Content-Type: multipart/mixed; boundary="===============6807450419829180741=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 3/9] mptcp: Remove OLIA congestion
 control
Date: Tue, 01 May 2018 13:35:32 -0700
Message-ID: <20180501203538.95477-4-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 587

--===============6807450419829180741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/Kconfig       |   8 --
 net/mptcp/Makefile     |   1 -
 net/mptcp/mptcp_olia.c | 310 ---------------------------------------------=
----
 3 files changed, 319 deletions(-)
 delete mode 100644 net/mptcp/mptcp_olia.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 32e98ea9d7c6..eb8e5b0296b6 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -688,14 +688,6 @@ config TCP_CONG_LIA
 	MultiPath TCP Linked Increase Congestion Control
 	To enable it, just put 'lia' in tcp_congestion_control
 =

-config TCP_CONG_OLIA
-	tristate "MPTCP Opportunistic Linked Increase"
-	depends on MPTCP
-	default n
-	---help---
-	MultiPath TCP Opportunistic Linked Increase Congestion Control
-	To enable it, just put 'olia' in tcp_congestion_control
-
 config TCP_CONG_MCTCPDESYNC
 	tristate "DESYNCHRONIZED MCTCP CONGESTION CONTROL (EXPERIMENTAL)"
 	depends on MPTCP
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index ccb1c44a06cf..bcdbc899db05 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -9,7 +9,6 @@ mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 	   mptcp_output.o mptcp_input.o mptcp_sched.o
 =

 obj-$(CONFIG_TCP_CONG_LIA) +=3D mptcp_coupled.o
-obj-$(CONFIG_TCP_CONG_OLIA) +=3D mptcp_olia.o
 obj-$(CONFIG_TCP_CONG_MCTCPDESYNC) +=3D mctcp_desync.o
 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
diff --git a/net/mptcp/mptcp_olia.c b/net/mptcp/mptcp_olia.c
deleted file mode 100644
index c17c306849a3..000000000000
--- a/net/mptcp/mptcp_olia.c
+++ /dev/null
@@ -1,310 +0,0 @@
-/*
- * MPTCP implementation - OPPORTUNISTIC LINKED INCREASES CONGESTION CONTRO=
L:
- *
- * Algorithm design:
- * Ramin Khalili <ramin.khalili(a)epfl.ch>
- * Nicolas Gast <nicolas.gast(a)epfl.ch>
- * Jean-Yves Le Boudec <jean-yves.leboudec(a)epfl.ch>
- *
- * Implementation:
- * Ramin Khalili <ramin.khalili(a)epfl.ch>
- *
- * Ported to the official MPTCP-kernel:
- * Christoph Paasch <christoph.paasch(a)uclouvain.be>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-
-#include <net/tcp.h>
-#include <net/mptcp.h>
-
-#include <linux/module.h>
-
-static int scale =3D 10;
-
-struct mptcp_olia {
-	u32	mptcp_loss1;
-	u32	mptcp_loss2;
-	u32	mptcp_loss3;
-	int	epsilon_num;
-	u32	epsilon_den;
-	int	mptcp_snd_cwnd_cnt;
-};
-
-static inline int mptcp_olia_sk_can_send(const struct sock *sk)
-{
-	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
-}
-
-static inline u64 mptcp_olia_scale(u64 val, int scale)
-{
-	return (u64) val << scale;
-}
-
-/* take care of artificially inflate (see RFC5681)
- * of cwnd during fast-retransmit phase
- */
-static u32 mptcp_get_crt_cwnd(struct sock *sk)
-{
-	const struct inet_connection_sock *icsk =3D inet_csk(sk);
-
-	if (icsk->icsk_ca_state =3D=3D TCP_CA_Recovery)
-		return tcp_sk(sk)->snd_ssthresh;
-	else
-		return tcp_sk(sk)->snd_cwnd;
-}
-
-/* return the dominator of the first term of  the increasing term */
-static u64 mptcp_get_rate(const struct mptcp_cb *mpcb , u32 path_rtt)
-{
-	struct sock *sk;
-	u64 rate =3D 1; /* We have to avoid a zero-rate because it is used as a d=
ivisor */
-
-	mptcp_for_each_sk(mpcb, sk) {
-		struct tcp_sock *tp =3D tcp_sk(sk);
-		u64 scaled_num;
-		u32 tmp_cwnd;
-
-		if (!mptcp_olia_sk_can_send(sk))
-			continue;
-
-		tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
-		scaled_num =3D mptcp_olia_scale(tmp_cwnd, scale) * path_rtt;
-		rate +=3D div_u64(scaled_num , tp->srtt_us);
-	}
-	rate *=3D rate;
-	return rate;
-}
-
-/* find the maximum cwnd, used to find set M */
-static u32 mptcp_get_max_cwnd(const struct mptcp_cb *mpcb)
-{
-	struct sock *sk;
-	u32 best_cwnd =3D 0;
-
-	mptcp_for_each_sk(mpcb, sk) {
-		u32 tmp_cwnd;
-
-		if (!mptcp_olia_sk_can_send(sk))
-			continue;
-
-		tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
-		if (tmp_cwnd > best_cwnd)
-			best_cwnd =3D tmp_cwnd;
-	}
-	return best_cwnd;
-}
-
-static void mptcp_get_epsilon(const struct mptcp_cb *mpcb)
-{
-	struct mptcp_olia *ca;
-	struct tcp_sock *tp;
-	struct sock *sk;
-	u64 tmp_int, tmp_rtt, best_int =3D 0, best_rtt =3D 1;
-	u32 max_cwnd, tmp_cwnd;
-	u8 M =3D 0, B_not_M =3D 0;
-
-	/* TODO - integrate this in the following loop - we just want to iterate =
once */
-
-	max_cwnd =3D mptcp_get_max_cwnd(mpcb);
-
-	/* find the best path */
-	mptcp_for_each_sk(mpcb, sk) {
-		tp =3D tcp_sk(sk);
-		ca =3D inet_csk_ca(sk);
-
-		if (!mptcp_olia_sk_can_send(sk))
-			continue;
-
-		tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
-		/* TODO - check here and rename variables */
-		tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
-			      ca->mptcp_loss2 - ca->mptcp_loss1);
-
-		if ((u64)tmp_int * best_rtt >=3D (u64)best_int * tmp_rtt) {
-			best_rtt =3D tmp_rtt;
-			best_int =3D tmp_int;
-		}
-	}
-
-	/* TODO - integrate this here in mptcp_get_max_cwnd and in the previous l=
oop */
-	/* find the size of M and B_not_M */
-	mptcp_for_each_sk(mpcb, sk) {
-		tp =3D tcp_sk(sk);
-		ca =3D inet_csk_ca(sk);
-
-		if (!mptcp_olia_sk_can_send(sk))
-			continue;
-
-		tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
-		if (tmp_cwnd =3D=3D max_cwnd) {
-			M++;
-		} else {
-			tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
-			tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
-				      ca->mptcp_loss2 - ca->mptcp_loss1);
-
-			if ((u64)tmp_int * best_rtt =3D=3D (u64)best_int * tmp_rtt)
-				B_not_M++;
-		}
-	}
-
-	/* check if the path is in M or B_not_M and set the value of epsilon acco=
rdingly */
-	mptcp_for_each_sk(mpcb, sk) {
-		tp =3D tcp_sk(sk);
-		ca =3D inet_csk_ca(sk);
-
-		if (!mptcp_olia_sk_can_send(sk))
-			continue;
-
-		if (B_not_M =3D=3D 0) {
-			ca->epsilon_num =3D 0;
-			ca->epsilon_den =3D 1;
-		} else {
-			tmp_rtt =3D (u64)tp->srtt_us * tp->srtt_us;
-			tmp_int =3D max(ca->mptcp_loss3 - ca->mptcp_loss2,
-				      ca->mptcp_loss2 - ca->mptcp_loss1);
-			tmp_cwnd =3D mptcp_get_crt_cwnd(sk);
-
-			if (tmp_cwnd < max_cwnd &&
-			    (u64)tmp_int * best_rtt =3D=3D (u64)best_int * tmp_rtt) {
-				ca->epsilon_num =3D 1;
-				ca->epsilon_den =3D mpcb->cnt_established * B_not_M;
-			} else if (tmp_cwnd =3D=3D max_cwnd) {
-				ca->epsilon_num =3D -1;
-				ca->epsilon_den =3D mpcb->cnt_established  * M;
-			} else {
-				ca->epsilon_num =3D 0;
-				ca->epsilon_den =3D 1;
-			}
-		}
-	}
-}
-
-/* setting the initial values */
-static void mptcp_olia_init(struct sock *sk)
-{
-	const struct tcp_sock *tp =3D tcp_sk(sk);
-	struct mptcp_olia *ca =3D inet_csk_ca(sk);
-
-	if (mptcp(tp)) {
-		ca->mptcp_loss1 =3D tp->snd_una;
-		ca->mptcp_loss2 =3D tp->snd_una;
-		ca->mptcp_loss3 =3D tp->snd_una;
-		ca->mptcp_snd_cwnd_cnt =3D 0;
-		ca->epsilon_num =3D 0;
-		ca->epsilon_den =3D 1;
-	}
-}
-
-/* updating inter-loss distance and ssthresh */
-static void mptcp_olia_set_state(struct sock *sk, u8 new_state)
-{
-	if (!mptcp(tcp_sk(sk)))
-		return;
-
-	if (new_state =3D=3D TCP_CA_Loss ||
-	    new_state =3D=3D TCP_CA_Recovery || new_state =3D=3D TCP_CA_CWR) {
-		struct mptcp_olia *ca =3D inet_csk_ca(sk);
-
-		if (ca->mptcp_loss3 !=3D ca->mptcp_loss2 &&
-		    !inet_csk(sk)->icsk_retransmits) {
-			ca->mptcp_loss1 =3D ca->mptcp_loss2;
-			ca->mptcp_loss2 =3D ca->mptcp_loss3;
-		}
-	}
-}
-
-/* main algorithm */
-static void mptcp_olia_cong_avoid(struct sock *sk, u32 ack, u32 acked)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct mptcp_olia *ca =3D inet_csk_ca(sk);
-	const struct mptcp_cb *mpcb =3D tp->mpcb;
-
-	u64 inc_num, inc_den, rate, cwnd_scaled;
-
-	if (!mptcp(tp)) {
-		tcp_reno_cong_avoid(sk, ack, acked);
-		return;
-	}
-
-	ca->mptcp_loss3 =3D tp->snd_una;
-
-	if (!tcp_is_cwnd_limited(sk))
-		return;
-
-	/* slow start if it is in the safe area */
-	if (tcp_in_slow_start(tp)) {
-		tcp_slow_start(tp, acked);
-		return;
-	}
-
-	mptcp_get_epsilon(mpcb);
-	rate =3D mptcp_get_rate(mpcb, tp->srtt_us);
-	cwnd_scaled =3D mptcp_olia_scale(tp->snd_cwnd, scale);
-	inc_den =3D ca->epsilon_den * tp->snd_cwnd * rate ? : 1;
-
-	/* calculate the increasing term, scaling is used to reduce the rounding =
effect */
-	if (ca->epsilon_num =3D=3D -1) {
-		if (ca->epsilon_den * cwnd_scaled * cwnd_scaled < rate) {
-			inc_num =3D rate - ca->epsilon_den *
-				cwnd_scaled * cwnd_scaled;
-			ca->mptcp_snd_cwnd_cnt -=3D div64_u64(
-			    mptcp_olia_scale(inc_num , scale) , inc_den);
-		} else {
-			inc_num =3D ca->epsilon_den *
-			    cwnd_scaled * cwnd_scaled - rate;
-			ca->mptcp_snd_cwnd_cnt +=3D div64_u64(
-			    mptcp_olia_scale(inc_num , scale) , inc_den);
-		}
-	} else {
-		inc_num =3D ca->epsilon_num * rate +
-		    ca->epsilon_den * cwnd_scaled * cwnd_scaled;
-		ca->mptcp_snd_cwnd_cnt +=3D div64_u64(
-		    mptcp_olia_scale(inc_num , scale) , inc_den);
-	}
-
-
-	if (ca->mptcp_snd_cwnd_cnt >=3D (1 << scale) - 1) {
-		if (tp->snd_cwnd < tp->snd_cwnd_clamp)
-			tp->snd_cwnd++;
-		ca->mptcp_snd_cwnd_cnt =3D 0;
-	} else if (ca->mptcp_snd_cwnd_cnt <=3D 0 - (1 << scale) + 1) {
-		tp->snd_cwnd =3D max((int) 1 , (int) tp->snd_cwnd - 1);
-		ca->mptcp_snd_cwnd_cnt =3D 0;
-	}
-}
-
-static struct tcp_congestion_ops mptcp_olia =3D {
-	.init		=3D mptcp_olia_init,
-	.ssthresh	=3D tcp_reno_ssthresh,
-	.cong_avoid	=3D mptcp_olia_cong_avoid,
-	.undo_cwnd	=3D tcp_reno_undo_cwnd,
-	.set_state	=3D mptcp_olia_set_state,
-	.owner		=3D THIS_MODULE,
-	.name		=3D "olia",
-};
-
-static int __init mptcp_olia_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct mptcp_olia) > ICSK_CA_PRIV_SIZE);
-	return tcp_register_congestion_control(&mptcp_olia);
-}
-
-static void __exit mptcp_olia_unregister(void)
-{
-	tcp_unregister_congestion_control(&mptcp_olia);
-}
-
-module_init(mptcp_olia_register);
-module_exit(mptcp_olia_unregister);
-
-MODULE_AUTHOR("Ramin Khalili, Nicolas Gast, Jean-Yves Le Boudec");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MPTCP COUPLED CONGESTION CONTROL");
-MODULE_VERSION("0.1");
-- =

2.16.2


--===============6807450419829180741==--
