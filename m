Content-Type: multipart/mixed; boundary="===============8573560928357397343=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] [DO-NOT-MERGE] mptcp: use kmalloc on kasan build
Date: Thu, 04 Jun 2020 19:40:06 +0200
Message-ID: <b51e3be17fb22306fe1c33dfa03cf635d0515813.1591291903.git.pabeni@redhat.com>
In-Reply-To: cover.1591291903.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4591

--===============8573560928357397343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Helps detection UaF, which apparently kasan misses
with kmem_cache allocator.

We also need to always set the SOCK_RCU_FREE flag, to
preserved the current code leveraging SLAB_TYPESAFE_BY_RCU.
This latter change will make unreachable some existing
errors path, but I don't see other options.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/ipv4/af_inet.c   |  3 +++
 net/mptcp/protocol.c | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90e87727fde3..5ce1314a1916 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1262,6 +1262,9 @@ static int __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 =

+#if IS_ENABLED(CONFIG_KASAN)
+	sock_set_flag(sk, SOCK_RCU_FREE);
+#endif
 	return 0;
 }
 =

@@ -1455,7 +1458,9 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		msk->ack_seq =3D ack_seq;
 	}
 =

+#if !IS_ENABLED(CONFIG_KASAN)
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
+#endif
 	/* will be fully established after successful MPC subflow creation */
 	inet_sk_state_store(nsk, TCP_SYN_RECV);
 	bh_unlock_sock(nsk);
@@ -2076,6 +2081,12 @@ static struct inet_protosw mptcp_protosw =3D {
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
@@ -2087,7 +2098,7 @@ void __init mptcp_proto_init(void)
 	mptcp_pm_init();
 	mptcp_token_init();
 =

-	if (proto_register(&mptcp_prot, 1) !=3D 0)
+	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
 =

 	inet_register_protosw(&mptcp_protosw);
@@ -2149,7 +2160,7 @@ int __init mptcp_proto_v6_init(void)
 	mptcp_v6_prot.destroy =3D mptcp_v6_destroy;
 	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp6_sock);
 =

-	err =3D proto_register(&mptcp_v6_prot, 1);
+	err =3D proto_register(&mptcp_v6_prot, MPTCP_USE_SLAB);
 	if (err)
 		return err;
 =

-- =

2.21.3

--===============8573560928357397343==--
