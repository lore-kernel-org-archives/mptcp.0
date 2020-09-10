Content-Type: multipart/mixed; boundary="===============7319051336469814077=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: call tcp_cleanup_rbuf on subflows
Date: Thu, 10 Sep 2020 12:33:53 +0200
Message-ID: <90b277657a8e3bb69267f0cc902bf0d34bf32417.1599734019.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5785

--===============7319051336469814077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That is needed to let the subflows announce promply when new
space is available in the receive buffer.

tcp_cleanup_rbuf() is currently a static function, drop the
scope modifier and add a declaration in the TCP header.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
should be inserted just before "mptcp: simult flow self-tests"

v1 -> v2:
 - move tcp_cleanup_rbuf() declaration inside the headers
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
index 7469e89b3d7a..2abfe998ed05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -527,6 +527,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	} while (more_data_avail);
 =

 	*bytes +=3D moved;
+	if (moved)
+		tcp_cleanup_rbuf(ssk, moved);
 =

 	return done;
 }
@@ -1439,10 +1441,14 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
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
index e31900ff0c56..c3073c400d6c 100644
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

--===============7319051336469814077==--
