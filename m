Content-Type: multipart/mixed; boundary="===============5048805443398374879=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] tcp: mptcp: use mptcp receive buffer space to select
 rcv window
Date: Thu, 12 Mar 2020 16:49:01 +0100
Message-ID: <20200312154901.540-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3937

--===============5048805443398374879==
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
 Unless there are comments i will post this as RFC to netdev and will
 CC Eric Dumazet.

 include/net/mptcp.h   | 13 +++++++++++++
 net/ipv4/tcp_output.c |  6 ++++++
 net/mptcp/subflow.c   | 24 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 7489f9267640..611a4d959470 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -66,6 +66,9 @@ static inline bool rsk_is_mptcp(const struct request_sock=
 *req)
 	return tcp_rsk(req)->is_mptcp;
 }
 =

+int mptcp_full_space(const struct sock *ssk);
+int mptcp_space(const struct sock *ssk);
+
 void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *pt=
r,
 			int opsize, struct tcp_options_received *opt_rx);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
@@ -195,6 +198,16 @@ static inline bool mptcp_sk_is_subflow(const struct so=
ck *sk)
 	return false;
 }
 =

+static inline int mptcp_space(struct sock *ssk)
+{
+	return 0;
+}
+
+static inline int mptcp_full_space(struct sock *ssk)
+{
+	return 0;
+}
+
 static inline void mptcp_seq_show(struct seq_file *seq) { }
 #endif /* CONFIG_MPTCP */
 =

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 306e25d743e8..b786da1db76a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2771,6 +2771,12 @@ u32 __tcp_select_window(struct sock *sk)
 	int full_space =3D min_t(int, tp->window_clamp, allowed_space);
 	int window;
 =

+	if (sk_is_mptcp(sk)) {
+		allowed_space =3D mptcp_full_space(sk);
+		free_space =3D mptcp_space(sk);
+		full_space =3D min_t(int, tp->window_clamp, allowed_space);
+	}
+
 	if (unlikely(mss > full_space)) {
 		mss =3D full_space;
 		if (mss <=3D 0)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f9fe60599f79..52d76af75b7f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -738,6 +738,30 @@ bool mptcp_subflow_data_available(struct sock *sk)
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
+ */
+int mptcp_full_space(const struct sock *ssk)
+{
+	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	const struct sock *sk =3D READ_ONCE(subflow->conn);
+
+	return sk ? tcp_full_space(sk) : tcp_full_space(ssk);
+}
+
+int mptcp_space(const struct sock *ssk)
+{
+	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	const struct sock *sk =3D READ_ONCE(subflow->conn);
+
+	return sk ? tcp_space(sk) : tcp_space(ssk);
+}
+
 static void subflow_data_ready(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-- =

2.24.1

--===============5048805443398374879==--
