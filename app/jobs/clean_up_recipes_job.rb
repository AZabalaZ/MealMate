class CleanUpRecipesJob < ApplicationJob
  queue_as :default

  def perform
    Recipe.where('created_at <= ?', 24.hours.ago).destroy_all
  end
end
