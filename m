Content-Type: multipart/mixed; boundary="===============4530976633198712927=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/5] mptcp: Make mptcp_subflow_connect() IPv4/6
 agnostic
Date: Tue, 15 Oct 2019 16:06:11 -0700
Message-ID: <20191015230613.16981-4-peter.krystad@linux.intel.com>
In-Reply-To: 20191015230613.16981-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2162

--===============4530976633198712927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will make IPV6-ifying the path manager interface easier.

squashto: Add handling of outgoing MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/subflow.c  | 16 ++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2bfcb65c7c0a..06e330b3a0f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -248,8 +248,8 @@ mptcp_subflow_tcp_socket(const struct mptcp_subflow_con=
text *subflow)
 int mptcp_is_enabled(struct net *net);
 =

 void mptcp_subflow_init(void);
-int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
-			  struct sockaddr_in *remote, u8 remote_id);
+int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
+			  struct sockaddr *remote, u8 remote_id);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

 extern const struct inet_connection_sock_af_ops ipv4_specific;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b0cda95fbe20..aa94d2f74e89 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -330,13 +330,14 @@ static void subflow_data_ready(struct sock *sk)
 	}
 }
 =

-int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
-			  struct sockaddr_in *remote, u8 remote_id)
+int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
+			  struct sockaddr *remote, u8 remote_id)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct socket *sf;
 	u32 remote_token;
+	int addrlen;
 	int err;
 =

 	lock_sock(sk);
@@ -354,8 +355,12 @@ int mptcp_subflow_connect(struct sock *sk, struct sock=
addr_in *local,
 	sock_hold(sf->sk);
 	release_sock(sk);
 =

-	err =3D kernel_bind(sf, (struct sockaddr *)local,
-			  sizeof(struct sockaddr_in));
+	addrlen =3D sizeof(struct sockaddr_in);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (local->sa_family =3D=3D AF_INET6)
+		addrlen =3D sizeof(struct sockaddr_in6);
+#endif
+	err =3D kernel_bind(sf, local, addrlen);
 	if (err)
 		goto failed;
 =

@@ -366,8 +371,7 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr_in *local,
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D 1;
 =

-	err =3D kernel_connect(sf, (struct sockaddr *)remote,
-			     sizeof(struct sockaddr_in), O_NONBLOCK);
+	err =3D kernel_connect(sf, remote, addrlen, O_NONBLOCK);
 	if (err && err !=3D -EINPROGRESS)
 		goto failed;
 =

-- =

2.17.2

--===============4530976633198712927==--
