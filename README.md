# 9cc C Compiler
Cコンパイラを作ってみたかったので作ります。
植山類さん作の9cc C コンパイラを作成します。

---

参考記事はこちら: https://www.sigbus.info/compilerbook

進捗を書いています: https://oyashimi.com/blog/cs/C_Compiler

---

## 開発環境

本が前提としているのは x86-64 Linux + GNU as だが、開発機は Apple Silicon (arm64) の macOS。
生成される Intel 記法の x86-64 アセンブリは arm64 の clang ではアセンブルできないため、
Docker で x86-64 Linux のコンテナを立ててその中でビルド・テストする。

初回のみイメージを作成する（本が配布している Dockerfile を使用）。

```bash
make dimage
```

## コマンド

ホストから叩くターゲット（`d` プレフィックス付き）は、内部で
`docker run --platform linux/amd64` 経由でコンテナ内の対応ターゲットを実行する。

| コマンド | 実行場所 | 動作 |
| --- | --- | --- |
| `make` | ホスト | `make dtest` と同じ（arm64 ホストでは既定ターゲット） |
| `make dtest` | ホスト | コンテナ内でビルドしてテストを実行 |
| `make dbuild` | ホスト | コンテナ内でビルドのみ |
| `make dclean` | ホスト | コンテナ内で成果物を削除 |
| `make dsh` | ホスト | コンテナに対話シェルで入る（`gdb`・アセンブリ確認用） |
| `make dimage` | ホスト | 本の Dockerfile からイメージを作り直す |
| `make 9cc` | コンテナ | `9cc.c` をコンパイル |
| `make test` | コンテナ | `test.sh` を実行 |
| `make clean` | コンテナ | `9cc`・`*.o`・`tmp*` を削除 |

`--platform linux/amd64` の指定が要点。付けないと arm64 のイメージが動いてしまい、
`.intel_syntax noprefix` が `unknown directive` になる。

---

随時更新
