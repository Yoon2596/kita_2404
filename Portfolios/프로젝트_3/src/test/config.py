import os
from pymongo import MongoClient
from openai import OpenAI

GPT_MODEL = "gpt-4o-mini-2024-07-18"

os.environ['OPENAI_API_KEY'] = OPENAI_API_KEY
client = OpenAI(api_key=OPENAI_API_KEY)


db_client = MongoClient(MONGODB_URI)
db = db_client['dbsparta']
collection = db['dog']

YOLO_MODEL_PATH = "E:/1006/model/yolo_model.pt"
LSTM_MODEL_PATH = "E:/1006/model/lstm_model.pt"
CONF_THRESH = 0.7

breed_mapping = {
    "Chihuahua": "치와와",
    "Japanese_spaniel": "재패니즈 스패니얼",
    "Maltese_dog": "말티즈",
    "Pekinese": "페키니즈",
    "Shih-Tzu": "시추",
    "Blenheim_spaniel": "블레넘 스패니얼",
    "Papillon": "파피용",
    "Toy_terrier": "토이 테리어",
    "Rhodesian_ridgeback": "로디지안 리지백",
    "Afghan_hound": "아프간 하운드",
    "Basset": "바셋",
    "Beagle": "비글",
    "Bloodhound": "블러드하운드",
    "Bluetick": "블루틱 쿤하운드",
    "Black-and-tan_coonhound": "블랙앤탄 쿤하운드",
    "Walker_hound": "워커 하운드",
    "English_foxhound": "잉글리시 폭스하운드",
    "Redbone": "레드본 하운드",
    "Borzoi": "보르조이",
    "Irish_wolfhound": "아이리시 울프하운드",
    "Italian_greyhound": "이탈리안 그레이하운드",
    "Whippet": "휘핏",
    "Ibizan_hound": "이비전 하운드",
    "Norwegian_elkhound": "노르웨이 엘크하운드",
    "Otterhound": "오터하운드",
    "Saluki": "살루키",
    "Scottish_deerhound": "스코티시 디어하운드",
    "Weimaraner": "바이마라너",
    "Staffordshire_bullterrier": "스태퍼드셔 불테리어",
    "American_Staffordshire_terrier": "아메리칸 스태퍼드셔 테리어",
    "Bedlington_terrier": "베들링턴 테리어",
    "Border_terrier": "보더 테리어",
    "Kerry_blue_terrier": "케리 블루 테리어",
    "Irish_terrier": "아이리시 테리어",
    "Norfolk_terrier": "노퍽 테리어",
    "Norwich_terrier": "노리치 테리어",
    "Yorkshire_terrier": "요크셔 테리어",
    "Wire-haired_fox_terrier": "와이어 폭스 테리어",
    "Lakeland_terrier": "레이클랜드 테리어",
    "Sealyham_terrier": "실리엄 테리어",
    "Airedale": "에어데일",
    "Cairn": "케언 테리어",
    "Australian_terrier": "오스트레일리안 테리어",
    "Dandie_Dinmont": "댄디 딘몬트 테리어",
    "Boston_bull": "보스턴 불",
    "Miniature_schnauzer": "미니어처 슈나우저",
    "Giant_schnauzer": "자이언트 슈나우저",
    "Standard_schnauzer": "스탠다드 슈나우저",
    "Scotch_terrier": "스카치 테리어",
    "Tibetan_terrier": "티베탄 테리어",
    "Silky_terrier": "실키 테리어",
    "Soft-coated_wheaten_terrier": "소프트 코티드 휘튼 테리어",
    "West_Highland_white_terrier": "웨스트 하이랜드 화이트 테리어",
    "Lhasa": "라사압소",
    "Flat-coated_retriever": "플랫 코티드 리트리버",
    "Curly-coated_retriever": "컬리 코티드 리트리버",
    "Golden_retriever": "골든 리트리버",
    "Labrador_retriever": "래브라도 리트리버",
    "Chesapeake_Bay_retriever": "체서피크 베이 리트리버",
    "German_short-haired_pointer": "저먼 쇼트헤어드 포인터",
    "Vizsla": "비즐라",
    "English_setter": "잉글리시 세터",
    "Irish_setter": "아이리시 세터",
    "Gordon_setter": "고든 세터",
    "Brittany_spaniel": "브리타니 스패니얼",
    "Clumber": "클럼버 스패니얼",
    "English_springer": "잉글리시 스프링거 스패니얼",
    "Welsh_springer_spaniel": "웰시 스프링거 스패니얼",
    "Cocker_spaniel": "코커 스패니얼",
    "Sussex_spaniel": "서식스 스패니얼",
    "Irish_water_spaniel": "아이리시 워터 스패니얼",
    "Kuvasz": "쿠바즈",
    "Schipperke": "스키퍼키",
    "Groenendael": "그로넨달",
    "Malinois": "말리노이즈",
    "Briard": "브리아드",
    "Kelpie": "켈피",
    "Komondor": "코몬도르",
    "Old_English_sheepdog": "올드 잉글리시 쉽독",
    "Shetland_sheepdog": "셰틀랜드 쉽독",
    "Collie": "콜리",
    "Border_collie": "보더 콜리",
    "Bouvier_des_Flandres": "부비에 데 플랑드르",
    "Rottweiler": "로트와일러",
    "German_shepherd": "저먼 셰퍼드",
    "Doberman": "도베르만",
    "Miniature_pinscher": "미니어처 핀셔",
    "Greater_Swiss_Mountain_dog": "그레이터 스위스 마운틴 독",
    "Bernese_mountain_dog": "버니즈 마운틴 독",
    "Appenzeller": "아펜젤러",
    "EntleBucher": "엔틀레부처",
    "Boxer": "복서",
    "Bull_mastiff": "불마스티프",
    "Tibetan_mastiff": "티베탄 마스티프",
    "French_bulldog": "프렌치 불도그",
    "Great_Dane": "그레이트 데인",
    "Saint_Bernard": "세인트 버나드",
    "Eskimo_dog": "에스키모 독",
    "Malamute": "말라뮤트",
    "Siberian_husky": "시베리안 허스키",
    "Affenpinscher": "아펜핀셔",
    "Basenji": "바센지",
    "Pug": "퍼그",
    "Leonberg": "레온베르거",
    "Newfoundland": "뉴펀들랜드",
    "Great_Pyrenees": "그레이트 피레니즈",
    "Samoyed": "사모예드",
    "Pomeranian": "포메라니안",
    "Chow": "차우차우",
    "Keeshond": "키스혼트",
    "Brabancon_griffon": "브라반손 그리펀",
    "Pembroke": "펨브로크 웰시 코기",
    "Cardigan": "카디건 웰시 코기",
    "Toy_poodle": "토이 푸들",
    "Miniature_poodle": "미니어처 푸들",
    "Standard_poodle": "스탠다드 푸들",
    "Mexican_hairless": "멕시칸 헤어리스",
    "Dingo": "딩고",
    "Dhole": "도울",
    "African_hunting_dog": "아프리칸 헌팅 독"
}
