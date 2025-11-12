find . -type f -name ".env*" ! -name "*.example" | while read -r f; do
  out="${f}.example"
  echo "# Redacted example generated from ${f}" > "$out"
  awk -F= '
    /^\s*#/ { next }                # skip comments
    /^\s*$/ { print ""; next }      # keep blank lines
    /^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*[[:space:]]*=/ {
      key=$1
      # trim spaces
      gsub(/^[[:space:]]+|[[:space:]]+$/,"",key)
      print key"=" "<redacted>"
    }
  ' "$f" >> "$out"
  echo "Wrote $out"
done