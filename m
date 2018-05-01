Content-Type: multipart/mixed; boundary="===============2964592945963746444=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 4/9] mptcp: Remove Coupled congestion
 control
Date: Tue, 01 May 2018 13:35:33 -0700
Message-ID: <20180501203538.95477-5-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 588

--===============2964592945963746444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/Kconfig          |   8 --
 net/mptcp/Makefile        |   1 -
 net/mptcp/mptcp_coupled.c | 271 ------------------------------------------=
----
 3 files changed, 280 deletions(-)
 delete mode 100644 net/mptcp/mptcp_coupled.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index eb8e5b0296b6..d5cd17c3e74b 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -680,14 +680,6 @@ config TCP_CONG_BBR
 	bufferbloat, policers, or AQM schemes that do not provide a delay
 	signal. It requires the fq ("Fair Queue") pacing packet scheduler.
 =

-config TCP_CONG_LIA
-	tristate "MPTCP Linked Increase"
-	depends on MPTCP
-	default n
-	---help---
-	MultiPath TCP Linked Increase Congestion Control
-	To enable it, just put 'lia' in tcp_congestion_control
-
 config TCP_CONG_MCTCPDESYNC
 	tristate "DESYNCHRONIZED MCTCP CONGESTION CONTROL (EXPERIMENTAL)"
 	depends on MPTCP
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index bcdbc899db05..06068fa6c6f8 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 	   mptcp_output.o mptcp_input.o mptcp_sched.o
 =

-obj-$(CONFIG_TCP_CONG_LIA) +=3D mptcp_coupled.o
 obj-$(CONFIG_TCP_CONG_MCTCPDESYNC) +=3D mctcp_desync.o
 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
diff --git a/net/mptcp/mptcp_coupled.c b/net/mptcp/mptcp_coupled.c
deleted file mode 100644
index f9d856334ca9..000000000000
--- a/net/mptcp/mptcp_coupled.c
+++ /dev/null
@@ -1,271 +0,0 @@
-/*
- *	MPTCP implementation - Linked Increase congestion control Algorithm (LI=
A)
- *
- *	Initial Design & Implementation:
- *	S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
- *
- *	Current Maintainer & Author:
- *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
- *
- *	Additional authors:
- *	Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
- *	Gregory Detal <gregory.detal(a)uclouvain.be>
- *	Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
- *	Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
- *	Lavkesh Lahngir <lavkesh51(a)gmail.com>
- *	Andreas Ripke <ripke(a)neclab.eu>
- *	Vlad Dogaru <vlad.dogaru(a)intel.com>
- *	Octavian Purdila <octavian.purdila(a)intel.com>
- *	John Ronan <jronan(a)tssg.org>
- *	Catalin Nicutar <catalin.nicutar(a)gmail.com>
- *	Brandon Heller <brandonh(a)stanford.edu>
- *
- *
- *	This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-#include <net/tcp.h>
-#include <net/mptcp.h>
-
-#include <linux/module.h>
-
-/* Scaling is done in the numerator with alpha_scale_num and in the denomi=
nator
- * with alpha_scale_den.
- *
- * To downscale, we just need to use alpha_scale.
- *
- * We have: alpha_scale =3D alpha_scale_num / (alpha_scale_den ^ 2)
- */
-static int alpha_scale_den =3D 10;
-static int alpha_scale_num =3D 32;
-static int alpha_scale =3D 12;
-
-struct mptcp_ccc {
-	u64	alpha;
-	bool	forced_update;
-};
-
-static inline int mptcp_ccc_sk_can_send(const struct sock *sk)
-{
-	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
-}
-
-static inline u64 mptcp_get_alpha(const struct sock *meta_sk)
-{
-	return ((struct mptcp_ccc *)inet_csk_ca(meta_sk))->alpha;
-}
-
-static inline void mptcp_set_alpha(const struct sock *meta_sk, u64 alpha)
-{
-	((struct mptcp_ccc *)inet_csk_ca(meta_sk))->alpha =3D alpha;
-}
-
-static inline u64 mptcp_ccc_scale(u32 val, int scale)
-{
-	return (u64) val << scale;
-}
-
-static inline bool mptcp_get_forced(const struct sock *meta_sk)
-{
-	return ((struct mptcp_ccc *)inet_csk_ca(meta_sk))->forced_update;
-}
-
-static inline void mptcp_set_forced(const struct sock *meta_sk, bool force)
-{
-	((struct mptcp_ccc *)inet_csk_ca(meta_sk))->forced_update =3D force;
-}
-
-static void mptcp_ccc_recalc_alpha(const struct sock *sk)
-{
-	const struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
-	const struct sock *sub_sk;
-	int best_cwnd =3D 0, best_rtt =3D 0, can_send =3D 0;
-	u64 max_numerator =3D 0, sum_denominator =3D 0, alpha =3D 1;
-
-	if (!mpcb)
-		return;
-
-	/* Only one subflow left - fall back to normal reno-behavior
-	 * (set alpha to 1)
-	 */
-	if (mpcb->cnt_established <=3D 1)
-		goto exit;
-
-	/* Do regular alpha-calculation for multiple subflows */
-
-	/* Find the max numerator of the alpha-calculation */
-	mptcp_for_each_sk(mpcb, sub_sk) {
-		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
-		u64 tmp;
-
-		if (!mptcp_ccc_sk_can_send(sub_sk))
-			continue;
-
-		can_send++;
-
-		/* We need to look for the path, that provides the max-value.
-		 * Integer-overflow is not possible here, because
-		 * tmp will be in u64.
-		 */
-		tmp =3D div64_u64(mptcp_ccc_scale(sub_tp->snd_cwnd,
-				alpha_scale_num), (u64)sub_tp->srtt_us * sub_tp->srtt_us);
-
-		if (tmp >=3D max_numerator) {
-			max_numerator =3D tmp;
-			best_cwnd =3D sub_tp->snd_cwnd;
-			best_rtt =3D sub_tp->srtt_us;
-		}
-	}
-
-	/* No subflow is able to send - we don't care anymore */
-	if (unlikely(!can_send))
-		goto exit;
-
-	/* Calculate the denominator */
-	mptcp_for_each_sk(mpcb, sub_sk) {
-		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
-
-		if (!mptcp_ccc_sk_can_send(sub_sk))
-			continue;
-
-		sum_denominator +=3D div_u64(
-				mptcp_ccc_scale(sub_tp->snd_cwnd,
-						alpha_scale_den) * best_rtt,
-						sub_tp->srtt_us);
-	}
-	sum_denominator *=3D sum_denominator;
-	if (unlikely(!sum_denominator)) {
-		pr_err("%s: sum_denominator =3D=3D 0, cnt_established:%d\n",
-		       __func__, mpcb->cnt_established);
-		mptcp_for_each_sk(mpcb, sub_sk) {
-			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
-			pr_err("%s: pi:%d, state:%d\n, rtt:%u, cwnd: %u",
-			       __func__, sub_tp->mptcp->path_index,
-			       sub_sk->sk_state, sub_tp->srtt_us,
-			       sub_tp->snd_cwnd);
-		}
-	}
-
-	alpha =3D div64_u64(mptcp_ccc_scale(best_cwnd, alpha_scale_num), sum_deno=
minator);
-
-	if (unlikely(!alpha))
-		alpha =3D 1;
-
-exit:
-	mptcp_set_alpha(mptcp_meta_sk(sk), alpha);
-}
-
-static void mptcp_ccc_init(struct sock *sk)
-{
-	if (mptcp(tcp_sk(sk))) {
-		mptcp_set_forced(mptcp_meta_sk(sk), 0);
-		mptcp_set_alpha(mptcp_meta_sk(sk), 1);
-	}
-	/* If we do not mptcp, behave like reno: return */
-}
-
-static void mptcp_ccc_cwnd_event(struct sock *sk, enum tcp_ca_event event)
-{
-	if (event =3D=3D CA_EVENT_LOSS)
-		mptcp_ccc_recalc_alpha(sk);
-}
-
-static void mptcp_ccc_set_state(struct sock *sk, u8 ca_state)
-{
-	if (!mptcp(tcp_sk(sk)))
-		return;
-
-	mptcp_set_forced(mptcp_meta_sk(sk), 1);
-}
-
-static void mptcp_ccc_cong_avoid(struct sock *sk, u32 ack, u32 acked)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	const struct mptcp_cb *mpcb =3D tp->mpcb;
-	int snd_cwnd;
-
-	if (!mptcp(tp)) {
-		tcp_reno_cong_avoid(sk, ack, acked);
-		return;
-	}
-
-	if (!tcp_is_cwnd_limited(sk))
-		return;
-
-	if (tcp_in_slow_start(tp)) {
-		/* In "safe" area, increase. */
-		tcp_slow_start(tp, acked);
-		mptcp_ccc_recalc_alpha(sk);
-		return;
-	}
-
-	if (mptcp_get_forced(mptcp_meta_sk(sk))) {
-		mptcp_ccc_recalc_alpha(sk);
-		mptcp_set_forced(mptcp_meta_sk(sk), 0);
-	}
-
-	if (mpcb->cnt_established > 1) {
-		u64 alpha =3D mptcp_get_alpha(mptcp_meta_sk(sk));
-
-		/* This may happen, if at the initialization, the mpcb
-		 * was not yet attached to the sock, and thus
-		 * initializing alpha failed.
-		 */
-		if (unlikely(!alpha))
-			alpha =3D 1;
-
-		snd_cwnd =3D (int) div_u64 ((u64) mptcp_ccc_scale(1, alpha_scale),
-						alpha);
-
-		/* snd_cwnd_cnt >=3D max (scale * tot_cwnd / alpha, cwnd)
-		 * Thus, we select here the max value.
-		 */
-		if (snd_cwnd < tp->snd_cwnd)
-			snd_cwnd =3D tp->snd_cwnd;
-	} else {
-		snd_cwnd =3D tp->snd_cwnd;
-	}
-
-	if (tp->snd_cwnd_cnt >=3D snd_cwnd) {
-		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
-			tp->snd_cwnd++;
-			mptcp_ccc_recalc_alpha(sk);
-		}
-
-		tp->snd_cwnd_cnt =3D 0;
-	} else {
-		tp->snd_cwnd_cnt++;
-	}
-}
-
-static struct tcp_congestion_ops mptcp_ccc =3D {
-	.init		=3D mptcp_ccc_init,
-	.ssthresh	=3D tcp_reno_ssthresh,
-	.cong_avoid	=3D mptcp_ccc_cong_avoid,
-	.undo_cwnd	=3D tcp_reno_undo_cwnd,
-	.cwnd_event	=3D mptcp_ccc_cwnd_event,
-	.set_state	=3D mptcp_ccc_set_state,
-	.owner		=3D THIS_MODULE,
-	.name		=3D "lia",
-};
-
-static int __init mptcp_ccc_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct mptcp_ccc) > ICSK_CA_PRIV_SIZE);
-	return tcp_register_congestion_control(&mptcp_ccc);
-}
-
-static void __exit mptcp_ccc_unregister(void)
-{
-	tcp_unregister_congestion_control(&mptcp_ccc);
-}
-
-module_init(mptcp_ccc_register);
-module_exit(mptcp_ccc_unregister);
-
-MODULE_AUTHOR("Christoph Paasch, S=C3=A9bastien Barr=C3=A9");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MPTCP LINKED INCREASE CONGESTION CONTROL ALGORITHM");
-MODULE_VERSION("0.1");
-- =

2.16.2


--===============2964592945963746444==--
