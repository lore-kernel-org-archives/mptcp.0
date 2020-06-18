Content-Type: multipart/mixed; boundary="===============0563004443577420569=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/4] mptcp: fallback refactor follow-up
Date: Thu, 18 Jun 2020 12:55:17 +0200
Message-ID: <cover.1592477699.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4727

--===============0563004443577420569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series compraises a few followup to the fallback refactor patch.
Ideally, they should land into the export branch just after =

"mptcp: fallback in case of simultaneous connect" - except for patch 1/4

This a v2, as patch 2/4 is the new version of the already posted
"mptcp: check for plain TCP sock at accept time", including the changes
suggested by Mat (M.)

Paolo Abeni (4):
  Squash-to: "net: mptcp: improve fallback to TCP"
  mptcp: check for plain TCP sock at accept time
  mptcp: create first subflow at msk creation time
  mptcp: __mptcp_tcp_fallback() returns a struct sock

 net/mptcp/protocol.c | 156 +++++++++++--------------------------------
 1 file changed, 40 insertions(+), 116 deletions(-)

-- =

2.26.2

--===============0563004443577420569==--
