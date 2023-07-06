.PHONY: start test typecheck upgrade clean all

TSC := npx tsc
TS_NODE := npx ts-node
NCU := npx ncu

TS_FILES := $(wildcard src/**/*.ts)
OUT_DIR := dist
NODE_MODULES := node_modules

tsconfig.json: tsconfig.base.json
	$(TSC) -p $^ --showConfig > $@

$(NODE_MODULES): package.json package-lock.json
	npm i

$(OUT_DIR): $(NODE_MODULES) $(TS_FILES) tsconfig.json
	$(TSC)

start: $(NODE_MODULES) tsconfig.json
	$(TS_NODE) src/app/index.ts

test: $(NODE_MODULES) tsconfig.json
	$(TS_NODE) src/tests/index.ts

typecheck: $(NODE_MODULES) $(TS_FILES) tsconfig.json
	$(TSC) --noEmit

upgrade: $(NODE_MODULES)
	$(NCU) -u
	$(MAKE) $(NODE_MODULES)

clean:
	rm -rf $(OUT_DIR) $(NODE_MODULES)
