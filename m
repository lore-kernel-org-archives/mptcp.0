Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5A2989B0
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506460; cv=none; b=DvLoBK0AcO5DU/UBj7fI1fNxmFV+B8823UfqlNMRA8dWlvQ6HyF6o6Cmf4vKYG1b4ZrUslawoASvqDroKeivgX9CCFH9WpclzWoUqhTDFaMk3OFq8dU9WgVEPZkFh/fcv84qTJhOmLufcubRhPqNmoPg2QLJ1VjFOFTycGHFcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506460; c=relaxed/simple;
	bh=tqQxCtBYZEYSb0VBK/bDrbQYT/Rsb0f9OomcFxC4SKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfWwtYBq+j1uW6xkcwwkU4ET/CC+agxn4N+5Dp8pdDmk2N6eOPcw9DvIsQHpscU5cT/+VNpmIcWrGFAZj2UI9g0cK4esx+IERwTwuqkf/aKeuce+MJJFvR4CgFBn8uVXHrphUGCRu7OyEsdynYzHe46Lmhmb+dcH4JwCq6Jz4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hydTK7nV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hydTK7nV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB443C113D0;
	Fri, 12 Dec 2025 02:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506460;
	bh=tqQxCtBYZEYSb0VBK/bDrbQYT/Rsb0f9OomcFxC4SKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hydTK7nVbN0MAXnhsI5Vy3332SQaYi79YXB7TvPz/ExNYS1EEm3CkUVXq8e9cO4m+
	 yS8Rn3K1ayhYmhi0wqhpojbqlcA2fVlsvxS/USCs74hw9LrbwmK/HqQf4kqUq1yS7u
	 cQTSuodljRNjNkgAO9kB7q4vCWkq9cY3iMO4EvsME6LJI35HvTabqWRF0NF8bGqTVG
	 2l/SXNWfS9XPsHzUFc2S3a9f/B7WWne1q+fkIlxhbhEDhcx4HYwqL9/JfiDsi4oyA5
	 7bgu2DFPR0y+FPT9d+vQwagQyLoZ+Fr/kFgb8aaQJxj13ZnSm7z+xP8YQ2nA+1xhNb
	 YKgU9iEogCCeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 07/10] mptcp: update ULP getsockopt
Date: Fri, 12 Dec 2025 10:27:17 +0800
Message-ID: <be44b12135d5ef6cf437d228ceb153fc949e101f.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TCP_ULP was obtained by calling mptcp_getsockopt_first_sf_only() to get
the ULP of the first subflow. Now that the mechanism has changed, a new
helper needs to be implemented to get the ULP of the msk.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..f3db4f2e8f81 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1393,6 +1393,17 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_msk(struct sock *sk, int level, int optname,
+				char __user *optval, int __user *optlen)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = tcp_getsockopt(sk, level, optname, optval, optlen);
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1400,6 +1411,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_msk(sk, SOL_TCP, optname, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

