Content-Type: multipart/mixed; boundary="===============3367694979182091851=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 0/2] mptcp: simplify crypto.c
Date: Fri, 14 Jun 2019 22:57:06 +0200
Message-ID: <cover.1560544900.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1379

--===============3367694979182091851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this series wants to simplify, and hopefully improve, random generation
of keys and nonces in crypto.c, While at it, I removed some unneeded
#includes on top of the file. Any feedbacks are welcome!

Note:
 in case you think the code is ok, I will propose to squash it into
 commit 34f09d53931a ("mptcp: Add key generation and token tree")

Davide Caratti (2):
  net: mptcp: randomness improvements for crypto.c
  net: mptcp: remove useless #includes in crypto.c

 net/mptcp/crypto.c   | 51 +++++---------------------------------------
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h |  6 ------
 3 files changed, 5 insertions(+), 53 deletions(-)

-- =

2.20.1


--===============3367694979182091851==--
