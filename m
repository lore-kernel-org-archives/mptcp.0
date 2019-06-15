Content-Type: multipart/mixed; boundary="===============7467354106567418794=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:43 +0200
Message-ID: <20190615105259.15151-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1385

--===============7467354106567418794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches simply fix code style reported by checkpatch.pl without
modifying the behaviour of the code.

Here are a few points that might be interesting to expose / debate:

- Some warnings have *not* been fixed on purpose:
  - edition in "old" files (in.h, etc.) keeping the same code convension
  - the MAINTAINERS file has not been updated, we will do that later
  - line over 80 characters in shell scripts
  - missing commit description in:
    - mptcp: Add shutdown() socket operation
    - mptcp: Add setsockopt()/getsockopt() socket operations
  - one BUG_ON is in protocol.c, we might want to remove it
- Even if a few lines have been added and removed, I guess we should not
  add a signed-off with my name in all modified topics.

Matthieu Baerts (16):
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues
  mptcp: fix checkpatch issues

 .topmsg                                       |  9 +++++----
 include/net/mptcp.h                           | 10 +++++-----
 net/mptcp/crypto.c                            |  3 +--
 net/mptcp/options.c                           | 17 +++++++++--------
 net/mptcp/pm.c                                |  2 +-
 net/mptcp/protocol.c                          | 33 ++++++++++++++---------=
--
 net/mptcp/protocol.h                          | 15 ++++++++-------
 net/mptcp/subflow.c                           | 18 +++++++-----------
 net/mptcp/token.c                             | 29 ++++++++++++++---------=
------
 .../selftests/net/mptcp/mptcp_connect.c       | 86 ++++++++++++++++++++++-=
---------------
 .../selftests/net/mptcp/mptcp_connect.sh      |  1 +
 11 files changed, 119 insertions(+), 104 deletions(-)

-- =

2.20.1


--===============7467354106567418794==--
