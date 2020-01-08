Content-Type: multipart/mixed; boundary="===============1661162110789105370=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 6/7] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Wed, 08 Jan 2020 15:47:23 +0100
Message-ID: <128ccc48923a56e937de32716cbb5a7b1bd123d5.1578487811.git.pabeni@redhat.com>
In-Reply-To: cover.1578487811.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3294

--===============1661162110789105370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now we can fully restore the subflow status on late tcp fallback

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71e82fd326c5..14c0bd79a534 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -52,10 +52,10 @@ static struct socket *__mptcp_fallback_to_tcp(struct mp=
tcp_sock *msk,
 	lock_sock(ssk);
 	sock_graft(ssk, sock);
 	if (subflow->conn) {
-		/* Clearing the 'conn' field will make the ULP-overriden
-		 * ops behaving like plain TCP ones.
-		 * Note: we can't release the ULP data on a live socket.
+		/* We can't release the ULP data on a live socket,
+		 * restore the tcp callback
 		 */
+		mptcp_subflow_tcp_fallback(ssk, subflow);
 		sock_put(subflow->conn);
 		subflow->conn =3D NULL;
 	}
-- =

2.21.0

--===============1661162110789105370==--
