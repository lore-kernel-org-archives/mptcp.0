Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732236EB6E
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715358; cv=none; b=cjO6nCd2hbDAHnbl/Kv4jK6WCpdHd+N3dutE3uw9Fl0PpwsywgiKyflPvvB703nHdDPNnhiWVBOYp4UtM7MW72x8al6xRMlkWainm2avzEOQ2B+/eyII7Q7oFD19tZHI320mVFlnneKG31NSJIQkE6HnhGvyyT0ExGJiN/AhQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715358; c=relaxed/simple;
	bh=+GdEAw/qdifvpl22bnq/eNWaRfJUUz7A2fptAPl44tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAD6Ru1wNnqppLLDW23z5pTX/9X7tMliKC/MOpoE7j9a8KkRLHPm9SkPEMr2KYKWsF/iIYxDDjft3IH1cpMtaU6c7lxr2MQXhUhbaVxQ3xF59rIhHHsk43T+mJA5kk0KBDuhAfrN5JsCU6EIuMWoOdQycBOTLi9DQage9+7yqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpOqy4Rs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpOqy4Rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C80C43399;
	Wed, 31 Jan 2024 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715357;
	bh=+GdEAw/qdifvpl22bnq/eNWaRfJUUz7A2fptAPl44tE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PpOqy4RsKqbNoDX31HbGpeNi0IoJSUQ26nufXN4e+XH5TLUTE14ZePCihqCCNz4UI
	 gCYMV8blxpm6Bi/O+bCnD7Qq/JsCVx88sw/0a4HhnBFzuGplwK67+2XrxgJquRvTqe
	 /PKoYpbhh7dyCkW2HWDhyn/5B7/8jOHzHLp0UQMpePWcKY80KbS9w5sONrQ1ZPCtdN
	 2kZmJBn3L6Kv7PZkuFG69qrr2NGzoOTKuMAr18rbU7IApKjAYtqoD6ssJbIEsqoQa6
	 ZH3KZ0bFlAPQH7/IhTbEPlSaZ1/Q6utcj8bgUTYumBbN5EpYDnLnYx/YyDXr3D5L8q
	 4EnHdmhTs1cTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 16:35:52 +0100
Subject: [PATCH mptcp-next 3/3] mptcp: check the protocol with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-mptcp-check-protocol-v1-3-a06067f0bd08@kernel.org>
References: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
In-Reply-To: <20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+GdEAw/qdifvpl22bnq/eNWaRfJUUz7A2fptAPl44tE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlumjZFGxsc/Ri9+EDDqkk1X5jnz6QNOwoeeq7t
 Qs7bodMQj6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbpo2QAKCRD2t4JPQmmg
 c/wkEAC9gQRZdv5FHuuTAw7GaXY1+6/CRbzgVPvAej42qHTKsU9g8/N3ZSs7w5Y55yhuXp2heik
 HhrfpkvAsJLcaqKv+lI6+3WsghGmOPd8/fAOm0bRPU9SKAhj5TGcJZKtZoAwKb9WEccK6/AGAb7
 /SoMc6iX3p3zid9quzN17Yk6KhDCfEdR9/jGlcRnriryxM5j0UA5Nr9gYZUTWRXEsk08f6BqUHD
 hCsmAgV7SpF/FiNgCWSKPT0a6z9vE/2g4xLor+CaijKeg0MsZjyJkUqypQ/exSAHOV6l+Lz3XXf
 gaqaw/A/VZpMtwqjpWN7ovEWP9L7B1xkCrYwq4pdyVOsIVOjR3lqCjCpEOVTmdJjObG1jARRqKK
 Xr0S3DMQfYaytnjtovITPILxWoD+jkbEBT3/rBqfMwsc/2zxENaYRt2ssIl9kKekGCBFR/AM9LF
 PHLRi1MDuXa3yyg7ULM+b8Ft8xJtS/5eQ86z/7u50HOvNvn2dapAJqnEP8WZffRCxogxpiweujB
 JyjaVNdyRnDrJsOzEt+X3Oc35SdRXoRyZsrrfjf6j/SXc9ZMVk28wObMZ3Ru1TnhCmgALYZkE0O
 11UoQsd3/vXanmb2vjl1iK3ekbqxc8G1pCCwpfNb95fyQSl3UPZaGRlYp0s+BLvvNL1snL0akG+
 G8It3U0dyxlhG4w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when mptcp_sk() is used
with a non mptcp_sock structure.

This is similar to the parent commit, where it is easy to use mptcp_sk()
with a TCP sock, e.g. with a subflow sk.

So a new simple check is done when CONFIG_DEBUG_NET is enabled.
mptcp_sk() is then used as an inlined function, like before commit
403a40f2304d ("mptcp: preserve const qualifier in mptcp_sk()").

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eefd1397106d..c10c778cd773 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -348,7 +348,16 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 }
 
+#ifdef CONFIG_DEBUG_NET
+static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
+{
+	WARN_ON(sk->sk_protocol != IPPROTO_MPTCP);
+
+	return (struct mptcp_sock *)sk;
+}
+#else
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
+#endif
 
 /* the msk socket don't use the backlog, also account for the bulk
  * free memory

-- 
2.43.0

