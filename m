Content-Type: multipart/mixed; boundary="===============0886832412625693300=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Thu, 22 Feb 2018 15:49:52 -0800
Message-ID: <1519343401-19027-1-git-send-email-rao.shoaib@oracle.com>
X-Status: 
X-Keywords:                  
X-UID: 300

--===============0886832412625693300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Following patches modify TCP code to enable implementation of MPTCP. MPTCP =
implementation requires sharing of TCP code with minor modification here an=
d there. In order to keep the TCP code clean and easy to maintain, common c=
ode has been moved to new functions for use by both TCP and MPTCP. struct t=
cp_sock now has function pointers and based on the socket type (TCP/MPTCP) =
appropriate function is called.

A basic implementation of MPTCP that works with IPv4/IPv6 and supports join=
 has been tested based on these changes.

The changes are being submitted as an RFC to get feedback from the communit=
y and to start a discussion on how to move forward.

Rao Shoaib (9):
  Modify tcp structures to support function pointers
  Introduce MPTCP specific elements that will co-exist with TCP even
    when MPTCP is not compiled
  Introduce MPTCP specific elements that can be under #ifdef
    MPTCP_CONFIG
  Populate function pointers -- few (5) will be populated later
  Switch code to use function pointers
  Make TCP options processing abstract
  Restructure syncookie code to use pointers
  Restructure TCP code so that it can be shared primarily with MPTCP
  Add MPTCP specific code to core TCP code

 crypto/md5.c                    |   3 -
 include/crypto/md5.h            |   2 +
 include/linux/tcp.h             |  91 ++++++++++++
 include/net/inet_common.h       |   2 +
 include/net/inet_sock.h         |   6 +-
 include/net/net_namespace.h     |   6 +
 include/net/secure_seq.h        |   9 +-
 include/net/sock.h              |   1 +
 include/net/tcp.h               | 321 ++++++++++++++++++++++++++++++++++++=
++--
 include/net/tcp_states.h        |   4 +-
 include/net/transp_v6.h         |   3 -
 include/uapi/linux/bpf.h        |   4 +-
 include/uapi/linux/if.h         |   5 +
 include/uapi/linux/tcp.h        |   1 +
 net/core/secure_seq.c           |  70 +++++++++
 net/ipv4/af_inet.c              |  16 +-
 net/ipv4/inet_connection_sock.c |  17 ++-
 net/ipv4/ip_sockglue.c          |  20 +++
 net/ipv4/syncookies.c           | 112 ++++++++++----
 net/ipv4/tcp.c                  | 221 +++++++++++++++++++++------
 net/ipv4/tcp_input.c            | 195 ++++++++++++++----------
 net/ipv4/tcp_ipv4.c             | 112 ++++++++++----
 net/ipv4/tcp_minisocks.c        |  56 ++++++-
 net/ipv4/tcp_output.c           | 206 +++++++++++++++-----------
 net/ipv4/tcp_timer.c            |  55 +++++--
 net/ipv6/af_inet6.c             |   4 +-
 net/ipv6/ipv6_sockglue.c        |  14 ++
 net/ipv6/syncookies.c           |  40 +----
 net/ipv6/tcp_ipv6.c             | 163 +++++++++++++-------
 29 files changed, 1360 insertions(+), 399 deletions(-)

-- =

2.7.4


--===============0886832412625693300==--
