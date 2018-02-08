# 3.2 疎結合なコードを書く
# インスタンス変数の作成を分離する
# WheelをGearに注入するような変更はできないときはどうすれば良いでしょうか

class Gear
  attr_reader :chainring, :cog, :rim, :tire

  # 依存が避けられないのなら、initializeでオブジェクトを生成する
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
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

puts Gear.new(52, 11, 26, 1.5).ratio

# Wheelの作成を隔離し、、独自に明示的に定義したwheelメソッド内で行うようにしています。

class Gear2
  attr_reader :chainring, :cog, :rim, :tire

  # 依存が避けられないのなら、initializeでオブジェクトを生成する
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire= tire
  end

  def gear_inches
    ratio * diameter
  end

  # こうすることで外部的な依存を取り除き、メソッド内でカプセル化する
  def diameter
    wheel.diameter
  end

  # Wheelの作成をするメソッド
  # 必要になるまで、Wheelオブジェクトをギリギリまで作らない方法
  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end

  # ギア比率
  def ratio
    chainring / cog.to_f
  end
end

puts Gear2.new(52, 11, 26, 1.5).ratio

# 初期化の際に引数にハッシュを使う

class Gear3
  attr_reader :chainring, :cog, :wheel

  # 引数をただ一つ、argsのみを取るようにする。これなら引数の順番に依存しない設計となる。
  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end

  def gear_inches
    ratio * diameter
  end

  # こうすることで外部的な依存を取り除き、メソッド内でカプセル化する
  def diameter
    wheel.diameter
  end

  # Wheelの作成をするメソッド
  # 必要になるまで、Wheelオブジェクトをギリギリまで作らない方法
  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end

  # ギア比率
  def ratio
    chainring / cog.to_f
  end
end

puts Gear3.new(
  :chainring => 52,
  :cog => 11,
  :wheel => Wheel.new(26, 1.5)
).gear_inches
