Content-Type: multipart/mixed; boundary="===============7990544028685328741=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC mptpcp-next] mptcp: add ooo prune support
Date: Fri, 02 Oct 2020 17:45:35 +0200
Message-ID: <20201002154535.28412-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6166

--===============7990544028685328741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It might be possible that entire receive buffer is occupied by
skbs in the OOO queue.

In this case we can't pull more skbs from subflows and the holes
will never be filled.

If this happens, schedule the work queue and prune ~12% of skbs to
make space available. Also add a MIB counter for this.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 Paolo, this does relate a bit to our discussion wrt. oow
 tracking.  I thought we might need to add some sort of cushion to
 account for window discrepancies, but that might then get us
 in a state where wmem might be full...

 What do you think?

 I did NOT see such a problem in practice, this is a theoretical "fix".
 TCP has similar code to deal with corner cases of small-oow packets.

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 84d119436b22..65c575e3af60 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
+	SNMP_MIB_ITEM("OFOPrune", MPTCP_MIB_OFOPRUNE),
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 47bcecce1106..75a7fb3a87db 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
+	MPTCP_MIB_OFOPRUNE,		/* Segments pruned from OoO queue */
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 79cd8e879c10..4cc30a3d426c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -658,8 +658,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ss=
k)
 		sk_rbuf =3D ssk_rbuf;
 =

 	/* over limit? can't append more skbs to msk */
-	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
-		goto wake;
+	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf) {
+		if (likely(!skb_queue_empty(&sk->sk_receive_queue)))
+			goto wake;
+
+		/* Entire recvbuf occupied by OOO skbs? Prune time. */
+		if (!test_and_set_bit(MPTCP_WORK_PRUNE_OFO, &msk->flags) &&
+		     schedule_work(&msk->work))
+			sock_hold(sk);
+
+		return;
+	}
 =

 	if (move_skbs_to_msk(msk, ssk))
 		goto wake;
@@ -1797,6 +1806,38 @@ static bool mptcp_check_close_timeout(const struct s=
ock *sk)
 	return true;
 }
 =

+static void mptcp_prune_ofo(struct mptcp_sock *msk)
+{
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+	struct sk_buff *skb, *prev =3D NULL;
+	int goal;
+
+	if (!skb_queue_empty(&sk->sk_receive_queue) ||
+	    atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf)
+		return;
+
+	if (WARN_ON_ONCE(RB_EMPTY_ROOT(&msk->out_of_order_queue)))
+		return;
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNE);
+
+	goal =3D READ_ONCE(sk->sk_rcvbuf) >> 3;
+	skb =3D msk->ooo_last_skb;
+
+	while (skb) {
+		prev =3D skb_rb_prev(skb);
+		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
+		goal -=3D skb->truesize;
+		mptcp_drop(sk, skb);
+
+		if (goal <=3D 0)
+			break;
+		skb =3D prev;
+	}
+
+	msk->ooo_last_skb =3D prev;
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -1819,6 +1860,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (mptcp_send_head(sk))
 		mptcp_push_pending(sk, 0);
 =

+	if (test_and_clear_bit(MPTCP_WORK_PRUNE_OFO, &msk->flags))
+		mptcp_prune_ofo(msk);
+
 	if (msk->pm.status)
 		pm_work(msk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d33e9676a1a3..360441fdaa93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,6 +91,7 @@
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORKER_RUNNING	5
+#define MPTCP_WORK_PRUNE_OFO	6
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
-- =

2.26.2

--===============7990544028685328741==--
