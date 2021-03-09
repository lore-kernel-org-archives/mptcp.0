Content-Type: multipart/mixed; boundary="===============7290587634024432674=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash-to: "mptcp: move sockopt function
 into a new file"
Date: Tue, 09 Mar 2021 11:47:05 +0100
Message-ID: <b984e1a9dda4a47ce1b2ed949434a290a50fcf18.1615286805.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 8081

--===============7290587634024432674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat noted I left over an helper function in protocol.c.
Just drop it.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 915cb1fc6bfb6..be6b318527497 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -90,16 +90,6 @@ static bool mptcp_is_tcpsk(struct sock *sk)
 	return false;
 }
 =

-static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
-{
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (likely(!__mptcp_check_fallback(msk)))
-		return NULL;
-
-	return msk->first;
-}
-
 static int __mptcp_socket_create(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-- =

2.26.2

--===============7290587634024432674==--
