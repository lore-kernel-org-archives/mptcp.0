Content-Type: multipart/mixed; boundary="===============7329141931044864754=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] mptcp: simplify crypto.c
Date: Tue, 23 Jul 2019 19:47:18 +0200
Message-ID: <cover.1563903620.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1546

--===============7329141931044864754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

his series wants to simplify, and hopefully improve, random generation
of keys and nonces in crypto.c, While at it, I removed some unneeded
#includes on top of the file. Any feedbacks are welcome!

Note:
 in case you think the code is ok, I will propose to squash it into
 commit a564283a1e38 ("mptcp: Add key generation and token tree")

Changes since v1:
 - add a comment that suggests use of hash to improve performance,
   thanks to Matthieu
 - remove useless #include <tcp.h>, thanks Mat =


Changes since RFC:
 - use get_random_bytes() instead of siphash, thanks to Florian / Mat =



Davide Caratti (2):
  net: mptcp: remove useless #includes in crypto.c
  net: mptcp: randomness improvements for crypto.c

 net/mptcp/crypto.c   | 76 --------------------------------------------
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h | 24 +++++++-------
 net/mptcp/token.c    | 54 ++++---------------------------
 4 files changed, 19 insertions(+), 136 deletions(-)

-- =

2.20.1


--===============7329141931044864754==--
