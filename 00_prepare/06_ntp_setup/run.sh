#!/bin/bash
ansible-playbook ./yaml/ntp_server.yml

ansible-playbook ./yaml/ntp_client.yml

