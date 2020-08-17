Content-Type: multipart/mixed; boundary="===============3208435918839931765=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2] mptcp: adjust mptcp receive buffer
 limit if subflow has larger one
Date: Mon, 17 Aug 2020 02:55:24 +0200
Message-ID: <20200817005524.16344-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5564

--===============3208435918839931765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In addition to tcp autotuning during read, it may also increase the
receive buffer in tcp_clamp_window().

In this case, mptcp should adjust its receive buffer size as well so
it can pull all pending skbs at once.

At this time, when TCP grows its receive buffer, it may have more
skbs ready for processing than what mptcp allows.

In the mptcp case, the receive window is derived from free
space of the mptcp parent socket instead of the individual subflows.
Following the subflow allows mptcp to grow its receive buffer.

This is especially noticeable for loopback traffic, when even two
skbs are enough to fill the initial receive window.

In mptcp_data_ready() we do not hold the mptcp socket lock, so
modification of sk_rcvbuf is racy.  Do it when moving skbs from subflow
to mptcp socket, both sockets are locked in this case.

v2: move rcvbuf update to __mptcp_move_skbs_from_subflow where both
mptcp and subflow sk locks are held (pointed out by Mat).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 77d655b0650c..ecf93d0bec14 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -454,10 +454,17 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct sock *sk =3D (struct sock *)msk;
 	unsigned int moved =3D 0;
+	int sk_rbuf, ssk_rbuf;
 	bool more_data_avail;
 	struct tcp_sock *tp;
 	bool done =3D false;
 =

+	ssk_rbuf =3D READ_ONCE(ssk->sk_rcvbuf);
+	sk_rbuf =3D READ_ONCE(sk->sk_rcvbuf);
+
+	if (unlikely(ssk_rbuf > sk_rbuf))
+		WRITE_ONCE(sk->sk_rcvbuf, ssk_rbuf);
+
 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 	tp =3D tcp_sk(ssk);
 	do {
@@ -511,7 +518,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 		WRITE_ONCE(tp->copied_seq, seq);
 		more_data_avail =3D mptcp_subflow_data_available(ssk);
 =

-		if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf)) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf) {
 			done =3D true;
 			break;
 		}
@@ -603,6 +610,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int sk_rbuf, ssk_rbuf;
 	bool wake;
 =

 	/* move_skbs_to_msk below can legitly clear the data_avail flag,
@@ -613,12 +621,16 @@ void mptcp_data_ready(struct sock *sk, struct sock *s=
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

2.26.2

--===============3208435918839931765==--
