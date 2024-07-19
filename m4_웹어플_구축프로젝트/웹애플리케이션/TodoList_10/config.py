import os
# 현재 파일의 절대 경로르 기반으로 basedir 변수를 설정. 이 변수는 프로젝트의 기본 디렉터리를 나타낸다
# os.path.abspath(path) : 주어진 경로 path에 저대 결로로 ㅂ녀환
# __file__의 디렉토리 부분만을 추출. D:\kdt_240424\workspace\m4_웹애플리케이션\TodoList_10>
basedir = os.path.abspath(os.path.dirname(__file__))
# Flask configuration
# 세션 데이터 암호화, CSRF 보호 등을 위해 사용

class Config:
    SECRET_KEY = '9546b2e2411510631a32f4d8b21268af8a2531055ddd5f9b'
    SQLALCHEMY_DATABASE_URI = "mysql+pymysql://kita2:kita2@localhost:3306/kita2_db"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    UPLOADED_FILES_DEST = os.path.join(basedir, "uploads")

# Uploads configuration
# 파일 업로드 시 저장할 기본 경로를 설정
# D:\kdt_240424\workspace\m4_웹애플리케이션\TodoList_10\uploads