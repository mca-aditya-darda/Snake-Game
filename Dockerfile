FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    xvfb \
    x11vnc \
    fluxbox \
    novnc \
    websockify \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY target/Maven1-1.0-SNAPSHOT.jar app.jar

EXPOSE 6080

CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & fluxbox & x11vnc -display :99 -nopw -forever -shared -bg && websockify --web=/usr/share/novnc/ 6080 localhost:5900 & sleep 5 && java -jar app.jar"]