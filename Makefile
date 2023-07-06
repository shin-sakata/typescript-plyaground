.PHONY: start test typecheck upgrade

TSC = npx tsc
TS_NODE = npx ts-node
NCU = npx ncu

tsconfig.json: tsconfig.base.json
	$(TSC) -p $^ --showConfig > $@

start: tsconfig.json
	$(TS_NODE) src/app/index.ts

test: tsconfig.json
	$(TS_NODE) src/tests/index.ts

typecheck: tsconfig.json
	$(TSC) --noEmit

upgrade:
	$(NCU) -u && npm i
