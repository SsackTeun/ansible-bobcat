# 00_prepare/00_kolla_image
- kolla-ansible 로 오픈스택을 배포할 때 필요한, 컨테이너 이미지를 dockerhub 로 부터 pull(download)
- tar 파일로 저장 ./kolla_image

# 00_prepare/01_registry <---------------------------------------- this
- 00_kolla_image 에서 저장된 tar 파일은 내부 망에서 dockerhub 에서 이미지를 제공해줄 수 없기 때문에,
registry 서버를 만들어 tar 파일을 push 를 통해 00_kolla_image 과정에서 dockerhub 에서 제공하는 파일을 내부망에서도 
그대로 제공할 수 있게 하기 위함이다.

1. dockerhub 는 image registry 라고 한다.
2. registry 서버를 만든다는 것은 image registry 즉, 이미지 제공하는 저장소를 만든다는 뜻

# 파이썬 가상환경 실행
. activate <-> deactivate

