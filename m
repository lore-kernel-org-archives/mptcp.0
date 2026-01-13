Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE0A41
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284831; cv=none; b=TWAMCPvK1MnLfgNOLy95IJC8ZKA1rsI/aJW/k31hKIBrgvb1LFxuNIQs/UVQB3q0YGGmCQ8GRgrSZmnS4670FldFXz7y9286wXBIBPJwWUS19JH7VKhoKDaBYA/KvFXm7nFggbutZ/ol/V9AFdppsyyYVvuNzMxN2oN3K3ilt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284831; c=relaxed/simple;
	bh=s+J0uiEWN2RKqf6vRJ0b882/FRaUaQiO4LNcZ2w7mr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNoDbmj1VvBqw1Wmfleb6LdvCe6TqX/0ZWrXNzND/gwjg6WwLeD07vlULGKfbAaTuyYlWA/KMtmU9iMNEDeleqpGaxLwB3bytWL++89j5yxx8vLpX2iLnhwIEF0SVqwH6XYDo1usr7GmBJMLk2vxOkxPySn/Egv2mdjetAXLfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONak/q5j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONak/q5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46074C19421;
	Tue, 13 Jan 2026 06:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768284831;
	bh=s+J0uiEWN2RKqf6vRJ0b882/FRaUaQiO4LNcZ2w7mr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONak/q5jdWm/hPEL51V8Y/eRoYlkWwYy+DySeqBVba0oa2BGUl+vWjXmkZJMz/w/3
	 poHjfJU1MJu+ivMPITjSbo2zLZVBsbmUXfv58ZPKbRXC3AWXUU70aGbMpqS4c78hmN
	 ad6AcAhpTs9sHqXlFCwjv0GbbKPh94opSwTSnurv1OjJGnLyAgpjxpNOw/Egfv0af8
	 CuyULfShXFr/U2X/rSL0b3WcLzTMIIPCByWwtGUL5nvxavZu7p7vcwdIbUQHHHgo7w
	 FJiLaaSRB7KQoKW4nkWWhuMGnX6oJmtKq09aiZBY574WH/lw6CqLLY55DOm2nVyZ1c
	 5auhMPPh/lcCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC mptcp-next v7 4/9] mptcp: allow overridden write_space to be invoked
Date: Tue, 13 Jan 2026 14:13:30 +0800
Message-ID: <3bb02f7f4d3d58291ac1e7a2eaaf851edb636136.1768284047.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

TLS overrides its own sk_write_space function with tls_write_space(). This
patch ensures that the overridden sk_write_space can be invoked by MPTCP.

Note: This patch was initially included in the NVME MPTCP set.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd5266099993..f5d4d7d030f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1014,7 +1014,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
 	if (mptcp_stream_memory_free(sk, 1))
-		sk_stream_write_space(sk);
+		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
-- 
2.51.0

