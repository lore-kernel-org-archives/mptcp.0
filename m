Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6870264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971585; cv=none; b=NQEMGRJyYT411J0Uv01SFe9pULcpIEwN/LBOBtRlai9l4upvU4ukCnAW3odAtf/G++1WdkmFYUykW/BRhpAgPMzJ8TTTuf5rl8laRU/gvEQz8pd8i6lS4xzAseAhqLne3g5aLBLreMsLf7RpF+MvCM2/xkWknLKtPgMUCgaVJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971585; c=relaxed/simple;
	bh=/pq1WdxxypAZu/C6uuEQi6NIle31JSl/Gv1O0Qrep0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhgyH3M65ZNDz8gSenKFAzzmcYacB5uVDXaMIIv1t7yHR2QxCjgkV8NfYbmP5jxzG9vD8/hvxzVDt6ZCYWjpG4kSKa9JiPS0Gl/sg1F/Juy7UNtzuKUMjZSIcAUrL6jlnBvXl01f0HSqpOjRW5M5hLN9gHSpEVdGptOgLk0F0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js4cFae1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js4cFae1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D731F00893;
	Tue,  9 Jun 2026 02:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971583;
	bh=B5UkfWUF15ELwxSd5uOLYRa3qnSRpb3EQaVvgNcwXR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Js4cFae18uFlMIyebewAB/VNXG1sHJInzS7sWkXnYpMFKDP/qkh7yDyw3ZNRZlG7C
	 E9XE1s4v4zLeAqzzC3XVD+S1gOYdMCSVszm6qLWc7T6OdOV/Kfn7qHSlkCWIzVRm8n
	 O8JEdRM1LXHwhnaQdnyNNBVZ9mNG21IvbBtosXFFi0PkbH4e1C5EAFYUs18ZM1IBuo
	 5pjxUYqiApEhYweEWUPj8zZDDvUdAtR8VSx3Vr9HNLQ25QT104b5PNt29Gxjy117mC
	 SiVj4wtBf0PEdsnOlc/1O+6uwSdIcl8uiTAwNiHiAPfHeaMegBibPC/PoyrOpOBi8w
	 wM4YRDVPpLq8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 10/22] mptcp: implement mptcp-specific tls protocol ops
Date: Tue,  9 Jun 2026 10:18:36 +0800
Message-ID: <a9a07e63e591b620429acdc785826e158dec0bc8.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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

Passing an MPTCP socket to tcp_sock_rate_check_app_limited() can
trigger a crash. Here, an MPTCP version of check_app_limited() is
implemented, which calls tcp_sock_rate_check_app_limited() for each
subflow.

When MPTCP implements lock_is_held interface, it not only checks
sock_owned_by_user_nocheck(sk) as TCP does, but also needs to check
whether the MPTCP data lock is held. This is required because TLS
may call lock_is_held from softirq context with bh_lock_sock held.
Checking both conditions ensures TLS always defers to workqueue when
the MPTCP data lock is held, avoiding deadlock.

Implement mptcp_skb_get_header() to handle fragmented MPTCP skbs when
copying TLS record headers.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |   2 +
 include/net/tcp.h    |   1 +
 net/ipv4/tcp.c       |   9 +++-
 net/mptcp/protocol.c | 113 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |   1 +
 net/tls/tls_main.c   |  13 +++++
 6 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 333bde2a0b76..ba2257986b13 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,8 @@ struct mptcp_pm_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+extern struct tls_prot_ops tls_mptcp_ops;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f063eccbbba3..1c8201f69ef1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -849,6 +849,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a058f350a759..bdad459e6605 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1097,9 +1097,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 }
 
 /* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
+void tcp_sock_rate_check_app_limited(struct tcp_sock *tp)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
+	struct sock *sk = (struct sock *)tp;
 
 	if (/* We have less than one packet to send. */
 	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
@@ -1112,6 +1112,11 @@ void tcp_rate_check_app_limited(struct sock *sk)
 		tp->app_limited =
 			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
 }
+
+void tcp_rate_check_app_limited(struct sock *sk)
+{
+	tcp_sock_rate_check_app_limited(tcp_sk(sk));
+}
 EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 18c8b6c64c3f..f4cd7a6e5770 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,6 +24,7 @@
 #include <net/mptcp.h>
 #include <net/hotdata.h>
 #include <net/xfrm.h>
+#include <net/tls.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
@@ -4894,3 +4895,115 @@ int __init mptcp_proto_v6_init(void)
 	return err;
 }
 #endif
+
+static bool mptcp_lock_is_held(struct sock *sk)
+{
+	return sock_owned_by_user_nocheck(sk) ||
+	       mptcp_data_is_locked(sk);
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
+static u32 mptcp_get_skb_seq(struct sk_buff *skb)
+{
+	return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
+}
+
+static int mptcp_skb_get_header(const struct sk_buff *skb, int off,
+				void *buf, int len)
+{
+	const struct sk_buff *iter = skb_shinfo(skb)->frag_list;
+	int copied = 0;
+	int ret = 0;
+
+	if (!iter)
+		return skb_copy_bits(skb, off, buf, len);
+
+	/* Make absolute to positive */
+	off -= MPTCP_SKB_CB(iter)->offset;
+
+	while (iter && copied < len) {
+		int skb_off  = MPTCP_SKB_CB(iter)->offset;
+		int data_len = iter->len - skb_off;
+		int count;
+
+		if (off >= data_len) {
+			off -= data_len; /* MPTCP skb avail data */
+			iter = iter->next;
+			continue;
+		}
+
+		count = min((int)(data_len - off), len - copied);
+		ret = skb_copy_bits(iter, skb_off + off, buf + copied, count);
+		if (ret)
+			break;
+		copied += count;
+		off = 0;
+		iter = iter->next;
+	}
+
+	if (copied < len && !ret)
+		ret = -EFAULT;
+	return ret;
+}
+
+static void mptcp_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
+struct tls_prot_ops tls_mptcp_ops = {
+	.owner			= THIS_MODULE,
+	.protocol		= IPPROTO_MPTCP,
+	.recv_skb		= mptcp_recv_skb,
+	.lock_is_held		= mptcp_lock_is_held,
+	.read_done		= mptcp_read_done,
+	.get_skb_seq		= mptcp_get_skb_seq,
+	.skb_get_header		= mptcp_skb_get_header,
+	.epollin_ready		= mptcp_epollin_ready,
+	.check_app_limited	= mptcp_check_app_limited,
+};
+EXPORT_SYMBOL(tls_mptcp_ops);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..6dea626348d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -380,6 +380,7 @@ struct mptcp_sock {
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
 #define mptcp_data_unlock(sk) spin_unlock_bh(&(sk)->sk_lock.slock)
+#define mptcp_data_is_locked(sk) spin_is_locked(&(sk)->sk_lock.slock)
 
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fa7727881e74..14a8f5e0ed01 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1423,6 +1423,12 @@ static int __init tls_register(void)
 	if (err)
 		goto err_strp;
 
+#ifdef CONFIG_MPTCP
+	err = tls_register_prot_ops(&tls_mptcp_ops);
+	if (err)
+		goto err_tcp;
+#endif
+
 	err = tls_device_init();
 	if (err)
 		goto err_ops;
@@ -1431,6 +1437,10 @@ static int __init tls_register(void)
 
 	return 0;
 err_ops:
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+err_tcp:
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 err_strp:
 	tls_strp_dev_exit();
@@ -1442,6 +1452,9 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+#ifdef CONFIG_MPTCP
+	tls_unregister_prot_ops(&tls_mptcp_ops);
+#endif
 	tls_unregister_prot_ops(&tls_tcp_ops);
 	tls_prot_cleanup();
 	tls_strp_dev_exit();
-- 
2.43.0

