Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C6315D32
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153637; cv=none; b=DuXoIbWL3gb7M9mRAJDtlEhM8wM4qzqD3/z2mnkUIVcD+ZIeuzp8uHirkaL+7O5EAqOXsqMMTwAvx8NQnxeaYu+YkEYG+bbMinJlKqE6FeY/aSQKpFJPBTC3s3AWR7bw0d4zGOiLHu8fH5d91HGh/zM8Euw/Ow6HIvBZjrfs0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153637; c=relaxed/simple;
	bh=tKUDZjqve9JfGFOd55dQPXbJ6nfcGhBqJr3QWgLPxb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgT6wmXVKwi2HRoc/5cx81nP7A/Lv5fFLpFpg0se20v0QhqbnLN177WmraL4ntMMQ8mNPiqUTIiRwqimUmq5chBh5UfeAQf0Bs7srXQhtj6Hufw4mTkLRGJGRUdtoQoOpaO7ZjeLyRPxCjASZN49dFGYf/aLqQkPT34ljdLtnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSvTT3dQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSvTT3dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F208EC116D0;
	Wed, 26 Nov 2025 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153637;
	bh=tKUDZjqve9JfGFOd55dQPXbJ6nfcGhBqJr3QWgLPxb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSvTT3dQgFBjohjqy6kRoXhcMPy38zoOexdA1ymCTJ8V25tdXTjTnudjqtx6CfSGM
	 LRCYIJ3wihmBLU32YSTEjzLISgxkBRIQyBBE5czTmgLQ4kWryZcS2KoOsdARvcF0XP
	 zVM94uVLCTz6r99WazepanxO79F6AlXcF/4XqoI5qE4smg2kt/k/S3uGRYgI5CBORx
	 sblFXeAcURbswC7qHwrTGOib/aZSqawLk08ruw2yGHQ4cAE8HnwaJ886Kps1sytImv
	 sBcBErudDj2WPIgIuHlY9a5Uv1UwMW8b2wuxc2y3RGiNg9eD2oJHaNPXJFVGYbWUWp
	 u8ZnliN11Vf1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 5/7] mptcp: add sock_set_syncnt
Date: Wed, 26 Nov 2025 18:40:02 +0800
Message-ID: <6f8fd94cf8d2b77e9c258f73c708e139e5e279b4.1764152990.git.tanggeliang@kylinos.cn>
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

Implement an MPTCP-specific sock_set_syncnt helper, which will be used for
NVMe over MPTCP.

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  7 +++++++
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4fc8f08c6588..7d981973df48 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -241,6 +241,8 @@ void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 void mptcp_sock_set_reuseaddr(struct sock *sk);
 
 void mptcp_sock_set_nodelay(struct sock *sk);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -331,6 +333,11 @@ static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired)
 static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9790bc74a0b7..543fa3131af7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3797,6 +3797,25 @@ void mptcp_sock_set_nodelay(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_nodelay);
 
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	WRITE_ONCE(inet_csk(ssk)->icsk_syn_retries, val);
+unlock:
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_sock_set_syncnt);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.51.0

