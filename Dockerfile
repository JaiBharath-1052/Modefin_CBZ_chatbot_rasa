FROM python:3.8

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

RUN mkdir /app/
WORKDIR /app/
USER root
USER 1000
COPY . .


FROM rasa/rasa:2.6.2-full
WORKDIR '/app'
COPY . /app
COPY ./data /app/data
RUN rasa train
VOLUME /app
VOLUME /app/data
VOLUME /app/models


######################  default ###############
#FROM rasa/rasa:2.6.2

#WORKDIR /app
#COPY . /app
#USER root

#RUN pip install --upgrade pip
#RUN pip install --no-cache-dir -r requirements.txt
#RUN pip install scipy==1.7.3
#RUN python -m spacy download en_core_web_md 
#RUN python -m spacy link en_core_web_md en

#COPY ./data /app/data

#RUN rasa train

#VOLUME /app
#VOLUME /app/data
#VOLUME /app/models

#CMD ["run", "-m", "/app/models", "--enable-api","--cors","*","--debug" ,"--endpoints", "endpoints.yml", "--log-file", "out.log", "--debug"]

#EXPOSE 5005

##################### 1st method ###################

#FROM python:3.8-slim

#RUN python -m pip install rasa

#WORKDIR /app
#COPY . .

#RUN rasa train nlu

# set the user to run, don't run as root permissions/folder
#USER 1001

# set entrypoint for interactive shells
#ENTRYPOINT ["rasa"]

# command to run when container is called to run
#CMD ["run", "--enable-api", "--port", "8080"]

####################### 2nd method ###################3

FROM rasa/rasa:2.6.2-full
WORKDIR '/app'
COPY . /app
USER 1001
USER root
COPY ./data /app/data
RUN rasa train
VOLUME /app
VOLUME /app/data
VOLUME /app/models
#COPY ./models /app/models
#COPY . /app
CMD ["run", "-m", "/app/models", "--enable-api", "--cors", "*", "--debug" , "--endpoints", "endpoints.yml", "--log-file", "out.log", "--debug"]
#CMD ["run", "--enable-api", "--port", "5005"]
#ENTRYPOINT ["rasa", "run", "-m", "/app/models", "--enable-api", "--cors", "*", "--debug"]
