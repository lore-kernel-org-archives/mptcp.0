Content-Type: multipart/mixed; boundary="===============7087432172580068162=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v3] mptcp: track window announced to peer
Date: Thu, 22 Oct 2020 23:27:38 +0200
Message-ID: <20201022212738.24258-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6409

--===============7087432172580068162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OoO handling attemtps to detect when packet is out-of-window by testing
current ack sequence and remaining space vs. sequence number.

This doesn't work reliably.  Store the highest allowed sequence number
that we've announced and use it to detect oow packets.

Do this when mptcp options get written to the packet (wire format).
For this to work we need to move the write_options call until after stack
selected a new tcp window.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 Changes in v3:
  - add a few line breaks
  - update rcvwnd even for non-dss packets

 include/net/mptcp.h   |  3 ++-
 net/ipv4/tcp_output.c | 11 +++++++----
 net/mptcp/options.c   | 22 +++++++++++++++++++++-
 net/mptcp/protocol.c  | 12 +++++++-----
 net/mptcp/protocol.h  |  1 +
 5 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6e706d838e4e..b6cf07143a8a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -88,7 +88,8 @@ bool mptcp_established_options(struct sock *sk, struct sk=
_buff *skb,
 			       struct mptcp_out_options *opts);
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 =

-void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
+void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
+			 struct mptcp_out_options *opts);
 =

 /* move the skb extension owership, with the assumption that 'to' is
  * newly allocated
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9abf5a0358d5..a127856ab7df 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -445,11 +445,12 @@ struct tcp_out_options {
 	struct mptcp_out_options mptcp;
 };
 =

-static void mptcp_options_write(__be32 *ptr, struct tcp_out_options *opts)
+static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp,
+				struct tcp_out_options *opts)
 {
 #if IS_ENABLED(CONFIG_MPTCP)
 	if (unlikely(OPTION_MPTCP & opts->options))
-		mptcp_write_options(ptr, &opts->mptcp);
+		mptcp_write_options(ptr, tp, &opts->mptcp);
 #endif
 }
 =

@@ -701,7 +702,7 @@ static void tcp_options_write(__be32 *ptr, struct tcp_s=
ock *tp,
 =

 	smc_options_write(ptr, &options);
 =

-	mptcp_options_write(ptr, opts);
+	mptcp_options_write(ptr, tp, opts);
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -1348,7 +1349,6 @@ static int __tcp_transmit_skb(struct sock *sk, struct=
 sk_buff *skb,
 		}
 	}
 =

-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
 		th->window      =3D htons(tcp_select_window(sk));
@@ -1359,6 +1359,9 @@ static int __tcp_transmit_skb(struct sock *sk, struct=
 sk_buff *skb,
 		 */
 		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
 	}
+
+	tcp_options_write((__be32 *)(th + 1), tp, &opts);
+
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
 	if (md5) {
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f2d1e27a2bc1..2e9f1c4ea008 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -991,7 +991,24 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb)
 	}
 }
 =

-void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
+static void mptcp_set_rwin(const struct tcp_sock *tp)
+{
+	const struct sock *ssk =3D (const struct sock *)tp;
+	const struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+	u64 ack_seq;
+
+	subflow =3D mptcp_subflow_ctx(ssk);
+	msk =3D mptcp_sk(subflow->conn);
+
+	ack_seq =3D READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+
+	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
+		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+}
+
+void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
+			 struct mptcp_out_options *opts)
 {
 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
@@ -1148,4 +1165,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 		}
 	}
+
+	if (tp)
+		mptcp_set_rwin(tp);
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6c131759f3e5..cd747696e7af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -168,19 +168,19 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
 	struct rb_node **p, *parent;
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
-	int space;
 =

 	seq =3D MPTCP_SKB_CB(skb)->map_seq;
 	end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
-	space =3D tcp_space(sk);
-	max_seq =3D space > 0 ? space + msk->ack_seq : msk->ack_seq;
+	max_seq =3D READ_ONCE(msk->rcv_wnd_sent);
 =

 	pr_debug("msk=3D%p seq=3D%llx limit=3D%llx empty=3D%d", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
-	if (after64(seq, max_seq)) {
+	if (after64(end_seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
-		pr_debug("oow by %ld", (unsigned long)seq - (unsigned long)max_seq);
+		pr_debug("oow by %lld, rcv_wnd_sent %llu\n",
+			 (unsigned long long)end_seq - (unsigned long)max_seq,
+			 (unsigned long long)msk->rcv_wnd_sent);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
@@ -2258,6 +2258,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
 		WRITE_ONCE(msk->ack_seq, ack_seq);
+		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	}
 =

 #if !IS_ENABLED(CONFIG_KASAN)
@@ -2567,6 +2568,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
+	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	atomic64_set(&msk->snd_una, msk->write_seq);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4c8dbe9236b..bf15c2fc0ba1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -211,6 +211,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		snd_nxt;
 	u64		ack_seq;
+	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	struct sock	*last_snd;
 	int		snd_burst;
-- =

2.26.2

--===============7087432172580068162==--
