Content-Type: multipart/mixed; boundary="===============4963946611041430782=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PRE-RFC 5/6] mptcp: use retransmission timer to update msk
 una
Date: Fri, 16 Aug 2019 18:48:03 +0200
Message-ID: <445d83af96a27730d5cf2c515115ac565ea31cdc.1565970525.git.pabeni@redhat.com>
In-Reply-To: cover.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1650

--===============4963946611041430782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

plugging unacked sequence update into sendmsg() is not enough;
use the msk icsk retransmit timer to trigger una updates. The
timer freqeuncy is based on the current subflow RTO estimation.

The timer is clearer for good at destroy() time

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 116 ++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |   1 +
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dcfffb71b545..5eba4e65ca93 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -17,6 +17,33 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static unsigned long mptcp_timeout(const struct sock *sk,
+				   const struct sock *ssk)
+{
+	unsigned long tout =3D inet_csk(ssk)->icsk_pending ?
+			     inet_csk(ssk)->icsk_timeout - jiffies : 0;
+
+	if (!tout)
+		tout =3D inet_csk(sk)->icsk_timeout;
+	return tout ?: TCP_RTO_MIN;
+}
+
+static void mptcp_reset_timer(struct sock *sk, unsigned long tout)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
+	icsk->icsk_timeout =3D tout;
+}
+
+static void mptcp_stop_timer(struct sock *sk)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
+	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	icsk->icsk_timeout =3D 0;
+}
+
 static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -78,6 +105,7 @@ static inline bool mptcp_frag_can_collapse_to(const stru=
ct mptcp_sock *msk,
 static u64 mptcp_update_msk_una(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_data_frag *dtmp, *dfrag;
 	struct subflow_context *subflow;
 	u64 snd_una =3D msk->snd_una;
 =

@@ -87,7 +115,19 @@ static u64 mptcp_update_msk_una(struct sock *sk)
 		if (after64(subflow_snd_una, snd_una))
 			snd_una =3D subflow_snd_una;
 	}
-	msk->snd_una =3D snd_una;
+
+	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
+		if (dfrag->data_seq + dfrag->data_len > snd_una)
+			break;
+
+		list_del(&dfrag->list);
+		put_page(dfrag->page);
+	}
+
+	if (msk->snd_una !=3D snd_una) {
+		msk->snd_una =3D snd_una;
+		msk->snd_una_tstamp =3D jiffies;
+	}
 	return snd_una;
 }
 =

@@ -98,8 +138,15 @@ static void mptcp_update_subflow_una(struct sock *sk, s=
truct sock *ssk)
 	u64 snd_una =3D msk->snd_una;
 =

 	/* heuristic to avoid doing the expensive data ack update frequently */
-	if (snd_una + tcp_sk(sk)->snd_cwnd <=3D msk->write_seq)
+	if (snd_una + tcp_sk(sk)->snd_cwnd <=3D msk->write_seq) {
+		u64 old_snd_una =3D snd_una;
+
 		snd_una =3D mptcp_update_msk_una(sk);
+		if (snd_una =3D=3D msk->write_seq)
+			mptcp_stop_timer(sk);
+		else if (snd_una !=3D old_snd_una)
+			mptcp_reset_timer(sk, mptcp_timeout(sk, ssk));
+	}
 =

 	/* if we msk just switched to this subflow, update subflow's una
 	 * to allow 32 bit ack update to be more accurate
@@ -314,9 +361,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		copied +=3D ret;
 	}
 	if (copied) {
+		struct inet_connection_sock *icsk =3D inet_csk(sk);
+
 		ret =3D copied;
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
+
+		/* start the timer, if it's not pending */
+		if (!icsk->icsk_timeout)
+			mptcp_reset_timer(sk, mptcp_timeout(sk, ssk));
 	}
 =

 	release_sock(ssk);
@@ -667,6 +720,36 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 	return copied;
 }
 =

+static void mptcp_retransmit_handler(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	mptcp_update_msk_una(sk);
+
+	if (msk->snd_una =3D=3D msk->write_seq)
+		mptcp_stop_timer(sk);
+	else
+		mptcp_reset_timer(sk, msk->sk.icsk_timeout);
+}
+
+static void mptcp_retransmit_timer(struct timer_list *t)
+{
+	struct inet_connection_sock *icsk =3D from_timer(icsk, t,
+						       icsk_retransmit_timer);
+	struct sock *sk =3D &icsk->icsk_inet.sk;
+
+	bh_lock_sock(sk);
+	if (!sock_owned_by_user(sk)) {
+		mptcp_retransmit_handler(sk);
+	} else {
+		/* delegate our work to tcp_release_cb() */
+		if (!test_and_set_bit(TCP_WRITE_TIMER_DEFERRED,
+				      &sk->sk_tsq_flags))
+			sock_hold(sk);
+	}
+	bh_unlock_sock(sk);
+}
+
 static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -676,6 +759,9 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

+	/* re-use the csk retrans timer for MPTCP-level retrans */
+	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
+
 	return 0;
 }
 =

@@ -798,6 +884,8 @@ static void mptcp_destroy(struct sock *sk)
 =

 	token_destroy(msk->token);
 =

+	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		list_del(&dfrag->list);
 		put_page(dfrag->page);
@@ -858,6 +946,30 @@ static int mptcp_getsockopt(struct sock *sk, int level=
, int optname,
 	return 0;
 }
 =

+#define MPTCP_DEFERRED_ALL TCPF_WRITE_TIMER_DEFERRED
+
+/* this is very alike tcp_release_cb() but we must handle differently a
+ * different set of events
+ */
+void mptcp_release_cb(struct sock *sk)
+{
+	unsigned long flags, nflags;
+
+	do {
+		flags =3D sk->sk_tsq_flags;
+		if (!(flags & MPTCP_DEFERRED_ALL))
+			return;
+		nflags =3D flags & ~MPTCP_DEFERRED_ALL;
+	} while (cmpxchg(&sk->sk_tsq_flags, flags, nflags) !=3D flags);
+
+	sock_release_ownership(sk);
+
+	if (flags & TCPF_WRITE_TIMER_DEFERRED) {
+		mptcp_retransmit_handler(sk);
+		__sock_put(sk);
+	}
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 889974a4022c..0a6c7c39fc8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -125,6 +125,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u64		snd_una;
+	unsigned long	snd_una_tstamp;
 	u32		token;
 	u16		dport;
 	struct list_head conn_list;
-- =

2.20.1


--===============4963946611041430782==--
