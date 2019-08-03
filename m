Content-Type: multipart/mixed; boundary="===============5124357958174889364=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Fri, 02 Aug 2019 17:16:37 -0700
Message-ID: <20190803001637.25724-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1582

--===============5124357958174889364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP-level socket doesn't use sk_receive_queue, so it was possible
for mptcp_recvmsg() to remain blocked when there was data ready for it
to read. When the MPTCP socket is waiting for additional data and it
releases the subflow socket lock, the subflow may have incoming packets
ready to process and it sometimes called subflow_data_ready() before the
MPTCP socket called sk_wait_data().

This change adds a new function for the MPTCP socket to use when waiting
for a data ready signal. Atomic bitops with memory barriers are used to
set, test, and clear a MPTCP socket flag that indicates waiting subflow
data. This flag replaces the sk_receive_queue checks used by other
socket types.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---

v2: Use existing sock_def_readable instead of creating a new function,
    and add barriers around atomic ops.


 net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/subflow.c  |  5 +++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4d2844bff36f..18ba430e8009 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -384,6 +384,31 @@ static enum mapping_status mptcp_get_mapping(struct so=
ck *ssk)
 	return ret;
 }
 =

+static void mptcp_wait_data(struct sock *sk, long *timeo)
+{
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	int data_ready;
+
+	add_wait_queue(sk_sleep(sk), &wait);
+	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+
+	release_sock(sk);
+
+	smp_mb__before_atomic();
+	data_ready =3D test_and_clear_bit(MPTCP_DATA_READY, &msk->flags);
+	smp_mb__after_atomic();
+
+	if (!data_ready)
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
@@ -434,6 +459,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		u64 old_ack;
 		u32 ssn;
 =

+		smp_mb__before_atomic();
+		clear_bit(MPTCP_DATA_READY, &msk->flags);
+		smp_mb__after_atomic();
+
 		status =3D mptcp_get_mapping(ssk);
 =

 		if (status =3D=3D MAPPING_ADDED) {
@@ -567,7 +596,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 		pr_debug("block");
 		release_sock(ssk);
-		sk_wait_data(sk, &timeo, NULL);
+		mptcp_wait_data(sk, &timeo);
 		lock_sock(ssk);
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4c098acf4170..7a515d8e99d0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -72,6 +72,9 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+/* MPTCP socket flags */
+#define MPTCP_DATA_READY	BIT(0)
+
 static inline u32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
 	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
@@ -98,6 +101,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u32		token;
+	unsigned long	flags;
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct pm_data	pm;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d91d817b8779..81c5cfae933a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -191,6 +191,11 @@ static void subflow_data_ready(struct sock *sk)
 =

 	if (parent) {
 		pr_debug("parent=3D%p", parent);
+
+		smp_mb__before_atomic();
+		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
+
 		parent->sk_data_ready(parent);
 	}
 }
-- =

2.22.0


--===============5124357958174889364==--
