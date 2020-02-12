BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

printf_green() {
    printf "${GREEN}$1${NC}\n"
}

printf_red() {
    printf "${RED}$1${NC}\n"
}
