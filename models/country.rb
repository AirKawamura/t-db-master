# https://www.mext.go.jp/a_menu/koutou/ryugaku/05081801/004.pdf

class Country < ActiveHash::Base
  self.data = [
    {name: "アイスランド"},
    {name: "アイルランド"},
    {name: "アゼルバイジャン"},
    {name: "アフガニスタン"},
    {name: "アメリカ"},
    {name: "アラブ首長国連邦"},
    {name: "アルジェリア"},
    {name: "アルゼンチン"},
    {name: "アルバニア"},
    {name: "アルメニア"},
    {name: "アンティグア・バーブーダ"},
    {name: "アンドラ公国"},
    {name: "イエメン"},
    {name: "イギリス"},
    {name: "イスラエル"},
    {name: "イタリア"},
    {name: "イラク"},
    {name: "イラン"},
    {name: "インド"},
    {name: "インドネシア"},
    {name: "ウガンダ"},
    {name: "ウクライナ"},
    {name: "ウズベキスタン"},
    {name: "ウルグアイ"},
    {name: "エクアドル"},
    {name: "エジプト"},
    {name: "エストニア"},
    {name: "エチオピア"},
    {name: "エリトリア"},
    {name: "エルサルバドル"},
    {name: "オマーン"},
    {name: "オランダ"},
    {name: "オーストラリア"},
    {name: "オーストリア"},
    {name: "カザフスタン"},
    {name: "カタール"},
    {name: "カナダ"},
    {name: "カメルーン"},
    {name: "韓国"},
    {name: "カンボジア"},
    {name: "ガイアナ"},
    {name: "ガボン"},
    {name: "ガンビア"},
    {name: "ガーナ"},
    {name: "キプロス"},
    {name: "キューバ"},
    {name: "キリバス"},
    {name: "キルギス"},
    {name: "ギニア"},
    {name: "ギニアビサウ"},
    {name: "ギリシャ"},
    {name: "クウェート"},
    {name: "クック諸島"},
    {name: "クロアチア"},
    {name: "グアテマラ"},
    {name: "グルジア"},
    {name: "グレナダ"},
    {name: "ケニア"},
    {name: "コスタリカ"},
    {name: "コモロ"},
    {name: "コロンビア"},
    {name: "コンゴ共和国"},
    {name: "コンゴ民主共和国"},
    {name: "コートジボワール"},
    {name: "サウジアラビア"},
    {name: "サモア独立国"},
    {name: "ザンビア"},
    {name: "シエラレオネ"},
    {name: "シリア"},
    {name: "シンガポール"},
    {name: "ジブチ"},
    {name: "ジャマイカ"},
    {name: "ジンバブエ"},
    {name: "スイス"},
    {name: "スウェーデン"},
    {name: "スペイン"},
    {name: "スリナム"},
    {name: "スリランカ"},
    {name: "スロバキア"},
    {name: "スロベニア"},
    {name: "スワジランド"},
    {name: "スーダン"},
    {name: "セネガル"},
    {name: "セルビア・モンテネグロ"},
    {name: "セントクリストファー・ネーヴィス"},
    {name: "セントビンセント"},
    {name: "セントルシア"},
    {name: "セーシェル"},
    {name: "ソマリア"},
    {name: "ソロモン諸島"},
    {name: "タイ"},
    {name: "台湾"},
    {name: "タジキスタン"},
    {name: "タンザニア"},
    {name: "チェコ"},
    {name: "チャド"},
    {name: "中国"},
    {name: "チュニジア"},
    {name: "チリ"},
    {name: "ツバル"},
    {name: "デンマーク"},
    {name: "トケラウ"},
    {name: "トリニダード・トバゴ"},
    {name: "トルクメニスタン"},
    {name: "トルコ"},
    {name: "トンガ"},
    {name: "トーゴ"},
    {name: "ドイツ"},
    {name: "ドミニカ共和国"},
    {name: "ドミニカ国"},
    {name: "ナイジェリア"},
    {name: "ナウル"},
    {name: "ナミビア"},
    {name: "ニウエ"},
    {name: "ニカラグア"},
    {name: "ニジェール"},
    {name: "日本"},
    {name: "ニューカレドニア"},
    {name: "ニュージーランド"},
    {name: "ネパール"},
    {name: "ノルウェー"},
    {name: "ハイチ"},
    {name: "ハンガリー"},
    {name: "バチカン"},
    {name: "バヌアツ"},
    {name: "バハマ"},
    {name: "バルバドス"},
    {name: "バングラデシュ"},
    {name: "バーレーン"},
    {name: "パキスタン"},
    {name: "パナマ"},
    {name: "パプアニューギニア"},
    {name: "パラオ"},
    {name: "パラグアイ"},
    {name: "パレスチナ"},
    {name: "東ティモール"},
    {name: "フィジー"},
    {name: "フィリピン"},
    {name: "フィンランド"},
    {name: "フランス"},
    {name: "ブラジル"},
    {name: "ブルガリア"},
    {name: "ブルネイ"},
    {name: "ブルンジ"},
    {name: "ブータン"},
    {name: "ベトナム"},
    {name: "ベナン"},
    {name: "ベネズエラ"},
    {name: "ベラルーシ"},
    {name: "ベリーズ"},
    {name: "ベルギー"},
    {name: "ペルー"},
    {name: "香港"},
    {name: "ホンジュラス"},
    {name: "ボスニア・ヘルツェゴビナ"},
    {name: "ボツワナ"},
    {name: "ボリビア"},
    {name: "ポルトガル"},
    {name: "ポーランド"},
    {name: "マカオ"},
    {name: "マケドニア旧ユーゴスラビア共和国"},
    {name: "マダガスカル"},
    {name: "マラウイ"},
    {name: "マリ"},
    {name: "マルタ"},
    {name: "マレーシア"},
    {name: "マーシャル"},
    {name: "ミクロネシア"},
    {name: "南アフリカ"},
    {name: "ミャンマー"},
    {name: "メキシコ"},
    {name: "モザンビーク"},
    {name: "モルディブ"},
    {name: "モルドバ"},
    {name: "モロッコ"},
    {name: "モンゴル"},
    {name: "モーリシャス"},
    {name: "モーリタニア"},
    {name: "ヨルダン"},
    {name: "ラオス"},
    {name: "ラトビア"},
    {name: "リトアニア"},
    {name: "リビア"},
    {name: "リベリア"},
    {name: "ルクセンブルク"},
    {name: "ルワンダ"},
    {name: "ルーマニア"},
    {name: "レソト"},
    {name: "レバノン"},
    {name: "ロシア"},
    {name: "中央アフリカ"},
    {name: "その他"},
  ]
end
