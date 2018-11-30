Content-Type: multipart/mixed; boundary="===============1320817836986624869=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v4 09/17] mptcp: Add key generation and token tree
Date: Fri, 30 Nov 2018 12:11:04 -0800
Message-ID: <20181130201112.21806-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181130201112.21806-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 862

--===============1320817836986624869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Generate the local keys, IDSN, and token when creating a new
socket. Introduce the token tree to track all tokens in use using
a radix tree with the MPTCP token itself as the index.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/net/mptcp.h  |  26 +++++
 net/mptcp/Makefile   |   2 +-
 net/mptcp/crypto.c   | 215 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  18 +++
 net/mptcp/subflow.c  |  31 +++++-
 net/mptcp/token.c    | 255 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 545 insertions(+), 2 deletions(-)
 create mode 100644 net/mptcp/crypto.c
 create mode 100644 net/mptcp/token.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ced33f1c529e..16052d0b0f3b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -41,6 +41,7 @@ struct mptcp_sock {
 	struct	inet_connection_sock sk;
 	u64	local_key;
 	u64	remote_key;
+	u32	token;
 	struct	socket *connection_list; /* @@ needs to be a list */
 	struct	socket *subflow; /* outgoing connect, listener or !mp_capable */
 };
@@ -56,6 +57,7 @@ struct subflow_sock {
 	struct	tcp_sock sk;
 	u64	local_key;
 	u64	remote_key;
+	u32	token;
 	bool	request_mptcp;	// send MP_CAPABLE
 	bool	checksum;
 	bool	version;
@@ -78,6 +80,7 @@ struct subflow_request_sock {
 		version : 4;
 	u64	local_key;
 	u64	remote_key;
+	u32	token;
 };
 =

 static inline
@@ -107,6 +110,29 @@ void mptcp_get_options(const struct sk_buff *skb,
 =

 extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
 =

+void token_init(void);
+void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
+void token_destroy_request(u32 token);
+void token_new_connect(struct sock *sk);
+void token_new_accept(struct sock *sk);
+void token_update_accept(struct sock *sk, struct sock *conn);
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
+void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
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
index 000000000000..2d3a58b1573c
--- /dev/null
+++ b/net/mptcp/crypto.c
@@ -0,0 +1,215 @@
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
+#include <asm/unaligned.h>
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
+
+	memset(workspace, 0, sizeof(workspace));
+
+	/* Initialize input with appropriate padding */
+	memset(&input[9], 0, sizeof(input) - 10); /* -10, because the last byte
+						   * is explicitly set too
+						   */
+	put_unaligned_be64(key, input);
+	input[8] =3D 0x80; /* Padding: First bit after message =3D 1 */
+	input[63] =3D 0x40; /* Padding: Length of the message =3D 64 bits */
+
+	sha_init(mptcp_hashed_key);
+	sha_transform(mptcp_hashed_key, input, workspace);
+
+	if (token)
+		*token =3D mptcp_hashed_key[0];
+	if (idsn)
+		*idsn =3D ((u64)mptcp_hashed_key[3] << 32) + mptcp_hashed_key[4];
+}
+
+void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
+		      int arg_num, ...)
+{
+	u32 workspace[SHA_WORKSPACE_WORDS];
+	u8 input[128]; /* 2 512-bit blocks */
+	int i;
+	int index;
+	int length;
+	u8 *msg;
+	va_list list;
+	u8 key_1[8];
+	u8 key_2[8];
+
+	memset(workspace, 0, sizeof(workspace));
+
+	put_unaligned_be64(key1, key_1);
+	put_unaligned_be64(key2, key_2);
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
+		hash_out[i] =3D (__force u32) cpu_to_be32(hash_out[i]);
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
+		hash_out[i] =3D (__force u32) cpu_to_be32(hash_out[i]);
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
index 9f802f69a528..2fa9031a77ca 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -111,6 +111,9 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 	if (subflow->mp_capable) {
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
+		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", msk->token);
+		token_update_accept(new_sock->sk, mp->sk);
 		msk->connection_list =3D new_sock;
 	} else {
 		msk->subflow =3D new_sock;
@@ -119,6 +122,15 @@ static struct sock *mptcp_accept(struct sock *sk, int =
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
@@ -139,6 +151,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 	if (mp_capable) {
 		msk->remote_key =3D subflow->remote_key;
 		msk->local_key =3D subflow->local_key;
+		msk->token =3D subflow->token;
+		pr_debug("token=3D%u", msk->token);
 		msk->connection_list =3D msk->subflow;
 		msk->subflow =3D NULL;
 	}
@@ -248,6 +262,7 @@ static struct proto mptcp_prot =3D {
 	.close		=3D mptcp_close,
 	.accept		=3D mptcp_accept,
 	.shutdown	=3D tcp_shutdown,
+	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
 	.hash		=3D inet_hash,
@@ -300,6 +315,9 @@ static int __init mptcp_init(void)
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
index 89fcc3b746eb..7495e259ce5d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -53,6 +53,29 @@ static int subflow_recvmsg(struct sock *sk, struct msghd=
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
+	if (subflow_req->mp_capable)
+		token_destroy_request(subflow_req->token);
+	tcp_request_sock_ops.destructor(req);
+}
+
 static void subflow_v4_init_req(struct request_sock *req,
 				const struct sock *sk_listener,
 				struct sk_buff *skb)
@@ -82,6 +105,8 @@ static void subflow_v4_init_req(struct request_sock *req,
 		    listener->checksum)
 			subflow_req->checksum =3D 1;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
+		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
+		token_new_request(req, skb);
 	} else {
 		subflow_req->mp_capable =3D 0;
 	}
@@ -147,6 +172,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
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
@@ -158,7 +186,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 const struct inet_connection_sock_af_ops subflow_specific =3D {
 	.queue_xmit	   =3D ip_queue_xmit,
 	.send_check	   =3D tcp_v4_send_check,
-	.rebuild_header	   =3D inet_sk_rebuild_header,
+	.rebuild_header	   =3D subflow_rebuild_header,
 	.sk_rx_dst_set	   =3D subflow_finish_connect,
 	.conn_request	   =3D subflow_conn_request,
 	.syn_recv_sock	   =3D subflow_syn_recv_sock,
@@ -273,6 +301,7 @@ int mptcp_subflow_init(void)
 =

 	subflow_request_sock_ops =3D tcp_request_sock_ops;
 	subflow_request_sock_ops.obj_size =3D sizeof(struct subflow_request_sock),
+	subflow_request_sock_ops.destructor =3D subflow_req_destructor;
 =

 	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
new file mode 100644
index 000000000000..473d5d15bad2
--- /dev/null
+++ b/net/mptcp/token.c
@@ -0,0 +1,255 @@
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
+#include <linux/ip.h>
+#include <net/sock.h>
+#include <net/inet_common.h>
+#include <net/protocol.h>
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
+	return (used !=3D NULL);
+}
+
+static bool find_token(u32 token)
+{
+	void *used;
+
+	pr_debug("token=3D%u", token);
+	used =3D radix_tree_lookup(&token_tree, token);
+	return (used !=3D NULL);
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
+static int insert_token(u32 token, void *conn)
+{
+	void *used =3D &token_used;
+
+	if (conn !=3D NULL)
+		used =3D conn;
+
+	pr_debug("token=3D%u, conn=3D%p", token, used);
+	return radix_tree_insert(&token_tree, token, used);
+}
+
+static void update_token(u32 token, void *conn)
+{
+	void **slot;
+
+	pr_debug("token=3D%u, conn=3D%p", token, conn);
+	slot =3D radix_tree_lookup_slot(&token_tree, token);
+	if (slot !=3D NULL) {
+		if (*slot !=3D &token_used)
+			pr_err("slot ALREADY updated!");
+		*slot =3D conn;
+	} else {
+		pr_warn("token NOT FOUND!");
+	}
+}
+
+static void destroy_req_token(u32 token)
+{
+	void *cur;
+
+	cur =3D radix_tree_delete(&token_req_tree, token);
+	if (!cur)
+		pr_warn("token NOT FOUND!");
+}
+
+static struct sock *destroy_token(u32 token)
+{
+	void *conn;
+
+	pr_debug("token=3D%u", token);
+	conn =3D radix_tree_delete(&token_tree, token);
+	if ((conn !=3D NULL) && (conn !=3D &token_used))
+		return (struct sock *) conn;
+	return NULL;
+}
+
+/* create new local key, idsn, and token for subflow_request */
+void token_new_request(struct request_sock *req,
+		       const struct sk_buff *skb)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+
+	pr_debug("subflow_req=3D%p", req);
+	while (1) {
+		new_req_token(req, skb);
+		spin_lock_bh(&token_tree_lock);
+		if (!find_req_token(subflow_req->token) &&
+		    !find_token(subflow_req->token))
+			break;
+		spin_unlock_bh(&token_tree_lock);
+	}
+	insert_req_token(subflow_req->token);
+	spin_unlock_bh(&token_tree_lock);
+}
+
+/* create new local key, idsn, and token for subflow */
+void token_new_connect(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", sk);
+
+	while (1) {
+		new_token(sk);
+		spin_lock_bh(&token_tree_lock);
+		if (!find_req_token(subflow->token) &&
+		    !find_token(subflow->token))
+			break;
+		spin_unlock_bh(&token_tree_lock);
+	}
+	insert_token(subflow->token, subflow->conn);
+	sock_hold(subflow->conn);
+	spin_unlock_bh(&token_tree_lock);
+}
+
+void token_new_accept(struct sock *sk)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", sk);
+
+	spin_lock_bh(&token_tree_lock);
+	insert_token(subflow->token, NULL);
+	spin_unlock_bh(&token_tree_lock);
+}
+
+void token_update_accept(struct sock *sk, struct sock *conn)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p, conn=3D%p", sk, conn);
+
+	spin_lock_bh(&token_tree_lock);
+	update_token(subflow->token, conn);
+	sock_hold(conn);
+	spin_unlock_bh(&token_tree_lock);
+}
+
+void token_destroy_request(u32 token)
+{
+	pr_debug("token=3D%u", token);
+
+	spin_lock_bh(&token_tree_lock);
+	destroy_req_token(token);
+	spin_unlock_bh(&token_tree_lock);
+}
+
+void token_destroy(u32 token)
+{
+	struct sock *conn;
+
+	pr_debug("token=3D%u", token);
+	spin_lock_bh(&token_tree_lock);
+	conn =3D destroy_token(token);
+	if (conn !=3D NULL)
+		sock_put(conn);
+	spin_unlock_bh(&token_tree_lock);
+}
+
+void token_init(void)
+{
+	INIT_RADIX_TREE(&token_tree, GFP_ATOMIC);
+	INIT_RADIX_TREE(&token_req_tree, GFP_ATOMIC);
+	spin_lock_init(&token_tree_lock);
+}
-- =

2.19.1


--===============1320817836986624869==--
