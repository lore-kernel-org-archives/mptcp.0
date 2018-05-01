Content-Type: multipart/mixed; boundary="===============8663360925619508775=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 2/9] mptcp: Remove wVegas congestion
 control
Date: Tue, 01 May 2018 13:35:31 -0700
Message-ID: <20180501203538.95477-3-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 586

--===============8663360925619508775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/Kconfig         |   8 --
 net/mptcp/Makefile       |   1 -
 net/mptcp/mptcp_wvegas.c | 270 -------------------------------------------=
----
 3 files changed, 279 deletions(-)
 delete mode 100644 net/mptcp/mptcp_wvegas.c

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 9c70f42cc091..32e98ea9d7c6 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -696,14 +696,6 @@ config TCP_CONG_OLIA
 	MultiPath TCP Opportunistic Linked Increase Congestion Control
 	To enable it, just put 'olia' in tcp_congestion_control
 =

-config TCP_CONG_WVEGAS
-	tristate "MPTCP WVEGAS CONGESTION CONTROL"
-	depends on MPTCP
-	default n
-	---help---
-	wVegas congestion control for MPTCP
-	To enable it, just put 'wvegas' in tcp_congestion_control
-
 config TCP_CONG_MCTCPDESYNC
 	tristate "DESYNCHRONIZED MCTCP CONGESTION CONTROL (EXPERIMENTAL)"
 	depends on MPTCP
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 2cb1e2cde40a..ccb1c44a06cf 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,7 +10,6 @@ mptcp-y :=3D mptcp_ctrl.o mptcp_ipv4.o mptcp_pm.o \
 =

 obj-$(CONFIG_TCP_CONG_LIA) +=3D mptcp_coupled.o
 obj-$(CONFIG_TCP_CONG_OLIA) +=3D mptcp_olia.o
-obj-$(CONFIG_TCP_CONG_WVEGAS) +=3D mptcp_wvegas.o
 obj-$(CONFIG_TCP_CONG_MCTCPDESYNC) +=3D mctcp_desync.o
 obj-$(CONFIG_MPTCP_FULLMESH) +=3D mptcp_fullmesh.o
 obj-$(CONFIG_MPTCP_NDIFFPORTS) +=3D mptcp_ndiffports.o
diff --git a/net/mptcp/mptcp_wvegas.c b/net/mptcp/mptcp_wvegas.c
deleted file mode 100644
index 4373b8d1ee8d..000000000000
--- a/net/mptcp/mptcp_wvegas.c
+++ /dev/null
@@ -1,270 +0,0 @@
-/*
- *	MPTCP implementation - WEIGHTED VEGAS
- *
- *	Algorithm design:
- *	Yu Cao <cyAnalyst(a)126.com>
- *	Mingwei Xu <xmw(a)csnet1.cs.tsinghua.edu.cn>
- *	Xiaoming Fu <fu(a)cs.uni-goettinggen.de>
- *
- *	Implementation:
- *	Yu Cao <cyAnalyst(a)126.com>
- *	Enhuan Dong <deh13(a)mails.tsinghua.edu.cn>
- *
- *	Ported to the official MPTCP-kernel:
- *	Christoph Paasch <christoph.paasch(a)uclouvain.be>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- */
-
-#include <linux/skbuff.h>
-#include <net/tcp.h>
-#include <net/mptcp.h>
-#include <linux/module.h>
-#include <linux/tcp.h>
-
-static int initial_alpha =3D 2;
-static int total_alpha =3D 10;
-static int gamma =3D 1;
-
-module_param(initial_alpha, int, 0644);
-MODULE_PARM_DESC(initial_alpha, "initial alpha for all subflows");
-module_param(total_alpha, int, 0644);
-MODULE_PARM_DESC(total_alpha, "total alpha for all subflows");
-module_param(gamma, int, 0644);
-MODULE_PARM_DESC(gamma, "limit on increase (scale by 2)");
-
-#define MPTCP_WVEGAS_SCALE 16
-
-/* wVegas variables */
-struct wvegas {
-	u32	beg_snd_nxt;	/* right edge during last RTT */
-	u8	doing_wvegas_now;/* if true, do wvegas for this RTT */
-
-	u16	cnt_rtt;		/* # of RTTs measured within last RTT */
-	u32 sampled_rtt; /* cumulative RTTs measured within last RTT (in usec) */
-	u32	base_rtt;	/* the min of all wVegas RTT measurements seen (in usec) */
-
-	u64 instant_rate; /* cwnd / srtt_us, unit: pkts/us * 2^16 */
-	u64 weight; /* the ratio of subflow's rate to the total rate, * 2^16 */
-	int alpha; /* alpha for each subflows */
-
-	u32 queue_delay; /* queue delay*/
-};
-
-
-static inline u64 mptcp_wvegas_scale(u32 val, int scale)
-{
-	return (u64) val << scale;
-}
-
-static void wvegas_enable(const struct sock *sk)
-{
-	const struct tcp_sock *tp =3D tcp_sk(sk);
-	struct wvegas *wvegas =3D inet_csk_ca(sk);
-
-	wvegas->doing_wvegas_now =3D 1;
-
-	wvegas->beg_snd_nxt =3D tp->snd_nxt;
-
-	wvegas->cnt_rtt =3D 0;
-	wvegas->sampled_rtt =3D 0;
-
-	wvegas->instant_rate =3D 0;
-	wvegas->alpha =3D initial_alpha;
-	wvegas->weight =3D mptcp_wvegas_scale(1, MPTCP_WVEGAS_SCALE);
-
-	wvegas->queue_delay =3D 0;
-}
-
-static inline void wvegas_disable(const struct sock *sk)
-{
-	struct wvegas *wvegas =3D inet_csk_ca(sk);
-
-	wvegas->doing_wvegas_now =3D 0;
-}
-
-static void mptcp_wvegas_init(struct sock *sk)
-{
-	struct wvegas *wvegas =3D inet_csk_ca(sk);
-
-	wvegas->base_rtt =3D 0x7fffffff;
-	wvegas_enable(sk);
-}
-
-static inline u64 mptcp_wvegas_rate(u32 cwnd, u32 rtt_us)
-{
-	return div_u64(mptcp_wvegas_scale(cwnd, MPTCP_WVEGAS_SCALE), rtt_us);
-}
-
-static void mptcp_wvegas_pkts_acked(struct sock *sk,
-				    const struct ack_sample *sample)
-{
-	struct wvegas *wvegas =3D inet_csk_ca(sk);
-	u32 vrtt;
-
-	if (sample->rtt_us < 0)
-		return;
-
-	vrtt =3D sample->rtt_us + 1;
-
-	if (vrtt < wvegas->base_rtt)
-		wvegas->base_rtt =3D vrtt;
-
-	wvegas->sampled_rtt +=3D vrtt;
-	wvegas->cnt_rtt++;
-}
-
-static void mptcp_wvegas_state(struct sock *sk, u8 ca_state)
-{
-	if (ca_state =3D=3D TCP_CA_Open)
-		wvegas_enable(sk);
-	else
-		wvegas_disable(sk);
-}
-
-static void mptcp_wvegas_cwnd_event(struct sock *sk, enum tcp_ca_event eve=
nt)
-{
-	if (event =3D=3D CA_EVENT_CWND_RESTART) {
-		mptcp_wvegas_init(sk);
-	} else if (event =3D=3D CA_EVENT_LOSS) {
-		struct wvegas *wvegas =3D inet_csk_ca(sk);
-		wvegas->instant_rate =3D 0;
-	}
-}
-
-static inline u32 mptcp_wvegas_ssthresh(const struct tcp_sock *tp)
-{
-	return  min(tp->snd_ssthresh, tp->snd_cwnd);
-}
-
-static u64 mptcp_wvegas_weight(const struct mptcp_cb *mpcb, const struct s=
ock *sk)
-{
-	u64 total_rate =3D 0;
-	struct sock *sub_sk;
-	const struct wvegas *wvegas =3D inet_csk_ca(sk);
-
-	if (!mpcb)
-		return wvegas->weight;
-
-
-	mptcp_for_each_sk(mpcb, sub_sk) {
-		struct wvegas *sub_wvegas =3D inet_csk_ca(sub_sk);
-
-		/* sampled_rtt is initialized by 0 */
-		if (mptcp_sk_can_send(sub_sk) && (sub_wvegas->sampled_rtt > 0))
-			total_rate +=3D sub_wvegas->instant_rate;
-	}
-
-	if (total_rate && wvegas->instant_rate)
-		return div64_u64(mptcp_wvegas_scale(wvegas->instant_rate, MPTCP_WVEGAS_S=
CALE), total_rate);
-	else
-		return wvegas->weight;
-}
-
-static void mptcp_wvegas_cong_avoid(struct sock *sk, u32 ack, u32 acked)
-{
-	struct tcp_sock *tp =3D tcp_sk(sk);
-	struct wvegas *wvegas =3D inet_csk_ca(sk);
-
-	if (!wvegas->doing_wvegas_now) {
-		tcp_reno_cong_avoid(sk, ack, acked);
-		return;
-	}
-
-	if (after(ack, wvegas->beg_snd_nxt)) {
-		wvegas->beg_snd_nxt  =3D tp->snd_nxt;
-
-		if (wvegas->cnt_rtt <=3D 2) {
-			tcp_reno_cong_avoid(sk, ack, acked);
-		} else {
-			u32 rtt, diff, q_delay;
-			u64 target_cwnd;
-
-			rtt =3D wvegas->sampled_rtt / wvegas->cnt_rtt;
-			target_cwnd =3D div_u64(((u64)tp->snd_cwnd * wvegas->base_rtt), rtt);
-
-			diff =3D div_u64((u64)tp->snd_cwnd * (rtt - wvegas->base_rtt), rtt);
-
-			if (diff > gamma && tcp_in_slow_start(tp)) {
-				tp->snd_cwnd =3D min(tp->snd_cwnd, (u32)target_cwnd+1);
-				tp->snd_ssthresh =3D mptcp_wvegas_ssthresh(tp);
-
-			} else if (tcp_in_slow_start(tp)) {
-				tcp_slow_start(tp, acked);
-			} else {
-				if (diff >=3D wvegas->alpha) {
-					wvegas->instant_rate =3D mptcp_wvegas_rate(tp->snd_cwnd, rtt);
-					wvegas->weight =3D mptcp_wvegas_weight(tp->mpcb, sk);
-					wvegas->alpha =3D max(2U, (u32)((wvegas->weight * total_alpha) >> MPT=
CP_WVEGAS_SCALE));
-				}
-				if (diff > wvegas->alpha) {
-					tp->snd_cwnd--;
-					tp->snd_ssthresh =3D mptcp_wvegas_ssthresh(tp);
-				} else if (diff < wvegas->alpha) {
-					tp->snd_cwnd++;
-				}
-
-				/* Try to drain link queue if needed*/
-				q_delay =3D rtt - wvegas->base_rtt;
-				if ((wvegas->queue_delay =3D=3D 0) || (wvegas->queue_delay > q_delay))
-					wvegas->queue_delay =3D q_delay;
-
-				if (q_delay >=3D 2 * wvegas->queue_delay) {
-					u32 backoff_factor =3D div_u64(mptcp_wvegas_scale(wvegas->base_rtt, M=
PTCP_WVEGAS_SCALE), 2 * rtt);
-					tp->snd_cwnd =3D ((u64)tp->snd_cwnd * backoff_factor) >> MPTCP_WVEGAS=
_SCALE;
-					wvegas->queue_delay =3D 0;
-				}
-			}
-
-			if (tp->snd_cwnd < 2)
-				tp->snd_cwnd =3D 2;
-			else if (tp->snd_cwnd > tp->snd_cwnd_clamp)
-				tp->snd_cwnd =3D tp->snd_cwnd_clamp;
-
-			tp->snd_ssthresh =3D tcp_current_ssthresh(sk);
-		}
-
-		wvegas->cnt_rtt =3D 0;
-		wvegas->sampled_rtt =3D 0;
-	}
-	/* Use normal slow start */
-	else if (tcp_in_slow_start(tp))
-		tcp_slow_start(tp, acked);
-}
-
-
-static struct tcp_congestion_ops mptcp_wvegas __read_mostly =3D {
-	.init		=3D mptcp_wvegas_init,
-	.ssthresh	=3D tcp_reno_ssthresh,
-	.cong_avoid	=3D mptcp_wvegas_cong_avoid,
-	.undo_cwnd	=3D tcp_reno_undo_cwnd,
-	.pkts_acked	=3D mptcp_wvegas_pkts_acked,
-	.set_state	=3D mptcp_wvegas_state,
-	.cwnd_event	=3D mptcp_wvegas_cwnd_event,
-
-	.owner		=3D THIS_MODULE,
-	.name		=3D "wvegas",
-};
-
-static int __init mptcp_wvegas_register(void)
-{
-	BUILD_BUG_ON(sizeof(struct wvegas) > ICSK_CA_PRIV_SIZE);
-	tcp_register_congestion_control(&mptcp_wvegas);
-	return 0;
-}
-
-static void __exit mptcp_wvegas_unregister(void)
-{
-	tcp_unregister_congestion_control(&mptcp_wvegas);
-}
-
-module_init(mptcp_wvegas_register);
-module_exit(mptcp_wvegas_unregister);
-
-MODULE_AUTHOR("Yu Cao, Enhuan Dong");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MPTCP wVegas");
-MODULE_VERSION("0.1");
-- =

2.16.2


--===============8663360925619508775==--
