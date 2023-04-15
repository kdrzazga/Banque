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
    apt-get install -y chromium && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the environment variables for Xfce
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DISPLAY=:1 \
    TERM=xterm

# Start the Xfce desktop environment and launch Chromium browser
CMD ["startxfce4"]
