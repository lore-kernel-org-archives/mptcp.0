Content-Type: multipart/mixed; boundary="===============4504629121771567344=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] mptcp: simplify crypto.c
Date: Thu, 11 Jul 2019 19:12:18 +0200
Message-ID: <cover.1562864862.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1486

--===============4504629121771567344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

his series wants to simplify, and hopefully improve, random generation
of keys and nonces in crypto.c, While at it, I removed some unneeded
#includes on top of the file. Any feedbacks are welcome!

Note:
 in case you think the code is ok, I will propose to squash it into
 commit 34f09d53931a ("mptcp: Add key generation and token tree")

Changes since RFC:
 - use get_random_bytes() instead of siphash, thanks to Florian / Mat =


Davide Caratti (2):
  net: mptcp: remove useless #includes in crypto.c
  net: mptcp: randomness improvements for crypto.c

 net/mptcp/crypto.c   | 77 +-------------------------------------------
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h | 11 -------
 net/mptcp/token.c    | 49 +++-------------------------
 4 files changed, 5 insertions(+), 133 deletions(-)

-- =

2.20.1


--===============4504629121771567344==--
