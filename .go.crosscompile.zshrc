
# set -e

SOURCE=$(go tool dist list | awk 'BEGIN { FS = "/" } ; { print "function go-"$1"-"$2 " {\n\tenv GOOS="$1" GOARCH="$2" go $@\n}\n" }')
eval "$SOURCE"

SOURCE=$(go tool dist list | awk 'BEGIN { FS = "/" } ; { print "\tgo-"$1"-"$2" $@" }')
eval "function go-all {
	$SOURCE
}"
