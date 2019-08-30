Content-Type: multipart/mixed; boundary="===============6536226878958605514=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/7] mptcp: implement and use MPTCP-level
 retransmission
Date: Fri, 30 Aug 2019 17:04:02 +0200
Message-ID: <d32e7947c5f9e2abfcc780b9235b48e6e9f7b9d7.1567177394.git.pabeni@redhat.com>
In-Reply-To: cover.1567177393.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1778

--===============6536226878958605514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On timeout event, schedule a work queue to do the retransmission.
Retransmission code resemple closely sendmsg() implementation and
re-uses mptcp_sendmsg_frag, providing a dummy msghdr - for flags'
sake - and peeking the relevant dfrag from the rtx head.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v2 -> v1:
- really preserve dfrag seq across retransmission using u64 store instead o=
f int
- update timer management according to new schema
- fix issues in mptcp_retransmit() cleanup code
- do cleanup the rtx queue before starting the retransmission
- cancel the rtx work outside the socket lock (avoid deadlock)

rfc v1 -> rfc v2:
- rtx_queue_head is now static inline (fix link issue)
- cancel on mptcp_clear_xmit
- (hopefully) fix msk refcnt
---
 net/mptcp/protocol.c | 81 ++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h | 11 ++++++
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dd671c62cf3e..4ab72e6fd748 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -771,10 +771,12 @@ static void mptcp_retransmit_handler(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq)
+	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq) {
 		mptcp_stop_timer(sk);
-	else
-		mptcp_reset_timer(sk);
+	} else {
+		if (schedule_work(&msk->rtx_work))
+			sock_hold(sk);
+	}
 }
 =

 static void mptcp_retransmit_timer(struct timer_list *t)
@@ -796,6 +798,66 @@ static void mptcp_retransmit_timer(struct timer_list *=
t)
 	sock_put(sk);
 }
 =

+static void mptcp_retransmit(struct work_struct *work)
+{
+	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
+	struct mptcp_data_frag *dfrag;
+	struct sock *ssk, *sk;
+	struct mptcp_sock *msk;
+	u64 orig_write_seq;
+	size_t copied =3D 0;
+	struct msghdr msg;
+	long timeo =3D 0;
+
+	msk =3D container_of(work, struct mptcp_sock, rtx_work);
+	sk =3D &msk->sk.icsk_inet.sk;
+
+	lock_sock(sk);
+	mptcp_clean_una(sk);
+	dfrag =3D mptcp_rtx_head(sk);
+	if (!dfrag)
+		goto unlock;
+
+	ssk =3D mptcp_subflow_get_ref(msk);
+	if (!ssk)
+		goto reset_unlock;
+
+	lock_sock(ssk);
+
+	msg.msg_flags =3D MSG_DONTWAIT;
+	orig_len =3D dfrag->data_len;
+	orig_offset =3D dfrag->offset;
+	orig_write_seq =3D dfrag->data_seq;
+	while (dfrag->data_len > 0) {
+		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo, &mss_now,
+					 &size_goal);
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
+	release_sock(ssk);
+	sock_put(ssk);
+
+reset_unlock:
+	mptcp_set_timeout(sk, ssk);
+	if (!mptcp_timer_pending(sk))
+		mptcp_reset_timer(sk);
+
+unlock:
+	release_sock(sk);
+	sock_put(sk);
+}
+
 static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -805,6 +867,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

+	INIT_WORK(&msk->rtx_work, mptcp_retransmit);
+
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 =

@@ -837,6 +901,14 @@ static void __mptcp_clear_xmit(struct sock *sk)
 		dfrag_clear(sk, dfrag);
 }
 =

+static void mptcp_cancel_rtx_work(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (cancel_work_sync(&msk->rtx_work))
+		sock_put(sk);
+}
+
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -865,6 +937,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
 =

+	mptcp_cancel_rtx_work(sk);
+
 	sk_common_release(sk);
 }
 =

@@ -873,6 +947,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	lock_sock(sk);
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
+	mptcp_cancel_rtx_work(sk);
 	return tcp_disconnect(sk, flags);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a14fdc161813..b9d136b01165 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -133,6 +133,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
+	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
@@ -158,6 +159,16 @@ static inline struct mptcp_data_frag *mptcp_rtx_tail(c=
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


--===============6536226878958605514==--
