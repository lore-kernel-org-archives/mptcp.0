Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95C14EC73
	for <mptcp@lists.linux.dev>; Fri, 27 Jun 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040091; cv=none; b=IdRjh/9eemaZg+q3bhQ9puWY6adKv2rkbuFa6jPqHlg8iYvvSLpK+lanrUrlLMXmfM306tASTtKT3EMO5X124zD5XKU4J5e47yZstTVfDfDgF/YyAxoY0piDWXRDtIhjRcMxTl21bAgU56unsJk0/7+LHKecM64ve1JNWYxEgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040091; c=relaxed/simple;
	bh=3xuUr77WJdOE23V8Tpi+/hhttLBIYXzMFY0ZVafEskQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9RGhJs1nMGf4YWlz6i20A3OeeDJlkC95lRfiTJxtGBpI4EaH6j/zkVWkxZ3Z5QyW2RL7t4zDfVO/WeAUlKN/kPMawyTlqWBFKKqDOlLLC+H7/ytvBnrAoPbXeQa91ZWhZckVAzBSoZxc/VtVRvpCY+0uNcKlBlA2PjN+8SSIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbeAcBmu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbeAcBmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8EFC4CEE3;
	Fri, 27 Jun 2025 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751040090;
	bh=3xuUr77WJdOE23V8Tpi+/hhttLBIYXzMFY0ZVafEskQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbeAcBmuBQ/S5pBVEgA3F7KQGSoqp1WE8jIccyjLO0E34ETjzuvWLUEPxR07+8+Z3
	 +BWsJqfGkiW5CZH8VvoBqYjtoLxmYRbvUtZcvLJu8yGYNozhjOEDMXA6UjKtGvviQ1
	 WrALDOxJ6vYtaqZsqb6ZCA2yUEbrdIYViEMZC+VfUr+diD4JZMIPurwBJK+JwvC/lw
	 ZwVALA0xvH9jNNiZv1pmKSyJvw59yM6rMRZrIVMxABiel3w/kgNTjaDGSgjD5BKJR4
	 5qggD7IuKXAkEc+S2Rf5bIbpZRKM9T9+uhmgorFvdQtu+VKxdpWWuNqfQK5FANzlAF
	 OzuJ8CPlzo1bg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/4] mptcp: set .splice_read
Date: Fri, 27 Jun 2025 23:59:42 +0800
Message-ID: <84557ee1e03cfe9172e5d52ad78cbf88d3711672.1751039657.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751039657.git.tanggeliang@kylinos.cn>
References: <cover.1751039657.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch sets .splice_read interface of mptcp struct proto_ops as
tcp_splice_read. And invoke .read_sock in __tcp_splice_read().

v2:
 - use INDIRECT_CALL_INET_1.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c       | 4 +++-
 net/mptcp/protocol.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c18682c3fa33..97175b75796b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -774,13 +774,15 @@ static int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
 
 static int __tcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
 {
+	const struct proto_ops *ops = READ_ONCE(sk->sk_socket->ops);
 	/* Store TCP splice context information in read_descriptor_t. */
 	read_descriptor_t rd_desc = {
 		.arg.data = tss,
 		.count	  = tss->len,
 	};
 
-	return tcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
+	return INDIRECT_CALL_INET_1(ops->read_sock, tcp_read_sock,
+				    sk, &rd_desc, tcp_splice_data_recv);
 }
 
 /**
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 10cc8756877e..33608404b871 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4039,6 +4039,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4144,6 +4145,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = tcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

