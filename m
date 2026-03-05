Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B35336881
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683544; cv=none; b=H1yxZchxsI/54y74opGEWpaqE0nqy8X0DEl5jTnVEaANYZKw1GMO7C8YmYA8QW6QOiTORuP9O/xyEFTgM2XnR5uoNWSTwPIlmaVlUKv+Kfmzw49U94tTFIvNtdAKX+KvN8xkaPrKXHbAfnxdeGJ9QPwg5TNXi+e4hOJZSUbvReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683544; c=relaxed/simple;
	bh=5wAqg4Y76q9Vqv/QfZpGMwdsak39VQtYVPozE4uN6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTSxFxoVdWyuvCmVVlMTtFh5C0vhO4v16LNncLYpHdOOw5ssP/egPw8ZIm85axIzaPx5ZBPvwlnIk3aNCiivje5N/zsuuqoh6wNZGhEVqnqvaetUgZazLxilD06/WGUEEIIGQNerc08zzlXOlCvUfmIixAx+tmxE+GqRafoMdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJacmfZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJacmfZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EB1C116C6;
	Thu,  5 Mar 2026 04:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683544;
	bh=5wAqg4Y76q9Vqv/QfZpGMwdsak39VQtYVPozE4uN6y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJacmfZt/GYz/2EB30OtN1jdzqS9vPwp6WNWFUjvZjC98YTA+9MrAa/l7sFZMyLnJ
	 rQ9o8KQ30ioYppipATP27CSGa6qRg+tINPWWRct9UG1gKLUSnMFdCiud9fdBj8jPGo
	 tFg4q1diBYbWE4TcE6riedxfqHCTkVpvxpTgcGbvpLEC1aLniYMsPoowNaWSIOpYff
	 QkMdf3C/hr1smvL5eKb164OalbSidCx5/VgcuhjhGeS6bF1DahIUbeFZFjZZNhpIiA
	 E3QuOCT1K5bcQy8WbCfFWfyI2DFuB9r47f3y9X4FmmvvM+9azHWqOSJSPszydQKBhG
	 KjHRvIqb2Y6Dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v4 1/8] mptcp: add sk_is_msk helper
Date: Thu,  5 Mar 2026 12:05:19 +0800
Message-ID: <20f722bb03b7e2b3959ac4cd377515a423c0b164.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
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

