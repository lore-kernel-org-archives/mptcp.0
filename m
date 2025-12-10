Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E792C237C
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354365; cv=none; b=SaOfKvX/hY3dJH0iZ1rnsEn9Z9Blmr150kTKrSj9X3egvUQiWa+vPcL44opSEGWi+MdjTO4eOcyb19zRTylFjTTvhTxB+uxxLddXJpwyoUOWIvGGmkELAeQvZIrhZ3LPMZAvd8iI5cDkYh1xYw0Hrs91QuZi69mtLKDG/4z+Wyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354365; c=relaxed/simple;
	bh=YwmXZ7kZpzEThkXjZLoQzKFSok6yeQOEjh0RQ/8M3es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0oQKq9qS4txflTRx9wmlXACqLmlAi09IdhZRFOIo0eXFCa/TnGZPUmQhZEEpyvCj83wMvLeY0bcz843Dv0WMmsw3CTRCINwX+Gyk0NJ+8uzLjExO3wsMhlOnquEJJDvzf//Vt0iM8m+NqkuJtrTpKulDlKUSl/jRkgu9sTlrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6AjZ8WA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6AjZ8WA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0F0C4CEF1;
	Wed, 10 Dec 2025 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765354365;
	bh=YwmXZ7kZpzEThkXjZLoQzKFSok6yeQOEjh0RQ/8M3es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6AjZ8WAYVD5zo6OLi/ytql0OQVmLr41uUROayp/vwOsxRc3iuvv6zt8Qb/vAeGFf
	 xhAGJY8lhqOVBXsh9VjZ7xwbSJmalWnJXJrDmklKdv9dHSUDVFhwGQ9Xdtbm1d8jJg
	 tDCs/3OCEQaHYqAB46hqwLQa+UCjq4T5MHrnGHuSGFee9jbs/mQF0PJ5y/GlBZ58Pu
	 WTUqhriS2qoSxcQgefATZp3zZ9SySlEbcf0Y2wLFOJgfuqI1RFOZW9h2P3fuMxARSP
	 q9cuNVrVzMekWWFWdZgnkR1PUKsjIyceYdCVsnHTfWJRwqZHpHWTQYnQXDDbGH6luA
	 LCgWUd+TVzGIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: add sk_is_msk helper
Date: Wed, 10 Dec 2025 16:12:36 +0800
Message-ID: <1c8e8e95896e6f34a677eec690bc9edf493fd4fe.1765354225.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765354225.git.tanggeliang@kylinos.cn>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a sk_is_msk() helper modeled after sk_is_tcp() to
determine whether the socket is an MPTCP one. Unlike sk_is_mptcp(), which
accepts a subflow socket as its parameter, this new helper specifically
accepts an MPTCP socket parameter.

Note: This helper will be useful in the subsequent "MPTCP KTLS support"
series.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 12 ++++++++++++
 net/mptcp/protocol.h |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..82660374859a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
 }
 
+static inline bool sk_is_msk(const struct sock *sk)
+{
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_STREAM &&
+	       sk->sk_protocol == IPPROTO_MPTCP;
+}
+
 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
@@ -258,6 +265,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
+static inline bool sk_is_msk(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 				     unsigned int *size,
 				     struct mptcp_out_options *opts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f418a0a0fa51..8f1fd74ecaa3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -404,7 +404,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 })
 #define mptcp_sk(ptr) ({						\
 	typeof(ptr) _ptr = (ptr);					\
-	WARN_ON(_ptr->sk_protocol != IPPROTO_MPTCP);			\
+	WARN_ON(!sk_is_msk(_ptr));					\
 	container_of_const(_ptr, struct mptcp_sock, sk.icsk_inet.sk);	\
 })
 
-- 
2.51.0

