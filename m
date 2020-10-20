Content-Type: multipart/mixed; boundary="===============1606143188594161925=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: add missing memory scheduling in the rx
 path
Date: Tue, 20 Oct 2020 11:59:16 +0200
Message-ID: <e9c867c873d2f44405498568e7709c4f2a94ece7.1603187930.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6362

--===============1606143188594161925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When moving the skbs from the subflow into the msk receive
queue, we must schedule there the required amount of memory.

Try to borrow the required memory from the subflow, if needed,
so that we leverage the existing TCP heuristic.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
@Florian: this is somewhat relates to the RFC patch
"mptcp: add ooo prune support". I think we could try to prune the
subflow via tcp_prune_queue()/tcp_prune_ofo_queue() when the msk is
under memory pressure, so that we don't need to drop data already
acked at the TCP level.
---
 net/mptcp/protocol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f0c5ad44eef..ebb43b2c1b34 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -286,6 +286,15 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, s=
truct sock *ssk,
 	skb_ext_reset(skb);
 	skb_orphan(skb);
 =

+	/* try to fetch required memory from subflow */
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
+		if (ssk->sk_forward_alloc < skb->truesize)
+			goto drop;
+		__sk_mem_reclaim(ssk, skb->truesize);
+		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+			goto drop;
+	}
+
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
@@ -313,6 +322,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, st=
ruct sock *ssk,
 	 * will retransmit as needed, if needed.
 	 */
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
-- =

2.26.2

--===============1606143188594161925==--
