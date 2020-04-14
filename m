Content-Type: multipart/mixed; boundary="===============6329109536190905241=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] iproute: mptcp support
Date: Tue, 14 Apr 2020 10:24:20 +0200
Message-ID: <cover.1586444916.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4160

--===============6329109536190905241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This updated the command syntax as per ML discussion. I picked 'endpoint' as
the main sub-command name.

Still lacks a man-page (help more than welcome!!!)

If there is agreement, the idea is including Davide's 'ss' patch and send
them upstream as a whole.

Any feedback welcome!

Paolo Abeni (2):
  uapi: update linux/mptcp.h
  add support for mptcp netlink interface.

 include/uapi/linux/mptcp.h |  88 ++++++++
 ip/Makefile                |   2 +-
 ip/ip.c                    |   3 +-
 ip/ip_common.h             |   1 +
 ip/ipmptcp.c               | 449 +++++++++++++++++++++++++++++++++++++
 5 files changed, 541 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 ip/ipmptcp.c

-- =

2.21.1

--===============6329109536190905241==--
