Content-Type: multipart/mixed; boundary="===============6774573819436612699=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 16/25] tcp_extra_options: Pass sk to
 tcp_parse_options instead of tp
Date: Mon, 27 Nov 2017 21:57:17 -0800
Message-ID: <20171128055726.430-17-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 192

--===============6774573819436612699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/tcp.h        |  2 +-
 net/ipv4/syncookies.c    |  2 +-
 net/ipv4/tcp_input.c     | 13 ++++++-------
 net/ipv4/tcp_minisocks.c |  6 ++++--
 net/ipv6/syncookies.c    |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0b94356ee5ba..55f6e6b39539 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -404,7 +404,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, si=
ze_t len, int nonblock,
 void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx,
 		       int estab, struct tcp_fastopen_cookie *foc,
-		       struct tcp_sock *tp);
+		       struct sock *sk);
 const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
 =

 /*
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b3698ac3f078..fc4f91d92b8a 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -313,7 +313,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, tp);
+	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, sk);
 =

 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff =3D secure_tcp_ts_off(sock_net(sk),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c2ef1309e877..07a43518affa 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3693,7 +3693,7 @@ static int smc_parse_options(const struct tcphdr *th,
 void tcp_parse_options(const struct net *net,
 		       const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx, int estab,
-		       struct tcp_fastopen_cookie *foc, struct tcp_sock *tp)
+		       struct tcp_fastopen_cookie *foc, struct sock *sk)
 {
 	const unsigned char *ptr;
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -3802,8 +3802,7 @@ void tcp_parse_options(const struct net *net,
 				if (static_branch_unlikely(&tcp_extra_options_enabled))
 					tcp_extra_options_parse(opcode, opsize,
 								ptr, skb,
-								opt_rx,
-								tcp_to_sk(tp));
+								opt_rx, sk);
 				break;
 =

 			}
@@ -3854,7 +3853,7 @@ static bool tcp_fast_parse_options(const struct net *=
net,
 			goto extra_opt_check;
 	}
 =

-	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL, tp);
+	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL, tcp_to_sk(tp));
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

@@ -5524,7 +5523,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, =
struct sk_buff *synack,
 		/* Get original SYNACK MSS value if user MSS sets mss_clamp */
 		tcp_clear_options(&opt);
 		opt.user_mss =3D opt.mss_clamp =3D 0;
-		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL, tp);
+		tcp_parse_options(sock_net(sk), synack, &opt, 0, NULL, sk);
 		mss =3D opt.mss_clamp;
 	}
 =

@@ -5587,7 +5586,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 	int saved_clamp =3D tp->rx_opt.mss_clamp;
 	bool fastopen_fail;
 =

-	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc, tp);
+	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc, sk);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
 		tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
 =

@@ -6255,7 +6254,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
 	tmp_opt.user_mss  =3D tp->rx_opt.user_mss;
 	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
-			  want_cookie ? NULL : &foc, tp);
+			  want_cookie ? NULL : &foc, sk);
 =

 	if (want_cookie && !tmp_opt.saw_tstamp)
 		tcp_clear_options(&tmp_opt);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index fb50d3d0d158..1685c5ab4913 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -97,7 +97,8 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw,=
 struct sk_buff *skb,
 =

 	tmp_opt.saw_tstamp =3D 0;
 	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
-		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL, NULL);
+		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL,
+				  (struct sock *)tw);
 =

 		if (tmp_opt.saw_tstamp) {
 			if (tmp_opt.rcv_tsecr)
@@ -595,7 +596,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 =

 	tmp_opt.saw_tstamp =3D 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
-		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL, NULL);
+		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL,
+				  req_to_sk(req));
 =

 		if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent =3D req->ts_recent;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 0ed3721b03a2..67ea216b7ffa 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -162,7 +162,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, tp);
+	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL, sk);
 =

 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
-- =

2.15.0


--===============6774573819436612699==--
