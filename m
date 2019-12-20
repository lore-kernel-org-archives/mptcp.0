Content-Type: multipart/mixed; boundary="===============0011361128935248082=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/4] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Fri, 20 Dec 2019 19:45:09 +0100
Message-ID: <f237a169874b5af7e35462c10d27e9ffb165f71b.1576867317.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3235

--===============0011361128935248082==
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

--===============0011361128935248082==--
