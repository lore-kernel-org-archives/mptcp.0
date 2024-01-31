Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE961272C2
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715356; cv=none; b=VWIlEkAf/kKuW/IMDJL+9x1jQFKZI/snHJys14GLSy3HyN2GUwXmgndQ0x4Q3GnaV2NBUdhSvk2ImIiPVt2bJ9oEEzEkZtosC9lqLdQyfuEcSAsZRXUu1/YTNQ07xi+CXQ/gb25xpWsdVkZ8Q7FBojuwplTPP+rs/mZwjezalzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715356; c=relaxed/simple;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbnetiJy5Wp5vR8ooOHQKGzRKTufe6AiQq/JdgRs7hjV8Y75EtaMg2fUvwDjYqA9ophXgmh4ojDHYGIOcnnotl83iMuk2CubuuTuz1yiMhD4nMlLSJ1dmUSr5WcYYZJzlurXnTeBigi8W8lVo3mk3WX3H9Jx7UuvOjEogjgh36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvCVn9Fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvCVn9Fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB17C433F1;
	Wed, 31 Jan 2024 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715355;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SvCVn9Fz3w+dIDrWWI4+GyVlEHsmKItYIIXg3KOmnoYxlLSGHbzHepgGb7Ejn/T8S
	 jkoOxwpIdzmf8xKvTT2nfFi/FGDhCQW5EOExG30GSxzLr78vOdjkhlUNFmmHzIamip
	 Qe6L+rwPx9/ZrGKe1fwK7Po9I3+zolvN4WCkfslIHAdtwOdpu7e/qVckRzhAwDLj3f
	 PTByO1hz1Ua+GhH7hVXymbNa/KdNlbw3aCwbybZfixxtvhXSySfM8Lv2W8B9CY4vEw
	 Qn0dVem0YiQLFWu/2/AeZVS2rIEeQF+k8kdmX0c1XKBseJlYUz/UzRCe5MPu7Lfs5p
	 SkH/aoxqBchhg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 16:35:50 +0100
Subject: [PATCH mptcp-next 1/3] mptcp: token kunit: set protocol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-mptcp-check-protocol-v1-1-a06067f0bd08@kernel.org>
References: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
In-Reply-To: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlumjZZ4AD9mBiyIct0XD1WCPheTPy1HmMpm9Dl
 cn0+UaY7XaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbpo2QAKCRD2t4JPQmmg
 c8gnD/9+qjhO+BzZdQfb1y9ToidHqDOASS3awhaloggHgP7tVUhU34Opx0hx8gLCOZLwMIllaA2
 IiCNQae9W/nYIWX+7rUNXom9tQ8pGR7+rAEO2inl2g6bWmn8yiqU1zfl6GUNEqDT7MN6McoNuyP
 ytCfRlxwwWjK7wbMKhm75GHGIW7qwaOQZM6jrBrAG4u8W+B5DcD5IlpQcqdShByBI3ZLh05cA2A
 aL9pfvmYXwGEqp+e+Uuf07360AUGsbSs0VQWCPMoZdppuyYNddDMHhiAcCwIDYt0XL2TdmMEoHI
 5ZBHcj+t9oc9HyjNldfXwgZNtvZOL6SEZ4EkOYivqTO8Mz3uRAUVSN5O+0DouUejVbJo3El7RUF
 FqGFi/O3t4QI892BaD1NwPE5VJgVtaVAwZclBGbnmnZ5A8G3IVFmZHOr7c36oVPazrCErSejDNz
 +kUtnJjU4fU+L6eoDkGyc0fWuFaG30S49CFd/+whQPc6Dm08/aCwwhILZJPnEXz4t2Xcu4X4uIJ
 d3Wl/bvx2FGRkLqbJYFYE/e0Vve+MJYs3JDfE1saAeioHHASLjDU0A/pXsNp6Bl6ul5fW8ZQtge
 5XU66DqWD7ya7SzCph9eJKBZ0eypwZpy2Ee/MzpTYL5BHEBNhAEib1xs7mw0sefJARu/ju7jO0s
 dDAhJFoGMeLlCgQ==
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

