Content-Type: multipart/mixed; boundary="===============7270398350586577836=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PRE-RFC 6/6] mptcp: implement memory accounting for mptcp
 rtx queue
Date: Fri, 16 Aug 2019 18:48:04 +0200
Message-ID: <e885fa778a668e8ef842ec18cb922f8a0edabbb1.1565970525.git.pabeni@redhat.com>
In-Reply-To: cover.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1651

--===============7270398350586577836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Charge the data on the rtx queue to the master MPTCP socket, too.
Such memory in uncharged when the data is acked/dequeued.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 18 +++++++++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5eba4e65ca93..2776a408f3e5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -121,8 +121,10 @@ static u64 mptcp_update_msk_una(struct sock *sk)
 			break;
 =

 		list_del(&dfrag->list);
+		sk_mem_uncharge(sk, dfrag->data_len + dfrag->overhead);
 		put_page(dfrag->page);
 	}
+	sk_mem_reclaim_partial(sk);
 =

 	if (msk->snd_una !=3D snd_una) {
 		msk->snd_una =3D snd_una;
@@ -172,14 +174,15 @@ bool mptcp_page_frag_refill(struct sock *sk, struct p=
age_frag *pfrag)
 =

 static inline struct mptcp_data_frag *
 mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfra=
g,
-		      int offset)
+		      int orig_offset)
 {
+	int offset =3D ALIGN(orig_offset, BITS_PER_LONG / 8);
 	struct mptcp_data_frag *dfrag;
 =

-	offset =3D ALIGN(offset, BITS_PER_LONG / 8);
 	dfrag =3D (struct mptcp_data_frag *)(pfrag->page + offset);
 	dfrag->data_len =3D 0;
 	dfrag->data_seq =3D msk->write_seq;
+	dfrag->overhead =3D offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset =3D offset + sizeof(struct mptcp_data_frag);
 	dfrag->page =3D pfrag->page;
 =

@@ -190,8 +193,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 			      struct msghdr *msg, long *timeo, int *pmss_now,
 			      int *ps_goal)
 {
+	int mss_now, avail_size, size_goal, offset, ret, frag_truesize =3D 0;
 	bool dfrag_collapsed, collapsed, can_collapse =3D false;
-	int mss_now, avail_size, size_goal, offset, ret;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_ext *mpext =3D NULL;
 	struct mptcp_data_frag *dfrag;
@@ -243,6 +246,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	if (!dfrag_collapsed) {
 		dfrag =3D mptcp_carve_data_frag(msk, pfrag, offset);
 		offset =3D dfrag->offset;
+		frag_truesize =3D dfrag->overhead;
 	}
 	psize =3D min_t(size_t, pfrag->size - offset, avail_size);
 =

@@ -274,6 +278,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 		list_add_tail(&dfrag->list, &msk->rtx_queue);
 	}
 =

+	/* charge data on mptcp rtx queue to the master socket
+	 * Note: we charge such data both to sk and ssk
+	 */
+	frag_truesize +=3D ret;
+	sk_wmem_schedule(sk, frag_truesize);
+	sk->sk_forward_alloc -=3D frag_truesize;
+
 	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
 	BUG_ON(collapsed && !can_collapse);
 	if (collapsed) {
@@ -888,6 +899,7 @@ static void mptcp_destroy(struct sock *sk)
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		list_del(&dfrag->list);
+		sk_mem_uncharge(sk, dfrag->data_len + dfrag->overhead);
 		put_page(dfrag->page);
 	}
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0a6c7c39fc8b..3a0d266576f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,6 +113,7 @@ struct mptcp_data_frag {
 	u64 data_seq;
 	int data_len;
 	int offset;
+	int overhead;
 	struct page *page;
 };
 =

-- =

2.20.1


--===============7270398350586577836==--
