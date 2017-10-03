Content-Type: multipart/mixed; boundary="===============4650188439467924500=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 17/18] tcp_md5: Use tcp_extra_options in output path
Date: Tue, 03 Oct 2017 09:22:03 -0700
Message-ID: <20171003162204.17945-18-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 100

--===============4650188439467924500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch starts making use of the extra_option framework for TCP_MD5.

One tricky part is that extra_options are called at the end of the
option-functions while TCP_MD5 is called at the beginning.

TCP_MD5 is called at the beginning because it wants to disable
TCP-timestamps (for option-space reasons). So, in the _prepare-function
of the extra options we need to undo the work that was done when
enabling TCP timestamps.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h      |   2 -
 include/linux/tcp_md5.h  |  14 ++----
 net/ipv4/tcp.c           |   2 +
 net/ipv4/tcp_md5.c       | 118 +++++++++++++++++++++++++++++++++++++++++++=
++++
 net/ipv4/tcp_minisocks.c |   3 --
 net/ipv4/tcp_output.c    |  69 +--------------------------
 6 files changed, 125 insertions(+), 83 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3c00b40554ab..c1cbc12cce9f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -123,8 +123,6 @@ struct tcp_out_options {
 	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_sack_blocks;	/* number of SACK blocks to include */
-	u8 hash_size;		/* bytes in hash_location */
-	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
 	struct tcp_md5sig_key *md5; /* TCP_MD5 signature key */
diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
index 73595e9783ed..4e37524d5f1e 100644
--- a/include/linux/tcp_md5.h
+++ b/include/linux/tcp_md5.h
@@ -96,20 +96,12 @@ static inline void tcp_md5_twsk_destructor(struct sock =
*sk)
 		kfree_rcu(twsk->tw_md5_key, rcu);
 }
 =

-static inline void tcp_md5_add_header_len(const struct sock *listener,
-					  struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	tp->md5sig_info =3D NULL;	/*XXX*/
-	if (tp->af_specific->md5_lookup(listener, sk))
-		tp->tcp_header_len +=3D TCPOLEN_MD5SIG_ALIGNED;
-}
-
 int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buff *=
skb);
 =

 int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin);
 =

+void tcp_md5_register(void);
+
 #else
 =

 static inline bool tcp_v4_inbound_md5_hash(const struct sock *sk,
@@ -124,6 +116,8 @@ static inline bool tcp_v6_inbound_md5_hash(const struct=
 sock *sk,
 	return false;
 }
 =

+static inline void tcp_md5_register(void) {}
+
 #endif
 =

 #endif /* _LINUX_TCP_MD5_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 22ff47bb602d..91f3ec72b5ea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3567,4 +3567,6 @@ void __init tcp_init(void)
 	tcp_metrics_init();
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) !=3D 0);
 	tcp_tasklet_init();
+
+	tcp_md5_register();
 }
diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
index 89a9a5457412..dcccbbcb8995 100644
--- a/net/ipv4/tcp_md5.c
+++ b/net/ipv4/tcp_md5.c
@@ -1060,6 +1060,119 @@ int tcp_md5_diag_get_aux_size(struct sock *sk, bool=
 net_admin)
 	return size;
 }
 =

+static int tcp_md5_extra_option_add_header_len(const struct sock *listener,
+					       const struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+
+	tp->md5sig_info =3D NULL;	/*XXX*/
+	if (tp->af_specific->md5_lookup(listener, sk))
+		return TCPOLEN_MD5SIG_ALIGNED;
+
+	return 0;
+}
+
+static unsigned int tcp_md5_extra_option_prepare(struct sk_buff *skb, u8 f=
lags,
+						 unsigned int remaining,
+						 struct tcp_out_options *opts,
+						 struct sock *sk)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	int ret =3D 0;
+
+	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
+	if (unlikely(opts->md5)) {
+		ret =3D TCPOLEN_MD5SIG_ALIGNED;
+		opts->options |=3D OPTION_MD5;
+
+		/* Don't use TCP timestamps with TCP_MD5 */
+		if (opts->options & OPTION_TS)
+			ret -=3D TCPOLEN_TSTAMP_ALIGNED;
+		opts->options &=3D ~OPTION_TS;
+		opts->tsval =3D 0;
+		opts->tsecr =3D 0;
+	}
+
+	return ret;
+}
+
+static unsigned int tcp_md5_extra_option_prepare_req(struct sk_buff *skb, =
u8 flags,
+						     unsigned int remaining,
+						     struct tcp_out_options *opts,
+						     struct request_sock *req,
+						     const struct sock *sk)
+{
+	struct inet_request_sock *ireq =3D inet_rsk(req);
+	int ret =3D 0;
+
+	/* Unlock is in tcp_md5_extra_option_write */
+	rcu_read_lock();
+	opts->md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req=
));
+
+	if (opts->md5) {
+		ret =3D TCPOLEN_MD5SIG_ALIGNED;
+		opts->options |=3D OPTION_MD5;
+
+		/* We can't fit any SACK blocks in a packet with MD5 + TS
+		 * options. There was discussion about disabling SACK
+		 * rather than TS in order to fit in better with old,
+		 * buggy kernels, but that was deemed to be unnecessary.
+		 */
+		if (ireq->tstamp_ok && ireq->sack_ok) {
+			ireq->tstamp_ok =3D 0;
+
+			ret -=3D TCPOLEN_TSTAMP_ALIGNED;
+
+			opts->options &=3D ~OPTION_TS;
+			opts->tsval =3D 0;
+			opts->tsecr =3D 0;
+		}
+	} else {
+		rcu_read_unlock();
+	}
+
+	return ret;
+}
+
+static void tcp_md5_extra_option_write(__be32 *ptr, struct sk_buff *skb,
+				       struct tcp_out_options *opts,
+				       struct sock *sk)
+{
+	if (unlikely(OPTION_MD5 & opts->options)) {
+		struct in6_addr *addr6;
+
+		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
+			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
+
+		if (sk && sk_fullsock(sk))
+			sk_nocaps_add(sk, NETIF_F_GSO_MASK);
+
+		if (sk_fullsock(sk))
+			addr6 =3D &sk->sk_v6_daddr;
+		else
+			addr6 =3D &inet_rsk(inet_reqsk(sk))->ir_v6_rmt_addr;
+
+		/* Calculate the MD5 hash, as we have all we need now */
+		if (sk->sk_family =3D=3D AF_INET6 && !ipv6_addr_v4mapped(addr6))
+			tcp_v6_md5_hash_skb((__u8 *)ptr, opts->md5, sk, skb);
+		else
+			tcp_v4_md5_hash_skb((__u8 *)ptr, opts->md5, sk, skb);
+
+		/* Coming from tcp_make_synack */
+		if (!sk_fullsock(sk))
+			rcu_read_unlock();
+	}
+}
+
+static struct tcp_extra_option_ops tcp_md5_extra_ops __read_mostly =3D {
+	.option_kind	=3D TCPOPT_MD5SIG,
+	.prepare	=3D tcp_md5_extra_option_prepare,
+	.prepare_req	=3D tcp_md5_extra_option_prepare_req,
+	.write		=3D tcp_md5_extra_option_write,
+	.add_header_len	=3D tcp_md5_extra_option_add_header_len,
+	.owner		=3D THIS_MODULE,
+};
+
 const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
 	.md5_lookup	=3D tcp_v4_md5_lookup,
 	.calc_md5_hash	=3D tcp_v4_md5_hash_skb,
@@ -1078,3 +1191,8 @@ const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_spe=
cific =3D {
 	.md5_parse	=3D	tcp_v6_parse_md5_keys,
 };
 =

+void tcp_md5_register(void)
+{
+	tcp_register_extra_option(&tcp_md5_extra_ops);
+}
+
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 587310fb588d..653bb07ebbc6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -503,9 +503,6 @@ struct sock *tcp_create_openreq_child(const struct sock=
 *sk,
 			newtp->tcp_header_len =3D sizeof(struct tcphdr);
 		}
 		newtp->tsoffset =3D treq->ts_off;
-#ifdef CONFIG_TCP_MD5SIG
-		tcp_md5_add_header_len(sk, newsk);
-#endif
 		if (static_branch_unlikely(&tcp_extra_options_enabled))
 			newtp->tcp_header_len +=3D tcp_extra_options_add_header(sk, newsk);
 =

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 75fa9d079a56..fc0753996b0a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -437,14 +437,6 @@ static void tcp_options_write(__be32 *ptr, struct sk_b=
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
@@ -540,16 +532,6 @@ static unsigned int tcp_syn_options(struct sock *sk, s=
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
-#else
-	opts->md5 =3D NULL;
-#endif
-
 	/* We always get an MSS option.  The option bytes which will be seen in
 	 * normal data packets should timestamps be used, must be in the MSS
 	 * advertised.  But we subtract them from tp->mss_cache so that
@@ -562,7 +544,7 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 	opts->mss =3D tcp_advertise_mss(sk);
 	remaining -=3D TCPOLEN_MSS_ALIGNED;
 =

-	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps && !opts->md5)) {
+	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps)) {
 		opts->options |=3D OPTION_TS;
 		opts->tsval =3D tcp_skb_timestamp(skb) + tp->tsoffset;
 		opts->tsecr =3D tp->rx_opt.ts_recent;
@@ -611,20 +593,6 @@ static unsigned int tcp_synack_options(const struct so=
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
@@ -688,16 +656,6 @@ static unsigned int tcp_established_options(struct soc=
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
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		size +=3D tcp_extra_options_prepare(skb, 0,
 						  MAX_TCP_OPTION_SPACE - size,
@@ -1089,14 +1047,6 @@ static int tcp_transmit_skb(struct sock *sk, struct =
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

@@ -3159,10 +3109,6 @@ struct sk_buff *tcp_make_synack(const struct sock *s=
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
 	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts, foc) +
 			  sizeof(*th);
@@ -3194,15 +3140,6 @@ struct sk_buff *tcp_make_synack(const struct sock *s=
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
@@ -3243,10 +3180,6 @@ static void tcp_connect_init(struct sock *sk)
 	if (sock_net(sk)->ipv4.sysctl_tcp_timestamps)
 		tp->tcp_header_len +=3D TCPOLEN_TSTAMP_ALIGNED;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	tcp_md5_add_header_len(sk, sk);
-#endif
-
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		tp->tcp_header_len +=3D tcp_extra_options_add_header(sk, sk);
 =

-- =

2.14.1


--===============4650188439467924500==--
