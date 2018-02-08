# 複数のパラメーターを用いた初期化を隔離する

# Gearが外部インターフェースの一部の場合
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def gear_inches
      ratio * diameter
    end

    def diameter
      wheel.diameter
    end

    # ギア比率
    def ratio
      chainring / cog.to_f
    end
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

# 外部のインターフェースをラップし、自信を変更から守る
module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

# 引数を持つハッシュを渡すことでGearのインスタンスを作成できるようになった
puts GearWrapper.gear(
  :chainring => 52,
  :cog => 11,
  :wheel => Wheel.new(26, 1.5)).gear_inches
