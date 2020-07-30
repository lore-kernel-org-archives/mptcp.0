Content-Type: multipart/mixed; boundary="===============3236317915410569653=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 07/10] tcp: syncookies: create mptcp request
 socket for ACK cookies with MPTCP option
Date: Thu, 30 Jul 2020 02:12:38 +0200
Message-ID: <20200730001241.3037-8-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5379

--===============3236317915410569653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If SYN packet contains MP_CAPABLE option, keep it enabled.
Syncokie validation and cookie-based socket creation is changed to
instantiate an mptcp request sockets if the ACK contains an MPTCP
connection request.

Rather than extend both cookie_v4/6_check, add a common helper to create
the (mp)tcp request socket.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/tcp.h     |  2 ++
 net/ipv4/syncookies.c | 38 ++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp_input.c  |  3 ---
 net/ipv6/syncookies.c |  5 +----
 4 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 84d524d92d12..4dcd4dd8e075 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -469,6 +469,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struc=
t sk_buff *skb,
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th,
 		      u32 cookie);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
+struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops =
*ops,
+					    struct sock *sk, struct sk_buff *skb);
 #ifdef CONFIG_SYN_COOKIES
 =

 /* Syncookies use a monotonic timer which increments every 60 seconds.
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 9a4f6b16c9bc..54838ee2e8d4 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -276,6 +276,39 @@ bool cookie_ecn_ok(const struct tcp_options_received *=
tcp_opt,
 }
 EXPORT_SYMBOL(cookie_ecn_ok);
 =

+struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops =
*ops,
+					    struct sock *sk,
+					    struct sk_buff *skb)
+{
+	struct tcp_request_sock *treq;
+	struct request_sock *req;
+
+#ifdef CONFIG_MPTCP
+	if (sk_is_mptcp(sk))
+		ops =3D &mptcp_subflow_request_sock_ops;
+#endif
+
+	req =3D inet_reqsk_alloc(ops, sk, false);
+	if (!req)
+		return NULL;
+
+#if IS_ENABLED(CONFIG_MPTCP)
+	treq =3D tcp_rsk(req);
+	treq->is_mptcp =3D sk_is_mptcp(sk);
+	if (treq->is_mptcp) {
+		int err =3D mptcp_subflow_init_cookie_req(req, sk, skb);
+
+		if (err) {
+			reqsk_free(req);
+			return NULL;
+		}
+	}
+#endif
+
+	return req;
+}
+EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
+
 /* On input, sk is a listener.
  * Output is listener if incoming packet would not create a child
  *           NULL if memory could not be allocated.
@@ -326,7 +359,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 		goto out;
 =

 	ret =3D NULL;
-	req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for safety=
 */
+	req =3D cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb);
 	if (!req)
 		goto out;
 =

@@ -350,9 +383,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 	treq->snt_synack	=3D 0;
 	treq->tfo_listener	=3D false;
 =

-	if (IS_ENABLED(CONFIG_MPTCP))
-		treq->is_mptcp =3D 0;
-
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok =3D 0;
 =

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7dd9280325d..4382a3fc173b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6700,9 +6700,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 =

 	af_ops->init_req(req, sk, skb, want_cookie);
 =

-	if (IS_ENABLED(CONFIG_MPTCP) && want_cookie)
-		tcp_rsk(req)->is_mptcp =3D 0;
-
 	if (security_inet_conn_request(sk, skb, req))
 		goto drop_and_free;
 =

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 13235a012388..e796a64be308 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -170,7 +170,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk=
_buff *skb)
 		goto out;
 =

 	ret =3D NULL;
-	req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);
+	req =3D cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb);
 	if (!req)
 		goto out;
 =

@@ -178,9 +178,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk=
_buff *skb)
 	treq =3D tcp_rsk(req);
 	treq->tfo_listener =3D false;
 =

-	if (IS_ENABLED(CONFIG_MPTCP))
-		treq->is_mptcp =3D 0;
-
 	if (security_inet_conn_request(sk, skb, req))
 		goto out_free;
 =

-- =

2.26.2

--===============3236317915410569653==--
