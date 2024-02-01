Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0E626AC
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803778; cv=none; b=esSaFlyTZTlHqA+HRR3cIwqa6ECyfNGJu9Lni8QlvOMrtHmGm1BoB9aKAfrsbMEGFEvvQXZ7cI0s36Ux+L7DBSvzkO9yGKhEGykI+cP2uQY9m183PaQOpNYu1WvM4aMM7NXeozEjC1TCLDqBvO3oWbdO+gVHKNO42LWQYhD1DCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803778; c=relaxed/simple;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+eWpuRtO39DWlWFBs61qmlRNwPD999WpceW243utSHPtgpHWfaJrWiq6dwQgL39pRI/C3ikYYjUitTZTZErTtC6AGJpqQjY/daPFTvMFpSIWFWjazAAbTzH/rr7W7ofswZEiaIED3m2KQD6rsZ07dUOt6erYrEKczOi+filQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBf1Q8bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBf1Q8bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC14C43394;
	Thu,  1 Feb 2024 16:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803778;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YBf1Q8bnTMPiKmXMXlU+ZZfRT/uXdaloYZWo3vGT25yX0UOip71RyPx6uzvwejXOf
	 BeeP0/WaKLw1eo7K7SYY5biGcZ2/RRXK7SEIcmRo4q+W/IgZEUBJdAVursZ4DSeeqJ
	 wILlTx7bzMxn4sKch5tzEma4L8IS5fjaav98v2s5CrB2KdDPDgPzfarhJIJiq8ygIW
	 frLrousqBXn/dmPOuNVSQgf8IKQlSnMpLlKKILq/wvepvDItsVxR0bj77DCyFPKcLT
	 kDBk++OujjUQvuBE8+RUICKYqI+lpBIjgu6f5oiP6s1amFwfe0J5ODHeh5+brfpFza
	 MY86w4GGbawpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 01 Feb 2024 17:09:29 +0100
Subject: [PATCH mptcp-next v2 1/3] mptcp: token kunit: set protocol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-mptcp-check-protocol-v2-1-1e253ef51990@kernel.org>
References: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
In-Reply-To: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlu8I/H/aveBrOlUw5UxsKxNVdUKGdJ6hQHGXtV
 eID7dRzQBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbvCPwAKCRD2t4JPQmmg
 c3ntD/9m+LmhmgUdspE3pZYISK91yp73IG3g+RvQhqK6OpAD5O9DkQE3QZqE/LmG3GX09GqBghW
 QhZ2MjxRtai8gIACmy3zlcXXcwdqrLJB5qC7occGc3HSoNKHzAoPMO1pqSb/iHer1GZ8FWAX/kH
 UAvspLon9CQlWacoo/QHgLTTdyR6f3lzIDXqAnxwKaSxDWdtW71fn5NsVRfQVme03yspc2k/Yxo
 wAD6lzcEyp/F2i4xjCj9la4JVqHDxYy9YcyewqxCsbpefh5hXkHq+Di+wVeTvLZue0RmdrmGyzk
 TuKqqx2HkCG4nZD29NpQFfa6KfZfp4i8SJtRY3DMsGdRZSy931Z1CeALKXaf+bJQJ0gXx0o4Cu7
 i0zRLHhH1WUngO1aLusx6T7JpA7Tc+VUuWL7lrlFTgVFfdq91KRYiGJgKh2oSniSqG2isuTFhOO
 1yc3FoXDpqxh31F+JMOP+/wtekRWk10lRuSfQi/M2WQ1g7NuyNF8NQ9KqVOY6SiTHXNSpzsDgGz
 Kiwx2+CO8z0+s7bI7z2QjeMaoPX4kCFejIQS29gKJxmILqdtYekMYvO5a6v2Z+JG67zwWFUtVxQ
 AhfTRKZDBXSHRy7am9cPCwHIBZ4V8tFfAqU0fRkuprFb5iWISCvu5YNe1Zd/57e0OhOrk9Gnxjz
 YtTnQnj8bCx+5ew==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As it would be done when initiating an MPTCP sock.

This is not strictly needed for this test, but it will be when a later
patch will check if the right protocol is being used when calling
mptcp_sk().

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/token_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index bfff53e668da..4fc39fa2e262 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -52,14 +52,19 @@ static struct mptcp_subflow_context *build_ctx(struct kunit *test)
 static struct mptcp_sock *build_msk(struct kunit *test)
 {
 	struct mptcp_sock *msk;
+	struct sock *sk;
 
 	msk = kunit_kzalloc(test, sizeof(struct mptcp_sock), GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
 	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
 	sock_net_set((struct sock *)msk, &init_net);
 
+	sk = (struct sock *)msk;
+
 	/* be sure the token helpers can dereference sk->sk_prot */
-	((struct sock *)msk)->sk_prot = &tcp_prot;
+	sk->sk_prot = &tcp_prot;
+	sk->sk_protocol = IPPROTO_MPTCP;
+
 	return msk;
 }
 

-- 
2.43.0

