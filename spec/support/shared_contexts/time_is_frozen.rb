# frozen_string_literal: true

shared_context :time_is_frozen do
  let(:current_time) { Time.new(2019, 6, 24, 14, 0_0, 0_0, "-05:00").in_time_zone("Central Time (US & Canada)") }

  before { Timecop.freeze(current_time) }

  after { Timecop.return }
end
