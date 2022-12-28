# emacs-ccc-evil

`evil`と`skk`を組み合わせて使う時にカーソル色が適切に変更されない問題を解決する。
`skk`は`ccc.el`というパッケージ(ddskk同リポが提供)を使ってカーソルの色(その他)を変更している。
本パッケージは`skk`が利用している`ccc.el`の関数・変数を`evil`のINSERT状態カーソル色を変更するように実装しなおした代替`ccc.el`を提供する。
必要最低限の実装しかしていないので色々設定していたら動かないかも。

## Elpaca使っている場合の導入方法

本家のddskkリポを取ってくる設定：

```elisp
(elpaca (ccc :repo "https://github.com/skk-dev/ddskk" :files ("ccc.el")))
```

を次のように書き換えればいけるはず。

```elisp
(elpaca (ccc :repo "https://github.com/kamoii/emacs-ccc-evil.git"))
```
