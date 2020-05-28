Content-Type: multipart/mixed; boundary="===============4399487152214917032=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 1/4] mptcp: add __init annotation on setup functions
Date: Thu, 28 May 2020 20:01:51 +0200
Message-ID: <f206e20f09d35c24a9bc31a70cc9c1649ae5a1e1.1590688878.git.pabeni@redhat.com>
In-Reply-To: cover.1590688878.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4540

--===============4399487152214917032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the missing annotation in some setup-only
functions.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
v1 -> v2
 - move mptcp_token_init() into the next patch
 - added missing annotation for pm_netlink
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c |  2 +-
 net/mptcp/protocol.c   |  4 ++--
 net/mptcp/protocol.h   | 10 +++++-----
 net/mptcp/subflow.c    |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 977d9c8b1453..7de09fdd42a3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -234,7 +234,7 @@ void mptcp_pm_close(struct mptcp_sock *msk)
 		sock_put((struct sock *)msk);
 }
 =

-void mptcp_pm_init(void)
+void __init mptcp_pm_init(void)
 {
 	pm_wq =3D alloc_workqueue("pm_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
 	if (!pm_wq)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b78edf237ba0..c8820c4156e6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -851,7 +851,7 @@ static struct pernet_operations mptcp_pm_pernet_ops =3D=
 {
 	.size =3D sizeof(struct pm_nl_pernet),
 };
 =

-void mptcp_pm_nl_init(void)
+void __init mptcp_pm_nl_init(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
 		panic("Failed to register MPTCP PM pernet subsystem.\n");
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2c8b57e7942..775599ab14ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2045,7 +2045,7 @@ static struct inet_protosw mptcp_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-void mptcp_proto_init(void)
+void __init mptcp_proto_init(void)
 {
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 =

@@ -2107,7 +2107,7 @@ static struct inet_protosw mptcp_v6_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

-int mptcp_proto_v6_init(void)
+int __init mptcp_proto_v6_init(void)
 {
 	int err;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 809687d3f410..260a13b19b7c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -341,7 +341,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 =

 int mptcp_is_enabled(struct net *net);
 bool mptcp_subflow_data_available(struct sock *sk);
-void mptcp_subflow_init(void);
+void __init mptcp_subflow_init(void);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, int ifindex,
@@ -364,9 +364,9 @@ extern const struct inet_connection_sock_af_ops ipv4_sp=
ecific;
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 #endif
 =

-void mptcp_proto_init(void);
+void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int mptcp_proto_v6_init(void);
+int __init mptcp_proto_v6_init(void);
 #endif
 =

 struct sock *mptcp_sk_clone(const struct sock *sk,
@@ -403,7 +403,7 @@ static inline void mptcp_crypto_key_gen_sha(u64 *key, u=
32 *token, u64 *idsn)
 =

 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hma=
c);
 =

-void mptcp_pm_init(void);
+void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_close(struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
@@ -437,7 +437,7 @@ bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsig=
ned int remaining,
 			  struct mptcp_addr_info *saddr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

-void mptcp_pm_nl_init(void);
+void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f3c06b8af92d..2638ff97097f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1243,7 +1243,7 @@ static int subflow_ops_init(struct request_sock_ops *=
subflow_ops)
 	return 0;
 }
 =

-void mptcp_subflow_init(void)
+void __init mptcp_subflow_init(void)
 {
 	subflow_request_sock_ops =3D tcp_request_sock_ops;
 	if (subflow_ops_init(&subflow_request_sock_ops) !=3D 0)
-- =

2.21.3

--===============4399487152214917032==--
