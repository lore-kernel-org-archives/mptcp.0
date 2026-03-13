Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238B28488F
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375191; cv=none; b=PQZTpRI/orjD67Je7DM19gFit2A0BmqidyWJPiIMvrbsKkhxAB/DMcZFvPN85x288PxfcCbO8YoThsdaeyhMErD8Z+XcWaCu7b588kZymD1wbNapRd0VskcbYGZB3BEz1IoKGCu2BpSDyv/e5SEqVhThV1PNyg5Fchg7j1cXAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375191; c=relaxed/simple;
	bh=5wAqg4Y76q9Vqv/QfZpGMwdsak39VQtYVPozE4uN6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k87Jd+8HY2yrSGRPFlIEXnUAUocunzpacXU/XffSNzE5D86xtS+P9ujeNfER48gItWs0ImDBasZ5r7tKbWWfyW6+C4upgrKnh3oYwbXc9apbm6gc018GftprsGS0f12lBbQpy1rNuR9DcqhLru3gm3TZkTAEHk7RGiHf7Uq+Dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prr8HL5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prr8HL5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAD7C19421;
	Fri, 13 Mar 2026 04:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375190;
	bh=5wAqg4Y76q9Vqv/QfZpGMwdsak39VQtYVPozE4uN6y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prr8HL5SM1iDgwv2pjRijYnJTZrywAYoIw8dJWa8M6y1TiJeJEjmANFWc7RiEYUN+
	 EqJzsvNR6zBzS4AlsMqb8nuxeP7/Ux0rHpR+cBVSCPfBGmx+ksjNxeTaMwT4JKdYze
	 tFCWs3oN7oxPoQsAbPA1sRhTfrrDwWD0QDfvMF7Jx2NwnWbUnqf2HaEJSWDns7nGZT
	 HYDKze6gY11Dg6hsfUHsBgEMmD2eEk1ocH1XwmEjhXnOxGU9/hqdOaMdYfhBuSac9P
	 /Tke2lIYiWL4u0AYt1IyVfz3qwi7ya29kAX6nOj3FESHDMDenRs3LHFK1gRDqdR7/C
	 ImqnCSb8fA+EA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v5 1/7] mptcp: add sk_is_msk helper
Date: Fri, 13 Mar 2026 12:12:45 +0800
Message-ID: <c8218399b642cbfe9730430e4385e8b29c8e082e.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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
-- 
2.53.0

