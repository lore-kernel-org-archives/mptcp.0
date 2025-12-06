Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D8DDC5
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024474; cv=none; b=DfowdeRL07odiZRi3/4Hkczl56VWH/x0fO88A6fAtPC4xxnEYZ18Ou7uabx9kQEuzIGRXhSFtuYw49loBpYGC9Foxj2EM8A9GKoomvrQIMukCTRqGRmbFtE+wtT+yhWs5h1edRL9XETZTDbXdCZJWpptapDksbFt2kFYbjcB0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024474; c=relaxed/simple;
	bh=lV56axlPXMe1LcP0B5FRqRW0KYzq5Ep3zPi9Lsr+CfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiKitOZf8yRkV2zEgOyfj2WJy2Yp7D+is8ulb2N/Fc235KCc466GMXhjrxWE6aPXtEi9EzXTSZR35T/9weG3VeQ4ODegVSUbtK7nM6QY/w1XlnyHnKJynl/3s3S5xMuSWMCOw2/u4b6r5O6SVULzMEC3XzSvm8giCUqTxR4UfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8OQ+Vo7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8OQ+Vo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E9AC4CEF5;
	Sat,  6 Dec 2025 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765024474;
	bh=lV56axlPXMe1LcP0B5FRqRW0KYzq5Ep3zPi9Lsr+CfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8OQ+Vo7gFdISBO0uHopQZs/sx5gUjCeeDk/4nvsnIDn+In6wuZBPqJzf5YozXr4a
	 KHC6Tm7/41CoAaR6AMEyCSNZLAn2KT1ewm9yKVuOnCHR2qTRd/bzuREdyg6wEZ6GGn
	 csFehLEgU9s4wWGZvvhp3XULZJeVqbhE1ya3cJlB9M3a9lUYUNwBlLkD8UrlyWWC1T
	 S3W3YPlLG6Q+4opWEz4jYCEWVv7ahPIQ6laeyP2O7CZUv7rRrura7kL6lfAEdL4kMB
	 5QaKkSCcW6FkTgQzhrybPVxzqeiokiKYZ2KgqILOtLrUh4CIiz7CaULMg0wXXNzqKQ
	 4V+DvzYpHXcxw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v15 3/6] tcp: export tcp_splice_state
Date: Sat,  6 Dec 2025 20:33:53 +0800
Message-ID: <83d5d4fe500cf589dca5b4318ed3e6985ed34f28.1765023923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
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
index 0deb5e9dd911..f5f6119f7716 100644
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
index 313c7cf208d8..40ad9656dc9e 100644
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
2.51.0

