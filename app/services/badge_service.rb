class BadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def find_badges
    @new_badge_ids = []
    BadgeRule.all.each do |badge_rule|
      rule = badge_rule.rule
      @level = rule == 'level' ? @test_passage.test.level : nil

      @new_badge = new_badge1(rule, @level)
      @count_badges = @new_badge.count_badges

      @new_badge = send("#{badge_rule.rule}_award", @new_badge, rule, @level)
      @new_badge_ids << @new_badge.badge_id if @new_badge.present? && @count_badges < @new_badge.count_badges
    end 
    @new_badge_ids
  end

  private

    def test_type_count
      {
        attempt: -> {1},
        level: -> { Test.with_questions.where(level: @level).length },
        category: -> { Test.with_questions.get_category_tests('Backend').length }
      } 
    end

    # ищем запись и берем значение счетчика
    def new_badge1(rule, level=nil)
      badge_id = Badge.find_badge_id(rule, level)

      if BadgesUser.exists?(user_id: @user.id, badge_id: badge_id)
        @new_badge = BadgesUser.where(user_id: @user.id, badge_id: badge_id).take
      else
        @new_badge = BadgesUser.new(user_id: @user.id, badge_id: badge_id, count_badges: 0)
      end
    end

    def update_granted(counts, all_tests, new_badge)
      @count_badges = new_badge.count_badges
      if !counts.empty? && counts.count == all_tests
        new_badge.save if @count_badges == 0
        new_badge.update_attributes(count_badges: counts.min)
      end
      new_badge
    end

    def grant_badge(counts, new_badge, rule)
      @all_tests = test_type_count[rule.to_sym].call
      new_badge = update_granted(counts, @all_tests, new_badge)
    end  

    def category_award(new_badge, rule, level=nil)
      @user_backend_ids = test_backend_ids_for_user
      @ids = @user_backend_ids.uniq
      @counts = []
      @ids.each { |id| @counts << @user_backend_ids.count(id) }
      grant_badge(@counts, new_badge, rule)
    end

    def attempt_award(new_badge, rule, level=nil)
      @test = Test.find(@test_passage.test_id)

      @is_success1 = fault_test? ? !success_test? : false    
      @is_success2 = count_success_tests > 1

      @counts = []
      if !@is_success1 && !@is_success2     
        @amount_badges = badge_for?(rule) ? count_badges_for(rule) : 0
        @counts = [@amount_badges += 1]
      end
      grant_badge(@counts, new_badge, rule)
    end

    def level_award(new_badge, rule, level)
      @user_tests_ids = @user.test_passages.pluck(:id, :test_id) 
      @ids = @user_tests_ids.collect{ |id, test_id| test_id if TestPassage.find(id).success? }.compact
      @counts = []
      Test.where(id: @ids, level: level).with_questions.each { |test| @counts << test.test_passages.length }
      grant_badge(@counts, new_badge, rule)
    end

    def fault_test?
      TestPassage.fault_test(@user, @test).exists?
    end

    def success_test?
      TestPassage.success_test(@user, @test).success?
    end

    def count_success_tests
      TestPassage.count_success_tests(@user, @test).length
    end

    def badge_for?(rule)
      BadgesUser.badge_for(@user, rule).exists?
    end

    def count_badges_for(rule)
      BadgesUser.count_badges_for(@user, rule).count_badges
    end

    def test_backend_ids_for_user
      Test.test_backend_ids_for(@user).pluck(:id)
    end

  end
