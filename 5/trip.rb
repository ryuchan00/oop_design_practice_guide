class Trip
  attr_reader :bicycles, :customers, :vehicle

  # この'mechanic'引数はどんなクラスのものでも良い。
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end

  # ...
end

# *この*クラスのインスタンスを渡すことになったとしても、動作する
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each{ |bicycle| prepare_bicycles(bicycle)}
  end

  def prepare_bicycle(bicycle)
    # ...
  end
end