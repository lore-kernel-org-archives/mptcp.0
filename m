Content-Type: multipart/mixed; boundary="===============0012658409823413263=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 4/9] Squash-to: "mptcp: Add handling of outgoing
 MP_JOIN requests"
Date: Fri, 21 Feb 2020 17:48:08 +0100
Message-ID: <aa7ef19ddbe1a8f026736389363dee46b6063416.1582303591.git.pabeni@redhat.com>
In-Reply-To: cover.1582303591.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3729

--===============0012658409823413263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

record local id for outgoing MP_JOIN connection.

join_id is the local address id, set as such in mptcp_syn_options()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.h |  7 ++++--
 net/mptcp/subflow.c  | 60 ++++++++++++++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b09d1136f945..961617a16fae 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -309,7 +309,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk=
_buff *skb,
 		pr_debug("remote_token=3D%u, nonce=3D%u", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions =3D OPTION_MPTCP_MPJ_SYN;
-		opts->join_id =3D subflow->remote_id;
+		opts->join_id =3D subflow->local_id;
 		opts->token =3D subflow->remote_token;
 		opts->nonce =3D subflow->local_nonce;
 		opts->backup =3D subflow->request_bkup;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9cd7e94a41ee..c4d935330cac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -256,8 +256,11 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflo=
w_context *subflow)
 int mptcp_is_enabled(struct net *net);
 bool mptcp_subflow_data_available(struct sock *sk);
 void mptcp_subflow_init(void);
-int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
-			  struct sockaddr *remote, u8 remote_id);
+
+/* called with sk socket lock held */
+int __mptcp_subflow_connect(struct sock *sk, int ifindex,
+			    const struct mptcp_addr_info *loc,
+			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 14c168df264d..34905841745f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -24,19 +24,31 @@
 static int subflow_rebuild_header(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	int err =3D 0;
+	int local_id, err =3D 0;
 =

 	if (subflow->request_mptcp && !subflow->token) {
 		pr_debug("subflow=3D%p", sk);
 		err =3D mptcp_token_new_connect(sk);
 	} else if (subflow->request_join && !subflow->local_nonce) {
+		struct mptcp_sock *msk =3D (struct mptcp_sock *)subflow->conn;
+
 		pr_debug("subflow=3D%p", sk);
 =

 		do {
 			get_random_bytes(&subflow->local_nonce, sizeof(u32));
 		} while (!subflow->local_nonce);
+
+		if (subflow->local_id)
+			goto out;
+
+		local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
+		if (local_id < 0)
+			return -EINVAL;
+
+		subflow->local_id =3D local_id;
 	}
 =

+out:
 	if (err)
 		return err;
 =

@@ -761,59 +773,75 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapp=
ed)
 }
 #endif
 =

-int mptcp_subflow_connect(struct sock *sk, struct sockaddr *local,
-			  struct sockaddr *remote, u8 remote_id)
+static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
+				struct sockaddr_storage *addr)
+{
+	memset(addr, 0, sizeof(*addr));
+	addr->ss_family =3D info->family;
+	if (addr->ss_family =3D=3D AF_INET) {
+		struct sockaddr_in *in_addr =3D (struct sockaddr_in *)addr;
+
+		in_addr->sin_addr =3D info->addr;
+		in_addr->sin_port =3D info->port;
+	} else if (addr->ss_family =3D=3D AF_INET6) {
+		struct sockaddr_in6 *in6_addr =3D (struct sockaddr_in6 *)addr;
+
+		in6_addr->sin6_addr =3D info->addr6;
+		in6_addr->sin6_port =3D info->port;
+	}
+}
+
+int __mptcp_subflow_connect(struct sock *sk, int ifindex,
+			    const struct mptcp_addr_info *loc,
+			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	struct sockaddr_storage addr;
 	struct socket *sf;
 	u32 remote_token;
 	int addrlen;
 	int err;
 =

-	lock_sock(sk);
-	if (sk->sk_state !=3D TCP_ESTABLISHED) {
-		release_sock(sk);
+	if (sk->sk_state !=3D TCP_ESTABLISHED)
 		return -ENOTCONN;
-	}
 =

 	err =3D mptcp_subflow_create_socket(sk, &sf);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		return err;
-	}
 =

 	subflow =3D mptcp_subflow_ctx(sf->sk);
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
+	mptcp_info2sockaddr(loc, &addr);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (local->sa_family =3D=3D AF_INET6)
+	if (loc->family =3D=3D AF_INET6)
 		addrlen =3D sizeof(struct sockaddr_in6);
 #endif
-	err =3D kernel_bind(sf, local, addrlen);
+	sf->sk->sk_bound_dev_if =3D ifindex;
+	err =3D kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
 		goto failed;
 =

 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=3D%p remote_token=3D%u", msk, remote_token);
 	subflow->remote_token =3D remote_token;
-	subflow->remote_id =3D remote_id;
+	subflow->local_id =3D loc->id;
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D 1;
+	mptcp_info2sockaddr(remote, &addr);
 =

-	err =3D kernel_connect(sf, remote, addrlen, O_NONBLOCK);
+	err =3D kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err !=3D -EINPROGRESS)
 		goto failed;
 =

-	release_sock(sk);
 	return err;
 =

 failed:
 	list_del_init(&subflow->node);
-	release_sock(sk);
 	sock_release(sf);
 	return err;
 }
-- =

2.21.1

--===============0012658409823413263==--
