TF_DIR      := infra
ANSIBLE_DIR := ansible
INVENTORY   := $(ANSIBLE_DIR)/inventory.ini
PLAYBOOK    := $(ANSIBLE_DIR)/site.yml

.PHONY: all init plan apply build ansible destroy clean test help

all: build ## Alias par defaut -> build

init: ## Initialise Terraform
	terraform -chdir=$(TF_DIR) init

plan: init ## Affiche le plan Terraform
	terraform -chdir=$(TF_DIR) plan

apply: init ## Applique Terraform (cree l'infra + genere ansible/inventory.ini)
	terraform -chdir=$(TF_DIR) apply -auto-approve

build: apply ## Chaine complete : terraform apply -> inventaire auto -> ansible-playbook
	@echo ">> Inventaire genere par Terraform :"
	@cat $(INVENTORY)
	$(MAKE) ansible

ansible: ## Lance Ansible sur l'inventaire genere par Terraform
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i $(INVENTORY) $(PLAYBOOK)

destroy: ## Detruit l'infra Terraform
	terraform -chdir=$(TF_DIR) destroy -auto-approve

clean: ## Nettoie les artefacts locaux
	rm -rf $(TF_DIR)/.terraform $(INVENTORY) $(ANSIBLE_DIR)/.ansible *.retry

test: init ## Valide Terraform et verifie la syntaxe du playbook
	terraform -chdir=$(TF_DIR) validate
	terraform -chdir=$(TF_DIR) fmt -check -recursive
	ansible-playbook $(PLAYBOOK) --syntax-check

help: ## Liste les cibles disponibles
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN{FS=":.*## "}{printf "  %-10s %s\n", $$1, $$2}'
