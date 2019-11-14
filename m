Content-Type: multipart/mixed; boundary="===============6592602549476744824=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 09/14] mptcp: sendmsg: transmit on backup if other
 subflows have been closed
Date: Thu, 14 Nov 2019 18:32:20 +0100
Message-ID: <20191114173225.21199-10-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2537

--===============6592602549476744824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we always pick the first ssk on the list and then have
mptcp_sendmsg_frag wait until more space becomes available in case that
ssk has no write space available.

Instead check the first subflow on the list.  If no more write space
is available, then we need to either return -EAGAIN to userspace (nonblock
case), or we need to wait until a subflow becomes available.

This is done by blocking the current thread via sk_stream_wait_memory()
and then make the subflow sk_write_space() unblock the parent mptcp socket.

We can't acquire the mptcp socket lock from the subflow callbacks, but
we can use the mptcp_sk->flags -- MPTCP_SEND_SPACE flag is added for this
purpose.  If it gets set, then at least one subflow has become available for
writing.

v2: dumb-down the selection: just pick the first ssk on the list and make
mptcp socket block if it has no wspace.
Backup is only used if no non-backup subflow exists.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 69 +++++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  5 +++-
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c5cf19a4b9f0..6fb178067a4a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -384,6 +384,43 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	return ret;
 }
 =

+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *backup =3D NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
+
+		if (!sk_stream_memory_free(ssk)) {
+			struct socket *sock =3D ssk->sk_socket;
+
+			if (sock) {
+				clear_bit(MPTCP_SEND_SPACE, &msk->flags);
+				smp_mb__after_atomic();
+
+				/* enables sk->write_space() callbacks */
+				set_bit(SOCK_NOSPACE, &sock->flags);
+			}
+
+			return NULL;
+		}
+
+		if (subflow->backup) {
+			if (!backup)
+				backup =3D ssk;
+
+			continue;
+		}
+
+		return ssk;
+	}
+
+	return backup;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
@@ -418,18 +455,28 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		mptcp_clean_una(sk);
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

+	ssk =3D mptcp_subflow_get_send(msk);
+	while (!ssk) {
+		ret =3D sk_stream_wait_memory(sk, &timeo);
+		if (ret)
+			goto out;
+
+		mptcp_clean_una(sk);
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
@@ -1123,6 +1170,13 @@ bool mptcp_sk_is_subflow(const struct sock *sk)
 	return subflow->mp_join =3D=3D 1;
 }
 =

+static bool mptcp_memory_free(const struct sock *sk, int wake)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	return wake ? test_bit(MPTCP_SEND_SPACE, &msk->flags) : true;
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
@@ -1143,6 +1197,7 @@ static struct proto mptcp_prot =3D {
 	.sockets_allocated	=3D &mptcp_sockets_allocated,
 	.memory_allocated	=3D &tcp_memory_allocated,
 	.memory_pressure	=3D &tcp_memory_pressure,
+	.stream_memory_free	=3D mptcp_memory_free,
 	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
 	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6e23da8c5024..ce5c5de6a5eb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -77,6 +77,7 @@
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
 #define MPTCP_WORK_RTX		BIT(1)
+#define MPTCP_SEND_SPACE	BIT(2)
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 976e49349276..32082c6e8552 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -670,8 +670,11 @@ static void subflow_write_space(struct sock *sk)
 	struct sock *parent =3D subflow->conn;
 =

 	sk_stream_write_space(sk);
-	if (parent)
+	if (parent && sk_stream_is_writeable(sk)) {
+		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
 		sk_stream_write_space(parent);
+	}
 }
 =

 int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
-- =

2.23.0

--===============6592602549476744824==--
