# 6.5 スーパークラスとサブクラス間の結合度を管理する
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args=[])
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def spares
    super.merge([ tape_color: tape_color])
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge([rear_shock: rear_shock])
  end

  def default_tire_size
    '2.1'
  end
end