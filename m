Content-Type: multipart/mixed; boundary="===============3210534358506009683=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v4 05/11] tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Thu, 19 Dec 2019 14:05:51 -0800
Message-ID: <20191219220557.17823-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191219220557.17823-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3190

--===============3210534358506009683==
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

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h               |  5 +++++
 net/ipv4/inet_connection_sock.c |  2 ++
 net/ipv4/tcp_ulp.c              | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d4b6bf2c5d3c..c82b2f75d024 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2145,6 +2145,9 @@ struct tcp_ulp_ops {
 	/* diagnostic */
 	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
+	/* clone ulp */
+	void (*clone)(const struct request_sock *req, struct sock *newsk,
+		      const gfp_t priority);
 =

 	char		name[TCP_ULP_NAME_MAX];
 	struct module	*owner;
@@ -2155,6 +2158,8 @@ int tcp_set_ulp(struct sock *sk, const char *name);
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
index e4c6e8b40490..d667f2569f8e 100644
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

--===============3210534358506009683==--
