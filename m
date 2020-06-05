Content-Type: multipart/mixed; boundary="===============8064169838584322250=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2] [DO-NOT-MERGE] mptcp: use kmalloc on
 kasan build
Date: Fri, 05 Jun 2020 19:32:42 +0200
Message-ID: <20200605173242.2644099-1-dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4598

--===============8064169838584322250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Helps detection UaF, which apparently kasan misses
with kmem_cache allocator.

We also need to always set the SOCK_RCU_FREE flag, to
preserved the current code leveraging SLAB_TYPESAFE_BY_RCU.
This latter change will make unreachable some existing
errors path, but I don't see other options.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/ipv4/af_inet.c   |  3 +++
 net/ipv6/af_inet6.c  |  3 +++
 net/mptcp/protocol.c | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 02aa5cb3a4fd..53da7a4683d3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -316,7 +316,10 @@ static int inet_create(struct net *net, struct socket =
*sock, int protocol,
 	answer_flags =3D answer->flags;
 	rcu_read_unlock();
 =

+#if !IS_ENABLED(CONFIG_KASAN)
+	/* with kasan we use kmalloc */
 	WARN_ON(!answer_prot->slab);
+#endif
 =

 	err =3D -ENOBUFS;
 	sk =3D sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index b304b882e031..14358a623e88 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -177,7 +177,10 @@ static int inet6_create(struct net *net, struct socket=
 *sock, int protocol,
 	answer_flags =3D answer->flags;
 	rcu_read_unlock();
 =

+#if !IS_ENABLED(CONFIG_KASAN)
 	WARN_ON(!answer_prot->slab);
+	/* with kasan we use kmalloc */
+#endif
 =

 	err =3D -ENOBUFS;
 	sk =3D sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99c019879833..1138caaae330 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1265,6 +1265,9 @@ static int __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 =

+#if IS_ENABLED(CONFIG_KASAN)
+	sock_set_flag(sk, SOCK_RCU_FREE);
+#endif
 	return 0;
 }
 =

@@ -1458,7 +1461,9 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		msk->ack_seq =3D ack_seq;
 	}
 =

+#if !IS_ENABLED(CONFIG_KASAN)
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
+#endif
 	/* will be fully established after successful MPC subflow creation */
 	inet_sk_state_store(nsk, TCP_SYN_RECV);
 	bh_unlock_sock(nsk);
@@ -2079,6 +2084,12 @@ static struct inet_protosw mptcp_protosw =3D {
 	.flags		=3D INET_PROTOSW_ICSK,
 };
 =

+#if IS_ENABLED(CONFIG_KASAN)
+#define MPTCP_USE_SLAB		0
+#else
+#define MPTCP_USE_SLAB		1
+#endif
+
 void __init mptcp_proto_init(void)
 {
 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
@@ -2090,7 +2101,7 @@ void __init mptcp_proto_init(void)
 	mptcp_pm_init();
 	mptcp_token_init();
 =

-	if (proto_register(&mptcp_prot, 1) !=3D 0)
+	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
 =

 	inet_register_protosw(&mptcp_protosw);
@@ -2152,7 +2163,7 @@ int __init mptcp_proto_v6_init(void)
 	mptcp_v6_prot.destroy =3D mptcp_v6_destroy;
 	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp6_sock);
 =

-	err =3D proto_register(&mptcp_v6_prot, 1);
+	err =3D proto_register(&mptcp_v6_prot, MPTCP_USE_SLAB);
 	if (err)
 		return err;
 =

-- =

2.18.1

--===============8064169838584322250==--
