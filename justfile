
install:
  yarn

start-holesky: install
  #!/usr/bin/env sh
  set -a
  . ./.env.holesky
  set +a
  NODE_OPTIONS=--openssl-legacy-provider yarn start

start-mainnet: install
  NODE_OPTIONS=--openssl-legacy-provider yarn start
