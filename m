Content-Type: multipart/mixed; boundary="===============5983203129497314916=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 20/25] tcp_smc: Make SMC use TCP extra-option
 framework
Date: Mon, 27 Nov 2017 21:57:21 -0800
Message-ID: <20171128055726.430-21-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 195

--===============5983203129497314916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cc: Ursula Braun <ubraun(a)linux.vnet.ibm.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp.h      |   3 +-
 include/net/inet_sock.h  |   3 +-
 include/net/tcp.h        |   4 --
 net/ipv4/tcp.c           |   6 +-
 net/ipv4/tcp_input.c     |  36 ----------
 net/ipv4/tcp_minisocks.c |  18 -----
 net/ipv4/tcp_output.c    |  54 ---------------
 net/smc/af_smc.c         | 170 +++++++++++++++++++++++++++++++++++++++++++=
++--
 8 files changed, 167 insertions(+), 127 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 4f653e3bd33f..c04b7e4f5309 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -257,8 +257,7 @@ struct tcp_sock {
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
 		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
 		save_syn:1,	/* Save headers of SYN packet */
-		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
-		syn_smc:1;	/* SYN includes SMC */
+		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
 	u32	tlp_high_seq;	/* snd_nxt at the time of TLP retransmit. */
 =

 /* RTT measurement */
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 39efb968b7a4..8e51b4a69088 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -90,8 +90,7 @@ struct inet_request_sock {
 				wscale_ok  : 1,
 				ecn_ok	   : 1,
 				acked	   : 1,
-				no_srccheck: 1,
-				smc_ok	   : 1;
+				no_srccheck: 1;
 	u32                     ir_mark;
 	union {
 		struct ip_options_rcu __rcu	*ireq_opt;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9b99209d726..beedb639e664 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2062,10 +2062,6 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock =
*sk)
 	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN) =3D=3D 1);
 }
 =

-#if IS_ENABLED(CONFIG_SMC)
-extern struct static_key_false tcp_have_smc;
-#endif
-
 extern struct static_key_false tcp_extra_options_enabled;
 struct tcp_extra_option_store;
 =

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5a9269e9ca2b..3090fac3c462 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -294,11 +294,6 @@ EXPORT_SYMBOL(sysctl_tcp_mem);
 atomic_long_t tcp_memory_allocated;	/* Current allocated memory. */
 EXPORT_SYMBOL(tcp_memory_allocated);
 =

-#if IS_ENABLED(CONFIG_SMC)
-DEFINE_STATIC_KEY_FALSE(tcp_have_smc);
-EXPORT_SYMBOL(tcp_have_smc);
-#endif
-
 /*
  * Current number of TCP sockets.
  */
@@ -3506,6 +3501,7 @@ struct tcp_extra_option_store *tcp_extra_options_find=
_kind(u32 kind,
 =

 	return entry;
 }
+EXPORT_SYMBOL_GPL(tcp_extra_options_find_kind);
 =

 void tcp_extra_options_parse(u32 opcode, int opsize, const unsigned char *=
opptr,
 			     const struct sk_buff *skb,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index dba59c8ae627..5dd19c3f37ce 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3668,24 +3668,6 @@ static void tcp_parse_fastopen_option(int len, const=
 unsigned char *cookie,
 	foc->exp =3D exp_opt;
 }
 =

-static int smc_parse_options(const struct tcphdr *th,
-			     struct tcp_options_received *opt_rx,
-			     const unsigned char *ptr,
-			     int opsize)
-{
-#if IS_ENABLED(CONFIG_SMC)
-	if (static_branch_unlikely(&tcp_have_smc)) {
-		if (th->syn && !(opsize & 1) &&
-		    opsize >=3D TCPOLEN_EXP_SMC_BASE &&
-		    get_unaligned_be32(ptr) =3D=3D TCPOPT_SMC_MAGIC) {
-			opt_rx->smc_ok =3D 1;
-			return 1;
-		}
-	}
-#endif
-	return 0;
-}
-
 /* Look for tcp options. Normally only called on SYN and SYNACK packets.
  * But, this can also be called on packets in the established flow when
  * the fast version below fails.
@@ -3793,9 +3775,6 @@ void tcp_parse_options(const struct net *net,
 					tcp_parse_fastopen_option(opsize -
 						TCPOLEN_EXP_FASTOPEN_BASE,
 						ptr + 2, th->syn, foc, true);
-				else if (smc_parse_options(th, opt_rx, ptr,
-							   opsize))
-					break;
 				else if (static_branch_unlikely(&tcp_extra_options_enabled) &&
 					 opsize >=3D TCPOLEN_EXP_BASE)
 					tcp_extra_options_parse(get_unaligned_be32(ptr),
@@ -5574,16 +5553,6 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk,=
 struct sk_buff *synack,
 	return false;
 }
 =

-static void smc_check_reset_syn(struct tcp_sock *tp)
-{
-#if IS_ENABLED(CONFIG_SMC)
-	if (static_branch_unlikely(&tcp_have_smc)) {
-		if (tp->syn_smc && !tp->rx_opt.smc_ok)
-			tp->syn_smc =3D 0;
-	}
-#endif
-}
-
 static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *=
skb,
 					 const struct tcphdr *th)
 {
@@ -5694,8 +5663,6 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 		 * is initialized. */
 		tp->copied_seq =3D tp->rcv_nxt;
 =

-		smc_check_reset_syn(tp);
-
 		smp_mb();
 =

 		tcp_finish_connect(sk, skb);
@@ -6152,9 +6119,6 @@ static void tcp_openreq_init(struct request_sock *req,
 	ireq->ir_rmt_port =3D tcp_hdr(skb)->source;
 	ireq->ir_num =3D ntohs(tcp_hdr(skb)->dest);
 	ireq->ir_mark =3D inet_request_mark(sk, skb);
-#if IS_ENABLED(CONFIG_SMC)
-	ireq->smc_ok =3D rx_opt->smc_ok;
-#endif
 	INIT_LIST_HEAD(&tcp_rsk(req)->tcp_option_list);
 }
 =

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index c3a0a4676fc8..641dca38cc1e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -429,21 +429,6 @@ void tcp_ca_openreq_child(struct sock *sk, const struc=
t dst_entry *dst)
 }
 EXPORT_SYMBOL_GPL(tcp_ca_openreq_child);
 =

-static void smc_check_reset_syn_req(struct tcp_sock *oldtp,
-				    struct request_sock *req,
-				    struct tcp_sock *newtp)
-{
-#if IS_ENABLED(CONFIG_SMC)
-	struct inet_request_sock *ireq;
-
-	if (static_branch_unlikely(&tcp_have_smc)) {
-		ireq =3D inet_rsk(req);
-		if (oldtp->syn_smc && !ireq->smc_ok)
-			newtp->syn_smc =3D 0;
-	}
-#endif
-}
-
 /* This is not only more efficient than what we used to do, it eliminates
  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
  *
@@ -461,9 +446,6 @@ struct sock *tcp_create_openreq_child(const struct sock=
 *sk,
 		struct tcp_request_sock *treq =3D tcp_rsk(req);
 		struct inet_connection_sock *newicsk =3D inet_csk(newsk);
 		struct tcp_sock *newtp =3D tcp_sk(newsk);
-		struct tcp_sock *oldtp =3D tcp_sk(sk);
-
-		smc_check_reset_syn_req(oldtp, req, newtp);
 =

 		/* Now setup tcp_sock */
 		newtp->pred_flags =3D 0;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1fd331018e58..2c9c6a1f3476 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -398,21 +398,6 @@ static inline bool tcp_urg_mode(const struct tcp_sock =
*tp)
 	return tp->snd_una !=3D tp->snd_up;
 }
 =

-static void smc_options_write(__be32 *ptr, u16 *options)
-{
-#if IS_ENABLED(CONFIG_SMC)
-	if (static_branch_unlikely(&tcp_have_smc)) {
-		if (unlikely(OPTION_SMC & *options)) {
-			*ptr++ =3D htonl((TCPOPT_NOP  << 24) |
-				       (TCPOPT_NOP  << 16) |
-				       (TCPOPT_EXP <<  8) |
-				       (TCPOLEN_EXP_SMC_BASE));
-			*ptr++ =3D htonl(TCPOPT_SMC_MAGIC);
-		}
-	}
-#endif
-}
-
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -524,45 +509,10 @@ static void tcp_options_write(__be32 *ptr, struct sk_=
buff *skb, struct sock *sk,
 		ptr +=3D (len + 3) >> 2;
 	}
 =

-	smc_options_write(ptr, &options);
-
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		tcp_extra_options_write(ptr, skb, opts, sk);
 }
 =

-static void smc_set_option(const struct tcp_sock *tp,
-			   struct tcp_out_options *opts,
-			   unsigned int *remaining)
-{
-#if IS_ENABLED(CONFIG_SMC)
-	if (static_branch_unlikely(&tcp_have_smc)) {
-		if (tp->syn_smc) {
-			if (*remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
-				opts->options |=3D OPTION_SMC;
-				*remaining -=3D TCPOLEN_EXP_SMC_BASE_ALIGNED;
-			}
-		}
-	}
-#endif
-}
-
-static void smc_set_option_cond(const struct tcp_sock *tp,
-				const struct inet_request_sock *ireq,
-				struct tcp_out_options *opts,
-				unsigned int *remaining)
-{
-#if IS_ENABLED(CONFIG_SMC)
-	if (static_branch_unlikely(&tcp_have_smc)) {
-		if (tp->syn_smc && ireq->smc_ok) {
-			if (*remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
-				opts->options |=3D OPTION_SMC;
-				*remaining -=3D TCPOLEN_EXP_SMC_BASE_ALIGNED;
-			}
-		}
-	}
-#endif
-}
-
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -627,8 +577,6 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 		}
 	}
 =

-	smc_set_option(tp, opts, &remaining);
-
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		remaining -=3D tcp_extra_options_prepare(skb, TCPHDR_SYN,
 						       remaining, opts,
@@ -694,8 +642,6 @@ static unsigned int tcp_synack_options(const struct soc=
k *sk,
 		}
 	}
 =

-	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
-
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		remaining -=3D tcp_extra_options_prepare(skb,
 						       TCPHDR_SYN | TCPHDR_ACK,
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6451c5013e06..a8c68edb1d47 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -44,6 +44,127 @@
 #include "smc_rx.h"
 #include "smc_close.h"
 =

+static unsigned int tcp_smc_opt_prepare(struct sk_buff *skb, u8 flags,
+					unsigned int remaining,
+					struct tcp_out_options *opts,
+					const struct sock *sk,
+					struct tcp_extra_option_store *store);
+static void tcp_smc_opt_write(__be32 *ptr, struct sk_buff *skb,
+			      struct tcp_out_options *opts,
+			      struct sock *sk,
+			      struct tcp_extra_option_store *store);
+static void tcp_smc_opt_parse(int opsize, const unsigned char *opptr,
+			      const struct sk_buff *skb,
+			      struct tcp_options_received *opt_rx,
+			      struct sock *sk,
+			      struct tcp_extra_option_store *store);
+static void tcp_smc_opt_post_process(struct sock *sk,
+				     struct tcp_options_received *opt,
+				     struct tcp_extra_option_store *store);
+static struct tcp_extra_option_store *tcp_smc_opt_copy(struct sock *listen=
er,
+						       struct request_sock *req,
+						       struct tcp_options_received *opt,
+						       struct tcp_extra_option_store *store);
+static void tcp_smc_opt_destroy(struct tcp_extra_option_store *store);
+
+struct tcp_smc_opt {
+	struct tcp_extra_option_store store;
+	int	smc_ok:1; /* SMC supported on this connection */
+};
+
+static const struct tcp_extra_option_ops tcp_smc_extra_ops =3D {
+	.option_kind	=3D TCPOPT_SMC_MAGIC,
+	.parse		=3D tcp_smc_opt_parse,
+	.post_process	=3D tcp_smc_opt_post_process,
+	.prepare	=3D tcp_smc_opt_prepare,
+	.write		=3D tcp_smc_opt_write,
+	.copy		=3D tcp_smc_opt_copy,
+	.destroy	=3D tcp_smc_opt_destroy,
+	.owner		=3D THIS_MODULE,
+};
+
+static unsigned int tcp_smc_opt_prepare(struct sk_buff *skb, u8 flags,
+					unsigned int remaining,
+					struct tcp_out_options *opts,
+					const struct sock *sk,
+					struct tcp_extra_option_store *store)
+{
+	if (remaining >=3D TCPOLEN_EXP_SMC_BASE_ALIGNED) {
+		opts->options |=3D OPTION_SMC;
+		return TCPOLEN_EXP_SMC_BASE_ALIGNED;
+	}
+
+	return 0;
+}
+
+static void tcp_smc_opt_write(__be32 *ptr, struct sk_buff *skb,
+			      struct tcp_out_options *opts,
+			      struct sock *sk,
+			      struct tcp_extra_option_store *store)
+{
+	if (unlikely(OPTION_SMC & opts->options)) {
+		*ptr++ =3D htonl((TCPOPT_NOP  << 24) |
+			       (TCPOPT_NOP  << 16) |
+			       (TCPOPT_EXP <<  8) |
+			       (TCPOLEN_EXP_SMC_BASE));
+		*ptr++ =3D htonl(TCPOPT_SMC_MAGIC);
+	}
+}
+
+static void tcp_smc_opt_parse(int opsize, const unsigned char *opptr,
+			      const struct sk_buff *skb,
+			      struct tcp_options_received *opt_rx,
+			      struct sock *sk,
+			      struct tcp_extra_option_store *store)
+{
+	struct tcphdr *th =3D tcp_hdr(skb);
+
+	if (th->syn && !(opsize & 1) && opsize >=3D TCPOLEN_EXP_SMC_BASE)
+		opt_rx->smc_ok =3D 1;
+}
+
+static void tcp_smc_opt_post_process(struct sock *sk,
+				     struct tcp_options_received *opt,
+				     struct tcp_extra_option_store *store)
+{
+	struct tcp_smc_opt *smc_opt =3D (struct tcp_smc_opt *)store;
+
+	if (sk->sk_state !=3D TCP_SYN_SENT)
+		return;
+
+	if (opt->smc_ok)
+		smc_opt->smc_ok =3D 1;
+	else
+		smc_opt->smc_ok =3D 0;
+}
+
+static struct tcp_extra_option_store *tcp_smc_opt_copy(struct sock *listen=
er,
+						       struct request_sock *req,
+						       struct tcp_options_received *opt,
+						       struct tcp_extra_option_store *store)
+{
+	struct tcp_smc_opt *smc_opt;
+
+	/* First, check if the peer sent us the smc-opt */
+	if (!opt->smc_ok)
+		return NULL;
+
+	smc_opt =3D kzalloc(sizeof(*smc_opt), GFP_KERNEL);
+	if (!smc_opt)
+		return NULL;
+
+	smc_opt->store.ops =3D &tcp_smc_extra_ops;
+
+	smc_opt->smc_ok =3D 1;
+
+	return (struct tcp_extra_option_store *)smc_opt;
+}
+
+static void tcp_smc_opt_destroy(struct tcp_extra_option_store *store)
+{
+	kfree(store);
+}
+
 static DEFINE_MUTEX(smc_create_lgr_pending);	/* serialize link group
 						 * creation
 						 */
@@ -384,13 +505,16 @@ static int smc_connect_rdma(struct smc_sock *smc)
 	struct smc_clc_msg_accept_confirm aclc;
 	int local_contact =3D SMC_FIRST_CONTACT;
 	struct smc_ib_device *smcibdev;
+	struct tcp_smc_opt *smc_opt;
 	struct smc_link *link;
 	u8 srv_first_contact;
 	int reason_code =3D 0;
 	int rc =3D 0;
 	u8 ibport;
 =

-	if (!tcp_sk(smc->clcsock->sk)->syn_smc) {
+	smc_opt =3D (struct tcp_smc_opt *)tcp_extra_options_find_kind(TCPOPT_SMC_=
MAGIC,
+								    smc->clcsock->sk);
+	if (!smc_opt || !smc_opt->smc_ok) {
 		/* peer has not signalled SMC-capability */
 		smc->use_fallback =3D true;
 		goto out_connected;
@@ -535,6 +659,7 @@ static int smc_connect_rdma(struct smc_sock *smc)
 static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		       int alen, int flags)
 {
+	struct tcp_smc_opt *smc_opt;
 	struct sock *sk =3D sock->sk;
 	struct smc_sock *smc;
 	int rc =3D -EINVAL;
@@ -548,9 +673,17 @@ static int smc_connect(struct socket *sock, struct soc=
kaddr *addr,
 		goto out_err;
 	smc->addr =3D addr;	/* needed for nonblocking connect */
 =

+	smc_opt =3D kzalloc(sizeof(*smc_opt), GFP_KERNEL);
+	if (!smc_opt) {
+		rc =3D -ENOMEM;
+		goto out_err;
+	}
+	smc_opt->store.ops =3D &tcp_smc_extra_ops;
+
 	lock_sock(sk);
 	switch (sk->sk_state) {
 	default:
+		rc =3D -EINVAL;
 		goto out;
 	case SMC_ACTIVE:
 		rc =3D -EISCONN;
@@ -560,8 +693,15 @@ static int smc_connect(struct socket *sock, struct soc=
kaddr *addr,
 		break;
 	}
 =

+	/* We are the only owner of smc->clcsock->sk, so we can be lockless */
+	rc =3D tcp_register_extra_option(&smc_opt->store, smc->clcsock->sk);
+	if (rc) {
+		release_sock(smc->clcsock->sk);
+		kfree(smc_opt);
+		goto out_err;
+	}
+
 	smc_copy_sock_settings_to_clc(smc);
-	tcp_sk(smc->clcsock->sk)->syn_smc =3D 1;
 	rc =3D kernel_connect(smc->clcsock, addr, alen, flags);
 	if (rc)
 		goto out;
@@ -759,6 +899,7 @@ static void smc_listen_work(struct work_struct *work)
 	struct smc_clc_msg_proposal pclc;
 	struct smc_ib_device *smcibdev;
 	struct sockaddr_in peeraddr;
+	struct tcp_smc_opt *smc_opt;
 	struct smc_link *link;
 	int reason_code =3D 0;
 	int rc =3D 0, len;
@@ -767,7 +908,9 @@ static void smc_listen_work(struct work_struct *work)
 	u8 ibport;
 =

 	/* check if peer is smc capable */
-	if (!tcp_sk(newclcsock->sk)->syn_smc) {
+	smc_opt =3D (struct tcp_smc_opt *)tcp_extra_options_find_kind(TCPOPT_SMC_=
MAGIC,
+								    newclcsock->sk);
+	if (!smc_opt || !smc_opt->smc_ok) {
 		new_smc->use_fallback =3D true;
 		goto out_connected;
 	}
@@ -960,10 +1103,18 @@ static void smc_tcp_listen_work(struct work_struct *=
work)
 =

 static int smc_listen(struct socket *sock, int backlog)
 {
+	struct tcp_smc_opt *smc_opt;
 	struct sock *sk =3D sock->sk;
 	struct smc_sock *smc;
 	int rc;
 =

+	smc_opt =3D kzalloc(sizeof(*smc_opt), GFP_KERNEL);
+	if (!smc_opt) {
+		rc =3D -ENOMEM;
+		goto out_err;
+	}
+	smc_opt->store.ops =3D &tcp_smc_extra_ops;
+
 	smc =3D smc_sk(sk);
 	lock_sock(sk);
 =

@@ -976,11 +1127,19 @@ static int smc_listen(struct socket *sock, int backl=
og)
 		sk->sk_max_ack_backlog =3D backlog;
 		goto out;
 	}
+
+	/* We are the only owner of smc->clcsock->sk, so we can be lockless */
+	rc =3D tcp_register_extra_option(&smc_opt->store, smc->clcsock->sk);
+	if (rc) {
+		release_sock(smc->clcsock->sk);
+		kfree(smc_opt);
+		goto out_err;
+	}
+
 	/* some socket options are handled in core, so we could not apply
 	 * them to the clc socket -- copy smc socket options to clc socket
 	 */
 	smc_copy_sock_settings_to_clc(smc);
-	tcp_sk(smc->clcsock->sk)->syn_smc =3D 1;
 =

 	rc =3D kernel_listen(smc->clcsock, backlog);
 	if (rc)
@@ -993,6 +1152,7 @@ static int smc_listen(struct socket *sock, int backlog)
 =

 out:
 	release_sock(sk);
+out_err:
 	return rc;
 }
 =

@@ -1423,7 +1583,6 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 =

-	static_branch_enable(&tcp_have_smc);
 	return 0;
 =

 out_sock:
@@ -1448,7 +1607,6 @@ static void __exit smc_exit(void)
 		list_del_init(&lgr->list);
 		smc_lgr_free(lgr); /* free link group */
 	}
-	static_branch_disable(&tcp_have_smc);
 	smc_ib_unregister_client();
 	sock_unregister(PF_SMC);
 	proto_unregister(&smc_proto);
-- =

2.15.0


--===============5983203129497314916==--
