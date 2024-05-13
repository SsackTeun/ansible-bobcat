#!/bin/bash
# python
python3 -m venv ../pyenv 
echo ". ../pyenv/bin/activate" >> activate
. activate
pip install -U pip # 활성화된 가상환경에서 pip 업그레이드
pip install ansible # ansible 설치 
