Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FE1E32D3
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486680; cv=none; b=i+jXGQMRdB6mF9Y879rLYERIZK7/AYZ0JSn0jt9dJRgkiKMY22sw8XFT0XJKM+r0FvGVu2RU6EGMq4Aiv+b939R45tvc4rRTI9+v4T1p0QjXaA+oSLkdfNXzoiwI6TkuPO9jxvxj5AOwbdXr3jj+FYLrZF01aspECkmdFbMEU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486680; c=relaxed/simple;
	bh=lLwfaRl7QsVbQv0wh8UqEkJcWszQ54RQ1a8cEzo98sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU7CnTbKHEGPBEqSLwrEFOFY617nr+AVKNMIr74S58VK0nrjf4hnXH2ggVP5NKMenBImLSl7AhHierEGM6/tuuvc4Bzp/nd/eWgD662Erfaut3KKR19zqFx9bOpDpJDOI9jtCL7nRCBJDNI6RaQFlkz3og2WHytu2WpYjgeVsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZrISWuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZrISWuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF170C4CEF5;
	Fri,  7 Nov 2025 03:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486680;
	bh=lLwfaRl7QsVbQv0wh8UqEkJcWszQ54RQ1a8cEzo98sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZrISWuLhkBwi7nq19jC6XhhM0UH7SHsUKqpLVQM+UOJJAGB8JfctUJspW6tug7pH
	 236PFM72duLIQ5hgDr9yfKFMFJo0kgoK/V16AuANd+Y6CZZ+u60DQS0i3dO75pyHCJ
	 V7HISJT3hTNGe33X8KVowVe5Iao4wLLKV0BTlZ1fkdjQpMu6YU7ZQGwlN/9Irqmwve
	 TASipEl61lCDvjOaRoXEPzMBQppnG2VvBnqOq3Zm2z3izKRPmrFn+oo3c5Xd0iitv/
	 ozyRHC41Pq4detNpCqMyEWRWkbvmH5NkW/+zj8YssofOAqbXBT382vZALAy3Xrvax0
	 kDFgEVw7+jG0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next 1/6] mptcp: add sock_set_nodelay
Date: Fri,  7 Nov 2025 11:37:32 +0800
Message-ID: <a1cf1ae0309392bee2e97b9a1640c7a056204fbd.1762485513.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds support for the TCP_NODELAY socket option in MPTCP by
introducing a new mptcp_sock_set_nodelay() function. The implementation:

1. Exposes the function in include/net/mptcp.h for external use
2. Provides the actual implementation in protocol.c that:
   - Locks the MPTCP master socket
   - Retrieves the first subflow socket
   - Sets TCP_NODELAY on the subflow using __tcp_sock_set_nodelay()
   - Properly handles locking and error cases

The function follows MPTCP's standard pattern for modifying subflow
options while maintaining proper socket locking semantics. When called,
it will disable Nagle's algorithm on the underlying TCP subflow, which
can help reduce latency for certain types of applications.

Co-Developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-Developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..f275eae0d32f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -323,6 +325,8 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static void mptcp_sock_set_nodelay(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e796c9c7971d..b2285b651ebc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3696,6 +3696,24 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
+void mptcp_sock_set_nodelay(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+
+	lock_sock(ssk);
+	__tcp_sock_set_nodelay(ssk, true);
+	release_sock(ssk);
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_nodelay);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.43.0

