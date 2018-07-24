Content-Type: multipart/mixed; boundary="===============0304364181455891338=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Disable MPTCP when interface is non-MPTCP
Date: Tue, 24 Jul 2018 16:49:40 -0700
Message-ID: <20180724234940.62909-3-cpaasch@apple.com>
In-Reply-To: 20180724234940.62909-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 685

--===============0304364181455891338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Franz Schleindlhuber found out that when MPTCP is disabled on an
interface with "ip link", the initiating subflow is still negotiating
MPTCP.

This patch changes this, by extending mptcp_doit() to check the
interface-flags as well.

Reported-by: Franz Schleindlhuber <Schleindlhuber(a)gmx.net>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit ccd0390729e370f43e1515b90fd6982faa00e724)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h    |  6 +++---
 net/mptcp/mptcp_ctrl.c | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8abb6985d852..2b5418d808bf 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -800,7 +800,7 @@ void mptcp_options_write(__be32 *ptr, struct tcp_sock *=
tp,
 			 const struct tcp_out_options *opts,
 			 struct sk_buff *skb);
 void mptcp_close(struct sock *meta_sk, long timeout);
-int mptcp_doit(struct sock *sk);
+bool mptcp_doit(struct sock *sk);
 int mptcp_create_master_sk(struct sock *meta_sk, __u64 remote_key,
 			   __u8 mptcp_ver, u32 window);
 int mptcp_check_req_fastopen(struct sock *child, struct request_sock *req);
@@ -1373,9 +1373,9 @@ static inline void mptcp_options_write(__be32 *ptr, s=
truct tcp_sock *tp,
 				       const struct tcp_out_options *opts,
 				       struct sk_buff *skb) {}
 static inline void mptcp_close(struct sock *meta_sk, long timeout) {}
-static inline int mptcp_doit(struct sock *sk)
+static inline bool mptcp_doit(struct sock *sk)
 {
-	return 0;
+	return false;
 }
 static inline int mptcp_check_req_fastopen(struct sock *child,
 					   struct request_sock *req)
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 7f7b4a0f2ee1..f5d46c688279 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1925,31 +1925,36 @@ void mptcp_disconnect(struct sock *sk)
 }
 =

 =

-/* Returns 1 if we should enable MPTCP for that socket. */
-int mptcp_doit(struct sock *sk)
+/* Returns True if we should enable MPTCP for that socket. */
+bool mptcp_doit(struct sock *sk)
 {
+	const struct dst_entry *dst =3D __sk_dst_get(sk);
+
 	/* Don't do mptcp over loopback */
 	if (sk->sk_family =3D=3D AF_INET &&
 	    (ipv4_is_loopback(inet_sk(sk)->inet_daddr) ||
 	     ipv4_is_loopback(inet_sk(sk)->inet_saddr)))
-		return 0;
+		return false;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family =3D=3D AF_INET6 &&
 	    (ipv6_addr_loopback(&sk->sk_v6_daddr) ||
 	     ipv6_addr_loopback(&inet6_sk(sk)->saddr)))
-		return 0;
+		return false;
 #endif
 	if (mptcp_v6_is_v4_mapped(sk) &&
 	    ipv4_is_loopback(inet_sk(sk)->inet_saddr))
-		return 0;
+		return false;
 =

 #ifdef CONFIG_TCP_MD5SIG
 	/* If TCP_MD5SIG is enabled, do not do MPTCP - there is no Option-Space */
 	if (tcp_sk(sk)->af_specific->md5_lookup(sk, sk))
-		return 0;
+		return false;
 #endif
 =

-	return 1;
+	if (dst->dev && (dst->dev->flags & IFF_NOMULTIPATH))
+		return false;
+
+	return true;
 }
 =

 int mptcp_create_master_sk(struct sock *meta_sk, __u64 remote_key,
-- =

2.16.2


--===============0304364181455891338==--
