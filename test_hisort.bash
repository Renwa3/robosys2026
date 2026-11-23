#!/bin/bash
# SPDX-FileCopyrightText: 2026 Ren Watanabe
# SPDX-License-Identifier: BSD-3-Clause

ng () {
         echo "${1}行目のテスト失敗"
         res=1
}

res=0

# テスト対象（hisort を読み込む）
source ./hisort

# テスト用に history コマンドを差し替える（末尾1行は自分の呼び出し分として削られる想定）
history () {
  printf '%s\n' \
    "  101  git status" \
    "  102  git push" \
    "  103  git status" \
    "  104  ls -la" \
    "  105  git push" \
    "  106  cd src" \
    "  107  git push" \
    "  108  hisort git p"
}

### NORMAL INPUT ###
out=$(hisort "git p")
[ "$?" = 0 ] || ng "$LINENO"
expected=$'      3 git push'
[ "${out}" = "${expected}" ] || ng "$LINENO"

out=$(hisort git p)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(hisort "not_found_cmd_xyz")
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK

exit $res
