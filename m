Content-Type: multipart/mixed; boundary="===============1932136961445325143=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/4] tcp: parse tcp options contained in reset
 packets
Date: Thu, 24 Sep 2020 16:35:05 +0200
Message-ID: <20200924143505.27641-5-fw@strlen.de>
In-Reply-To: 20200924143505.27641-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6028

--===============1932136961445325143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used to handle MPTCP_TCPRST suboption.

It allows an MPTCP receiver to learn more information when a subflow is
re-set.  The MPTCP_TCPRST option gives an error code (protocol error,
path too slow, middlebox interference detected, and so on).

This allows an MPTCP receiver to make a decision to reopen the subflow
at a later time, or even completely disable the path.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/tcp.h        |  2 +-
 net/ipv4/tcp_input.c     | 13 ++++++++-----
 net/ipv4/tcp_minisocks.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a981b5d60112..92eee154e2a3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -609,7 +609,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
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
index 8afa4af30fdc..0a10ba1df1a0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4206,10 +4206,13 @@ static inline bool tcp_sequence(const struct tcp_so=
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
@@ -5590,7 +5593,7 @@ static bool tcp_validate_incoming(struct sock *sk, st=
ruct sk_buff *skb,
 						  &tp->last_oow_ack_time))
 				tcp_send_dupack(sk, skb);
 		} else if (tcp_reset_check(sk, skb)) {
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 		}
 		goto discard;
 	}
@@ -5626,7 +5629,7 @@ static bool tcp_validate_incoming(struct sock *sk, st=
ruct sk_buff *skb,
 		}
 =

 		if (rst_seq_match)
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 		else {
 			/* Disable TFO if RST is out-of-order
 			 * and no data has been received
@@ -6059,7 +6062,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		 */
 =

 		if (th->rst) {
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 			goto discard;
 		}
 =

@@ -6501,7 +6504,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_=
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
index 56c306e3cd2f..12f2495f98df 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -802,7 +802,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
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

--===============1932136961445325143==--
