Content-Type: multipart/mixed; boundary="===============0087496728447874414=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 10/13] recv: make DATA_READY reflect ssk
 in-sequence state
Date: Mon, 18 Nov 2019 22:45:35 +0100
Message-ID: <20191118214538.21931-11-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2595

--===============0087496728447874414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to make mptcp_poll independent of the subflows, we need
to keep the mptcp DATA_READY flag in sync, i.e., if it is set, at least
one ssk has in-sequence data.

If it is cleared, no further data is available.
Avoid the unconditional clearing on recv entry.
Instead make sure the flag is cleared on exit if there is no more
in-sequence data available.

v2:
 - add back 'done =3D true' assigment (Paolo)
 - keep 'break' statements instead of 'goto out'. (Paolo)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be927f456a18..8b22cf245580 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -541,8 +541,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	bool more_data_avail =3D false;
 	struct mptcp_read_arg arg;
 	read_descriptor_t desc;
+	bool wait_data =3D false;
 	struct socket *ssock;
 	struct tcp_sock *tp;
 	bool done =3D false;
@@ -575,10 +577,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		u32 map_remaining;
 		int bytes_read;
 =

-		smp_mb__before_atomic();
-		clear_bit(MPTCP_DATA_READY, &msk->flags);
-		smp_mb__after_atomic();
-
 		ssk =3D mptcp_subflow_recv_lookup(msk);
 		pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 		if (!ssk)
@@ -588,7 +586,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		tp =3D tcp_sk(ssk);
 =

 		lock_sock(ssk);
-		while (mptcp_subflow_data_available(ssk) && !done) {
+		do {
 			/* try to read as much data as available */
 			map_remaining =3D subflow->map_data_len -
 					mptcp_subflow_get_map_offset(subflow);
@@ -600,7 +598,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 				if (!copied)
 					copied =3D bytes_read;
 				done =3D true;
-				continue;
+				goto next;
 			}
 =

 			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
@@ -609,18 +607,22 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 			copied +=3D bytes_read;
 			if (copied >=3D len) {
 				done =3D true;
-				continue;
+				goto next;
 			}
 			if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
 				pr_err("Urgent data present, cannot proceed");
 				done =3D true;
-				continue;
+				goto next;
 			}
-		}
+next:
+			more_data_avail =3D mptcp_subflow_data_available(ssk);
+		} while (more_data_avail && !done);
 		release_sock(ssk);
 		continue;
 =

 wait_for_data:
+		more_data_avail =3D false;
+
 		/* only the master socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
 		 */
@@ -660,9 +662,24 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		}
 =

 		pr_debug("block timeout %ld", timeo);
+		wait_data =3D true;
 		mptcp_wait_data(sk, &timeo);
 	}
 =

+	if (more_data_avail) {
+		if (!test_bit(MPTCP_DATA_READY, &msk->flags))
+			set_bit(MPTCP_DATA_READY, &msk->flags);
+	} else if (!wait_data) {
+		clear_bit(MPTCP_DATA_READY, &msk->flags);
+
+		/* .. race-breaker: ssk might get new data after last
+		 * data_available() returns false.
+		 */
+		ssk =3D mptcp_subflow_recv_lookup(msk);
+		if (unlikely(ssk))
+			set_bit(MPTCP_DATA_READY, &msk->flags);
+	}
+
 	release_sock(sk);
 	return copied;
 }
-- =

2.23.0

--===============0087496728447874414==--
