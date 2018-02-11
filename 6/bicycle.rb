# 継承を使うべき箇所を識別する
# 具象クラスから始める
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:type_color]
  end

  # 全ての自転車は、デフォルト値として、同じタイヤサイズとチェーンサイズをもつ
  def spares
    {
      chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end

  # 他にも多くのメソッドが...
end

bike = Bicycle.new(
  size: 'M',
  tape_color: 'red'
)

p bike.size # => M
p bike.spares