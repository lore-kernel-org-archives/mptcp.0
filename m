Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5811E572F
	for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653238; cv=none; b=T/wuwrQAT27Ef5YUfoqcROPFEEghseeIYBpcZKhVerMRlZVhEDRKXM4nhWXiX2QjVQ6GzhX3/WCADoUEesh31QthuWM2flveZM93u89MDf7wjASx/eOz1cHojuzIcPNlM0EKK+2msLmXJfOBIUCdroATf6mddQa22p7WQgxoQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653238; c=relaxed/simple;
	bh=dQa2mQD1k8jMXM428vmJcI3XZnE4oX5j4J4zESf4rEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhvKor4waLHLgrOy3k48jepywxjWALk1i9v3sMQ5ONirgwl0U5pj+PYsEw+eTMhPKlpKs3OJwx23IjzfieGQh4sBygYYjHD6tRLg7vPly4szyQQN69Vt+1zpHB0/fASP9PqW0XbjEb3bcTSAb10lcsTFhauLTexiTIE3GG8v7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO8plxUw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO8plxUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723CEC4CEF1;
	Thu, 25 Dec 2025 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766653238;
	bh=dQa2mQD1k8jMXM428vmJcI3XZnE4oX5j4J4zESf4rEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SO8plxUwZ2L+ZQ7y+szXivYja/zC8PrR0zTNbi7uk2IClFOn3afX9IPNiKYtk4A5L
	 iz1di/2GUQ2UJb3rLHde8vuO0KX7E91Akse+EMxYHJCMUzbdmfwkhr6+pGQC0nMx0U
	 7lJs25gXVMk8rUwZGkSuKEf0oTjXhHtJExTpWiUWkyinrPPjkUVx76L7Zb+lid7cXf
	 CRh0n+okViH+FDItIKm4galGKFpCXfid5u8/XjievbWqDdaTwPPIEB5I7wymYwAZAX
	 tmzNBmxH39CtO43lkHLkh2bNGgdiOVe1GO6NAFEbs59J+T7J83FdeDt3jEJhVDq9vC
	 4/mK95FsMcEOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: allow overridden write_space to be invoked
Date: Thu, 25 Dec 2025 16:59:57 +0800
Message-ID: <1f9a7ad4c8174feb4de57ac51c77768623ed02df.1766653030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766653030.git.tanggeliang@kylinos.cn>
References: <cover.1766653030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

psock may override its own sk_write_space functions. This patch ensures
that the overridden sk_write_space can be invoked by MPTCP.

Note: This patch was initially included in the NVME MPTCP set.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
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

