Content-Type: multipart/mixed; boundary="===============0472829064089633845=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v7 05/11] tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Thu, 09 Jan 2020 07:59:18 -0800
Message-ID: <20200109155924.30122-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200109155924.30122-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3319

--===============0472829064089633845==
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

v6 -> v7:
 - move and rename ulp clone helper to make it inline-friendly
v5 -> v6:
 - clarified MPTCP clone usage in commit message

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h               |  3 +++
 net/ipv4/inet_connection_sock.c | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 85f1d7ff6e8b..ac52633e7061 100644
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
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 18c0d5bffe12..6a691fd04398 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -770,6 +770,18 @@ void inet_csk_reqsk_queue_hash_add(struct sock *sk, st=
ruct request_sock *req,
 }
 EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
 =

+static void inet_clone_ulp(const struct request_sock *req, struct sock *ne=
wsk,
+			   const gfp_t priority)
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
 /**
  *	inet_csk_clone_lock - clone an inet socket, and lock its clone
  *	@sk: the socket to clone
@@ -810,6 +822,8 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 		/* Deinitialize accept_queue to trap illegal accesses. */
 		memset(&newicsk->icsk_accept_queue, 0, sizeof(newicsk->icsk_accept_queue=
));
 =

+		inet_clone_ulp(req, newsk, priority);
+
 		security_inet_csk_clone(newsk, req);
 	}
 	return newsk;
-- =

2.24.1

--===============0472829064089633845==--
