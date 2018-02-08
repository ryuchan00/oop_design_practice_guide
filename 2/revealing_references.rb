class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  # この メソッド が 責任 を 2 つ 持っ て いる こと は 明白 です。 wheels を 繰り返し 処理 し、 それぞれ の wheel の 直径 を 計算 し て い ます。
  # def diameters
  #   wheels.collect {|wheel|
  #     wheel.rim + (wheel.tire * 2)}
  # end

  # これを2つのメソッドに分けて、単一責任にさせる。

  # 最初に = 配列を繰り返し処理する
  # 単数形のdiameterメソッドを他の場所からでも呼べるようになったという事実は、だいしょうのない嬉しい副作用です。
  def diameters
    wheels.collect {|wheel| diameter(wheel)}
  end

  # 次に - 「1つ」の車輪の直径を計算する
  def diameter(wheel)
    wheel.rm + (wheel.tire * 2)
  end

  # ...これで誰でもwheelにrim/tireを遅れる


  # Struct クラスに新しいサブクラスを作って、それを返します。
  #
  # サブクラスでは構造体のメンバに対するアクセスメソッドが定義されています。
  #
  # dog = Struct.new("Dog", :name, :age)
  # fred = dog.new("fred", 5)
  # fred.age = 6
  # printf "name:%s age:%d", fred.name, fred.age
  #=> "name:fred age:6" を出力します
  Wheel = Struct.new(:rim, :tire)

  def wheelify(data)
    data.collect {|cell|
      Wheel.new(cell[0], cell[1])}
  end
end

r = RevealingReferences.new([[1, 2], [3, 4]])
p r
#<RevealingReferences:0x007ff951819e10 @wheels=[#<struct RevealingReferences::Wheel rim=1, tire=2>, #<struct RevealingReferences::Wheel rim=3, tire=4>]>

