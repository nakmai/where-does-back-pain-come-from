# README

■サービス名
あなたの腰痛どこから

■サービス概要
腰痛に対し、ツボ・ストレッチ方法・トレーニング方法を紹介を行い、ユーザーに対して腰痛のセルフケアを伝授するサービスです。

■ このサービスへの思い・作りたい理由
前職にて、かん虫の強い赤ちゃんからスポーツ強豪校の学生、最終受付時間ギリギリまで仕事を頑張られている会社員、ベットでの寝たきりや車椅子でしか移動できない高齢者など、ゆりかごから墓場までの年齢層の方達と関わらせていただきました。
その際、若年層・社会人の方から
「お金もそこまでかけることができないため、セルフでできるケアを知りたい。」
「日曜しか休みがない・どこも治療院が空いておらず、せめて自分でできる運動の方法やストレッチの方法を教えてほしい。」
「今度老人ホームに寝たきりの母に会いに行くため、使えそうなツボの場所を教えてほしい。」
など自身のセルフケアや関係者へのケアの方法を聞かれることが多くありました。

私の中でおすすめできるセルフケアアプリもなく、日々の業務で紙やPDFなどのデータにまとめる時間もなく、アプリやサイトでおすすめのツボとストレッチ・簡単な運動方法を教えてくれるものがあればと考えており、今回の作成予定に至りました。


■ ユーザー層について
ユーザー層
約10代〜50代の整体や病院へ行くほどかどうか悩んでいる腰痛症の方

理由
・スマートフォン操作に慣れている
・指示が間違えていなければ、正しい方法でケアが行える
・痛みや痺れが引かなければ早期の病院受診に繋げ、病気の早期発見・正しいケアの方法を知ることができる
（極まれに疲れによる背中の痛みだと思っていたら、実は命に関わる病気だったなどもある 


■サービスの利用イメージ
基本チェック項目で質問していく
・年齢・性別・病歴などをチェックしていく
・腰痛に対しての質問をyes,no形式で答えていく
・最終どこが原因で痛みを起こしている可能性があるかを提示し、ツボ・ストレッチ・トレーニング方法を各２種類ほど何秒・何回・何セット行うかを提示する

・ユーザー登録を行うと、質問項目を入力することなく、前回とは別のツボ・ストレッチ・トレーニング方法を各２種類ほど何秒・何回・何セット行うかを提示する


■ ユーザーの獲得について
x(旧twitter)やtimesなどSNSで発信
知り合いの鍼灸師・柔道整復師などの施術者に宣伝


■ サービスの差別化ポイント・推しポイント
競合：リハサク
差別化ポイント
・リハサクは治療院・病院と必ず連携が必要なため、登録はできても利用は限定される
・当サービスはユーザー登録せずに利用可能である
・ユーザー登録することで、同じ内容の腰痛に対し、別日にも同じケアが行える
・逆に、正確性がないため効果を感じない・日が経つにつれて徐々に悪化するなど、腰痛の状態悪化があれば病院などに通院を促し、早期に受診案内・治療をすることで正しいケアの方法を知ることができる、早期治療にもつながり仕事などへのパフォーマンスアップにも繋がる


■ 機能候補
MVP
・年齢・性別・病歴・悩んでいる事柄の項目を選択、入力
    -数値入力
    -ラジオボタン
    -チェックボックス
・セルフケア開始時の痛みを可視化
    -スライダーで表現
・ユーザー登録機能
・ログイン機能
    -メールアドレスでログイン
    -次回以降も自動でログイン
    -パスワードの再設定
・ログイン後は診断内容の記憶
・ケアをサボってしまう人向け
    -googleカレンダー(外部アプリ)にてケアを行うように通知
・ユーザーが実際にケアを行い、個別で鍛えたい筋肉・ストレッチがある
    -筋肉名のタグ登録


本リリース
 ・ログイン機能
    -googlreアカウントでログイン
    -Twitterアカウントでログイン
・ユーザー登録機能
    -登録後１週間後に効果の実感を確認し、効果を感じなければ病院へ行くようアプリ内にて通知を行う
・ケア内容のシャッフル機能
・トレーニング・ストレッチ時間のタイマー機能
・アカウント1つに対し、三人まで診断内容を記録


■ 機能の実装方針予定
Ruby 3.2.2 
Bootstrap
Rails 7.0.8.1 
PostgreSQL 
Docker / docker-compose
GitHub
HTML5 / CSS3　/ JavaScript
Devise
OmniAuth
Heroku
Google Calendar API

画面遷移図
Figma：https://www.figma.com/design/SiYqMI2oVfb0wILmlhX03J/%E3%81%82%E3%81%AA%E3%81%9F%E3%81%AE%E8%85%B0%E7%97%9B%E3%81%A9%E3%81%93%E3%81%8B%E3%82%89%EF%BC%9F?node-id=0-1&t=vpkvjyVycpMbZgLD-1
