#!/bin/bash
# 실행

ansible-playbook yaml/prepare_create_registry.yml
ansible-playbook yaml/prepare_load_image.yml
ansible-playbook yaml/prepare_push_image_to_myregistry.yml
curl -u admin:admin http://myregistry:5000/v2/_catalog
 
