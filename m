Content-Type: multipart/mixed; boundary="===============7837914246541680653=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 02/13] mptcp: use tcp_build_frag()
Date: Thu, 12 Nov 2020 11:48:00 +0100
Message-ID: <e9ab4e3eacb3b983110af3cf24b435c183a6193e.1605175834.git.pabeni@redhat.com>
In-Reply-To: cover.1605175834.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6672

--===============7837914246541680653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_push_pending() is called even on orphaned
msk (and orphaned subflows), if there is outstanding
data at close() time.

To cope with the above MPTCP needs to handle explicitly
the allocation failure on xmit. The newly introduced
do_tcp_sendfrag() allows that, just plug it.

We can additionally drop a couple of sanity checks,
duplicate in the TCP code.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b84b84adc9ad..0d712755d7fc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -992,17 +992,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		psize =3D min_t(size_t, dfrag->data_len, avail_size);
 	}
 =

-	/* tell the TCP stack to delay the push so that we can safely
-	 * access the skb after the sendpages call
-	 */
-	ret =3D do_tcp_sendpages(ssk, page, offset, psize,
-			       msg->msg_flags | MSG_SENDPAGE_NOTLAST | MSG_DONTWAIT);
-	if (ret <=3D 0) {
-		if (!retransmission)
-			iov_iter_revert(&msg->msg_iter, psize);
-		return ret;
+	tail =3D tcp_build_frag(ssk, psize, msg->msg_flags, page, offset, &psize);
+	if (!tail) {
+		tcp_remove_empty_skb(sk, tcp_write_queue_tail(ssk));
+		return -ENOMEM;
 	}
 =

+	ret =3D psize;
 	frag_truesize +=3D ret;
 	if (!retransmission) {
 		if (unlikely(ret < psize))
@@ -1026,20 +1022,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
 		sk->sk_forward_alloc -=3D frag_truesize;
 	}
 =

-	/* if the tail skb extension is still the cached one, collapsing
-	 * really happened. Note: we can't check for 'same skb' as the sk_buff
-	 * hdr on tail can be transmitted, freed and re-allocated by the
-	 * do_tcp_sendpages() call
+	/* if the tail skb is still the cached one, collapsing really happened.
 	 */
-	tail =3D tcp_write_queue_tail(ssk);
-	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
+	if (skb =3D=3D tail) {
 		WARN_ON_ONCE(!can_collapse);
 		mpext->data_len +=3D ret;
 		goto out;
 	}
 =

-	skb =3D tcp_write_queue_tail(ssk);
-	mpext =3D __skb_ext_set(skb, SKB_EXT_MPTCP, msk->cached_ext);
+	mpext =3D __skb_ext_set(tail, SKB_EXT_MPTCP, msk->cached_ext);
 	msk->cached_ext =3D NULL;
 =

 	memset(mpext, 0, sizeof(*mpext));
-- =

2.26.2

--===============7837914246541680653==--
