Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664792F5316
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975590; cv=none; b=X8BRW230oh1ZtUw6HaZrhbFIIrIjK3U3RnmYgBkGUm1gDdpqwhRL8AksWtntMkEW+efpyowCap/XjTlMBbanD2VikLQY1dbHWTMyUYmsB3U/0LGLr/lzjMYHM6JUbelVZl5VnaGeSflEWs+mZA5/GzKj38/FqTmJGgiNahEg2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975590; c=relaxed/simple;
	bh=hHvG0ace6qZUfNg2igScH2dfB5idZl8Bvpz868+5SJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMSw7okTDbsG0lDfPACVAOFqrZWtTUsOPc5+iNN9vhD/5sDB8tuoFO0WFeaICtyRn6WW0+zFZpsxNMFiBZYbtaowWdbQjYTLiciBxaVyQAc55GO+TWIi1541tz/vqxhBWVuCNnAzNCpCqhXdp8/SMV/ZYW4pQhCw1nwXiElGOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK6j3QZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK6j3QZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0184C19422;
	Mon, 24 Nov 2025 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975590;
	bh=hHvG0ace6qZUfNg2igScH2dfB5idZl8Bvpz868+5SJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK6j3QZdOJoLTpaICbvuZXuQV9VINayoXVZ867KQ9nHQQT7/79dP9NkUD5ZEvvqf8
	 bWS/QuninjmnoUocNbGOo9dEanC/CLp4/t1/zUQSjP/OUsIkcrUgpwmq0Bz9KxzQwv
	 Rrk2UIrBmxxmM86kXRZMfeLRb+4CyYUHuj9nw5t5Yt7EVSOKEM+EEZT9U44Cjw+J3k
	 Siw1F4JeX5Jjt0tvZ0PfQvj6GduSbQRyOKpMqV2iI5jsdVDHwEPRnznmFSYJ19LCaW
	 HWb23/jgTEJq4jzbAoqZyBVZVk8rivL7uL/XHTRMocIjlanRwDAKHz89XhJ77r/9fx
	 0fLE1oND5Hp5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v14 5/8] tcp: export tcp_splice_state
Date: Mon, 24 Nov 2025 17:12:50 +0800
Message-ID: <11a1c9d041698169f45cf9a1e065ad0d2d4799af.1763974740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h so
that they can be used by MPTCP.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h | 11 +++++++++++
 net/ipv4/tcp.c    | 13 ++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 94a50a9daf65..a5a30b65e0ed 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -347,6 +347,15 @@ extern struct proto tcp_prot;
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
+/*
+ * TCP splice context
+ */
+struct tcp_splice_state {
+	struct pipe_inode_info *pipe;
+	size_t len;
+	unsigned int flags;
+};
+
 void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
@@ -378,6 +387,8 @@ void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
 void tcp_twsk_purge(struct list_head *net_exit_list);
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len);
 ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8b4917a7f262..c96f8fdf271a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -318,15 +318,6 @@ EXPORT_SYMBOL(tcp_have_smc);
 struct percpu_counter tcp_sockets_allocated ____cacheline_aligned_in_smp;
 EXPORT_IPV6_MOD(tcp_sockets_allocated);
 
-/*
- * TCP splice context
- */
-struct tcp_splice_state {
-	struct pipe_inode_info *pipe;
-	size_t len;
-	unsigned int flags;
-};
-
 /*
  * Pressure flag: try to collapse.
  * Technical note: it is used by multiple contexts non atomically.
@@ -775,8 +766,8 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 	__tcp_push_pending_frames(sk, mss_now, nonagle);
 }
 
-static int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
-				unsigned int offset, size_t len)
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len)
 {
 	struct tcp_splice_state *tss = rd_desc->arg.data;
 	int ret;
-- 
2.43.0

