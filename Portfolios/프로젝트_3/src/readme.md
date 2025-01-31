## 구조 설명

### `AI/`
- **fine_tuning** : 문제해결 솔루션 관련 AI 개발 관련 코드 입니다. (관련 기술 : OpenAI API(GPT-4o-mini),  Langchain, Langchain-Memory Buffer, LangChain-Multi retriever, Prompt Engineering, Rag, Fine Tuning)
- **vision_model** : 반려동물 사전학습 데이터셋을 활용한 Vision 모델 개발 관련 코드 입니다. (관련 기술 : yolo-v8, TTS, OpenAI API(GPT-4o-mini), fine_tuning)
- **AI Integration** : 개발한 AI 서비스를 통합한 AI 'echo' 개발 코드 입니다.

### `Client/`
- **frontend**: 사용자 UI/UX 개발 관련 코드 입니다. (APP / WEB) 으로 분리됩니다. (관련 기술 : React, React Native)
- **backend**: API 서버와 클라이언트 간의 상호작용을 처리하며, DB연동 같은 사이드 로직이 포함될 Main 코드입니다. (관련 기술 : node.js + express)

### `Server/`
- **Cloud**: 클라우드 서버 서비스 연동 및 배포 코드 입니다. (관련 기술 : AWS)
- **DB**: 데이터베이스 서버 연결 및 연동, 쿼리 작성이 포함된 코드 입니다. (관련 기술 : MongoDB)
- **Docker**: Docker 컨테이너 및 환경 설정과 관련된 코드입니다. 다양한 환경에서 애플리케이션을 일관되게 배포하고 관리하는데 필요한 설정과 스크립트가 포함 됩니다.

### `config/`
- **config.json**: 애플리케이션의 주요 설정 파일을 포함합니다. 데이터베이스 연결 정보, API 키, 로그 설정 등 애플리케이션의 동작에 필요한 민감한 정보와 조정에 필요한 설정 정보가 포함됩니다.

### `test/`
- **integration/**: 개별, 모듈/함수가 통합된 상태에서의 테스트 코드 입니다. 시스템의 다양한 부분을 조립하여 함께 동작하는지를 확인하기 위한 목적 입니다.
- **e2e/**: 전체 애플리케이션의 흐름을 테스트하는 E2E 테스트가 포함됩니다. 사용자 시나리오를 기반으로 전체 시스템의 기능을 테스트합니다.

## 참고

- 각 폴더의 세부 사항은 프로젝트의 요구 사항에 따라 다를 수 있으며, 필요에 따라 폴더 구조와 파일을 수정할 수 있습니다.
- 파일의 내용이나 구조에 대한 변경 사항은 반드시 상의 후 진행해 주세요.
