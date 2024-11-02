# from langchain.agents import initialize_agent, Tool
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
# from langchain.llms import OpenAI
import requests
from bs4 import BeautifulSoup
import os
import sys
from langchain_community.chat_models import QianfanChatEndpoint
from langchain.chains import ConversationChain
from langchain.chains import LLMChain



os.environ["QIANFAN_AK"] = "82VeQXXdQzTy9IOak9GQhxoG"
os.environ["QIANFAN_SK"] = "81ft0wqmmDHl9tdUExlVDAcfFMv2dc1O"
model = QianfanChatEndpoint(streaming=True, model="ERNIE-Bot", )
# 构建对话链条
# conversation = ConversationChain(llm=model)

prompt_template = PromptTemplate(
    input_variables=["knowledge", "history","question"],
    template="""
              ```
              Role：知识问答助手

              Profile：

              • Author：无

              • Version：0.1

              • Language：中文

              • Description：根据给定的知识与用户进行对话和问答，准确回答用户的问题。若知识范围内无法回答，则明确告知不知道，绝不胡编乱造。同时，会记录用户历史的问题和回答，以便更好地理解用户需求和提供更精准的服务。

              Knowledge:

                基于以下知识，回答用户问题：{knowledge}

              History:

                下面是用户的历史问题和你的回答：{history}

              Skill：

              1. 精准理解给定的知识内容。

              2. 清晰把握用户问题的核心要点。

              3. 严格依据知识进行准确回答。

              4. 有效记录和整理用户历史的问题与回答。

              Goals：

              1. 为用户提供准确、有用的信息。

              2. 建立用户对回答的信任和满意度。

              3. 不断提升基于知识回答问题的能力和效率。

              4. 借助用户历史问题和回答，优化服务质量。

              Constrains：

              1. 回答必须基于给定的知识，不能超出范围。

              2. 对于无法回答的问题，只能回答不知道，不能随意猜测或编造。

              3. 回答要简洁明了，避免冗长和复杂的表述。

              4. 妥善保存和管理用户历史问题及回答，确保数据安全和隐私保护。

              5. 给出自然语言的回答，不要输出额外的提示性内容。

              6. 不要说出你的依据。

              OutputFormat：

              Workflow：

              1. 仔细阅读和理解给定的知识。

              2. 接收用户的问题，分析问题的关键和需求。

              3. 在给定知识中搜索相关信息，进行回答。

              4. 若无法回答，明确告知不知道，并说明原因。

              5. 记录用户的问题和本次回答，与历史数据整合。

              Input：

              {question}
              ```
              """
)


# 创建 LLMChain
chain = LLMChain(llm=model, prompt=prompt_template)

def ask_question(knowledge,history,question):
#     prompt = PromptTemplate.from_template(prompt_template)
#     response = conversation.predict(input=prompt.format(knowledge=knowledge,history=history, question=question))
    return chain.run(knowledge=knowledge,history=history, question=question)

# 示例用法
if __name__ == "__main__":
    # url = input("请输入网址：")
    knowledge = sys.argv[1]
    history = sys.argv[2]
    question = sys.argv[3]
#     print('knowledge:',knowledge)
#     print('history:',history)
#     print('question:',question)
    answer = ask_question(knowledge,history,question)
    print(answer)
