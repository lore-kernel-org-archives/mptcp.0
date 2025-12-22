Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E882F851
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373339; cv=none; b=j75FOVu4ZB0LKm5amK1r/iQ7fJfmVzij161w7zvdl4QSzLVrNqM1o4hDDmybFQASLQpbin2pLyCjq1aL2qME/oOSpZm51jM+15jhnSTIC/BRq7KsvFgj8XAmI6ReJBeST3nklfdnbVh/LngJrsYrdU3jgwtOv9mc71juxWVJonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373339; c=relaxed/simple;
	bh=RnTxOPxflhqIwx21FLa4JuJOQjgjfd+tsn0wRFmwemI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ6Zm/qIIOrELgR6dEjgwJu0SBGNoW43GoMagQNx62bkCLbuhn5iWMiFgpM5ZVAK8usuYfrl1zc5cg44j6ic/EFXO5z1qWX9zQNzkdZrQM5PnxV+U9DO1jiJ1pYs4Kw2srQRIrRy+KFDRq2xjhxAWC3Jv9aZ3cKGxbDbDkjKfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+ytlXNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+ytlXNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD39C4CEFB;
	Mon, 22 Dec 2025 03:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373338;
	bh=RnTxOPxflhqIwx21FLa4JuJOQjgjfd+tsn0wRFmwemI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+ytlXNVE9l+3ySmUbQVj4sA3qLPTJE1V6iRKeGOQn1R4ItalZnsy+ITtLNz+l5QX
	 Rfx2bsRTYQxr8Egb6vtmFwWsqxRxjKZh2QKb8jGWiQlFtb3IKWhDB60nMxtRJZioMD
	 4urXUg34EHWBWWUsdSmAdooQgvUmTFQgx3eNohn26pIrJLC6rP8r6MBSLhpsYnK5Tf
	 XeYRRB3Ax9xhVMWLhRK0Uqxs/zCbYVEjBJCi3HeKJHk89IQP59ITgeAeREsLM6vEsY
	 qmoOx6WKAxmCX9OJtJfOohBJ0wsXSIkGtpdUxFeddm2bTNFQhrQWUa5Fa3kL7O6tZU
	 3bbygPaCGckCQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 2/8] mptcp: implement tls_mptcp_ops
Date: Mon, 22 Dec 2025 11:15:21 +0800
Message-ID: <7ae87a2beaae790f9d4d633f04baa00118c88517.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements the MPTCP-specific struct tls_prot_ops, named
'tls_mptcp_ops'.

Note that there is a slight difference between mptcp_inq() and
mptcp_inq_hint(), it does not return 1 when the socket is closed or
shut down; instead, it returns 0. Otherwise, it would break the
condition "inq < 1" in tls_strp_read_sock().

A direct call to mptcp_read_sock() could lead to a deadlock, as
'read_sock' interface of TLS might be invoked from within a softirq
context. In such a scenario, lock_sock_fast(), which is called by
mptcp_rcv_space_adjust() or mptcp_cleanup_rbuf(), would cause the
deadlocks. To resolve it, use in_softirq() to determine whether to
call mptcp_read_sock() or mptcp_read_sock_noack().

Also introduces a sk_is_msk() helper modeled after sk_is_tcp() to
determine whether the socket is an MPTCP one. Unlike sk_is_mptcp(),
which accepts a subflow socket as its parameter, this new helper
specifically accepts an MPTCP socket parameter.

In do_tls_setsockopt_conf, the sk_is_mptcp helper is used to determine
the socket type, selecting either 'tls_mptcp_ops' or 'tls_tcp_ops'
accordingly.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 12 ++++++
 include/net/tls.h    |  2 +
 net/mptcp/protocol.c | 99 +++++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_main.c   |  2 +
 4 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..82660374859a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
 }
 
+static inline bool sk_is_msk(const struct sock *sk)
+{
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_STREAM &&
+	       sk->sk_protocol == IPPROTO_MPTCP;
+}
+
 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
@@ -258,6 +265,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
+static inline bool sk_is_msk(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 				     unsigned int *size,
 				     struct mptcp_out_options *opts)
diff --git a/include/net/tls.h b/include/net/tls.h
index 985ac326d59c..71c0399e6a43 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -261,6 +261,8 @@ static const struct tls_prot_ops tls_tcp_ops = {
 	.epollin_ready	= tcp_epollin_ready,
 };
 
+extern const struct tls_prot_ops tls_mptcp_ops;
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..bdf53e4b3f7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,11 +24,12 @@
 #include <net/mptcp.h>
 #include <net/hotdata.h>
 #include <net/xfrm.h>
+#include <net/tls.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
 
-static unsigned int mptcp_inq_hint(const struct sock *sk);
+static unsigned int mptcp_inq_hint(struct sock *sk);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -1884,7 +1885,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1895,8 +1896,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2004,7 +2003,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2015,6 +2013,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
@@ -2242,7 +2251,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static int mptcp_inq(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
@@ -2257,6 +2266,16 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 		return (unsigned int)hint_val;
 	}
 
+	return 0;
+}
+
+static unsigned int mptcp_inq_hint(struct sock *sk)
+{
+	unsigned int inq = mptcp_inq(sk);
+
+	if (inq)
+		return inq;
+
 	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
 		return 1;
 
@@ -4674,4 +4693,72 @@ int __init mptcp_proto_v6_init(void)
 
 	return err;
 }
+
+static struct sk_buff *mptcp_recv_skb_tls(struct sock *sk, u32 seq, u32 *off)
+{
+	return mptcp_recv_skb(sk, off);
+}
+
+static void mptcp_read_done(struct sock *sk, size_t len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	size_t left;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return;
+
+	left = len;
+	while (left && (skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		int used;
+
+		used = min_t(size_t, skb->len - offset, left);
+		msk->bytes_consumed += used;
+		MPTCP_SKB_CB(skb)->offset += used;
+		MPTCP_SKB_CB(skb)->map_seq += used;
+		left -= used;
+
+		if (skb->len > offset + used)
+			break;
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	mptcp_rcv_space_adjust(msk, len - left);
+
+	/* Clean up data we have read: This will do ACK frames. */
+	if (left != len)
+		mptcp_cleanup_rbuf(msk, len - left);
+}
+
+static u32 mptcp_get_seq(struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->map_seq;
+}
+
+static int mptcp_read_sock_tls(struct sock *sk, read_descriptor_t *desc,
+			       sk_read_actor_t recv_actor)
+{
+	return __mptcp_read_sock(sk, desc, recv_actor, in_softirq());
+}
+
+static bool mptcp_epollin_ready_tls(const struct sock *sk, int target)
+{
+	return mptcp_epollin_ready(sk);
+}
+
+const struct tls_prot_ops tls_mptcp_ops = {
+	.name		= "mptcp",
+	.inq		= mptcp_inq,
+	.sendmsg_locked	= mptcp_sendmsg_locked,
+	.recv_skb	= mptcp_recv_skb_tls,
+	.read_done	= mptcp_read_done,
+	.get_seq	= mptcp_get_seq,
+	.read_sock	= mptcp_read_sock_tls,
+	.poll		= mptcp_poll,
+	.epollin_ready	= mptcp_epollin_ready_tls,
+};
 #endif
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 20f7eb438771..7c69bef4f51d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -762,6 +762,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 
 	if (sk_is_tcp(sk))
 		ctx->ops = &tls_tcp_ops;
+	else if (sk_is_msk(sk))
+		ctx->ops = &tls_mptcp_ops;
 
 	if (!tls_validate_prot_ops(ctx->ops))
 		return -EINVAL;
-- 
2.51.0

