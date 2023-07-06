.PHONY: start test typecheck upgrade clean

TSC = npx tsc
TS_NODE = npx ts-node
NCU = npx ncu

TS_FILES := $(wildcard src/**/*.ts)
OUT_DIR := dist

tsconfig.json: tsconfig.base.json
	$(TSC) -p $^ --showConfig > $@

start: tsconfig.json
	$(TS_NODE) src/app/index.ts

test: tsconfig.json
	$(TS_NODE) src/tests/index.ts

typecheck: $(TS_FILES) tsconfig.json
	$(TSC) --noEmit

$(OUT_DIR): $(TS_FILES) tsconfig.json
	$(TSC)

upgrade:
	$(NCU) -u && npm i

clean:
	rm -rf $(OUT_DIR)
