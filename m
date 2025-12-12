Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3645274FD3
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506447; cv=none; b=s8Rw4QfECu1drRFB82x89SRACfQu5HaqJDB0CoIcaEKXyo4gv5UqV3uFJYg9Z7xYpiHOsgQfrOXs+Czf54Q4NNI0CJ4h6v/VPeJqur4H5TDXN8hCl4qdxmdh9pQbI0tF9AzpQ3oYQAxm1+RFr9WW63xp5rcum00MVI9vxYOtD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506447; c=relaxed/simple;
	bh=doqCdOWnbuuMH1gL6XRGNNKshbLTMO+Xw1nFQPZEv7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOP97ePvHHnZZjrdhVByeTEVfB08pCWxrWDT04i6ySjzCWfbWAihT+tZSnfAikYpwKgZ8bXu1Az4sR0eRBkqZORjL81H7nbOo18oZqlxcCWD+j9h3Hjx+EFZ+sb5USiG8jSphtExpDPfjjr2c8zUaIEDHQ6/mBNEeOO1y1HiebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYnOgY25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYnOgY25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D169C113D0;
	Fri, 12 Dec 2025 02:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506447;
	bh=doqCdOWnbuuMH1gL6XRGNNKshbLTMO+Xw1nFQPZEv7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYnOgY25eTvKalzhU31Nlq4UvNVCigEcw1YWZZqd/FFR6DIPOgFMoQXQyh6TZu4tz
	 7OYJ2EAJVW3DoTaZQIYOVveiZznx80v0JibA2KjWHkNOYkly6DZEWeLxO+2rpBKc6I
	 ckSEC2QX1S9+iJ8Mn2tLycWNRWYSlwYGxjnhxOb1UNDZ7RL27B2kH1hbdHgtJ6X49Y
	 +PqFOfB7cY3Vv3/neFSMNEIuHKo8Xhg0B67yrKsKwT3uigcIiWPbZn8snsU1J2odXv
	 p5jaLwpjErHre8s+duHJPdZg4F4fway3G/LLQZ57GD6ug8n8IjvaVw/rDKtnTzxHox
	 YojUxAd0DF0XA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v4 01/10] mptcp: add sk_is_msk helper
Date: Fri, 12 Dec 2025 10:27:11 +0800
Message-ID: <e2727ba40084f261545f1cbb140a3fb9d295ba25.1765505775.git.tanggeliang@kylinos.cn>
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
2.51.0

