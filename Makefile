.PHONY: install lint yaml-lint ansible-lint

install:
	bash install.sh --local --become -e emacs_spacemacs_config=no
	bash install.sh --local

lint: yaml-lint ansible-lint

yaml-lint:
	yamllint ./

ansible-lint:
	ansible-lint ./
