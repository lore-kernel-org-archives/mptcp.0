Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610D17BB21
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373341; cv=none; b=C2r3sIB594KCZDjKLC0Z3TIuqvXOdgB9fDeq/104wnbNN+PDeOi5pLq3WWcFv091xSCNB7MBMI589orCg4vTP+gKtRkCIxF6BTIJOr/mAz6j6BaeXKwqQn3vF7Mqz214ARwh5eZ3xWWTweUDWhHMdJDLqHyekLKQlPNAhJxPlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373341; c=relaxed/simple;
	bh=ea1pxUcWUaochMdR+R8wcf2lBkGPyHgWs6A2iNTf72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGVPteKcKiqCjcYLBMACu2qqTb+JapFheUK327rV6DEd8qmGvHDmtdoEpO6IIs8HmEw75oivwKtSKm9Wfs/s78htpyH1Ki0nQBr4fv7SW/qUalqTzZLwr/xHeVPHUqmH+TwnetZtVzHej6DFE3k4c08s+perkCbx2iNUbdb4UPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDGUdYaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDGUdYaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC13C4CEFB;
	Mon, 22 Dec 2025 03:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373340;
	bh=ea1pxUcWUaochMdR+R8wcf2lBkGPyHgWs6A2iNTf72M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDGUdYazYXDd2ZjDuf3a++n7YGi0YbQskwcbTmQJSVGtEnMDGlXk4v3lsGepEcVzY
	 S2fNvYl3Qg8rbgEgVnaQ814a4YrtJ1UhMaXbJtQ+2hHuY0NqEQsKiv5YRJ4kFnKKnG
	 ifeM9SUkPIuqoYLRmxnF9Onbd5Yp5kkV4ZfR0QLGu//HkUPllJUNvWu0rjJ1sAiHrF
	 eUT+2W42l02RQoRdRGVXIBxN2Af2LfGfUdGqICkg2iS8FRxVaZZio5MPeaCIY20GOi
	 ZWETeesmP43jBrkyKs7a+GFO3Sx2YQW6AH1QCMGLkPnWEMS1CrGd7lPfWvLPntebTu
	 GcdOHsQjuQIGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 3/8] mptcp: update ULP getsockopt
Date: Mon, 22 Dec 2025 11:15:22 +0800
Message-ID: <30f3a9d298bfb93bcb49a4360af5976697684f2a.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..4f805b99742e 100644
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
@@ -1400,6 +1411,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_msk(sk, SOL_TCP, optname,
+					    optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

