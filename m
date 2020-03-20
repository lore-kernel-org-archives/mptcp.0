Content-Type: multipart/mixed; boundary="===============1211925495195017340=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 3/5] Squash-to: "mptcp: Add handling of incoming
 MP_JOIN requests"
Date: Fri, 20 Mar 2020 19:34:41 +0100
Message-ID: <09e4e68d2a32dedf5a021a9ecafa38cdb18bb788.1584728932.git.pabeni@redhat.com>
In-Reply-To: cover.1584728931.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4031

--===============1211925495195017340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop another unneeded check, and remote the paired, obsoleted
comment.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3d6000f98e69..df8184aba3e1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -661,8 +661,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 	subflow->can_ack =3D 1;
 =

 fully_established:
-	/* msk can be null for MPC subflow on passive socket */
-	if (subflow->pm_notified || !msk)
+	if (likely(subflow->pm_notified))
 		return true;
 =

 	subflow->pm_notified =3D 1;
-- =

2.21.1

--===============1211925495195017340==--
