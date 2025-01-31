# Work List

## A. 프롬프트 → LLM
- **문제행동 솔루션**: 응답 조건 [반려동물 정보{나이, 성별, 품종, 성격 등}에 맞는 대사 생성 = 글자수 제한(10자)]
- **감정, 통증, 행동 분석**: 1번 옵션 + (분석정보{감정, 통증 여부, 이상 행동})에 맞는 대사 생성.

## B. LLM → 대사생성
- 데이터 JSON 타입으로 저장

### Example

```json
{
  "pets": [
    {
      "id": "pet1",
      "name": "Buddy",
      "age": "3",
      "gender": "Male",
      "breed": "Labrador",
      "personality": "Playful",
      "utterances": [
        {
          "context": "problem_behavior",
          "response": "저 너무 지루해요! 더 놀아주세요!",
          "character_limit": 10
        },
        {
          "context": "emotion_pain_behavior",
          "emotion": "happy",
          "pain": "no",
          "behavior": "playful",
          "response": "오늘 너무 신나요! 함께 놀아요!",
          "character_limit": 10
        }
      ]
    },
    {
      "id": "pet2",
      "name": "Mittens",
      "age": "7",
      "gender": "Female",
      "breed": "Siamese",
      "personality": "Quiet",
      "utterances": [
        {
          "context": "problem_behavior",
          "response": "혼자 있는 게 좋네요. 조금만 기다려 주세요.",
          "character_limit": 10
        },
        {
          "context": "emotion_pain_behavior",
          "emotion": "sad",
          "pain": "yes",
          "behavior": "inactive",
          "response": "요즘 좀 아파요. 조용히 쉬고 싶어요.",
          "character_limit": 10
        }
      ]
    }
  ]
}
```
    # **다른 RAG 명과 특징** :
    
    1. Self-RAG
    강점: Self-RAG는 검색된 정보를 자체적으로 검토 후, 신뢰도를 평가 진행. 정보의 출처가 많거나 출처마다 신뢰도가 다를 때, Self-RAG는 보다 정확한 정보로 응답할 수 있도록 최적화됩니다.
    추천 이유: 정보의 신뢰성을 평가하고 그에 따라 필터링하기 때문에, 검색된 정보가 신뢰도 높은 경우에만 결과로 제공됩니다.
    
    2. Knowledge-Enhanced RAG
    강점: 이 방식은 사전 학습된 지식과 검색된 정보를 결합하여 보다 정확하고 풍부한 답변을 제공합니다. Pre-trained knowledge가 포함되므로, 검색된 정보가 부족하거나 신뢰도가 낮을 경우 사전 지식을 활용해 교정할 수 있습니다.
    추천 이유: 검색 기반 정보에만 의존하지 않고, 미리 학습된 지식을 함께 사용하여 정확성을 높일 수 있습니다. 특히, 정보가 충분하지 않을 때 유용합니다.
    
    3. Hierarchical RAG
    강점: 이 방식은 정보를 단계적으로 평가하여, 가장 신뢰성 높은 데이터를 우선 제공하는 구조입니다. 검색된 정보를 여러 단계로 분류한 후, 단계별로 가장 정확하고 신뢰성 높은 정보를 제공하는 방식입니다.
    추천 이유: 검색된 정보의 신뢰성에 차이가 있을 때, 이 방식을 사용하여 가장 신뢰할 수 있는 정보부터 응답으로 제공할 수 있습니다.
    
    4. Modular RAG
    강점: Modular RAG는 각각의 데이터 소스(텍스트, 비디오, 오디오)를 개별적으로 처리하고, 각 소스별로 최적화된 방식을 사용하여 검색된 정보의 정확도를 높입니다.
    추천 이유: 다양한 소스에서 데이터를 받아올 때, 각 데이터의 특성에 맞는 처리를 하기 때문에 보다 정교하고 정확한 결과를 제공할 수 있습니다.
    
    5. Context-Aware RAG
    강점: 이 방식은 사용자의 컨텍스트를 정확히 파악하고, 해당 상황에 맞는 정보를 검색하는 데 최적화되어 있습니다. 검색된 정보와 사용자의 입력 사이의 의미적 연관성을 강화하여 정확한 정보를 제공합니다.
    추천 이유: 사용자의 구체적인 요청에 맞춰 문맥을 해석하고, 그 문맥에 적합한 정보를 우선 제공하기 때문에 정확성을 보장할 수 있습니다.
    
    # 사용할 RAG : Corrective RAG
    ### 채택한 이유 : 유튜브 데이터 → 비정형 데이터 → 데이터가 일관적이지 않고, 신뢰도가 떨어짐. 
    1차 검색: RAG 시스템 기반 검색
    RAG 시스템을 통해 내부 데이터베이스(YouTube에서 수집한 데이터 등)에 대해 질문을 검색하고 답변을 제공함.
    이 단계에서 검색된 정보가 정확하다면, 바로 답변을 제공하고 마무리 ..! 
    
    2차 교정: 부정확한 정보 감지
    사용자가 제공된 정보에 만족하지 않거나, 제공된 정보가 부정확하다고 판단될 경우 Corrective RAG 프로세스가 작동합니다.
    이때, 부정확한 정보로 판단된 경우 추가적인 검색 요청을 하게 됩니다.
    
    **부정확한 정보로 판단될 경우 TAVILY 검색 활용하여 추가적인 실시간 웹 서칭**
    
    TAVILY를 사용하여 부정확한 정보를 실시간으로 검색합니다. 특히 최신 정보나 신뢰할 수 있는 웹 데이터를 통해 보완이 필요한 경우, TAVILY는 매우 효과적으로 활용될 수 있습니다.
    TAVILY가 제공하는 정보를 가져와서 기존의 답변에 교정된 내용을 추가합니다.
    
    **최종 답변 생성** : RAG + TAVILY 결과 결합



## Self-RAG 구현을 위한 전체적인 흐름

```
사용자의 질문에 따라 자동 검색 수행:

사용자가 질문을 입력하면, 시스템이 해당 질문을 분석하여 관련 정보를 검색합니다.
검색된 정보를 사용해 질문에 대한 더 정확하고 구체적인 답변을 생성합니다.
질문을 벡터화하고 관련 데이터를 검색:

질문을 임베딩 벡터로 변환하여 벡터 데이터베이스에서 관련 데이터를 검색합니다.
검색된 데이터와 질문을 결합하여 답변 생성:

검색된 데이터를 OpenAI GPT 모델과 결합하여 최종 응답을 생성합니다.
질문과 응답을 메모리에 저장:

질문과 응답을 메모리에 저장하여, 이후 대화에서 해당 정보를 참조할 수 있도록 합니다.
```
Test.v prompt

"""
제공된 영상에서 정확한 동작을 설명해줘
예를들어서 혀를 내밀고 있는 영상이면
그 혀가 어떻게 움직이고, 얼굴이 어떻게 변했고, 고개를 어떻게 움직였는지
프레임 단위로 진행순서에 맞게 설명해줘.
제공된 영상이 동물일 경우, 그 동물의 행동을 최대한 자세히 분석해야돼.
동물의 종류와, 품종, 옷을 입고 있을경우, 어떤 옷을 입고있는지, 기분과 감정은 어떤거 같은지
분석해줘봐.
.
"""

