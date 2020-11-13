Content-Type: multipart/mixed; boundary="===============7206597542868414734=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/6] mptcp: separate accouting for wmem forward
 alloc mem
Date: Fri, 13 Nov 2020 17:27:31 +0100
Message-ID: <f258529e0cc92e23cda9129216a672ce10e850e7.1605283958.git.pabeni@redhat.com>
In-Reply-To: cover.1605283958.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6716

--===============7206597542868414734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Account separatelly the memory forward allocated
for write operation. When sendmsg() need more memory
it looks at wforward_alloc first and if that is
exaused, move more space from sk_forward_alloc.

This will simplify the next patch

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 52 +++++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  1 +
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6397083476e3..87d8659b9bcc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -852,9 +852,48 @@ static bool mptcp_frag_can_collapse_to(const struct mp=
tcp_sock *msk,
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
 }
 =

+static bool mptcp_wmem_alloc(struct sock *sk, int size)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int amount;
+
+	if (msk->wforward_alloc >=3D size)
+		goto account;
+
+	if (!sk_wmem_schedule(sk, size))
+		return false;
+
+	/* try to keep half fwd alloc memory for each direction */
+	amount =3D max(size, sk->sk_forward_alloc >> 1);
+	sk->sk_forward_alloc -=3D amount;
+	msk->wforward_alloc +=3D amount;
+
+account:
+	msk->wforward_alloc -=3D size;
+	return true;
+}
+
+static void mptcp_wmem_uncharge(struct sock *sk, int size)
+{
+	mptcp_sk(sk)->wforward_alloc +=3D size;
+}
+
+static void mptcp_mem_reclaim_partial(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	sk->sk_forward_alloc +=3D msk->wforward_alloc;
+	msk->wforward_alloc =3D 0;
+	sk_mem_reclaim_partial(sk);
+
+	/* split the remaining fwd allocated memory between rx and tx */
+	msk->wforward_alloc =3D sk->sk_forward_alloc >> 1;
+	sk->sk_forward_alloc -=3D msk->wforward_alloc;
+}
+
 static void dfrag_uncharge(struct sock *sk, int len)
 {
-	sk_mem_uncharge(sk, len);
+	mptcp_wmem_uncharge(sk, len);
 	sk_wmem_queued_add(sk, -len);
 }
 =

@@ -909,8 +948,8 @@ static void mptcp_clean_una(struct sock *sk)
 	}
 =

 out:
-	if (cleaned)
-		sk_mem_reclaim_partial(sk);
+	if (cleaned && tcp_under_memory_pressure(sk))
+		mptcp_mem_reclaim_partial(sk);
 }
 =

 static void mptcp_clean_una_wakeup(struct sock *sk)
@@ -1334,11 +1373,12 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
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
+			mptcp_wmem_uncharge(sk, psize + frag_truesize);
 			ret =3D -EFAULT;
 			goto out;
 		}
@@ -1354,7 +1394,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		 * Note: we charge such data both to sk and ssk
 		 */
 		sk_wmem_queued_add(sk, frag_truesize);
-		sk->sk_forward_alloc -=3D frag_truesize;
 		if (!dfrag_collapsed) {
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
@@ -1977,6 +2016,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue =3D RB_ROOT;
 	msk->first_pending =3D NULL;
+	msk->wforward_alloc =3D 0;
 =

 	msk->ack_hint =3D NULL;
 	msk->first =3D NULL;
@@ -2167,6 +2207,8 @@ static void __mptcp_destroy_sock(struct sock *sk)
 =

 	sk->sk_prot->destroy(sk);
 =

+	sk->sk_forward_alloc +=3D msk->wforward_alloc;
+	msk->wforward_alloc =3D 0;
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 	sk_refcnt_debug_release(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 07542f7b349a..2a842d228950 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -219,6 +219,7 @@ struct mptcp_sock {
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
+	int		wforward_alloc;
 	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
-- =

2.26.2

--===============7206597542868414734==--
