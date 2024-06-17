visualStudio Code
1. path 설정 : 시스템 환경변수 설정 -> 환경변수 -> administrator쪽에 있는 Path를 클릭하고 밑에 편집
  - C:\Users\Administrator\AppData\Local\Programs\Python\Python310\
  - C:\Users\Administrator\AppData\Local\Programs\Python\Python310\Scripts\
  - 2개 넣고 종료
  
2. 설치 필요
왼쪽 블럭 같은 곳 클릭후 설치 필요
- python
- jupyter notebook
- live server  

4. VS Code 시작 터미널 명령어
python 경로 확인:
where python

python 가상환경 설정:
python --version

가상환경 생성 :
cd my_project
python -m venv myenv

가상환경 활성화:
myenv\Scripts\activate

패키지 설치 및 관리:
pip list
pip install requests

가상환경 비활성화:
deactivate

가상환경에 설치된 모든 패키지 목록을 requirements.txt 파일로 저장
pip freeze > requirements.txt

requirements.txt 파일을 사용하여 패키지 설치
pip install -r requirements.txt

Python의 패키지 관리자인 pip을 최신 버전으로 업그레이드하는 명령어
python.exe -m pip install --upgrade pip


Live Server Port 이슈
포트 사용 중인 프로세스 확인
netstat -aon | findstr :5500
프로세스 종료: taskkill /PID 1234 /F
라이브 안돼면 왼쪽 밑 톱니바퀴에서 세팅 클릭 -> 찾는 곳에서 live 치고 조금 밑으로 내리면 live Server : Settings Port 에서 Edit in settings.json 클릭 -> port의 숫자를 5500 안돼면 5501로 바꾸고 오른쪽 하단끝에 있는 Go Live click
