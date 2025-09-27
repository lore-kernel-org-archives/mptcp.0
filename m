Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8B27A900
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976302; cv=none; b=JBNnbu5Q5JkU11oHlf9rk4Nx6zhX2VjInJTTZ/jnwH/Jn1zAZQcOxyrK/96AwjJvCBt5yKbqd8oPy6IuL3zBqpZIvgMgBAszxzoEYnuI7jBp5m+VqYhrZb/zglCBub2GreBQAf/e/UcHbAJ3d+6GFejL/3mztl3SBpfSJtzMrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976302; c=relaxed/simple;
	bh=Gf/1GGWFVT75sh9k240f+4uEhi0FRKi36OKzPuA+VC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxwYCvzoKvUvfpJiqdlb8Fkm5ELeLyDWWb9RntHmvJeizuXkxjkbkx7wInuCxCQu4iDEmwugxX5lNMLlT+tUtxdg9FedvHNfX0TZe7VdKoVXQl3NhntK4dsW69RQInJYI3qwjbRq0wnXtJYf417/OWO5a/R13WPiGb56T6l0D1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqmftGnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqmftGnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566EFC113CF;
	Sat, 27 Sep 2025 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976300;
	bh=Gf/1GGWFVT75sh9k240f+4uEhi0FRKi36OKzPuA+VC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqmftGnIjnz95BhVDiRAaFXC2H9Gmvo5Dn3wc4Kl3DRiLLFim96aYT/fiSlrIeMXW
	 nc1DWkV3TUXZvNvj8u6lxVsiQgsjSJhaty1vzdRudvjldhNUdTxNpMgWuNz4pf9B5/
	 UX4EZdkkXPJEljIaLn5IWFNQm3Cu05oBC6dvOe9+JPQjMqTPTfyKzKxK6GJiJ1NzEd
	 cow5r+75osNvmlkieJaHZYDPRovcdt9HYfuBqhJkttSUUnxjIpdeB4wlUZvN3m5HTD
	 38UFN9BlEO4H06pI3ezOcwSfdGAdE9j32KhjX7h3C6tiDmgiRhPSjKPp8UgmtCvunT
	 39L+x8dFRECEg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v12 3/8] tcp: export splice_state and splice_data_recv
Date: Sat, 27 Sep 2025 20:30:20 +0800
Message-ID: <41ca62e786b275e637c19ff260d71a1ec2f43d8c.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
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
index 5ca230ed526a..402017e8367e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -282,6 +282,18 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
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
index 15602793e4a9..bfad7ccf6bad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -319,15 +319,6 @@ EXPORT_SYMBOL(tcp_have_smc);
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
@@ -777,8 +768,8 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
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

