Content-Type: multipart/mixed; boundary="===============1987406692704576645=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 1/9] mptcp: Remove Balia congestion
 control
Date: Tue, 01 May 2018 13:35:30 -0700
Message-ID: <20180501203538.95477-2-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 589

--===============1987406692704576645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/Kconfig        |   8 --
 net/mptcp/Makefile      |   1 -
 net/mptcp/mptcp_balia.c | 268 --------------------------------------------=
----
 3 files changed, 277 deletions(-)
 delete mode 100644 net/mptcp/mptcp_balia.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 9f071c6d93c3..9c70f42cc091 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -704,14 +704,6 @@ config TCP_CONG_WVEGAS
 	wVegas congestion control for MPTCP
 	To enable it, just put 'wvegas' in tcp_congestion_control
 =

-config TCP_CONG_BALIA
-	tristate "MPTCP BALIA CONGESTION CONTROL"
-	depends on MPTCP
-	default n
-	---help---
-	Multipath TCP Balanced Linked Adaptation Congestion Control
-	To enable it, just put 'balia' in tcp_congestion_control
-
 config TCP_CONG_MCTCPDESYNC
 	tristate "DESYNCHRONIZED MCTCP CONGESTION CONTROL (EXPERIMENTAL)"
 	depends on MPTCP
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index d3a5f3cb3052..2cb1e2cde40a 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -11,7 +11,6 @@ mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 obj-$(CONFIG_TCP_CONG_LIA) +=3D mptcp_coupled.o
 obj-$(CONFIG_TCP_CONG_OLIA) +=3D mptcp_olia.o
 obj-$(CONFIG_TCP_CONG_WVEGAS) +=3D mptcp_wvegas.o
-obj-$(CONFIG_TCP_CONG_BALIA) +=3D mptcp_balia.o
 obj-$(CONFIG_TCP_CONG_MCTCPDESYNC) +=3D mctcp_desync.o
 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
diff --git a/net/mptcp/mptcp_balia.c b/net/mptcp/mptcp_balia.c
deleted file mode 100644
index 8b1fe11b08d5..000000000000
--- a/net/mptcp/mptcp_balia.c
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- *	MPTCP implementation - Balia Congestion Control
- *	(Balanced Linked Adaptation Algorithm)
- *
- *	Analysis, Design and Implementation:
- *	Qiuyu Peng <qpeng(a)caltech.edu>
- *	Anwar Walid <anwar(a)research.bell-labs.com>
- *	Jaehyun Hwang <jhyun.hwang(a)samsung.com>
- *	Steven H. Low <slow(a)caltech.edu>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- */
-
-#include <net/tcp.h>
-#include <net/mptcp.h>
-
-#include <linux/module.h>
-
-/* The variable 'rate' (i.e., x_r) will be scaled
- * e.g., from B/s to KB/s, MB/s, or GB/s
- * if max_rate > 2^rate_scale_limit
- */
-
-static int rate_scale_limit =3D 25;
-static int alpha_scale =3D 10;
-static int scale_num =3D 5;
-
-struct mptcp_balia {
-	u64	ai;
-	u64	md;
-	bool	forced_update;
-};
-
-static inline int mptcp_balia_sk_can_send(const struct sock *sk)
-{
-	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
-}
-
-static inline u64 mptcp_get_ai(const struct sock *meta_sk)
-{
-	return ((struct mptcp_balia *)inet_csk_ca(meta_sk))->ai;
-}
-
-static inline void mptcp_set_ai(const struct sock *meta_sk, u64 ai)
-{
-	((struct mptcp_balia *)inet_csk_ca(meta_sk))->ai =3D ai;
-}
-
-static inline u64 mptcp_get_md(const struct sock *meta_sk)
-{
-	return ((struct mptcp_balia *)inet_csk_ca(meta_sk))->md;
-}
-
-static inline void mptcp_set_md(const struct sock *meta_sk, u64 md)
-{
-	((struct mptcp_balia *)inet_csk_ca(meta_sk))->md =3D md;
-}
-
-static inline u64 mptcp_balia_scale(u64 val, int scale)
-{
-	return (u64) val << scale;
-}
-
-static inline bool mptcp_get_forced(const struct sock *meta_sk)
-{
-	return ((struct mptcp_balia *)inet_csk_ca(meta_sk))->forced_update;
-}
-
-static inline void mptcp_set_forced(const struct sock *meta_sk, bool force)
-{
-	((struct mptcp_balia *)inet_csk_ca(meta_sk))->forced_update =3D force;
-}
-
-static void mptcp_balia_recalc_ai(const struct sock *sk)
-{
-	const struct tcp_sock *tp =3D tcp_sk(sk);
-	const struct mptcp_cb *mpcb =3D tp->mpcb;
-	const struct sock *sub_sk;
-	u64 max_rate =3D 0, rate =3D 0, sum_rate =3D 0;
-	u64 alpha, ai =3D tp->snd_cwnd, md =3D (tp->snd_cwnd >> 1);
-	int num_scale_down =3D 0;
-
-	if (!mpcb)
-		return;
-
-	/* Only one subflow left - fall back to normal reno-behavior */
-	if (mpcb->cnt_established <=3D 1)
-		goto exit;
-
-	/* Find max_rate first */
-	mptcp_for_each_sk(mpcb, sub_sk) {
-		struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
-		u64 tmp;
-
-		if (!mptcp_balia_sk_can_send(sub_sk))
-			continue;
-
-		tmp =3D div_u64((u64)tp->mss_cache * sub_tp->snd_cwnd
-				* (USEC_PER_SEC << 3), sub_tp->srtt_us);
-		sum_rate +=3D tmp;
-
-		if (tp =3D=3D sub_tp)
-			rate =3D tmp;
-
-		if (tmp >=3D max_rate)
-			max_rate =3D tmp;
-	}
-
-	/* At least, the current subflow should be able to send */
-	if (unlikely(!rate))
-		goto exit;
-
-	alpha =3D div64_u64(max_rate, rate);
-
-	/* Scale down max_rate if it is too high (e.g., >2^25) */
-	while (max_rate > mptcp_balia_scale(1, rate_scale_limit)) {
-		max_rate >>=3D scale_num;
-		num_scale_down++;
-	}
-
-	if (num_scale_down) {
-		sum_rate =3D 0;
-		mptcp_for_each_sk(mpcb, sub_sk) {
-			struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
-			u64 tmp;
-
-			if (!mptcp_balia_sk_can_send(sub_sk))
-				continue;
-
-			tmp =3D div_u64((u64)tp->mss_cache * sub_tp->snd_cwnd
-				* (USEC_PER_SEC << 3), sub_tp->srtt_us);
-			tmp >>=3D (scale_num * num_scale_down);
-
-			sum_rate +=3D tmp;
-		}
-		rate >>=3D (scale_num * num_scale_down);
-	}
-
-	/*	(sum_rate)^2 * 10 * w_r
-	 * ai =3D ------------------------------------
-	 *	(x_r + max_rate) * (4x_r + max_rate)
-	 */
-	sum_rate *=3D sum_rate;
-
-	ai =3D div64_u64(sum_rate * 10, rate + max_rate);
-	ai =3D div64_u64(ai * tp->snd_cwnd, (rate << 2) + max_rate);
-
-	if (unlikely(!ai))
-		ai =3D tp->snd_cwnd;
-
-	md =3D ((tp->snd_cwnd >> 1) * min(mptcp_balia_scale(alpha, alpha_scale),
-					mptcp_balia_scale(3, alpha_scale) >> 1))
-					>> alpha_scale;
-
-exit:
-	mptcp_set_ai(sk, ai);
-	mptcp_set_md(sk, md);
-}
-
-static void mptcp_balia_init(struct sock *sk)
-{
-	if (mptcp(tcp_sk(sk))) {
-		mptcp_set_forced(sk, 0);
-		mptcp_set_ai(sk, 0);
-		mptcp_set_md(sk, 0);
-	}
-}
-
-static void mptcp_balia_cwnd_event(struct sock *sk, enum tcp_ca_event even=
t)
-{
-	if (event =3D=3D CA_EVENT_COMPLETE_CWR || event =3D=3D CA_EVENT_LOSS)
-		mptcp_balia_recalc_ai(sk);
-}
-
-static void mptcp_balia_set_state(struct sock *sk, u8 ca_state)
-{
-	if (!mptcp(tcp_sk(sk)))
-		return;
-
-	mptcp_set_forced(sk, 1);
-}
-
-static void mptcp_balia_cong_avoid(struct sock *sk, u32 ack, u32 acked)
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
-		mptcp_balia_recalc_ai(sk);
-		return;
-	}
-
-	if (mptcp_get_forced(mptcp_meta_sk(sk))) {
-		mptcp_balia_recalc_ai(sk);
-		mptcp_set_forced(sk, 0);
-	}
-
-	if (mpcb->cnt_established > 1)
-		snd_cwnd =3D (int) mptcp_get_ai(sk);
-	else
-		snd_cwnd =3D tp->snd_cwnd;
-
-	if (tp->snd_cwnd_cnt >=3D snd_cwnd) {
-		if (tp->snd_cwnd < tp->snd_cwnd_clamp) {
-			tp->snd_cwnd++;
-			mptcp_balia_recalc_ai(sk);
-		}
-
-		tp->snd_cwnd_cnt =3D 0;
-	} else {
-		tp->snd_cwnd_cnt++;
-	}
-}
-
-static u32 mptcp_balia_ssthresh(struct sock *sk)
-{
-	const struct tcp_sock *tp =3D tcp_sk(sk);
-	const struct mptcp_cb *mpcb =3D tp->mpcb;
-
-	if (unlikely(!mptcp(tp) || mpcb->cnt_established <=3D 1))
-		return tcp_reno_ssthresh(sk);
-	else
-		return max((u32)(tp->snd_cwnd - mptcp_get_md(sk)), 1U);
-}
-
-static struct tcp_congestion_ops mptcp_balia =3D {
-	.init		=3D mptcp_balia_init,
-	.ssthresh	=3D mptcp_balia_ssthresh,
-	.cong_avoid	=3D mptcp_balia_cong_avoid,
-	.undo_cwnd	=3D tcp_reno_undo_cwnd,
-	.cwnd_event	=3D mptcp_balia_cwnd_event,
-	.set_state	=3D mptcp_balia_set_state,
-	.owner		=3D THIS_MODULE,
-	.name		=3D "balia",
-};
-
-static int __init mptcp_balia_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct mptcp_balia) > ICSK_CA_PRIV_SIZE);
-	return tcp_register_congestion_control(&mptcp_balia);
-}
-
-static void __exit mptcp_balia_unregister(void)
-{
-	tcp_unregister_congestion_control(&mptcp_balia);
-}
-
-module_init(mptcp_balia_register);
-module_exit(mptcp_balia_unregister);
-
-MODULE_AUTHOR("Jaehyun Hwang, Anwar Walid, Qiuyu Peng, Steven H. Low");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MPTCP BALIA CONGESTION CONTROL ALGORITHM");
-MODULE_VERSION("0.1");
-- =

2.16.2


--===============1987406692704576645==--
