SHELL := /bin/bash
DEPLOYMENT=local

build:
	hugo --config config-main.toml,config-${DEPLOYMENT}.toml

dev:
	hugo server --config config-main.toml,config-${DEPLOYMENT}.toml