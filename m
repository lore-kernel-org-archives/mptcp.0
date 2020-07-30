Content-Type: multipart/mixed; boundary="===============3839397631811168191=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 06/10] mptcp: subflow: add
 mptcp_subflow_init_cookie_req helper
Date: Thu, 30 Jul 2020 02:12:37 +0200
Message-ID: <20200730001241.3037-7-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5378

--===============3839397631811168191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be used to initialize the mptcp request socket when a MP_CAPABLE
request was handled in syncookie mode, i.e. when a TCP ACK containing a
MP_CAPABLE option is a valid syncookie value.

Normally (non-cookie case), MPTCP will generate a unique 32 bit connection
ID and stores it in the MPTCP token storage to be able to retrieve the
mptcp socket for subflow joining.

In syncookie case, we do not want to store any state, so just generate the
unique ID and use it in the reply.

This means there is a small window where another connection could generate
the same token.

When Cookie ACK comes back, we check that the token has not been registered
in the mean time.  If it was, the connection needs to fall back to TCP.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/mptcp.h  | 10 +++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 50 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/token.c    | 26 +++++++++++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 76eb915bf91c..3525d2822abe 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -131,6 +131,9 @@ static inline bool mptcp_skb_can_collapse(const struct =
sk_buff *to,
 }
 =

 void mptcp_seq_show(struct seq_file *seq);
+int mptcp_subflow_init_cookie_req(struct request_sock *req,
+				  const struct sock *sk_listener,
+				  struct sk_buff *skb);
 #else
 =

 static inline void mptcp_init(void)
@@ -200,6 +203,13 @@ static inline bool mptcp_skb_can_collapse(const struct=
 sk_buff *to,
 =

 static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { }
 static inline void mptcp_seq_show(struct seq_file *seq) { }
+
+static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
+						const struct sock *sk_listener,
+						struct sk_buff *skb)
+{
+	return 0; /* TCP fallback */
+}
 #endif /* CONFIG_MPTCP */
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index beb34b8a5363..d76d3b40d69e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -400,6 +400,7 @@ void mptcp_token_destroy_request(struct request_sock *r=
eq);
 int mptcp_token_new_connect(struct sock *sk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
+bool mptcp_token_exists(u32 token);
 struct mptcp_sock *mptcp_token_get_sock(u32 token);
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_sl=
ot,
 					 long *s_num);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e9c7d97251e9..e21dd19c617e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -141,18 +141,31 @@ static void subflow_init_req(struct request_sock *req,
 	if (mp_opt.mp_capable && listener->request_mptcp) {
 		int err, retries =3D 4;
 =

+		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 again:
 		do {
 			get_random_bytes(&subflow_req->local_key, sizeof(subflow_req->local_key=
));
 		} while (subflow_req->local_key =3D=3D 0);
 =

+		if (unlikely(want_cookie)) {
+			mptcp_crypto_key_sha(subflow_req->local_key,
+					     &subflow_req->token,
+					     &subflow_req->idsn);
+			if (mptcp_token_exists(subflow_req->token)) {
+				if (retries-- > 0)
+					goto again;
+			} else {
+				subflow_req->mp_capable =3D 1;
+			}
+			return;
+		}
+
 		err =3D mptcp_token_new_request(req);
 		if (err =3D=3D 0)
 			subflow_req->mp_capable =3D 1;
 		else if (retries-- > 0)
 			goto again;
 =

-		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else if (mp_opt.mp_join && listener->request_mptcp) {
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		subflow_req->mp_join =3D 1;
@@ -166,6 +179,41 @@ static void subflow_init_req(struct request_sock *req,
 	}
 }
 =

+int mptcp_subflow_init_cookie_req(struct request_sock *req,
+				  const struct sock *sk_listener,
+				  struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
+	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
+	struct mptcp_options_received mp_opt;
+	int err;
+
+	err =3D __subflow_init_req(req, sk_listener);
+	if (err)
+		return err;
+
+	mptcp_get_options(skb, &mp_opt);
+
+	if (mp_opt.mp_capable && mp_opt.mp_join)
+		return -EINVAL;
+
+	if (mp_opt.mp_capable && listener->request_mptcp) {
+		if (mp_opt.sndr_key =3D=3D 0)
+			return -EINVAL;
+
+		subflow_req->local_key =3D mp_opt.rcvr_key;
+		err =3D mptcp_token_new_request(req);
+		if (err)
+			return err;
+
+		subflow_req->mp_capable =3D 1;
+		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq - 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mptcp_subflow_init_cookie_req);
+
 static void subflow_v4_init_req(struct request_sock *req,
 				const struct sock *sk_listener,
 				struct sk_buff *skb,
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f82410c54653..8b47c4bb1c6b 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -204,6 +204,32 @@ void mptcp_token_accept(struct mptcp_subflow_request_s=
ock *req,
 	spin_unlock_bh(&bucket->lock);
 }
 =

+bool mptcp_token_exists(u32 token)
+{
+	struct hlist_nulls_node *pos;
+	struct token_bucket *bucket;
+	struct mptcp_sock *msk;
+	struct sock *sk;
+
+	rcu_read_lock();
+	bucket =3D token_bucket(token);
+
+again:
+	sk_nulls_for_each_rcu(sk, pos, &bucket->msk_chain) {
+		msk =3D mptcp_sk(sk);
+		if (READ_ONCE(msk->token) =3D=3D token)
+			goto found;
+	}
+	if (get_nulls_value(pos) !=3D (token & token_mask))
+		goto again;
+
+	rcu_read_unlock();
+	return false;
+found:
+	rcu_read_unlock();
+	return true;
+}
+
 /**
  * mptcp_token_get_sock - retrieve mptcp connection sock using its token
  * @token: token of the mptcp connection to retrieve
-- =

2.26.2

--===============3839397631811168191==--
