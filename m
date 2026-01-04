Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A622F772
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519323; cv=none; b=UkbXSxvLz/Mnnfi7cM1N7mhWjnItLRBy4JMEEx/MXrYNl8vI4ZRHsx+upsOwQhsjuowlkEzPW19n3Zkp76NE5uirfMNoVPXNMzD9SFHuRWdTbnwzp25wCn9eZbXSq+6/qdJywnfdxPRA6+okzq6NSpp202m69tfdyYpeKhugwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519323; c=relaxed/simple;
	bh=HDha1aQuEeCE82OTJoPfDYOH05vj8RQ+G+8XoobS5G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpR7AtJiLIH16o2BHcDQaDKCMWz4PpR6gdwPATJrmXl8WORQZpqLFrBaD0IPOW3G3C45YsKCRq8AH8ESH4vtKLJLdgm3xfX53Gn4vkiHZ1m3Vig1VU3Kri3d2/xmBPtj174AW9OU6kE9UI8raLOoG8GtkpRWVKuI0zwn+H2AtXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv/Fdor+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv/Fdor+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C7DC116C6;
	Sun,  4 Jan 2026 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519322;
	bh=HDha1aQuEeCE82OTJoPfDYOH05vj8RQ+G+8XoobS5G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sv/Fdor+UptAyjuxX2Tw/xbURxJ3pAqK3A36VB6vw5w71bYA7FWyv249F9WTiASvF
	 ldNLa7kPANfoNQM3YQXlGrVgzlPBXGB0iiSyAfYHnhBxO3nfNCm8KFz2txEgNJnsGJ
	 x2wWT25u5vhdIGVdaBCvm0h9U/e5AVYiSUDNWoBW5QXcHwWncWVfRrZjRb3NGgJZAf
	 TFcRQBQqDs/OGsoMPOdR+nlSbsa8oWMiCY+1axLXlWh+eNy+C2bnKOE2tsG/2sZZ1i
	 IwGsBXWjh2kcuBq2ulFBIbGbFlUA/fSLrujLKrX6pQ2bKy8PKDii4JSH+NeZp2oiUp
	 5T4vUmImkiJRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 03/10] mptcp: implement tls_mptcp_ops
Date: Sun,  4 Jan 2026 17:35:04 +0800
Message-ID: <a1a996887345314b95c487db3e334b0757c7596a.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 100 ++++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_main.c   |   7 +++
 2 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 900f26e21acd..da24e7b89637 100644
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
 
@@ -4675,3 +4694,72 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
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
+struct tls_prot_ops tls_mptcp_ops = {
+	.protocol	= IPPROTO_MPTCP,
+	.inq		= mptcp_inq,
+	.sendmsg_locked	= mptcp_sendmsg_locked,
+	.recv_skb	= mptcp_recv_skb_tls,
+	.read_done	= mptcp_read_done,
+	.get_seq	= mptcp_get_seq,
+	.read_sock	= mptcp_read_sock_tls,
+	.poll		= mptcp_poll,
+	.epollin_ready	= mptcp_epollin_ready_tls,
+};
+EXPORT_SYMBOL(tls_mptcp_ops);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 5d58351e2a03..db3c9ffabd76 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1117,6 +1117,10 @@ static struct tls_prot_ops tls_tcp_ops = {
 	.epollin_ready	= tcp_epollin_ready,
 };
 
+#ifdef CONFIG_MPTCP
+extern struct tls_prot_ops tls_mptcp_ops;
+#endif
+
 static int tls_init(struct sock *sk)
 {
 	struct tls_context *ctx;
@@ -1125,6 +1129,9 @@ static int tls_init(struct sock *sk)
 	tls_build_proto(sk);
 
 	tls_register_prot_ops(&tls_tcp_ops);
+#ifdef CONFIG_MPTCP
+	tls_register_prot_ops(&tls_mptcp_ops);
+#endif
 
 #ifdef CONFIG_TLS_TOE
 	if (tls_toe_bypass(sk))
-- 
2.51.0

