Content-Type: multipart/mixed; boundary="===============5002428579188022855=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-net-next 00/12] Code-removal out of
 mptcp-net-next
Date: Mon, 17 Dec 2018 17:37:56 -0800
Message-ID: <20181218013808.4819-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 926

--===============5002428579188022855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Series removing a lot of code out of mptcp-net-next.

Before:
$ git diff --shortstat  1464193107da..mptcp-net-next/master
 54 files changed, 14663 insertions(+), 375 deletions(-)

$ git diff --shortstat  1464193107da..HEAD
 50 files changed, 12286 insertions(+), 349 deletions(-)


v2: Some minor fixes - see notes in the sub-patches 4/12 and 12/12


Christoph Paasch (12):
  mptcp: Remove support for DSS-checksums
  mptcp: Remove some left-over cruft
  mptcp: Remove RPS-recording for flow-steering in MPTCP
  mptcp: Remove support for subflow-priorities (aka backup)
  mptcp: Remove support for sendpage()
  mptcp: Remove reinjection of data across subflows
  mptcp: Remove support for TCP SYN-cookies
  mptcp: Remove support for TCP Fast Open
  mptcp: Remove MPTCP-code out of do_ip_setsockopt
  mptcp: Remove scheduler-selection support
  mptcp: Remove ndiffports path manager
  mptcp: Make path-management no more a module nor selectable through
    socketops

 include/linux/tcp.h          |  15 +-
 include/net/mptcp.h          | 235 +++++++--------------
 include/net/netns/mptcp.h    |   8 +-
 include/net/tcp.h            |  13 +-
 include/uapi/linux/if.h      |   1 -
 include/uapi/linux/tcp.h     |   1 -
 net/core/dev.c               |   2 +-
 net/ipv4/Kconfig             |  19 --
 net/ipv4/af_inet.c           |   6 -
 net/ipv4/ip_sockglue.c       |  14 --
 net/ipv4/syncookies.c        |  47 +----
 net/ipv4/tcp.c               | 155 +-------------
 net/ipv4/tcp_fastopen.c      |  16 +-
 net/ipv4/tcp_input.c         |  29 +--
 net/ipv4/tcp_output.c        |   3 +-
 net/ipv6/syncookies.c        |  32 +--
 net/mptcp/Kconfig            |  81 --------
 net/mptcp/Makefile           |   5 +-
 net/mptcp/mptcp_ctrl.c       | 168 +--------------
 net/mptcp/mptcp_fullmesh.c   | 485 ++++++++-------------------------------=
----
 net/mptcp/mptcp_input.c      | 343 ++----------------------------
 net/mptcp/mptcp_ipv4.c       |  22 +-
 net/mptcp/mptcp_ipv6.c       |  22 +-
 net/mptcp/mptcp_ndiffports.c | 169 ---------------
 net/mptcp/mptcp_output.c     | 472 ++-------------------------------------=
--
 net/mptcp/mptcp_pm.c         | 226 --------------------
 net/mptcp/mptcp_sched.c      | 271 +++---------------------
 27 files changed, 270 insertions(+), 2590 deletions(-)
 delete mode 100644 net/mptcp/mptcp_ndiffports.c
 delete mode 100644 net/mptcp/mptcp_pm.c

-- =

2.16.2


--===============5002428579188022855==--
