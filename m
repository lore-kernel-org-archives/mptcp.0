Content-Type: multipart/mixed; boundary="===============6859357828661854364=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 6/8] mptcp: implement memory accounting for
 mptcp rtx queue
Date: Thu, 22 Aug 2019 15:47:43 +0200
Message-ID: <5451d9a5581164e2428f2530405ca0238a545838.1566481012.git.pabeni@redhat.com>
In-Reply-To: cover.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1672

--===============6859357828661854364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Charge the data on the rtx queue to the master MPTCP socket, too.
Such memory in uncharged when the data is acked/dequeued.

Do not interfer with memory pressure accounting, TCP will deal
with that at subflow level.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v1 -> rfc v2:
 - initialize memory_allocated/sysctl_mem fields in struct proto,
   required to have mem accounting primitives do their work
 - deal with mem scheduling failure, bailing out the xmit
---
 net/mptcp/protocol.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b77669b0c79a..c9caa0692f41 100644
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
@@ -244,6 +246,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	if (!dfrag_collapsed) {
 		dfrag =3D mptcp_carve_data_frag(msk, pfrag, offset);
 		offset =3D dfrag->offset;
+		frag_truesize =3D dfrag->overhead;
 	}
 	psize =3D min_t(size_t, pfrag->size - offset, avail_size);
 =

@@ -256,6 +259,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	if (!psize)
 		return -EINVAL;
 =

+	if (!sk_wmem_schedule(sk, psize + dfrag->overhead))
+		return -ENOMEM;
+
 	/* tell the TCP stack to delay the push so that we can safely
 	 * access the skb after the sendpages call
 	 */
@@ -277,6 +283,11 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 		list_add_tail(&dfrag->list, &msk->rtx_queue);
 	}
 =

+	/* charge data on mptcp rtx queue to the master socket
+	 * Note: we charge such data both to sk and ssk
+	 */
+	sk->sk_forward_alloc -=3D frag_truesize;
+
 	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
 	BUG_ON(collapsed && !can_collapse);
 	if (collapsed) {
@@ -790,6 +801,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		list_del(&dfrag->list);
+		sk_mem_uncharge(sk, dfrag->data_len + dfrag->overhead);
 		put_page(dfrag->page);
 	}
 }
@@ -1097,6 +1109,8 @@ static struct proto mptcp_prot =3D {
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
+	.memory_allocated =3D &tcp_memory_allocated,
+	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.no_autobind	=3D 1,
 };
-- =

2.21.0


--===============6859357828661854364==--
