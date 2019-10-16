Content-Type: multipart/mixed; boundary="===============6339010918397824085=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: fix compilation without IPV6
Date: Wed, 16 Oct 2019 18:15:25 +0200
Message-ID: <20191016161528.4336-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2181

--===============6339010918397824085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I just checked the compilation without CONFIG_IPV6 and fixed what GCC was
complaining about. Nothing fancy.

Matthieu Baerts (3):
  mptcp: fix compilation warning without IPV6
  mptcp: fix compilation error without IPV6
  mptcp:basic: check for v6 family

 net/mptcp/basic.c   | 2 +-
 net/mptcp/options.c | 2 ++
 net/mptcp/pm.c      | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- =

2.20.1

--===============6339010918397824085==--
