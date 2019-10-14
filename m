Content-Type: multipart/mixed; boundary="===============4022394292478277995=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 6/6] mptcp: pick best-suited subflow for transmit
Date: Tue, 15 Oct 2019 01:19:19 +0200
Message-ID: <20191014231919.2454-7-fw@strlen.de>
In-Reply-To: 20191014231919.2454-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2128

--===============4022394292478277995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because we only have one subflow active at the moment, the major
change isn't how the ssk is chosen but what happens when no subflow is
available (e.g. when only active subflow has its wmem maxed out).

If this happens we need to either signal -EAGAIN to userspace (nonblock
case), or we need to wait until a subflow becomes available.

This is done by blocking the current thread via sk_stream_wait_memory()
and then make the subflow sk_write_space() unblock the parent mptcp socket.

We can't acquire the mptcp socket lock from the subflow callbacks, but
we can use the mptcp->flags to for signalling.

Before this change, we always picked the first ssk on the list and then
had do_tcp_sendpages wait until more space became available.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 114 ++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |   1 +
 net/mptcp/subflow.c  |   7 ++-
 3 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e003608af237..89c49efa8fdd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -92,6 +92,83 @@ static struct sock *mptcp_subflow_get(const struct mptcp=
_sock *msk)
 	return NULL;
 }
 =

+/* returns < 0 if a should be preferred to b */
+static int sock_compare(const struct sock *a, const struct sock *b)
+{
+	int cmp =3D inet_csk(a)->icsk_ca_state - inet_csk(b)->icsk_ca_state;
+
+	if (cmp)
+		return cmp;
+
+	cmp =3D tcp_is_cwnd_limited(a) - tcp_is_cwnd_limited(b);
+	if (cmp)
+		return cmp;
+
+	cmp =3D skb_queue_len(&a->sk_write_queue) -
+	      skb_queue_len(&b->sk_write_queue);
+	if (cmp)
+		return cmp;
+
+	cmp =3D tcp_packets_in_flight(tcp_sk(a)) - tcp_packets_in_flight(tcp_sk(b=
));
+	if (cmp)
+		return cmp;
+
+	return 0;
+}
+
+static struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	bool non_backup_present =3D false;
+	struct sock *best, *backup;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	backup =3D NULL;
+	best =3D NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
+
+		if (!sk_stream_is_writeable(ssk)) {
+			struct socket *sock =3D ssk->sk_socket;
+
+			if (sock)
+				set_bit(SOCK_NOSPACE, &sock->flags);
+
+			if (!subflow->backup)
+				non_backup_present =3D true;
+
+			continue;
+		}
+
+		if (subflow->backup) {
+			if (!backup)
+				backup =3D ssk;
+
+			continue;
+		}
+
+		if (tcp_sk(ssk)->inet_conn.icsk_ca_state =3D=3D TCP_CA_Open) {
+			/* Not backup and empty write queue -> use it */
+			if (tcp_write_queue_empty(ssk))
+				return ssk;
+		}
+
+		if (!best || sock_compare(ssk, best) < 0)
+			best =3D ssk;
+	}
+
+	if (best)
+		return best;
+
+	/* prefer to wait unless no non-backup sockets exist. */
+	if (!non_backup_present)
+		return backup;
+
+	return NULL;
+}
+
 static inline bool mptcp_skb_can_collapse_to(u64 write_seq,
 					     const struct sk_buff *skb,
 					     const struct mptcp_ext *mpext)
@@ -343,23 +420,36 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		return ret;
 	}
 =

-	ssk =3D mptcp_subflow_get(msk);
-	if (!ssk) {
-		release_sock(sk);
-		return -ENOTCONN;
-	}
-
-	if (!msg_data_left(msg)) {
+	if (unlikely(!msg_data_left(msg))) {
+		ssk =3D mptcp_subflow_get(msk);
 		pr_debug("empty send");
 		ret =3D sock_sendmsg(ssk->sk_socket, msg);
 		goto out;
 	}
 =

+	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+	smp_mb__before_atomic();
+	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
+	smp_mb__after_atomic();
+
+	ssk =3D mptcp_subflow_get_send(msk);
+	while (!ssk) {
+		ret =3D sk_stream_wait_memory(sk, &timeo);
+		if (ret)
+			goto out;
+
+		ssk =3D mptcp_subflow_get_send(msk);
+		if (list_empty(&msk->conn_list)) {
+			ret =3D -ENOTCONN;
+			goto out;
+		}
+	}
+
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
 	mptcp_clean_una(sk);
-	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
@@ -1220,6 +1310,13 @@ bool mptcp_sk_is_subflow(const struct sock *sk)
 	return subflow->mp_join =3D=3D 1;
 }
 =

+static bool mptcp_memory_free(const struct sock *sk, int wake)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	return test_bit(MPTCP_SEND_SPACE, &msk->flags);
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
@@ -1240,6 +1337,7 @@ static struct proto mptcp_prot =3D {
 	.sockets_allocated	=3D &mptcp_sockets_allocated,
 	.memory_allocated	=3D &tcp_memory_allocated,
 	.memory_pressure	=3D &tcp_memory_pressure,
+	.stream_memory_free	=3D mptcp_memory_free,
 	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
 	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 73f79d82f76e..c9a772773a42 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -76,6 +76,7 @@
 =

 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
+#define MPTCP_SEND_SPACE	BIT(1)
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c3429f8eca6e..a7832f86d301 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -335,8 +335,13 @@ static void subflow_write_space(struct sock *sk)
 	struct sock *parent =3D subflow->conn;
 =

 	sk_stream_write_space(sk);
-	if (parent)
+	if (parent) {
+		smp_mb__before_atomic();
+		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
+
 		sk_stream_write_space(parent);
+	}
 }
 =

 int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
-- =

2.21.0

--===============4022394292478277995==--
