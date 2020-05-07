Content-Type: multipart/mixed; boundary="===============6038868106420889594=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/2] mptcp: add new sock flag to deal with join
 subflows
Date: Thu, 07 May 2020 16:30:23 +0200
Message-ID: <15ff69f38804447b9f8ad111be549f2e67416420.1588861016.git.pabeni@redhat.com>
In-Reply-To: cover.1588861016.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4338

--===============6038868106420889594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MP_JOIN subflows must not land into the accept queue.
Currently tcp_check_req() calls an mptcp specific helper
to detect such scenario.

Such helper leverages the subflow context to check for
MP_JOIN subflows. We need to deal also with MP JOIN
failures, even when the subflow context is not available
due allocation failure.

A possible solution would be changing the syn_recv_sock()
signature to allow returning a more descriptive action/
error code and deal with that in tcp_check_req().

Since the above need is MPTCP specific, this patch instead
uses a TCP socket hole to add a MPTCP specific flag.
Such flag is used by the MPTCP syn_recv_sock() to tell
tcp_check_req() how to deal with the request socket.

This change is a no-op for !MPTCP build, and makes the
MPTCP code simpler. It allows also the next patch to deal
correctly with MP JOIN failure.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/linux/tcp.h      |  1 +
 include/net/mptcp.h      | 17 ++++++++++-------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/mptcp/protocol.c     |  7 -------
 net/mptcp/subflow.c      |  2 ++
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 4f8159e90ce1..f9a368d16953 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -384,6 +384,7 @@ struct tcp_sock {
 			   */
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool	is_mptcp;
+	bool	drop_req;
 #endif
 =

 #ifdef CONFIG_TCP_MD5SIG
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3bce2019e4da..99657f84d10a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -68,6 +68,11 @@ static inline bool rsk_is_mptcp(const struct request_soc=
k *req)
 	return tcp_rsk(req)->is_mptcp;
 }
 =

+static inline bool sk_drop_req(const struct sock *sk)
+{
+	return tcp_sk(sk)->is_mptcp && tcp_sk(sk)->drop_req;
+}
+
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
@@ -120,8 +125,6 @@ static inline bool mptcp_skb_can_collapse(const struct =
sk_buff *to,
 				 skb_ext_find(from, SKB_EXT_MPTCP));
 }
 =

-bool mptcp_sk_is_subflow(const struct sock *sk);
-
 void mptcp_seq_show(struct seq_file *seq);
 #else
 =

@@ -139,6 +142,11 @@ static inline bool rsk_is_mptcp(const struct request_s=
ock *req)
 	return false;
 }
 =

+static inline bool sk_drop_req(const struct sock *sk)
+{
+	return false;
+}
+
 static inline void mptcp_parse_option(const struct sk_buff *skb,
 				      const unsigned char *ptr, int opsize,
 				      struct tcp_options_received *opt_rx)
@@ -189,11 +197,6 @@ static inline bool mptcp_skb_can_collapse(const struct=
 sk_buff *to,
 	return true;
 }
 =

-static inline bool mptcp_sk_is_subflow(const struct sock *sk)
-{
-	return false;
-}
-
 static inline void mptcp_seq_show(struct seq_file *seq) { }
 #endif /* CONFIG_MPTCP */
 =

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7e40322cc5ec..ba7cfb22dc79 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -774,7 +774,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 	if (!child)
 		goto listen_overflow;
 =

-	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
+	if (own_req && sk_drop_req(child)) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		inet_csk_reqsk_queue_drop_and_put(sk, req);
 		return child;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f23016ed3f..a61e60e94137 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1638,13 +1638,6 @@ bool mptcp_finish_join(struct sock *sk)
 	return ret;
 }
 =

-bool mptcp_sk_is_subflow(const struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-
-	return subflow->mp_join =3D=3D 1;
-}
-
 static bool mptcp_memory_free(const struct sock *sk, int wake)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4931a29a6f08..0d735e5aeb0d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -500,6 +500,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			ctx->remote_key =3D mp_opt.sndr_key;
 			ctx->fully_established =3D mp_opt.mp_capable;
 			ctx->can_ack =3D mp_opt.mp_capable;
+			tcp_sk(child)->drop_req =3D false;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

@@ -512,6 +513,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 				goto close_child;
 =

 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
+			tcp_sk(child)->drop_req =3D true;
 		}
 	}
 =

-- =

2.21.1

--===============6038868106420889594==--
