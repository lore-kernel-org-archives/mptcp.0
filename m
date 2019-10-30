Content-Type: multipart/mixed; boundary="===============1029887652388721013=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/6] mptcp: Re-factor create socket/subflow routines
 to be af-agnostic
Date: Wed, 30 Oct 2019 16:38:40 -0700
Message-ID: <20191030233844.4790-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191030233844.4790-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2366

--===============1029887652388721013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-factor mptcp_subflow_create_socket() and
mptcp_socket_create_get() to work for both IPv4 and IPv6.

squashto: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3af5f121af9e..ee108e246dcf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1072,7 +1072,8 @@ static struct proto mptcp_prot =3D {
 	.no_autobind	=3D 1,
 };
 =

-static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
+static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk,
+					      sa_family_t family)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
@@ -1084,7 +1085,7 @@ static struct socket *mptcp_socket_create_get(struct =
mptcp_sock *msk)
 	if (ssock)
 		goto release;
 =

-	err =3D mptcp_subflow_create_socket(sk, &ssock);
+	err =3D mptcp_subflow_create_socket(sk, family, &ssock);
 	if (err) {
 		ssock =3D ERR_PTR(err);
 		goto release;
@@ -1112,7 +1113,7 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
 		return err;
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, AF_INET);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -1131,7 +1132,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
 		return err;
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, AF_INET);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

@@ -1193,7 +1194,7 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 =

 	pr_debug("msk=3D%p", msk);
 =

-	ssock =3D mptcp_socket_create_get(msk);
+	ssock =3D mptcp_socket_create_get(msk, AF_INET);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8fe5f9383d38..2635d68e58a0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,8 @@ bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
 int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
 			  struct sockaddr *remote, u8 remote_id);
-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+int mptcp_subflow_create_socket(struct sock *sk, sa_family_t family,
+				struct socket **new_sock);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e6bb68e1c292..13e207458e0b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -632,7 +632,7 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr *local,
 	int err;
 =

 	lock_sock(sk);
-	err =3D mptcp_subflow_create_socket(sk, &sf);
+	err =3D mptcp_subflow_create_socket(sk, local->sa_family, &sf);
 	if (err) {
 		release_sock(sk);
 		return err;
@@ -675,14 +675,15 @@ int mptcp_subflow_connect(struct sock *sk, struct soc=
kaddr *local,
 	return err;
 }
 =

-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+int mptcp_subflow_create_socket(struct sock *sk, sa_family_t family,
+				struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
 	struct net *net =3D sock_net(sk);
 	struct socket *sf;
 	int err;
 =

-	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err =3D sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 =

-- =

2.17.2

--===============1029887652388721013==--
