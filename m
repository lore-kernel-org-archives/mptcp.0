Content-Type: multipart/mixed; boundary="===============5802433070626707294=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] mptcp: fix compilation errors without IPV6
Date: Thu, 17 Oct 2019 16:50:43 +0200
Message-ID: <20191017145047.8900-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2220

--===============5802433070626707294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I just checked the compilation without CONFIG_IPV6 and fixed what GCC was
complaining about. Nothing fancy.

v2:
  - fix coding style as suggested by Paolo
  - drop "mptcp:basic: check for v6 family" (Peter)

Matthieu Baerts (4):
  mptcp: fix compilation warning without IPV6
  mptcp: fix compilation error without IPV6
  mptcp:ipv6: fix code style
  mptcp:ipv6: fix code style

 net/mptcp/basic.c   |  6 ++++--
 net/mptcp/options.c | 10 +++++++---
 net/mptcp/pm.c      |  4 +++-
 3 files changed, 14 insertions(+), 6 deletions(-)

-- =

2.20.1

--===============5802433070626707294==--
