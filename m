Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D962045AD
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119393; cv=none; b=ZF9kye4l4H3a4QFpem1YX5Nx4qL/fqiqD28neT56ExUHIV/rSZmxjA0PHhv7Y7JfSFs45UZfDf+fXvHJsa/WkudPK9g6QOIMhGkkNSCJNCIj4iYqiZN9wKhcHfdR4xrwvwty5Hv2Kmty6gC8Xg9Lkikddjye3E0/+s8K6JvXFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119393; c=relaxed/simple;
	bh=RwQ2ZyRTWdsJB94Xk5fSutnmDGpQxU3yZiJdz8aqBxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9PhOIafzkeYl+OmQbDTYW04bL7qqDs5soSh30aoyvAzikebr7NI06TOoZum9NDBRzKaqZ0zphPkDjd1aTR+aSin0raMqwbOEGLthouLqnOjqjjwolnGqIz7hTRYVH/KJMeqnDn3qP8vRz70N9HyFIPhu7oAnhMYiJNhFAAfRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGzd+kyy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGzd+kyy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6fbaEFLyxJvO1MF8ueeaNjJuFg1qmrk1K1kPVzQdqo=;
	b=vGzd+kyyndgDZA8cNPSwrlEYdWMX0snxrN3bwCXObf+l6+4zVBGl/LESV/llaBBVeTrvqD
	W7EMI+9jp1xQhJ/yReatSpc3D2liNgKdN2ZDtphi1UXrOypqZu85T+9W2SacN9gkNsFQ/3
	Z7FFzbm5tQLWwZkA7ED/I+uIvSQpaLM=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/7] mptcp: enable bpf_setsockopt on the master socket
Date: Mon, 27 Jul 2026 10:28:47 +0800
Message-ID: <20260727022849.20923-6-gang.yan@linux.dev>
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
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

