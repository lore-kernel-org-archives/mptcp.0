Content-Type: multipart/mixed; boundary="===============4696774993467987976=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 09/16] mptcp: Add key generation and token tree
Date: Wed, 28 Mar 2018 16:18:33 -0700
Message-ID: <20180328231840.12410-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 453

--===============4696774993467987976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Generate the local keys, IDSN, and token when creating a new
socket. Introduce the token tree to track all tokens in use using
a radix tree with the MPTCP token itself as the index.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/net/mptcp.h  |  25 ++++++
 net/mptcp/Makefile   |   2 +-
 net/mptcp/crypto.c   | 213 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 net/mptcp/protocol.c |  21 ++++-
 net/mptcp/subflow.c  |  30 ++++++-
 net/mptcp/token.c    | 221 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 6 files changed, 508 insertions(+), 4 deletions(-)
 create mode 100644 net/mptcp/crypto.c
 create mode 100644 net/mptcp/token.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 981d782cab9a..06bf49844c86 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -39,6 +39,7 @@ struct mptcp_sock {
 	struct	inet_connection_sock sk;
 	u64	local_key;
 	u64	remote_key;
+	u32	token;
 	struct	socket *connection_list; /* @@ needs to be a list */
 	struct	socket *subflow; /* outgoing connect, listener or !mp_capable */
 };
@@ -54,6 +55,7 @@ struct subflow_sock {
 	struct	tcp_sock sk;
 	u64	local_key;
 	u64	remote_key;
+	u32	token;
 	bool	request_mptcp;	// send MP_CAPABLE
 	bool	checksum;
 	bool	version;
@@ -76,6 +78,7 @@ struct subflow_request_sock {
 		version : 4;
 	u64	local_key;
 	u64	remote_key;
+	u32	token;
 };
 =

 static inline
@@ -102,6 +105,28 @@ void mptcp_get_options(const struct sk_buff *skb,
 =

 extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
 =

+void token_init(void);
+void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
+void token_destroy_request(u32 token);
+void token_new_connect(struct sock *sk);
+void token_new_accept(struct sock *sk);
+void token_destroy(u32 token);
+
+void crypto_init(void);
+u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr,
+			__be16 sport, __be16 dport);
+u64 crypto_v4_get_key(__be32 saddr, __be32 daddr,
+			__be16 sport, __be16 dport);
+u64 crypto_v6_get_key(const struct in6_addr *saddr,
+		      const struct in6_addr *daddr,
+		      __be16 sport, __be16 dport);
+u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__be16 sport, __be16 dport);
+void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
+void crypto_hmac_sha1(const u8 *key_1, const u8 *key_2, u32 *hash_out,
+		     int arg_num, ...);
+
 #else
 =

 static inline void mptcp_parse_option(const unsigned char *ptr, int opsize,
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 3f0e7163fe80..eaf59dc38b00 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o subflow.o options.o
+mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o
diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
new file mode 100644
index 000000000000..0ba35449c4a0
--- /dev/null
+++ b/net/mptcp/crypto.c
@@ -0,0 +1,213 @@
+/*
+ * Multipath TCP cryptographic functions
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * Note: This code is based on mptcp_ctrl.c, mptcp_ipv4.c, and
+ *       mptcp_ipv6 from multipath-tcp.org, authored by:
+ *
+ *       S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *       Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *       Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *       Gregory Detal <gregory.detal(a)uclouvain.be>
+ *       Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *       Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *       Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *       Andreas Ripke <ripke(a)neclab.eu>
+ *       Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *       Octavian Purdila <octavian.purdila(a)intel.com>
+ *       John Ronan <jronan(a)tssg.org>
+ *       Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *       Brandon Heller <brandonh(a)stanford.edu>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cryptohash.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
+
+static siphash_key_t crypto_key_secret __read_mostly;
+static hsiphash_key_t crypto_nonce_secret __read_mostly;
+static u32 crypto_seed;
+
+u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16 d=
port)
+{
+	return hsiphash_4u32((__force u32)saddr, (__force u32)daddr,
+			    (__force u32)sport << 16 | (__force u32)dport,
+			    crypto_seed++, &crypto_nonce_secret);
+}
+
+u64 crypto_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 dpo=
rt)
+{
+	pr_debug("src=3D%x:%d, dst=3D%x:%d", saddr, sport, daddr, dport);
+	return siphash_4u32((__force u32)saddr, (__force u32)daddr,
+			    (__force u32)sport << 16 | (__force u32)dport,
+			    crypto_seed++, &crypto_key_secret);
+}
+
+u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__be16 sport, __be16 dport)
+{
+	const struct {
+		struct in6_addr saddr;
+		struct in6_addr daddr;
+		u32 seed;
+		__be16 sport;
+		__be16 dport;
+	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
+		.saddr =3D *saddr,
+		.daddr =3D *daddr,
+		.seed =3D crypto_seed++,
+		.sport =3D sport,
+		.dport =3D dport,
+	};
+
+	return hsiphash(&combined, offsetofend(typeof(combined), dport),
+			&crypto_nonce_secret);
+}
+
+u64 crypto_v6_get_key(const struct in6_addr *saddr,
+		      const struct in6_addr *daddr,
+		      __be16 sport, __be16 dport)
+{
+	const struct {
+		struct in6_addr saddr;
+		struct in6_addr daddr;
+		u32 seed;
+		__be16 sport;
+		__be16 dport;
+	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
+		.saddr =3D *saddr,
+		.daddr =3D *daddr,
+		.seed =3D crypto_seed++,
+		.sport =3D sport,
+		.dport =3D dport,
+	};
+
+	return siphash(&combined, offsetofend(typeof(combined), dport),
+		       &crypto_key_secret);
+}
+
+void crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
+{
+	u32 workspace[SHA_WORKSPACE_WORDS];
+	u32 mptcp_hashed_key[SHA_DIGEST_WORDS];
+	u8 input[64];
+	int i;
+
+	memset(workspace, 0, sizeof(workspace));
+
+	/* Initialize input with appropriate padding */
+	memset(&input[9], 0, sizeof(input) - 10); /* -10, because the last byte
+						   * is explicitly set too
+						   */
+	memcpy(input, &key, sizeof(key)); /* Copy key to the msg beginning */
+	input[8] =3D 0x80; /* Padding: First bit after message =3D 1 */
+	input[63] =3D 0x40; /* Padding: Length of the message =3D 64 bits */
+
+	sha_init(mptcp_hashed_key);
+	sha_transform(mptcp_hashed_key, input, workspace);
+
+	for (i =3D 0; i < 5; i++)
+		mptcp_hashed_key[i] =3D cpu_to_be32(mptcp_hashed_key[i]);
+
+	if (token)
+		*token =3D mptcp_hashed_key[0];
+	if (idsn)
+		*idsn =3D *((u64 *)&mptcp_hashed_key[3]);
+}
+
+void crypto_hmac_sha1(const u8 *key_1, const u8 *key_2, u32 *hash_out,
+		      int arg_num, ...)
+{
+	u32 workspace[SHA_WORKSPACE_WORDS];
+	u8 input[128]; /* 2 512-bit blocks */
+	int i;
+	int index;
+	int length;
+	u8 *msg;
+	va_list list;
+
+	memset(workspace, 0, sizeof(workspace));
+
+	/* Generate key xored with ipad */
+	memset(input, 0x36, 64);
+	for (i =3D 0; i < 8; i++)
+		input[i] ^=3D key_1[i];
+	for (i =3D 0; i < 8; i++)
+		input[i + 8] ^=3D key_2[i];
+
+	va_start(list, arg_num);
+	index =3D 64;
+	for (i =3D 0; i < arg_num; i++) {
+		length =3D va_arg(list, int);
+		msg =3D va_arg(list, u8 *);
+		WARN_ON(index + length > 125); /* Message is too long */
+		memcpy(&input[index], msg, length);
+		index +=3D length;
+	}
+	va_end(list);
+
+	input[index] =3D 0x80; /* Padding: First bit after message =3D 1 */
+	memset(&input[index + 1], 0, (126 - index));
+
+	/* Padding: Length of the message =3D 512 + message length (bits) */
+	input[126] =3D 0x02;
+	input[127] =3D ((index - 64) * 8); /* Message length (bits) */
+
+	sha_init(hash_out);
+	sha_transform(hash_out, input, workspace);
+	memset(workspace, 0, sizeof(workspace));
+
+	sha_transform(hash_out, &input[64], workspace);
+	memset(workspace, 0, sizeof(workspace));
+
+	for (i =3D 0; i < 5; i++)
+		hash_out[i] =3D cpu_to_be32(hash_out[i]);
+
+	/* Prepare second part of hmac */
+	memset(input, 0x5C, 64);
+	for (i =3D 0; i < 8; i++)
+		input[i] ^=3D key_1[i];
+	for (i =3D 0; i < 8; i++)
+		input[i + 8] ^=3D key_2[i];
+
+	memcpy(&input[64], hash_out, 20);
+	input[84] =3D 0x80;
+	memset(&input[85], 0, 41);
+
+	/* Padding: Length of the message =3D 512 + 160 bits */
+	input[126] =3D 0x02;
+	input[127] =3D 0xA0;
+
+	sha_init(hash_out);
+	sha_transform(hash_out, input, workspace);
+	memset(workspace, 0, sizeof(workspace));
+
+	sha_transform(hash_out, &input[64], workspace);
+
+	for (i =3D 0; i < 5; i++)
+		hash_out[i] =3D cpu_to_be32(hash_out[i]);
+}
+
+void crypto_init(void)
+{
+	get_random_bytes((void *)&crypto_key_secret,
+			 sizeof(crypto_key_secret));
+	get_random_bytes((void *)&crypto_nonce_secret,
+			 sizeof(crypto_nonce_secret));
+	crypto_seed =3D 0;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d401c197caf3..373e89cf8eda 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -38,6 +38,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr=
 *saddr, int len)
 	if (!err) {
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
+		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", subflow->token);
 		msk->connection_list =3D msk->subflow;
 		msk->subflow =3D NULL;
 	}
@@ -91,13 +93,11 @@ static int mptcp_init_sock(struct sock *sk)
 		struct subflow_sock *subflow =3D subflow_sk(sf->sk);
 =

 		pr_debug("subflow=3D%p", subflow);
-		msk->local_key =3D 1234567887654321; // @@ fixed for now
 		msk->subflow =3D sf;
 		subflow->conn =3D sk;
 		subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
 		subflow->checksum =3D 1; // @@ if checksum enabled
 		subflow->version =3D 0;
-		subflow->local_key =3D msk->local_key;
 	}
 =

 	return err;
@@ -148,6 +148,8 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 	if (subflow->mp_capable) {
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
+		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", msk->token);
 		msk->connection_list =3D new_sock;
 	} else {
 		msk->subflow =3D new_sock;
@@ -156,6 +158,15 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 	return mp->sk;
 }
 =

+static void mptcp_destroy(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
+
+	token_destroy(msk->token);
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -186,6 +197,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 	if (mp_capable) {
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
+		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", msk->token);
 		msk->connection_list =3D msk->subflow;
 		msk->subflow =3D NULL;
 	}
@@ -223,6 +236,7 @@ static struct proto mptcp_prot =3D {
 	.accept		=3D mptcp_accept,
 	.connect	=3D mptcp_connect,
 	.shutdown	=3D tcp_shutdown,
+	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
 	.hash		=3D inet_hash,
@@ -275,6 +289,9 @@ static int __init mptcp_init(void)
 =

 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
 =

+	token_init();
+	crypto_init();
+
 	err =3D mptcp_subflow_init();
 	if (err)
 		goto subflow_failed;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 89fcc3b746eb..9f417f3ed188 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -53,6 +53,28 @@ static int subflow_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 	return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
 }
 =

+static int subflow_rebuild_header(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	if (subflow->request_mptcp && !subflow->token) {
+		pr_debug("subflow=3D%p", sk);
+		token_new_connect(sk);
+	}
+
+	return inet_sk_rebuild_header(sk);
+}
+
+static void subflow_req_destructor(struct request_sock *req)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+
+	pr_debug("subflow_req=3D%p", subflow_req);
+
+	token_destroy_request(subflow_req->token);
+	tcp_request_sock_ops.destructor(req);
+}
+
 static void subflow_v4_init_req(struct request_sock *req,
 				const struct sock *sk_listener,
 				struct sk_buff *skb)
@@ -82,6 +104,8 @@ static void subflow_v4_init_req(struct request_sock *req,
 		    listener->checksum)
 			subflow_req->checksum =3D 1;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
+		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
+		token_new_request(req, skb);
 	} else {
 		subflow_req->mp_capable =3D 0;
 	}
@@ -147,6 +171,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			subflow->fourth_ack =3D 1;
 			subflow->remote_key =3D subflow_req->remote_key;
 			subflow->local_key =3D subflow_req->local_key;
+			subflow->token =3D subflow_req->token;
+			pr_debug("token=3D%u", subflow->token);
+			token_new_accept(child);
 		} else {
 			subflow->mp_capable =3D 0;
 		}
@@ -158,7 +185,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 const struct inet_connection_sock_af_ops subflow_specific =3D {
 	.queue_xmit	   =3D ip_queue_xmit,
 	.send_check	   =3D tcp_v4_send_check,
-	.rebuild_header	   =3D inet_sk_rebuild_header,
+	.rebuild_header	   =3D subflow_rebuild_header,
 	.sk_rx_dst_set	   =3D subflow_finish_connect,
 	.conn_request	   =3D subflow_conn_request,
 	.syn_recv_sock	   =3D subflow_syn_recv_sock,
@@ -273,6 +300,7 @@ int mptcp_subflow_init(void)
 =

 	subflow_request_sock_ops =3D tcp_request_sock_ops;
 	subflow_request_sock_ops.obj_size =3D sizeof(struct subflow_request_sock),
+	subflow_request_sock_ops.destructor =3D subflow_req_destructor;
 =

 	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
new file mode 100644
index 000000000000..241cc0eb5729
--- /dev/null
+++ b/net/mptcp/token.c
@@ -0,0 +1,221 @@
+/*
+ * Multipath TCP token management
+ * Copyright (c) 2017, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * Note: This code is based on mptcp_ctrl.c from multipath-tcp.org,
+ *       authored by:
+ *
+ *       S=C3=A9bastien Barr=C3=A9 <sebastien.barre(a)uclouvain.be>
+ *       Christoph Paasch <christoph.paasch(a)uclouvain.be>
+ *       Jaakko Korkeaniemi <jaakko.korkeaniemi(a)aalto.fi>
+ *       Gregory Detal <gregory.detal(a)uclouvain.be>
+ *       Fabien Duch=C3=AAne <fabien.duchene(a)uclouvain.be>
+ *       Andreas Seelinger <Andreas.Seelinger(a)rwth-aachen.de>
+ *       Lavkesh Lahngir <lavkesh51(a)gmail.com>
+ *       Andreas Ripke <ripke(a)neclab.eu>
+ *       Vlad Dogaru <vlad.dogaru(a)intel.com>
+ *       Octavian Purdila <octavian.purdila(a)intel.com>
+ *       John Ronan <jronan(a)tssg.org>
+ *       Catalin Nicutar <catalin.nicutar(a)gmail.com>
+ *       Brandon Heller <brandonh(a)stanford.edu>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/radix-tree.h>
+#include <net/sock.h>
+#include <net/inet_common.h>
+#include <net/protocol.h>
+#include <net/tcp.h>
+#include <net/mptcp.h>
+
+static struct radix_tree_root token_tree;
+static struct radix_tree_root token_req_tree;
+static spinlock_t token_tree_lock;
+static int token_used;
+
+static bool find_req_token(u32 token)
+{
+	void *used;
+
+	pr_debug("token=3D%u", token);
+	used =3D radix_tree_lookup(&token_req_tree, token);
+	return (used =3D=3D &token_used);
+}
+
+static bool find_token(u32 token)
+{
+	void *used;
+
+	pr_debug("token=3D%u", token);
+	used =3D radix_tree_lookup(&token_tree, token);
+	return (used =3D=3D &token_used);
+}
+
+static void new_req_token(struct request_sock *req,
+			  const struct sk_buff *skb)
+{
+	const struct inet_request_sock *ireq =3D inet_rsk(req);
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	u64 local_key;
+
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		local_key =3D crypto_v4_get_key(ip_hdr(skb)->saddr,
+					      ip_hdr(skb)->daddr,
+					      htons(ireq->ir_num),
+					      ireq->ir_rmt_port);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		local_key =3D crypto_v6_get_key(&ipv6_hdr(skb)->saddr,
+					      &ipv6_hdr(skb)->daddr,
+					      htons(ireq->ir_num),
+					      ireq->ir_rmt_port);
+#endif
+	}
+	pr_debug("local_key=3D%llu:%llx", local_key, local_key);
+	subflow_req->local_key =3D local_key;
+	crypto_key_sha1(subflow_req->local_key, &subflow_req->token, NULL);
+	pr_debug("token=3D%u", subflow_req->token);
+}
+
+static void new_token(const struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+	const struct inet_sock *isk =3D inet_sk(sk);
+
+	if (sk->sk_family =3D=3D AF_INET) {
+		subflow->local_key =3D crypto_v4_get_key(isk->inet_saddr,
+						       isk->inet_daddr,
+						       isk->inet_sport,
+						       isk->inet_dport);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		subflow->local_key =3D crypto_v6_get_key(&inet6_sk(sk)->saddr,
+						       &sk->sk_v6_daddr,
+						       isk->inet_sport,
+						       isk->inet_dport);
+#endif
+	}
+	pr_debug("local_key=3D%llu:%llx", subflow->local_key, subflow->local_key);
+	crypto_key_sha1(subflow->local_key, &subflow->token, NULL);
+	pr_debug("token=3D%u", subflow->token);
+}
+
+static int insert_req_token(u32 token)
+{
+	void *used =3D &token_used;
+
+	pr_debug("token=3D%u", token);
+	return radix_tree_insert(&token_req_tree, token, used);
+}
+
+static int insert_token(u32 token)
+{
+	void *used =3D &token_used;
+
+	pr_debug("token=3D%u", token);
+	return radix_tree_insert(&token_tree, token, used);
+}
+
+static void destroy_req_token(u32 token)
+{
+	void *cur;
+
+	pr_debug("token=3D%u", token);
+	cur =3D radix_tree_delete(&token_req_tree, token);
+	if (!cur)
+		pr_warn("token NOT FOUND!");
+}
+
+static void destroy_token(u32 token)
+{
+	void *cur;
+
+	pr_debug("token=3D%u", token);
+	cur =3D radix_tree_delete(&token_tree, token);
+	if (!cur)
+		pr_warn("token NOT FOUND!");
+}
+
+/* create new local key, idsn, and token for subflow_request */
+void token_new_request(struct request_sock *req,
+		       const struct sk_buff *skb)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+
+	pr_debug("subflow_req=3D%p", req);
+	rcu_read_lock_bh();
+	spin_lock_bh(&token_tree_lock);
+	do {
+		new_req_token(req, skb);
+	} while (find_req_token(subflow_req->token) ||
+		 find_token(subflow_req->token));
+	insert_req_token(subflow_req->token);
+	spin_unlock_bh(&token_tree_lock);
+	rcu_read_unlock_bh();
+}
+
+/* create new local key, idsn, and token for subflow */
+void token_new_connect(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", sk);
+
+	rcu_read_lock_bh();
+	spin_lock_bh(&token_tree_lock);
+	do {
+		new_token(sk);
+	} while (find_req_token(subflow->token) ||
+		 find_token(subflow->token));
+	insert_token(subflow->token);
+	spin_unlock_bh(&token_tree_lock);
+	rcu_read_unlock_bh();
+}
+
+void token_new_accept(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", sk);
+
+	rcu_read_lock_bh();
+	spin_lock_bh(&token_tree_lock);
+	insert_token(subflow->token);
+	spin_unlock_bh(&token_tree_lock);
+	rcu_read_unlock_bh();
+}
+
+void token_destroy_request(u32 token)
+{
+	rcu_read_lock_bh();
+	spin_lock_bh(&token_tree_lock);
+	destroy_req_token(token);
+	spin_unlock_bh(&token_tree_lock);
+	rcu_read_unlock_bh();
+}
+
+void token_destroy(u32 token)
+{
+	rcu_read_lock_bh();
+	spin_lock_bh(&token_tree_lock);
+	destroy_token(token);
+	spin_unlock_bh(&token_tree_lock);
+	rcu_read_unlock_bh();
+}
+
+void token_init(void)
+{
+	INIT_RADIX_TREE(&token_tree, GFP_ATOMIC);
+	INIT_RADIX_TREE(&token_req_tree, GFP_ATOMIC);
+	spin_lock_init(&token_tree_lock);
+}
-- =

2.16.3


--===============4696774993467987976==--
