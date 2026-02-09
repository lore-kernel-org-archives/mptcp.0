Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79C1E2614
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627875; cv=none; b=m6hdQO+pU5Z0rQPhKc5yKVQb+8LLlDIg6bAPd6CH9fe0vVoUCfeW1uu7Lho0i2/jwAmjyj+/2fWmRo0erdXdTaKwBMSkOCwC2N3utgS+ES8N3RK4l6Mk8qwr04QLjMWAuQBWLz2V9V1mFgNNaoGjs13i3egZWq7ol96e0CJ/I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627875; c=relaxed/simple;
	bh=5wAqg4Y76q9Vqv/QfZpGMwdsak39VQtYVPozE4uN6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPMA3zF79wDtsITmAgRyErbOqZ8iFOIYVTsygm04YJDXK8jkMOXAwdIL56kEVRuPVIIBFeCVnvSVFJkdJoHIpbNEoGZYGwAoiPaoR5x4YWo45gfednl+m5sfFbICyTTMbTkPPDmXit/UDAeL+vmDCmHrkdquBITCCZ2dB6krMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/9u4OKX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/9u4OKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09752C116C6;
	Mon,  9 Feb 2026 09:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627875;
	bh=5wAqg4Y76q9Vqv/QfZpGMwdsak39VQtYVPozE4uN6y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/9u4OKXXjPJAH6sILO5MqcjON7u+7RM4DceLddolBLSCFj1mPZsboK/qvcPEz9MQ
	 MaqptQBPWIRT5AnQHpDKAyfGVgbDNJ5NJZT5QK30J8ERxy0pTm8kaRV63Ja3c9XabN
	 LJf5/5qKXpo9IL+6vq1Jm+w3Lra4Np+CtzphDj7Bft4eUwhuldGpZAPdAcESIwwvDq
	 FYCGgOS7/K906sFZn31Srl5wMDu2bEk1SHywUa90Sojpqq9t+e6COWw0kYYul+mcq0
	 GHWYyy3r8AbuMBImEqTP7uAu9TJWhlxJiTvlTewPA6zRZEAVqEdkJyQnNrkP+y2A6v
	 zqqe+9nHrYQdA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v3 1/7] mptcp: add sk_is_msk helper
Date: Mon,  9 Feb 2026 17:04:16 +0800
Message-ID: <ac2f9a7ee1531baad56ed7b98fc4e1465bcb9945.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
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

