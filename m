Content-Type: multipart/mixed; boundary="===============6360878324650996411=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 06/18] tcp: Register handlers for extra TCP options
Date: Tue, 03 Oct 2017 09:21:52 -0700
Message-ID: <20171003162204.17945-7-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 93

--===============6360878324650996411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Allow additional TCP options to be handled by registered hook
functions.

Option parsing will call the provided 'parse' function when a TCP option
number is not recognized by the normal option parsing code.

The 'prepare' and 'prepare_req' functions determine the required space
for registered options and store associated data. There are two variants
because options must be generated for connections that are associated
with either tcp_sock or request_sock structures.

A static key and RCU synchronization are used to minimize the
performance impact of these extensible TCP features.

Before this is posted upstream, I plan to split the patch in two parts
(at least), since making tcp_out_options public should be separate. The
extra parameter for tcp_parse_options may also warrant its own
patch. I'd also like to discuss where to store information for the
options that are parsed or generated using these hooks, since the
tcp_options_received and tcp_out_options structs don't have places to
store extra information yet.

I've confirmed that this code builds, but haven't tested yet.

This commit is also available at
https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
branch: mptcp

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 drivers/infiniband/hw/cxgb4/cm.c |   2 +-
 include/linux/tcp.h              |  17 +++++
 include/net/tcp.h                |  49 ++++++++++++++-
 net/ipv4/syncookies.c            |   2 +-
 net/ipv4/tcp.c                   | 133 +++++++++++++++++++++++++++++++++++=
++++
 net/ipv4/tcp_input.c             |  15 +++--
 net/ipv4/tcp_minisocks.c         |   4 +-
 net/ipv4/tcp_output.c            |  35 ++++++-----
 net/ipv6/syncookies.c            |   2 +-
 9 files changed, 231 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4=
/cm.c
index daf7a56e5d7e..c3eb31611011 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3752,7 +3752,7 @@ static void build_cpl_pass_accept_req(struct sk_buff =
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
index 4aa40ef02d32..6175caf2e309 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -112,6 +112,23 @@ static inline void tcp_clear_options(struct tcp_option=
s_received *rx_opt)
 	rx_opt->wscale_ok =3D rx_opt->snd_wscale =3D 0;
 }
 =

+#define OPTION_SACK_ADVERTISE	(1 << 0)
+#define OPTION_TS		(1 << 1)
+#define OPTION_MD5		(1 << 2)
+#define OPTION_WSCALE		(1 << 3)
+#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
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
+};
+
 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
  * to increase this, although since:
  *   size =3D TCPOLEN_SACK_BASE_ALIGNED (4) + n * TCPOLEN_SACK_PERBLOCK (8)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 770b608c8439..676ae8991e7f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -433,7 +433,8 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, si=
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
@@ -2103,4 +2104,50 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock =
*sk)
 {
 	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN) =3D=3D 1);
 }
+
+extern struct static_key_false tcp_extra_options_enabled;
+
+struct tcp_extra_option_ops {
+	struct list_head	list;
+	unsigned char		option_kind;
+	void (*parse)(int opsize, const unsigned char *opptr,
+		      const struct sk_buff *skb,
+		      struct tcp_options_received *opt_rx,
+		      struct tcp_sock *tp);
+	/* Return the number of bytes consumed */
+	unsigned int (*prepare)(struct sk_buff *skb, u8 flags,
+				unsigned int remaining,
+				struct tcp_out_options *opts,
+				struct tcp_sock *tp);
+	/* Return the number of bytes consumed */
+	unsigned int (*prepare_req)(struct sk_buff *skb, u8 flags,
+				    unsigned int remaining,
+				    struct tcp_out_options *opts,
+				    struct request_sock *req);
+	void (*write)(__be32 *ptr, struct tcp_out_options *opts,
+		      struct tcp_sock *tp);
+	struct module		*owner;
+};
+
+void tcp_extra_options_parse(int opcode, int opsize, const unsigned char *=
opptr,
+			     const struct sk_buff *skb,
+			     struct tcp_options_received *opt_rx,
+			     struct tcp_sock *tp);
+
+unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
+				       unsigned int remaining,
+				       struct tcp_out_options *opts,
+				       struct tcp_sock *tp);
+
+unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flags,
+					   unsigned int remaining,
+					   struct tcp_out_options *opts,
+					   struct request_sock *req);
+
+void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
+			     struct tcp_sock *tp);
+
+int tcp_register_extra_option(struct tcp_extra_option_ops *ops);
+void tcp_unregister_extra_option(struct tcp_extra_option_ops *ops);
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b1bb1b3a1082..6c8d750a2243 100644
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
index 5091402720ab..82b022d5f215 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -270,6 +270,7 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
+#include <linux/static_key.h>
 =

 #include <net/icmp.h>
 #include <net/inet_common.h>
@@ -306,6 +307,11 @@ EXPORT_SYMBOL(tcp_memory_allocated);
 struct percpu_counter tcp_sockets_allocated;
 EXPORT_SYMBOL(tcp_sockets_allocated);
 =

+/* Optional TCP option handlers */
+static DEFINE_SPINLOCK(tcp_option_list_lock);
+static LIST_HEAD(tcp_option_list);
+DEFINE_STATIC_KEY_FALSE(tcp_extra_options_enabled);
+
 /*
  * TCP splice context
  */
@@ -3375,6 +3381,132 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
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
+			     struct tcp_sock *tp)
+{
+	struct tcp_extra_option_ops *entry;
+
+	rcu_read_lock();
+	entry =3D tcp_extra_options_find_kind(opcode);
+	if (entry && entry->parse)
+		entry->parse(opsize, opptr, skb, opt_rx, tp);
+	rcu_read_unlock();
+}
+
+unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
+				       unsigned int remaining,
+				       struct tcp_out_options *opts,
+				       struct tcp_sock *tp)
+{
+	struct tcp_extra_option_ops *entry;
+	unsigned int used =3D 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->prepare))
+			continue;
+
+		used +=3D entry->prepare(skb, flags, remaining - used, opts, tp);
+	}
+	rcu_read_unlock();
+
+	return used;
+}
+
+unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flags,
+					   unsigned int remaining,
+					   struct tcp_out_options *opts,
+					   struct request_sock *req)
+{
+	struct tcp_extra_option_ops *entry;
+	unsigned int used =3D 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->prepare_req))
+			continue;
+
+		used +=3D entry->prepare_req(skb, flags, remaining - used, opts,
+					   req);
+	}
+	rcu_read_unlock();
+
+	return used;
+}
+
+void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
+			     struct tcp_sock *tp)
+{
+	struct tcp_extra_option_ops *entry;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
+		if (unlikely(!entry->write))
+			continue;
+
+		entry->write(ptr, opts, tp);
+	}
+	rcu_read_unlock();
+}
+
+int tcp_register_extra_option(struct tcp_extra_option_ops *ops)
+{
+	int ret =3D 0;
+
+	if (!ops->option_kind)
+		return -EINVAL;
+
+	if (!try_module_get(ops->owner))
+		return -ENOENT;
+
+	spin_lock(&tcp_option_list_lock);
+	if (tcp_extra_options_find_kind(ops->option_kind)) {
+		pr_notice("Option kind %u already registered\n",
+			  ops->option_kind);
+		spin_unlock(&tcp_option_list_lock);
+		module_put(ops->owner);
+		return -EEXIST;
+	}
+
+	list_add_tail_rcu(&ops->list, &tcp_option_list);
+	pr_debug("Option kind %u registered\n", ops->option_kind);
+	spin_unlock(&tcp_option_list_lock);
+
+	static_branch_inc(&tcp_extra_options_enabled);
+
+	return ret;
+}
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
+
 void tcp_done(struct sock *sk)
 {
 	struct request_sock *req =3D tcp_sk(sk)->fastopen_rsk;
@@ -3521,6 +3653,7 @@ void __init tcp_init(void)
 		INIT_HLIST_HEAD(&tcp_hashinfo.bhash[i].chain);
 	}
 =

+	INIT_LIST_HEAD(&tcp_option_list);
 =

 	cnt =3D tcp_hashinfo.ehash_mask + 1;
 	sysctl_tcp_max_orphans =3D cnt / 2;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index db9bb46b5776..89c38ef94b54 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3726,7 +3726,7 @@ static void tcp_parse_fastopen_option(int len, const =
unsigned char *cookie,
 void tcp_parse_options(const struct net *net,
 		       const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx, int estab,
-		       struct tcp_fastopen_cookie *foc)
+		       struct tcp_fastopen_cookie *foc, struct tcp_sock *tp)
 {
 	const unsigned char *ptr;
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -3828,6 +3828,11 @@ void tcp_parse_options(const struct net *net,
 						ptr + 2, th->syn, foc, true);
 				break;
 =

+			default:
+				tcp_extra_options_parse(opcode, opsize, ptr,
+							skb, opt_rx, tp);
+				break;
+
 			}
 			ptr +=3D opsize-2;
 			length -=3D opsize;
@@ -3874,7 +3879,7 @@ static bool tcp_fast_parse_options(const struct net *=
net,
 			return true;
 	}
 =

-	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
+	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL, tp);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

@@ -5550,7 +5555,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, =
struct sk_buff *synack,
 		/* Get original SYNACK MSS value if user MSS sets mss_clamp */
 		tcp_clear_options(&opt);
 		opt.user_mss =3D opt.mss_clamp =3D 0;
-		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL);
+		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL, tp);
 		mss =3D opt.mss_clamp;
 	}
 =

@@ -5604,7 +5609,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 	int saved_clamp =3D tp->rx_opt.mss_clamp;
 	bool fastopen_fail;
 =

-	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc);
+	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc, tp);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

@@ -6280,7 +6285,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
 	tmp_opt.user_mss  =3D tp->rx_opt.user_mss;
 	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
-			  want_cookie ? NULL : &foc);
+			  want_cookie ? NULL : &foc, tp);
 =

 	if (want_cookie && !tmp_opt.saw_tstamp)
 		tcp_clear_options(&tmp_opt);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 188a6f31356d..1c3e91899dac 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -98,7 +98,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw,=
 struct sk_buff *skb,
 =

 	tmp_opt.saw_tstamp =3D 0;
 	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
-		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
+		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL, NULL);
 =

 		if (tmp_opt.saw_tstamp) {
 			if (tmp_opt.rcv_tsecr)
@@ -565,7 +565,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
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
index 964c4c6cd0a2..c4089202e686 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -41,6 +41,7 @@
 #include <linux/compiler.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/static_key.h>
 =

 /* People can turn this off for buggy TCP's found in printers etc. */
 int sysctl_tcp_retrans_collapse __read_mostly =3D 1;
@@ -413,23 +414,6 @@ static inline bool tcp_urg_mode(const struct tcp_sock =
*tp)
 	return tp->snd_una !=3D tp->snd_up;
 }
 =

-#define OPTION_SACK_ADVERTISE	(1 << 0)
-#define OPTION_TS		(1 << 1)
-#define OPTION_MD5		(1 << 2)
-#define OPTION_WSCALE		(1 << 3)
-#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
-
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
@@ -540,6 +524,9 @@ static void tcp_options_write(__be32 *ptr, struct sk_bu=
ff *skb, struct sock *sk,
 		}
 		ptr +=3D (len + 3) >> 2;
 	}
+
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		tcp_extra_options_write(ptr, opts, tp);
 }
 =

 /* Compute TCP options for SYN packets. This is not the final
@@ -607,6 +594,10 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
truct sk_buff *skb,
 		}
 	}
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		remaining -=3D tcp_extra_options_prepare(skb, TCPHDR_SYN,
+						       remaining, opts, tp);
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -668,6 +659,13 @@ static unsigned int tcp_synack_options(const struct so=
ck *sk,
 		}
 	}
 =

+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		remaining -=3D tcp_extra_options_prepare_req(skb,
+							   TCPHDR_SYN |
+							   TCPHDR_ACK,
+							   remaining, opts,
+							   req);
+
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
 =

@@ -701,6 +699,9 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

+	size +=3D tcp_extra_options_prepare(skb, 0, MAX_TCP_OPTION_SPACE - size,
+					  opts, tp);
+
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4e7817abc0b9..407480366c73 100644
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
-- =

2.14.1


--===============6360878324650996411==--
