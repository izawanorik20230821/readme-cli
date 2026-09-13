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

デフォルトでは `$(HOME)/.local/bin` にインストールされます。変更するには：

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

MinGW / MinGW-w64 または clang for Windows でも同じソースコードをコンパイルできます。
ただし Makefile は 修正が必要かもしれません。

```sh
mingw32-make
```

`install` ターゲットは Windows では必須ではありません。

## このプロジェクトの目的

次が、このプロジェクトの目的です。

- OSS 開発の敷居を下げること
- 「難しいコードを書かなければ OSS に貢献できない」という印象をなくすこと

## License

MIT License — See [LICENSE](LICENSE) file for details.
