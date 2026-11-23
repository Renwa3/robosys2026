#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Ren Watanabe
# SPDX-License-Identifier: BSD-3-Clause

ng () {
  echo "${1}行目のテスト失敗"
  res=1
}

res=0

### NORMAL INPUT ###
out=$(printf "  1  git status\n  2  git push\n  3  git push\n  4  ls -la\n" | ./hisort)
[ "$?" = 0 ] || ng "$LINENO"
expected=$'      2 git push\n      1 ls -la\n      1 git status'
[ "${out}" = "${expected}" ] || ng "$LINENO"

out=$(printf "  1  git status\n  2  git push\n  3  git push\n  4  git pull\n" | ./hisort "git p")
[ "$?" = 0 ] || ng "$LINENO"
expected=$'      2 git push\n      1 git pull'
[ "${out}" = "${expected}" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(printf "  1  git status\n  2  ls -la\n" | ./hisort "not_found_cmd_xyz")
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "\n   \n" | ./hisort)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK

exit $res
