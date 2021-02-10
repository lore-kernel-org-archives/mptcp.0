Content-Type: multipart/mixed; boundary="===============8437489536146653684=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squashto: mptcp: schedule worker when subflow is
 closed
Date: Wed, 10 Feb 2021 13:47:08 +0100
Message-ID: <20210210124708.11899-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7747

--===============8437489536146653684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When remote side closes a subflow we should schedule the worker to
dispose of the subflow in a timely manner.

Otherwise, SF_CLOSED event won't be generated until the mptcp
socket itself is closing or local side is closing another subflow.

As noted by Paolo and Matthieu, a subflow that moves to TCP_CLOSE state
might still have data in its rx queue.

Add a helper to only schedule the work queue once the subflow is empty.

For subflows that still have data, we can do same schedule check
in subflow_check_data_avail().

In case we have multiple subflows closing at the same time,
also make the work queue skip subflows that are TCP_CLOSE with
pending data.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/subflow.c  | 30 ++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 646f91e1c792..d49e0efbdd50 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2172,6 +2172,10 @@ static void __mptcp_close_subflow(struct mptcp_sock =
*msk)
 		if (inet_sk_state_load(ssk) !=3D TCP_CLOSE)
 			continue;
 =

+		/* 'subflow_data_ready' will re-sched once rx queue is empty */
+		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
+			continue;
+
 		mptcp_close_ssk((struct sock *)msk, ssk, subflow);
 	}
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 16c391ee8e0f..06e233410e0e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -945,6 +945,22 @@ static void mptcp_subflow_discard_data(struct sock *ss=
k, struct sk_buff *skb,
 		subflow->map_valid =3D 0;
 }
 =

+/* sched mptcp worker to remove the subflow if no more data is pending */
+static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct so=
ck *ssk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+
+	if (likely(ssk->sk_state !=3D TCP_CLOSE))
+		return;
+
+	if (skb_queue_empty(&ssk->sk_receive_queue) &&
+	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags)) {
+		sock_hold(sk);
+		if (!schedule_work(&msk->work))
+			sock_put(sk);
+	}
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
@@ -983,11 +999,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		}
 =

 		if (status !=3D MAPPING_OK)
-			return false;
+			goto no_data;
 =

 		skb =3D skb_peek(&ssk->sk_receive_queue);
 		if (WARN_ON_ONCE(!skb))
-			return false;
+			goto no_data;
 =

 		/* if msk lacks the remote key, this subflow must provide an
 		 * MP_CAPABLE-based mapping
@@ -1021,6 +1037,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	}
 	return true;
 =

+no_data:
+	subflow_sched_work_if_closed(msk, ssk);
+	return false;
 fatal:
 	/* fatal protocol error, close the socket */
 	/* This barrier is coupled with smp_rmb() in tcp_poll() */
@@ -1445,12 +1464,7 @@ static void subflow_state_change(struct sock *sk)
 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 =

-	if (sk->sk_state =3D=3D TCP_CLOSE &&
-	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(parent)->flags)=
) {
-		sock_hold(parent);
-		if (!schedule_work(&mptcp_sk(parent)->work))
-			sock_put(parent);
-	}
+	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
 =

 	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
-- =

2.26.2

--===============8437489536146653684==--
