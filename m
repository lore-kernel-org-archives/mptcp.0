Content-Type: multipart/mixed; boundary="===============1091196478232565933=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Thu, 26 Sep 2019 19:20:56 +0200
Message-ID: <1a5101afdb6fa955835b7fd09ce56077abf2c1eb.camel@redhat.com>
In-Reply-To: 20190926150519.GA9938@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1935

--===============1091196478232565933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-26 at 17:05 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > We (well, mainly poor Florian) are working to a rebase. Main reason for
> > rebase is that the squashing proved to be quite complex. Likely a pull
> > request could be shared very soon, but any export branch change from
> > now one will likely be omitted.
> =

> Paolo placed current iteration here:
> =

> https://github.com/pabeni/mptcp/commits/export_squash_09_more_nit
> =

> Following patches were folded (some were split and merged in
> several other patches).
> =

> Florian:
> mptcp: add and use mptcp_subflow_hold
> mptcp: selftests: switch to netns+veth based tests
> mptcp: accept: don't leak mptcp socket structure
> mptcp: switch sublist to mptcp socket lock protection
> mptcp: token: add mptcp prefixes to functions
> =

> Mat:
> mptcp: selftests: Add capture option
> =

> Peter:
> tcp: Make connection_list a real list of subflows
> =

> This results in 40 patches. The series is bisectable.
> =

> There are a few more candidates, e.g.
>   mptcp: harmonize locking on all socket operations
> =

> from Paolo.
> =

> But I figured it would make sense to share this now and discuss
> how to proceed from here first.

The above branch is based on mptcp_net-next export branch hash
a45bdbe6701b

There is a small diff vs such hash, see below. Mostily checkpack fixes,
a trivial functional fix in mptcp_setsockopt(), and a bunch of likely
not interesting debug messages dropped - side note: we may want remove
more of them.
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 439d6744c8e2..e0ae0a2542d1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
 =

+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -291,8 +293,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	}
 =

 	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
-	BUG_ON(collapsed && !can_collapse);
 	if (collapsed) {
+		WARN_ON_ONCE(!can_collapse);
 		/* when collapsing mpext always exists */
 		mpext->data_len +=3D ret;
 		goto out;
@@ -847,8 +849,6 @@ static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	pr_debug("msk=3D%p", msk);
-
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

@@ -977,6 +977,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
+
 		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

@@ -1036,7 +1037,7 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not defined.
 	 */
-	return 0;
+	return -EOPNOTSUPP;
 }
 =

 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
@@ -1147,7 +1148,6 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
-
 		list_add(&subflow->node, &msk->conn_list);
 		msk->subflow =3D NULL;
 		bh_unlock_sock(sk);
@@ -1241,8 +1241,6 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 	struct socket *ssock;
 	int err =3D -ENOTSUPP;
 =

-	pr_debug("msk=3D%p", msk);
-
 	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
 		return err;
 =

@@ -1262,8 +1260,6 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 	struct socket *ssock;
 	int err =3D -ENOTSUPP;
 =

-	pr_debug("msk=3D%p", msk);
-
 	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
 		return err;
 =

@@ -1284,8 +1280,6 @@ static int mptcp_getname(struct socket *sock, struct =
sockaddr *uaddr,
 	struct sock *ssk;
 	int ret;
 =

-	pr_debug("msk=3D%p", msk);
-
 	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
 		/* we are being invoked from __sys_accept4, after
 		 * mptcp_accept() has just accepted a non-mp-capable
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0fd4a9523db..f3f293c82058 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,8 +8,8 @@
 #define __MPTCP_PROTOCOL_H
 =

 #include <linux/random.h>
-#include <linux/spinlock.h>
 #include <net/tcp.h>
+#include <net/inet_connection_sock.h>
 =

 /* MPTCP option bits */
 #define OPTION_MPTCP_MPC_SYN	BIT(0)
@@ -199,10 +199,10 @@ struct subflow_context {
 	struct	list_head node;/* conn_list of subflows */
 	u64	local_key;
 	u64	remote_key;
+	u64	idsn;
+	u64	map_seq;
 	u32	token;
 	u32     rel_write_seq;
-	u64     idsn;
-	u64	map_seq;
 	u32	map_subflow_seq;
 	u32	ssn_offset;
 	u16	map_data_len;
@@ -284,6 +284,7 @@ static inline void crypto_key_gen_sha1(u64 *key, u32 *t=
oken, u64 *idsn)
 	get_random_bytes(key, sizeof(u64));
 	crypto_key_sha1(*key, token, idsn);
 }
+
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 		      u32 *hash_out);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 465c1fcc59ac..80d297ce11d2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -121,7 +121,6 @@ static void subflow_v4_init_req(struct request_sock *re=
q,
 		    listener->request_cksum)
 			subflow_req->checksum =3D 1;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
-		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
 		subflow_req->mp_join =3D 1;
@@ -249,13 +248,14 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 					  bool *own_req)
 {
 	struct subflow_context *listener =3D subflow_ctx(sk);
-	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct subflow_request_sock *subflow_req;
 	struct tcp_options_received opt_rx;
 	struct sock *child;
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

 	/* if the sk is MP_CAPABLE, we already received the client key */
+	subflow_req =3D subflow_rsk(req);
 	if (!subflow_req->mp_capable && subflow_req->mp_join) {
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
@@ -458,14 +458,11 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 			      const gfp_t priority)
 {
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
-	struct subflow_context *old_ctx;
+	struct subflow_context *old_ctx =3D subflow_ctx(newsk);
 	struct subflow_context *new_ctx;
 =

-	old_ctx =3D subflow_ctx(newsk);
-
 	/* newsk->sk_socket is NULL at this point */
 	new_ctx =3D subflow_create_ctx(newsk, NULL, priority);
-
 	if (!new_ctx)
 		return;
 =

@@ -482,7 +479,6 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 		new_ctx->token =3D subflow_req->token;
 		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
 		new_ctx->idsn =3D subflow_req->idsn;
-		pr_debug("token=3D%u", new_ctx->token);
 	} else if (subflow_req->mp_join) {
 		new_ctx->mp_join =3D 1;
 		new_ctx->fourth_ack =3D 1;
@@ -490,7 +486,6 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 		new_ctx->local_id =3D subflow_req->local_id;
 		new_ctx->token =3D subflow_req->token;
 		new_ctx->thmac =3D subflow_req->thmac;
-		pr_debug("token=3D%u", new_ctx->token);
 	}
 }
 =

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f493ebb4c2d8..27cd0acc6ea9 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -54,16 +54,15 @@ int mptcp_token_new_request(struct request_sock *req)
 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
 	int err;
 =

-	pr_debug("subflow_req=3D%p", req);
 	while (1) {
 		u32 token;
 =

 		crypto_key_gen_sha1(&subflow_req->local_key,
 				    &subflow_req->token,
 				    &subflow_req->idsn);
-		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
-			 subflow_req->local_key,
-			 subflow_req->token, subflow_req->idsn);
+		pr_debug("req=3D%p local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
+			 req, subflow_req->local_key, subflow_req->token,
+			 subflow_req->idsn);
 =

 		token =3D subflow_req->token;
 		spin_lock_bh(&token_tree_lock);
@@ -101,17 +100,14 @@ int mptcp_token_new_connect(struct sock *sk)
 	struct sock *mptcp_sock =3D subflow->conn;
 	int err;
 =

-	pr_debug("subflow=3D%p", sk);
-
 	while (1) {
 		u32 token;
 =

 		crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
 				    &subflow->idsn);
 =

-		pr_debug("local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
-			 subflow->local_key,
-			 subflow->token, subflow->idsn);
+		pr_debug("ssk=3D%p, local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
+			 sk, subflow->local_key, subflow->token, subflow->idsn);
 =

 		token =3D subflow->token;
 		spin_lock_bh(&token_tree_lock);


--===============1091196478232565933==--
