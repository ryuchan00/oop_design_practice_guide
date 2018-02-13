# 6.5 スーパークラスとサブクラス間の結合度を管理する
# フックメッセージを使ってサプクラスを疎結合にする

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args=[])
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    {tire_size: tire_size, chain: chain}.merge(local_spares)
  end

  def default_tire_size
    raise NotlmplementedError
  end

  # subclasses may override
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
    # 毎回superでsuperクラスのinitializeを呼び出していたら、呼び出し漏れで想定しない挙動になり、検知にもコストがかかるので、
    # post_initializeという種類の違うinitializeを作成する
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def local_spares
    {rear_shock: rear_chock}
  end

  def default_tire_size
    '2.1'
  end
end

# さらに新しいサブクラス RecumbentBikeを定義する。
class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    {flag: flag}
  end

  def default_chain
    "9-speed"
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new(flag: 'tall and orange')
p bent.spares