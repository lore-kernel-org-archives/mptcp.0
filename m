Content-Type: multipart/mixed; boundary="===============1970332076727233199=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC final 08/14] tcp_md5: Detect key inside tcp_v4_send_ack
 instead of passing it as an argument
Date: Sun, 17 Dec 2017 22:42:39 -0800
Message-ID: <20171218064245.94150-9-cpaasch@apple.com>
In-Reply-To: 20171218064245.94150-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 283

--===============1970332076727233199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will simplify to consolidate the TCP_MD5-code into a single place.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_ipv4.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4e8690667b17..1ebcbc01215f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -764,7 +764,6 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 static void tcp_v4_send_ack(const struct sock *sk,
 			    struct sk_buff *skb, u32 seq, u32 ack,
 			    u32 win, u32 tsval, u32 tsecr, int oif,
-			    struct tcp_md5sig_key *key,
 			    int reply_flags, u8 tos)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -773,6 +772,9 @@ static void tcp_v4_send_ack(const struct sock *sk,
 		__be32 opt[(MAX_TCP_OPTION_SPACE >> 2)];
 	} rep;
 	struct hlist_head *extopt_list =3D NULL;
+#ifdef CONFIG_TCP_MD5SIG
+	struct tcp_md5sig_key *key;
+#endif
 	struct net *net =3D sock_net(sk);
 	struct ip_reply_arg arg;
 	int offset =3D 0;
@@ -803,6 +805,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	rep.th.ack     =3D 1;
 	rep.th.window  =3D htons(win);
 =

+#ifdef CONFIG_TCP_MD5SIG
+	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
+		key =3D tcp_twsk_md5_key(tcp_twsk(sk));
+	} else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
+		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->saddr,
+					AF_INET);
+	} else {
+		key =3D NULL;     /* Should not happen */
+	}
+#endif
+
 	if (unlikely(extopt_list && !hlist_empty(extopt_list))) {
 		unsigned int remaining;
 		struct tcp_out_options opts;
@@ -872,7 +885,6 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct=
 sk_buff *skb)
 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
 			tcptw->tw_ts_recent,
 			tw->tw_bound_dev_if,
-			tcp_twsk_md5_key(tcptw),
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			tw->tw_tos
 			);
@@ -900,8 +912,6 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk=
, struct sk_buff *skb,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			req->ts_recent,
 			0,
-			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->saddr,
-					  AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos);
 }
-- =

2.15.0


--===============1970332076727233199==--
