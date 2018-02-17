# 8.2 Partsオブジェクトをコンポーズする
class Bicycle
  attr_reader :size, :parts

  def initialize(args=[])
    @size = args[:size]
    @parts = args[:parts]
  end

  def spears
    parts.spares
  end
end

# Parts階層構造を作る
class Parts
  attr_reader :chain, :tire_size

  def initialize(args=[])
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    {tire_size: tire_size,
     chain: chain}.merge(local_spares)
  end
end

# 新たに導入されたPartクラス
class Part
  attr_reader :name, :description, :need_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @nedds_spare = args[:nedds_spare]
  end
end