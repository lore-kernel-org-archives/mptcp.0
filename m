Content-Type: multipart/mixed; boundary="===============8990769790421009094=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Fri, 20 Sep 2019 18:58:19 +0200
Message-ID: <f2691051949e480e3c4c5ca28b38a2005238de10.1568998504.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1894

--===============8990769790421009094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we can hit a stream's corruption with the following sequence:
- sendmsg_frag is invoked while the write_queue tail skb's len is equal to
  the current size_goal.
  sendmsg_frag sets can_collapse to false, even if mptcp data are in sequen=
ce.
  Anyway it does not set eor in the write_queue skb.
- sendmsg_frag invokes do_tcp_sendmsg(), which tries to allocate a new skb -
  as the 'size_goal - skb->len <=3D 0' condition is true.
  But it hits memory limit and/or such allocation fails, so do_tcp_sendmsg()
  jumps to the 'wait_for_memory:' label and invokes tcp_push()
- tcp_push() tries to transmit the write queue tail skb, but due to window =
size
  limit, split it, send the first half and leave in the write queue a small=
er
  skb - without any ext attached
- do_tcp_sendmsg() invokes sk_stream_wait_memory and than checks again for =
skb
  allocation, this time skb->len is less than size_goal and do_tcp_sendmsg()
  collapse the data on the existing skb
- sendmsg_frag adds a new ext to the tail skb in write queue, but due to th=
e above
  it is associated with a wrong/unexpected subflow sequence number: it maps
  a future ssn -> stream corruption

This change addresses the above issue explicitly setting the 'eor' when hit=
ting
the initial condition so that tcp will not collapse the data after tcp_push=
().

Fixes: 6c80a73a33c2 ("mptcp: allow collapsing consecutive sendpages on the =
same substream")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Notes:
- based on top of "mptcp: implement retransmit infrastructure",
- the issue is present even without that series, but it become somewhat
  reproducible with both the above triggering MP_JOIN.
- I guess squashing to the specific commit may cause a bit of rebase confli=
ct, =

  otherwise it may be squashed to "mptcp: rework mptcp_sendmsg_frag to acce=
pt optional dfrag"
---
 net/mptcp/protocol.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 308ced6955a8..e91f761d0da6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -217,19 +217,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 =

 		/* Limit the write to the size available in the
 		 * current skb, if any, so that we create at most a new skb.
-		 * If we run out of space in the current skb (e.g. the window
-		 * size shrunk from last sent) a new skb will be allocated even
-		 * is collapsing was allowed: collapsing is effectively
-		 * disabled.
+		 * Explicitly tells TCP internals to avoid collapsing on later
+		 * queue management operation, to avoid breaking the ext <->
+		 * SSN association set here
 		 */
-		can_collapse =3D mptcp_skb_can_collapse_to(*write_seq, skb,
-							 mpext);
+		can_collapse =3D (size_goal - skb->len > 0) &&
+			      mptcp_skb_can_collapse_to(*write_seq, skb, mpext);
 		if (!can_collapse)
 			TCP_SKB_CB(skb)->eor =3D 1;
-		else if (size_goal - skb->len > 0)
-			avail_size =3D size_goal - skb->len;
 		else
-			can_collapse =3D false;
+			avail_size =3D size_goal - skb->len;
 	}
 =

 	if (!retransmission) {
-- =

2.21.0


--===============8990769790421009094==--
