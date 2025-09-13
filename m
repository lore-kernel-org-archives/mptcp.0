Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAE11185
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723950; cv=none; b=OL4PaxQ0O2Utf23G2ulhxk7U5roZO9MQM6MgI+ITqb2y0SyyEMBf0Obxfjlkok75TRSYlWTxm5DtBQwFKv8jT4Fhty1Xjke/aGRVIRFJiI1pDLMTqzrow/RFlo2ujZbwTuJQ1ooR5H93LnwdIiXh+9/SsmjR65brzMj93BgP2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723950; c=relaxed/simple;
	bh=OGcTCBKq3im1Sr97t2AUNmxwsssfLDlmVA/h4Q2X/2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkdkB614UdlbV82zCasLiJ7IgmKINZC+Qdb6t+SnMJMEAZ0FpBh82uVApcUKecdw83uMwv42CEevuA/EL2RAWLy7ULGxaEW1qVFR/znsdvH5BjnWLNvFuZfzE6JATd3DvIaBm833P6ANCq2IvoozALQ/O7tTAXTwkQjlonSbfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+dAVGWd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+dAVGWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E49BC4CEF1;
	Sat, 13 Sep 2025 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723949;
	bh=OGcTCBKq3im1Sr97t2AUNmxwsssfLDlmVA/h4Q2X/2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+dAVGWd2QMa5StcNlet0fd00BiSHt4asSYod8QzjYIiZ1PpVaOve4OJMRPgJwEeZ
	 sBxOB2Fg3htg0dKKjdyxAsXMKpWQQV2FappM3DbF8lTqVrmc5Yug5vj9CyMYtifSau
	 pzYKGIa9aiH7FK93jSW4yCCXyuLeMXFYMs9flWkK5f+8qbwJAsh2B94OUmV2fdhO1J
	 i0LJG9rMJrqY3mCl03o1UxOyQcLP4Wkf9XURKgRmppdhr05vUNlzRtXdamSIXRyjml
	 l9xOiy6KCFFYyCI3AYpthdP0EuQA9bJrpsU+KF14Udz2zuLqvsvD9aSKD4Cn2nCusd
	 FgL9Vk6gOP/sQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v11 3/8] tcp: export splice_state and splice_data_recv
Date: Sat, 13 Sep 2025 08:37:22 +0800
Message-ID: <a42aad67f1ca6ab64180ba8807a6f11cda686091.1757723270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
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
index 277914c4d067..b071dad4c5e0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -268,6 +268,18 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
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
index d9ec2207bad9..03b75b3f676e 100644
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
@@ -773,8 +764,8 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
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

