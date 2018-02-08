class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect {|wheel|
      wheel.rim + (wheel.tire * 2)}
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
