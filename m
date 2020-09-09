Content-Type: multipart/mixed; boundary="===============5373411798017756840=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: call tcp_cleanup_rbuf on subflows
Date: Wed, 09 Sep 2020 15:51:20 +0200
Message-ID: <3e3bca22480da1920cb48f87d1167a0f22cbd63f.1599659451.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5768

--===============5373411798017756840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That is needed to let the subflows announce promply when new
space is available in the receive buffer.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
should be inserted just before "mptcp: simult flow self-tests"
---
 net/ipv4/tcp.c       | 2 +-
 net/mptcp/protocol.c | 8 ++++++++
 net/mptcp/subflow.c  | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
index 7469e89b3d7a..e32e094022e6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -444,6 +444,8 @@ static void mptcp_check_data_fin(struct sock *sk)
 	}
 }
 =

+void tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -527,6 +529,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	} while (more_data_avail);
 =

 	*bytes +=3D moved;
+	if (moved)
+		tcp_cleanup_rbuf(ssk, moved);
 =

 	return done;
 }
@@ -1439,10 +1443,14 @@ static void mptcp_rcv_space_adjust(struct mptcp_soc=
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
index e31900ff0c56..246207a0a869 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -806,6 +806,8 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 	return MAPPING_OK;
 }
 =

+void tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *s=
kb,
 				       unsigned limit)
 {
@@ -823,6 +825,8 @@ static void mptcp_subflow_discard_data(struct sock *ssk=
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

--===============5373411798017756840==--
