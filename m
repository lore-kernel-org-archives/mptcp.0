Content-Type: multipart/mixed; boundary="===============0194242207108766786=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 10/15] tcp_md5: Detect key inside
 tcp_v6_send_response instead of passing it as an argument
Date: Mon, 11 Dec 2017 13:42:13 -0800
Message-ID: <20171211214218.35868-11-cpaasch@apple.com>
In-Reply-To: 20171211214218.35868-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 240

--===============0194242207108766786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want to move all the TCP-MD5 code to a single place which enables us
to factor the TCP-MD5 code out of the TCP-stack into the extra-option
framework.

Detection of whether or not to drop the segment (as done in
tcp_v6_send_reset()) has now been moved to tcp_v6_send_response().
So we needed to adapt the latter so that it can handle the case where we
want to exit without sending anything.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    v3: * Fix a compiler error because of #if CONFIG_TCP_MD5SIG

 net/ipv6/tcp_ipv6.c | 119 +++++++++++++++++++++++++-----------------------=
----
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 05e43465aff7..fccfce82f102 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -82,12 +82,6 @@ static const struct inet_connection_sock_af_ops ipv6_spe=
cific;
 #ifdef CONFIG_TCP_MD5SIG
 static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
 static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
-#else
-static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *sk,
-						   const struct in6_addr *addr)
-{
-	return NULL;
-}
 #endif
 =

 static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
@@ -780,12 +774,11 @@ static const struct tcp_request_sock_ops tcp_request_=
sock_ipv6_ops =3D {
 =

 static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *sk=
b, u32 seq,
 				 u32 ack, u32 win, u32 tsval, u32 tsecr,
-				 int oif, struct tcp_md5sig_key *key, int rst,
-				 u8 tclass, __be32 label)
+				 int oif, int rst, u8 tclass, __be32 label)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
 	struct tcphdr *t1;
-	struct sk_buff *buff;
+	struct sk_buff *buff =3D NULL;
 	struct flowi6 fl6;
 	struct net *net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
 	struct sock *ctl_sk =3D net->ipv6.tcp_sk;
@@ -793,10 +786,54 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
 	struct dst_entry *dst;
 	__be32 *topt;
 	struct tcp_out_options extraopts;
+#ifdef CONFIG_TCP_MD5SIG
+	struct tcp_md5sig_key *key =3D NULL;
+	const __u8 *hash_location =3D NULL;
+	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
+#endif
 =

 	if (tsecr)
 		tot_len +=3D TCPOLEN_TSTAMP_ALIGNED;
 #ifdef CONFIG_TCP_MD5SIG
+	rcu_read_lock();
+	hash_location =3D tcp_parse_md5sig_option(th);
+	if (sk && sk_fullsock(sk)) {
+		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
+	} else if (sk && sk->sk_state =3D=3D TCP_TIME_WAIT) {
+		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
+
+		key =3D tcp_twsk_md5_key(tcptw);
+	} else if (sk && sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
+		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
+	} else if (hash_location) {
+		unsigned char newhash[16];
+		struct sock *sk1 =3D NULL;
+		int genhash;
+
+		/* active side is lost. Try to find listening socket through
+		 * source port, and then find md5 key through listening socket.
+		 * we are not loose security here:
+		 * Incoming packet is checked with md5 hash with finding key,
+		 * no RST generated if md5 hash doesn't match.
+		 */
+		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
+					    &tcp_hashinfo, NULL, 0,
+					    &ipv6h->saddr,
+					    th->source, &ipv6h->daddr,
+					    ntohs(th->source), tcp_v6_iif(skb),
+					    tcp_v6_sdif(skb));
+		if (!sk1)
+			goto out;
+
+		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
+		if (!key)
+			goto out;
+
+		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
+		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
+			goto out;
+	}
+
 	if (key)
 		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
 #endif
@@ -820,7 +857,7 @@ static void tcp_v6_send_response(const struct sock *sk,=
 struct sk_buff *skb, u32
 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
 			 GFP_ATOMIC);
 	if (!buff)
-		return;
+		goto out;
 =

 	skb_reserve(buff, MAX_HEADER + sizeof(struct ipv6hdr) + tot_len);
 =

@@ -897,24 +934,21 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
 		TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 		if (rst)
 			TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
-		return;
+		buff =3D NULL;
 	}
 =

+out:
 	kfree_skb(buff);
+
+#ifdef CONFIG_TCP_MD5SIG
+	rcu_read_unlock();
+#endif
 }
 =

 static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
 	u32 seq =3D 0, ack_seq =3D 0;
-	struct tcp_md5sig_key *key =3D NULL;
-#ifdef CONFIG_TCP_MD5SIG
-	const __u8 *hash_location =3D NULL;
-	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
-	unsigned char newhash[16];
-	int genhash;
-	struct sock *sk1 =3D NULL;
-#endif
 	int oif =3D 0;
 =

 	if (th->rst)
@@ -926,38 +960,6 @@ static void tcp_v6_send_reset(const struct sock *sk, s=
truct sk_buff *skb)
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 =

-#ifdef CONFIG_TCP_MD5SIG
-	rcu_read_lock();
-	hash_location =3D tcp_parse_md5sig_option(th);
-	if (sk && sk_fullsock(sk)) {
-		key =3D tcp_v6_md5_do_lookup(sk, &ipv6h->saddr);
-	} else if (hash_location) {
-		/*
-		 * active side is lost. Try to find listening socket through
-		 * source port, and then find md5 key through listening socket.
-		 * we are not loose security here:
-		 * Incoming packet is checked with md5 hash with finding key,
-		 * no RST generated if md5 hash doesn't match.
-		 */
-		sk1 =3D inet6_lookup_listener(dev_net(skb_dst(skb)->dev),
-					   &tcp_hashinfo, NULL, 0,
-					   &ipv6h->saddr,
-					   th->source, &ipv6h->daddr,
-					   ntohs(th->source), tcp_v6_iif(skb),
-					   tcp_v6_sdif(skb));
-		if (!sk1)
-			goto out;
-
-		key =3D tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr);
-		if (!key)
-			goto out;
-
-		genhash =3D tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) !=3D 0)
-			goto out;
-	}
-#endif
-
 	if (th->ack)
 		seq =3D ntohl(th->ack_seq);
 	else
@@ -969,20 +971,14 @@ static void tcp_v6_send_reset(const struct sock *sk, =
struct sk_buff *skb)
 		trace_tcp_send_reset(sk, skb);
 	}
 =

-	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, key, 1, 0, 0);
-
-#ifdef CONFIG_TCP_MD5SIG
-out:
-	rcu_read_unlock();
-#endif
+	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1, 0, 0);
 }
 =

 static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u3=
2 seq,
 			    u32 ack, u32 win, u32 tsval, u32 tsecr, int oif,
-			    struct tcp_md5sig_key *key, u8 tclass,
-			    __be32 label)
+			    u8 tclass, __be32 label)
 {
-	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, key, 0,
+	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, 0,
 			     tclass, label);
 }
 =

@@ -994,7 +990,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct=
 sk_buff *skb)
 	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
-			tcptw->tw_ts_recent, tw->tw_bound_dev_if, tcp_twsk_md5_key(tcptw),
+			tcptw->tw_ts_recent, tw->tw_bound_dev_if,
 			tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel));
 =

 	inet_twsk_put(tw);
@@ -1017,7 +1013,6 @@ static void tcp_v6_reqsk_send_ack(const struct sock *=
sk, struct sk_buff *skb,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			req->ts_recent, sk->sk_bound_dev_if,
-			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr),
 			0, 0);
 }
 =

-- =

2.15.0


--===============0194242207108766786==--
