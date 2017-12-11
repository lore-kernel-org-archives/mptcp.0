Content-Type: multipart/mixed; boundary="===============4137271173799527809=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 13/15] tcp_md5: Use tcp_extra_options in output path
Date: Mon, 11 Dec 2017 13:42:16 -0800
Message-ID: <20171211214218.35868-14-cpaasch@apple.com>
In-Reply-To: 20171211214218.35868-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 244

--===============4137271173799527809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch starts making use of the extra_option framework for TCP_MD5.

One tricky part is that extra_options are called at the end of the
tcp_syn_options(), while TCP_MD5 is called at the beginning.

TCP_MD5 is called at the beginning because it wants to disable
TCP-timestamps (for option-space reasons). So, in the _prepare-function
of the extra options we need to undo the work that was done when
enabling TCP timestamps.

Another thing to note is that in tcp_v4_send_reset (and its IPv6
counterpart), we were looking previously for the listening-socket (if sk
=3D=3D NULL) in case there was an MD5 signature in the TCP-option space of
the incoming packet.

With the extra-option framework we can't do this anymore, because
extra-options are part of the TCP-socket's tcp_option_list. If there is
no socket, it means we can't parse the option.

This shouldn't thave an impact, because when we receive a segment and
there is not established socket, we will match on the listening socket
(if it's still there). Then, when we decide to respond with a RST in
tcp_rcv_state_process, we will give to tcp_v4_send_reset() the
listening-socket and thus will parse the TCP_MD5 option.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    v3: * Fix option-accounting for SACK in tcp_md5_extopt_prepare
        * Use GFP_ATOMIC in the store-allocator

 include/linux/tcp.h      |  10 +-
 include/linux/tcp_md5.h  |  64 -----
 net/ipv4/tcp_ipv4.c      |  56 ----
 net/ipv4/tcp_md5.c       | 670 ++++++++++++++++++++++++++++++++-----------=
----
 net/ipv4/tcp_minisocks.c |  12 -
 net/ipv4/tcp_output.c    |  68 +----
 net/ipv6/tcp_ipv6.c      |  23 --
 7 files changed, 465 insertions(+), 438 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a1633d467af5..df9d7aafd62f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -127,11 +127,11 @@ struct tcp_out_options {
 	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_sack_blocks;	/* number of SACK blocks to include */
-	u8 hash_size;		/* bytes in hash_location */
-	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+#ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key *md5; /* TCP_MD5 signature key */
+#endif
 };
 =

 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
@@ -380,9 +380,6 @@ struct tcp_sock {
 #ifdef CONFIG_TCP_MD5SIG
 /* TCP AF-Specific parts; only used by MD5 Signature support so far */
 	const struct tcp_sock_af_ops	*af_specific;
-
-/* TCP MD5 Signature Option information */
-	struct tcp_md5sig_info	__rcu *md5sig_info;
 #endif
 =

 /* TCP fastopen related information */
@@ -440,9 +437,6 @@ struct tcp_timewait_sock {
 	long			  tw_ts_recent_stamp;
 =

 	struct hlist_head	  tcp_option_list;
-#ifdef CONFIG_TCP_MD5SIG
-	struct tcp_md5sig_key	  *tw_md5_key;
-#endif
 };
 =

 static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
index f6a681cdded4..8dee4fc3dc7f 100644
--- a/include/linux/tcp_md5.h
+++ b/include/linux/tcp_md5.h
@@ -26,25 +26,6 @@ struct tcp_md5sig_key {
 	struct rcu_head		rcu;
 };
 =

-/* - sock block */
-struct tcp_md5sig_info {
-	struct hlist_head	head;
-	struct rcu_head		rcu;
-};
-
-union tcp_md5sum_block {
-	struct tcp4_pseudohdr ip4;
-#if IS_ENABLED(CONFIG_IPV6)
-	struct tcp6_pseudohdr ip6;
-#endif
-};
-
-/* - pool: digest algorithm, hash description and scratch buffer */
-struct tcp_md5sig_pool {
-	struct ahash_request	*md5_req;
-	void			*scratch;
-};
-
 extern const struct tcp_sock_af_ops tcp_sock_ipv4_specific;
 extern const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
 extern const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
@@ -56,37 +37,9 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp=
_md5sig_key *key,
 struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 					 const struct sock *addr_sk);
 =

-void tcp_v4_md5_destroy_sock(struct sock *sk);
-
-int tcp_v4_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
-				     unsigned int remaining,
-				     struct tcp_out_options *opts,
-				     const struct sock *sk);
-
-void tcp_v4_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
-				    struct tcphdr *t1,
-				    struct tcp_out_options *opts,
-				    const struct sock *sk);
-
-int tcp_v6_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
-				     unsigned int remaining,
-				     struct tcp_out_options *opts,
-				     const struct sock *sk);
-
-void tcp_v6_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
-				    struct tcphdr *t1,
-				    struct tcp_out_options *opts,
-				    const struct sock *sk);
-
 bool tcp_v4_inbound_md5_hash(const struct sock *sk,
 			     const struct sk_buff *skb);
 =

-void tcp_v4_md5_syn_recv_sock(const struct sock *listener, struct sock *sk=
);
-
-void tcp_v6_md5_syn_recv_sock(const struct sock *listener, struct sock *sk=
);
-
-void tcp_md5_time_wait(struct sock *sk, struct inet_timewait_sock *tw);
-
 struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
 					 const struct sock *addr_sk);
 =

@@ -98,23 +51,6 @@ int tcp_v6_md5_hash_skb(char *md5_hash,
 bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 			     const struct sk_buff *skb);
 =

-static inline void tcp_md5_twsk_destructor(struct sock *sk)
-{
-	struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
-
-	if (twsk->tw_md5_key)
-		kfree_rcu(twsk->tw_md5_key, rcu);
-}
-
-static inline void tcp_md5_add_header_len(const struct sock *listener,
-					  struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	if (tp->af_specific->md5_lookup(listener, sk))
-		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
-}
-
 int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buff *=
skb);
 =

 int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c00d1e8828e8..9553a18d95cc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -636,30 +636,11 @@ static void tcp_v4_send_reset(const struct sock *sk, =
struct sk_buff *skb)
 =

 	net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
 =

-#ifdef CONFIG_TCP_MD5DSIG
-{
-	int ret;
-
-	ret =3D tcp_v4_md5_send_response_prepare(skb, 0,
-					       MAX_TCP_OPTION_SPACE - arg.iov[0].iov_len,
-					       &opts, sk);
-
-	if (ret =3D=3D -1)
-		return;
-
-	arg.iov[0].iov_len +=3D ret;
-}
-#endif
-
 	if (static_branch_unlikely(&tcp_extopt_enabled)) {
 		unsigned int remaining;
 		int used;
 =

 		remaining =3D sizeof(rep.opt);
-#ifdef CONFIG_TCP_MD5SIG
-		if (opts.md5)
-			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
-#endif
 =

 		used =3D tcp_extopt_response_prepare(skb, TCPHDR_RST, remaining,
 						   &opts, sk);
@@ -671,9 +652,6 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 		offset +=3D used / 4;
 	}
 =

-#ifdef CONFIG_TCP_MD5SIG
-	tcp_v4_md5_send_response_write(&rep.opt[offset], skb, &rep.th, &opts, sk);
-#endif
 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
 				      ip_hdr(skb)->saddr, /* XXX */
 				      arg.iov[0].iov_len, IPPROTO_TCP, 0);
@@ -749,32 +727,12 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	rep.th.ack     =3D 1;
 	rep.th.window  =3D htons(win);
 =

-#ifdef CONFIG_TCP_MD5SIG
-{
-	int ret;
-
-	ret =3D tcp_v4_md5_send_response_prepare(skb, 0,
-					       MAX_TCP_OPTION_SPACE - arg.iov[0].iov_len,
-					       &opts, sk);
-
-	if (ret =3D=3D -1)
-		return;
-
-	arg.iov[0].iov_len +=3D ret;
-}
-#endif
-
 	if (static_branch_unlikely(&tcp_extopt_enabled)) {
 		unsigned int remaining;
 		int used;
 =

 		remaining =3D sizeof(rep.th) + sizeof(rep.opt) - arg.iov[0].iov_len;
 =

-#ifdef CONFIG_TCP_MD5SIG
-		if (opts.md5)
-			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
-#endif
-
 		memset(&opts, 0, sizeof(opts));
 		used =3D tcp_extopt_response_prepare(skb, TCPHDR_ACK, remaining,
 						   &opts, sk);
@@ -787,14 +745,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
 		offset +=3D used / 4;
 	}
 =

-#ifdef CONFIG_TCP_MD5SIG
-	if (opts.md5) {
-		arg.iov[0].iov_len +=3D TCPOLEN_MD5SIG_ALIGNED;
-		rep.th.doff =3D arg.iov[0].iov_len / 4;
-	}
-	tcp_v4_md5_send_response_write(&rep.opt[offset], skb, &rep.th, &opts, sk);
-#endif
-
 	arg.flags =3D reply_flags;
 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
 				      ip_hdr(skb)->saddr, /* XXX */
@@ -1025,9 +975,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *s=
k, struct sk_buff *skb,
 		tcp_extopt_move(req_to_sk(req), newsk);
 		INIT_HLIST_HEAD(&tcp_rsk(req)->tcp_option_list);
 	}
-#ifdef CONFIG_TCP_MD5SIG
-	tcp_v4_md5_syn_recv_sock(sk, newsk);
-#endif
 =

 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
@@ -1526,9 +1473,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
 =

 	if (static_branch_unlikely(&tcp_extopt_enabled))
 		tcp_extopt_destroy(sk);
-#ifdef CONFIG_TCP_MD5SIG
-	tcp_v4_md5_destroy_sock(sk);
-#endif
 =

 	/* Clean up a referenced TCP bind bucket. */
 	if (inet_csk(sk)->icsk_bind_hash)
diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
index ab2059a015d3..5c3dcb76f0b3 100644
--- a/net/ipv4/tcp_md5.c
+++ b/net/ipv4/tcp_md5.c
@@ -7,11 +7,105 @@
 =

 #include <net/inet6_hashtables.h>
 =

+struct tcp_md5sig_info {
+	struct hlist_head	head;
+	struct rcu_head		rcu;
+};
+
+union tcp_md5sum_block {
+	struct tcp4_pseudohdr ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct tcp6_pseudohdr ip6;
+#endif
+};
+
+/* - pool: digest algorithm, hash description and scratch buffer */
+struct tcp_md5sig_pool {
+	struct ahash_request	*md5_req;
+	void			*scratch;
+};
+
 static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig_pool);
 static DEFINE_MUTEX(tcp_md5sig_mutex);
 static bool tcp_md5sig_pool_populated;
 =

-#define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
+static unsigned int tcp_md5_extopt_prepare(struct sk_buff *skb, u8 flags,
+					   unsigned int remaining,
+					   struct tcp_out_options *opts,
+					   const struct sock *sk,
+					   struct tcp_extopt_store *store);
+
+static __be32 *tcp_md5_extopt_write(__be32 *ptr, struct sk_buff *skb,
+				    struct tcp_out_options *opts,
+				    struct sock *sk,
+				    struct tcp_extopt_store *store);
+
+static int tcp_md5_send_response_prepare(struct sk_buff *orig, u8 flags,
+					 unsigned int remaining,
+					 struct tcp_out_options *opts,
+					 const struct sock *sk,
+					 struct tcp_extopt_store *store);
+
+static __be32 *tcp_md5_send_response_write(__be32 *ptr, struct sk_buff *or=
ig,
+					   struct tcphdr *th,
+					   struct tcp_out_options *opts,
+					   const struct sock *sk,
+					   struct tcp_extopt_store *store);
+
+static int tcp_md5_extopt_add_header_len(const struct sock *listener,
+					 const struct sock *sk,
+					 struct tcp_extopt_store *store);
+
+static struct tcp_extopt_store *tcp_md5_extopt_copy(struct sock *listener,
+						    struct request_sock *req,
+						    struct tcp_options_received *opt,
+						    struct tcp_extopt_store *store);
+
+static struct tcp_extopt_store *tcp_md5_extopt_move(struct sock *from,
+						    struct sock *to,
+						    struct tcp_extopt_store *store);
+
+static void tcp_md5_extopt_destroy(struct tcp_extopt_store *store);
+
+struct tcp_md5_extopt {
+	struct tcp_extopt_store		store;
+	struct tcp_md5sig_info __rcu	*md5sig_info;
+	struct sock			*sk;
+	struct rcu_head			rcu;
+};
+
+static const struct tcp_extopt_ops tcp_md5_extra_ops =3D {
+	.option_kind		=3D TCPOPT_MD5SIG,
+	.prepare		=3D tcp_md5_extopt_prepare,
+	.write			=3D tcp_md5_extopt_write,
+	.response_prepare	=3D tcp_md5_send_response_prepare,
+	.response_write		=3D tcp_md5_send_response_write,
+	.add_header_len		=3D tcp_md5_extopt_add_header_len,
+	.copy			=3D tcp_md5_extopt_copy,
+	.move			=3D tcp_md5_extopt_move,
+	.destroy		=3D tcp_md5_extopt_destroy,
+	.owner			=3D THIS_MODULE,
+};
+
+static int tcp_md5_register(struct sock *sk,
+			    struct tcp_md5_extopt *md5_opt)
+{
+	return tcp_register_extopt(&md5_opt->store, sk);
+}
+
+static struct tcp_md5_extopt *tcp_md5_alloc_store(struct sock *sk)
+{
+	struct tcp_md5_extopt *md5_opt;
+
+	md5_opt =3D kzalloc(sizeof(*md5_opt), GFP_ATOMIC);
+	if (!md5_opt)
+		return NULL;
+
+	md5_opt->store.ops =3D &tcp_md5_extra_ops;
+	md5_opt->sk =3D sk;
+
+	return md5_opt;
+}
 =

 static void __tcp_alloc_md5sig_pool(void)
 {
@@ -91,18 +185,18 @@ static struct tcp_md5sig_pool *tcp_get_md5sig_pool(voi=
d)
 	return NULL;
 }
 =

-static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock *s=
k,
+static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct tcp_md5=
_extopt *md5_opt,
 						      const union tcp_md5_addr *addr,
 						      int family, u8 prefixlen)
 {
-	const struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_md5sig_key *key;
 	unsigned int size =3D sizeof(struct in_addr);
 	const struct tcp_md5sig_info *md5sig;
+	const struct sock *sk =3D md5_opt->sk;
 =

 	/* caller either holds rcu_read_lock() or socket lock */
-	md5sig =3D rcu_dereference_check(tp->md5sig_info,
-				       lockdep_sock_is_held(sk));
+	md5sig =3D rcu_dereference_check(md5_opt->md5sig_info,
+				       sk_fullsock(sk) && lockdep_sock_is_held(sk));
 	if (!md5sig)
 		return NULL;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -126,10 +220,25 @@ static int tcp_md5_do_add(struct sock *sk, const unio=
n tcp_md5_addr *addr,
 {
 	/* Add Key to the list */
 	struct tcp_md5sig_key *key;
-	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_md5sig_info *md5sig;
+	struct tcp_md5_extopt *md5_opt;
+
+	md5_opt =3D (struct tcp_md5_extopt *)tcp_extopt_find_kind(TCPOPT_MD5SIG, =
sk);
+	if (!md5_opt) {
+		int ret;
 =

-	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
+		md5_opt =3D (struct tcp_md5_extopt *)tcp_md5_alloc_store(sk);
+		if (!md5_opt)
+			return -ENOMEM;
+
+		ret =3D tcp_md5_register(sk, md5_opt);
+		if (ret) {
+			kfree(md5_opt);
+			return ret;
+		}
+	}
+
+	key =3D tcp_md5_do_lookup_exact(md5_opt, addr, family, prefixlen);
 	if (key) {
 		/* Pre-existing entry - just update that one. */
 		memcpy(key->key, newkey, newkeylen);
@@ -137,8 +246,8 @@ static int tcp_md5_do_add(struct sock *sk, const union =
tcp_md5_addr *addr,
 		return 0;
 	}
 =

-	md5sig =3D rcu_dereference_protected(tp->md5sig_info,
-					   lockdep_sock_is_held(sk));
+	md5sig =3D rcu_dereference_protected(md5_opt->md5sig_info,
+					   sk_fullsock(sk) && lockdep_sock_is_held(sk));
 	if (!md5sig) {
 		md5sig =3D kmalloc(sizeof(*md5sig), gfp);
 		if (!md5sig)
@@ -146,7 +255,7 @@ static int tcp_md5_do_add(struct sock *sk, const union =
tcp_md5_addr *addr,
 =

 		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
 		INIT_HLIST_HEAD(&md5sig->head);
-		rcu_assign_pointer(tp->md5sig_info, md5sig);
+		rcu_assign_pointer(md5_opt->md5sig_info, md5sig);
 	}
 =

 	key =3D sock_kmalloc(sk, sizeof(*key), gfp);
@@ -168,18 +277,18 @@ static int tcp_md5_do_add(struct sock *sk, const unio=
n tcp_md5_addr *addr,
 	return 0;
 }
 =

-static void tcp_clear_md5_list(struct sock *sk)
+static void tcp_clear_md5_list(struct tcp_md5_extopt *md5_opt)
 {
-	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct tcp_md5sig_info *md5sig;
 	struct tcp_md5sig_key *key;
 	struct hlist_node *n;
-	struct tcp_md5sig_info *md5sig;
 =

-	md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1);
+	md5sig =3D rcu_dereference_protected(md5_opt->md5sig_info, 1);
 =

 	hlist_for_each_entry_safe(key, n, &md5sig->head, node) {
 		hlist_del_rcu(&key->node);
-		atomic_sub(sizeof(*key), &sk->sk_omem_alloc);
+		if (md5_opt->sk && sk_fullsock(md5_opt->sk))
+			atomic_sub(sizeof(*key), &md5_opt->sk->sk_omem_alloc);
 		kfree_rcu(key, rcu);
 	}
 }
@@ -187,9 +296,14 @@ static void tcp_clear_md5_list(struct sock *sk)
 static int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr,
 			  int family, u8 prefixlen)
 {
+	struct tcp_md5_extopt *md5_opt;
 	struct tcp_md5sig_key *key;
 =

-	key =3D tcp_md5_do_lookup_exact(sk, addr, family, prefixlen);
+	md5_opt =3D (struct tcp_md5_extopt *)tcp_extopt_find_kind(TCPOPT_MD5SIG, =
sk);
+	if (!md5_opt)
+		return -ENOENT;
+
+	key =3D tcp_md5_do_lookup_exact(md5_opt, addr, family, prefixlen);
 	if (!key)
 		return -ENOENT;
 	hlist_del_rcu(&key->node);
@@ -421,16 +535,20 @@ static struct tcp_md5sig_key *tcp_md5_do_lookup(const=
 struct sock *sk,
 						const union tcp_md5_addr *addr,
 						int family)
 {
-	const struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_md5sig_key *key;
 	const struct tcp_md5sig_info *md5sig;
 	__be32 mask;
 	struct tcp_md5sig_key *best_match =3D NULL;
+	struct tcp_md5_extopt *md5_opt;
 	bool match;
 =

+	md5_opt =3D (struct tcp_md5_extopt *)tcp_extopt_find_kind(TCPOPT_MD5SIG, =
sk);
+	if (!md5_opt)
+		return NULL;
+
 	/* caller either holds rcu_read_lock() or socket lock */
-	md5sig =3D rcu_dereference_check(tp->md5sig_info,
-				       lockdep_sock_is_held(sk));
+	md5sig =3D rcu_dereference_check(md5_opt->md5sig_info,
+				       sk_fullsock(sk) && lockdep_sock_is_held(sk));
 	if (!md5sig)
 		return NULL;
 =

@@ -538,75 +656,29 @@ static int tcp_md5_hash_skb_data(struct tcp_md5sig_po=
ol *hp,
 	return 0;
 }
 =

-int tcp_v4_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
-				     unsigned int remaining,
-				     struct tcp_out_options *opts,
-				     const struct sock *sk)
+static int tcp_v4_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
+					    unsigned int remaining,
+					    struct tcp_out_options *opts,
+					    const struct sock *sk)
 {
-	const struct tcphdr *th =3D tcp_hdr(skb);
 	const struct iphdr *iph =3D ip_hdr(skb);
-	const __u8 *hash_location =3D NULL;
 =

 	rcu_read_lock();
-	hash_location =3D tcp_parse_md5sig_option(th);
-	if (sk && sk_fullsock(sk)) {
-		opts->md5 =3D tcp_md5_do_lookup(sk,
-					      (union tcp_md5_addr *)&iph->saddr,
-					      AF_INET);
-	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
-		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
-
-		opts->md5 =3D tcp_twsk_md5_key(tcptw);
-	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
-		opts->md5 =3D tcp_md5_do_lookup(sk,
-					      (union tcp_md5_addr *)&iph->saddr,
-					      AF_INET);
-	} else if (hash_location) {
-		unsigned char newhash[16];
-		struct sock *sk1;
-		int genhash;
-
-		/* active side is lost. Try to find listening socket through
-		 * source port, and then find md5 key through listening socket.
-		 * we are not loose security here:
-		 * Incoming packet is checked with md5 hash with finding key,
-		 * no RST generated if md5 hash doesn't match.
-		 */
-		sk1 =3D __inet_lookup_listener(dev_net(skb_dst(skb)->dev),
-					     &tcp_hashinfo, NULL, 0,
-					     iph->saddr,
-					     th->source, iph->daddr,
-					     ntohs(th->source), inet_iif(skb),
-					     tcp_v4_sdif(skb));
-		/* don't send rst if it can't find key */
-		if (!sk1)
-			goto out_err;
-
-		opts->md5 =3D tcp_md5_do_lookup(sk1, (union tcp_md5_addr *)
-					      &iph->saddr, AF_INET);
-		if (!opts->md5)
-			goto out_err;
-
-		genhash =3D tcp_v4_md5_hash_skb(newhash, opts->md5, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
-			goto out_err;
-	}
+	opts->md5 =3D tcp_md5_do_lookup(sk,
+				      (union tcp_md5_addr *)&iph->saddr,
+				      AF_INET);
 =

 	if (opts->md5)
 		return TCPOLEN_MD5SIG_ALIGNED;
 =

 	rcu_read_unlock();
 	return 0;
-
-out_err:
-	rcu_read_unlock();
-	return -1;
 }
 =

-void tcp_v4_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
-				    struct tcphdr *t1,
-				    struct tcp_out_options *opts,
-				    const struct sock *sk)
+static __be32 *tcp_v4_md5_send_response_write(__be32 *topt, struct sk_buff=
 *skb,
+					      struct tcphdr *t1,
+					      struct tcp_out_options *opts,
+					      const struct sock *sk)
 {
 	if (opts->md5) {
 		*topt++ =3D htonl((TCPOPT_NOP << 24) |
@@ -617,75 +689,36 @@ void tcp_v4_md5_send_response_write(__be32 *topt, str=
uct sk_buff *skb,
 		tcp_v4_md5_hash_hdr((__u8 *)topt, opts->md5,
 				    ip_hdr(skb)->saddr,
 				    ip_hdr(skb)->daddr, t1);
+
+		topt +=3D 4;
 		rcu_read_unlock();
 	}
+
+	return topt;
 }
 =

 #if IS_ENABLED(CONFIG_IPV6)
-int tcp_v6_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
-				     unsigned int remaining,
-				     struct tcp_out_options *opts,
-				     const struct sock *sk)
+static int tcp_v6_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
+					    unsigned int remaining,
+					    struct tcp_out_options *opts,
+					    const struct sock *sk)
 {
-	const struct tcphdr *th =3D tcp_hdr(skb);
 	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
-	const __u8 *hash_location =3D NULL;
 =

 	rcu_read_lock();
-	hash_location =3D tcp_parse_md5sig_option(th);
-	if (sk && sk_fullsock(sk)) {
-		opts->md5 =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
-	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
-		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
-
-		opts->md5 =3D tcp_twsk_md5_key(tcptw);
-	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
-		opts->md5 =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
-	} else if (hash_location) {
-		unsigned char newhash[16];
-		struct sock *sk1;
-		int genhash;
-
-		/* active side is lost. Try to find listening socket through
-		 * source port, and then find md5 key through listening socket.
-		 * we are not loose security here:
-		 * Incoming packet is checked with md5 hash with finding key,
-		 * no RST generated if md5 hash doesn't match.
-		 */
-		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
-					    &tcp_hashinfo, NULL, 0,
-					    &ipv6h->saddr,
-					    th->source, &ipv6h->daddr,
-					    ntohs(th->source), tcp_v6_iif(skb),
-					    tcp_v6_sdif(skb));
-		if (!sk1)
-			goto out_err;
-
-		opts->md5 =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
-		if (!opts->md5)
-			goto out_err;
-
-		genhash =3D tcp_v6_md5_hash_skb(newhash, opts->md5, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
-			goto out_err;
-	}
+	opts->md5 =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
 =

 	if (opts->md5)
 		return TCPOLEN_MD5SIG_ALIGNED;
 =

 	rcu_read_unlock();
 	return 0;
-
-out_err:
-	rcu_read_unlock();
-	return -1;
 }
-EXPORT_SYMBOL_GPL(tcp_v6_md5_send_response_prepare);
 =

-void tcp_v6_md5_send_response_write(__be32 *topt, struct sk_buff *skb,
-				    struct tcphdr *t1,
-				    struct tcp_out_options *opts,
-				    const struct sock *sk)
+static __be32 *tcp_v6_md5_send_response_write(__be32 *topt, struct sk_buff=
 *skb,
+					      struct tcphdr *t1,
+					      struct tcp_out_options *opts,
+					      const struct sock *sk)
 {
 	if (opts->md5) {
 		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -694,11 +727,42 @@ void tcp_v6_md5_send_response_write(__be32 *topt, str=
uct sk_buff *skb,
 				    &ipv6_hdr(skb)->saddr,
 				    &ipv6_hdr(skb)->daddr, t1);
 =

+		topt +=3D 4;
 		rcu_read_unlock();
 	}
+
+	return topt;
+}
+#endif
+
+static int tcp_md5_send_response_prepare(struct sk_buff *orig, u8 flags,
+					 unsigned int remaining,
+					 struct tcp_out_options *opts,
+					 const struct sock *sk,
+					 struct tcp_extopt_store *store)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (orig->protocol !=3D htons(ETH_P_IP))
+		return tcp_v6_md5_send_response_prepare(orig, flags, remaining,
+							opts, sk);
+	else
+#endif
+		return tcp_v4_md5_send_response_prepare(orig, flags, remaining,
+							opts, sk);
 }
-EXPORT_SYMBOL_GPL(tcp_v6_md5_send_response_write);
+
+static __be32 *tcp_md5_send_response_write(__be32 *ptr, struct sk_buff *or=
ig,
+					   struct tcphdr *th,
+					   struct tcp_out_options *opts,
+					   const struct sock *sk,
+					   struct tcp_extopt_store *store)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (orig->protocol !=3D htons(ETH_P_IP))
+		return tcp_v6_md5_send_response_write(ptr, orig, th, opts, sk);
 #endif
+	return tcp_v4_md5_send_response_write(ptr, orig, th, opts, sk);
+}
 =

 struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 					 const struct sock *addr_sk)
@@ -909,59 +973,6 @@ bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 	return false;
 }
 EXPORT_SYMBOL_GPL(tcp_v6_inbound_md5_hash);
-#endif
-
-void tcp_v4_md5_destroy_sock(struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	/* Clean up the MD5 key list, if any */
-	if (tp->md5sig_info) {
-		tcp_clear_md5_list(sk);
-		kfree_rcu(tp->md5sig_info, rcu);
-		tp->md5sig_info =3D NULL;
-	}
-}
-
-void tcp_v4_md5_syn_recv_sock(const struct sock *listener, struct sock *sk)
-{
-	struct inet_sock *inet =3D inet_sk(sk);
-	struct tcp_md5sig_key *key;
-
-	/* Copy over the MD5 key from the original socket */
-	key =3D tcp_md5_do_lookup(listener, (union tcp_md5_addr *)&inet->inet_dad=
dr,
-				AF_INET);
-	if (key) {
-		/* We're using one, so create a matching key
-		 * on the sk structure. If we fail to get
-		 * memory, then we end up not copying the key
-		 * across. Shucks.
-		 */
-		tcp_md5_do_add(sk, (union tcp_md5_addr *)&inet->inet_daddr,
-			       AF_INET, 32, key->key, key->keylen, GFP_ATOMIC);
-		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
-	}
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-void tcp_v6_md5_syn_recv_sock(const struct sock *listener, struct sock *sk)
-{
-	struct tcp_md5sig_key *key;
-
-	/* Copy over the MD5 key from the original socket */
-	key =3D tcp_v6_md5_do_lookup(listener, &sk->sk_v6_daddr);
-	if (key) {
-		/* We're using one, so create a matching key
-		 * on the newsk structure. If we fail to get
-		 * memory, then we end up not copying the key
-		 * across. Shucks.
-		 */
-		tcp_md5_do_add(sk, (union tcp_md5_addr *)&sk->sk_v6_daddr,
-			       AF_INET6, 128, key->key, key->keylen,
-			       sk_gfp_mask(sk, GFP_ATOMIC));
-	}
-}
-EXPORT_SYMBOL_GPL(tcp_v6_md5_syn_recv_sock);
 =

 struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
 					 const struct sock *addr_sk)
@@ -971,25 +982,6 @@ struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct =
sock *sk,
 EXPORT_SYMBOL_GPL(tcp_v6_md5_lookup);
 #endif
 =

-void tcp_md5_time_wait(struct sock *sk, struct inet_timewait_sock *tw)
-{
-	struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct tcp_md5sig_key *key;
-
-	/* The timewait bucket does not have the key DB from the
-	 * sock structure. We just make a quick copy of the
-	 * md5 key being used (if indeed we are using one)
-	 * so the timewait ack generating code has the key.
-	 */
-	tcptw->tw_md5_key =3D NULL;
-	key =3D tp->af_specific->md5_lookup(sk, sk);
-	if (key) {
-		tcptw->tw_md5_key =3D kmemdup(key, sizeof(*key), GFP_ATOMIC);
-		BUG_ON(tcptw->tw_md5_key && !tcp_alloc_md5sig_pool());
-	}
-}
-
 static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
 				 const struct tcp_md5sig_key *key)
 {
@@ -1039,13 +1031,17 @@ static int tcp_diag_put_md5sig(struct sk_buff *skb,
 int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buff *=
skb)
 {
 	if (net_admin) {
+		struct tcp_md5_extopt *md5_opt;
 		struct tcp_md5sig_info *md5sig;
 		int err =3D 0;
 =

 		rcu_read_lock();
-		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
-		if (md5sig)
-			err =3D tcp_diag_put_md5sig(skb, md5sig);
+		md5_opt =3D (struct tcp_md5_extopt *)tcp_extopt_find_kind(TCPOPT_MD5SIG,=
 sk);
+		if (md5_opt) {
+			md5sig =3D rcu_dereference(md5_opt->md5sig_info);
+			if (md5sig)
+				err =3D tcp_diag_put_md5sig(skb, md5sig);
+		}
 		rcu_read_unlock();
 		if (err < 0)
 			return err;
@@ -1060,15 +1056,19 @@ int tcp_md5_diag_get_aux_size(struct sock *sk, bool=
 net_admin)
 	int size =3D 0;
 =

 	if (net_admin && sk_fullsock(sk)) {
+		struct tcp_md5_extopt *md5_opt;
 		const struct tcp_md5sig_info *md5sig;
 		const struct tcp_md5sig_key *key;
 		size_t md5sig_count =3D 0;
 =

 		rcu_read_lock();
-		md5sig =3D rcu_dereference(tcp_sk(sk)->md5sig_info);
-		if (md5sig) {
-			hlist_for_each_entry_rcu(key, &md5sig->head, node)
-				md5sig_count++;
+		md5_opt =3D (struct tcp_md5_extopt *)tcp_extopt_find_kind(TCPOPT_MD5SIG,=
 sk);
+		if (md5_opt) {
+			md5sig =3D rcu_dereference(md5_opt->md5sig_info);
+			if (md5sig) {
+				hlist_for_each_entry_rcu(key, &md5sig->head, node)
+					md5sig_count++;
+			}
 		}
 		rcu_read_unlock();
 		size +=3D nla_total_size(md5sig_count *
@@ -1079,6 +1079,260 @@ int tcp_md5_diag_get_aux_size(struct sock *sk, bool=
 net_admin)
 }
 EXPORT_SYMBOL_GPL(tcp_md5_diag_get_aux_size);
 =

+static int tcp_md5_extopt_add_header_len(const struct sock *listener,
+					 const struct sock *sk,
+					 struct tcp_extopt_store *store)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	if (tp->af_specific->md5_lookup(listener, sk))
+		return TCPOLEN_MD5SIG_ALIGNED;
+
+	return 0;
+}
+
+static unsigned int tcp_md5_extopt_prepare(struct sk_buff *skb, u8 flags,
+					   unsigned int remaining,
+					   struct tcp_out_options *opts,
+					   const struct sock *sk,
+					   struct tcp_extopt_store *store)
+{
+	int ret =3D 0;
+
+	if (sk_fullsock(sk)) {
+		struct tcp_sock *tp =3D tcp_sk(sk);
+
+		opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
+	} else {
+		struct request_sock *req =3D inet_reqsk(sk);
+		struct sock *listener =3D req->rsk_listener;
+
+		/* Coming from tcp_make_synack, unlock is in
+		 * tcp_md5_extopt_write
+		 */
+		rcu_read_lock();
+
+		opts->md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(listener, sk);
+
+		if (!opts->md5)
+			rcu_read_unlock();
+	}
+
+	if (unlikely(opts->md5)) {
+		ret =3D TCPOLEN_MD5SIG_ALIGNED;
+		opts->options |=3D OPTION_MD5;
+
+		/* Don't use TCP timestamps with TCP_MD5 */
+		if ((opts->options & OPTION_TS)) {
+			ret -=3D TCPOLEN_TSTAMP_ALIGNED;
+
+			/* When TS are enabled, Linux puts the SACK_OK
+			 * next to the timestamp option, thus not accounting
+			 * for its space. Here, we disable timestamps, thus
+			 * we need to account for the space.
+			 */
+			if (opts->options & OPTION_SACK_ADVERTISE)
+				ret +=3D TCPOLEN_SACKPERM_ALIGNED;
+		}
+
+		opts->options &=3D ~OPTION_TS;
+		opts->tsval =3D 0;
+		opts->tsecr =3D 0;
+
+		if (!sk_fullsock(sk)) {
+			struct request_sock *req =3D inet_reqsk(sk);
+
+			inet_rsk(req)->tstamp_ok =3D 0;
+		}
+	}
+
+	return ret;
+}
+
+static __be32 *tcp_md5_extopt_write(__be32 *ptr, struct sk_buff *skb,
+				    struct tcp_out_options *opts,
+				    struct sock *sk,
+				    struct tcp_extopt_store *store)
+{
+	if (unlikely(OPTION_MD5 & opts->options)) {
+#if IS_ENABLED(CONFIG_IPV6)
+		const struct in6_addr *addr6;
+
+		if (sk_fullsock(sk)) {
+			addr6 =3D &sk->sk_v6_daddr;
+		} else {
+			BUG_ON(sk->sk_state !=3D TCP_NEW_SYN_RECV);
+			addr6 =3D &inet_rsk(inet_reqsk(sk))->ir_v6_rmt_addr;
+		}
+#endif
+
+		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
+			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
+
+		if (sk_fullsock(sk))
+			sk_nocaps_add(sk, NETIF_F_GSO_MASK);
+
+		/* Calculate the MD5 hash, as we have all we need now */
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family =3D=3D AF_INET6 && !ipv6_addr_v4mapped(addr6))
+			tcp_v6_md5_hash_skb((__u8 *)ptr, opts->md5, sk, skb);
+		else
+#endif
+			tcp_v4_md5_hash_skb((__u8 *)ptr, opts->md5, sk, skb);
+
+		ptr +=3D 4;
+
+		/* Coming from tcp_make_synack */
+		if (!sk_fullsock(sk))
+			rcu_read_unlock();
+	}
+
+	return ptr;
+}
+
+static struct tcp_md5_extopt *__tcp_md5_extopt_copy(struct request_sock *r=
eq,
+						    const struct tcp_md5sig_key *key,
+						    const union tcp_md5_addr *addr,
+						    int family)
+{
+	struct tcp_md5_extopt *md5_opt =3D NULL;
+	struct tcp_md5sig_info *md5sig;
+	struct tcp_md5sig_key *newkey;
+
+	md5_opt =3D tcp_md5_alloc_store(req_to_sk(req));
+	if (!md5_opt)
+		goto err;
+
+	md5sig =3D kmalloc(sizeof(*md5sig), GFP_ATOMIC);
+	if (!md5sig)
+		goto err_md5sig;
+
+	INIT_HLIST_HEAD(&md5sig->head);
+	rcu_assign_pointer(md5_opt->md5sig_info, md5sig);
+
+	newkey =3D kmalloc(sizeof(*newkey), GFP_ATOMIC);
+	if (!newkey)
+		goto err_newkey;
+
+	memcpy(newkey->key, key->key, key->keylen);
+	newkey->keylen =3D key->keylen;
+	newkey->family =3D family;
+	newkey->prefixlen =3D 32;
+	memcpy(&newkey->addr, addr,
+	       (family =3D=3D AF_INET6) ? sizeof(struct in6_addr) :
+				      sizeof(struct in_addr));
+	hlist_add_head_rcu(&newkey->node, &md5sig->head);
+
+	return md5_opt;
+
+err_newkey:
+	kfree(md5sig);
+err_md5sig:
+	kfree_rcu(md5_opt, rcu);
+err:
+	return NULL;
+}
+
+static struct tcp_extopt_store *tcp_md5_v4_extopt_copy(const struct sock *=
listener,
+						       struct request_sock *req)
+{
+	struct inet_request_sock *ireq =3D inet_rsk(req);
+	struct tcp_md5sig_key *key;
+
+	/* Copy over the MD5 key from the original socket */
+	key =3D tcp_md5_do_lookup(listener,
+				(union tcp_md5_addr *)&ireq->ir_rmt_addr,
+				AF_INET);
+	if (!key)
+		return NULL;
+
+	return (struct tcp_extopt_store *)__tcp_md5_extopt_copy(req, key,
+				(union tcp_md5_addr *)&ireq->ir_rmt_addr,
+				AF_INET);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct tcp_extopt_store *tcp_md5_v6_extopt_copy(const struct sock *=
listener,
+						       struct request_sock *req)
+{
+	struct inet_request_sock *ireq =3D inet_rsk(req);
+	struct tcp_md5sig_key *key;
+
+	/* Copy over the MD5 key from the original socket */
+	key =3D tcp_v6_md5_do_lookup(listener, &ireq->ir_v6_rmt_addr);
+	if (!key)
+		return NULL;
+
+	return (struct tcp_extopt_store *)__tcp_md5_extopt_copy(req, key,
+				(union tcp_md5_addr *)&ireq->ir_v6_rmt_addr,
+				AF_INET6);
+}
+#endif
+
+/* We are creating a new request-socket, based on the listener's key that
+ * matches the IP-address. Thus, we need to create a new tcp_extopt_store,=
 and
+ * store the matching key in there for the request-sock.
+ */
+static struct tcp_extopt_store *tcp_md5_extopt_copy(struct sock *listener,
+						    struct request_sock *req,
+						    struct tcp_options_received *opt,
+						    struct tcp_extopt_store *store)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct inet_request_sock *ireq =3D inet_rsk(req);
+
+	if (ireq->ireq_family =3D=3D AF_INET6)
+		return tcp_md5_v6_extopt_copy(listener, req);
+#endif
+	return tcp_md5_v4_extopt_copy(listener, req);
+}
+
+/* Moving from a request-sock to a full socket means we need to account for
+ * the memory and set GSO-flags. When moving from a full socket to ta time=
-wait
+ * socket we also need to adjust the memory accounting.
+ */
+static struct tcp_extopt_store *tcp_md5_extopt_move(struct sock *from,
+						    struct sock *to,
+						    struct tcp_extopt_store *store)
+{
+	struct tcp_md5_extopt *md5_opt =3D (struct tcp_md5_extopt *)store;
+	unsigned int size =3D sizeof(struct tcp_md5sig_key);
+
+	if (sk_fullsock(to)) {
+		/* From request-sock to full socket */
+
+		if (size > sysctl_optmem_max ||
+		    atomic_read(&to->sk_omem_alloc) + size >=3D sysctl_optmem_max) {
+			tcp_md5_extopt_destroy(store);
+			return NULL;
+		}
+
+		sk_nocaps_add(to, NETIF_F_GSO_MASK);
+		atomic_add(size, &to->sk_omem_alloc);
+	} else if (sk_fullsock(from)) {
+		/* From full socket to time-wait-socket */
+		atomic_sub(size, &from->sk_omem_alloc);
+	}
+
+	md5_opt->sk =3D to;
+
+	return store;
+}
+
+static void tcp_md5_extopt_destroy(struct tcp_extopt_store *store)
+{
+	struct tcp_md5_extopt *md5_opt =3D (struct tcp_md5_extopt *)store;
+
+	/* Clean up the MD5 key list, if any */
+	if (md5_opt) {
+		tcp_clear_md5_list(md5_opt);
+		kfree_rcu(md5_opt->md5sig_info, rcu);
+		md5_opt->md5sig_info =3D NULL;
+
+		kfree_rcu(md5_opt, rcu);
+	}
+}
+
 const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
 	.md5_lookup	=3D tcp_v4_md5_lookup,
 	.calc_md5_hash	=3D tcp_v4_md5_hash_skb,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index aeb68687a75c..e04c2e945326 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-#include <linux/tcp_md5.h>
 #include <linux/workqueue.h>
 #include <linux/static_key.h>
 #include <net/tcp.h>
@@ -295,9 +294,6 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o)
 			tcp_extopt_move(sk, (struct sock *)tw);
 			INIT_HLIST_HEAD(&tcp_sk(sk)->tcp_option_list);
 		}
-#ifdef CONFIG_TCP_MD5SIG
-		tcp_md5_time_wait(sk, tw);
-#endif
 =

 		/* Get the TIME_WAIT timeout firing. */
 		if (timeo < rto)
@@ -331,10 +327,6 @@ void tcp_time_wait(struct sock *sk, int state, int tim=
eo)
 =

 void tcp_twsk_destructor(struct sock *sk)
 {
-#ifdef CONFIG_TCP_MD5SIG
-	tcp_md5_twsk_destructor(sk);
-#endif
-
 	if (static_branch_unlikely(&tcp_extopt_enabled))
 		tcp_extopt_destroy(sk);
 }
@@ -519,10 +511,6 @@ struct sock *tcp_create_openreq_child(const struct soc=
k *sk,
 			newtp->tcp_header_len =3D sizeof(struct tcphdr);
 		}
 		newtp->tsoffset =3D treq->ts_off;
-#ifdef CONFIG_TCP_MD5SIG
-		newtp->md5sig_info =3D NULL;	/*XXX*/
-		tcp_md5_add_header_len(sk, newsk);
-#endif
 		if (static_branch_unlikely(&tcp_extopt_enabled))
 			newtp->tcp_header_len +=3D tcp_extopt_add_header(sk, newsk);
 =

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e15006277275..5d40bcb0952f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -42,7 +42,6 @@
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/static_key.h>
-#include <linux/tcp_md5.h>
 =

 #include <trace/events/tcp.h>
 =

@@ -421,14 +420,6 @@ static void tcp_options_write(__be32 *ptr, struct sk_b=
uff *skb, struct sock *sk,
 	if (sk_fullsock(sk))
 		tp =3D tcp_sk(sk);
 =

-	if (unlikely(OPTION_MD5 & options)) {
-		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
-			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
-		/* overload cookie hash location */
-		opts->hash_location =3D (__u8 *)ptr;
-		ptr +=3D 4;
-	}
-
 	if (unlikely(opts->mss)) {
 		*ptr++ =3D htonl((TCPOPT_MSS << 24) |
 			       (TCPOLEN_MSS << 16) |
@@ -524,14 +515,6 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
truct sk_buff *skb,
 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
 	struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
-	if (opts->md5) {
-		opts->options |=3D OPTION_MD5;
-		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
-	}
-#endif
-
 	/* We always get an MSS option.  The option bytes which will be seen in
 	 * normal data packets should timestamps be used, must be in the MSS
 	 * advertised.  But we subtract them from tp->mss_cache so that
@@ -544,7 +527,7 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 	opts->mss =3D tcp_advertise_mss(sk);
 	remaining -=3D TCPOLEN_MSS_ALIGNED;
 =

-	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps && !opts->md5)) {
+	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps)) {
 		opts->options |=3D OPTION_TS;
 		opts->tsval =3D tcp_skb_timestamp(skb) + tp->tsoffset;
 		opts->tsecr =3D tp->rx_opt.ts_recent;
@@ -593,20 +576,6 @@ static unsigned int tcp_synack_options(const struct so=
ck *sk,
 	struct inet_request_sock *ireq =3D inet_rsk(req);
 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	if (opts->md5) {
-		opts->options |=3D OPTION_MD5;
-		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
-
-		/* We can't fit any SACK blocks in a packet with MD5 + TS
-		 * options. There was discussion about disabling SACK
-		 * rather than TS in order to fit in better with old,
-		 * buggy kernels, but that was deemed to be unnecessary.
-		 */
-		ireq->tstamp_ok &=3D !ireq->sack_ok;
-	}
-#endif
-
 	/* We always send an MSS option. */
 	opts->mss =3D mss;
 	remaining -=3D TCPOLEN_MSS_ALIGNED;
@@ -667,16 +636,6 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

-#ifdef CONFIG_TCP_MD5SIG
-	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
-	if (unlikely(opts->md5)) {
-		opts->options |=3D OPTION_MD5;
-		size +=3D TCPOLEN_MD5SIG_ALIGNED;
-	}
-#else
-	opts->md5 =3D NULL;
-#endif
-
 	if (static_branch_unlikely(&tcp_extopt_enabled))
 		size +=3D tcp_extopt_prepare(skb, 0, MAX_TCP_OPTION_SPACE - size,
 					   opts, tcp_to_sk(tp));
@@ -1079,14 +1038,6 @@ static int tcp_transmit_skb(struct sock *sk, struct =
sk_buff *skb, int clone_it,
 		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
 	}
 	tcp_options_write((__be32 *)(th + 1), skb, sk, &opts);
-#ifdef CONFIG_TCP_MD5SIG
-	/* Calculate the MD5 hash, as we have all we need now */
-	if (opts.md5) {
-		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
-		tp->af_specific->calc_md5_hash(opts.hash_location,
-					       opts.md5, sk, skb);
-	}
-#endif
 =

 	icsk->icsk_af_ops->send_check(sk, skb);
 =

@@ -3159,10 +3110,6 @@ struct sk_buff *tcp_make_synack(const struct sock *s=
k, struct dst_entry *dst,
 #endif
 		skb->skb_mstamp =3D tcp_clock_us();
 =

-#ifdef CONFIG_TCP_MD5SIG
-	rcu_read_lock();
-	opts.md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req)=
);
-#endif
 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
 	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts,
 					     foc) + sizeof(*th);
@@ -3189,15 +3136,6 @@ struct sk_buff *tcp_make_synack(const struct sock *s=
k, struct dst_entry *dst,
 	tcp_options_write((__be32 *)(th + 1), skb, req_to_sk(req), &opts);
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 =

-#ifdef CONFIG_TCP_MD5SIG
-	/* Okay, we have all we need - do the md5 hash if needed */
-	if (opts.md5)
-		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
-							 opts.md5,
-							 req_to_sk(req), skb);
-	rcu_read_unlock();
-#endif
-
 	/* Do not fool tcpdump (if any), clean our debris */
 	skb->tstamp =3D 0;
 	return skb;
@@ -3238,10 +3176,6 @@ static void tcp_connect_init(struct sock *sk)
 	if (sock_net(sk)->ipv4.sysctl_tcp_timestamps)
 		tp->tcp_header_len +=3D TCPOLEN_TSTAMP_ALIGNED;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	tcp_md5_add_header_len(sk, sk);
-#endif
-
 	if (static_branch_unlikely(&tcp_extopt_enabled))
 		tp->tcp_header_len +=3D tcp_extopt_add_header(sk, sk);
 =

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 69ceebebb123..41a70f458b79 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -576,20 +576,6 @@ static void tcp_v6_send_response(const struct sock *sk=
, struct sk_buff *skb, u32
 =

 	if (tsecr)
 		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
-#ifdef CONFIG_TCP_MD5SIG
-{
-	int ret;
-
-	ret =3D tcp_v6_md5_send_response_prepare(skb, 0,
-					       MAX_TCP_OPTION_SPACE - tot_len,
-					       &extraopts, sk);
-
-	if (ret =3D=3D -1)
-		goto out;
-
-	tot_len +=3D ret;
-}
-#endif
 =

 	if (static_branch_unlikely(&tcp_extopt_enabled)) {
 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - tot_len;
@@ -635,11 +621,6 @@ static void tcp_v6_send_response(const struct sock *sk=
, struct sk_buff *skb, u32
 		*topt++ =3D htonl(tsecr);
 	}
 =

-#ifdef CONFIG_TCP_MD5SIG
-	if (extraopts.md5)
-		tcp_v6_md5_send_response_write(topt, skb, t1, &extraopts, sk);
-#endif
-
 	if (static_branch_unlikely(&tcp_extopt_enabled))
 		tcp_extopt_response_write(topt, skb, t1, &extraopts, sk);
 =

@@ -958,10 +939,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct =
sock *sk, struct sk_buff *
 		INIT_HLIST_HEAD(&tcp_rsk(req)->tcp_option_list);
 	}
 =

-#ifdef CONFIG_TCP_MD5SIG
-	tcp_v6_md5_syn_recv_sock(sk, newsk);
-#endif
-
 	if (__inet_inherit_port(sk, newsk) < 0) {
 		inet_csk_prepare_forced_close(newsk);
 		tcp_done(newsk);
-- =

2.15.0


--===============4137271173799527809==--
