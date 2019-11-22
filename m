Content-Type: multipart/mixed; boundary="===============7953116423945524336=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] crypto: refactor sha code
Date: Fri, 22 Nov 2019 15:26:09 +0100
Message-ID: <cover.1574432261.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2660

--===============7953116423945524336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

patch 1/4 refactor the crypto code to make it easier transitioning to
sha256. It includes feedback from Peter about helper renaming.

The following patches update the rest of the tree to the new helper name.
Overall this should generate 3 conflicts along the rebase.

Paolo Abeni (1):
  crypto: refactor crypto helpers.

 net/mptcp/crypto.c   | 142 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  10 +--
 net/mptcp/token.c    |  10 +--
 3 files changed, 78 insertions(+), 84 deletions(-)

-- =

2.21.0

--===============7953116423945524336==--
