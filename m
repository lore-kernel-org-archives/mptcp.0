Content-Type: multipart/mixed; boundary="===============2352161426516472904=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 11/16] mptcp: add mptcp_destroy_common
 helper
Date: Thu, 24 Sep 2020 08:29:57 +0800
Message-ID: <fcebccadfa3127e0f55103cc7ee4cd00841e2ea0.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6007

--===============2352161426516472904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper named mptcp_destroy_common containing the
shared code between mptcp_destroy() and mptcp_sock_destruct().

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 11 ++++++++---
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  4 +---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b53e55826975..34c037731f35 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2128,16 +2128,21 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
 	return newsk;
 }
 =

+void mptcp_destroy_common(struct mptcp_sock *msk)
+{
+	skb_rbtree_purge(&msk->out_of_order_queue);
+	mptcp_token_destroy(msk);
+	mptcp_pm_free_anno_list(msk);
+}
+
 static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	skb_rbtree_purge(&msk->out_of_order_queue);
-	mptcp_token_destroy(msk);
 	if (msk->cached_ext)
 		__skb_ext_put(msk->cached_ext);
 =

-	mptcp_pm_free_anno_list(msk);
+	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index df6cc94df1f7..db1e5de2fee7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,6 +408,7 @@ bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq);
+void mptcp_destroy_common(struct mptcp_sock *msk);
 =

 void __init mptcp_token_init(void);
 static inline void mptcp_token_init_request(struct request_sock *req)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a1fefc965e17..ac2b19993f1a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -435,9 +435,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 		sock_orphan(sk);
 	}
 =

-	skb_rbtree_purge(&mptcp_sk(sk)->out_of_order_queue);
-	mptcp_token_destroy(mptcp_sk(sk));
-	mptcp_pm_free_anno_list(mptcp_sk(sk));
+	mptcp_destroy_common(mptcp_sk(sk));
 	inet_sock_destruct(sk);
 }
 =

-- =

2.17.1

--===============2352161426516472904==--
