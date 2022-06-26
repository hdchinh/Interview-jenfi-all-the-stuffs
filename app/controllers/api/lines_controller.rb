module Api
  class LinesController < Api::BaseController
    def index
      @lines = Line.all
    end

    def active
      @lines = Line.activated
    end
  end
end
