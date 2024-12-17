# プロジェクト名：Where Does Back Pain Come From
<img width="500" src="app/assets/images/top_page.png"><br>


# 目次
- [サービス概要](#サービス概要)
- [サービスURL](#サービスurl)
- [サービス開発の背景](#サービス開発の背景)
- [ユーザー層](#ユーザー層)
- [機能紹介](#機能紹介)
  - [ログイン機能](#ログイン機能)
  - [ユーザー登録](#ユーザー登録)
  - [ゲストユーザー](#ゲストユーザー)
  - [登録ユーザー](#登録ユーザー)
  - [質問事項](#質問事項)<br>
- [技術構成について](#技術構成について)
  - [使用技術](#使用技術)
  - [ER図](#er図)
  - [画面遷移図](#画面遷移図)<br>

# サービス概要
腰痛に対し、ストレッチ方法・トレーニング方法を紹介を行い、ユーザーに対して腰痛のセルフケアを伝授するサービスです。
<br>

# サービスURL
**https://where-does-back-pain-come-from.com**
<br>

# サービス開発の背景
前職・前々職にて、かん虫の強い赤ちゃんからスポーツ強豪校の学生、最終受付時間ギリギリまで仕事を頑張られている会社員、ベットでの寝たきりや車椅子でしか移動できない高齢者など、ゆりかごから墓場までの年齢層の方達と関わらせていただきました。
その際、若年層・社会人の方から
- 「お金もそこまでかけることができないため、セルフでできるケアを知りたい。」
- 「日曜しか休みがない・どこも治療院が空いておらず、せめて自分でできる運動の方法やストレッチの方法を教えてほしい。」
- 「今度老人ホームに寝たきりの母に会いに行くため、使えそうなツボの場所やストレッチの方法を教えてほしい。」
など自身のセルフケアや関係者へのケアの方法を聞かれることが多くありました。

私の自身の中でおすすめできるセルフケアアプリもなく、日々の業務で紙やPDFなどのデータにまとめる時間もなく、アプリやサイトでおすすめのストレッチ・簡単な運動方法を教えてくれるものがあればと考えており、今回の作成予定に至りました。
<br>


# ユーザー層
**対象ユーザー**

約10代〜50代の整体や病院へ行くほどかどうか悩んでいる腰痛症の方

**理由**

    - スマートフォン操作に慣れている
    - 指示が間違えていなければ、正しい方法でケアが行える
    - 痛みや痺れが引かなければ早期の病院受診に繋げ、病気の早期発見・正しいケアの方法を知ることができる
    　（極まれに疲れによる背中の痛みだと思っていたら、実は命に関わる病気だったなどもある)


# 機能紹介

<br>

## ログイン機能

| ユーザー登録 / ログイン |
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/3484e8b75b8cadeb58741ff7cdc7b435.gif)](https://gyazo.com/3484e8b75b8cadeb58741ff7cdc7b435)|
| <p align="left">『生年月日』『性別』『メールアドレス』『パスワード』『確認用パスワード』を入力してユーザー登録を行います。ユーザー登録後は、自動的にログイン処理が行われるようになっており、そのまま直ぐにサービスを利用する事が出来ます。<br>また、Googleアカウントを用いてGoogleログインを行う事も可能です。</p> |
<br>

## ゲストユーザー

| 生年月日・性別・質問事項の入力が毎回必要|
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/5dc0049191a3c452aec4bedffebc558b.gif)](https://gyazo.com/5dc0049191a3c452aec4bedffebc558b)|
| <p align="left">セルフケアページに辿り着くまでに、生年月日・性別・質問事項の入力が毎回必要となります。</p> |
<br>

| セルフケアの紹介は基本１種類ずつ|
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/d7e2c6335f0b62ca4c7a2f70dd2d0cf3.gif)](https://gyazo.com/d7e2c6335f0b62ca4c7a2f70dd2d0cf3)|
| <p align="left">セルフケア紹介は基本１種類のみに絞り、登録ユーザーと差別化を図っております。</p> |
<br>

## 登録ユーザー
| セルフケアを0:00・12:00にシャッフルで紹介|
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/4e496f0f8a9a657268c3fff7d8ded08a.gif)](https://gyazo.com/4e496f0f8a9a657268c3fff7d8ded08a)|
| <p align="left">セルフケア紹介をシャッフルで行い、セルフケアへの飽き・特定の筋肉のみのアプローチ防止に役立てております。<br>また、アクセスするたびセルフケア内容が異なると、ケアの効果低下にもつながるため特定の時間にシャッフルされるようにしております。</p> |
<br>

| マイページ登録 |
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/8f17b237b42626e5be0ba5d93eebea70.gif)](https://gyazo.com/8f17b237b42626e5be0ba5d93eebea70)|
| <p align="left">セルフケアページを登録しておくことで、毎回質問事項にチェックを行わすセルフケアを行うことができます。</p> |
<br>

## 質問事項


| 質問事項をチェック /  身体状態に問題がない場合 |
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/934dd4a603c4c1c7702dd004dfad872b.gif)](https://gyazo.com/934dd4a603c4c1c7702dd004dfad872b)|
| <p align="left">質問事項をチェックしていきます。<br>身体状態に、特に問題がなければセルフケアの画面に移行します。</p> |
<br>

| 質問事項をチェック /  身体状態に問題がある場合 |
| :---: | 
|[![Image from Gyazo](https://i.gyazo.com/ee94b88abdd7b483df66994e8ce19782.gif)](https://gyazo.com/ee94b88abdd7b483df66994e8ce19782)|
| <p align="left">身体状態に問題があった際、医療機関への診察を促す警告文が出現します。<br>すでに医療機関へ相談されている方も利用できるように設計しております。</p> |
<br>

# 技術構成について

## 使用技術

| カテゴリー | 技術 |
:----|:----
| フロントエンド | HTML, CSS, JavaScript, BootstrapCSS |
| バックエンド | Rails 7.0.8.4 (Ruby 3.1.4 )  |
| データベース | MySQL8.0 |
| 開発環境 | Docker |
| アプリケーションサーバー | Heroku |
| API | Google People API |


# 画面遷移図
Figma:https://www.figma.com/design/SiYqMI2oVfb0wILmlhX03J/%E3%81%82%E3%81%AA%E3%81%9F%E3%81%AE%E8%85%B0%E7%97%9B%E3%81%A9%E3%81%93%E3%81%8B%E3%82%89%EF%BC%9F?node-id=0-1&t=vpkvjyVycpMbZgLD-1

# ER図
[![Image from Gyazo](https://i.gyazo.com/efc3727c2640c09e6b3a13b675584e0c.png)](https://gyazo.com/efc3727c2640c09e6b3a13b675584e0c)
