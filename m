Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571D1DD525
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780517; cv=none; b=KSSIELvCp/Fqb+xUFkdXUXuSG8x/Vx81cfC8EHtA0h9gqBVbyx1UksBrZOMzR4ALT6fZOHrVtCZu7fX+jHnSpCagl+aE9mTNDYTTbhzbeWBMIGxCwlo59622mQMxjswp3pdzaEl0x/MMbnJG6WrhKrS/x3mulYXd1w+mwxM23gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780517; c=relaxed/simple;
	bh=D8lHWzzViSsdNsAtrgt+yazAoAjdJ1bTrKazNqCAKRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFUIuhh88j02B5EPVeXMnJLsz1dfov6X/A4oY8/ypkr9WnPPIGuqfnEA5S3oJgboU9x9peBNYiattfVK19t/Lhcuen+hF9vZi8r+ZA6Xg8dWmI5HW2aU+SzT673P7/Bixioe9QhTZtIoessoZzOzjAGfVvMKRotBQ6mThR2+ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8j5v9Pk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8j5v9Pk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0D2C4CEF0;
	Tue,  2 Sep 2025 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780516;
	bh=D8lHWzzViSsdNsAtrgt+yazAoAjdJ1bTrKazNqCAKRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8j5v9PkQM9/fApi5g9c2wCsTrotqdNNiQTy0gNZqCfaRHpSEfgTCqKXSXN2Zz3q2
	 g/8I+gDWl8J2EPrUZ3Po8dQ1af6o1Vlp0FUM3YG0O7dIaFRsUag1D7o5Aj9jL+YUM2
	 YmNp0/UVjnLmbbKyM1iSmsC8+i7eXt+ZKB4BViv4ZHHV3aFqhslY3J/2auYehBWV9I
	 TohVCMPUtLEAvFkzd7O19HOvdIlYVQMFiGSJGkvnfF+Gx6LqptgibSjnKhADXGB39d
	 iSzrcfidPXO1nhQnqDgC1E3k8ennGrSeUd7dZ1CFjFt++yBONcaBIqzw2J4LPmMtGv
	 PYp7uE0G2OhyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v10 4/9] tcp: export splice_state and splice_data_recv
Date: Tue,  2 Sep 2025 10:34:55 +0800
Message-ID: <a55a85e972df0bdba9be7d1a71d52c175d9b0af0.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
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
index 16dc9cebb9d2..d48555d5f792 100644
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
index c6425f13afd0..a1fc0a42d089 100644
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

