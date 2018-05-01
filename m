Content-Type: multipart/mixed; boundary="===============8897411264763186922=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 7/9] mptcp: Remove RoundRobin Scheduler
Date: Tue, 01 May 2018 13:35:36 -0700
Message-ID: <20180501203538.95477-8-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 592

--===============8897411264763186922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/Kconfig    |  13 ---
 net/mptcp/Makefile   |   1 -
 net/mptcp/mptcp_rr.c | 301 -----------------------------------------------=
----
 3 files changed, 315 deletions(-)
 delete mode 100644 net/mptcp/mptcp_rr.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index e4d5dd5d1959..0333de3e6349 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -78,13 +78,6 @@ menuconfig MPTCP_SCHED_ADVANCED
 =

 if MPTCP_SCHED_ADVANCED
 =

-config MPTCP_ROUNDROBIN
-	tristate "MPTCP Round-Robin"
-	depends on (MPTCP=3Dy)
-	---help---
-	  This is a very simple round-robin scheduler. Probably has bad performan=
ce
-	  but might be interesting for researchers.
-
 choice
 	prompt "Default MPTCP Scheduler"
 	default DEFAULT
@@ -97,12 +90,6 @@ choice
 		  This is the default scheduler, sending first on the subflow
 		  with the lowest RTT.
 =

-	config DEFAULT_ROUNDROBIN
-		bool "Round-Robin" if MPTCP_ROUNDROBIN=3Dy
-		---help---
-		  This is the round-rob scheduler, sending in a round-robin
-		  fashion..
-
 endchoice
 endif
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 81dd47c2a52a..d722b8266014 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,7 +11,6 @@ mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
 obj-$(CONFIG_MPTCP_BINDER) +=3D mptcp_binder.o
-obj-$(CONFIG_MPTCP_ROUNDROBIN) +=3D mptcp_rr.o
 =

 mptcp-$(subst m,y,$(CONFIG_IPV6)) +=3D mptcp_ipv6.o
 =

diff --git a/net/mptcp/mptcp_rr.c b/net/mptcp/mptcp_rr.c
deleted file mode 100644
index 8910ba9e6052..000000000000
--- a/net/mptcp/mptcp_rr.c
+++ /dev/null
@@ -1,301 +0,0 @@
-/* MPTCP Scheduler module selector. Highly inspired by tcp_cong.c */
-
-#include <linux/module.h>
-#include <net/mptcp.h>
-
-static unsigned char num_segments __read_mostly =3D 1;
-module_param(num_segments, byte, 0644);
-MODULE_PARM_DESC(num_segments, "The number of consecutive segments that ar=
e part of a burst");
-
-static bool cwnd_limited __read_mostly =3D 1;
-module_param(cwnd_limited, bool, 0644);
-MODULE_PARM_DESC(cwnd_limited, "if set to 1, the scheduler tries to fill t=
he congestion-window on all subflows");
-
-struct rrsched_priv {
-	unsigned char quota;
-};
-
-static struct rrsched_priv *rrsched_get_priv(const struct tcp_sock *tp)
-{
-	return (struct rrsched_priv *)&tp->mptcp->mptcp_sched[0];
-}
-
-/* If the sub-socket sk available to send the skb? */
-static bool mptcp_rr_is_available(const struct sock *sk, const struct sk_b=
uff *skb,
-				  bool zero_wnd_test, bool cwnd_test)
-{
-	const struct tcp_sock *tp =3D tcp_sk(sk);
-	unsigned int space, in_flight;
-
-	/* Set of states for which we are allowed to send data */
-	if (!mptcp_sk_can_send(sk))
-		return false;
-
-	/* We do not send data on this subflow unless it is
-	 * fully established, i.e. the 4th ack has been received.
-	 */
-	if (tp->mptcp->pre_established)
-		return false;
-
-	if (tp->pf)
-		return false;
-
-	if (inet_csk(sk)->icsk_ca_state =3D=3D TCP_CA_Loss) {
-		/* If SACK is disabled, and we got a loss, TCP does not exit
-		 * the loss-state until something above high_seq has been acked.
-		 * (see tcp_try_undo_recovery)
-		 *
-		 * high_seq is the snd_nxt at the moment of the RTO. As soon
-		 * as we have an RTO, we won't push data on the subflow.
-		 * Thus, snd_una can never go beyond high_seq.
-		 */
-		if (!tcp_is_reno(tp))
-			return false;
-		else if (tp->snd_una !=3D tp->high_seq)
-			return false;
-	}
-
-	if (!tp->mptcp->fully_established) {
-		/* Make sure that we send in-order data */
-		if (skb && tp->mptcp->second_packet &&
-		    tp->mptcp->last_end_data_seq !=3D TCP_SKB_CB(skb)->seq)
-			return false;
-	}
-
-	if (!cwnd_test)
-		goto zero_wnd_test;
-
-	in_flight =3D tcp_packets_in_flight(tp);
-	/* Not even a single spot in the cwnd */
-	if (in_flight >=3D tp->snd_cwnd)
-		return false;
-
-	/* Now, check if what is queued in the subflow's send-queue
-	 * already fills the cwnd.
-	 */
-	space =3D (tp->snd_cwnd - in_flight) * tp->mss_cache;
-
-	if (tp->write_seq - tp->snd_nxt > space)
-		return false;
-
-zero_wnd_test:
-	if (zero_wnd_test && !before(tp->write_seq, tcp_wnd_end(tp)))
-		return false;
-
-	return true;
-}
-
-/* Are we not allowed to reinject this skb on tp? */
-static int mptcp_rr_dont_reinject_skb(const struct tcp_sock *tp, const str=
uct sk_buff *skb)
-{
-	/* If the skb has already been enqueued in this sk, try to find
-	 * another one.
-	 */
-	return skb &&
-		/* Has the skb already been enqueued into this subsocket? */
-		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
-}
-
-/* We just look for any subflow that is available */
-static struct sock *rr_get_available_subflow(struct sock *meta_sk,
-					     struct sk_buff *skb,
-					     bool zero_wnd_test)
-{
-	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct sock *sk, *bestsk =3D NULL, *backupsk =3D NULL;
-
-	/* Answer data_fin on same subflow!!! */
-	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
-	    skb && mptcp_is_data_fin(skb)) {
-		mptcp_for_each_sk(mpcb, sk) {
-			if (tcp_sk(sk)->mptcp->path_index =3D=3D mpcb->dfin_path_index &&
-			    mptcp_rr_is_available(sk, skb, zero_wnd_test, true))
-				return sk;
-		}
-	}
-
-	/* First, find the best subflow */
-	mptcp_for_each_sk(mpcb, sk) {
-		struct tcp_sock *tp =3D tcp_sk(sk);
-
-		if (!mptcp_rr_is_available(sk, skb, zero_wnd_test, true))
-			continue;
-
-		if (mptcp_rr_dont_reinject_skb(tp, skb)) {
-			backupsk =3D sk;
-			continue;
-		}
-
-		bestsk =3D sk;
-	}
-
-	if (bestsk) {
-		sk =3D bestsk;
-	} else if (backupsk) {
-		/* It has been sent on all subflows once - let's give it a
-		 * chance again by restarting its pathmask.
-		 */
-		if (skb)
-			TCP_SKB_CB(skb)->path_mask =3D 0;
-		sk =3D backupsk;
-	}
-
-	return sk;
-}
-
-/* Returns the next segment to be sent from the mptcp meta-queue.
- * (chooses the reinject queue if any segment is waiting in it, otherwise,
- * chooses the normal write queue).
- * Sets *@reinject to 1 if the returned segment comes from the
- * reinject queue. Sets it to 0 if it is the regular send-head of the meta=
-sk,
- * and sets it to -1 if it is a meta-level retransmission to optimize the
- * receive-buffer.
- */
-static struct sk_buff *__mptcp_rr_next_segment(const struct sock *meta_sk,=
 int *reinject)
-{
-	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct sk_buff *skb =3D NULL;
-
-	*reinject =3D 0;
-
-	/* If we are in fallback-mode, just take from the meta-send-queue */
-	if (mpcb->infinite_mapping_snd || mpcb->send_infinite_mapping)
-		return tcp_send_head(meta_sk);
-
-	skb =3D skb_peek(&mpcb->reinject_queue);
-
-	if (skb)
-		*reinject =3D 1;
-	else
-		skb =3D tcp_send_head(meta_sk);
-	return skb;
-}
-
-static struct sk_buff *mptcp_rr_next_segment(struct sock *meta_sk,
-					     int *reinject,
-					     struct sock **subsk,
-					     unsigned int *limit)
-{
-	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
-	struct sock *sk_it, *choose_sk =3D NULL;
-	struct sk_buff *skb =3D __mptcp_rr_next_segment(meta_sk, reinject);
-	unsigned char split =3D num_segments;
-	unsigned char iter =3D 0, full_subs =3D 0;
-
-	/* As we set it, we have to reset it as well. */
-	*limit =3D 0;
-
-	if (!skb)
-		return NULL;
-
-	if (*reinject) {
-		*subsk =3D rr_get_available_subflow(meta_sk, skb, false);
-		if (!*subsk)
-			return NULL;
-
-		return skb;
-	}
-
-retry:
-
-	/* First, we look for a subflow who is currently being used */
-	mptcp_for_each_sk(mpcb, sk_it) {
-		struct tcp_sock *tp_it =3D tcp_sk(sk_it);
-		struct rrsched_priv *rsp =3D rrsched_get_priv(tp_it);
-
-		if (!mptcp_rr_is_available(sk_it, skb, false, cwnd_limited))
-			continue;
-
-		iter++;
-
-		/* Is this subflow currently being used? */
-		if (rsp->quota > 0 && rsp->quota < num_segments) {
-			split =3D num_segments - rsp->quota;
-			choose_sk =3D sk_it;
-			goto found;
-		}
-
-		/* Or, it's totally unused */
-		if (!rsp->quota) {
-			split =3D num_segments;
-			choose_sk =3D sk_it;
-		}
-
-		/* Or, it must then be fully used  */
-		if (rsp->quota >=3D num_segments)
-			full_subs++;
-	}
-
-	/* All considered subflows have a full quota, and we considered at
-	 * least one.
-	 */
-	if (iter && iter =3D=3D full_subs) {
-		/* So, we restart this round by setting quota to 0 and retry
-		 * to find a subflow.
-		 */
-		mptcp_for_each_sk(mpcb, sk_it) {
-			struct tcp_sock *tp_it =3D tcp_sk(sk_it);
-			struct rrsched_priv *rsp =3D rrsched_get_priv(tp_it);
-
-			if (!mptcp_rr_is_available(sk_it, skb, false, cwnd_limited))
-				continue;
-
-			rsp->quota =3D 0;
-		}
-
-		goto retry;
-	}
-
-found:
-	if (choose_sk) {
-		unsigned int mss_now;
-		struct tcp_sock *choose_tp =3D tcp_sk(choose_sk);
-		struct rrsched_priv *rsp =3D rrsched_get_priv(choose_tp);
-
-		if (!mptcp_rr_is_available(choose_sk, skb, false, true))
-			return NULL;
-
-		*subsk =3D choose_sk;
-		mss_now =3D tcp_current_mss(*subsk);
-		*limit =3D split * mss_now;
-
-		if (skb->len > mss_now)
-			rsp->quota +=3D DIV_ROUND_UP(skb->len, mss_now);
-		else
-			rsp->quota++;
-
-		return skb;
-	}
-
-	return NULL;
-}
-
-static struct mptcp_sched_ops mptcp_sched_rr =3D {
-	.get_subflow =3D rr_get_available_subflow,
-	.next_segment =3D mptcp_rr_next_segment,
-	.name =3D "roundrobin",
-	.owner =3D THIS_MODULE,
-};
-
-static int __init rr_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct rrsched_priv) > MPTCP_SCHED_SIZE);
-
-	if (mptcp_register_scheduler(&mptcp_sched_rr))
-		return -1;
-
-	return 0;
-}
-
-static void rr_unregister(void)
-{
-	mptcp_unregister_scheduler(&mptcp_sched_rr);
-}
-
-module_init(rr_register);
-module_exit(rr_unregister);
-
-MODULE_AUTHOR("Christoph Paasch");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("ROUNDROBIN MPTCP");
-MODULE_VERSION("0.89");
-- =

2.16.2


--===============8897411264763186922==--
