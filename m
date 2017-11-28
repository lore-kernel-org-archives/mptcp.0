Content-Type: multipart/mixed; boundary="===============8685743565232199751=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 02/25] tcp: Pass sock to tcp_options_write instead
 of tcp_sock
Date: Mon, 27 Nov 2017 21:57:03 -0800
Message-ID: <20171128055726.430-3-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 180

--===============8685743565232199751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because, to write the extra-options, we need also the request-socket to
properly write the correct info.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_output.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e0335be600d3..6937098fb2b5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -444,10 +444,14 @@ struct tcp_out_options {
  * At least SACK_PERM as the first option is known to lead to a disaster
  * (but it may well be that other scenarios fail similarly).
  */
-static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
+static void tcp_options_write(__be32 *ptr, struct sock *sk,
 			      struct tcp_out_options *opts)
 {
 	u16 options =3D opts->options;	/* mungable copy */
+	struct tcp_sock *tp =3D NULL;
+
+	if (sk_fullsock(sk))
+		tp =3D tcp_sk(sk);
 =

 	if (unlikely(OPTION_MD5 & options)) {
 		*ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -1136,7 +1140,7 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 		 */
 		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
 	}
-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
+	tcp_options_write((__be32 *)(th + 1), sk, &opts);
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
 	if (md5) {
@@ -3246,7 +3250,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window =3D htons(min(req->rsk_rcv_wnd, 65535U));
 	th->doff =3D (tcp_header_size >> 2);
-	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
+	tcp_options_write((__be32 *)(th + 1), req_to_sk(req), &opts);
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 =

 #ifdef CONFIG_TCP_MD5SIG
-- =

2.15.0


--===============8685743565232199751==--
