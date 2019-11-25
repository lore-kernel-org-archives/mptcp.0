Content-Type: multipart/mixed; boundary="===============6658688789863385555=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/7] remove second conditional
Date: Mon, 25 Nov 2019 03:15:04 +0100
Message-ID: <20191125021508.29153-4-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2675

--===============6658688789863385555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Handle MP_CAPABLE options for outgoing connections

... there is no reason for this second conditional, one is enough.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f65c48a0069a..72e6950fbbc2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -901,7 +901,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *ssk =3D NULL;
 =

 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
@@ -909,15 +908,10 @@ static void mptcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 =

 	if (msk->subflow) {
-		ssk =3D msk->subflow;
+		sock_release(msk->subflow);
 		msk->subflow =3D NULL;
 	}
 =

-	if (ssk) {
-		pr_debug("subflow=3D%p", ssk->sk);
-		sock_release(ssk);
-	}
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		pr_debug("conn_list->subflow=3D%p", subflow);
 		sock_release(mptcp_subflow_tcp_socket(subflow));
-- =

2.23.0

--===============6658688789863385555==--
