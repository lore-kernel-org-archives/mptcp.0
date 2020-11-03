Content-Type: multipart/mixed; boundary="===============8458715618006854413=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 1/7] mptcp: adjust mptcp receive buffer
 limit if subflow has larger one
Date: Tue, 03 Nov 2020 11:05:03 -0800
Message-ID: <20201103190509.27416-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201103190509.27416-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6528

--===============8458715618006854413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

In addition to tcp autotuning during read, it may also increase the
receive buffer in tcp_clamp_window().

In this case, mptcp should adjust its receive buffer size as well so
it can move all pending skbs from the subflow socket to the mptcp socket.

At this time, TCP can have more skbs ready for processing than what the
mptcp receive buffer size allows.

In the mptcp case, the receive window announced is based on the free
space of the mptcp parent socket instead of the individual subflows.

Following the subflow allows mptcp to grow its receive buffer.

This is especially noticeable for loopback traffic where two skbs are
enough to fill the initial receive window.

In mptcp_data_ready() we do not hold the mptcp socket lock, so modifying
mptcp_sk->sk_rcvbuf is racy.  Do it when moving skbs from subflow to
mptcp socket, both sockets are locked in this case.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e7419fd15d84..e010ef7585bf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -466,6 +466,18 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 	struct tcp_sock *tp;
 	u32 old_copied_seq;
 	bool done =3D false;
+	int sk_rbuf;
+
+	sk_rbuf =3D READ_ONCE(sk->sk_rcvbuf);
+
+	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
+		int ssk_rbuf =3D READ_ONCE(ssk->sk_rcvbuf);
+
+		if (unlikely(ssk_rbuf > sk_rbuf)) {
+			WRITE_ONCE(sk->sk_rcvbuf, ssk_rbuf);
+			sk_rbuf =3D ssk_rbuf;
+		}
+	}
 =

 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 	tp =3D tcp_sk(ssk);
@@ -528,7 +540,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail =3D mptcp_subflow_data_available(ssk);
 =

-		if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf)) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf) {
 			done =3D true;
 			break;
 		}
@@ -622,6 +634,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int sk_rbuf, ssk_rbuf;
 	bool wake;
 =

 	/* move_skbs_to_msk below can legitly clear the data_avail flag,
@@ -632,12 +645,16 @@ void mptcp_data_ready(struct sock *sk, struct sock *s=
sk)
 	if (wake)
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 =

-	if (atomic_read(&sk->sk_rmem_alloc) < READ_ONCE(sk->sk_rcvbuf) &&
-	    move_skbs_to_msk(msk, ssk))
+	ssk_rbuf =3D READ_ONCE(ssk->sk_rcvbuf);
+	sk_rbuf =3D READ_ONCE(sk->sk_rcvbuf);
+	if (unlikely(ssk_rbuf > sk_rbuf))
+		sk_rbuf =3D ssk_rbuf;
+
+	/* over limit? can't append more skbs to msk */
+	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
 		goto wake;
 =

-	/* don't schedule if mptcp sk is (still) over limit */
-	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
+	if (move_skbs_to_msk(msk, ssk))
 		goto wake;
 =

 	/* mptcp socket is owned, release_cb should retry */
-- =

2.29.2

--===============8458715618006854413==--
