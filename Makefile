create_update: clean
	./scripts/create_update.sh

deploy_update: create_update
	./scripts/deploy_update.sh

clean:
	rm -rf build/
