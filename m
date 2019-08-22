Content-Type: multipart/mixed; boundary="===============2860052731973133477=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 8/8] mptcp: implement and use MPTCP-level
 retransmission
Date: Thu, 22 Aug 2019 15:47:45 +0200
Message-ID: <b98c2da44e68a642bc4500297e48ea636cd9fd54.1566481012.git.pabeni@redhat.com>
In-Reply-To: cover.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1674

--===============2860052731973133477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On timeout event, schedule a work queue to do the retransmission.
Retransmission code resemple closely sendmsg() implementation and
re-uses mptcp_sendmsg_frag, providing a dummy msghdr - for flags'
sake - and peeking the relevant dfrag from the rtx head.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v1 -> rfc v2:
- rtx_queue_head is now static inline (fix link issue)
- cancel on mptcp_clear_xmit
- (hopefully) fix msk refcnt
---
 net/mptcp/protocol.c | 73 ++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h | 11 +++++++
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b628ab326883..481983addcf5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -761,10 +761,12 @@ static void mptcp_retransmit_handler(struct sock *sk)
 =

 	mptcp_update_msk_una(sk);
 =

-	if (msk->snd_una =3D=3D msk->write_seq)
+	if (msk->snd_una =3D=3D msk->write_seq) {
 		mptcp_stop_timer(sk);
-	else
-		mptcp_reset_timer(sk, msk->sk.icsk_timeout);
+	} else {
+		if (schedule_work(&msk->rtx_work))
+			sock_hold(sk);
+	}
 }
 =

 static void mptcp_retransmit_timer(struct timer_list *t)
@@ -785,6 +787,66 @@ static void mptcp_retransmit_timer(struct timer_list *=
t)
 	bh_unlock_sock(sk);
 }
 =

+static void mptcp_retransmit(struct work_struct *work)
+{
+	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, rtx_work=
);
+	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
+	int orig_len, orig_offset, orig_write_seq;
+	int ret, mss_now =3D 0, size_goal =3D 0;
+	struct inet_connection_sock *icsk;
+	struct mptcp_data_frag *dfrag;
+	size_t copied =3D 0;
+	struct msghdr msg;
+	long timeo =3D 0;
+
+	lock_sock(sk);
+	ssk =3D mptcp_subflow_get_ref(msk);
+	if (!ssk) {
+		release_sock(sk);
+		goto put_out;
+	}
+
+	lock_sock(ssk);
+
+	mptcp_update_subflow_una(sk, ssk);
+	dfrag =3D mptcp_rtx_head(sk);
+	if (!dfrag)
+		goto unlock;
+
+	msg.msg_flags =3D MSG_DONTWAIT;
+	orig_len =3D dfrag->data_len;
+	orig_offset =3D dfrag->offset;
+	orig_write_seq =3D dfrag->data_seq;
+	while (dfrag->data_len > 0) {
+		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo, &mss_now,
+				   &size_goal);
+		if (ret < 0)
+			break;
+
+		copied +=3D ret;
+		dfrag->data_len -=3D ret;
+	}
+	if (copied)
+		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
+			 size_goal);
+
+	dfrag->data_seq =3D orig_write_seq;
+	dfrag->offset =3D orig_offset;
+	dfrag->data_len =3D orig_len;
+
+unlock:
+	release_sock(ssk);
+	release_sock(sk);
+	sock_put(ssk);
+put_out:
+	/* start the timer, if it's not pending */
+	icsk =3D inet_csk(sk);
+	if (!icsk->icsk_timeout)
+		mptcp_reset_timer(sk, mptcp_timeout(sk, ssk));
+
+	sock_put(sk);
+}
+
 static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -794,6 +856,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

+	INIT_WORK(&msk->rtx_work, mptcp_retransmit);
+
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 =

@@ -825,6 +889,9 @@ static void __mptcp_clear_xmit(struct sock *sk)
 		sk_mem_uncharge(sk, dfrag->data_len + dfrag->overhead);
 		put_page(dfrag->page);
 	}
+
+	if (cancel_work_sync(&msk->rtx_work))
+		sock_put(sk);
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4d1b4d1e2a3c..4457c281fc75 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -129,6 +129,7 @@ struct mptcp_sock {
 	unsigned long	snd_una_tstamp;
 	u32		token;
 	u16		dport;
+	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
@@ -154,6 +155,16 @@ static inline struct mptcp_data_frag *mptcp_rtx_tail(c=
onst struct sock *sk)
 	return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 =

+static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (list_empty(&msk->rtx_queue))
+		return NULL;
+
+	return list_first_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
+}
+
 struct subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u8	mp_capable : 1,
-- =

2.21.0


--===============2860052731973133477==--
