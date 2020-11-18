Content-Type: multipart/mixed; boundary="===============4523633014690025675=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 2/7] mptcp: implement wmem reservation.
Date: Wed, 18 Nov 2020 23:30:11 +0100
Message-ID: <eb19fcfd12548db6860b03fe26e0ee351212db6f.1605737933.git.pabeni@redhat.com>
In-Reply-To: cover.1605737932.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6798

--===============4523633014690025675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This leverage the previous commit to reserve the wmem
required for the sendmsg() operation when the msk socket
lock is first acquired.
Some euristic is used to get a reasonable [over-estimate of
the whole memory required. If we can't forward alloc such amount
fallback to a resonable small chunk, otherwise enter the wait
for memory path.

When sendmsg() need more memory it looks at wmem_reserved
first and if that is exaused, move more space from
sk_forward_alloc.

The reserved memory is a transient state and is released at the
next socket unlock via the release_cb().

Overall this will simplify the next patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - rename wmem_alloc -> wmem_reserved. This now track a transient
   value, which should really exposed to user-space.
 - use mptcp_lock_sock()/release_cb() to update wmem_reserved
---
 net/mptcp/protocol.c | 92 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  1 +
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d11d1a437f41..44751ea02e54 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -859,6 +859,81 @@ static bool mptcp_frag_can_collapse_to(const struct mp=
tcp_sock *msk,
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
 }
 =

+static int mptcp_wmem_with_overhead(int size)
+{
+	return size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
+}
+
+static void __mptcp_wmem_reserve(struct sock *sk, int size)
+{
+	int amount =3D mptcp_wmem_with_overhead(size);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	WARN_ON_ONCE(msk->wmem_reserved);
+	if (amount <=3D sk->sk_forward_alloc)
+		goto reserve;
+
+	/* under memory pressure try to reserve at most a single page
+	 * otherwise try to reserve the full estimate and fallback
+	 * to a single page before entering the error path
+	 */
+	if ((tcp_under_memory_pressure(sk) && amount > PAGE_SIZE) ||
+	    !sk_wmem_schedule(sk, amount)) {
+		if (amount <=3D PAGE_SIZE)
+			goto nomem;
+
+		amount =3D PAGE_SIZE;
+		if (!sk_wmem_schedule(sk, amount))
+			goto nomem;
+	}
+
+reserve:
+	msk->wmem_reserved =3D amount;
+	sk->sk_forward_alloc -=3D amount;
+	return;
+
+nomem:
+	/* we will wait for memory on next allocation */
+	msk->wmem_reserved =3D -1;
+}
+
+static void __mptcp_update_wmem(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (!msk->wmem_reserved)
+		return;
+
+	if (msk->wmem_reserved < 0)
+		msk->wmem_reserved =3D 0;
+	if (msk->wmem_reserved > 0) {
+		sk->sk_forward_alloc +=3D msk->wmem_reserved;
+		msk->wmem_reserved =3D 0;
+	}
+}
+
+static bool mptcp_wmem_alloc(struct sock *sk, int size)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	/* check for pre-existing error condition */
+	if (msk->wmem_reserved < 0)
+		return false;
+
+	if (msk->wmem_reserved >=3D size)
+		goto account;
+
+	if (!sk_wmem_schedule(sk, size))
+		return false;
+
+	sk->sk_forward_alloc -=3D size;
+	msk->wmem_reserved +=3D size;
+
+account:
+	msk->wmem_reserved -=3D size;
+	return true;
+}
+
 static void dfrag_uncharge(struct sock *sk, int len)
 {
 	sk_mem_uncharge(sk, len);
@@ -916,7 +991,7 @@ static void mptcp_clean_una(struct sock *sk)
 	}
 =

 out:
-	if (cleaned)
+	if (cleaned && tcp_under_memory_pressure(sk))
 		sk_mem_reclaim_partial(sk);
 }
 =

@@ -1292,7 +1367,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
 		return -EOPNOTSUPP;
 =

-	lock_sock(sk);
+	mptcp_lock_sock(sk, __mptcp_wmem_reserve(sk, len));
 =

 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 =

@@ -1341,11 +1416,12 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 		offset =3D dfrag->offset + dfrag->data_len;
 		psize =3D pfrag->size - offset;
 		psize =3D min_t(size_t, psize, msg_data_left(msg));
-		if (!sk_wmem_schedule(sk, psize + frag_truesize))
+		if (!mptcp_wmem_alloc(sk, psize + frag_truesize))
 			goto wait_for_memory;
 =

 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) !=3D psize) {
+			msk->wmem_reserved +=3D psize + frag_truesize;
 			ret =3D -EFAULT;
 			goto out;
 		}
@@ -1361,7 +1437,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		 * Note: we charge such data both to sk and ssk
 		 */
 		sk_wmem_queued_add(sk, frag_truesize);
-		sk->sk_forward_alloc -=3D frag_truesize;
 		if (!dfrag_collapsed) {
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
@@ -1982,6 +2057,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
+	msk->wmem_reserved =3D 0;
 =

 	msk->ack_hint =3D NULL;
 	msk->first =3D NULL;
@@ -2180,6 +2256,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 =

 	sk->sk_prot->destroy(sk);
 =

+	WARN_ON_ONCE(msk->wmem_reserved);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
@@ -2527,13 +2604,14 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
 =

 #define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
 =

-/* this is very alike tcp_release_cb() but we must handle differently a
- * different set of events
- */
+/* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
 {
 	unsigned long flags, nflags;
 =

+	/* clear any wmem reservation and errors */
+	__mptcp_update_wmem(sk);
+
 	do {
 		flags =3D sk->sk_tsq_flags;
 		if (!(flags & MPTCP_DEFERRED_ALL))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9f553993322..4d7d14ea0fb0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -218,6 +218,7 @@ struct mptcp_sock {
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
+	int		wmem_reserved;
 	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
-- =

2.26.2

--===============4523633014690025675==--
