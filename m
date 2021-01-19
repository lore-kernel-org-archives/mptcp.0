Content-Type: multipart/mixed; boundary="===============3607923608698826695=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next] Squash-to: "mptcp: implement delegated
 actions"
Date: Tue, 19 Jan 2021 16:54:35 +0100
Message-ID: <677811d751738e2a4329a6b15e78a5a76598c489.1611071647.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7425

--===============3607923608698826695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Many issues in the reference patch:

- mptcp_subflow_has_delegated_action() tested the wrong condition,
fix it - things did not break hard too much, because usually
mptcp_napi_poll() kicked in and processed the pending action
without any sanity check

- subflow->delegated_node/mptcp_delegated_action->head is
touched/modified by the subflow release callback, which is
helding the local BH, but can run on a CPU other then the
one that originally scheduled the delegated action. That
would cause list corruption. Clarify the locking schema in
the header file and touch the node only in mptcp_napi_poll()
/mptcp_subflow_delegated_next(), which is always running on
the relevant CPU.

As a consequence we must check mptcp_subflow_has_delegated_action()
in mptcp_napi_poll(), too (release_cb could have already served the
action, but the subflow would still be enqueued)

- when delegating the action we need to acquire an extra reference
to the delegated subflow, otherwise such socket could be disposed
in-between the scheduling and the mptcp_napi_poll() call itself.
(actually I'm not 130% sure that could really happen due to the
non trivial chain of references between the ssk, the msk the other ssk,
but better safe than sorry).

- we can drop an unneeded local bh disable/enable pair, since
mptcp_subflow_delegate() is always called from bh. Add a suitable
lockdep annotation istead.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - fix double add issue in mptcp_subflow_delegate()
 - add possibly pedantinc barriers (better safe than sorry style)
---
 net/mptcp/protocol.c | 11 +++++++----
 net/mptcp/protocol.h | 29 ++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5dbeae3ad666e..f4776f9096ed1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3415,13 +3415,16 @@ static int mptcp_napi_poll(struct napi_struct *napi=
, int budget)
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 		bh_lock_sock_nested(ssk);
-		if (!sock_owned_by_user(ssk))
+		if (!sock_owned_by_user(ssk) &&
+		    mptcp_subflow_has_delegated_action(subflow))
 			mptcp_subflow_process_delegated(ssk);
-
-		/* if the sock is locked the delegated status will be cleared
-		 * by tcp_release_cb_override
+		/* ... elsewhere tcp_release_cb_override already processed
+		 * the action or will do at next release_sock().
+		 * In both case must dequeue the subflow here - on the same
+		 * CPU that scheduled it.
 		 */
 		bh_unlock_sock(ssk);
+		sock_put(ssk);
 =

 		if (++work_done =3D=3D budget)
 			return budget;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0d321dcaeb43..1d6076f1c5380 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -381,6 +381,8 @@ struct mptcp_delegated_action {
 =

 DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 =

+#define MPTCP_DELEGATE_SEND		0
+
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -419,7 +421,7 @@ struct mptcp_subflow_context {
 	u8	remote_id;
 =

 	long	delegated_status;
-	struct	list_head delegated_node;
+	struct	list_head delegated_node;   /* link into delegated_action, protect=
ed by local BH */
 =

 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
@@ -476,14 +478,24 @@ static inline void mptcp_subflow_delegate(struct mptc=
p_subflow_context *subflow)
 	struct mptcp_delegated_action *delegated;
 	bool schedule;
 =

-	if (!test_and_set_bit(1, &subflow->delegated_status)) {
-		local_bh_disable();
+	/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
+	 * ensures the below list check sees list updates done prior to status
+	 * bit changes
+	 */
+	if (!test_and_set_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
+		/* still on delegated list from previous scheduling */
+		if (!list_empty(&subflow->delegated_node))
+			return;
+
+		/* the caller held the subflow bh socket lock */
+		lockdep_assert_in_softirq();
+
 		delegated =3D this_cpu_ptr(&mptcp_delegated_actions);
 		schedule =3D list_empty(&delegated->head);
 		list_add_tail(&subflow->delegated_node, &delegated->head);
+		sock_hold(mptcp_subflow_tcp_sock(subflow));
 		if (schedule)
 			napi_schedule(&delegated->napi);
-		local_bh_enable();
 	}
 }
 =

@@ -502,13 +514,16 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_a=
ction *delegated)
 =

 static inline bool mptcp_subflow_has_delegated_action(const struct mptcp_s=
ubflow_context *subflow)
 {
-	return !test_bit(1, &subflow->delegated_status);
+	return test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
 }
 =

 static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_conte=
xt *subflow)
 {
-	clear_bit(1, &subflow->delegated_status);
-	list_del_init(&subflow->delegated_node);
+	/* pairs with mptcp_subflow_delegate, ensures delegate_node is updated be=
fore
+	 * touching the status bit
+	 */
+	smp_wmb();
+	clear_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
 }
 =

 int mptcp_is_enabled(struct net *net);
-- =

2.26.2

--===============3607923608698826695==--
