Content-Type: multipart/mixed; boundary="===============3562138212185261650=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 12/18] tcp_md5: Detect key inside tcp_v4_send_ack
 instead of passing it as an argument
Date: Tue, 03 Oct 2017 09:21:58 -0700
Message-ID: <20171003162204.17945-13-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 102

--===============3562138212185261650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will simplify to consolidate the TCP_MD5-code into a single place.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_ipv4.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d9416b5162bc..f0e12a1e9ad4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -732,7 +732,6 @@ static void tcp_v4_send_reset(const struct sock *sk, st=
ruct sk_buff *skb)
 static void tcp_v4_send_ack(const struct sock *sk,
 			    struct sk_buff *skb, u32 seq, u32 ack,
 			    u32 win, u32 tsval, u32 tsecr, int oif,
-			    struct tcp_md5sig_key *key,
 			    int reply_flags, u8 tos)
 {
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -744,6 +743,9 @@ static void tcp_v4_send_ack(const struct sock *sk,
 #endif
 			];
 	} rep;
+#ifdef CONFIG_TCP_MD5SIG
+	struct tcp_md5sig_key *key;
+#endif
 	struct net *net =3D sock_net(sk);
 	struct ip_reply_arg arg;
 =

@@ -771,6 +773,17 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	rep.th.window  =3D htons(win);
 =

 #ifdef CONFIG_TCP_MD5SIG
+	if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
+		struct tcp_timewait_sock *tcptw =3D tcp_twsk(sk);
+
+		key =3D tcp_twsk_md5_key(tcptw);
+	} else if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV) {
+		key =3D tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->daddr,
+					AF_INET);
+	} else {
+		BUG();
+	}
+
 	if (key) {
 		int offset =3D (tsecr) ? 3 : 0;
 =

@@ -816,7 +829,6 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct=
 sk_buff *skb)
 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
 			tcptw->tw_ts_recent,
 			tw->tw_bound_dev_if,
-			tcp_twsk_md5_key(tcptw),
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			tw->tw_tos
 			);
@@ -844,8 +856,6 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk=
, struct sk_buff *skb,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			req->ts_recent,
 			0,
-			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->daddr,
-					  AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos);
 }
-- =

2.14.1


--===============3562138212185261650==--
