# robosys2026


# hisortコマンド(課題1)
![test](https://github.com/Renwa3/robosys2026/actions/workflows/test.yml/badge.svg)
- コマンド履歴形式のテキスト（標準入力またはシェルの `history`）から、コマンドの実行回数を集計して上位15件を表示するコマンドです。プレフィックス（先頭一致の文字列）を指定して絞り込むこともできます。

## 特徴

- パイプやリダイレクトで渡した履歴データを集計し、標準出力へ結果を返します。
- 標準入力がない場合は `history` から履歴を取得して集計します。
- 引数を渡すと、その文字列で始まるコマンドだけを対象に集計します。
- 1行1文字列のテキストを集計することも可能です。

## 使い方

### 1. コマンドとして直接実行する（標準入力・パイプ向け）

実行権限を付けたうえで、標準入力から履歴形式のデータを渡して使います。
- 入力例(sample_history.txtというhistory形式のテキストファイルを入力)
```
chmod +x hisort
cat sample_history.txt | ./hisort
```
- 出力例
```
 12 git status
 10 git push
 5 ls -la
 5 bash ./test_hisort.bash
 2 git add .
 1 source ./hisort
 1 hisort "git p"
...
```
1行1文字列のテキストファイルを読み込んだり、先頭の文字列で絞ることも可能です。
- 入力例(sample_text.txtという一行一文字列のテキストファイルを入力)
```
cat sample_text.txt | ./hisort ap
```
- 出力例
```
 6 apple
 4 apricot
```


### 2. 現在のシェルに読み込んで使う
`history`から直近の200件を読み込みます。
- 入力例
```
source ./hisort
hisort
hisort git p
```
- 出力例
```
 4 git push
 2 ls -la
 1 git status 
```
## 必要なソフトウェア
- Bash
## テスト環境
- Ubuntu 24.04 LTS
# plusコマンド
![test](https://github.com/Renwa3/robosys2026/actions/workflows/test.yml/badge.svg)

- 標準入力から読み込んだ数字を足す
- 以下のコマンドで使用可能
```
seq <任意の数字> | ./plus
```

## 必要なソフトウェア
- Python
  - テスト済みバージョン: 3.10〜3.14

## テスト環境
- Ubuntu 24.04 LTS

## 著作権とライセンス
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- このパッケージは、aaa由来のコード（© 2025 Hoge Fuge）を利用しています。
- このパッケージのコードは、下記のスライド（CC BY-SA 4.0 by Taro Suzuki）のものを、
  本人の許可を得て自身の著作としたものです。
    - https://github.com/tarolab-cit/lectures/tree/main/robosys2026
- © 2026 Ren Watanabe


