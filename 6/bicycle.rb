# 継承を使うべき箇所を識別する
# 複数の型を埋め込む
# 既存のBicycleクラスを変更し、ロードバイク、マウンテンバイクの両方でsparesが動作するということをしています。
class Bicycle
  attr_reader :style, :size, :tape_color, :front_shock, :rear_shock

  def initialize(args)
    @style = args[:style]
    @size = args[:size]
    @tape_color = args[:type_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  # 'style'の確認は、危険な道へ進む一歩
  def spares
    if style == :road
      {
        chain: '10-speed',
        tire_size: '23', # milimeters
        tape_color: tape_color
      }
    else
      # このelseは、ロードバイク以外を処理するので、マウンテンバイクとは限らない
      # つまり、想定している動きではなくなる可能性がある
      {
        chain: '10-speed',
        tire_size: '2.1', # inches
        tape_color: rear_shock
      }
    end
  end
end

bike = Bicycle.new(
  style: :mountain,
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox'
)

p bike.size
p bike.spares