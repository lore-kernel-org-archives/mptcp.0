Content-Type: multipart/mixed; boundary="===============3829122210372782082=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 4/9] Populate function pointers -- few (5) will be
 populated later
Date: Thu, 22 Feb 2018 15:49:56 -0800
Message-ID: <1519343401-19027-5-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 304

--===============3829122210372782082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/net/tcp.h     | 33 ++++++++++++++++++++++++++-
 net/ipv4/tcp.c        | 62 +++++++++++++++++++++++++++++++++++++++++++++++=
+---
 net/ipv4/tcp_input.c  | 47 +++++++++++++++++++-------------------
 net/ipv4/tcp_output.c | 19 +++++++---------
 4 files changed, 122 insertions(+), 39 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9f7582..f952d97 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -560,14 +560,44 @@ void tcp_send_loss_probe(struct sock *sk);
 bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto);
 void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 			     const struct sk_buff *next_skb);
+u16 tcp_select_window(struct sock *sk);
+int select_size(const struct sock *sk, bool sg, bool first_skb, bool zc);
+bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
+		    int push_one, gfp_t gfp);
+void tcp_cwnd_validate(struct sock *sk, bool is_cwnd_limited);
+void tcp_connect_init(struct sock *sk);
+int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
+int tcp_mtu_probe(struct sock *sk);
+void tcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to, int spa=
ce);
 =

 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
 void tcp_reset(struct sock *sk);
+void tcp_set_rto(struct sock *sk);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *=
skb);
 void tcp_fin(struct sock *sk);
-
+bool tcp_should_expand_sndbuf(const struct sock *sk);
+bool tcp_prune_ofo_queue(struct sock *sk);
+
+void tcp_sndbuf_expand(struct sock *sk);
+void tcp_grow_window(struct sock *sk, const struct sk_buff *skb);
+int tcp_try_rmem_schedule(struct sock *sk, struct sk_buff *skb,
+			  unsigned int size);
+int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
+				  const struct tcphdr *th);
+struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
+				 struct sk_buff_head *list,
+				 struct rb_root *root);
+void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *th=
);
+struct sk_buff *tcp_shift_skb_data(struct sock *sk, struct sk_buff *skb,
+				   struct tcp_sacktag_state *state,
+				   u32 start_seq, u32 end_seq,
+				   bool dup_sack);
+bool tcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+		      struct sk_buff *from, bool *fragstolen);
+bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
+			     struct tcp_fastopen_cookie *cookie);
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
@@ -604,6 +634,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock=
 *tp, int pktsize)
 =

 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_cleanup_rbuf(struct sock *sk, int copied);
 =

 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 48636ae..a6ff25c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -399,6 +399,62 @@ static u64 tcp_compute_delivery_rate(const struct tcp_=
sock *tp)
 	return rate64;
 }
 =

+static bool tcp_can_send(struct sock *sk)
+{
+	bool ret =3D true;
+
+	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
+	    !tcp_passive_fastopen(sk))
+		ret =3D false;
+	return ret;
+}
+
+static const struct tcp_operational_ops __tcp_default_op_ops =3D {
+	.__select_window		=3D __tcp_select_window,
+	.select_window			=3D tcp_select_window,
+	.select_initial_window		=3D tcp_select_initial_window,
+	.select_size			=3D select_size,
+	.init_buffer_space		=3D tcp_init_buffer_space,
+	.set_rto			=3D tcp_set_rto,
+	.should_expand_sndbuf		=3D tcp_should_expand_sndbuf,
+	.send_fin			=3D tcp_send_fin,
+	.write_xmit			=3D tcp_write_xmit,
+	.send_active_reset		=3D tcp_send_active_reset,
+	.write_wakeup			=3D tcp_write_wakeup,
+	.prune_ofo_queue		=3D tcp_prune_ofo_queue,
+	.retransmit_timer		=3D tcp_retransmit_timer,
+	.time_wait			=3D tcp_time_wait,
+	.cleanup_rbuf			=3D tcp_cleanup_rbuf,
+	.cwnd_validate			=3D tcp_cwnd_validate,
+	.sndbuf_expand			=3D tcp_sndbuf_expand,
+	.shift_skb_data			=3D tcp_shift_skb_data,
+	.grow_window			=3D tcp_grow_window,
+	.try_coalesce			=3D tcp_try_coalesce,
+	.try_rmem_schedule		=3D tcp_try_rmem_schedule,
+	.collapse_one			=3D tcp_collapse_one,
+	.trim_head			=3D tcp_trim_head,
+	.urg				=3D tcp_urg,
+	.can_send			=3D tcp_can_send,
+	.connect_init			=3D tcp_connect_init,
+	.send_mss			=3D tcp_send_mss,
+	.mtu_probe			=3D tcp_mtu_probe,
+	.retrans_try_collapse		=3D tcp_retrans_try_collapse,
+	.fastopen_synack		=3D tcp_rcv_fastopen_synack,
+	.sendpage_locked		=3D tcp_sendpage_locked,
+	.get_cookie_sock		=3D tcp_get_cookie_sock,
+};
+
+struct tcp_operational_ops *tcp_default_op_ops =3D
+			    (struct tcp_operational_ops *)&__tcp_default_op_ops;
+
+const struct tcp_state_ops __tcp_default_state_ops =3D {
+	.rcv_state_process =3D tcp_rcv_state_process,
+	.synsent =3D tcp_rcv_synsent_state_process,
+};
+
+struct tcp_state_ops *tcp_default_state_ops =3D
+		      (struct tcp_state_ops *)&__tcp_default_state_ops;
+
 /* Address-family independent initialization for a tcp_sock.
  *
  * NOTE: A lot of things set to zero explicitly by call to
@@ -916,7 +972,7 @@ static unsigned int tcp_xmit_size_goal(struct sock *sk,=
 u32 mss_now,
 	return max(size_goal, mss_now);
 }
 =

-static int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
+int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 {
 	int mss_now;
 =

@@ -1102,7 +1158,7 @@ static int linear_payload_sz(bool first_skb)
 	return 0;
 }
 =

-static int select_size(const struct sock *sk, bool sg, bool first_skb, boo=
l zc)
+int select_size(const struct sock *sk, bool sg, bool first_skb, bool zc)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	int tmp =3D tp->mss_cache;
@@ -1547,7 +1603,7 @@ static int tcp_peek_sndq(struct sock *sk, struct msgh=
dr *msg, int len)
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void tcp_cleanup_rbuf(struct sock *sk, int copied)
+void tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	bool time_to_ack =3D false;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index be81be4..5d6eb58 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -293,7 +293,7 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock =
*tp, const struct tcphdr
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
  */
 =

-static void tcp_sndbuf_expand(struct sock *sk)
+void tcp_sndbuf_expand(struct sock *sk)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
@@ -367,7 +367,7 @@ static int __tcp_grow_window(const struct sock *sk, con=
st struct sk_buff *skb)
 	return 0;
 }
 =

-static void tcp_grow_window(struct sock *sk, const struct sk_buff *skb)
+void tcp_grow_window(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 =

@@ -803,7 +803,7 @@ static void tcp_update_pacing_rate(struct sock *sk)
 /* Calculate rto without backoff.  This is the second half of Van Jacobson=
's
  * routine referred to above.
  */
-static void tcp_set_rto(struct sock *sk)
+void tcp_set_rto(struct sock *sk)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	/* Old crap is replaced with new one. 8)
@@ -1333,10 +1333,10 @@ static int skb_can_shift(const struct sk_buff *skb)
 /* Try collapsing SACK blocks spanning across multiple skbs to a single
  * skb.
  */
-static struct sk_buff *tcp_shift_skb_data(struct sock *sk, struct sk_buff =
*skb,
-					  struct tcp_sacktag_state *state,
-					  u32 start_seq, u32 end_seq,
-					  bool dup_sack)
+struct sk_buff *tcp_shift_skb_data(struct sock *sk, struct sk_buff *skb,
+				   struct tcp_sacktag_state *state,
+				   u32 start_seq, u32 end_seq,
+				   bool dup_sack)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sk_buff *prev;
@@ -4259,10 +4259,10 @@ static void tcp_sack_remove(struct tcp_sock *tp)
  * Better try to coalesce them right now to avoid future collapses.
  * Returns true if caller should free @from instead of queueing it
  */
-static bool tcp_try_coalesce(struct sock *sk,
-			     struct sk_buff *to,
-			     struct sk_buff *from,
-			     bool *fragstolen)
+bool tcp_try_coalesce(struct sock *sk,
+		      struct sk_buff *to,
+		      struct sk_buff *from,
+		      bool *fragstolen)
 {
 	int delta;
 =

@@ -4350,11 +4350,10 @@ static void tcp_ofo_queue(struct sock *sk)
 	}
 }
 =

-static bool tcp_prune_ofo_queue(struct sock *sk);
 static int tcp_prune_queue(struct sock *sk);
 =

-static int tcp_try_rmem_schedule(struct sock *sk, struct sk_buff *skb,
-				 unsigned int size)
+int tcp_try_rmem_schedule(struct sock *sk, struct sk_buff *skb,
+			  unsigned int size)
 {
 	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
 	    !sk_rmem_schedule(sk, skb, size)) {
@@ -4681,9 +4680,9 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *s=
kb, struct sk_buff_head *li
 	return skb_rb_next(skb);
 }
 =

-static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *s=
kb,
-					struct sk_buff_head *list,
-					struct rb_root *root)
+struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
+				 struct sk_buff_head *list,
+				 struct rb_root *root)
 {
 	struct sk_buff *next =3D tcp_skb_next(skb, list);
 =

@@ -4868,7 +4867,7 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
  *
  * Return true if queue has shrunk.
  */
-static bool tcp_prune_ofo_queue(struct sock *sk)
+bool tcp_prune_ofo_queue(struct sock *sk)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct rb_node *node, *prev;
@@ -4950,7 +4949,7 @@ static int tcp_prune_queue(struct sock *sk)
 	return -1;
 }
 =

-static bool tcp_should_expand_sndbuf(const struct sock *sk)
+bool tcp_should_expand_sndbuf(const struct sock *sk)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 =

@@ -5124,7 +5123,7 @@ static void tcp_check_urg(struct sock *sk, const stru=
ct tcphdr *th)
 }
 =

 /* This is the 'fast' part of urgent handling. */
-static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcp=
hdr *th)
+void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *th)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 =

@@ -5502,8 +5501,8 @@ void tcp_finish_connect(struct sock *sk, struct sk_bu=
ff *skb)
 		tp->pred_flags =3D 0;
 }
 =

-static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synac=
k,
-				    struct tcp_fastopen_cookie *cookie)
+bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
+			     struct tcp_fastopen_cookie *cookie)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sk_buff *data =3D tp->syn_data ? tcp_rtx_queue_head(sk) : NULL;
@@ -5570,8 +5569,8 @@ static void smc_check_reset_syn(struct tcp_sock *tp)
 #endif
 }
 =

-static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *=
skb,
-					 const struct tcphdr *th)
+int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
+				  const struct tcphdr *th)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 777c8b5..9f5be16 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -45,9 +45,6 @@
 =

 #include <trace/events/tcp.h>
 =

-static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nona=
gle,
-			   int push_one, gfp_t gfp);
-
 /* Account for new data that has been sent to the network. */
 static void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb)
 {
@@ -245,7 +242,7 @@ EXPORT_SYMBOL(tcp_select_initial_window);
  * value can be stuffed directly into th->window for an outgoing
  * frame.
  */
-static u16 tcp_select_window(struct sock *sk)
+u16 tcp_select_window(struct sock *sk)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	u32 old_win =3D tp->rcv_wnd;
@@ -1621,7 +1618,7 @@ static void tcp_cwnd_application_limited(struct sock =
*sk)
 	tp->snd_cwnd_stamp =3D tcp_jiffies32;
 }
 =

-static void tcp_cwnd_validate(struct sock *sk, bool is_cwnd_limited)
+void tcp_cwnd_validate(struct sock *sk, bool is_cwnd_limited)
 {
 	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
 	struct tcp_sock *tp =3D tcp_sk(sk);
@@ -2025,7 +2022,7 @@ static inline void tcp_mtu_check_reprobe(struct sock =
*sk)
  *         1 if a probe was sent,
  *         -1 otherwise
  */
-static int tcp_mtu_probe(struct sock *sk)
+int tcp_mtu_probe(struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
@@ -2270,8 +2267,8 @@ void tcp_chrono_stop(struct sock *sk, const enum tcp_=
chrono type)
  * Returns true, if no segments are in flight and we have queued segments,
  * but cannot send anything now because of SWS or another problem.
  */
-static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nona=
gle,
-			   int push_one, gfp_t gfp)
+bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
+		    int push_one, gfp_t gfp)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sk_buff *skb;
@@ -2758,8 +2755,8 @@ static bool tcp_can_collapse(const struct sock *sk, c=
onst struct sk_buff *skb)
 /* Collapse packets in the retransmit queue to make to create
  * less packets on the wire. This is only done on retransmission.
  */
-static void tcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to,
-				     int space)
+void tcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to,
+			      int space)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct sk_buff *skb =3D to, *tmp;
@@ -3274,7 +3271,7 @@ static void tcp_ca_dst_init(struct sock *sk, const st=
ruct dst_entry *dst)
 }
 =

 /* Do all connect socket setups that can be done AF independent. */
-static void tcp_connect_init(struct sock *sk)
+void tcp_connect_init(struct sock *sk)
 {
 	const struct dst_entry *dst =3D __sk_dst_get(sk);
 	struct tcp_sock *tp =3D tcp_sk(sk);
-- =

2.7.4


--===============3829122210372782082==--
