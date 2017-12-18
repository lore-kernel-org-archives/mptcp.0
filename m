Content-Type: multipart/mixed; boundary="===============3737513168485300199=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC final 01/14] tcp: Write options after the header has
 been fully done
Date: Sun, 17 Dec 2017 22:42:32 -0800
Message-ID: <20171218064245.94150-2-cpaasch@apple.com>
In-Reply-To: 20171218064245.94150-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 278

--===============3737513168485300199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The generic TCP-option framework will need to have access to the full
TCP-header (e.g., if we want to compute a checksum for TCP-MD5).

Thus, we move the call to tcp_options_write() to after all the fields in
the header have been filled out.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 04be9f833927..0f66d101d0ca 100644
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
@@ -3242,8 +3242,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
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


--===============3737513168485300199==--
