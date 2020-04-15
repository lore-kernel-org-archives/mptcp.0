Content-Type: multipart/mixed; boundary="===============6173853070926160605=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] iproute: mptcp support
Date: Wed, 15 Apr 2020 14:28:52 +0200
Message-ID: <cover.1586953702.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4167

--===============6173853070926160605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This addresses the feedback from Davide, includes the 'ss' support - still
from Davide and also a very tentative man page.

Any feedback welcome!

Davide Caratti (1):
  ss: allow dumping MPTCP subflow information

Paolo Abeni (3):
  uapi: update linux/mptcp.h
  add support for mptcp netlink interface.
  man: mptcp man page

 include/uapi/linux/mptcp.h |  89 ++++++++
 ip/Makefile                |   2 +-
 ip/ip.c                    |   3 +-
 ip/ip_common.h             |   1 +
 ip/ipmptcp.c               | 449 +++++++++++++++++++++++++++++++++++++
 man/man8/ip-mptcp.8        | 142 ++++++++++++
 misc/ss.c                  |  62 +++++
 7 files changed, 746 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 ip/ipmptcp.c
 create mode 100644 man/man8/ip-mptcp.8

-- =

2.21.1

--===============6173853070926160605==--
