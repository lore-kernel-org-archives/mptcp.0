Content-Type: multipart/mixed; boundary="===============0284299991880249085=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/2] mptcp: use tcp_build_frag()
Date: Wed, 14 Oct 2020 19:15:16 +0200
Message-ID: <9b755cbc7dac921c1806df8d3df235d71bd42c30.1602693911.git.pabeni@redhat.com>
In-Reply-To: cover.1602693911.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6306

--===============0284299991880249085==
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
index 185dacb39781..296813f3e75a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -956,17 +956,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
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
@@ -990,20 +986,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
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

--===============0284299991880249085==--
