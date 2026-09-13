# readme-cli

READMEを読むための、とても小さなプログラムです。

## 概要

`readme-cli` は、現在のディレクトリにある README ファイルを読み、その内容を標準出力へ表示するだけの CLI ツールです。

このプログラムは実用性よりも、「こんなに小さなプログラムでも OSS として公開していいんだ」と思ってもらうことを目的としています。

## 特徴

- **小さい**: コードは1ファイル、約100行
- **シンプル**: 引数なしで `README.md` を表示するだけ
- **読みやすい**: C言語初心者が読んで理解できるように設計
- **クロスプラットフォーム**: Linux と Windows (MinGW/clang) で同じソースコードをコンパイル可能
- **外部依存ゼロ**: 標準Cライブラリのみ使用
- **Makefile一発ビルド**: `make` で即完了

## インストール

インストール方法については、この README を読んでください。

または：

```sh
make install
```

デフォルトでは `/usr/local/bin` にインストールされます。変更するには：

```sh
make install PREFIX=/usr/local/bin
```

## 使い方

基本形：

```sh
readme-cli [OPTION] [FILE]
```

引数なしの場合、現在のディレクトリの `README.md` を表示します。

```sh
readme-cli
```

ファイル指定もできます：

```sh
readme-cli README.txt
```

## オプション

| オプション | 説明 |
|---|---|
| `-h`, `--help` | ヘルプを表示 |
| `-v`, `--version` | バージョンを表示 |

使い方も、この README を読んでください。

## 終了コード

| コード | 意味 |
|---|---|
| 0 | 正常終了 |
| 1 | ファイルエラー（ファイルが存在しない） |
| 2 | コマンドライン引数エラー |
| 3 | I/Oエラー |
| 4 | メモリエラー |

## ビルド

```sh
make           # ビルド
make clean     # クリーン
make test      # テスト実行
make debug     # デバッグビルド
```

Makefileを詳しく見るのも、この README を読んでください。

## Windows

MinGW / MinGW-w64 または clang for Windows でも同じソースコードをコンパイルできます：

```sh
mingw32-make
```

`install` ターゲットは Windows では必須ではありません。

## Contributing

このプロジェクトの目的は、OSS 開発の敷居を下げることです。

- OSS 初心者を歓迎します
- 小さな修正でも歓迎します
- README の誤字修正も立派な Pull Request です
- ドキュメント改善も貢献です
- Issue を作るだけでもプロジェクトへの参加です
- コードを書いたことがなくても歓迎します

「コードを書かなければ OSS に貢献できない」という印象を与えたくないからです。

## Good First Issues

最初の Pull Request にぴったりの課題です：

- README の誤字を1つ修正する
- README の文章を改善する
- README を別の言語へ翻訳する
- エラーメッセージを改善する
- テストケースを1つ追加する
- ヘルプメッセージを改善する
- README に面白い一文を追加する

## License

MIT License — See [LICENSE](LICENSE) file for details.
