#!/bin/sh
# tests/test.sh — readme-cli のテスト

PASS=0
FAIL=0
TOTAL=11

pass() { PASS=$((PASS + 1)); echo "  PASS: $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  FAIL: $1"; }

bin="../readme-cli"

# テスト用一時ディレクトリを作成
TMPDIR="tests_tmp_dir"
mkdir -p "$TMPDIR"

cd "$TMPDIR" || exit 1

# Test 1: README.mdを表示できる
echo "Test 1: README.mdを表示できる"

cat > README.md <<'EOF'
# Hello
This is a test.
EOF

output=$($bin 2>/dev/null)
expected="# Hello
This is a test."
if [ "$output" = "$expected" ]; then
    pass "README.mdを表示できる"
else
    fail "README.mdの内容が一致しない (got: $output)"
fi

# Test 2: README.mdが存在しない場合、終了コード1
echo "Test 2: README.mdが存在しない場合、終了コード1"
rm -f README.md
$bin >/dev/null 2>&1
code=$?
if [ "$code" = "1" ]; then
    pass "README.md不存在で終了コード1"
else
    fail "README.md不存在で終了コード1ではない (got $code)"
fi

# Test 3: 指定ファイルを表示できる
echo "Test 3: 指定ファイルを表示できる"
cat > test_readme.txt <<'EOF'
Custom file content.
EOF

output=$($bin test_readme.txt 2>/dev/null)
if [ "$output" = "Custom file content." ]; then
    pass "指定ファイルを表示できる"
else
    fail "指定ファイルの内容が一致しない (got: $output)"
fi

# Test 4: --help が終了コード0
echo "Test 4: --help が終了コード0"
$bin --help >/dev/null 2>&1
code=$?
if [ "$code" = "0" ]; then
    pass "--help で終了コード0"
else
    fail "--help で終了コード0ではない (got $code)"
fi

# Test 5: -h が終了コード0
echo "Test 5: -h が終了コード0"
$bin -h >/dev/null 2>&1
code=$?
if [ "$code" = "0" ]; then
    pass "-h で終了コード0"
else
    fail "-h で終了コード0ではない (got $code)"
fi

# Test 6: --version が終了コード0
echo "Test 6: --version が終了コード0"
$bin --version >/dev/null 2>&1
code=$?
if [ "$code" = "0" ]; then
    pass "--version で終了コード0"
else
    fail "--version で終了コード0ではない (got $code)"
fi

# Test 7: -v が終了コード0
echo "Test 7: -v が終了コード0"
$bin -v >/dev/null 2>&1
code=$?
if [ "$code" = "0" ]; then
    pass "-v で終了コード0"
else
    fail "-v で終了コード0ではない (got $code)"
fi

# Test 8: 存在しないオプションが終了コード2
echo "Test 8: 存在しないオプションが終了コード2"
$bin --unknown >/dev/null 2>&1
code=$?
if [ "$code" = "2" ]; then
    pass "--unknown で終了コード2"
else
    fail "--unknown で終了コード2ではない (got $code)"
fi

# Test 9: 引数が多すぎる場合、終了コード2
echo "Test 9: 引数が多すぎる場合、終了コード2"
$bin README.md test_readme.txt >/dev/null 2>&1
code=$?
if [ "$code" = "2" ]; then
    pass "ファイル2個で終了コード2"
else
    fail "ファイル2個で終了コード2ではない (got $code)"
fi

# Test 10: オプションとFILEを同時指定した場合、終了コード2
echo "Test 10: オプションとFILEを同時指定した場合、終了コード2"
$bin --help README.md >/dev/null 2>&1
code=$?
if [ "$code" = "2" ]; then
    pass "--help + FILE で終了コード2"
else
    fail "--help + FILE で終了コード2ではない (got $code)"
fi

# Test 11: 短縮オプションを連結した場合、終了コード2
echo "Test 11: 短縮オプションを連結した場合、終了コード2"
$bin -hv >/dev/null 2>&1
code=$?
if [ "$code" = "2" ]; then
    pass "-hv (連結) で終了コード2"
else
    fail "-hv (連結) で終了コード2ではない (got $code)"
fi

# テストディレクトリを掃除
cd ..
rm -rf "$TMPDIR"

echo ""
echo "結果: $PASS/$TOTAL 通過, $FAIL 失敗"

if [ "$FAIL" -gt 0 ]; then
    exit 1
else
    echo "すべてのテストが成功しました。"
    exit 0
fi
