Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153E26CE31
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045956; cv=none; b=bBmBCwat8zo3gvZBy8ZxsRXmnxN1qtbWmX0q8D7W8cnXwPQ6Yjx6GOJddpzi+cDSJlJdvfDWlJ0vBtYIzYFjGRLhtmGPOSmKDgEx8PlnbD69wQE8ZcU7cCQX0GKgF4C4PKf8qYjdjz3hu3/7gu79MQfshEBFbVf1nlWhHp/1sLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045956; c=relaxed/simple;
	bh=DiAXIpVjhSZ+RvlYXOF3cPsZn4SUz/v2DfoI59ns5rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxylk9eIKPQlXJFL4A+BL7kc4Falp6TLp/JjGZkE/dx5th+HaZme05oqUKMqT/GYfzw+edMsaVPdcs3KdNX4nx4nN40OQuGSxePcBc2k3RZd5Xx+irafsO7slVT60jkEoV3NQ5ewdzHFeAKlrIVRxOmyRT/wiswDWTux/q6auGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upPAWz3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upPAWz3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A44EC4CEF1;
	Wed,  9 Jul 2025 07:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045955;
	bh=DiAXIpVjhSZ+RvlYXOF3cPsZn4SUz/v2DfoI59ns5rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upPAWz3bAZI6GEgKkA5MCJLDrDJiboT7/XQhsUsM0GIqXqqELZB7jkZIXSfXDfohi
	 nME7kH361cLpFy5a9dBX6zeayhgyQvStKl3k7atPDeGtq/esAj9GJDnY1cNArr9EvO
	 S4gLzGlfBMsGhbOYO8qp3+cjW19hdeGNoEumtgg/NhFA7sUGestBpArWndmwwxFxF2
	 Mjl9XQvM4WsPbF5GoimW2czGDUCc7YC3O8zdY8ShDBdIiWDnqvDu4AgUGV7OOXc/7l
	 jY5G0+FgVB5jkeJZeLSiV65BeCQXobg5LHq6Gu45KJpyVhJHgg1Y1u/NFMzCd8YLWD
	 KHKEliHBT8aQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 3/7] tcp: export tcp_splice_state
Date: Wed,  9 Jul 2025 15:25:30 +0800
Message-ID: <d6e0af387267133607241ad865c1a7752daf2adf.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
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
 include/net/tcp.h | 12 ++++++++++++
 net/ipv4/tcp.c    | 13 ++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bc08de49805c..338b97a91278 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -258,6 +258,18 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
  */
 #define	TFO_SERVER_WO_SOCKOPT1	0x400
 
+/*
+ * TCP splice context
+ */
+struct tcp_splice_state {
+	struct pipe_inode_info *pipe;
+	size_t len;
+	unsigned int flags;
+};
+
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len);
+
 
 /* sysctl variables for tcp */
 extern int sysctl_tcp_max_orphans;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8637dfce8c4a..505c3a123e2d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -316,15 +316,6 @@ EXPORT_SYMBOL(tcp_have_smc);
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
@@ -757,8 +748,8 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
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
2.48.1

