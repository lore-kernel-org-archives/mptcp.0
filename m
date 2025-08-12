Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A2DDC3
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986657; cv=none; b=Q/gOIkPUUcbG6BUvoyg70QRJfLKYwOSrW5NF90/38i2Tmut2a2jxlHDULOvbT+N/WwcFSzGYZK9B1MBDTNCu+a97Fx4+AygSFyaExMfOFLbY+tYKExfQxF12wHKnllmHbq2lifwoL1W7jqv9vYkfK4wzWgEiPFgdcL6e0bioFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986657; c=relaxed/simple;
	bh=9Gy6VuXrWGCauyH+4uZtadIpH3a+QbAA7LrRxZidzno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAdWU4LrOuXGKhxNQsVFj3Wp2X65c9heH9Swdkg8FAesCmjXn8j84DMaieOIWzcvLA1rI6UKCMM2WsvVMwhjXl+EtKE0R/xep4yeRCnoFMB/fB4qk1x2pJh0YcjlYXjJBVDzSvy65FzNXoR+s7ONNvOp4X0smRuw41qpvEp9pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtUMdfAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtUMdfAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B700C4CEF6;
	Tue, 12 Aug 2025 08:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986657;
	bh=9Gy6VuXrWGCauyH+4uZtadIpH3a+QbAA7LrRxZidzno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtUMdfAcofiPCqt47tApH/8Simz47A539UUuEpFbdjJqz1J+GFqOPzJK0l8YY5UfG
	 NwyWwAHFIyQHKEjb+9CibMzhJAgGDEzsdwR6hsMKxgGEcHEvytPrwdO+AbQzWXNhFx
	 dlr6op8GjBeB6BMNOQF29iKEVR3hzxV0t4NOn95CFYJ9agJvEEY38xCwT7SAf/YJ9o
	 s8xXuIymJuuHvUzsNH5WRyaTsUin7MtYAiwinSNbBg3gaDZ2dEFm2FKV1XiDc4iZaS
	 pjQ4tiaOp9uqItLdacFSF8C8AbtvhzLO+xTqG6vbQ6YZAZx7RlSsHiEOb00xnbCB4r
	 cOErTI3giKC3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/6] mptcp: extract IPv6 socket option handling for first subflow
Date: Tue, 12 Aug 2025 16:17:19 +0800
Message-ID: <f2ffe3abbe2441d6a70fb350c6ae185aa86cde98.1754986557.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754986557.git.tanggeliang@kylinos.cn>
References: <cover.1754986557.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract IPv6 socket option logic into dedicated helper function
mptcp_setsockopt_sol_ipv6_first_sf_only(). This helper handles:

1. Options requiring first-subflow-only application:
   - IPV6_V6ONLY
   - IPV6_TRANSPARENT
   - IPV6_FREEBIND

2. Synchronization flow:
   a) Lock MPTCP socket
   b) Retrieve first subflow
   c) Apply option to subflow
   d) Update MPTCP socket state
   e) Increment option sequence counter

The refactoring provides:
- Clear separation of IPv6-specific logic
- Consistent error handling
- Reusable pattern for future IPv6 options
- Improved code maintainability

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 80 ++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1ab3dbe5124e..964131ef82d8 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -401,51 +401,62 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
-			       sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_ipv6_first_sf_only(struct mptcp_sock *msk, int optname,
+						   sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	int ret = -EOPNOTSUPP;
 	struct sock *ssk;
+	int ret;
+
+	if (optname != IPV6_V6ONLY && optname != IPV6_TRANSPARENT &&
+	    optname != IPV6_FREEBIND)
+		return -EOPNOTSUPP;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		release_sock(sk);
+		return PTR_ERR(ssk);
+	}
+
+	ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
+	if (ret != 0) {
+		release_sock(sk);
+		return ret;
+	}
+
+	sockopt_seq_inc(msk);
 
 	switch (optname) {
 	case IPV6_V6ONLY:
+		sk->sk_ipv6only = ssk->sk_ipv6only;
+		break;
 	case IPV6_TRANSPARENT:
+		inet_assign_bit(TRANSPARENT, sk,
+				inet_test_bit(TRANSPARENT, ssk));
+		break;
 	case IPV6_FREEBIND:
-		lock_sock(sk);
-		ssk = __mptcp_nmpc_sk(msk);
-		if (IS_ERR(ssk)) {
-			release_sock(sk);
-			return PTR_ERR(ssk);
-		}
-
-		ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
-		if (ret != 0) {
-			release_sock(sk);
-			return ret;
-		}
-
-		sockopt_seq_inc(msk);
+		inet_assign_bit(FREEBIND, sk,
+				inet_test_bit(FREEBIND, ssk));
+		break;
+	}
 
-		switch (optname) {
-		case IPV6_V6ONLY:
-			sk->sk_ipv6only = ssk->sk_ipv6only;
-			break;
-		case IPV6_TRANSPARENT:
-			inet_assign_bit(TRANSPARENT, sk,
-					inet_test_bit(TRANSPARENT, ssk));
-			break;
-		case IPV6_FREEBIND:
-			inet_assign_bit(FREEBIND, sk,
-					inet_test_bit(FREEBIND, ssk));
-			break;
-		}
+	release_sock(sk);
+	return 0;
+}
 
-		release_sock(sk);
-		break;
+static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
+			       sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IPV6_V6ONLY:
+	case IPV6_TRANSPARENT:
+	case IPV6_FREEBIND:
+		return mptcp_setsockopt_first_sf_only(msk, SOL_IPV6, optname,
+						      optval, optlen);
 	}
 
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static bool mptcp_supported_sockopt(int level, int optname)
@@ -829,6 +840,9 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
 	case SOL_IP:
 		return mptcp_setsockopt_sol_ip_first_sf_only(msk, optname,
 							     optval, optlen);
+	case SOL_IPV6:
+		return mptcp_setsockopt_sol_ipv6_first_sf_only(msk, optname,
+							       optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1

