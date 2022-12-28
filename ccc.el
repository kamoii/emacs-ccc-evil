;;; ccc.el --- ccc.el implementation for evil        -*- lexical-binding: t; -*-

;; Copyright (C) 2022 kamoii

;; Author: kamoii
;; Version: 0.1
;; Keywords: skk, evil
;; URL: https://github.com/kamoii/emacs-ccc-evil

;; SKKが提供するカーソル色を制御するccc.elの仕組みがevilと相性が悪い。
;; evil使う前提で必要な機能をevilのinsert状態のカーソル色をbuffer-localに変更することで実現する。
;; 実際使っている関数や変数のみ定義する。

;; 色が設定される
(defvar-local ccc-buffer-local-cursor-color nil)
;; 設定はされていないが参照はされているので定義
(defvar ccc-default-cursor-color nil)

;; 空で良いはず
;; after-init-hookでskkから呼ばれるのでそれまでに用意する
(defun ccc-setup ()
  (message "Use ccc.el implementationfor evil"))

;; 本来はpost-command-hookに登録されている
;; 設定に基づきローカルのcursor/forground/backgroundの色を変える
;; カーソルの色はccc-update-buffer-local-cursor-colorで更新
;; カーソルの色はバッファローカルなものが ~ccc-buffer-local-cursor-color~ に設定されていれば其、なければ(ccc-frame-cursor-color)
;;
;; ccc-buffer-local-cursor-color変数を設定時にevilのカーソル色に設定するので実装は不要のはず。
(defun ccc-update-buffer-local-frame-params (&optional buffer))

;; 本来ならフレーム毎のカーソル設定を取るがそもそも今はフレーム毎設定はない。
;; 単に本来のevil-insert-state-cursorから設定を取る
(defun ccc-frame-cursor-color (&optional frame)
  (car (default-value 'evil-insert-state-cursor)))

;; カーソル色設定
;; ~ccc-buffer-local-cursor-color~ 変数に色を設定
;; 反映のためにリフレッシュ関数も呼び出し
(defun ccc-set-buffer-local-cursor-color (color-name)
    (setq ccc-buffer-local-cursor-color (or color-name (ccc-frame-cursor-color)))
    (setq-local evil-insert-state-cursor (list ccc-buffer-local-cursor-color 'box))
    (evil-refresh-cursor))

;; カーソル色オフにする機能
;; 本来のカーソル色(ccc-frame-cursor-color)を設定
;; ~ccc-buffer-local-cursor-color~ 変数を元に戻す
;; argが非nilなら別の挙動をするがそのような呼び出しはない
(defun ccc-set-cursor-color-buffer-local (arg)
  (cl-assert (not arg))
  (setq ccc-buffer-local-cursor-color nil)
  (kill-local-variable 'evil-insert-state-cursor)
  (evil-refresh-cursor))

(provide 'ccc)
