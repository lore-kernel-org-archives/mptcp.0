Content-Type: multipart/mixed; boundary="===============7404520505524754203=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 08/13] mptcp: add OoO related mibs
Date: Mon, 14 Sep 2020 10:01:14 +0200
Message-ID: <a968da10355e303d483a9d12409930e80ab7fccd.1599854632.git.pabeni@redhat.com>
In-Reply-To: cover.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5839

--===============7404520505524754203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a bunch of MPTCP mibs related to MPTCP OoO data
processing.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/mib.c      |  5 +++++
 net/mptcp/mib.h      |  5 +++++
 net/mptcp/protocol.c | 24 +++++++++++++++++++++++-
 net/mptcp/subflow.c  |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 0a6a15f3456d..056986c7a228 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -22,6 +22,11 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
+	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
+	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
+	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
+	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index d7de340fc997..937a177729f1 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -15,6 +15,11 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
+	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
+	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
+	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
+	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6fbfbab51660..ec9c38d3acc7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -128,6 +128,9 @@ static bool mptcp_try_coalesce(struct sock *sk, struct =
sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 =

+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
+		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq =3D MPTCP_SKB_CB(from)->end_seq;
 	kfree_skb_partial(from, fragstolen);
 	atomic_add(delta, &sk->sk_rmem_alloc);
@@ -160,13 +163,17 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
 	max_seq =3D tcp_space(sk);
 	max_seq =3D max_seq > 0 ? max_seq + msk->ack_seq : msk->ack_seq;
 =

+	pr_debug("msk=3D%p seq=3D%llx limit=3D%llx empty=3D%d", msk, seq, max_seq,
+		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
 	}
 =

 	p =3D &msk->out_of_order_queue.rb_node;
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUE);
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
 		rb_link_node(&skb->rbnode, NULL, p);
 		rb_insert_color(&skb->rbnode, &msk->out_of_order_queue);
@@ -177,11 +184,15 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
 	/* with 2 subflows, adding at end of ooo queue is quite likely
 	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
 	 */
-	if (mptcp_ooo_try_coalesce(msk, msk->ooo_last_skb, skb))
+	if (mptcp_ooo_try_coalesce(msk, msk->ooo_last_skb, skb)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOMERGE);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		return;
+	}
 =

 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
 	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent =3D &msk->ooo_last_skb->rbnode;
 		p =3D &parent->rb_right;
 		goto insert;
@@ -200,6 +211,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk=
, struct sk_buff *skb)
 			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
 				/* All the bits are present. Drop. */
 				mptcp_drop(sk, skb);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				return;
 			}
 			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
@@ -215,13 +227,16 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
 				rb_replace_node(&skb1->rbnode, &skb->rbnode,
 						&msk->out_of_order_queue);
 				mptcp_drop(sk, skb1);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				goto merge_right;
 			}
 		} else if (mptcp_ooo_try_coalesce(msk, skb1, skb)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOMERGE);
 			return;
 		}
 		p =3D &parent->rb_right;
 	}
+
 insert:
 	/* Insert segment into RB tree. */
 	rb_link_node(&skb->rbnode, parent, p);
@@ -234,6 +249,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk=
, struct sk_buff *skb)
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 	}
 	/* If there is no skb after us, we are the last_skb ! */
 	if (!skb1)
@@ -283,6 +299,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, st=
ruct sock *ssk,
 	/* old data, keep it simple and drop the whole pkt, sender
 	 * will retransmit as needed, if needed.
 	 */
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 	mptcp_drop(sk, skb);
 	return false;
 }
@@ -511,6 +528,7 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
 	u64 end_seq;
 =

 	p =3D rb_first(&msk->out_of_order_queue);
+	pr_debug("msk=3D%p empty=3D%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_que=
ue));
 	while (p) {
 		skb =3D rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -522,6 +540,7 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
 		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
 				      msk->ack_seq))) {
 			mptcp_drop(sk, skb);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 =

@@ -531,6 +550,9 @@ static bool mptcp_ofo_queue(struct mptcp_sock *msk)
 			int delta =3D msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 =

 			/* skip overlapping data, if any */
+			pr_debug("uncoalesced seq=3D%llx ack seq=3D%llx delta=3D%d",
+				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
+				 delta);
 			MPTCP_SKB_CB(skb)->offset +=3D delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6eb2fc0a8ebb..8c9418d1901b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -816,6 +816,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk=
, struct sk_buff *skb,
 =

 	pr_debug("discarding=3D%d len=3D%d seq=3D%d", incr, skb->len,
 		 subflow->map_subflow_seq);
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq +=3D incr;
 	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
 		sk_eat_skb(ssk, skb);
-- =

2.26.2

--===============7404520505524754203==--
