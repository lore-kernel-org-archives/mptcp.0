Content-Type: multipart/mixed; boundary="===============3829666335857413920=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Use sk_family field in the mptcp_sock for
 address family.
Date: Mon, 04 Nov 2019 21:26:24 -0800
Message-ID: <20191105052624.3269-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2388

--===============3829666335857413920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was not necessary to add a family field to mptcp_sock as it is
a wrapper around a struct sock, and sk_family is set correctly when
the msk is created as a result of a socket() call.

squashto: Associate MPTCP context with TCP socket
          mptcp: Implement basic path manager

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/basic.c    | 5 +++--
 net/mptcp/protocol.c | 1 -
 net/mptcp/protocol.h | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
index 67a93aff500e..03afb1263f3d 100644
--- a/net/mptcp/basic.c
+++ b/net/mptcp/basic.c
@@ -185,6 +185,7 @@ static void announce_addr_worker(struct work_struct *wo=
rk)
 	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
 						addr_work);
 	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
+	struct sock *sk =3D (struct sock *)msk;
 	struct basic_pernet *pernet;
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
@@ -193,11 +194,11 @@ static void announce_addr_worker(struct work_struct *=
work)
 	 * When the listening socket can accept connections from both
 	 * families this restriction may be removed.
 	 */
-	if (pernet->has_announce_v4 && msk->family =3D=3D AF_INET)
+	if (pernet->has_announce_v4 && sk->sk_family =3D=3D AF_INET)
 		mptcp_pm_announce_addr(pm->token, 1,
 				       &pernet->announce_v4_addr);
 #if IS_ENABLED(CONFIG_IPV6)
-	else if (pernet->has_announce_v6 && msk->family =3D=3D AF_INET6)
+	else if (pernet->has_announce_v6 && sk->sk_family =3D=3D AF_INET6)
 		mptcp_pm_announce_addr6(pm->token, 1,
 					&pernet->announce_v6_addr);
 #endif
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3af5f121af9e..c2b29f8d0377 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1091,7 +1091,6 @@ static struct socket *mptcp_socket_create_get(struct =
mptcp_sock *msk)
 	}
 =

 	msk->subflow =3D ssock;
-	msk->family =3D ssock->sk->sk_family;
 	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
 	subflow->request_version =3D 0; /* currently only v0 supported */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8fe5f9383d38..791f2c19cfb8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -133,7 +133,6 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
-	sa_family_t	family;
 	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
-- =

2.17.2

--===============3829666335857413920==--
