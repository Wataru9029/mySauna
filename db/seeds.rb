50.times do |n|
  User.create!(
    name: "サウナー♯#{n}",
    email: "email♯#{n}@gmail.com",
    password: 'password',
    image: File.open('./app/assets/images/saunner.jpeg')
  )
end

User.create!(
  name: '管理ユーザー',
  email: 'admin@gmail.com',
  admin: true,
  password: ENV['ADMIN_PASSWORD'],
  introduction: '管理ユーザーです。',
  image: File.open('./app/assets/images/admin.jpeg')
)

Post.create!(
  title: 'スカイスパYOKOHAMA',
  address: '神奈川県横浜市西区高島２丁目１９−１２',
  description: 'サ室は静かで、水風呂と外気浴との導線が完璧。整いイスが多いのも最高です。',
  site_url: 'https://www.skyspa.co.jp',
  rate: 5,
  infection_control_rate: 4,
  user_id: 50,
  image: File.open('./app/assets/images/skyspa.jpeg')
)

Post.create!(
  title: 'サウナ&カプセルホテル北欧',
  address: '東京都台東区上野７丁目２−１６',
  description: 'ドラマ「サ道」のロケ地として有名です。',
  site_url: 'https://www.saunahokuou.com',
  rate: 5,
  infection_control_rate: 4,
  user_id: 49,
  image: File.open('./app/assets/images/hokuou.jpeg')
)

Post.create!(
  title: '綱島源泉湯けむりの庄',
  address: '神奈川県横浜市港北区樽町３丁目７−６１',
  description: 'セルフロウリュと塩サウナ、強いて言うなら外気浴が若干遠くて残念。',
  site_url: 'https://www.yukemurinosato.com/tsunashima',
  rate: 4,
  infection_control_rate: 4,
  user_id: 48,
  image: File.open('./app/assets/images/yukemuri.jpeg')
)

Post.create!(
  title: 'RAKU SPA 鶴見',
  address: '神奈川県横浜市鶴見区元宮２丁目１−３９',
  description: '導線が素晴らしくて、デッキチェアが3つあります。炭酸水水風呂は人を選ぶかなと。',
  site_url: 'https://rakuspa.com',
  rate: 4,
  infection_control_rate: 3,
  user_id: 47,
  image: File.open('./app/assets/images/rakuspa.jpeg')
)

Post.create!(
  title: '橘湯',
  address: '神奈川県川崎市中原区苅宿３６−３２',
  description: 'サウナマットがなくて、サ室に行くと必ず常連客が話し込んでいました。ただサウナ付きで500円とコスパ良し。',
  site_url: 'https://spa-tokyo.net/z-k-k-y-sp/index.html',
  rate: 2,
  infection_control_rate: 1,
  user_id: 46,
  image: File.open('./app/assets/images/tachibanayu.jpeg')
)

Post.create!(
  title: 'ファンタジーサウナ＆スパおふろの国',
  address: '神奈川県横浜市鶴見区下末吉２丁目２５−２３',
  description: 'アウフグースが頻繁にあって、露天風呂前のデッキチェアが最高。',
  site_url: 'http://ofuronokuni.co.jp/',
  rate: 5,
  infection_control_rate: 3,
  user_id: 45,
  image: File.open('./app/assets/images/ofuronokuni.jpeg')
)

Post.create!(
  title: '旭湯',
  address: '横浜市港北区日吉2-15-31',
  description: '銭湯サウナの中では最高の導線。サ室も静かです。',
  site_url: 'https://k-o-i.jp/koten/asahiyu-1',
  rate: 3,
  infection_control_rate: 2,
  user_id: 44,
  image: File.open('./app/assets/images/asahiyu.jpeg')
)

Post.create!(
  title: 'コナミスポーツクラブ 武蔵小杉',
  address: '神奈川県川崎市中原区新丸子東3-1100-14',
  description: 'ジムサウナ。若干汗臭いけど、週5,6通うならコスパ良いです。水風呂が20度近くなのが少し残念。',
  site_url: 'https://information.konamisportsclub.jp/ksc/004070',
  rate: 3,
  infection_control_rate: 3,
  user_id: 43,
  image: File.open('./app/assets/images/konami_musashikosugi.jpeg')
)

Post.create!(
  title: '縄文天然温泉 志楽の湯',
  address: '神奈川県 川崎市幸区 塚越４丁目314-1',
  description: 'シンプルなドライサウナですが、縄文時代にタイムスリップしたような景観と落ち着いた雰囲気が素晴らしいです。水風呂は若干狭い。',
  site_url: 'http://www.shiraku.jp',
  rate: 4,
  infection_control_rate: 3,
  user_id: 42,
  image: File.open('./app/assets/images/shirakunoyu.jpeg')
)

Post.create!(
  title: '今井湯',
  address: '神奈川県川崎市中原区今井南町34-25',
  description: '毎日朝7時から入れるのが嬉しいです。バイブラ付き水風呂も気持ちいいですが、整いイスは1つだけ。',
  site_url: 'https://www.imaiyu.com',
  rate: 4,
  infection_control_rate: 3,
  user_id: 41,
  image: File.open('./app/assets/images/imaiyu.jpeg')
)
