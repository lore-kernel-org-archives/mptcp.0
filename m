Content-Type: multipart/mixed; boundary="===============8893729217240527402=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/2] mptcp: use do_tcp_sendfrag()
Date: Tue, 06 Oct 2020 13:18:07 +0200
Message-ID: <4fb2c74c5d9325af2320827d69b09bf83a53ac42.1601982978.git.pabeni@redhat.com>
In-Reply-To: cover.1601982978.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6213

--===============8893729217240527402==
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
 net/mptcp/protocol.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d5905968fac..21b56835f151 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -958,7 +958,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	struct sk_buff *skb, *tail;
 	bool can_collapse =3D false;
 	int avail_size, ret;
-	size_t psize;
 =

 	pr_debug("msk=3D%p ssk=3D%p sending dfrag at seq=3D%lld len=3D%d already =
sent=3D%d",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
@@ -997,23 +996,21 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 			 info->limit > dfrag->data_len))
 		return 0;
 =

-	psize =3D min_t(size_t, info->limit - info->sent, avail_size);
-
 	/* tell the TCP stack to delay the push so that we can safely
 	 * access the skb after the sendpages call
 	 */
-	ret =3D do_tcp_sendpages(ssk, dfrag->page, dfrag->offset + info->sent,
-			       psize, info->flags | MSG_SENDPAGE_NOTLAST | MSG_DONTWAIT);
-	if (ret <=3D 0)
-		return ret;
+	ret =3D do_tcp_sendfrag(ssk, dfrag->page, dfrag->offset + info->sent,
+			      info->limit - info->sent, avail_size, info->flags);
+	if (ret =3D=3D -ENOMEM) {
+		tcp_remove_empty_skb(sk, tcp_write_queue_tail(sk));
+		return 0;
+	}
 =

-	/* if the tail skb extension is still the cached one, collapsing
-	 * really happened. Note: we can't check for 'same skb' as the sk_buff
-	 * hdr on tail can be transmitted, freed and re-allocated by the
-	 * do_tcp_sendpages() call
+	/* if the tail skb is still the cached one, collapsing
+	 * really happened.
 	 */
 	tail =3D tcp_write_queue_tail(ssk);
-	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
+	if (tail =3D=3D skb) {
 		WARN_ON_ONCE(!can_collapse);
 		mpext->data_len +=3D ret;
 		WARN_ON_ONCE(zero_window_probe);
-- =

2.26.2

--===============8893729217240527402==--
