Content-Type: multipart/mixed; boundary="===============0801535228252425695=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 09/25] tcp: Register handlers for extra TCP options
Date: Mon, 27 Nov 2017 21:57:10 -0800
Message-ID: <20171128055726.430-10-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 185

--===============0801535228252425695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Allow additional TCP options to be handled by registered hook
functions.

Registered options have a priority that determines the order in which
options are prepared and written. Lower priority numbers are handled
first.

Option parsing will call the provided 'parse' function when a TCP option
number is not recognized by the normal option parsing code.

The 'prepare' function determines the required space for registered
options and store associated data. 'write' adds the option to the TCP
header.

A static key and RCU synchronization are used to minimize the
performance impact of these extensible TCP features.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    v2: * Merged my previous commits from v1 into this one
        * Moved rep.th.doff =3D arg.iov[0].iov_len / 4; to after the MD5-co=
de in tcp_v4_send_ack

 drivers/infiniband/hw/cxgb4/cm.c |   2 +-
 include/linux/tcp.h              |  24 +++++++
 include/net/tcp.h                |  46 +++++++++++-
 net/ipv4/syncookies.c            |   2 +-
 net/ipv4/tcp.c                   | 151 +++++++++++++++++++++++++++++++++++=
++++
 net/ipv4/tcp_input.c             |  16 +++--
 net/ipv4/tcp_ipv4.c              |  87 +++++++++++++++++-----
 net/ipv4/tcp_minisocks.c         |   7 +-
 net/ipv4/tcp_output.c            |  47 ++++++------
 net/ipv6/syncookies.c            |   2 +-
 net/ipv6/tcp_ipv6.c              |  18 +++++
 11 files changed, 351 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4=
/cm.c
index 21db3b48a617..a1ea5583f07b 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3746,7 +3746,7 @@ static void build_cpl_pass_accept_req(struct sk_buff =
*skb, int stid , u8 tos)
 	 */
 	memset(&tmp_opt, 0, sizeof(tmp_opt));
 	tcp_clear_options(&tmp_opt);
-	tcp_parse_options(&init_net, skb, &tmp_opt, 0, NULL);
+	tcp_parse_options(&init_net, skb, &tmp_opt, 0, NULL, NULL);
 =

 	req =3D __skb_push(skb, sizeof(*req));
 	memset(req, 0, sizeof(*req));
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index df5d97a85e1a..a2a1676dfc52 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -115,6 +115,25 @@ static inline void tcp_clear_options(struct tcp_option=
s_received *rx_opt)
 #endif
 }
 =

+#define OPTION_SACK_ADVERTISE	(1 << 0)
+#define OPTION_TS		(1 << 1)
+#define OPTION_MD5		(1 << 2)
+#define OPTION_WSCALE		(1 << 3)
+#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
+#define OPTION_SMC		(1 << 9)
+
+struct tcp_out_options {
+	u16 options;		/* bit field of OPTION_* */
+	u16 mss;		/* 0 to disable */
+	u8 ws;			/* window scale, 0 to disable */
+	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 hash_size;		/* bytes in hash_location */
+	__u8 *hash_location;	/* temporary pointer, overloaded */
+	__u32 tsval, tsecr;	/* need to include OPTION_TS */
+	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+	struct tcp_md5sig_key *md5; /* TCP_MD5 signature key */
+};
+
 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
  * to increase this, although since:
  *   size =3D TCPOLEN_SACK_BASE_ALIGNED (4) + n * TCPOLEN_SACK_PERBLOCK (8)
@@ -399,6 +418,11 @@ static inline struct tcp_sock *tcp_sk(const struct soc=
k *sk)
 	return (struct tcp_sock *)sk;
 }
 =

+static inline struct sock *tcp_to_sk(const struct tcp_sock *tp)
+{
+	return (struct sock *)tp;
+}
+
 struct tcp_timewait_sock {
 	struct inet_timewait_sock tw_sk;
 #define tw_rcv_nxt tw_sk.__tw_common.skc_tw_rcv_nxt
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4e09398009c1..fff0959dfd91 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -403,7 +403,8 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, si=
ze_t len, int nonblock,
 		int flags, int *addr_len);
 void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx,
-		       int estab, struct tcp_fastopen_cookie *foc);
+		       int estab, struct tcp_fastopen_cookie *foc,
+		       struct tcp_sock *tp);
 const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
 =

 /*
@@ -2063,4 +2064,47 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock =
*sk)
 #if IS_ENABLED(CONFIG_SMC)
 extern struct static_key_false tcp_have_smc;
 #endif
+
+extern struct static_key_false tcp_extra_options_enabled;
+
+struct tcp_extra_option_ops {
+	struct list_head	list;
+	unsigned char		option_kind;
+	unsigned char		priority;
+	void (*parse)(int opsize, const unsigned char *opptr,
+		      const struct sk_buff *skb,
+		      struct tcp_options_received *opt_rx,
+		      struct sock *sk);
+	/* Return the number of bytes consumed */
+	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
+				unsigned int remaining,
+				struct tcp_out_options *opts,
+				const struct sock *sk);
+	void (*write)(__be32 *ptr, struct sk_buff *skb,
+		      struct tcp_out_options *opts, const struct sock *sk);
+	int (*add_header_len)(const struct sock *listener,
+			      const struct sock *sk);
+	struct module		*owner;
+};
+
+void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
+			     const struct sk_buff *skb,
+			     struct tcp_options_received *opt_rx,
+			     struct sock *sk);
+
+unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
+				       unsigned int remaining,
+				       struct tcp_out_options *opts,
+				       const struct sock *sk);
+
+void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
+			     struct tcp_out_options *opts,
+			     const struct sock *sk);
+
+int tcp_extra_options_add_header(const struct sock *listener,
+				 const struct sock *sk);
+
+int tcp_register_extra_option(struct tcp_extra_option_ops *ops);
+void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops);
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fda37f2862c9..b3698ac3f078 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -313,7 +313,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
+	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, tp);
 =

 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff =3D secure_tcp_ts_off(sock_net(sk),
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bf97317e6c97..155bee4659fa 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -305,6 +305,13 @@ EXPORT_SYMBOL(tcp_have_smc);
 struct percpu_counter tcp_sockets_allocated;
 EXPORT_SYMBOL(tcp_sockets_allocated);
 =

+/*
+ * Optional TCP option handlers
+ */
+static DEFINE_SPINLOCK(tcp_option_list_lock);
+static LIST_HEAD(tcp_option_list);
+DEFINE_STATIC_KEY_FALSE(tcp_extra_options_enabled);
+
 /*
  * TCP splice context
  */
@@ -3472,6 +3479,149 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
 =

 #endif
 =

+/* Linear search, few entries are expected. The RCU read lock must
+ * be held before calling.
+ */
+static struct tcp_extra_option_ops *tcp_extra_options_find_kind(unsigned c=
har kind)
+{
+	struct tcp_extra_option_ops *entry;
+
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (entry->option_kind =3D=3D kind)
+			return entry;
+	}
+
+	return NULL;
+}
+
+void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
+			     const struct sk_buff *skb,
+			     struct tcp_options_received *opt_rx,
+			     struct sock *sk)
+{
+	struct tcp_extra_option_ops *entry;
+
+	rcu_read_lock();
+	entry =3D tcp_extra_options_find_kind(opcode);
+	if (entry && entry->parse)
+		entry->parse(opsize, opptr, skb, opt_rx, sk);
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_parse);
+
+/* The RCU read lock must be held before calling, and should span both
+ * the call to this function and tcp_extra_options_write to ensure that
+ * tcp_option_list does not change between the two calls. To preserve
+ * expected option alignment, always returns a multiple of 4 bytes.
+ */
+unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
+				       unsigned int remaining,
+				       struct tcp_out_options *opts,
+				       const struct sock *sk)
+{
+	struct tcp_extra_option_ops *entry;
+	unsigned int used =3D 0;
+
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->prepare))
+			continue;
+
+		used +=3D entry->prepare(skb, flags, remaining - used, opts, sk);
+	}
+
+	return roundup(used, 4);
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_prepare);
+
+/* The RCU read lock must be held before calling, and should span both
+ * the call to tcp_extra_options_write and this function to ensure that
+ * tcp_option_list does not change between the two calls.
+ */
+void tcp_extra_options_write(__be32 *ptr, struct sk_buff *skb,
+			     struct tcp_out_options *opts,
+			     const struct sock *sk)
+{
+	struct tcp_extra_option_ops *entry;
+
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->write))
+			continue;
+
+		entry->write(ptr, skb, opts, sk);
+	}
+}
+EXPORT_SYMBOL_GPL(tcp_extra_options_write);
+
+int tcp_extra_options_add_header(const struct sock *listener,
+				 const struct sock *sk)
+{
+	struct tcp_extra_option_ops *entry;
+	int tcp_header_len =3D 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->add_header_len))
+			continue;
+
+		tcp_header_len +=3D entry->add_header_len(listener, sk);
+	}
+	rcu_read_unlock();
+
+	return tcp_header_len;
+}
+
+int tcp_register_extra_option(struct tcp_extra_option_ops *ops)
+{
+	struct tcp_extra_option_ops *entry;
+	struct list_head *add_before =3D &tcp_option_list;
+	int ret =3D 0;
+
+	if (!ops->option_kind)
+		return -EINVAL;
+
+	if (!try_module_get(ops->owner))
+		return -ENOENT;
+
+	spin_lock(&tcp_option_list_lock);
+
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (entry->option_kind =3D=3D ops->option_kind) {
+			pr_notice("Option kind %u already registered\n",
+				  ops->option_kind);
+			spin_unlock(&tcp_option_list_lock);
+			module_put(ops->owner);
+			return -EEXIST;
+		}
+
+		if (entry->priority <=3D ops->priority)
+			add_before =3D &entry->list;
+	}
+
+	list_add_tail_rcu(&ops->list, add_before);
+	pr_debug("Option kind %u registered\n", ops->option_kind);
+
+	spin_unlock(&tcp_option_list_lock);
+
+	static_branch_inc(&tcp_extra_options_enabled);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tcp_register_extra_option);
+
+void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops)
+{
+	spin_lock(&tcp_option_list_lock);
+	list_del_rcu(&ops->list);
+	spin_unlock(&tcp_option_list_lock);
+
+	synchronize_net();
+
+	static_branch_dec(&tcp_extra_options_enabled);
+
+	module_put(ops->owner);
+}
+EXPORT_SYMBOL_GPL(tcp_unregister_extra_option);
+
 void tcp_done(struct sock *sk)
 {
 	struct request_sock *req =3D tcp_sk(sk)->fastopen_rsk;
@@ -3618,6 +3768,7 @@ void __init tcp_init(void)
 		INIT_HLIST_HEAD(&tcp_hashinfo.bhash[i].chain);
 	}
 =

+	INIT_LIST_HEAD(&tcp_option_list);
 =

 	cnt =3D tcp_hashinfo.ehash_mask + 1;
 	sysctl_tcp_max_orphans =3D cnt / 2;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 843061955973..028da0a4eff5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3693,7 +3693,7 @@ static int smc_parse_options(const struct tcphdr *th,
 void tcp_parse_options(const struct net *net,
 		       const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx, int estab,
-		       struct tcp_fastopen_cookie *foc)
+		       struct tcp_fastopen_cookie *foc, struct tcp_sock *tp)
 {
 	const unsigned char *ptr;
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -3798,6 +3798,12 @@ void tcp_parse_options(const struct net *net,
 					break;
 				break;
 =

+			default:
+				tcp_extra_options_parse(opcode, opsize, ptr,
+							skb, opt_rx,
+							tcp_to_sk(tp));
+				break;
+
 			}
 			ptr +=3D opsize-2;
 			length -=3D opsize;
@@ -3846,7 +3852,7 @@ static bool tcp_fast_parse_options(const struct net *=
net,
 			goto extra_opt_check;
 	}
 =

-	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
+	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL, tp);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

@@ -5512,7 +5518,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, =
struct sk_buff *synack,
 		/* Get original SYNACK MSS value if user MSS sets mss_clamp */
 		tcp_clear_options(&opt);
 		opt.user_mss =3D opt.mss_clamp =3D 0;
-		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL);
+		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL, tp);
 		mss =3D opt.mss_clamp;
 	}
 =

@@ -5575,7 +5581,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 	int saved_clamp =3D tp->rx_opt.mss_clamp;
 	bool fastopen_fail;
 =

-	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc);
+	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc, tp);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

@@ -6242,7 +6248,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
 	tmp_opt.user_mss  =3D tp->rx_opt.user_mss;
 	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
-			  want_cookie ? NULL : &foc);
+			  want_cookie ? NULL : &foc, tp);
 =

 	if (want_cookie && !tmp_opt.saw_tstamp)
 		tcp_clear_options(&tmp_opt);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6f14004bd36d..ccbb219c7b61 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -600,9 +600,7 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 	const struct tcphdr *th =3D tcp_hdr(skb);
 	struct {
 		struct tcphdr th;
-#ifdef CONFIG_TCP_MD5SIG
-		__be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
-#endif
+		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
 	} rep;
 	struct ip_reply_arg arg;
 #ifdef CONFIG_TCP_MD5SIG
@@ -613,6 +611,7 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 	struct sock *sk1 =3D NULL;
 #endif
 	struct net *net;
+	int offset =3D 0;
 =

 	/* Never send a reset in response to a reset. */
 	if (th->rst)
@@ -678,19 +677,46 @@ static void tcp_v4_send_reset(const struct sock *sk, =
struct sk_buff *skb)
 			goto out;
 =

 	}
+#endif
+
+	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
+		unsigned int remaining;
+		unsigned int used;
+		struct tcp_out_options opts;
+
+		remaining =3D sizeof(rep.opt);
+#ifdef CONFIG_TCP_MD5SIG
+		if (key)
+			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
+#endif
+
+		memset(&opts, 0, sizeof(opts));
+
+		rcu_read_lock();
+		used =3D tcp_extra_options_prepare(NULL, TCPHDR_RST, remaining,
+						 &opts, sk);
+
+		tcp_extra_options_write(&rep.opt[0], NULL, &opts, sk);
+		rcu_read_unlock();
+
+		arg.iov[0].iov_len +=3D used;
+		offset +=3D used / 4;
+		rep.th.doff =3D arg.iov[0].iov_len / 4;
+	}
 =

+#ifdef CONFIG_TCP_MD5SIG
 	if (key) {
-		rep.opt[0] =3D htonl((TCPOPT_NOP << 24) |
-				   (TCPOPT_NOP << 16) |
-				   (TCPOPT_MD5SIG << 8) |
-				   TCPOLEN_MD5SIG);
+		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
+					  (TCPOPT_NOP << 16) |
+					  (TCPOPT_MD5SIG << 8) |
+					  TCPOLEN_MD5SIG);
 		/* Update length and the length the header thinks exists */
 		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 		rep.th.doff =3D arg.iov[0].iov_len / 4;
 =

-		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[1],
-				     key, ip_hdr(skb)->saddr,
-				     ip_hdr(skb)->daddr, &rep.th);
+		tcp_v4_md5_hash_hdr((__u8 *)&rep.opt[offset],
+				    key, ip_hdr(skb)->saddr,
+				    ip_hdr(skb)->daddr, &rep.th);
 	}
 #endif
 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
@@ -741,17 +767,14 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	const struct tcphdr *th =3D tcp_hdr(skb);
 	struct {
 		struct tcphdr th;
-		__be32 opt[(TCPOLEN_TSTAMP_ALIGNED >> 2)
-#ifdef CONFIG_TCP_MD5SIG
-			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
-#endif
-			];
+		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
 	} rep;
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key *key;
 #endif
 	struct net *net =3D sock_net(sk);
 	struct ip_reply_arg arg;
+	int offset =3D 0;
 =

 	memset(&rep.th, 0, sizeof(struct tcphdr));
 	memset(&arg, 0, sizeof(arg));
@@ -765,12 +788,12 @@ static void tcp_v4_send_ack(const struct sock *sk,
 		rep.opt[1] =3D htonl(tsval);
 		rep.opt[2] =3D htonl(tsecr);
 		arg.iov[0].iov_len +=3D TCPOLEN_TSTAMP_ALIGNED;
+		offset +=3D 3;
 	}
 =

 	/* Swap the send and the receive. */
 	rep.th.dest    =3D th->source;
 	rep.th.source  =3D th->dest;
-	rep.th.doff    =3D arg.iov[0].iov_len / 4;
 	rep.th.seq     =3D htonl(seq);
 	rep.th.ack_seq =3D htonl(ack);
 	rep.th.ack     =3D 1;
@@ -787,22 +810,48 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	} else {
 		BUG();
 	}
+#endif
 =

-	if (key) {
-		int offset =3D (tsecr) ? 3 : 0;
+	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
+		unsigned int remaining;
+		unsigned int used;
+		struct tcp_out_options opts;
+
+		remaining =3D sizeof(rep.th) + sizeof(rep.opt) - arg.iov[0].iov_len;
+
+#ifdef CONFIG_TCP_MD5SIG
+		if (key)
+			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
+#endif
+
+		memset(&opts, 0, sizeof(opts));
+		rcu_read_lock();
+		used =3D tcp_extra_options_prepare(NULL, TCPHDR_ACK, remaining,
+						 &opts, sk);
+
+		tcp_extra_options_write(&rep.opt[offset], NULL, &opts, sk);
+		rcu_read_unlock();
+
+		arg.iov[0].iov_len +=3D used;
+		offset +=3D used / 4;
+	}
 =

+#ifdef CONFIG_TCP_MD5SIG
+	if (key) {
 		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
 					  (TCPOPT_NOP << 16) |
 					  (TCPOPT_MD5SIG << 8) |
 					  TCPOLEN_MD5SIG);
 		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
-		rep.th.doff =3D arg.iov[0].iov_len/4;
 =

 		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
 				    key, ip_hdr(skb)->saddr,
 				    ip_hdr(skb)->daddr, &rep.th);
 	}
 #endif
+
+	rep.th.doff =3D arg.iov[0].iov_len / 4;
+
 	arg.flags =3D reply_flags;
 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
 				      ip_hdr(skb)->saddr, /* XXX */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e36eff0403f4..7f9403d3272c 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -97,7 +97,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw,=
 struct sk_buff *skb,
 =

 	tmp_opt.saw_tstamp =3D 0;
 	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
-		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
+		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL, NULL);
 =

 		if (tmp_opt.saw_tstamp) {
 			if (tmp_opt.rcv_tsecr)
@@ -538,6 +538,9 @@ struct sock *tcp_create_openreq_child(const struct sock=
 *sk,
 		if (newtp->af_specific->md5_lookup(sk, newsk))
 			newtp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
+		if (static_branch_unlikely(&tcp_extra_options_enabled))
+			newtp->tcp_header_len +=3D tcp_extra_options_add_header(sk, newsk);
+
 		if (skb->len >=3D TCP_MSS_DEFAULT + newtp->tcp_header_len)
 			newicsk->icsk_ack.last_seg_size =3D skb->len - newtp->tcp_header_len;
 		newtp->rx_opt.mss_clamp =3D req->mss;
@@ -582,7 +585,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 =

 	tmp_opt.saw_tstamp =3D 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
-		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
+		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL, NULL);
 =

 		if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent =3D req->ts_recent;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fedaaea83b43..199a8baf281c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -398,13 +398,6 @@ static inline bool tcp_urg_mode(const struct tcp_sock =
*tp)
 	return tp->snd_una !=3D tp->snd_up;
 }
 =

-#define OPTION_SACK_ADVERTISE	(1 << 0)
-#define OPTION_TS		(1 << 1)
-#define OPTION_MD5		(1 << 2)
-#define OPTION_WSCALE		(1 << 3)
-#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
-#define OPTION_SMC		(1 << 9)
-
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
 #if IS_ENABLED(CONFIG_SMC)
@@ -420,18 +413,6 @@ static void smc_options_write(__be32 *ptr, u16 *option=
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
-	struct tcp_md5sig_key *md5; /* TCP_MD5 signature key */
-};
-
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -544,6 +525,9 @@ static void tcp_options_write(__be32 *ptr, struct sk_bu=
ff *skb, struct sock *sk,
 	}
 =

 	smc_options_write(ptr, &options);
+
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_write(ptr, skb, opts, tcp_to_sk(tp));
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -645,6 +629,11 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
truct sk_buff *skb,
 =

 	smc_set_option(tp, opts, &remaining);
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		remaining -=3D tcp_extra_options_prepare(skb, TCPHDR_SYN,
+						       remaining, opts,
+						       tcp_to_sk(tp));
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -707,6 +696,12 @@ static unsigned int tcp_synack_options(const struct so=
ck *sk,
 =

 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		remaining -=3D tcp_extra_options_prepare(skb,
+						       TCPHDR_SYN | TCPHDR_ACK,
+						       remaining, opts,
+						       req_to_sk(req));
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -739,6 +734,11 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		size +=3D tcp_extra_options_prepare(skb, 0,
+						  MAX_TCP_OPTION_SPACE - size,
+						  opts, tcp_to_sk(tp));
+
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
@@ -1070,6 +1070,7 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 	tcb =3D TCP_SKB_CB(skb);
 	memset(&opts, 0, sizeof(opts));
 =

+	rcu_read_lock();
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN))
 		tcp_options_size =3D tcp_syn_options(sk, skb, &opts);
 	else
@@ -1145,6 +1146,7 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 					       opts.md5, sk, skb);
 	}
 #endif
+	rcu_read_unlock();
 =

 	icsk->icsk_af_ops->send_check(sk, skb);
 =

@@ -3217,8 +3219,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 #endif
 		skb->skb_mstamp =3D tcp_clock_us();
 =

-#ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
+#ifdef CONFIG_TCP_MD5SIG
 	opts.md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req)=
);
 #endif
 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
@@ -3253,8 +3255,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
 							 opts.md5,
 							 req_to_sk(req), skb);
-	rcu_read_unlock();
 #endif
+	rcu_read_unlock();
 =

 	/* Do not fool tcpdump (if any), clean our debris */
 	skb->tstamp =3D 0;
@@ -3301,6 +3303,9 @@ static void tcp_connect_init(struct sock *sk)
 		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tp->tcp_header_len +=3D tcp_extra_options_add_header(sk, sk);
+
 	/* If user gave his TCP_MAXSEG, record it to clamp */
 	if (tp->rx_opt.user_mss)
 		tp->rx_opt.mss_clamp =3D tp->rx_opt.user_mss;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index e7a3a6b6cf56..0ed3721b03a2 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -162,7 +162,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
+	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, tp);
 =

 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7075f4a1d701..7e4e8788943f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -793,6 +793,7 @@ static void tcp_v6_send_response(const struct sock *sk,=
 struct sk_buff *skb, u32
 	const __u8 *hash_location =3D NULL;
 	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
 #endif
+	struct tcp_out_options extraopts;
 =

 	if (tsecr)
 		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
@@ -840,6 +841,20 @@ static void tcp_v6_send_response(const struct sock *sk=
, struct sk_buff *skb, u32
 		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
 =

+
+	if (static_branch_unlikely(&tcp_extra_options_enabled)) {
+		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - tot_len;
+		u8 extraflags =3D rst ? TCPHDR_RST : 0;
+
+		if (!rst || !th->ack)
+			extraflags |=3D TCPHDR_ACK;
+
+		memset(&extraopts, 0, sizeof(extraopts));
+
+		tot_len +=3D tcp_extra_options_prepare(skb, extraflags, remaining,
+						     &extraopts, sk);
+	}
+
 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
 			 GFP_ATOMIC);
 	if (!buff)
@@ -880,6 +895,9 @@ static void tcp_v6_send_response(const struct sock *sk,=
 struct sk_buff *skb, u32
 	}
 #endif
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_write(topt, buff, &extraopts, sk);
+
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.daddr =3D ipv6_hdr(skb)->saddr;
 	fl6.saddr =3D ipv6_hdr(skb)->daddr;
-- =

2.15.0


--===============0801535228252425695==--
