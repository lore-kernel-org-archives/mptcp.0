Content-Type: multipart/mixed; boundary="===============3843041503351925092=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 08/15] tcp_md5: Don't pass along md5-key
Date: Mon, 11 Dec 2017 13:42:11 -0800
Message-ID: <20171211214218.35868-9-cpaasch@apple.com>
In-Reply-To: 20171211214218.35868-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 239

--===============3843041503351925092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is much cleaner to store the key-pointer in tcp_out_options.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    v3: * Don't init to NULL opts->md5 in tcp_syn_options

 include/linux/tcp.h   |  1 +
 net/ipv4/tcp_output.c | 46 +++++++++++++++++++---------------------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5dc4067100af..a1633d467af5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -131,6 +131,7 @@ struct tcp_out_options {
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+	struct tcp_md5sig_key *md5; /* TCP_MD5 signature key */
 };
 =

 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0dc736849fc0..2ca662499c28 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -517,21 +517,18 @@ static void tcp_options_write(__be32 *ptr, struct sk_=
buff *skb, struct sock *sk,
  * network wire format yet.
  */
 static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
-				struct tcp_out_options *opts,
-				struct tcp_md5sig_key **md5)
+				struct tcp_out_options *opts)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
 	struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;
 =

 #ifdef CONFIG_TCP_MD5SIG
-	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
-	if (*md5) {
+	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
+	if (opts->md5) {
 		opts->options |=3D OPTION_MD5;
 		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
 	}
-#else
-	*md5 =3D NULL;
 #endif
 =

 	/* We always get an MSS option.  The option bytes which will be seen in
@@ -546,7 +543,7 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 	opts->mss =3D tcp_advertise_mss(sk);
 	remaining -=3D TCPOLEN_MSS_ALIGNED;
 =

-	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps && !*md5)) {
+	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps && !opts->md5)) {
 		opts->options |=3D OPTION_TS;
 		opts->tsval =3D tcp_skb_timestamp(skb) + tp->tsoffset;
 		opts->tsecr =3D tp->rx_opt.ts_recent;
@@ -590,14 +587,13 @@ static unsigned int tcp_synack_options(const struct s=
ock *sk,
 				       struct request_sock *req,
 				       unsigned int mss, struct sk_buff *skb,
 				       struct tcp_out_options *opts,
-				       const struct tcp_md5sig_key *md5,
 				       struct tcp_fastopen_cookie *foc)
 {
 	struct inet_request_sock *ireq =3D inet_rsk(req);
 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
 =

 #ifdef CONFIG_TCP_MD5SIG
-	if (md5) {
+	if (opts->md5) {
 		opts->options |=3D OPTION_MD5;
 		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
 =

@@ -655,8 +651,7 @@ static unsigned int tcp_synack_options(const struct soc=
k *sk,
  * final wire format yet.
  */
 static unsigned int tcp_established_options(struct sock *sk, struct sk_buf=
f *skb,
-					struct tcp_out_options *opts,
-					struct tcp_md5sig_key **md5)
+					struct tcp_out_options *opts)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	unsigned int size =3D 0;
@@ -665,13 +660,13 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 	opts->options =3D 0;
 =

 #ifdef CONFIG_TCP_MD5SIG
-	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
-	if (unlikely(*md5)) {
+	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
+	if (unlikely(opts->md5)) {
 		opts->options |=3D OPTION_MD5;
 		size +=3D TCPOLEN_MD5SIG_ALIGNED;
 	}
 #else
-	*md5 =3D NULL;
+	opts->md5 =3D NULL;
 #endif
 =

 	if (likely(tp->rx_opt.tstamp_ok)) {
@@ -989,7 +984,6 @@ static int tcp_transmit_skb(struct sock *sk, struct sk_=
buff *skb, int clone_it,
 	struct tcp_out_options opts;
 	unsigned int tcp_options_size, tcp_header_size;
 	struct sk_buff *oskb =3D NULL;
-	struct tcp_md5sig_key *md5;
 	struct tcphdr *th;
 	int err;
 =

@@ -1018,10 +1012,9 @@ static int tcp_transmit_skb(struct sock *sk, struct =
sk_buff *skb, int clone_it,
 	memset(&opts, 0, sizeof(opts));
 =

 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN))
-		tcp_options_size =3D tcp_syn_options(sk, skb, &opts, &md5);
+		tcp_options_size =3D tcp_syn_options(sk, skb, &opts);
 	else
-		tcp_options_size =3D tcp_established_options(sk, skb, &opts,
-							   &md5);
+		tcp_options_size =3D tcp_established_options(sk, skb, &opts);
 	tcp_header_size =3D tcp_options_size + sizeof(struct tcphdr);
 =

 	/* if no packet is in qdisc/device queue, then allow XPS to select
@@ -1087,10 +1080,10 @@ static int tcp_transmit_skb(struct sock *sk, struct=
 sk_buff *skb, int clone_it,
 	tcp_options_write((__be32 *)(th + 1), skb, sk, &opts);
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
-	if (md5) {
+	if (opts.md5) {
 		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
 		tp->af_specific->calc_md5_hash(opts.hash_location,
-					       md5, sk, skb);
+					       opts.md5, sk, skb);
 	}
 #endif
 =

@@ -1534,7 +1527,6 @@ unsigned int tcp_current_mss(struct sock *sk)
 	u32 mss_now;
 	unsigned int header_len;
 	struct tcp_out_options opts;
-	struct tcp_md5sig_key *md5;
 =

 	mss_now =3D tp->mss_cache;
 =

@@ -1544,7 +1536,7 @@ unsigned int tcp_current_mss(struct sock *sk)
 			mss_now =3D tcp_sync_mss(sk, mtu);
 	}
 =

-	header_len =3D tcp_established_options(sk, NULL, &opts, &md5) +
+	header_len =3D tcp_established_options(sk, NULL, &opts) +
 		     sizeof(struct tcphdr);
 	/* The mss_cache is sized based on tp->tcp_header_len, which assumes
 	 * some common options. If this is an odd packet (because we have SACK
@@ -3123,7 +3115,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 {
 	struct inet_request_sock *ireq =3D inet_rsk(req);
 	const struct tcp_sock *tp =3D tcp_sk(sk);
-	struct tcp_md5sig_key *md5 =3D NULL;
 	struct tcp_out_options opts;
 	struct sk_buff *skb;
 	int tcp_header_size;
@@ -3169,10 +3160,10 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
 =

 #ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
-	md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
+	opts.md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req)=
);
 #endif
 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
-	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts, md5,
+	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts,
 					     foc) + sizeof(*th);
 =

 	skb_push(skb, tcp_header_size);
@@ -3199,9 +3190,10 @@ struct sk_buff *tcp_make_synack(const struct sock *s=
k, struct dst_entry *dst,
 =

 #ifdef CONFIG_TCP_MD5SIG
 	/* Okay, we have all we need - do the md5 hash if needed */
-	if (md5)
+	if (opts.md5)
 		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
-					       md5, req_to_sk(req), skb);
+							 opts.md5,
+							 req_to_sk(req), skb);
 	rcu_read_unlock();
 #endif
 =

-- =

2.15.0


--===============3843041503351925092==--
