Content-Type: multipart/mixed; boundary="===============8154981186625971525=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2] tcp: mptcp: use mptcp receive buffer
 space to select rcv window
Date: Thu, 19 Mar 2020 14:51:33 +0100
Message-ID: <20200319135133.13825-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3991

--===============8154981186625971525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In MPTCP, the receive windo is shared across all subflows, because it
refers to the mptcp-level sequence space.

This commit doesn't change choice of initial window for passive or active
connections.
While it would be possible to change those as well, this adds complexity
(especially when handling MP_JOIN requests).

However, the MPTCP RFC specifically says that a MPTCP sender
'MUST NOT use the RCV.WND field of a TCP segment at the connection level if
it does not also carry a DSS option with a Data ACK field.'

SYN/SYNACK packets do not carry a DSS option with a Data ACK field.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 This time without RFC.  I've addressed Erics comments, i.e.
 READ_ONCE annotation is gone and min_t() was moved around
 to avoid the duplication.

 include/net/mptcp.h   |  3 +++
 net/ipv4/tcp_output.c |  8 ++++++--
 net/mptcp/subflow.c   | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 7489f9267640..1ef4520f45c3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -66,6 +66,8 @@ static inline bool rsk_is_mptcp(const struct request_sock=
 *req)
 	return tcp_rsk(req)->is_mptcp;
 }
 =

+void mptcp_space(const struct sock *ssk, int *space, int *full_space);
+
 void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *pt=
r,
 			int opsize, struct tcp_options_received *opt_rx);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
@@ -195,6 +197,7 @@ static inline bool mptcp_sk_is_subflow(const struct soc=
k *sk)
 	return false;
 }
 =

+static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { }
 static inline void mptcp_seq_show(struct seq_file *seq) { }
 #endif /* CONFIG_MPTCP */
 =

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 306e25d743e8..d38cf5e75823 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2768,8 +2768,12 @@ u32 __tcp_select_window(struct sock *sk)
 	int mss =3D icsk->icsk_ack.rcv_mss;
 	int free_space =3D tcp_space(sk);
 	int allowed_space =3D tcp_full_space(sk);
-	int full_space =3D min_t(int, tp->window_clamp, allowed_space);
-	int window;
+	int full_space, window;
+
+	if (sk_is_mptcp(sk))
+		mptcp_space(sk, &free_space, &allowed_space);
+
+	full_space =3D min_t(int, tp->window_clamp, allowed_space);
 =

 	if (unlikely(mss > full_space)) {
 		mss =3D full_space;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 40ad7995b13b..8cce26dc0bce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -745,6 +745,24 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	return subflow->data_avail;
 }
 =

+/* If ssk has an mptcp parent socket, use the mptcp rcvbuf occupancy,
+ * not the ssk one.
+ *
+ * In mptcp, rwin is about the mptcp-level connection data.
+ *
+ * Data that is still on the ssk rx queue can thus be ignored,
+ * as far as mptcp peer is concerened that data is still inflight.
+ * DSS ACK is updated when skb is moved to the mptcp rx queue.
+ */
+void mptcp_space(const struct sock *ssk, int *space, int *full_space)
+{
+	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	const struct sock *sk =3D subflow->conn;
+
+	*space =3D tcp_space(sk);
+	*full_space =3D tcp_full_space(sk);
+}
+
 static void subflow_data_ready(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-- =

2.24.1

--===============8154981186625971525==--
