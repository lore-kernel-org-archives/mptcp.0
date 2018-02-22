Content-Type: multipart/mixed; boundary="===============7298709561918774481=="
MIME-Version: 1.0
From: rao.shoaib at oracle.com
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/9] Modify tcp structures to support function pointers
Date: Thu, 22 Feb 2018 15:49:53 -0800
Message-ID: <1519343401-19027-2-git-send-email-rao.shoaib@oracle.com>
In-Reply-To: 1519343401-19027-1-git-send-email-rao.shoaib@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 301

--===============7298709561918774481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rao Shoaib <rao.shoaib(a)oracle.com>

Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
---
 include/linux/tcp.h   |  13 +++++
 include/net/tcp.h     | 129 ++++++++++++++++++++++++++++++++++++++++++++++=
----
 net/ipv4/tcp_input.c  |  13 -----
 net/ipv4/tcp_output.c |  11 -----
 4 files changed, 133 insertions(+), 33 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 8f4c549..612360b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -83,6 +83,17 @@ struct tcp_sack_block {
 	u32	end_seq;
 };
 =

+struct tcp_out_options {
+	u16 options;		/* bit field of OPTION_* */
+	u16 mss;		/* 0 to disable */
+	u8 ws;			/* window scale, 0 to disable */
+	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 hash_size;		/* bytes in hash_location */
+	__u8 *hash_location;	/* temporary pointer, overloaded */
+	__u32 tsval, tsecr;	/* need to include OPTION_TS */
+	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+};
+
 /*These are used to set the sack_ok field in struct tcp_options_received */
 #define TCP_SACK_SEEN     (1 << 0)   /*1 =3D peer is SACK capable, */
 #define TCP_DSACK_SEEN    (1 << 2)   /*1 =3D DSACK was received from peer*/
@@ -384,6 +395,8 @@ struct tcp_sock {
 	 */
 	struct request_sock *fastopen_rsk;
 	u32	*saved_syn;
+	const struct tcp_operational_ops	*op_ops;
+	const struct tcp_state_ops		*state_ops;
 };
 =

 enum tsq_enum {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 92b06c6..8bc724f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -250,6 +250,17 @@ extern atomic_long_t tcp_memory_allocated;
 extern struct percpu_counter tcp_sockets_allocated;
 extern unsigned long tcp_memory_pressure;
 =

+enum tcp_synack_type {
+	TCP_SYNACK_NORMAL,
+	TCP_SYNACK_FASTOPEN,
+	TCP_SYNACK_COOKIE,
+};
+
+enum tcp_queue {
+	TCP_FRAG_IN_WRITE_QUEUE,
+	TCP_FRAG_IN_RTX_QUEUE,
+};
+
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
@@ -369,6 +380,18 @@ enum tcp_tw_status {
 	TCP_TW_SYN =3D 3
 };
 =

+struct tcp_sacktag_state {
+	u32     reord;
+	/* Timestamps for earliest and latest never-retransmitted segment
+	 * that was SACKed. RTO needs the earliest RTT to stay conservative,
+	 * but congestion control should still get an accurate delay signal.
+	 */
+	u64     first_sackt;
+	u64     last_sackt;
+	struct rate_sample *rate;
+	int     flag;
+	unsigned int mss_now;
+};
 =

 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *t=
w,
 					      struct sk_buff *skb,
@@ -427,11 +450,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *s=
k, struct sk_buff *skb,
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
-enum tcp_synack_type {
-	TCP_SYNACK_NORMAL,
-	TCP_SYNACK_FASTOPEN,
-	TCP_SYNACK_COOKIE,
-};
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *d=
st,
 				struct request_sock *req,
 				struct tcp_fastopen_cookie *foc,
@@ -522,10 +540,6 @@ void tcp_xmit_retransmit_queue(struct sock *);
 void tcp_simple_retransmit(struct sock *);
 void tcp_enter_recovery(struct sock *sk, bool ece_ack);
 int tcp_trim_head(struct sock *, struct sk_buff *, u32);
-enum tcp_queue {
-	TCP_FRAG_IN_WRITE_QUEUE,
-	TCP_FRAG_IN_RTX_QUEUE,
-};
 int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 		 struct sk_buff *skb, u32 len,
 		 unsigned int mss_now, gfp_t gfp);
@@ -1822,6 +1836,103 @@ struct tcp_sock_af_ops {
 #endif
 };
 =

+/* TCP operational functions */
+struct tcp_operational_ops {
+	u32 (*__select_window)(struct sock *sk);
+	u16 (*select_window)(struct sock *sk);
+	void (*select_initial_window)(const struct sock *sk,
+				      int __space, __u32 mss, __u32 *rcv_wnd,
+				      __u32 *window_clamp, int wscale_ok,
+				      __u8 *rcv_wscale, __u32 init_rcv_wnd);
+	int (*select_size)(const struct sock *sk, bool sg,
+			   bool first_skb, bool zc);
+	void (*init_buffer_space)(struct sock *sk);
+	void (*set_rto)(struct sock *sk);
+	bool (*should_expand_sndbuf)(const struct sock *sk);
+	void (*send_fin)(struct sock *sk);
+	bool (*write_xmit)(struct sock *sk, unsigned int mss_now, int nonagle,
+			   int push_one, gfp_t gfp);
+	void (*send_active_reset)(struct sock *sk, gfp_t priority);
+	int (*write_wakeup)(struct sock *sk, int mib);
+	bool (*prune_ofo_queue)(struct sock *sk);
+	void (*retransmit_timer)(struct sock *sk);
+	void (*time_wait)(struct sock *sk, int state, int timeo);
+	void (*cleanup_rbuf)(struct sock *sk, int copied);
+	void (*cwnd_validate)(struct sock *sk, bool is_cwnd_limited);
+	void (*sndbuf_expand)(struct sock *sk);
+	struct sk_buff *(*shift_skb_data)(struct sock *sk, struct sk_buff *skb,
+					  struct tcp_sacktag_state *state,
+					  u32 start_seq, u32 end_seq,
+					  bool dup_sack);
+	void (*grow_window)(struct sock *sk, const struct sk_buff *skb);
+	bool (*check_rtt)(struct sock *sk);
+	bool (*try_coalesce)(struct sock *sk, struct sk_buff *to,
+			     struct sk_buff *from,
+			     bool *fragstolen);
+	int (*try_rmem_schedule)(struct sock *sk, struct sk_buff *skb,
+				 unsigned int size);
+	struct sk_buff *(*collapse_one)(struct sock *sk, struct sk_buff *skb,
+					struct sk_buff_head *list,
+					struct rb_root *root);
+	void (*urg)(struct sock *sk, struct sk_buff *skb,
+		    const struct tcphdr *th);
+	int (*trim_head)(struct sock *sk, struct sk_buff *skb, u32 len);
+	/* MPTCP wants certain skb's that may be dropped, to process options */
+	void (*ack_only)(struct sock *sk, struct sk_buff *skb);
+	bool (*can_send)(struct sock *sk);
+	int (*rx)(struct sock *sk, struct sk_buff *skb, int refcounted);
+	unsigned int (*synack_options_size)(const struct sock *sk,
+					    struct request_sock *req,
+					    unsigned int mss,
+					    struct sk_buff *skb,
+					    struct tcp_out_options *opts,
+					    const struct tcp_md5sig_key *md5,
+					    struct tcp_fastopen_cookie *foc);
+	int (*options_size)(struct sock *sk, struct sk_buff *skb,
+			    struct tcp_out_options *opts,
+			    struct tcp_md5sig_key **md5);
+	void (*options_write)(__be32 **ptr_ptr, struct tcp_sock *tp,
+			      struct tcp_out_options *opts,
+			      struct sk_buff *skb);
+	void (*connect_init)(struct sock *sk);
+	void (*sock_init)(struct sock *sk);
+	int (*send_mss)(struct sock *sk, int *size_goal, int flags);
+	int (*mtu_probe)(struct sock *sk);
+	void (*retrans_try_collapse)(struct sock *sk, struct sk_buff *to,
+				     int space);
+	bool (*fastopen_synack)(struct sock *sk, struct sk_buff *synack,
+				struct tcp_fastopen_cookie *cookie);
+	int (*sendpage_locked)(struct sock *sk, struct page *page, int offset,
+			       size_t size, int flags);
+	struct request_sock *(*cookie_req_alloc)(struct sock *sk,
+						 struct sk_buff *skb,
+						 struct tcp_options_received *
+						 tcp_opts,
+						 __u32 cookie, int mss);
+	struct sock *(*get_cookie_sock)(struct sock *sk, struct sk_buff *skb,
+					struct request_sock *req,
+					struct dst_entry *dst, u32 tsoff);
+};
+
+/*
+ * Pointers to state specific TCP functions
+ */
+struct tcp_state_ops {
+	int (*rcv_state_process)(struct sock *sk, struct sk_buff *skb);
+	int (*close)(struct sock *sk, struct sk_buff *skb);
+	int (*synsent)(struct sock *sk, struct sk_buff *skb,
+		       const struct tcphdr *th);
+	int (*listen)(struct sock *sk, struct sk_buff *skb);
+	int (*synrcv)(struct sock *sk, struct sk_buff *skb);
+	int (*finwait1)(struct sock *sk, struct sk_buff *skb);
+	int (*finwait2)(struct sock *sk, struct sk_buff *skb);
+	int (*established)(struct sock *sk, struct sk_buff *skb);
+	int (*closewait)(struct sock *sk, struct sk_buff *skb);
+};
+
+extern struct tcp_operational_ops *tcp_default_op_ops;
+extern struct tcp_state_ops *tcp_default_state_ops;
+
 struct tcp_request_sock_ops {
 	u16 mss_clamp;
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a6b48f6..be81be4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1093,19 +1093,6 @@ static bool tcp_check_dsack(struct sock *sk, const s=
truct sk_buff *ack_skb,
 	return dup_sack;
 }
 =

-struct tcp_sacktag_state {
-	u32	reord;
-	/* Timestamps for earliest and latest never-retransmitted segment
-	 * that was SACKed. RTO needs the earliest RTT to stay conservative,
-	 * but congestion control should still get an accurate delay signal.
-	 */
-	u64	first_sackt;
-	u64	last_sackt;
-	struct rate_sample *rate;
-	int	flag;
-	unsigned int mss_now;
-};
-
 /* Check if skb is fully within the SACK block. In presence of GSO skbs,
  * the incoming SACK may not exactly match but we can find smaller MSS
  * aligned portion of it that matches. Therefore we might need to fragment
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e9f985e..777c8b5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -420,17 +420,6 @@ static void smc_options_write(__be32 *ptr, u16 *option=
s)
 #endif
 }
 =

-struct tcp_out_options {
-	u16 options;		/* bit field of OPTION_* */
-	u16 mss;		/* 0 to disable */
-	u8 ws;			/* window scale, 0 to disable */
-	u8 num_sack_blocks;	/* number of SACK blocks to include */
-	u8 hash_size;		/* bytes in hash_location */
-	__u8 *hash_location;	/* temporary pointer, overloaded */
-	__u32 tsval, tsecr;	/* need to include OPTION_TS */
-	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
-};
-
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
-- =

2.7.4


--===============7298709561918774481==--
