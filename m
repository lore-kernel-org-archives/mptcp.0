Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02181DF26B
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399840; cv=none; b=eSZlUpt5n+XPboBoX4OQEUlBwKaG6Wkn5CkovGR5PzH/lCFXBanhUqaBvT7J34THkMWOT5ZKeXWv8mVekcniIumlSYOXXIFMBJwXodjXfH7YHwBxIEhcviWTUudu9X5ndQqAVpdry6lCEbdvXTI3TIVTADvKrNJTOqqiNNZ2fCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399840; c=relaxed/simple;
	bh=A+AWwBWTxht1ZZgtIKeQmVyErtyqPvb5QBqgQ5ist0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpWI9+HNYko6VRVdn+a1pYM4M++0FmQ4LAsoP0bewmRuJbLytANrC3kRagxVKAbC/LJwwA6+Or6nxdJJOpUXnHeCo8VvdQc3W4D2sqY/v75V0iX4fBD2/5IMo9/jvZZ4AliMAb5wnS7U+zUR+NVLhByGS294k2tTL9qpJxiWAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuGAmtMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuGAmtMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BDDC4CEE3;
	Sun, 13 Jul 2025 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399840;
	bh=A+AWwBWTxht1ZZgtIKeQmVyErtyqPvb5QBqgQ5ist0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuGAmtMKWVfXubnUXj75k9oi9ZooTPRgTD4nwsn/XjvETMzwAkS/emmom478qWEsC
	 dr0eYDXySR4O56wLez5XKw1fkDaXnGjXglf4Gg1UKAlQ6q1yWQFm3Vxyhh2NkoURxt
	 6ow4jXoKmUCZXPSazBWt4xcdzG5Y8VIlDGS+Wl5qWsOJ/Oq6XYoPNveBbK03XMd5Ne
	 dgoJRTF7tA6CqRP/ChR2KuloqEx8D+jhr+0qo5mQm72E6Q1wgN/JBA9jYe2iAPq7ky
	 k9KB6KFzCaSzZv5SCkiRSHLJS1LHy5hMgRuJ7z1fmeFTGpjO7YbT2mwzmlFmGY8x6j
	 GcyQNRKr2xPzQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v9 4/9] tcp: export splice_state and splice_data_recv
Date: Sun, 13 Jul 2025 17:43:44 +0800
Message-ID: <205dd08e07f29a6a7957112736ed0b7e32eba647.1752399660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
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
index c81866ec4333..a9af4677051e 100644
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

