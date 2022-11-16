$gomod = $Env:GOPATH + "\pkg\mod"

del ./pkg/proto/* -Recurse -Force

&protoc @("-I=$gomod",
    "-I=./proto/tron",
    "-I=./proto/googleapis",
    "--go_out=./pkg/proto",
    "--go_opt=paths=source_relative",
    "--go-grpc_out=./pkg/proto",
    "--go-grpc_opt=paths=source_relative",
    "./proto/tron/core/*.proto")
&protoc @("-I=$gomod",
    "-I=./proto/tron",
    "-I=./proto/googleapis",
    "--go_out=./pkg/proto",
    "--go_opt=paths=source_relative",
    "--go-grpc_out=./pkg/proto",
    "--go-grpc_opt=paths=source_relative",
    "./proto/tron/core/contract/*.proto")
mv ./pkg/proto/core/contract/* ./pkg/proto/core/
rm -Recurse -Force ./pkg/proto/core/contract

&protoc @("-I=$gomod",
    "-I=./proto/tron",
    "-I=./proto/googleapis",
    "--go_out=./pkg/proto",
    "--go_opt=paths=source_relative",
    "--go-grpc_out=./pkg/proto",
    "--go-grpc_opt=paths=source_relative",
    "./proto/tron/api/*.proto")

mkdir ./pkg/proto/util

&protoc @("-I=$gomod",
    "-I=./proto/tron",
    "-I=./proto/googleapis",
    "-I=./proto/util",
    "--go_out=./pkg/proto/util",
    "--go_opt=paths=source_relative",
    "--go-grpc_out=./pkg/proto/util",
    "--go-grpc_opt=paths=source_relative",
    "./proto/util/*.proto")

Get-ChildItem ./pkg/proto/api/*.go -Recurse | ForEach-Object {
# Read the file and use replace()
    (Get-Content $_) -replace 'github.com/tronprotocol/grpc-gateway','github.com/fbsobreira/gotron-sdk/pkg/proto'| Set-Content $_
}

Get-ChildItem ./pkg/proto/util/*.go -Recurse | ForEach-Object {
# Read the file and use replace()
    (Get-Content $_) -replace 'github.com/tronprotocol/grpc-gateway','github.com/fbsobreira/gotron-sdk/pkg/proto'| Set-Content $_
}