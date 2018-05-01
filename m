Content-Type: multipart/mixed; boundary="===============3788996892624854669=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 5/9] mptcp: Remove MCTCP Desync
 congestion control
Date: Tue, 01 May 2018 13:35:34 -0700
Message-ID: <20180501203538.95477-6-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 590

--===============3788996892624854669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/Kconfig         |  13 ----
 net/mptcp/Makefile       |   1 -
 net/mptcp/mctcp_desync.c | 189 -------------------------------------------=
----
 3 files changed, 203 deletions(-)
 delete mode 100644 net/mptcp/mctcp_desync.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index d5cd17c3e74b..28de03f7a931 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -680,19 +680,6 @@ config TCP_CONG_BBR
 	bufferbloat, policers, or AQM schemes that do not provide a delay
 	signal. It requires the fq ("Fair Queue") pacing packet scheduler.
 =

-config TCP_CONG_MCTCPDESYNC
-	tristate "DESYNCHRONIZED MCTCP CONGESTION CONTROL (EXPERIMENTAL)"
-	depends on MPTCP
-	default n
-	---help---
-	Desynchronized MultiChannel TCP Congestion Control. This is experimental
-	code that only supports single path and must have set mptcp_ndiffports
-	larger than one.
-	To enable it, just put 'mctcpdesync' in tcp_congestion_control
-	For further details see:
-	  http://ieeexplore.ieee.org/abstract/document/6911722/
-	  https://doi.org/10.1016/j.comcom.2015.07.010
-
 choice
 	prompt "Default TCP congestion control"
 	default DEFAULT_CUBIC
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 06068fa6c6f8..dd9714fa070b 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 	   mptcp_output.o mptcp_input.o mptcp_sched.o
 =

-obj-$(CONFIG_TCP_CONG_MCTCPDESYNC) +=3D mctcp_desync.o
 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
 obj-$(CONFIG_MPTCP_BINDER) +=3D mptcp_binder.o
diff --git a/net/mptcp/mctcp_desync.c b/net/mptcp/mctcp_desync.c
deleted file mode 100644
index 9c5d6c196da5..000000000000
--- a/net/mptcp/mctcp_desync.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- *  Desynchronized Multi-Channel TCP Congestion Control Algorithm
- *
- *  Implementation based on publications of "DMCTCP:Desynchronized Multi-C=
hannel
- *  TCP for high speed access networks with tiny buffers" in 23rd internat=
ional
- *  conference of Computer Communication and Networks (ICCCN), 2014, and
- *  "Exploring parallelism and desynchronization of TCP over high speed ne=
tworks
- *  with tiny buffers" in Journal of Computer Communications Elsevier, 201=
5.
- *
- *  http://ieeexplore.ieee.org/abstract/document/6911722/
- *  https://doi.org/10.1016/j.comcom.2015.07.010
- *
- *  This prototype is for research purpose and is currently experimental c=
ode
- *  that only support a single path. Future support of multi-channel over
- *  multi-path requires channels grouping.
- *
- *  Initial Design and Implementation:
- *  Cheng Cui <Cheng.Cui(a)netapp.com>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the =
Free
- *  Software Foundation; either version 2 of the License, or (at your opti=
on)
- *  any later version.
- */
-#include <net/tcp.h>
-#include <net/mptcp.h>
-#include <linux/module.h>
-
-enum {
-	MASTER_CHANNEL =3D 1,
-	INI_MIN_CWND =3D 2,
-};
-
-/* private congestion control structure:
- * off_tstamp: the last backoff timestamp for loss synchronization event
- * off_subfid: the subflow which was backoff on off_tstamp
- */
-struct mctcp_desync {
-	u64	off_tstamp;
-	u8	off_subfid;
-};
-
-static inline int mctcp_cc_sk_can_send(const struct sock *sk)
-{
-	return mptcp_sk_can_send(sk) && tcp_sk(sk)->srtt_us;
-}
-
-static void mctcp_desync_init(struct sock *sk)
-{
-	if (mptcp(tcp_sk(sk))) {
-		struct mctcp_desync *ca =3D inet_csk_ca(mptcp_meta_sk(sk));
-		ca->off_tstamp =3D 0;
-		ca->off_subfid =3D 0;
-    }
-    /* If we do not mptcp, behave like reno: return */
-}
-
-static void mctcp_desync_cong_avoid(struct sock *sk, u32 ack, u32 acked)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	if (!mptcp(tp) || (1 =3D=3D tp->mpcb->cnt_established)) {
-		tcp_reno_cong_avoid(sk, ack, acked);
-		return;
-	} else if (!tcp_is_cwnd_limited(sk)) {
-		return;
-	} else {
-		const struct mctcp_desync *ca =3D inet_csk_ca(mptcp_meta_sk(sk));
-		const u8 subfid =3D tp->mptcp->path_index;
-		const struct sock *sub_sk;
-
-		/* current aggregated cwnd */
-		u32 agg_cwnd =3D 0;
-		u32 min_cwnd =3D 0xffffffff;
-		u8 min_cwnd_subfid =3D 0;
-
-		/* In "safe" area, increase */
-		if (tcp_in_slow_start(tp)) {
-			if (ca->off_subfid) {
-				/* passed initial phase, allow slow start */
-				tcp_slow_start(tp, acked);
-			} else if (MASTER_CHANNEL =3D=3D tp->mptcp->path_index) {
-				/* master channel is normal slow start in
-				 * initial phase */
-				tcp_slow_start(tp, acked);
-			} else {
-				/* secondary channels increase slowly until
-				 * the initial phase passed
-				 */
-				tp->snd_ssthresh =3D tp->snd_cwnd =3D INI_MIN_CWND;
-			}
-			return;
-		}
-		  /* In dangerous area, increase slowly and linearly. */
-		  else {
-			/* get total cwnd and the subflow that has min cwnd */
-			mptcp_for_each_sk(tp->mpcb, sub_sk) {
-				if (mctcp_cc_sk_can_send(sub_sk)) {
-					const struct tcp_sock *sub_tp =3D
-								tcp_sk(sub_sk);
-					agg_cwnd +=3D sub_tp->snd_cwnd;
-					if(min_cwnd > sub_tp->snd_cwnd) {
-						min_cwnd =3D sub_tp->snd_cwnd;
-						min_cwnd_subfid =3D
-						      sub_tp->mptcp->path_index;
-					}
-				}
-			}
-			/* the smallest subflow grows faster than others */
-			if (subfid =3D=3D min_cwnd_subfid) {
-				tcp_cong_avoid_ai(tp, min_cwnd, acked);
-			} else {
-				tcp_cong_avoid_ai(tp, agg_cwnd - min_cwnd,
-						  acked);
-			}
-		}
-	}
-}
-
-static u32 mctcp_desync_ssthresh(struct sock *sk)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-
-	if (!mptcp(tp) || (1 =3D=3D tp->mpcb->cnt_established)) {
-		return max(tp->snd_cwnd >> 1U, 2U);
-	} else {
-		struct mctcp_desync *ca =3D inet_csk_ca(mptcp_meta_sk(sk));
-		const u8 subfid =3D tp->mptcp->path_index;
-		const struct sock *sub_sk;
-		u32 max_cwnd =3D 0;
-		u8 max_cwnd_subfid =3D 0;
-
-		/* Find the subflow that has the max cwnd. */
-		mptcp_for_each_sk(tp->mpcb, sub_sk) {
-			if (mctcp_cc_sk_can_send(sub_sk)) {
-				const struct tcp_sock *sub_tp =3D tcp_sk(sub_sk);
-				if (max_cwnd < sub_tp->snd_cwnd) {
-					max_cwnd =3D sub_tp->snd_cwnd;
-					max_cwnd_subfid =3D
-						sub_tp->mptcp->path_index;
-				}
-			}
-		}
-		/* Use high resolution clock. */
-		if (subfid =3D=3D max_cwnd_subfid) {
-			u64 now =3D tcp_clock_us();
-			u32 delta =3D tcp_stamp_us_delta(now, ca->off_tstamp);
-
-			if (delta < (tp->srtt_us >> 3)) {
-				/* desynchronize */
-				return tp->snd_cwnd;
-			} else {
-				ca->off_tstamp =3D now;
-				ca->off_subfid =3D subfid;
-				return max(max_cwnd >> 1U, 2U);
-			}
-		} else {
-			return tp->snd_cwnd;
-		}
-	}
-}
-
-static struct tcp_congestion_ops mctcp_desync =3D {
-	.init       =3D mctcp_desync_init,
-	.ssthresh   =3D mctcp_desync_ssthresh,
-	.undo_cwnd  =3D tcp_reno_undo_cwnd,
-	.cong_avoid =3D mctcp_desync_cong_avoid,
-	.owner      =3D THIS_MODULE,
-	.name       =3D "mctcpdesync",
-};
-
-static int __init mctcp_desync_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct mctcp_desync) > ICSK_CA_PRIV_SIZE);
-	return tcp_register_congestion_control(&mctcp_desync);
-}
-
-static void __exit mctcp_desync_unregister(void)
-{
-	tcp_unregister_congestion_control(&mctcp_desync);
-}
-
-module_init(mctcp_desync_register);
-module_exit(mctcp_desync_unregister);
-
-MODULE_AUTHOR("Cheng Cui");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MCTCP: DESYNCHRONIZED MULTICHANNEL TCP CONGESTION CONT=
ROL");
-MODULE_VERSION("1.0");
-- =

2.16.2


--===============3788996892624854669==--
