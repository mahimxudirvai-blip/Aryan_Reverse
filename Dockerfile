FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        openssh-server \
        sudo \
        figlet && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd && ssh-keygen -A

RUN useradd -m -s /bin/bash xnil6x404 && \
    echo "xnil6x404:xnil7080" | chpasswd && \
    usermod -aG sudo xnil6x404 && \
    echo "xnil6x404 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/xnil6x404 && \
    chmod 0440 /etc/sudoers.d/xnil6x404

RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    echo "UseDNS no" >> /etc/ssh/sshd_config

RUN echo 'PS1="\[\033[1;31m\]Nyxora-host@\u:\w\$ \[\033[0m\]"' > /home/xnil6x404/.bashrc && \
    chown xnil6x404:xnil6x404 /home/xnil6x404/.bashrc

RUN echo 'clear' >> /etc/profile && \
    echo 'echo -e "\033[1;35m$(figlet -c Nyxora)\033[0m"' >> /etc/profile && \
    echo 'echo ""' >> /etc/profile && \
    echo 'echo -e "\033[1;33m ✦ Think Fast. Build Clean. Deploy Bold. ✦ \033[0m"' >> /etc/profile && \
    echo 'echo ""' >> /etc/profile && \
    echo 'echo -e "\033[1;36m ⚡  Hey $(whoami), welcome to the Main Nyxora Server ⚡ \033[0m"' >> /etc/profile && \
    echo 'echo -e "\033[1;32m ✨  You have administrative access. Build fearlessly. ✨ \033[0m"' >> /etc/profile && \
    echo 'echo ""' >> /etc/profile

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
