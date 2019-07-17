Content-Type: multipart/mixed; boundary="===============0178182465417016597=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/9] Fix locking in mptcp_finish_join.
Date: Wed, 17 Jul 2019 15:12:49 -0700
Message-ID: <20190717221256.7358-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1513

--===============0178182465417016597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lock was being taken on the subflow sock, not mptcp_sock.

squashto:  Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 9 +++++----
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a56085742cf7..1664a69c8e30 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -777,18 +777,19 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

-void mptcp_finish_join(struct sock *conn, struct sock *sk)
+void mptcp_finish_join(struct sock *sk)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
-	struct mptcp_sock *msk =3D mptcp_sk(conn);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
 =

 	local_bh_disable();
-	bh_lock_sock_nested(sk);
+	bh_lock_sock_nested(subflow->conn);
 	list_add_tail(&subflow->node, &msk->conn_list);
-	bh_unlock_sock(sk);
+	bh_unlock_sock(subflow->conn);
 	local_bh_enable();
+	inet_sk_state_store(sk, TCP_ESTABLISHED);
 }
 =

 bool mptcp_sk_is_subflow(const struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8c04774ea2ec..9d6b10e5479c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -210,7 +210,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

 void mptcp_finish_connect(struct sock *sk, int mp_capable);
-void mptcp_finish_join(struct sock *conn, struct sock *sk);
+void mptcp_finish_join(struct sock *sk);
 =

 void token_init(void);
 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fdc5aecab897..32652f7d1497 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -171,7 +171,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			if (token_new_join(child))
 				goto close_child;
 			else
-				mptcp_finish_join(ctx->conn, child);
+				mptcp_finish_join(child);
 		}
 	}
 =

-- =

2.17.2


--===============0178182465417016597==--
