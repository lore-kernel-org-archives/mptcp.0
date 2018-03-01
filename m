Content-Type: multipart/mixed; boundary="===============5152689517422467274=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/1] MPTCP Changes
Date: Wed, 28 Feb 2018 16:49:51 -0800
Message-ID: <1519865392-10321-1-git-send-email-rao.shoaib@oracle.com>
X-Status: 
X-Keywords:                  
X-UID: 329

--===============5152689517422467274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

This patch includes MPTCP code that works in conjuction with the previously=
 posted TCP patches.

This is a prototype. IPv4, IPv6 and join has been tested. Join was tested u=
sing ndiff ports. Join to a non listener socket is currently not supported.

The original code had a lot of style issues, some have been fixed but there=
 are quite a few remaining

Rao Shoaib (1):
  Add MPTCP code to work with the modified TCP code

 include/net/mptcp.h          | 1474 +++++++++++++++++++++
 include/net/mptcp_v4.h       |   56 +
 include/net/mptcp_v6.h       |   56 +
 include/net/netns/mptcp.h    |   52 +
 net/Kconfig                  |    1 +
 net/Makefile                 |    1 +
 net/mptcp/Kconfig            |  129 ++
 net/mptcp/Makefile           |   22 +
 net/mptcp/mptcp_balia.c      |  267 ++++
 net/mptcp/mptcp_binder.c     |  487 +++++++
 net/mptcp/mptcp_coupled.c    |  270 ++++
 net/mptcp/mptcp_ctrl.c       | 2981 ++++++++++++++++++++++++++++++++++++++=
++++
 net/mptcp/mptcp_fullmesh.c   | 1877 ++++++++++++++++++++++++++
 net/mptcp/mptcp_input.c      | 2970 ++++++++++++++++++++++++++++++++++++++=
+++
 net/mptcp/mptcp_ipv4.c       |  345 +++++
 net/mptcp/mptcp_ipv6.c       |  316 +++++
 net/mptcp/mptcp_ndiffports.c |  169 +++
 net/mptcp/mptcp_ofo_queue.c  |  177 +++
 net/mptcp/mptcp_olia.c       |  309 +++++
 net/mptcp/mptcp_output.c     | 1837 ++++++++++++++++++++++++++
 net/mptcp/mptcp_pm.c         |  178 +++
 net/mptcp/mptcp_redundant.c  |  268 ++++
 net/mptcp/mptcp_rr.c         |  301 +++++
 net/mptcp/mptcp_sched.c      |  597 +++++++++
 net/mptcp/mptcp_wvegas.c     |  268 ++++
 25 files changed, 15408 insertions(+)
 create mode 100644 include/net/mptcp.h
 create mode 100644 include/net/mptcp_v4.h
 create mode 100644 include/net/mptcp_v6.h
 create mode 100644 include/net/netns/mptcp.h
 create mode 100644 net/mptcp/Kconfig
 create mode 100644 net/mptcp/Makefile
 create mode 100644 net/mptcp/mptcp_balia.c
 create mode 100644 net/mptcp/mptcp_binder.c
 create mode 100644 net/mptcp/mptcp_coupled.c
 create mode 100644 net/mptcp/mptcp_ctrl.c
 create mode 100644 net/mptcp/mptcp_fullmesh.c
 create mode 100644 net/mptcp/mptcp_input.c
 create mode 100644 net/mptcp/mptcp_ipv4.c
 create mode 100644 net/mptcp/mptcp_ipv6.c
 create mode 100644 net/mptcp/mptcp_ndiffports.c
 create mode 100644 net/mptcp/mptcp_ofo_queue.c
 create mode 100644 net/mptcp/mptcp_olia.c
 create mode 100644 net/mptcp/mptcp_output.c
 create mode 100644 net/mptcp/mptcp_pm.c
 create mode 100644 net/mptcp/mptcp_redundant.c
 create mode 100644 net/mptcp/mptcp_rr.c
 create mode 100644 net/mptcp/mptcp_sched.c
 create mode 100644 net/mptcp/mptcp_wvegas.c

-- =

2.7.4


--===============5152689517422467274==--
