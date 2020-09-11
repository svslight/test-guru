class BadgeService
    def initialize(test_passage)
      @test_passage = test_passage
      @user = test_passage.user
    end
  
    def get_badges      
      Badge.all.map { |badge| send("#{badge.rule_type}_award", badge) }.compact
    end
  
    private

    def category_award(badge)
      badge if all_in_category?(badge.rule_value) && badge.rule_value == @test_passage.test.category.title
    end
  
    def attempt_award(badge)
      badge if first_attempt?(badge.rule_value)
    end
  
    def level_award(badge)
      badge if all_in_level?(badge.rule_value) && badge.rule_value.to_i == @test_passage.test.level
    end
  
    def all_in_category?(category)
      Test.with_questions.by_category(category).count == @user.tests.where('test_passages.passed = ?', true).by_category(category).count
    end
  
    def first_attempt?(attempts)
      @user.tests.where(id: @test_passage.test_id).count == attempts.to_i
    end
  
    def all_in_level?(level)
      Test.with_questions.by_level(level.to_i).count == @user.tests.where('test_passages.passed = ?', true).by_level(level.to_i).count
    end
  end
  