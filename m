Content-Type: multipart/mixed; boundary="===============3676608379901386744=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Wed, 26 Jun 2019 16:11:44 -0700
Message-ID: <20190626231144.30117-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1450

--===============3676608379901386744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP-level socket doesn't use sk_receive_queue, so it was possible
for mptcp_recvmsg() to remain blocked when there was data ready for it
to read. When the MPTCP socket is waiting for additional data and it
releases the subflow socket lock, the subflow may have incoming packets
ready to process and it sometimes called subflow_data_ready() before the
MPTCP socket called sk_wait_data().

This change adds new functions for the MPTCP socket to use to wait and
to signal that data is ready. Atomic bitops are used to set, test, and
clear a MPTCP socket flag that indicates waiting subflow data. This flag
replaces the sk_receive_queue checks used by other socket types.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---

Squashing this into "mptcp: Implement MPTCP receive path" has a few
conflicts with later commits that also fix up the receive code. It's
fine to add this to the end of the commit chain.

 net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  4 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 774ed25d3b6d..5555ee1529bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -357,6 +357,26 @@ static enum mapping_status mptcp_get_mapping(struct so=
ck *ssk)
 	return ret;
 }
 =

+static void mptcp_wait_data(struct sock *sk, long *timeo)
+{
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+
+	release_sock(sk);
+
+	if (!test_and_clear_bit(MPTCP_DATA_READY, &msk->flags))
+		*timeo =3D wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
+
+	sched_annotate_sleep();
+	lock_sock(sk);
+
+	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+	remove_wait_queue(sk_sleep(sk), &wait);
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -403,6 +423,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 		u64 old_ack;
 		u32 ssn;
 =

+		clear_bit(MPTCP_DATA_READY, &msk->flags);
 		status =3D mptcp_get_mapping(ssk);
 =

 		if (status =3D=3D MAPPING_ADDED) {
@@ -536,7 +557,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 		pr_debug("block");
 		release_sock(ssk);
-		sk_wait_data(sk, &timeo, NULL);
+		mptcp_wait_data(sk, &timeo);
 		lock_sock(ssk);
 	}
 =

@@ -548,6 +569,22 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 	return copied;
 }
 =

+static void mptcp_data_ready(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket_wq *wq;
+
+	set_bit(MPTCP_DATA_READY, &msk->flags);
+
+	rcu_read_lock();
+	wq =3D rcu_dereference(sk->sk_wq);
+	if (skwq_has_sleeper(wq))
+		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
+						EPOLLRDNORM | EPOLLRDBAND);
+	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	rcu_read_unlock();
+}
+
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -555,6 +592,7 @@ static int mptcp_init_sock(struct sock *sk)
 	pr_debug("msk=3D%p", msk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
+	sk->sk_data_ready =3D mptcp_data_ready;
 =

 	return 0;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7f15f6aab93d..ca5e6d839575 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -71,6 +71,9 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+/* MPTCP socket flags */
+#define MPTCP_DATA_READY	BIT(0)
+
 static inline u32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
 	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
@@ -97,6 +100,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u32		token;
+	unsigned long	flags;
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct pm_data	pm;
-- =

2.22.0


--===============3676608379901386744==--
