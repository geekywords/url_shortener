.PHONY: $(MAKECMDGOALS)

# `make setup` will be used after cloning or downloading to fulfill
# dependencies, and setup the the project in an initial state.
# This is where you might download rubygems, node_modules, packages,
# compile code, build container images, initialize a database,
# anything else that needs to happen before your server is started
# for the first time
setup:
	@echo
	@echo
	@echo Setting up application, if something fails please check notes.txt for requisites
	@echo 
	@echo
	@echo Starting database with Docker
	docker-compose up -d postgres
	@echo 
	@echo
	@echo Installing backend dependencies
	mix deps.get
	@echo 
	@echo
	@echo Setting up database
	mix ecto.setup
	@echo 
	@echo
	@echo Installing frontend dependencies
	cd assets && yarn

# `make server` will be used after `make setup` in order to start
# an http server process that listens on any unreserved port
#	of your choice (e.g. 8080). 
server:
	mix phx.server

# `make test` will be used after `make setup` in order to run
# your test suite.
test:
	mix test