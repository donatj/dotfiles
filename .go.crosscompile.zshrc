
function go-darwin-386 {
	env GOOS=darwin GOARCH=386 go $@
}

function go-darwin-amd64 {
	env GOOS=darwin GOARCH=amd64 go $@
}

function go-freebsd-386 {
	env GOOS=freebsd GOARCH=386 go $@
}

function go-freebsd-amd64 {
	env GOOS=freebsd GOARCH=amd64 go $@
}

function go-freebsd-arm {
	env GOOS=freebsd GOARCH=arm go $@
}

function go-linux-386 {
	env GOOS=linux GOARCH=386 go $@
}

function go-linux-amd64 {
	env GOOS=linux GOARCH=amd64 go $@
}

function go-linux-arm {
	env GOOS=linux GOARCH=arm go $@
}

function go-windows-386 {
	env GOOS=windows GOARCH=386 go $@
}

function go-windows-amd64 {
	env GOOS=windows GOARCH=amd64 go $@
}

function go-all {
	go-darwin-386 $@
	go-darwin-amd64 $@
	go-freebsd-386 $@
	go-freebsd-amd64 $@
	go-freebsd-arm $@
	go-linux-386 $@
	go-linux-amd64 $@
	go-linux-arm $@
	go-windows-386 $@
	go-windows-amd64 $@
}
