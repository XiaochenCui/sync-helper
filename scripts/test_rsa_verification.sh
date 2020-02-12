#!/bin/sh
source "printf.sh"

usage() {
    echo "Usage:"
    echo "  ./test_rsa_verification.sh genkey\t\t生成密钥对"
    echo "  ./test_rsa_verification.sh sign MESSAGE\t对 MESSAGE 进行签名"
    echo "  ./test_rsa_verification.sh request\t\t向服务器发送控制指令"
    exit 0
}

PRIVATE_FILE="private.pem"
PUBLIC_FILE="public.pem"
PASSWORD="foobar"
MESSAGE_FILE="message.txt"
SIGNATURE_ALG="md5"
SIGNED_FILE=$MESSAGE_FILE.$SIGNATURE_ALG

gen_keypair() {
    printf_green "Generating private key..."
    openssl genrsa -aes128 -out $PRIVATE_FILE -passout pass:$PASSWORD 3072

    printf_green "\nGenerating public key..."
    openssl rsa -passin pass:$PASSWORD -in $PRIVATE_FILE -outform PEM -pubout -out $PUBLIC_FILE
}

gen_signature() {
    echo $1 > $MESSAGE_FILE
    openssl dgst -passin pass:$PASSWORD -$SIGNATURE_ALG -sign $PRIVATE_FILE -out $SIGNED_FILE $MESSAGE_FILE
    signature="$(base64 $SIGNED_FILE)"
    printf_green "\nSignature is:"
    echo $signature
}

send_request() {
    signature="$(base64 $SIGNED_FILE)"
    curl -q -H "Content-Type: application/json" -H "Authorization: JWT eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkNZWFdtTlU4WksiLCJ1c2VyX2lkIjoyLCJlbWFpbCI6IiIsImV4cCI6MTU0Mzk5NDU4MX0.X2gVHRKM0KLdYeGcTGjlWqr0u6oKAldqRsCyN63Wk_NkmkaO3h22WEGmpkVMFwHLDoeaya6zPR52mdC1jq1aFw" --request PATCH http://localhost:4050/truck/truck/1/send_unlock_command/ -d "{\"sign\":\"$signature\"}"
}

action=$1
shift
case "$action" in
    genkey)
        gen_keypair
        ;;
    sign)
        gen_signature "$@"
        ;;
    request)
        send_request
        ;;
    *)
        usage
        ;;
esac
exit 0
