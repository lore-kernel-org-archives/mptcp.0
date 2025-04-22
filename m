Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A4202C21
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314321; cv=none; b=q34qkY3LXl2/qoriTtgvML2iStJ2meX+Y2PyAvCBl6Ow1fSlIaOBWdla2gb6F+AAR8/JrhleiCq51kSXN8exriItqPfUmJRTzmxf099xCUtdJ1vflGjpYWHmQkKTlOaQ1pVjg/OOWnYqRtzH5nrGSIQgEtK1WwWjqHvzUtVASso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314321; c=relaxed/simple;
	bh=CGsrBcKI6v3kABL0+eExA3y73MnxBRshNjk+HcTKG5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HExKgi1vW41YiiQplipSNqMG8Wx+jKgB2Nr9SibkYHsXyZaCUDzS4zJh3/nfaMKKBfzjGBJP+CL3AsMkT719JSidSls+jxCztz+is3RI970zqhcoQsM3V41r+9gU8A0bFDkk40dMNTTcp/Q+bdY6+RsfkRrJ5ybnW5wJFwkjCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3kg67hq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3kg67hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E61C4CEEC;
	Tue, 22 Apr 2025 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745314320;
	bh=CGsrBcKI6v3kABL0+eExA3y73MnxBRshNjk+HcTKG5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3kg67hqAEFiCAZxMN/xMlSNj42smpsdTuRrrFIk9PhhXrcOKq6imr8qEtZS7Wked
	 0pKnYe8+7JQ/QmfRAhhkTaGmA62ROlxxXLI130AdGLn1uj0mRG5TJER/P6D/Afdwvw
	 XT9z8H2hfp+4VSdqEqnMHu2D6g1UmpvZcBhAvPTdEqN6L7q5t6T8WwHn8MfJFgTV8u
	 oRnSDFnPfgBGtnnwNdH7h/Wg+2LkoPlshtLk9/m2uOUIUeSiApYtag6e5D1lyv/SW3
	 SDA1bkmH1rdD37Vu8YWlKhK3USJyIUinC08hpAR2tikDlsleprnerYIRdi49b9N4O5
	 ikAfZ3S73Ybzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/2] mptcp: add TCP_MAXSEG sockopt support
Date: Tue, 22 Apr 2025 17:30:44 +0800
Message-ID: <73d0d8594eaee83d2902ca23c3972ec5e6d628f4.1745314165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745314165.git.tanggeliang@kylinos.cn>
References: <cover.1745314165.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
because it has never been requested before. But there are still valid
use-cases, e.g. with HAProxy.

This patch adds its support in MPTCP by propagating the value to all
subflows.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3caa0a9d3b38..3014713b037c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -798,6 +798,24 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_setsockopt_sol_tcp_maxseg(struct mptcp_sock *msk,
+					   sockptr_t optval,
+					   unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret;
+
+		ret = tcp_setsockopt(ssk, SOL_TCP, TCP_MAXSEG, optval, optlen);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -819,6 +837,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
+	case TCP_MAXSEG:
+		return mptcp_setsockopt_sol_tcp_maxseg(msk, optval, optlen);
 	}
 
 	ret = mptcp_get_int_option(msk, optval, optlen, &val);
@@ -1368,6 +1388,13 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_sol_tcp_maxseg(struct mptcp_sock *msk,
+					   char __user *optval,
+					   int __user *optlen)
+{
+	return tcp_getsockopt(msk->first, SOL_TCP, TCP_MAXSEG, optval, optlen);
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1407,6 +1434,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_MAXSEG:
+		return mptcp_getsockopt_sol_tcp_maxseg(msk, optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
-- 
2.43.0

