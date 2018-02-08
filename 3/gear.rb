# 3.1 依存関係を理解する
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
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

# Wheelへの変更によってGearへの変更が強制される状況を書き出してみましょう。
# このコードに街は内容に見えますが、実際は複雑さが隠れています。GearのWheelに対する依存は、少なくとも4つあります。
### 個人的な考察
# Gearの中でWheelを生成するのは、密結合ではないのか
# rim,tireはGearは知らなくてもいい、rubyだったらObjectでもらえばいいのでは
# gear_inchesを呼び出すたびにWheelオブジェクトを生み出すのは、メモリの負担になる
# Gearの情報に関係ないものが引数、oopに反する

### 実際の答え
# 他のクラスの名前 : Gearは、Wheelという名前のクラスが存在することを予想している
# self以外のどこかに送ろうとするメッセージの名前 : Gearは、Wheelのインスタンスがdiameterに応答することを知っている
# メッセージが要求する引数 : Gearは、Wheel.newにrimとtireが必要なことを知っている
# それら引数の順番 : Gearは、wheel.newの最初の引数がrimで、2番目がtireであることを知っている