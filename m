Content-Type: multipart/mixed; boundary="===============6861100008640482905=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: Implement MPTCP receive path"
Date: Mon, 16 Dec 2019 22:29:56 +0100
Message-ID: <6c8a763ddc3d9110354a197ab9b1f0f2aace020e.1576531786.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3093

--===============6861100008640482905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

drop duplicate line indroduced by the 'Squash-to' commit.

Note: this will cause some conflict in v1 patches. Resolution
is trivial, howver the patches must be rebased on top of this
one.
---
 net/mptcp/protocol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ede654057ba..5b73a1ae0da9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -559,8 +559,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	subflow->map_subflow_seq =3D 1;
 	subflow->rel_write_seq =3D 1;
 =

-	subflow->rel_write_seq =3D 1;
-
 	/* the socket is not connected yet, no msk/subflow ops can access/race
 	 * accessing the field below
 	 */
-- =

2.21.0

--===============6861100008640482905==--
