module BadgesHelper
    BADGE_LEVELS = TestsHelper::TEST_LEVELS
  
    def badge_level(level)
      BADGE_LEVELS[level]
    end
  end
