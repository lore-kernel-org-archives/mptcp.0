Content-Type: multipart/mixed; boundary="===============4361621373956135809=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 07/11] mptcp: subflow: add
 mptcp_subflow_init_cookie_req helper
Date: Tue, 14 Jul 2020 20:25:10 +0200
Message-ID: <20200714182514.25250-8-fw@strlen.de>
In-Reply-To: 20200714182514.25250-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5004

--===============4361621373956135809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be used to initialize the mptcp request socket when a
MP_CAPABLE request was handled in syncookie mode, i.e. when a
TCP ACK containing a MP_CAPABLE option is a valid syncookie value.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/linux/tcp.h |  1 +
 include/net/mptcp.h | 10 +++++++++
 net/mptcp/subflow.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3bdec31ce8f4..1f706157b551 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -118,6 +118,7 @@ struct tcp_request_sock {
 	struct inet_request_sock 	req;
 	const struct tcp_request_sock_ops *af_specific;
 	u64				snt_synack; /* first SYNACK sent time */
+	u8				syncookie:1;
 	bool				tfo_listener;
 	bool				is_mptcp;
 #if IS_ENABLED(CONFIG_MPTCP)
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 985344512f31..653acfe58d04 100644
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
@@ -204,6 +207,13 @@ static inline bool mptcp_skb_can_collapse(const struct=
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
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cc9eaec14037..943fa650f1e9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -154,6 +154,20 @@ static void subflow_init_req(struct request_sock *req,
 			get_random_bytes(&subflow_req->local_key, sizeof(subflow_req->local_key=
));
 		} while (subflow_req->local_key =3D=3D 0);
 =

+		if (unlikely(tcp_rsk(req)->syncookie)) {
+			mptcp_crypto_key_sha(subflow_req->local_key,
+					     &subflow_req->token,
+					     &subflow_req->idsn);
+			if (mptcp_token_get_sock(subflow_req->token)) {
+				if (retries-- > 0)
+					goto again;
+			} else {
+				subflow_req->mp_capable =3D 1;
+			}
+			subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
+			return;
+		}
+
 		err =3D mptcp_token_new_request(req);
 		if (err =3D=3D 0)
 			subflow_req->mp_capable =3D 1;
@@ -174,6 +188,45 @@ static void subflow_init_req(struct request_sock *req,
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
+	int ret;
+
+	ret =3D __subflow_init_req(req, sk_listener);
+	if (ret)
+		return ret;
+
+	mptcp_get_options(skb, &mp_opt);
+	ret =3D __subflow_check_options(&mp_opt, req);
+	if (ret)
+		return ret;
+
+	if (mp_opt.mp_capable && listener->request_mptcp) {
+		int err;
+
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
+	/* JOIN cannot be handled via cookies due to need
+	 * to store the remote peer nonce value.
+	 */
+
+	return 0;
+}
+
 static void subflow_v4_init_req(struct request_sock *req,
 				const struct sock *sk_listener,
 				struct sk_buff *skb)
-- =

2.26.2

--===============4361621373956135809==--
