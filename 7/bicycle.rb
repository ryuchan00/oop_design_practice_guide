class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size

  # Scheduleを注入し、初期値を設計する
  def initialize(args=[])
    @schedule = args[:schedule] || Schedule.new

    # ...
  end

  # 与えられた期間(現在はBicycleに固有)の間、bicycleが利用可能であればtrueを返す
  def schedulable?(start_data, end_date)
    !scheduled?(start_data - lead_days, end_date)
  end

  # scheduleの答えを返す
  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # bicycleがスケジュール可能となるまでの準備日数を返す
  def lead_days
    1
  end

  # ...
end

require 'date'
starting = Date.parse("2015/09/04")
ending = Date.parse("2015/09/10")

b = Bicycle.new
b.schedulable?(starting, ending)
