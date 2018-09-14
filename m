Content-Type: multipart/mixed; boundary="===============8854325393980472627=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/20] mptcp: Remove cnt_established
Date: Fri, 14 Sep 2018 10:25:12 -0700
Message-ID: <20180914172524.67961-11-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 727

--===============8854325393980472627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want to remove the number of up-calls into the meta-socket.
cnt_established is one of those where we are modifying a field in the
mpcb.

We can remove it fairly safely. It's only use is in some MPTCP-specific
congestion controls to short-circuit some parts of it.

One particular use was in mptcp_should_expand_sndbuf(). There, we use it
to see whether to expand the sndbuf when there are only backup subflows
available.

One problem with this old code is that the decision whether or not to send =
on
a backup subflow is steered by the modular scheduler. We cannot assume in
core-MPTCP code that backup subflows are never being sent on.

By no more taking backup subflows into account, we greatly simplify
mptcp_should_expand_sndbuf at the cost of potentially increasing the
window even if there is no subflow ready to send because it's a backup
subflow.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 773f0e58474e56dfdf4334b889beebd4a8062d51)
---
 include/net/mptcp.h     |  4 ----
 net/mptcp/mptcp_ctrl.c  |  8 --------
 net/mptcp/mptcp_input.c | 20 ++------------------
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a1b9413689e3..3e6626fdfbd5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -166,7 +166,6 @@ struct mptcp_tcp_sock {
 	u16	map_data_len;
 	u16	slave_sk:1,
 		fully_established:1,
-		establish_increased:1,
 		second_packet:1,
 		attached:1,
 		send_mp_fail:1,
@@ -276,9 +275,6 @@ struct mptcp_cb {
 		snd_hiseq_index:1, /* Index in snd_high_order of snd_nxt */
 		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
 =

-	/* socket count in this connection */
-	u8 cnt_established;
-
 #define MPTCP_SCHED_DATA_SIZE 8
 	u8 mptcp_sched[MPTCP_SCHED_DATA_SIZE] __aligned(8);
 	struct mptcp_sched_ops *sched_ops;
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 5020724b4431..8db7c5bea1b4 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -745,11 +745,6 @@ static void mptcp_set_state(struct sock *sk)
 		tcp_sk(meta_sk)->lsndtime =3D tcp_jiffies32;
 	}
 =

-	if (sk->sk_state =3D=3D TCP_ESTABLISHED) {
-		tcp_sk(sk)->mptcp->establish_increased =3D 1;
-		tcp_sk(sk)->mpcb->cnt_established++;
-	}
-
 	if (sk->sk_state =3D=3D TCP_CLOSE) {
 		if (!sock_flag(sk, SOCK_DEAD))
 			mptcp_sub_close(sk, 0);
@@ -1468,9 +1463,6 @@ void mptcp_del_sock(struct sock *sk)
 			}
 		}
 	}
-	if (tp->mptcp->establish_increased)
-		mpcb->cnt_established--;
-
 	tp->mptcp->next =3D NULL;
 	tp->mptcp->attached =3D 0;
 	mpcb->path_index_bits &=3D ~(1 << tp->mptcp->path_index);
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 0ef43f8da140..645e5e1e93c7 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -2357,11 +2357,9 @@ int mptcp_rcv_synsent_state_process(struct sock *sk,=
 struct sock **skptr,
 /* Similar to tcp_should_expand_sndbuf */
 bool mptcp_should_expand_sndbuf(const struct sock *sk)
 {
-	const struct sock *sk_it;
 	const struct sock *meta_sk =3D mptcp_meta_sk(sk);
 	const struct tcp_sock *meta_tp =3D tcp_sk(meta_sk);
-	int cnt_backups =3D 0;
-	int backup_available =3D 0;
+	const struct sock *sk_it;
 =

 	/* We circumvent this check in tcp_check_space, because we want to
 	 * always call sk_write_space. So, we reproduce the check here.
@@ -2393,24 +2391,10 @@ bool mptcp_should_expand_sndbuf(const struct sock *=
sk)
 		if (!mptcp_sk_can_send(sk_it))
 			continue;
 =

-		/* Backup-flows have to be counted - if there is no other
-		 * subflow we take the backup-flow into account.
-		 */
-		if (tp_it->mptcp->rcv_low_prio || tp_it->mptcp->low_prio)
-			cnt_backups++;
-
-		if (tcp_packets_in_flight(tp_it) < tp_it->snd_cwnd) {
-			if (tp_it->mptcp->rcv_low_prio || tp_it->mptcp->low_prio) {
-				backup_available =3D 1;
-				continue;
-			}
+		if (tcp_packets_in_flight(tp_it) < tp_it->snd_cwnd)
 			return true;
-		}
 	}
 =

-	/* Backup-flow is available for sending - update send-buffer */
-	if (meta_tp->mpcb->cnt_established =3D=3D cnt_backups && backup_available)
-		return true;
 	return false;
 }
 =

-- =

2.16.2


--===============8854325393980472627==--
