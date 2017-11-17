# frozen_string_literal: true

class TestJob < ApplicationJob
  queue_as :basic

  def related_objects
    arguments.first&.fetch(:related, nil)
  end

  def perform(**params)
    if params[:error]
      log :error, raw: "raw test message"
      self.result = :error
    end

    if params[:raise]
      a = 1 / 0
    end

    log :user, key: "test.user_message.#{result}", params: { user_id: 1, number: 12 }
  end
end
