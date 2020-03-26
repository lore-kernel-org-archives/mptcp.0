Content-Type: multipart/mixed; boundary="===============5778461583184532651=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/2] iproute: mptcp support
Date: Thu, 26 Mar 2020 16:03:02 +0100
Message-ID: <cover.1585234717.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4078

--===============5778461583184532651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the first draft for iproute support.

Still lack a man-page (help more than welcome!!!)

Any feedback on [sub]commands name and syntax more than welcome - please
have a look at the usage() section in patch 2

Paolo Abeni (2):
  uapi: update linux/mptcp.h
  add support for mptcp netlink interface.

 include/uapi/linux/mptcp.h |  88 ++++++++
 ip/Makefile                |   2 +-
 ip/ip.c                    |   3 +-
 ip/ip_common.h             |   1 +
 ip/ipmptcp.c               | 446 +++++++++++++++++++++++++++++++++++++
 5 files changed, 538 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 ip/ipmptcp.c

-- =

2.21.1

--===============5778461583184532651==--
