# ELM説明用コード
## はじめに
プロジェクトがRailsだからRailsでスケルトンにした。
でも深い意味は無い。


## 構成概要
ElmDummyはRJB実装が面倒だったから、それっぽいダミーをつくった。
さすがにJavaのダミークラスをつくるのはめんどくさすぎた。

なので、ElmCallerがとりあえずRJBで書くヤツ
Rails4のqueue apiは実はないっぽいのでこんな書き方にして損した気がする。

それはさておき、非同期実行はdelayed_jobを使った。

## セットアップ
```
bundle install --path vendor/bundle
bundle exec rails g delayed_job:active_record
bundle exec rake db:migrate
```

## 実行のしかた
まずは非同期ジョブ実行用のworkerを起動する
```
bundle exec rake jobs:work
```

で、あとはRails consoleで試してみる。
とりあえず通常の処理（同期処理）

```
elm = ElmCaller.new("PluginA", "data")
elm.run
elm.run
elm.run
```

とりあえず普通に処理されるはず。でもこれだとWebで同時接続があると同時に走って、ELM的に多分よろしくない。ついでに遅いはず。というわけで非同期処理。（のんぶろっきんぐ）

```
elm = ElmCaller.new("PluginA", "data")
elm.delay.run
elm.delay.run
elm.delay.run
```

これでworker側で動くはず。workerをシングルプロセスで上げていると、シリアル処理になるので、つまるところELMの多重実行される心配がない（はず）。加えて、ユーザには先に結果を戻せるので、多少混み合っててもなんとかなる。
