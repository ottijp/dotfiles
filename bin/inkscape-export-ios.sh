#!/bin/bash
set -eu

readonly INKSCAPE_PATH=/Applications/Inkscape.app/Contents/Resources/bin/inkscape

if [ $# -lt 1 ]; then
  >&2 echo "usage: $0 <svg-file-path>"
  exit 1
fi

PNG_PATH=${1%.*}
echo "export to $PNG_PATH"

if [ ! -f "$INKSCAPE_PATH" ]; then
  >&2 echo "inkscape not found: $INKSCAPE_PATH"
  exit 1
fi

if [ ! -f "$1" ]; then
  >&2 echo "file not found: $1"
  exit 1
fi

mkdir -p "$PNG_PATH"

TMP_REQ_DIR=`mktemp -d`
TMP_PIPE_FILE="$TMP_REQ_DIR/pipe"
mkfifo "$TMP_PIPE_FILE"

# inkscakepをバックグラウンドで起動し，リクエストをパイプ経由で渡す
"$INKSCAPE_PATH" --shell < "$TMP_PIPE_FILE" &
INKSCAPE_PID=$!

# inkscapeシェルへのリクエストを構築
cat <<-EOF > "$TMP_PIPE_FILE"
"$1" --export-png="$PNG_PATH/icon-20.png" --export-width=20 --export-height=20
"$1" --export-png="$PNG_PATH/icon-20@2x.png" --export-width=40 --export-height=40
"$1" --export-png="$PNG_PATH/icon-20@3x.png" --export-width=60 --export-height=60
"$1" --export-png="$PNG_PATH/icon-29.png" --export-width=29 --export-height=29
"$1" --export-png="$PNG_PATH/icon-29@2x.png" --export-width=58 --export-height=58
"$1" --export-png="$PNG_PATH/icon-29@3x.png" --export-width=87 --export-height=87
"$1" --export-png="$PNG_PATH/icon-40.png" --export-width=40 --export-height=40
"$1" --export-png="$PNG_PATH/icon-40@2x.png" --export-width=80 --export-height=80
"$1" --export-png="$PNG_PATH/icon-40@3x.png" --export-width=120 --export-height=120
"$1" --export-png="$PNG_PATH/icon-60@2x.png" --export-width=120 --export-height=120
"$1" --export-png="$PNG_PATH/icon-60@3x.png" --export-width=180 --export-height=180
"$1" --export-png="$PNG_PATH/icon-76.png" --export-width=76 --export-height=76
"$1" --export-png="$PNG_PATH/icon-76@2x.png" --export-width=152 --export-height=152
"$1" --export-png="$PNG_PATH/icon-83.5@2x.png" --export-width=167 --export-height=167
"$1" --export-png="$PNG_PATH/icon-1024.png" --export-width=1024 --export-height=1024
quit
EOF

wait $INKSCAPE_PID
echo done

rm -r $TMP_REQ_DIR

