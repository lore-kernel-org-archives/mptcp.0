Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6A3195E8
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153624; cv=none; b=XtkFMWXz4cunePjfFnT5iz7QlYxeo+EJM6VUUVHs0nAlvuvohCLGjxcbnJZCJcugswYL/uURPdzyFLKNVWkD5AjW7fCSh7bTxIMRnTWdafxSgB7ZaXBhwxAfLLCa3+21TwMeex29iZs2D1WVPCjnQewV4e2aka0rWh5C8eOqVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153624; c=relaxed/simple;
	bh=f0bZ6fi6QDswjUjdbSGNtKIAgYgslReMqzgUE2cGTi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtJYhkrW6yibIfm+s4G9oFjLFCBKSqcgoQ8ONoNlxyb6IaFG98lzssfLPRv8wiFQbFoNIzF+EzyJrWBDfaBn/gZkW2OuvL35jts+qn1D/VUtBxqAem5rKOaKnP/5rs5Pdr5KO/n7fKk5uRnbvNfyNItYrECegJ86LGuu69KIpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvL40phD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvL40phD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E7BC116D0;
	Wed, 26 Nov 2025 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153624;
	bh=f0bZ6fi6QDswjUjdbSGNtKIAgYgslReMqzgUE2cGTi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvL40phDzGkGJp/GOx7mp6aSeCey7+jQBGz3TRYHORW7cRVrH3TtMkc5pEmLWFFNz
	 qe8qPfTdf3GrNdLtGgwNSwCr1KBe/HdfPAAHoXSwpk5uAzU1GNqPGmpEen9wezqqbJ
	 euX6bydXkWX8DLxeFQAB8F7wxFcy72Z2e19jah1ZSN9+99xl2acBb2BxpL1tbbqBAj
	 VYA6s4mZZPtqcsYm17Mmsxjw3y+Ik1ulGeRcp5mkbLY8HNmUu+UuQ0wGWhe49hBTxx
	 z64XhmLIZWvum8m0XW9TGI7kV4KgDVAqO9KszAQD44s8ksMSQs9TZ1z23HpUt1alfD
	 wjG7FrhN0pcvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 1/7] mptcp: allow overridden write_space to be invoked
Date: Wed, 26 Nov 2025 18:39:58 +0800
Message-ID: <6e185e586ee731d83ae6fb44254bfee7e3074f51.1764152990.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764152990.git.tanggeliang@kylinos.cn>
References: <cover.1764152990.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

NVMe overrides its own sk_write_space functions. This patch ensures that
the overridden sk_write_space can be invoked by MPTCP.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 199f28f3dd5e..483143e2d0b5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -973,7 +973,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
 	if (mptcp_stream_memory_free(sk, 1))
-		sk_stream_write_space(sk);
+		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
-- 
2.51.0

