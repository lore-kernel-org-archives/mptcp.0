Content-Type: multipart/mixed; boundary="===============1166133193122433034=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/3] mptcp: a bunch of fixes
Date: Wed, 09 Dec 2020 12:03:28 +0100
Message-ID: <cover.1607508810.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7096

--===============1166133193122433034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series includes a few fixes following-up the
recent code refactor for the MPTCP RX and TX paths.

Boundling them together, since the fixes are somewhat
related.

Paolo Abeni (3):
  mptcp: link MPC subflow into msk only after accept
  mptcp: plug subflow context memory leak
  mptcp: be careful on subflows shutdown

 net/mptcp/options.c  |  7 ++++++-
 net/mptcp/pm.c       |  8 +++++++-
 net/mptcp/protocol.c | 23 +++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 19 +++++++++++++------
 5 files changed, 48 insertions(+), 10 deletions(-)

-- =

2.26.2

--===============1166133193122433034==--
