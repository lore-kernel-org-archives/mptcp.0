Content-Type: multipart/mixed; boundary="===============6163817940083800653=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] kselftests: remove modif in framework + commit msg
Date: Fri, 13 Dec 2019 12:38:52 +0100
Message-ID: <20191213113854.1690771-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2929

--===============6163817940083800653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As discussed yesterday, better to remove the modifications we did in
the kselftest framework [1]. While looking at it, I propose to add more
details in the commit message.

[1] https://patchwork.kernel.org/patch/11204935/

Matthieu Baerts (2):
  Revert "selftests: settings: tests can be in subsubdirs"
  .topmsg: mptcp: add basic kselftest for mptcp

 .topmsg                                     | 18 ++++++++++++------
 tools/testing/selftests/kselftest/runner.sh |  2 +-
 2 files changed, 13 insertions(+), 7 deletions(-)

-- =

2.24.0

--===============6163817940083800653==--
