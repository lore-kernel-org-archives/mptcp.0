Content-Type: multipart/mixed; boundary="===============4372385861675947717=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/2] mptcp: add
 mptcp_destroy_common helper
Date: Tue, 15 Sep 2020 15:36:36 +0800
Message-ID: <9ba28d5dc65283a21065f44816b9de1ab0ebcf6f.1600154343.git.geliangtang@gmail.com>
In-Reply-To: cover.1600154343.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5869

--===============4372385861675947717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper named mptcp_destroy_common containing the
shared code between mptcp_destroy() and mptcp_sock_destruct().

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  5 +----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b8aa02856b6..e85827519e0a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2151,17 +2151,22 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
 	return newsk;
 }
 =

+void mptcp_destroy_common(struct sock *sk)
+{
+	skb_rbtree_purge(&mptcp_sk(sk)->out_of_order_queue);
+	mptcp_token_destroy(mptcp_sk(sk));
+	mptcp_pm_free_anno_list(mptcp_sk(sk));
+	inet_sock_destruct(sk);
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
-	sk_sockets_allocated_dec(sk);
+	mptcp_destroy_common(sk);
 }
 =

 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index df6cc94df1f7..f87fa6ad445b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,6 +408,7 @@ bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq);
+void mptcp_destroy_common(struct sock *sk);
 =

 void __init mptcp_token_init(void);
 static inline void mptcp_token_init_request(struct request_sock *req)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 339f90e22269..e0d387a12eed 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -435,10 +435,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 		sock_orphan(sk);
 	}
 =

-	skb_rbtree_purge(&mptcp_sk(sk)->out_of_order_queue);
-	mptcp_token_destroy(mptcp_sk(sk));
-	mptcp_pm_free_anno_list(mptcp_sk(sk));
-	inet_sock_destruct(sk);
+	mptcp_destroy_common(sk);
 }
 =

 static void mptcp_force_close(struct sock *sk)
-- =

2.17.1

--===============4372385861675947717==--
