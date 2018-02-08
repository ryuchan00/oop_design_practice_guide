# 3.2 疎結合なコードを書く
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    # オブジェクトの種類は関係ないよ、diameterメソッドか呼びたせればよい
    # これがダックタイピング
    ratio * wheel.diameter
  end

  # ギア比率
  def ratio
    chainring / cog.to_f
  end
end

# 車輪に間するクラス
class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  # 直径を求める
  def diameter
    rim + (tire * 2)
  end

  # 円周を求める
  def circumference
    diameter * Math::PI
  end
end

wheel = Wheel.new(26, 1.5)
puts Gear.new(52, 11, wheel).ratio
