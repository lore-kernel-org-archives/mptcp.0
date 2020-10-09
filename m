Content-Type: multipart/mixed; boundary="===============2561320276874136737=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/2] mptcp: some fallback fixes
Date: Fri, 09 Oct 2020 18:59:59 +0200
Message-ID: <cover.1602262630.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6275

--===============2561320276874136737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pktdrill pointed-out we currently don't handle properly some
fallback scenario for MP_JOIN subflows

The first patch addresses such issue.

Patch 2/2 fixes a related pre-existing issue that is more
evident after 1/2: we could keep using for MPTCP signaling
closed subflows.

Paolo Abeni (2):
  mptcp: fix fallback for MP_JOIN subflows
  mptcp: subflows garbage collection

 net/mptcp/options.c  | 32 +++++++++++++++++++++++++-------
 net/mptcp/protocol.c | 17 +++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 16 ++++++++++++++--
 4 files changed, 58 insertions(+), 9 deletions(-)

-- =

2.26.2

--===============2561320276874136737==--
