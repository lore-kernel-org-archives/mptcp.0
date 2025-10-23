Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3921B191
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199030; cv=none; b=HVSMnmQ8E32UHs0sxnEY76wh9YuPbG7F0K/pqWMez3qegeu7nsfWfjKe5h1hB07zeSZuaTJ3ngSak5xxWNbcr/qnHYUmmr+dXacSB0BqAz/rwCNs5R+qzJOvn93DXwDkxPCInbUdv96B8W4lmjlVUKkCExjOIdr5VSIETDrTYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199030; c=relaxed/simple;
	bh=05BULzRiW7apYMuz0MjN22qZsOUPN0LFtqDcXSMcOeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVqJv3ujMaguXxJ2husyTH+eOxlIgWFMsqT6QvPbaL7xmEeOHmU3mTrU2DM7ay/RqsVsRouv458XIuj9vLp6jw+JFldGGOITdfE+IyBzNPhSrb0mwdFmVQHnpOlpdvihP5LXlBB0e8uJsLU8IdP98UP2TbQRQ/N/dMsaWOYxIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi1VYPcj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi1VYPcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB225C4CEFB;
	Thu, 23 Oct 2025 05:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199030;
	bh=05BULzRiW7apYMuz0MjN22qZsOUPN0LFtqDcXSMcOeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hi1VYPcjy816KDHAk6VJ4BP09UG5mATxDCHVpAHYEib0FEV+EAtgdqLeGtvSsYzH2
	 g0oI5wW8N4CQAdG2jkkUlm1DQpb083S8T+S0gobTbdaWS3txbHd+yTEgpdqmSQC5SD
	 W+3uTAnXgMq8oZEDBL6PXyr3M57v713jfEBl+Q83saaUOMGT0jjB8b8E4yBZ3M9BNB
	 42u+AqtN7dD+ItbA4dxxt3Y5LPpIHa+9JHpE4AopEfH281HUbLK3P8IrNcXc8GzLyk
	 Ig50KqFgCVRJpPwplgeH9Ly0h/Jr7xzpHVmYXgljYDbavqzd2DM0JkX4BOUV/GL25N
	 WmaXSsh1NmzeQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v13 5/8] tcp: export tcp_splice_state
Date: Thu, 23 Oct 2025 13:56:48 +0800
Message-ID: <b7d3cf617729eb75f0c669cf4bc771d251a8087e.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Export struct tcp_splice_state into net/tcp.h so that it can be used
by MPTCP.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h | 9 +++++++++
 net/ipv4/tcp.c    | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4492397a5377..b54227ba79ce 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2958,4 +2958,13 @@ static inline int tcp_recv_should_stop(struct sock *sk, long timeo)
 	return 0;
 }
 
+/*
+ * TCP splice context
+ */
+struct tcp_splice_state {
+	struct pipe_inode_info *pipe;
+	size_t len;
+	unsigned int flags;
+};
+
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c5653daa2201..27786bebb101 100644
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
-- 
2.43.0

