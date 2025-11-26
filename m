Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724C315D32
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153631; cv=none; b=sM1+TCzMo6yIHPBqg1vWbpFhB7+1KPmM7Wtf7XfZmlM2gTqMsc+W5WYKx9zdoj9JBtpwzYmjw4Np+f2tZwEVBHD8FbBM0eIhQ7TqLICZdyO+KKc4RF6bDenJdahz/OqIGXq9hs6GQhZoX9b+ewM3aTrp382BLqd9t+IPur5ulKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153631; c=relaxed/simple;
	bh=sj/rDpT3m39PBkRW4dkQHD46hWmrQGYW4HnSuwUyocg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzxBtPE6rHHV/VSdxh/IO1YISYTGIkHHFNdtIA9+1Q7sjZbgjfLSI6IJujN9cjQ2WLIrj9nlYKp9vBABANHJ1m8531APrVYpHB/lfC1JAQOOSMlebfF3jFm1WYVJ5bT5f8HUD1AtCTJBh+gZBLYS01hrnRZRdRY8+xCyv6u+A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omv9sInZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omv9sInZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39017C113D0;
	Wed, 26 Nov 2025 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153630;
	bh=sj/rDpT3m39PBkRW4dkQHD46hWmrQGYW4HnSuwUyocg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omv9sInZW+y5OHnIa7GEWTCLMQPp7isONEICCPILJBnBqhQduu8pFLZ8lBeZELrh/
	 9yenNlz7lkA65jKXlz7anAdo5+heIc005KsPlzgAzUP5o0WaabS6FRSdAkiJqGmpGl
	 FCATizJ7I0ex7IaS/u6cdVgZpX4ieisS9QvVcvXwwZJOSOVemAJME5pXmz98Pia88I
	 Wkqa6O/4Hs1TrmmLIY5Xu8Wg2DTDkXrPX2CB+k6ItbNJABaobYqbRczAZSlv0MMWlw
	 n3dN4gyp6nSaJ3SH52BQM8R9xTXaKndODgSZCuY6sxCSPl0q2h7PdowU9cVa5LF3OP
	 x7lRyf8L/avtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 3/7] mptcp: add sock_set_nodelay
Date: Wed, 26 Nov 2025 18:40:00 +0800
Message-ID: <8d655baf1d091f6960c4ed815d20b4a7f6eb0414.1764152990.git.tanggeliang@kylinos.cn>
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

Implement an MPTCP-specific sock_set_nodelay helper, which will be used for
NVMe over MPTCP.

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c7bf444eee56..4fc8f08c6588 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -239,6 +239,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 
 void mptcp_sock_set_reuseaddr(struct sock *sk);
+
+void mptcp_sock_set_nodelay(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -327,6 +329,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return hto
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 
 static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
+
+static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21067245a8f5..9790bc74a0b7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3779,6 +3779,24 @@ void mptcp_sock_set_reuseaddr(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
 
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
2.51.0

