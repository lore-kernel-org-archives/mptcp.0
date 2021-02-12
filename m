Content-Type: multipart/mixed; boundary="===============8359292169279620490=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/8] mptcp: schedule worker when subflow is
 closed
Date: Fri, 12 Feb 2021 15:59:56 -0800
Message-ID: <20210213000001.379332-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210213000001.379332-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7786

--===============8359292169279620490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

When remote side closes a subflow we should schedule the worker to
dispose of the subflow in a timely manner.

Otherwise, SF_CLOSED event won't be generated until the mptcp
socket itself is closing or local side is closing another subflow.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/subflow.c  | 25 +++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3fd8aef979a3..267c5521692d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2170,6 +2170,10 @@ static void __mptcp_close_subflow(struct mptcp_sock =
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
index 280da418d60b..36b15726f851 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -953,6 +953,22 @@ static void mptcp_subflow_discard_data(struct sock *ss=
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
@@ -991,11 +1007,11 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
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
@@ -1029,6 +1045,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	}
 	return true;
 =

+no_data:
+	subflow_sched_work_if_closed(msk, ssk);
+	return false;
 fatal:
 	/* fatal protocol error, close the socket */
 	/* This barrier is coupled with smp_rmb() in tcp_poll() */
@@ -1413,6 +1432,8 @@ static void subflow_state_change(struct sock *sk)
 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 =

+	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
+
 	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
 		subflow->rx_eof =3D 1;
-- =

2.30.1

--===============8359292169279620490==--
