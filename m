Content-Type: multipart/mixed; boundary="===============1364816815351436042=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 6/9] mptcp: Remove Redundant scheduler
Date: Tue, 01 May 2018 13:35:35 -0700
Message-ID: <20180501203538.95477-7-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 591

--===============1364816815351436042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/Kconfig           |  13 --
 net/mptcp/Makefile          |   1 -
 net/mptcp/mptcp_redundant.c | 301 ----------------------------------------=
----
 3 files changed, 315 deletions(-)
 delete mode 100644 net/mptcp/mptcp_redundant.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 13cf4d51ce1f..e4d5dd5d1959 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -85,13 +85,6 @@ config MPTCP_ROUNDROBIN
 	  This is a very simple round-robin scheduler. Probably has bad performan=
ce
 	  but might be interesting for researchers.
 =

-config MPTCP_REDUNDANT
-	tristate "MPTCP Redundant"
-	depends on (MPTCP=3Dy)
-	---help---
-	  This scheduler sends all packets redundantly over all subflows to decre=
ases
-	  latency and jitter on the cost of lower throughput.
-
 choice
 	prompt "Default MPTCP Scheduler"
 	default DEFAULT
@@ -110,12 +103,6 @@ choice
 		  This is the round-rob scheduler, sending in a round-robin
 		  fashion..
 =

-	config DEFAULT_REDUNDANT
-		bool "Redundant" if MPTCP_REDUNDANT=3Dy
-		---help---
-		  This is the redundant scheduler, sending packets redundantly over
-		  all the subflows.
-
 endchoice
 endif
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index dd9714fa070b..81dd47c2a52a 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
 obj-$(CONFIG_MPTCP_BINDER) +=3D mptcp_binder.o
 obj-$(CONFIG_MPTCP_ROUNDROBIN) +=3D mptcp_rr.o
-obj-$(CONFIG_MPTCP_REDUNDANT) +=3D mptcp_redundant.o
 =

 mptcp-$(subst m,y,$(CONFIG_IPV6)) +=3D mptcp_ipv6.o
 =

diff --git a/net/mptcp/mptcp_redundant.c b/net/mptcp/mptcp_redundant.c
deleted file mode 100644
index 001a3f8a974d..000000000000
--- a/net/mptcp/mptcp_redundant.c
+++ /dev/null
@@ -1,301 +0,0 @@
-/*
- *	MPTCP Scheduler to reduce latency and jitter.
- *
- *	This scheduler sends all packets redundantly on all available subflows.
- *
- *	Initial Design & Implementation:
- *	Tobias Erbshaeusser <erbshauesser(a)dvs.tu-darmstadt.de>
- *	Alexander Froemmgen <froemmge(a)dvs.tu-darmstadt.de>
- *
- *	Initial corrections & modifications:
- *	Christian Pinedo <christian.pinedo(a)ehu.eus>
- *	Igor Lopez <igor.lopez(a)ehu.eus>
- *
- *	This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <net/mptcp.h>
-
-/* Struct to store the data of a single subflow */
-struct redsched_sock_data {
-	/* The skb or NULL */
-	struct sk_buff *skb;
-	/* End sequence number of the skb. This number should be checked
-	 * to be valid before the skb field is used
-	 */
-	u32 skb_end_seq;
-};
-
-/* Struct to store the data of the control block */
-struct redsched_cb_data {
-	/* The next subflow where a skb should be sent or NULL */
-	struct tcp_sock *next_subflow;
-};
-
-/* Returns the socket data from a given subflow socket */
-static struct redsched_sock_data *redsched_get_sock_data(struct tcp_sock *=
tp)
-{
-	return (struct redsched_sock_data *)&tp->mptcp->mptcp_sched[0];
-}
-
-/* Returns the control block data from a given meta socket */
-static struct redsched_cb_data *redsched_get_cb_data(struct tcp_sock *tp)
-{
-	return (struct redsched_cb_data *)&tp->mpcb->mptcp_sched[0];
-}
-
-static bool redsched_get_active_valid_sks(struct sock *meta_sk)
-{
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
-	struct sock *sk;
-	int active_valid_sks =3D 0;
-
-	mptcp_for_each_sk(mpcb, sk) {
-		if (subflow_is_active((struct tcp_sock *)sk) &&
-		    !mptcp_is_def_unavailable(sk))
-			active_valid_sks++;
-	}
-
-	return active_valid_sks;
-}
-
-static bool redsched_use_subflow(struct sock *meta_sk,
-				 int active_valid_sks,
-				 struct tcp_sock *tp,
-				 struct sk_buff *skb)
-{
-	if (!skb || !mptcp_is_available((struct sock *)tp, skb, false))
-		return false;
-
-	if (TCP_SKB_CB(skb)->path_mask !=3D 0)
-		return subflow_is_active(tp);
-
-	if (TCP_SKB_CB(skb)->path_mask =3D=3D 0) {
-		if (active_valid_sks =3D=3D -1)
-			active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
-
-		if (subflow_is_backup(tp) && active_valid_sks > 0)
-			return false;
-		else
-			return true;
-	}
-
-	return false;
-}
-
-static struct sock *redundant_get_subflow(struct sock *meta_sk,
-					  struct sk_buff *skb,
-					  bool zero_wnd_test)
-{
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
-	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(meta_tp);
-	struct tcp_sock *first_tp =3D cb_data->next_subflow;
-	struct sock *sk;
-	struct tcp_sock *tp;
-
-	/* Answer data_fin on same subflow */
-	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
-	    skb && mptcp_is_data_fin(skb)) {
-		mptcp_for_each_sk(mpcb, sk) {
-			if (tcp_sk(sk)->mptcp->path_index =3D=3D
-				mpcb->dfin_path_index &&
-			    mptcp_is_available(sk, skb, zero_wnd_test))
-				return sk;
-		}
-	}
-
-	if (!first_tp)
-		first_tp =3D mpcb->connection_list;
-	tp =3D first_tp;
-
-	/* still NULL (no subflow in connection_list?) */
-	if (!first_tp)
-		return NULL;
-
-	/* Search for any subflow to send it */
-	do {
-		if (mptcp_is_available((struct sock *)tp, skb,
-				       zero_wnd_test)) {
-			cb_data->next_subflow =3D tp->mptcp->next;
-			return (struct sock *)tp;
-		}
-
-		tp =3D tp->mptcp->next;
-		if (!tp)
-			tp =3D mpcb->connection_list;
-	} while (tp !=3D first_tp);
-
-	/* No space */
-	return NULL;
-}
-
-/* Corrects the stored skb pointers if they are invalid */
-static void redsched_correct_skb_pointers(struct sock *meta_sk,
-					  struct redsched_sock_data *sk_data)
-{
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-
-	if (sk_data->skb && !after(sk_data->skb_end_seq, meta_tp->snd_una))
-		sk_data->skb =3D NULL;
-}
-
-/* Returns the next skb from the queue */
-static struct sk_buff *redundant_next_skb_from_queue(struct sk_buff_head *=
queue,
-						     struct sk_buff *previous,
-						     struct sock *meta_sk)
-{
-	if (skb_queue_empty(queue))
-		return NULL;
-
-	if (!previous)
-		return skb_peek(queue);
-
-	if (skb_queue_is_last(queue, previous))
-		return NULL;
-
-	/* sk_data->skb stores the last scheduled packet for this subflow.
-	 * If sk_data->skb was scheduled but not sent (e.g., due to nagle),
-	 * we have to schedule it again.
-	 *
-	 * For the redundant scheduler, there are two cases:
-	 * 1. sk_data->skb was not sent on another subflow:
-	 *    we have to schedule it again to ensure that we do not
-	 *    skip this packet.
-	 * 2. sk_data->skb was already sent on another subflow:
-	 *    with regard to the redundant semantic, we have to
-	 *    schedule it again. However, we keep it simple and ignore it,
-	 *    as it was already sent by another subflow.
-	 *    This might be changed in the future.
-	 *
-	 * For case 1, send_head is equal previous, as only a single
-	 * packet can be skipped.
-	 */
-	if (tcp_send_head(meta_sk) =3D=3D previous)
-		return tcp_send_head(meta_sk);
-
-	return skb_queue_next(queue, previous);
-}
-
-static struct sk_buff *redundant_next_segment(struct sock *meta_sk,
-					      int *reinject,
-					      struct sock **subsk,
-					      unsigned int *limit)
-{
-	struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
-	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(meta_tp);
-	struct tcp_sock *first_tp =3D cb_data->next_subflow;
-	struct tcp_sock *tp;
-	struct sk_buff *skb;
-	int active_valid_sks =3D -1;
-
-	/* As we set it, we have to reset it as well. */
-	*limit =3D 0;
-
-	if (skb_queue_empty(&mpcb->reinject_queue) &&
-	    skb_queue_empty(&meta_sk->sk_write_queue))
-		/* Nothing to send */
-		return NULL;
-
-	/* First try reinjections */
-	skb =3D skb_peek(&mpcb->reinject_queue);
-	if (skb) {
-		*subsk =3D get_available_subflow(meta_sk, skb, false);
-		if (!*subsk)
-			return NULL;
-		*reinject =3D 1;
-		return skb;
-	}
-
-	/* Then try indistinctly redundant and normal skbs */
-
-	if (!first_tp)
-		first_tp =3D mpcb->connection_list;
-
-	/* still NULL (no subflow in connection_list?) */
-	if (!first_tp)
-		return NULL;
-
-	tp =3D first_tp;
-
-	*reinject =3D 0;
-	active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
-	do {
-		struct redsched_sock_data *sk_data;
-
-		/* Correct the skb pointers of the current subflow */
-		sk_data =3D redsched_get_sock_data(tp);
-		redsched_correct_skb_pointers(meta_sk, sk_data);
-
-		skb =3D redundant_next_skb_from_queue(&meta_sk->sk_write_queue,
-						    sk_data->skb, meta_sk);
-		if (skb && redsched_use_subflow(meta_sk, active_valid_sks, tp,
-						skb)) {
-			sk_data->skb =3D skb;
-			sk_data->skb_end_seq =3D TCP_SKB_CB(skb)->end_seq;
-			cb_data->next_subflow =3D tp->mptcp->next;
-			*subsk =3D (struct sock *)tp;
-
-			if (TCP_SKB_CB(skb)->path_mask)
-				*reinject =3D -1;
-			return skb;
-		}
-
-		tp =3D tp->mptcp->next;
-		if (!tp)
-			tp =3D mpcb->connection_list;
-	} while (tp !=3D first_tp);
-
-	/* Nothing to send */
-	return NULL;
-}
-
-static void redundant_release(struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct redsched_cb_data *cb_data =3D redsched_get_cb_data(tp);
-
-	/* Check if the next subflow would be the released one. If yes correct
-	 * the pointer
-	 */
-	if (cb_data->next_subflow =3D=3D tp)
-		cb_data->next_subflow =3D tp->mptcp->next;
-}
-
-static struct mptcp_sched_ops mptcp_sched_redundant =3D {
-	.get_subflow =3D redundant_get_subflow,
-	.next_segment =3D redundant_next_segment,
-	.release =3D redundant_release,
-	.name =3D "redundant",
-	.owner =3D THIS_MODULE,
-};
-
-static int __init redundant_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct redsched_sock_data) > MPTCP_SCHED_SIZE);
-	BUILD_BUG_ON(sizeof(struct redsched_cb_data) > MPTCP_SCHED_DATA_SIZE);
-
-	if (mptcp_register_scheduler(&mptcp_sched_redundant))
-		return -1;
-
-	return 0;
-}
-
-static void redundant_unregister(void)
-{
-	mptcp_unregister_scheduler(&mptcp_sched_redundant);
-}
-
-module_init(redundant_register);
-module_exit(redundant_unregister);
-
-MODULE_AUTHOR("Tobias Erbshaeusser, Alexander Froemmgen");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("REDUNDANT MPTCP");
-MODULE_VERSION("0.90");
-- =

2.16.2


--===============1364816815351436042==--
