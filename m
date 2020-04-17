Content-Type: multipart/mixed; boundary="===============6118507127044900866=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/4] iproute: mptcp support
Date: Fri, 17 Apr 2020 18:08:23 +0200
Message-ID: <cover.1587139599.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4200

--===============6118507127044900866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This improves ip-mptcp help, addressing feedback from Mat.

Also includes ss man page update.

Davide Caratti (1):
  ss: allow dumping MPTCP subflow information

Paolo Abeni (3):
  uapi: update linux/mptcp.h
  add support for mptcp netlink interface
  man: mptcp man page

 include/uapi/linux/mptcp.h |  89 ++++++++
 ip/Makefile                |   2 +-
 ip/ip.c                    |   3 +-
 ip/ip_common.h             |   1 +
 ip/ipmptcp.c               | 436 +++++++++++++++++++++++++++++++++++++
 man/man8/ip-mptcp.8        | 142 ++++++++++++
 man/man8/ss.8              |   5 +
 misc/ss.c                  |  62 ++++++
 8 files changed, 738 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 ip/ipmptcp.c
 create mode 100644 man/man8/ip-mptcp.8

-- =

2.21.1

--===============6118507127044900866==--
