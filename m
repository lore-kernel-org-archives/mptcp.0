Content-Type: multipart/mixed; boundary="===============6189377748386575430=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 12/13] mptcp: call tcp_cleanup_rbuf on
 subflows
Date: Mon, 14 Sep 2020 10:01:18 +0200
Message-ID: <6b86efb4be6a098401b53a66ec49022bd1c7cfee.1599854632.git.pabeni@redhat.com>
In-Reply-To: cover.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5843

--===============6189377748386575430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That is needed to let the subflows announce promptly when new
space is available in the receive buffer.

tcp_cleanup_rbuf() is currently a static function, drop the
scope modifier and add a declaration in the TCP header.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/tcp.h    | 2 ++
 net/ipv4/tcp.c       | 2 +-
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/subflow.c  | 2 ++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e85d564446c6..852f0d71dd40 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1414,6 +1414,8 @@ static inline int tcp_full_space(const struct sock *s=
k)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 =

+void tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
  * SO_RCVLOWAT constraint, since we are receiving skbs with too small
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 57a568875539..d3781b6087cb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1527,7 +1527,7 @@ static int tcp_peek_sndq(struct sock *sk, struct msgh=
dr *msg, int len)
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void tcp_cleanup_rbuf(struct sock *sk, int copied)
+void tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	bool time_to_ack =3D false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d7af96a900c4..ef0dd2f23482 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -515,6 +515,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	} while (more_data_avail);
 =

 	*bytes +=3D moved;
+	if (moved)
+		tcp_cleanup_rbuf(ssk, moved);
 =

 	return done;
 }
@@ -1424,10 +1426,14 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
k *msk, int copied)
 			 */
 			mptcp_for_each_subflow(msk, subflow) {
 				struct sock *ssk;
+				bool slow;
 =

 				ssk =3D mptcp_subflow_tcp_sock(subflow);
+				slow =3D lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
 				tcp_sk(ssk)->window_clamp =3D window_clamp;
+				tcp_cleanup_rbuf(ssk, 1);
+				unlock_sock_fast(ssk, slow);
 			}
 		}
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8be401349d9f..a2ae3087e24d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -823,6 +823,8 @@ static void mptcp_subflow_discard_data(struct sock *ssk=
, struct sk_buff *skb,
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
 		subflow->map_valid =3D 0;
+	if (incr)
+		tcp_cleanup_rbuf(ssk, incr);
 }
 =

 static bool subflow_check_data_avail(struct sock *ssk)
-- =

2.26.2

--===============6189377748386575430==--
