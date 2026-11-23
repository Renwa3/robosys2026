#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Ren Watanabe
# SPDX-License-Identifier: BSD-3-Clause

ng () {
  echo "${1}行目のテスト失敗"
  res=1
}

res=0

# テスト対象（hisort 関数を読み込む。BASH_SOURCE チェックにより末尾の自動実行は走らない）
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

### NORMAL INPUT (history fallback) ###
out=$(hisort "git p")
[ "$?" = 0 ] || ng "$LINENO"
expected=$'      3 git push'
[ "${out}" = "${expected}" ] || ng "$LINENO"

out=$(hisort git p)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "${expected}" ] || ng "$LINENO"

### STDIN INPUT ###
stdin_data=$'  1  git commit -m "a"\n  2  git commit -m "b"\n  3  git status\n  4  git commit -m "c"'
out=$(printf '%s\n' "$stdin_data" | hisort "git commit")
[ "$?" = 0 ] || ng "$LINENO"
expected_stdin=$'      3 git commit -m "a"\n      3 git commit -m "b"\n      3 git commit -m "c"'
# 同一カウントの行順は sort に依存するため、件数とコマンドが含まれるか確認
echo "$out" | grep -q '      3 git commit -m "a"' || ng "$LINENO"

# 引数なしで標準入力を渡した場合
out=$(printf '%s\n' "  1  echo hi" "  2  echo hi" "  3  pwd" | hisort)
[ "$?" = 0 ] || ng "$LINENO"
expected_no_prefix=$'      2 echo hi\n      1 pwd'
[ "${out}" = "${expected_no_prefix}" ] || ng "$LINENO"

### DIRECT EXECUTION (./hisort) ###
if [ -x ./hisort ]; then
  out=$(printf '%s\n' "  1  ls" "  2  ls" "  3  ls" "  4  pwd" | ./hisort ls)
  [ "$?" = 0 ] || ng "$LINENO"
  [ "${out}" = $'      3 ls' ] || ng "$LINENO"
fi

### STRANGE INPUT ###
out=$(hisort "not_found_cmd_xyz")
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf '%s\n' "" "   " | hisort)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK

exit $res
