Content-Type: multipart/mixed; boundary="===============1092149687154191299=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/3] tcp: parse mptcp options contained in
 reset packets
Date: Wed, 25 Nov 2020 18:49:55 +0100
Message-ID: <20201125174956.9222-3-fw@strlen.de>
In-Reply-To: 20201125174956.9222-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6933

--===============1092149687154191299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because TCP-level resets only affect the subflow, there is a MPTCP
option to indicate that the MPTCP-level connection should be closed
immediately without a mptcp-level fin exchange.

This is the 'MPTCP fast close option'.  It can be carried on ack
segments or TCP resets.  In the latter case, its needed to parse mptcp
options also for reset packets so that MPTCP can act accordingly.

Next patch will add receive side fastclose support in MPTCP.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/tcp.h        |  2 +-
 net/ipv4/tcp_input.c     | 13 ++++++++-----
 net/ipv4/tcp_minisocks.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d5d22c411918..be105a5be4ba 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -610,7 +610,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
-void tcp_reset(struct sock *sk);
+void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *=
skb);
 void tcp_fin(struct sock *sk);
 =

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fb3a7750f623..fb65d3519439 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4217,10 +4217,13 @@ static inline bool tcp_sequence(const struct tcp_so=
ck *tp, u32 seq, u32 end_seq)
 }
 =

 /* When we get a reset we do this. */
-void tcp_reset(struct sock *sk)
+void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
 	trace_tcp_receive_reset(sk);
 =

+	if (sk_is_mptcp(sk))
+		mptcp_incoming_options(sk, skb);
+
 	/* We want the right error as BSD sees it (and indeed as we do). */
 	switch (sk->sk_state) {
 	case TCP_SYN_SENT:
@@ -5603,7 +5606,7 @@ static bool tcp_validate_incoming(struct sock *sk, st=
ruct sk_buff *skb,
 						  &tp->last_oow_ack_time))
 				tcp_send_dupack(sk, skb);
 		} else if (tcp_reset_check(sk, skb)) {
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 		}
 		goto discard;
 	}
@@ -5639,7 +5642,7 @@ static bool tcp_validate_incoming(struct sock *sk, st=
ruct sk_buff *skb,
 		}
 =

 		if (rst_seq_match)
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 		else {
 			/* Disable TFO if RST is out-of-order
 			 * and no data has been received
@@ -6076,7 +6079,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		 */
 =

 		if (th->rst) {
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 			goto discard;
 		}
 =

@@ -6518,7 +6521,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_=
buff *skb)
 			if (TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq &&
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-				tcp_reset(sk);
+				tcp_reset(sk, skb);
 				return 1;
 			}
 		}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 495dda2449fe..0055ae0a3bf8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -801,7 +801,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 		req->rsk_ops->send_reset(sk, skb);
 	} else if (fastopen) { /* received a valid RST pkt */
 		reqsk_fastopen_remove(sk, req, true);
-		tcp_reset(sk);
+		tcp_reset(sk, skb);
 	}
 	if (!fastopen) {
 		inet_csk_reqsk_queue_drop(sk, req);
-- =

2.26.2

--===============1092149687154191299==--
