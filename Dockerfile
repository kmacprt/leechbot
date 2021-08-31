FROM breakdowns/mega-sdk-python:latest

RUN mkdir ./leechbot
RUN chmod 777 ./CendrawasihLeech
WORKDIR /leechbot

ENV TZ=Asia/Jakarta

RUN apt -qq update --fix-missing && \
    rm -rf /var/lib/apt/lists/* && \
    apt -qq update
#     apt -qq install -y git aria2 wget curl busybox ffmpeg

RUN wget https://rclone.org/install.sh
RUN bash install.sh

RUN mkdir /leechbot/Leech
RUN wget -O /leechbot/Leech/gclone.gz https://git.io/JJMSG
RUN gzip -d /leechbot/Leech/gclone.gz
RUN chmod 0775 /leechbot/Leech/gclone

# RUN wget -O /CendrawasihLeech/dht.dat https://raw.githubusercontent.com/P3TERX/aria2.conf/master/dht.dat
# RUN wget -O /CendrawasihLeech/dht6.dat https://raw.githubusercontent.com/P3TERX/aria2.conf/master/dht6.dat

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
COPY extract /usr/local/bin
COPY .netrc $HOME/.netrc
# RUN chmod +x /usr/local/bin/extract && chmod 600 /root/.netrc
RUN touch $HOME/.netrc && chmod a-rwx,u+rw $HOME/.netrc

CMD ["bash","start.sh"]
