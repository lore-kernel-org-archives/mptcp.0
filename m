Content-Type: multipart/mixed; boundary="===============1921889768468149283=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 6/7] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Thu, 09 Jan 2020 17:41:37 +0100
Message-ID: <81918d92317dc647dc7cc160b8ff76419f7b3871.1578586485.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3332

--===============1921889768468149283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now we can fully restore the subflow status on late tcp fallback

v1  -> v2:
 - use sk_is_mptcp() in __mptcp_needs_tcp_fallback() (Mat)

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d1f8e54068f..f6c6298857a4 100644
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
@@ -83,7 +83,7 @@ static struct socket *__mptcp_nmpc_socket(const struct mp=
tcp_sock *msk)
 =

 static bool __mptcp_needs_tcp_fallback(const struct mptcp_sock *msk)
 {
-	return msk->first && !tcp_sk(msk->first)->is_mptcp;
+	return msk->first && !sk_is_mptcp(msk->first);
 }
 =

 /* if the mp_capable handshake has failed, it fallbacks msk to plain TCP,
-- =

2.21.0

--===============1921889768468149283==--
