Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919982E62E
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307011; cv=none; b=PL4JeHhm+RwlHG0hMaKCT4/if63+Oq9P2IooYPXH3C4EEdH6yx9Hy3lwQS4uM9rPJnLVQStaRpw9XH4xXH4b8owYVEeVIiigbkluiEpTy8jO41ejZExr3aoWsMsAjT2GS+hKLWXmYgLzNLC1D9GJd8tW1ghA0B/iqR4lThZl93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307011; c=relaxed/simple;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPEMVCqNzmVzBxTdR+2K4HlWg5gIbWtYghR3VRn5V1kSVFPykA06GWLbQrp2c6mz/DPR1AonI36xer84meupdTy3oLKsuRqsMlPcVebgFtWo+/htfpmmx5mQ+FbEMgvTYQNKRBUSyt48LE3qrcG5yR2HvYPVnzXydF23rKhWycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9NigX7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9NigX7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67534C433F1;
	Wed,  7 Feb 2024 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707307011;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I9NigX7pty+cIOWakOYSVkUaGuPyB7th8KTx+G7i/qcnBpyu91u3+G7Wu7E8LfAkZ
	 muK7df3+ovTbhHNcJAuRkG43IHIZij1QNYB5aG0LQq1WEnt4334UziREU2XycvEV68
	 Id/LYl5zIkGMOxV2Xa7QE/Mqo7FMk9THpkKgfh/DZlR3j7YEyNyhRg0UDZV/PMod1x
	 70JzIFQ6DlZlWnvDQ5PtTgxMsbcjd6u71m0NeYdMWBmiBw3p2dWYlNwvqc/h1gNfeo
	 B+493IufYTao/RNBxTWXZvL//mWzExLHrYu6LmIiLmyLnFLUyYFMtOdLdCES8fwnHI
	 52al/Q3UgycFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 12:56:23 +0100
Subject: [PATCH mptcp-next v3 1/3] mptcp: token kunit: set protocol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-mptcp-check-protocol-v3-1-77c69c596f55@kernel.org>
References: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
In-Reply-To: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw3AAxAmfXkhgbYGgQXAFtNJAP+N/0eqM/NL4d
 6lb3dPctbGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcNwAAAKCRD2t4JPQmmg
 c7QIEADXU3Qi+G7NfdkMqsO81+hP3yzMbSImJqyIpOZ0+lut2Tq5DPdYj9HXyypWnNGDBo/QDvU
 ZYqcdQxj5oH2xmbEv702dvXWdFyDyJyDHBR42N6605lcWEL9TVMpLoJ8go7ewzhxKtGGLRTMVTb
 Fv6TD0UUS5PAmKPHjBNubClMPgOMbh4TGLkJPCJYPfGZwEKekxXI+9XzyXqnUwqHdEzpfgVpwTH
 iMFZ98852/EhKGUaHIOwgNr0pi4gMbU7fdD8UODTGXJJfa/+8/3dlw4zwklJ+c3xbeYozn9DcZm
 wKS9G55Ccf820hGDMlNIPOjx45ytq9roD1zFOuzFCY863RrYdHiUx2835/4KcXSsHbgHicUEKV+
 9NicISYTnrRABsR9OOIez1GMRxGtMh4U2cT9IdRMeeqPqmlNHyv2XiQvUJJdb83c4YrFYDHByxm
 Fnezxa8GNeJCbC+dnPFgqMNi5gj0KYQtaWuYYuSDNxKdPhlrxrs80aGgxgW87ricT5rwgwKonh3
 YaIrPwJN0DmsPt11OtCgxHSs4GBU8kK5jxDyo8tdTtCuzqg6oNLtDtlQzafT+DUSEc27m/YOFy9
 Rio+v6az03FDD/hKieoc/5GhjFbtww1RMIWqctRZbArQx2WFePvtEJXzX0XbM60emrOdvvjq/FT
 R1NInt4PoJO7sqg==
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

