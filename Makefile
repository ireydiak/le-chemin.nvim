.PHONY: lint format check

LUA_FILES = lua/**/*.lua

lint:
	@echo "==> Running Luacheck..."
	luacheck $(LUA_FILES) --globals vim

format:
	@echo "==> Running StyLua..."
	stylua $(LUA_FILES)

check: lint format
