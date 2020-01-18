Content-Type: multipart/mixed; boundary="===============7434109319473810394=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Refine some comments
Date: Fri, 17 Jan 2020 17:44:31 -0800
Message-ID: <20200118014431.9925-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3421

--===============7434109319473810394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 9 ++++-----
 net/mptcp/subflow.c  | 5 ++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ed8f7afd43db..fe5f813b4c13 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -71,10 +71,9 @@ static struct socket *__mptcp_fallback_to_tcp(struct mpt=
cp_sock *msk,
 	return sock;
 }
 =

-/* if msk has a single subflow socket, and the mp_capable handshake is not
- * completed yet or has failed - that is, the socket is Not MP Capable,
- * returns it.
- * Otherwise returns NULL
+/* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
+ * completed yet or has failed, return the subflow socket.
+ * Otherwise return NULL.
  */
 static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 {
@@ -139,7 +138,7 @@ static struct socket *__mptcp_socket_create(struct mptc=
p_sock *msk, int state)
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
-	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
+	subflow->request_mptcp =3D 1;
 =

 set_state:
 	if (state !=3D MPTCP_SAME_STATE)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 34ccaa7bbacd..b36c72ba3dd8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -841,7 +841,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
 socket **new_sock)
 		return err;
 =

 	lock_sock(sf->sk);
-	/* kern socket do not acquire by default net ref, but TCP timer need it
+
+	/* kernel sockets do not by default acquire net ref, but TCP timer
+	 * needs it.
 	 */
 	sf->sk->sk_net_refcnt =3D 1;
 	get_net(net);
@@ -871,6 +873,7 @@ static struct mptcp_subflow_context *subflow_create_ctx=
(struct sock *sk,
 	ctx =3D kzalloc(sizeof(*ctx), priority);
 	if (!ctx)
 		return NULL;
+
 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	INIT_LIST_HEAD(&ctx->node);
 =

-- =

2.17.2

--===============7434109319473810394==--
