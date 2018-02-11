# 問題を悪化させる
# 旅行の準備はさらに複雑になった
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(prepares)
    preparers.each { |preparer|
      case preparer
      when Mechaic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        prepare.buy_food(customers)
      when Driver
        preparer.gas_up(cehicle)
        preparer.fill_water_tank(cehicle)
      end
    }
  end
end

class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each { |bicycle| prepare_bicycle(bicycle) }
  end

  def prepare_bicycle(bicycle)
    # ...
  end
end

# TripCoordinator と Driver を追加した
class TripCoordinator
  def buy_food(customers)
    # ...
  end
end

class Driver
  def gas_up(vehicle)
    # ...
  end

  def fill_water_tank(vehicle)
    # ...
  end
end