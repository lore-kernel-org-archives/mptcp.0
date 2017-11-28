Content-Type: multipart/mixed; boundary="===============4737241168332656553=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 01/25] tcp: Write options after the header has been
 fully done
Date: Mon, 27 Nov 2017 21:57:02 -0800
Message-ID: <20171128055726.430-2-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 176

--===============4737241168332656553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is needed later on for TCP_MD5, as we need the complete TCP-header
to compute the TCP_MD5-hash.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a4d214c7b506..e0335be600d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1126,7 +1126,6 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 		}
 	}
 =

-	tcp_options_write((__be32 *)(th + 1), tp, &opts);
 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
 		th->window      =3D htons(tcp_select_window(sk));
@@ -1137,6 +1136,7 @@ static int tcp_transmit_skb(struct sock *sk, struct s=
k_buff *skb, int clone_it,
 		 */
 		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
 	}
+	tcp_options_write((__be32 *)(th + 1), tp, &opts);
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
 	if (md5) {
@@ -3245,8 +3245,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 =

 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window =3D htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
 	th->doff =3D (tcp_header_size >> 2);
+	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 =

 #ifdef CONFIG_TCP_MD5SIG
-- =

2.15.0


--===============4737241168332656553==--
