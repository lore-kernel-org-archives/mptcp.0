Content-Type: multipart/mixed; boundary="===============9220769713986296430=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC final 13/14] tcp_md5: Cleanup TCP-code
Date: Sun, 17 Dec 2017 22:42:44 -0800
Message-ID: <20171218064245.94150-14-cpaasch@apple.com>
In-Reply-To: 20171218064245.94150-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 288

--===============9220769713986296430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we have consolidated the TCP_MD5 output path, we can cleanup
TCP and its callbacks to MD5.

These callbacks are solely there to handle the different
address-familiese (v4, v6 and v4mapped).

Now that we have isolated the TCP_MD5-code it is acceptable to add a bit
more complexity inside tcp_md5.c to handle these address-families at the
benefit of getting rid of these callbacks in tcp_sock, together with its
assignments in tcp_v4/6_connect,...

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/tcp.h     |   5 -
 include/linux/tcp_md5.h |  18 +--
 include/net/tcp.h       |  24 ----
 net/ipv4/tcp.c          |   2 +-
 net/ipv4/tcp_ipv4.c     |   8 --
 net/ipv4/tcp_md5.c      | 340 ++++++++++++++++++++++----------------------=
----
 net/ipv6/tcp_ipv6.c     |  17 ---
 7 files changed, 155 insertions(+), 259 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 034fbd9e0a38..5278387fabe7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -377,11 +377,6 @@ struct tcp_sock {
 			   * while socket was owned by user.
 			   */
 =

-#ifdef CONFIG_TCP_MD5SIG
-/* TCP AF-Specific parts; only used by MD5 Signature support so far */
-	const struct tcp_sock_af_ops	*af_specific;
-#endif
-
 /* TCP fastopen related information */
 	struct tcp_fastopen_request *fastopen_req;
 	/* fastopen_rsk points to request_sock that resulted in this big
diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
index 8dee4fc3dc7f..509fc36335e7 100644
--- a/include/linux/tcp_md5.h
+++ b/include/linux/tcp_md5.h
@@ -26,28 +26,14 @@ struct tcp_md5sig_key {
 	struct rcu_head		rcu;
 };
 =

-extern const struct tcp_sock_af_ops tcp_sock_ipv4_specific;
-extern const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
-extern const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
-
 /* - functions */
-int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
-			const struct sock *sk, const struct sk_buff *skb);
 =

-struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
-					 const struct sock *addr_sk);
+int tcp_md5_parse_keys(struct sock *sk, int optname, char __user *optval,
+		       int optlen);
 =

 bool tcp_v4_inbound_md5_hash(const struct sock *sk,
 			     const struct sk_buff *skb);
 =

-struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
-					 const struct sock *addr_sk);
-
-int tcp_v6_md5_hash_skb(char *md5_hash,
-			const struct tcp_md5sig_key *key,
-			const struct sock *sk,
-			const struct sk_buff *skb);
-
 bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 			     const struct sk_buff *skb);
 =

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 40b77458ea6c..52ca18da8967 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1729,32 +1729,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_op=
s,
 		     const struct tcp_request_sock_ops *af_ops,
 		     struct sock *sk, struct sk_buff *skb);
 =

-/* TCP af-specific functions */
-struct tcp_sock_af_ops {
-#ifdef CONFIG_TCP_MD5SIG
-	struct tcp_md5sig_key	*(*md5_lookup) (const struct sock *sk,
-						const struct sock *addr_sk);
-	int		(*calc_md5_hash)(char *location,
-					 const struct tcp_md5sig_key *md5,
-					 const struct sock *sk,
-					 const struct sk_buff *skb);
-	int		(*md5_parse)(struct sock *sk,
-				     int optname,
-				     char __user *optval,
-				     int optlen);
-#endif
-};
-
 struct tcp_request_sock_ops {
 	u16 mss_clamp;
-#ifdef CONFIG_TCP_MD5SIG
-	struct tcp_md5sig_key *(*req_md5_lookup)(const struct sock *sk,
-						 const struct sock *addr_sk);
-	int		(*calc_md5_hash) (char *location,
-					  const struct tcp_md5sig_key *md5,
-					  const struct sock *sk,
-					  const struct sk_buff *skb);
-#endif
 	void (*init_req)(struct request_sock *req,
 			 const struct sock *sk_listener,
 			 struct sk_buff *skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 29f3ce8a0b54..8b6f5efe9509 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2795,7 +2795,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 	case TCP_MD5SIG:
 	case TCP_MD5SIG_EXT:
 		/* Read the IP->Key mappings from userspace */
-		err =3D tp->af_specific->md5_parse(sk, optname, optval, optlen);
+		err =3D tcp_md5_parse_keys(sk, optname, optval, optlen);
 		break;
 #endif
 	case TCP_USER_TIMEOUT:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c9acf000df9b..8748277c17f9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -889,10 +889,6 @@ struct request_sock_ops tcp_request_sock_ops __read_mo=
stly =3D {
 =

 static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
 	.mss_clamp	=3D	TCP_MSS_DEFAULT,
-#ifdef CONFIG_TCP_MD5SIG
-	.req_md5_lookup	=3D	tcp_v4_md5_lookup,
-	.calc_md5_hash	=3D	tcp_v4_md5_hash_skb,
-#endif
 	.init_req	=3D	tcp_v4_init_req,
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =3D	cookie_v4_init_sequence,
@@ -1450,10 +1446,6 @@ static int tcp_v4_init_sock(struct sock *sk)
 =

 	icsk->icsk_af_ops =3D &ipv4_specific;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	tcp_sk(sk)->af_specific =3D &tcp_sock_ipv4_specific;
-#endif
-
 	return 0;
 }
 =

diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
index 64e5b4420ce9..052f5a587783 100644
--- a/net/ipv4/tcp_md5.c
+++ b/net/ipv4/tcp_md5.c
@@ -336,12 +336,13 @@ static int tcp_md5_hash_key(struct tcp_md5sig_pool *h=
p,
 	return crypto_ahash_update(hp->md5_req);
 }
 =

-static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
-				 char __user *optval, int optlen)
+int tcp_md5_parse_keys(struct sock *sk, int optname, char __user *optval,
+		       int optlen)
 {
+	u8 prefixlen =3D 32, maxprefixlen;
+	union tcp_md5_addr *tcpmd5addr;
 	struct tcp_md5sig cmd;
-	struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.tcpm_addr;
-	u8 prefixlen =3D 32;
+	unsigned short family;
 =

 	if (optlen < sizeof(cmd))
 		return -EINVAL;
@@ -349,76 +350,48 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int=
 optname,
 	if (copy_from_user(&cmd, optval, sizeof(cmd)))
 		return -EFAULT;
 =

-	if (sin->sin_family !=3D AF_INET)
-		return -EINVAL;
-
-	if (optname =3D=3D TCP_MD5SIG_EXT &&
-	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
-		prefixlen =3D cmd.tcpm_prefixlen;
-		if (prefixlen > 32)
-			return -EINVAL;
-	}
+	family =3D cmd.tcpm_addr.ss_family;
 =

-	if (!cmd.tcpm_keylen)
-		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
-				      AF_INET, prefixlen);
-
-	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
+	if (family !=3D AF_INET && family !=3D AF_INET6)
 		return -EINVAL;
 =

-	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin->sin_addr.s_addr,
-			      AF_INET, prefixlen, cmd.tcpm_key, cmd.tcpm_keylen,
-			      GFP_KERNEL);
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
-				 char __user *optval, int optlen)
-{
-	struct tcp_md5sig cmd;
-	struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)&cmd.tcpm_addr;
-	u8 prefixlen;
-
-	if (optlen < sizeof(cmd))
+	if (sk->sk_family !=3D family)
 		return -EINVAL;
 =

-	if (copy_from_user(&cmd, optval, sizeof(cmd)))
-		return -EFAULT;
+	if (family =3D=3D AF_INET6) {
+		struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)&cmd.tcpm_addr;
 =

-	if (sin6->sin6_family !=3D AF_INET6)
-		return -EINVAL;
+		if (!ipv6_addr_v4mapped(&sin6->sin6_addr)) {
+			tcpmd5addr =3D (union tcp_md5_addr *)&sin6->sin6_addr;
+			maxprefixlen =3D 128;
+		} else {
+			tcpmd5addr =3D (union tcp_md5_addr *)&sin6->sin6_addr.s6_addr32[3];
+			family =3D AF_INET;
+			maxprefixlen =3D 32;
+		}
+	} else {
+		struct sockaddr_in *sin =3D (struct sockaddr_in *)&cmd.tcpm_addr;
+
+		tcpmd5addr =3D (union tcp_md5_addr *)&sin->sin_addr;
+		maxprefixlen =3D 32;
+	}
 =

 	if (optname =3D=3D TCP_MD5SIG_EXT &&
 	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
 		prefixlen =3D cmd.tcpm_prefixlen;
-		if (prefixlen > 128 || (ipv6_addr_v4mapped(&sin6->sin6_addr) &&
-					prefixlen > 32))
+		if (prefixlen > maxprefixlen)
 			return -EINVAL;
-	} else {
-		prefixlen =3D ipv6_addr_v4mapped(&sin6->sin6_addr) ? 32 : 128;
 	}
 =

-	if (!cmd.tcpm_keylen) {
-		if (ipv6_addr_v4mapped(&sin6->sin6_addr))
-			return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_add=
r32[3],
-					      AF_INET, prefixlen);
-		return tcp_md5_do_del(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
-				      AF_INET6, prefixlen);
-	}
+	if (!cmd.tcpm_keylen)
+		return tcp_md5_do_del(sk, tcpmd5addr, family, prefixlen);
 =

 	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
 		return -EINVAL;
 =

-	if (ipv6_addr_v4mapped(&sin6->sin6_addr))
-		return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_addr=
32[3],
-				      AF_INET, prefixlen, cmd.tcpm_key,
-				      cmd.tcpm_keylen, GFP_KERNEL);
-
-	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
-			      AF_INET6, prefixlen, cmd.tcpm_key,
+	return tcp_md5_do_add(sk, tcpmd5addr, family, prefixlen, cmd.tcpm_key,
 			      cmd.tcpm_keylen, GFP_KERNEL);
 }
-#endif
 =

 static int tcp_v4_md5_hash_headers(struct tcp_md5sig_pool *hp,
 				   __be32 daddr, __be32 saddr,
@@ -670,6 +643,102 @@ static int tcp_md5_hash_skb_data(struct tcp_md5sig_po=
ol *hp,
 	return 0;
 }
 =

+static int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key=
 *key,
+			       const struct sock *sk, const struct sk_buff *skb)
+{
+	struct tcp_md5sig_pool *hp;
+	struct ahash_request *req;
+	const struct tcphdr *th =3D tcp_hdr(skb);
+	__be32 saddr, daddr;
+
+	if (sk) { /* valid for establish/request sockets */
+		saddr =3D sk->sk_rcv_saddr;
+		daddr =3D sk->sk_daddr;
+	} else {
+		const struct iphdr *iph =3D ip_hdr(skb);
+
+		saddr =3D iph->saddr;
+		daddr =3D iph->daddr;
+	}
+
+	hp =3D tcp_get_md5sig_pool();
+	if (!hp)
+		goto clear_hash_noput;
+	req =3D hp->md5_req;
+
+	if (crypto_ahash_init(req))
+		goto clear_hash;
+
+	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
+		goto clear_hash;
+	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
+		goto clear_hash;
+	if (tcp_md5_hash_key(hp, key))
+		goto clear_hash;
+	ahash_request_set_crypt(req, NULL, md5_hash, 0);
+	if (crypto_ahash_final(req))
+		goto clear_hash;
+
+	tcp_put_md5sig_pool();
+	return 0;
+
+clear_hash:
+	tcp_put_md5sig_pool();
+clear_hash_noput:
+	memset(md5_hash, 0, 16);
+	return 1;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int tcp_v6_md5_hash_skb(char *md5_hash,
+			       const struct tcp_md5sig_key *key,
+			       const struct sock *sk,
+			       const struct sk_buff *skb)
+{
+	const struct in6_addr *saddr, *daddr;
+	struct tcp_md5sig_pool *hp;
+	struct ahash_request *req;
+	const struct tcphdr *th =3D tcp_hdr(skb);
+
+	if (sk) { /* valid for establish/request sockets */
+		saddr =3D &sk->sk_v6_rcv_saddr;
+		daddr =3D &sk->sk_v6_daddr;
+	} else {
+		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
+
+		saddr =3D &ip6h->saddr;
+		daddr =3D &ip6h->daddr;
+	}
+
+	hp =3D tcp_get_md5sig_pool();
+	if (!hp)
+		goto clear_hash_noput;
+	req =3D hp->md5_req;
+
+	if (crypto_ahash_init(req))
+		goto clear_hash;
+
+	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
+		goto clear_hash;
+	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
+		goto clear_hash;
+	if (tcp_md5_hash_key(hp, key))
+		goto clear_hash;
+	ahash_request_set_crypt(req, NULL, md5_hash, 0);
+	if (crypto_ahash_final(req))
+		goto clear_hash;
+
+	tcp_put_md5sig_pool();
+	return 0;
+
+clear_hash:
+	tcp_put_md5sig_pool();
+clear_hash_noput:
+	memset(md5_hash, 0, 16);
+	return 1;
+}
+#endif
+
 static int tcp_v4_md5_send_response_prepare(struct sk_buff *skb, u8 flags,
 					    unsigned int remaining,
 					    struct tcp_out_options *opts,
@@ -784,114 +853,14 @@ static __be32 *tcp_md5_send_response_write(__be32 *p=
tr, struct sk_buff *orig,
 	return tcp_v4_md5_send_response_write(ptr, orig, th, opts, sk);
 }
 =

-struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
-					 const struct sock *addr_sk)
+static struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
+						const struct sock *addr_sk)
 {
 	const union tcp_md5_addr *addr;
 =

 	addr =3D (const union tcp_md5_addr *)&addr_sk->sk_daddr;
 	return tcp_md5_do_lookup(sk, addr, AF_INET);
 }
-EXPORT_SYMBOL(tcp_v4_md5_lookup);
-
-int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
-			const struct sock *sk,
-			const struct sk_buff *skb)
-{
-	struct tcp_md5sig_pool *hp;
-	struct ahash_request *req;
-	const struct tcphdr *th =3D tcp_hdr(skb);
-	__be32 saddr, daddr;
-
-	if (sk) { /* valid for establish/request sockets */
-		saddr =3D sk->sk_rcv_saddr;
-		daddr =3D sk->sk_daddr;
-	} else {
-		const struct iphdr *iph =3D ip_hdr(skb);
-
-		saddr =3D iph->saddr;
-		daddr =3D iph->daddr;
-	}
-
-	hp =3D tcp_get_md5sig_pool();
-	if (!hp)
-		goto clear_hash_noput;
-	req =3D hp->md5_req;
-
-	if (crypto_ahash_init(req))
-		goto clear_hash;
-
-	if (tcp_v4_md5_hash_headers(hp, daddr, saddr, th, skb->len))
-		goto clear_hash;
-	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
-		goto clear_hash;
-	if (tcp_md5_hash_key(hp, key))
-		goto clear_hash;
-	ahash_request_set_crypt(req, NULL, md5_hash, 0);
-	if (crypto_ahash_final(req))
-		goto clear_hash;
-
-	tcp_put_md5sig_pool();
-	return 0;
-
-clear_hash:
-	tcp_put_md5sig_pool();
-clear_hash_noput:
-	memset(md5_hash, 0, 16);
-	return 1;
-}
-EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
-
-#if IS_ENABLED(CONFIG_IPV6)
-int tcp_v6_md5_hash_skb(char *md5_hash,
-			const struct tcp_md5sig_key *key,
-			const struct sock *sk,
-			const struct sk_buff *skb)
-{
-	const struct in6_addr *saddr, *daddr;
-	struct tcp_md5sig_pool *hp;
-	struct ahash_request *req;
-	const struct tcphdr *th =3D tcp_hdr(skb);
-
-	if (sk) { /* valid for establish/request sockets */
-		saddr =3D &sk->sk_v6_rcv_saddr;
-		daddr =3D &sk->sk_v6_daddr;
-	} else {
-		const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
-
-		saddr =3D &ip6h->saddr;
-		daddr =3D &ip6h->daddr;
-	}
-
-	hp =3D tcp_get_md5sig_pool();
-	if (!hp)
-		goto clear_hash_noput;
-	req =3D hp->md5_req;
-
-	if (crypto_ahash_init(req))
-		goto clear_hash;
-
-	if (tcp_v6_md5_hash_headers(hp, daddr, saddr, th, skb->len))
-		goto clear_hash;
-	if (tcp_md5_hash_skb_data(hp, skb, th->doff << 2))
-		goto clear_hash;
-	if (tcp_md5_hash_key(hp, key))
-		goto clear_hash;
-	ahash_request_set_crypt(req, NULL, md5_hash, 0);
-	if (crypto_ahash_final(req))
-		goto clear_hash;
-
-	tcp_put_md5sig_pool();
-	return 0;
-
-clear_hash:
-	tcp_put_md5sig_pool();
-clear_hash_noput:
-	memset(md5_hash, 0, 16);
-	return 1;
-}
-EXPORT_SYMBOL_GPL(tcp_v6_md5_hash_skb);
-#endif
 =

 /* Called with rcu_read_lock() */
 bool tcp_v4_inbound_md5_hash(const struct sock *sk,
@@ -994,8 +963,8 @@ bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(tcp_v6_inbound_md5_hash);
 =

-struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
-					 const struct sock *addr_sk)
+static struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
+						const struct sock *addr_sk)
 {
 	return tcp_v6_md5_do_lookup(sk, &addr_sk->sk_v6_daddr);
 }
@@ -1103,10 +1072,17 @@ static int tcp_md5_extopt_add_header_len(const stru=
ct sock *orig,
 					 const struct sock *sk,
 					 struct tcp_extopt_store *store)
 {
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	if (tp->af_specific->md5_lookup(orig, sk))
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family =3D=3D AF_INET6 &&
+	    !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) {
+		if (tcp_v6_md5_lookup(orig, sk))
+			return TCPOLEN_MD5SIG_ALIGNED;
+	} else
+#endif
+{
+	if (tcp_v4_md5_lookup(orig, sk))
 		return TCPOLEN_MD5SIG_ALIGNED;
+}
 =

 	return 0;
 }
@@ -1120,19 +1096,29 @@ static unsigned int tcp_md5_extopt_prepare(struct s=
k_buff *skb, u8 flags,
 	int ret =3D 0;
 =

 	if (sk_fullsock(sk)) {
-		struct tcp_sock *tp =3D tcp_sk(sk);
-
-		opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family =3D=3D AF_INET6 && !ipv6_addr_v4mapped(&sk->sk_v6_dadd=
r))
+			opts->md5 =3D tcp_v6_md5_lookup(sk, sk);
+		else
+#endif
+			opts->md5 =3D tcp_v4_md5_lookup(sk, sk);
 	} else {
 		struct request_sock *req =3D inet_reqsk(sk);
 		struct sock *listener =3D req->rsk_listener;
+		struct inet_request_sock *ireq =3D inet_rsk(req);
 =

 		/* Coming from tcp_make_synack, unlock is in
 		 * tcp_md5_extopt_write
 		 */
 		rcu_read_lock();
 =

-		opts->md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(listener, sk);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (ireq->ireq_family =3D=3D AF_INET6 &&
+		    !ipv6_addr_v4mapped(&ireq->ir_v6_rmt_addr))
+			opts->md5 =3D tcp_v6_md5_lookup(listener, sk);
+		else
+#endif
+			opts->md5 =3D tcp_v4_md5_lookup(listener, sk);
 =

 		if (!opts->md5)
 			rcu_read_unlock();
@@ -1352,25 +1338,3 @@ static void tcp_md5_extopt_destroy(struct tcp_extopt=
_store *store)
 		kfree_rcu(md5_opt, rcu);
 	}
 }
-
-const struct tcp_sock_af_ops tcp_sock_ipv4_specific =3D {
-	.md5_lookup	=3D tcp_v4_md5_lookup,
-	.calc_md5_hash	=3D tcp_v4_md5_hash_skb,
-	.md5_parse	=3D tcp_v4_parse_md5_keys,
-};
-
-#if IS_ENABLED(CONFIG_IPV6)
-const struct tcp_sock_af_ops tcp_sock_ipv6_specific =3D {
-	.md5_lookup	=3D	tcp_v6_md5_lookup,
-	.calc_md5_hash	=3D	tcp_v6_md5_hash_skb,
-	.md5_parse	=3D	tcp_v6_parse_md5_keys,
-};
-EXPORT_SYMBOL_GPL(tcp_sock_ipv6_specific);
-
-const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific =3D {
-	.md5_lookup	=3D	tcp_v4_md5_lookup,
-	.calc_md5_hash	=3D	tcp_v4_md5_hash_skb,
-	.md5_parse	=3D	tcp_v6_parse_md5_keys,
-};
-EXPORT_SYMBOL_GPL(tcp_sock_ipv6_mapped_specific);
-#endif
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e0da640651aa..4192af62564e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -208,9 +208,6 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 =

 		icsk->icsk_af_ops =3D &ipv6_mapped;
 		sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
-#ifdef CONFIG_TCP_MD5SIG
-		tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
-#endif
 =

 		err =3D tcp_v4_connect(sk, (struct sockaddr *)&sin, sizeof(sin));
 =

@@ -218,9 +215,6 @@ static int tcp_v6_connect(struct sock *sk, struct socka=
ddr *uaddr,
 			icsk->icsk_ext_hdr_len =3D exthdrlen;
 			icsk->icsk_af_ops =3D &ipv6_specific;
 			sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
-#ifdef CONFIG_TCP_MD5SIG
-			tp->af_specific =3D &tcp_sock_ipv6_specific;
-#endif
 			goto failure;
 		}
 		np->saddr =3D sk->sk_v6_rcv_saddr;
@@ -543,10 +537,6 @@ struct request_sock_ops tcp6_request_sock_ops __read_m=
ostly =3D {
 static const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
 	.mss_clamp	=3D	IPV6_MIN_MTU - sizeof(struct tcphdr) -
 				sizeof(struct ipv6hdr),
-#ifdef CONFIG_TCP_MD5SIG
-	.req_md5_lookup	=3D	tcp_v6_md5_lookup,
-	.calc_md5_hash	=3D	tcp_v6_md5_hash_skb,
-#endif
 	.init_req	=3D	tcp_v6_init_req,
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =3D	cookie_v6_init_sequence,
@@ -821,9 +811,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct s=
ock *sk, struct sk_buff *
 =

 		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
 		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
-#ifdef CONFIG_TCP_MD5SIG
-		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
-#endif
 =

 		newnp->ipv6_mc_list =3D NULL;
 		newnp->ipv6_ac_list =3D NULL;
@@ -1430,10 +1417,6 @@ static int tcp_v6_init_sock(struct sock *sk)
 =

 	icsk->icsk_af_ops =3D &ipv6_specific;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
-#endif
-
 	return 0;
 }
 =

-- =

2.15.0


--===============9220769713986296430==--
