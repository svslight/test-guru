class Badge < ApplicationRecord
  IMAGES = [
    ['Leader attempt', 'winner_attempt.png'],
    ['Leader category', 'winner_category.png'],
    ['Leader level - 0', 'winner_level.png'],
    ['Leader level - 1', 'winner_level1.png'],
    ['Leader level - 2', 'winner_level2.png'],
    ['Leader level - 3', 'winner_level3.png'],
  ].freeze

  belongs_to :badge_rule

  has_many :badges_users, dependent: :destroy
  has_many :users, through: :badges_users
  
  validates :title, presence: true, uniqueness: true  

  scope :winned_badges, ->(user) { find(user.badges_users.pluck(:badge_id)) }
  scope :find_badge_id, ->(rule, level) { where(badge_rule_id: BadgeRule.find_by(rule: rule).id, level: level).take.id }
  
  def self.user_badges(user)
    @user_badges = []    
    @badges = self.winned_badges(user)

    @badges.each do |badge|
      @user_badges << [badge, BadgesUser.count_badges(user, badge)]
    end
    @user_badges
  end

  @test_type_count = {
    attempt: -> {1},
    level: -> { Test.with_questions.where(level: @level).length },
    category: -> { Test.with_questions.get_category_tests('Backend').length } 
  }

  def self.granting(user, test_passage)

    @new_badge_ids = []

    BadgeRule.pluck(:rule).map do |rule|

      @level = rule == 'level' ? test_passage.test.level : nil
      @new_badge = new_badge(user, rule, @level)
      @count_badges = @new_badge.count_badges

      @count_tests = self.count_tests_rule1(user, rule, test_passage, @level)

      @all_tests = @test_type_count[rule.to_sym].call
      @new_badge = update_granted(@count_tests, @all_tests, @new_badge)

      @new_badge_ids << @new_badge.badge_id if @new_badge.present? && @count_badges < @new_badge.count_badges
      @new_badge = nil
    end
    @new_badge_ids
  end

  private

    # ищем запись и берем значение счетчика
    def self.new_badge(user, rule, level=nil)
      badge_id = Badge.find_badge_id(rule, level)

      if BadgesUser.exists?(user_id: user.id, badge_id: badge_id)
        @new_badge = BadgesUser.where(user_id: user.id, badge_id: badge_id).take
      else
        @new_badge = BadgesUser.new(user_id: user.id, badge_id: badge_id, count_badges: 0)
      end
    end

    # общее кол-во пройденных тестов соответствующего правила  
    def self.count_tests_rule1(user, rule, test_passage, level=nil)
      if rule == 'attempt'
        @test = Test.find(test_passage.test_id)

        if TestPassage.fault_test?(user, @test)
          @is_success1 = !TestPassage.success_test?(user, @test)
        else
          @is_success1 = false
        end

        @is_success2 = TestPassage.count_success_tests(user, @test) > 1

        @counts = []
        if !@is_success1 && !@is_success2
          if BadgesUser.badge_for(user, rule)
            @mount_badges = BadgesUser.count_badges_for(user, rule)
            @mount_badges += 1
          else
            @mount_badges = 1
          end
          @counts = [@mount_badges]
        end
      end

      if rule == 'level'
        @user_tests_ids = user.test_passages.pluck(:id, :test_id) 
        @ids = @user_tests_ids.collect{ |id, test_id| test_id if TestPassage.find(id).success? }.compact
        @counts = []
        Test.where(id: @ids, level: level).with_questions.each { |test| @counts << test.test_passages.length }
      end

      if rule == 'category'
        @user_backend_ids = Test.test_backend_ids_for(user)
        @ids = @user_backend_ids.uniq
        @counts = []
        @ids.each { |id| @counts << @user_backend_ids.count(id) }
      end
      @counts
    end

    def self.update_granted(counts, all_tests, new_badge)
      # [1,2,1] 
      @count_badges = new_badge.count_badges
      if !counts.empty? && counts.count == all_tests
        new_badge.save if @count_badges == 0
        new_badge.update_attribute(:count_badges, counts.min)
      end
      new_badge
    end  
end
