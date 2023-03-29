# ポートフォリオ
<img src="./app/assets/images/ogp.png" width="600">

## サービス名：　[草刈山雄](https://www.kusakari-yamao.com)

## ■　サービス概要
　プログラミング学習者が学習のモチベーションを維持するために、
  GitHubで生やした草を刈り取って、積み上げた高さを日本に山の標高と比較する
  学習モチベートサービスです。


## ■　なぜこのサービスを作りたいのか？
　エンジニアになりたい、技術力を向上させたいと日々学習していく中でどうしてもモチベーションが保てないときがあると思います。
  今までの学習のなかでコードを書いて生やした草を現実にあるものと比較することで更なる学習意欲を掻き立てることができるのではないかと考えました。

## メインのターゲットユーザー
　プログラミング初学者
  プログラミングをこれから始めようと思っている人
  現役エンジニア

## ユーザーが抱える課題
　Webエンジニアになるために学習に励むもののモチベーションの維持が難しい。

## ■　解決方法
　GitHubのcontributionsの数を増やし草を生やすだけだなく、生やした草を転用することでさらなる学習意欲の向上を図る。

## ■　機能紹介
| トップページ | 新規草刈|
|----------|-------|
|[![Image from Gyazo](https://i.gyazo.com/1ad2f3f5824a3f4e62f1a3979cb6df21.jpg)](https://gyazo.com/1ad2f3f5824a3f4e62f1a3979cb6df21)|[![Image from Gyazo](https://i.gyazo.com/8ecfb9803d1deecaf5581caca48f665c.png)](https://gyazo.com/8ecfb9803d1deecaf5581caca48f665c)|
||・GitHubのアカウント名を入力し診断を開始|

| 結果画面 | マイページ |
|---------|----------|
|[![Image from Gyazo](https://i.gyazo.com/1baaf868c54bbc760420e69ac606ce15.jpg)](https://gyazo.com/1baaf868c54bbc760420e69ac606ce15)|[![Image from Gyazo](https://i.gyazo.com/c124b7d3bd231a5e05c385626960e5dd.png)](https://gyazo.com/c124b7d3bd231a5e05c385626960e5dd)|
|・草刈結果（診断結果）を地図とともに表示|・今までの利用回数と表示<br>・直近の山名を表示|

| 山一覧ページ |マイマップ|
|------------|--------|
|[![Image from Gyazo](https://i.gyazo.com/7023006678e8e814cdfdf047664ce035.jpg)](https://gyazo.com/7023006678e8e814cdfdf047664ce035)|[![Image from Gyazo](https://i.gyazo.com/01808b32c502348325d0a87710a86b8c.jpg)](https://gyazo.com/01808b32c502348325d0a87710a86b8c)|
|・利用したユーザーの結果を地図でまとめて表示|・自分の過去の山々を地図上に表示|

| ランキング | 使い方 |
|----------|--|
|[![Image from Gyazo](https://i.gyazo.com/dcc0e8f049d67542e9753853028c0431.png)](https://gyazo.com/dcc0e8f049d67542e9753853028c0431)|[![Image from Gyazo](https://i.gyazo.com/6ea15f4e60d66d9f8b19674331955bd0.png)](https://gyazo.com/6ea15f4e60d66d9f8b19674331955bd0)|
|・登録ユーザー草数をランキングで表示||


### その他の機能
  - サポート画面の閲覧
    - 利用規約
    - プライバシーポリシー
  - twitter共有機能
  - 過去の山の推移表示

### 追加予定の機能
  - publicレポジトリー一覧の表示
  - フォローユーザーの山を地図表示
  - 登頂記念バッジ機能
  - 投稿共有機能（追加）
  - ユーザーフォロー機能

## 使用技術

#### バックエンド
- Ruby3.1.2
- Ruby on Rails 7.0.4

#### 主要ライブラリ
- OmniAuth
- MetaTags(SEO)
- graphql-client
- RSpec(テスト)
- RuboCop(リントチェック)
- Gon
- kaminari

#### フロントエンド
- HTML/SCSS/Javascript
- CSSフレームワーク
  - Tailwind css
  - daisyUI

#### インフラ
- Heroku
- PostgreSQL(データベース)

#### その他
- GitHub GraphQL API
- GoogleMapsAPI

#### ツール
- Googleアナリティクス
- Googleサーチコンソール

## 画面遷移図
https://www.figma.com/file/pbZEOPLIKdOmKMe3aiG9tU/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1&t=Df6UdHSyURYHaj0K-1

## ER図
[![Image from Gyazo](https://i.gyazo.com/e7051a272beca500e5634996ab066e9d.png)](https://gyazo.com/e7051a272beca500e5634996ab066e9d)
