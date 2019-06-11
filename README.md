# medley_generater
semi_auto_medley_generater

mp3ファイルからサビを抜き出し、結合してサビメドレーを自動でつくる。

事前準備
以下の命名規則に沿った、音楽ファイルを準備しておく。

[サビ開始秒(2桁)][曲名].mp3

例 : 63Rising Hope.mp3

ディレクトリ構成は以下の通り

Folder
  |- medley_generater.sh
  |- 63Rising Hope.mp3
  |- 43STARTING NOW!.mp3
  |- ・・・
  
  
結合ファイルは ./after_cut/output.mp3


