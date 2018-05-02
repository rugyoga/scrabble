# frozen_string_literal: true

class WordsController < ApplicationController
  def index
    @words = params[:rack] ? Word.from_rack(params[:rack]) : []
  end
end
