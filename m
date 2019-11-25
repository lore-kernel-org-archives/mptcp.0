Content-Type: multipart/mixed; boundary="===============2545045990638381048=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 4/7] copy connection id from first subflow to mptcp
 socket
Date: Mon, 25 Nov 2019 03:15:05 +0100
Message-ID: <20191125021508.29153-5-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2676

--===============2545045990638381048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to call inet(6)_getname on the parent socket
and it will return the right result.

At this time it only works because the first incoming subflow has a
'struct socket' allocated.

This will change in followup patch, passive subflows will not have
a socket struct anymore.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/pm.c       | 18 ++++----
 net/mptcp/protocol.c | 98 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  1 -
 3 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7e493d81afef..e474bd9dc05d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -81,6 +81,7 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, stru=
ct in_addr *addr)
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	struct sockaddr_in remote;
 	struct sockaddr_in local;
+	struct sock *sk;
 	int err;
 =

 	if (!msk)
@@ -88,6 +89,7 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, stru=
ct in_addr *addr)
 =

 	pr_debug("msk=3D%p", msk);
 =

+	sk =3D (struct sock *)msk;
 	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
 		err =3D -EBADR;
 		goto create_put;
@@ -101,15 +103,14 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, =
struct in_addr *addr)
 		local.sin_addr.s_addr =3D htonl(INADDR_ANY);
 =

 	remote.sin_family =3D msk->pm.remote_family;
-	remote.sin_port =3D htons(msk->dport);
+	remote.sin_port =3D inet_sk(sk)->inet_dport;
 	remote.sin_addr =3D msk->pm.remote_addr;
 =

-	err =3D mptcp_subflow_connect((struct sock *)msk,
-				    (struct sockaddr *)&local,
+	err =3D mptcp_subflow_connect(sk, (struct sockaddr *)&local,
 				    (struct sockaddr *)&remote, remote_id);
 =

 create_put:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 =

@@ -119,12 +120,14 @@ int mptcp_pm_create_subflow6(u32 token, u8 remote_id,=
 struct in6_addr *addr)
 	struct mptcp_sock *msk =3D mptcp_token_get_sock(token);
 	struct sockaddr_in6 remote;
 	struct sockaddr_in6 local;
+	struct sock *sk;
 	int err;
 =

 	if (!msk)
 		return -EINVAL;
 =

 	pr_debug("msk=3D%p", msk);
+	sk =3D (struct sock *)msk;
 =

 	if (!msk->pm.remote_valid || remote_id !=3D msk->pm.remote_id) {
 		err =3D -EBADR;
@@ -139,15 +142,14 @@ int mptcp_pm_create_subflow6(u32 token, u8 remote_id,=
 struct in6_addr *addr)
 		local.sin6_addr =3D in6addr_any;
 =

 	remote.sin6_family =3D msk->pm.remote_family;
-	remote.sin6_port =3D htons(msk->dport);
+	remote.sin6_port =3D inet_sk(sk)->inet_dport;
 	remote.sin6_addr =3D msk->pm.remote_addr6;
 =

-	err =3D mptcp_subflow_connect((struct sock *)msk,
-				    (struct sockaddr *)&local,
+	err =3D mptcp_subflow_connect(sk, (struct sockaddr *)&local,
 				    (struct sockaddr *)&remote, remote_id);
 =

 create_put:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 #endif
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 72e6950fbbc2..720c0ab46cfb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -91,19 +91,6 @@ static struct socket *mptcp_fallback_get_ref(const struc=
t mptcp_sock *msk)
 	return ssock;
 }
 =

-static struct sock *mptcp_subflow_get(const struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		return mptcp_subflow_tcp_socket(subflow)->sk;
-	}
-
-	return NULL;
-}
-
 static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
@@ -934,6 +921,29 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	return tcp_disconnect(sk, flags);
 }
 =

+static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
+{
+	const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
+	struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
+
+	inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
+	inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dport;
+	inet_sk(msk)->inet_sport =3D inet_sk(ssk)->inet_sport;
+	inet_sk(msk)->inet_daddr =3D inet_sk(ssk)->inet_daddr;
+	inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_saddr;
+	inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_rcv_saddr;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	msk->sk_v6_daddr =3D ssk->sk_v6_daddr;
+	msk->sk_v6_rcv_saddr =3D ssk->sk_v6_rcv_saddr;
+
+	if (msk6 && ssk6) {
+		msk6->saddr =3D ssk6->saddr;
+		msk6->flow_label =3D ssk6->flow_label;
+	}
+#endif
+}
+
 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 				 bool kern)
 {
@@ -954,6 +964,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
 =

 	if (subflow->mp_capable) {
+		struct sock *ssk =3D new_sock->sk;
 		struct sock *new_mptcp_sock;
 		u64 ack_seq;
 =

@@ -988,6 +999,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 		newsk =3D new_mptcp_sock;
+		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
 		bh_unlock_sock(new_mptcp_sock);
 =

@@ -999,7 +1011,7 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		/* the subflow can already receive packet, avoid racing with
 		 * the receive path and process the pending ones
 		 */
-		lock_sock(new_sock->sk);
+		lock_sock(ssk);
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
@@ -1007,7 +1019,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		subflow->conn =3D new_mptcp_sock;
 		if (unlikely(!skb_queue_empty(&new_sock->sk->sk_receive_queue)))
 			mptcp_subflow_data_available(new_sock->sk);
-		release_sock(new_sock->sk);
+		release_sock(ssk);
 	} else {
 		newsk =3D new_sock->sk;
 		tcp_sk(newsk)->is_mptcp =3D 0;
@@ -1122,6 +1134,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
 =

 	if (mp_capable) {
+		struct sock *ssk =3D msk->subflow->sk;
 		u64 ack_seq;
 =

 		/* sk (new subflow socket) is already locked, but we need
@@ -1151,7 +1164,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
-		msk->dport =3D ntohs(inet_sk(msk->subflow->sk)->inet_dport);
+		mptcp_copy_inaddrs(sk, ssk);
 =

 		mptcp_pm_new_connection(msk, 0);
 =

@@ -1300,43 +1313,44 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
 }
 =

 static int mptcp_getname(struct socket *sock, struct sockaddr *uaddr,
-			 int peer)
+			 int peer, int af)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	struct sock *ssk;
 	int ret;
 =

-	lock_sock(sock->sk);
-	ssock =3D __mptcp_fallback_get_ref(msk);
-	if (ssock) {
+	if (msk->subflow) {
+		lock_sock(sock->sk);
+		ssock =3D __mptcp_fallback_get_ref(msk);
 		release_sock(sock->sk);
-		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D ssock->ops->getname(ssock, uaddr, peer);
-		sock_put(ssock->sk);
-		return ret;
+		if (ssock) {
+			pr_debug("subflow=3D%p", ssock->sk);
+			ret =3D ssock->ops->getname(ssock, uaddr, peer);
+			sock_put(ssock->sk);
+			return ret;
+		}
 	}
 =

-	/* @@ the meaning of getname() for the remote peer when the socket
-	 * is connected and there are multiple subflows is not defined.
-	 * For now just use the first subflow on the list.
-	 */
-	ssk =3D mptcp_subflow_get(msk);
-	if (!ssk) {
-		release_sock(sock->sk);
-		return -ENOTCONN;
+	switch (af) {
+	case AF_INET:
+		ret =3D inet_getname(sock, uaddr, peer);
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6:
+		ret =3D inet6_getname(sock, uaddr, peer);
+		break;
+#endif
+	default:
+		ret =3D -ENOPROTOOPT;
+		WARN_ON_ONCE(1);
 	}
 =

-	ret =3D ssk->sk_socket->ops->getname(ssk->sk_socket, uaddr, peer);
-	release_sock(sock->sk);
 	return ret;
 }
 =

 static int mptcp_v4_getname(struct socket *sock, struct sockaddr *uaddr,
 			    int peer)
 {
-	int ret;
-
 	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
 		/* we are being invoked from __sys_accept4, after
 		 * mptcp_accept() has just accepted a non-mp-capable
@@ -1349,17 +1363,13 @@ static int mptcp_v4_getname(struct socket *sock, st=
ruct sockaddr *uaddr,
 		return sock->ops->getname(sock, uaddr, peer);
 	}
 =

-	ret =3D mptcp_getname(sock, uaddr, peer);
-
-	return ret;
+	return mptcp_getname(sock, uaddr, peer, AF_INET);
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
 			    int peer)
 {
-	int ret;
-
 	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
 		/* we are being invoked from __sys_accept4 after
 		 * mptcp_accept() has accepted a non-mp-capable
@@ -1372,9 +1382,7 @@ static int mptcp_v6_getname(struct socket *sock, stru=
ct sockaddr *uaddr,
 		return sock->ops->getname(sock, uaddr, peer);
 	}
 =

-	ret =3D mptcp_getname(sock, uaddr, peer);
-
-	return ret;
+	return mptcp_getname(sock, uaddr, peer, AF_INET6);
 }
 #endif
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index acad61c70de9..237c5efd0ba7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -134,7 +134,6 @@ struct mptcp_sock {
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
-	u16		dport;
 	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
-- =

2.23.0

--===============2545045990638381048==--
