Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C6626BE
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803781; cv=none; b=jN76Bf2MU4i8m+CrZQOeOPL8JJp9XvHOhtE475C48VDYWC8qZaga/7eYdLX58IK1U3KAoEXyttlIAgHkSOXghni86O87iiep0ekp120Gu33HlAbcS8f1PmsOSanFY7xNIF4UHYive4d+VFdLjXqfFWRMq6MIRBeathkfBAoC4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803781; c=relaxed/simple;
	bh=8lytkz5ZediEVKO9v4YEKd6NPwx1gvUhp9XX5T3qsDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hy9+zMw7yZC8V85ZnZmvGkGJ2ziObvbZ4NV5BddOwdqZVd3zPLpP4ZipIpGuFwDwayxxE0QMgNkbBOU//bk+nQ4HSQhL1D9IOKJ/w/OrD8O7V+/s6ulIbTirLxPxuW31W2RplxtEpZ1FZSiS5K4mIH/FdxfxobiZB/X9/kSWLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsKkG5Xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsKkG5Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8102C433A6;
	Thu,  1 Feb 2024 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803780;
	bh=8lytkz5ZediEVKO9v4YEKd6NPwx1gvUhp9XX5T3qsDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FsKkG5XouZON9a17JDcbCqV33ketN35l59NeaUF5cJItCegw0EalaC5Dg8G9JOUQz
	 srcvdMLatlR4Il/KUPsabN+utO+ym1jUmNeVOmgcHF1yMIwcyeuwQNqEuKXS48dLxW
	 FBgSLDoYQLtM4G+QBtAp4/68EiwKSxGWyhBWVv6NC1dIgGP1qfqIhCVJ7TRZS9tMkn
	 8K9K5wyTdvCfkVE7OwyhU4nRVSmJ6v+tmEWP1ZxnfkbJcDT7Cw+RD93BfndX2xNWpt
	 XlTyeaNrMhJw5OcWVjdlodF4awaB9ixDGYJCfhNBqoXM90TtRDj5gUEyQqStL6mJzC
	 EOj3SEJk8pQ0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 01 Feb 2024 17:09:31 +0100
Subject: [PATCH mptcp-next v2 3/3] mptcp: check the protocol in mptcp_sk()
 with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-mptcp-check-protocol-v2-3-1e253ef51990@kernel.org>
References: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
In-Reply-To: <20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8lytkz5ZediEVKO9v4YEKd6NPwx1gvUhp9XX5T3qsDo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlu8I/EzanmmW+ai+Ih6dVpb7YU6+cXvYq/sTNc
 cYB69cggyWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbvCPwAKCRD2t4JPQmmg
 cxrfD/92+n8j7amrJYku8LNglk2PqJJ88D2LjUeOka8B4TxZRGbAjR9uFfF+4Q7Q4xbIcIsfELm
 KEOyp/1EMoyFv/0GhzqC7hY3hfutckgwYrjHgAQSBGBnKrNacTPJpa6duiuNk9krgqznLIpPZv7
 NUr61HQm58ye47smtvNDPSOfcWPIYDY1gXNsdkI20eqIIF3FTG/NqRtaxEpRwx4Yl9houtrCRn6
 UNn47fjzJ78pfyLqgSdWDprSq0eW0xcvRKSlbc8S/NUU09uKlYdJZlD1Pf9a7JM4UH3vxjI7AZg
 G7H1uKKN/t82DMlYAUUmIkpkth09rJwVfsrQjgxJojHUrMJbigF30WrT/Jdi+gtwz0NOnXMj1Pf
 1uhuRU+SF/DqAnWuYdTP0QAzhm/SkBwKq+3jrR2wILP7a54wgpPJTIU9h7ZPilWRobMb0MvEQZR
 k81VqiYXxGQJCzhaXIfUoUz6zPnMms/023ZjhepE0ZSH8ydcLTSLBwYy1BmTBAbIF3VcddhEqUU
 YyMlO2v1JGW8vWhhWJuGZlUJ7MmZeF+yeorgG+z3itkha1Y5yJSWtkIqXxqwT1gatLDIs1Qn+cB
 KCgwM1NJ5KGIPAP03WCyWjRu4nSdCgJoaeKZ/WLBXLj95NzkQn9AZqh8AXWujHUhaJjzIC2MrAg
 ZAhBM2FLyIFNP4A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when mptcp_sk() is used
with a non mptcp_sock structure.

This is similar to the parent commit, where it is easy to use mptcp_sk()
with a TCP sock, e.g. with a subflow sk.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-MPTCP socket is being used as an MPTCP one.
'mptcp_sk()' macro is then defined differently: with an extra WARN to
complain when an unexpected socket is being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  v2:
    - Use a macro instead of an inlined function (Paolo)
---
 net/mptcp/protocol.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f2473d9acae6..defccef59b3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -355,9 +355,14 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	WARN_ON(ptr->sk_protocol != IPPROTO_TCP);				\
 	container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
 })
-#endif
+#define mptcp_sk(ptr) ({						\
+	WARN_ON(ptr->sk_protocol != IPPROTO_MPTCP);			\
+	container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk);	\
+})
 
+#else /* !CONFIG_DEBUG_NET */
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
+#endif
 
 /* the msk socket don't use the backlog, also account for the bulk
  * free memory

-- 
2.43.0

