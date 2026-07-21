Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2F2D7393
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 02:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601690; cv=none; b=im++6bThCTqqJq65VqBVF03BjRQdkPS/62RGiP10M/vvyhwb7bR0ZP1E5zcqoW5MILp9su0vB4/Hpp4bGvrYMMTm75aPajoInxlIeHhVRq6X9sRCiyggBmuvVdYGWszSdLNIlcd7ynJwT0YwtcvuH0EXOxb5n9bmvPWjqL6PkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601690; c=relaxed/simple;
	bh=RwQ2ZyRTWdsJB94Xk5fSutnmDGpQxU3yZiJdz8aqBxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTLc1J0NfnAB3yvQjXbG4O0eeeETsb4Nu7Tzr/zZ4nmybkSQHW8kVCnbmX8CxQzO00n6BSAyOTSxZxCcD0SsUkMIhdH+GFwcnd/ThDImbb2hdSe8V8e5oqBib1CWLmfCgfcPkmWDH/wMDGESWZrQVbAsDswjZkXUCtNbxJYjp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqvinwdQ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqvinwdQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784601687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6fbaEFLyxJvO1MF8ueeaNjJuFg1qmrk1K1kPVzQdqo=;
	b=NqvinwdQPjZifXogK4DfensrEnkxXHAH0jO2y4f5dDyuVLuRJiQGPLLm3oiAPoLGB4xWVA
	EpkhYribNf3t02B6LEbUrd+2Y9qGH/pwX3lPqhpz9UeBKdSdMO0sXg31mTHx9l8O88ZBeH
	XCGigEFVJiGJqNyy0u3Nf2KChC9AVBk=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/7] mptcp: enable bpf_setsockopt on the master socket
Date: Tue, 21 Jul 2026 10:41:00 +0800
Message-ID: <105cb65167ebbedb770760193e2af64dab4dbf10.1784601268.git.yangang@kylinos.cn>
In-Reply-To: <cover.1784601268.git.yangang@kylinos.cn>
References: <cover.1784601268.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

bpf_setsockopt() currently cannot be used on mptcp master sockets:
__bpf_setsockopt() dispatches by level to the protocol-agnostic
sol_*_sockopt() helpers, which either reject the msk
(sk_protocol == IPPROTO_MPTCP) and the ssk (sk_is_tcp() is false)
or bypass mptcp's own dispatch (e.g. SOL_IP going straight to
do_ip_setsockopt()).

This patch routes any level to mptcp_setsockopt(), which already
handles all levels.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 include/net/mptcp.h | 9 +++++++++
 net/core/filter.c   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 333bde2a0b76..fcce2b7e9ef9 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -237,6 +237,9 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+int mptcp_setsockopt(struct sock *sk, int level, int optname,
+		     sockptr_t optval, unsigned int optlen);
 #else
 
 static inline void mptcp_init(void)
@@ -314,6 +317,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline int mptcp_setsockopt(struct sock *sk, int level, int optname,
+				   sockptr_t optval, unsigned int optlen)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..18e650bf7393 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5683,6 +5683,13 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 	if (!sk_fullsock(sk))
 		return -EINVAL;
 
+	/* Route any bpf_setsockopt on the mptcp socket to mptcp_setsockopt,
+	 * which handles all levels.
+	 */
+	if (IS_ENABLED(CONFIG_MPTCP) && sk->sk_protocol == IPPROTO_MPTCP)
+		return mptcp_setsockopt(sk, level, optname,
+					KERNEL_SOCKPTR(optval), optlen);
+
 	if (level == SOL_SOCKET)
 		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
 	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
-- 
2.43.0

