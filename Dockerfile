# docker build -t banque-img .
# docker run -it banque-img

FROM debian:latest

# Install Xfce desktop environment and related packages
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Java 11
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Chromium browser
RUN apt-get update && \
    apt-get install -y chromium mc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the environment variables for Xfce
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DISPLAY=:1 \
    TERM=xterm

COPY app/target/banque-app-0.8.0-RELEASE-jar-with-dependencies.jar /usr/local/share/banque.jar
RUN cd /usr/local/share/
#RUN chmod 777 banque.jar

# Start the Xfce desktop environment and launch Chromium browser
#CMD ["startxfce4"]
CMD ["mc"]
