.PHONY: install start test typecheck upgrade clean build

TSC := npx tsc
TS_NODE := npx ts-node
NCU := npx ncu

SRC_DIR := src
TS_FILES := $(wildcard $(SRC_DIR)/**/*.ts)
OUT_DIR := dist
NODE_MODULES := node_modules

define npm_install
	npm install
endef

tsconfig.json: tsconfig.base.json
	$(TSC) -p $^ --showConfig > $@

$(NODE_MODULES): package.json package-lock.json
	$(call npm_install)

$(OUT_DIR): $(NODE_MODULES) $(TS_FILES) tsconfig.json
	$(TSC)

install: $(NODE_MODULES)

build: $(OUT_DIR)

start: install tsconfig.json
	$(TS_NODE) $(SRC_DIR)/app/index.ts

test: install tsconfig.json
	$(TS_NODE) $(SRC_DIR)/tests/index.ts

typecheck: install $(TS_FILES) tsconfig.json
	$(TSC) --noEmit

upgrade: install
	$(NCU) -u
	$(call npm_install)

clean:
	rm -rf $(OUT_DIR) $(NODE_MODULES)
