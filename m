Content-Type: multipart/mixed; boundary="===============1981498660879719178=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v6 05/11] tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Tue, 07 Jan 2020 17:19:15 -0800
Message-ID: <20200108011921.28942-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200108011921.28942-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3276

--===============1981498660879719178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If ULP is used on a listening socket, icsk_ulp_ops and icsk_ulp_data are
copied when the listener is cloned. Sometimes the clone is immediately
deleted, which will invoke the release op on the clone and likely
corrupt the listening socket's icsk_ulp_data.

The clone operation is invoked immediately after the clone is copied and
gives the ULP type an opportunity to set up the clone socket and its
icsk_ulp_data.

The MPTCP ULP clone will silently fallback to plain TCP on allocation
failure, so 'clone()' does not need to return an error code.

v5 -> v6:
 - clarified MPTCP clone usage in commit message

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h               |  5 +++++
 net/ipv4/inet_connection_sock.c |  2 ++
 net/ipv4/tcp_ulp.c              | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 85f1d7ff6e8b..82879718d35a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2154,6 +2154,9 @@ struct tcp_ulp_ops {
 	/* diagnostic */
 	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
+	/* clone ulp */
+	void (*clone)(const struct request_sock *req, struct sock *newsk,
+		      const gfp_t priority);
 =

 	char		name[TCP_ULP_NAME_MAX];
 	struct module	*owner;
@@ -2164,6 +2167,8 @@ int tcp_set_ulp(struct sock *sk, const char *name);
 void tcp_get_available_ulp(char *buf, size_t len);
 void tcp_cleanup_ulp(struct sock *sk);
 void tcp_update_ulp(struct sock *sk, struct proto *p);
+void tcp_clone_ulp(const struct request_sock *req,
+		   struct sock *newsk, const gfp_t priority);
 =

 #define MODULE_ALIAS_TCP_ULP(name)				\
 	__MODULE_INFO(alias, alias_userspace, name);		\
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 18c0d5bffe12..bf53a722923a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -810,6 +810,8 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 		/* Deinitialize accept_queue to trap illegal accesses. */
 		memset(&newicsk->icsk_accept_queue, 0, sizeof(newicsk->icsk_accept_queue=
));
 =

+		tcp_clone_ulp(req, newsk, priority);
+
 		security_inet_csk_clone(newsk, req);
 	}
 	return newsk;
diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
index 12ab5db2b71c..e7a2589d69ee 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -130,6 +130,18 @@ void tcp_cleanup_ulp(struct sock *sk)
 	icsk->icsk_ulp_ops =3D NULL;
 }
 =

+void tcp_clone_ulp(const struct request_sock *req, struct sock *newsk,
+		   const gfp_t priority)
+{
+	struct inet_connection_sock *icsk =3D inet_csk(newsk);
+
+	if (!icsk->icsk_ulp_ops)
+		return;
+
+	if (icsk->icsk_ulp_ops->clone)
+		icsk->icsk_ulp_ops->clone(req, newsk, priority);
+}
+
 static int __tcp_set_ulp(struct sock *sk, const struct tcp_ulp_ops *ulp_op=
s)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
-- =

2.24.1

--===============1981498660879719178==--
