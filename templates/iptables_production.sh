#!/bin/bash

# Источник: http://help.ubuntu.ru/wiki/iptables

# Разрешаем связанные и установленые соединения
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Разрешаем служебный icmp-трафик
iptables -A INPUT -p icmp -j ACCEPT

# Разрешаем доверенный трафик на интерфейс loopback
iptables -A INPUT -i lo -j ACCEPT

# remote.ssh
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m tcp --dport 22 -j ACCEPT

# web.http, web.https
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m multiport --dports 80,443,8080 -j ACCEPT

# web.ftp + необходима загрузка модуля nf_conntrack_ftp
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m tcp --dport 21 -j ACCEPT

# mail.pop3, mail.pop3s
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m multiport --dports 110,995 -j ACCEPT

# mail.imap, mail.imaps
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m multiport --dports 143,993 -j ACCEPT

# mail.smtp, mail.smtps
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m multiport --dports 25,465,587 -j ACCEPT

# Сюда можно вставлять дополнительные правила для цепочки INPUT

# Запрещаем всё остальное для INPUT
iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited

# Порядок и смысл правил для цепочек FORWARD и OUTPUT аналогичен INPUT
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p icmp -j ACCEPT
iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited

# Фильтровать цепочку OUTPUT настоятельно не рекомендуется
# iptables -A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -p icmp -j ACCEPT
# iptables -A OUTPUT -o lo -j ACCEPT
# iptables -A OUTPUT -j REJECT --reject-with icmp-host-prohibited
