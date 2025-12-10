Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420623505E
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354364; cv=none; b=tiArzmKkcl2lDuARTTDwMYQzIxOqiGyzrTRXQzSQp0SylKmSrAEsCZHoHpoDL3zQglWG/nWE79bu2bLJiemQePPACZrqAKL1RgaeK+lgBv5aB9L5L6b37QC/A3jRfGNGfoD48/HMsewz30kS978oDhFmvp0TmX6K1Rbtz7j0ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354364; c=relaxed/simple;
	bh=ZeyCxId4knqELJNFu2u5cEEYTNvx0kHT/JwXrL0AXOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSQZ2NJ5CkORaXdqoOIujnED3/JPy5r34UjDoOOsSqiY01XlCdN6tkvXnkXL9CuyX4lKVSGGQ761/ptHPNPZyrrqJTGGHLgG256RZlbsLCzXT1UgrFsuMJdoDwQa6i5b8uxI/hKYcsWTHNq/0FEC/jXjaiq2nbsat+M4Cks7Mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDbnJsdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDbnJsdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D3AC4CEF1;
	Wed, 10 Dec 2025 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765354363;
	bh=ZeyCxId4knqELJNFu2u5cEEYTNvx0kHT/JwXrL0AXOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDbnJsdNLySmDDWhMeTTMvDkRQvKx4jfM7J6SgXzFj+6C4Qq5YFzFOfgcHKnkI3EO
	 jO/sG0jHBts3NubtDwj9B4Tuhg0EUb+DaHsI6BDqU2VUtUr4lQkcGA6zlxJSSBGeIu
	 C7fdHVUAEFl5BEQR1c0K7xMxuNEimiBfv+BYWJjqvkn6LYs3fp1GmQTf2CFIbK3r/5
	 nKJdNOYFfsp7zl4gqlgfgoGGzKiqK6C67jVsPEE+oM2uN6EHYHR1+KjGfhCRAfeMJ/
	 OByNulJvIEmP77fLSxnLUof52qDq2CEwcQtd28B1PLknibbZcJvQoMpnbqerdWNd9H
	 J0f+CZxAbimAQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: use sk_is_tcp helper
Date: Wed, 10 Dec 2025 16:12:35 +0800
Message-ID: <f33c663ae39d50dbca2623822519f5628c04f9f0.1765354225.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765354225.git.tanggeliang@kylinos.cn>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch enhances the validation by using sk_is_tcp to determine whether
the socket is a TCP socket. This approach is more rigorous than simply
checking if sk_protocol equals IPPROTO_TCP, as the helper also verifies
sk_family and sk_type.

Note: The modifications in the bpf_sk_stream_memory_free section should be
squashed into the commit "bpf: Export mptcp packet scheduler helpers".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 4 ++--
 net/mptcp/protocol.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index b261551f5d1b..372a21b96495 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,7 +193,7 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;
@@ -294,7 +294,7 @@ __bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
 	const struct sock *sk = sk__ign;
 
 	if (sk && sk_fullsock(sk) &&
-	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	    sk_is_tcp(sk) && sk_is_mptcp(sk))
 		return sk_stream_memory_free(sk);
 
 	return NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd5266099993..f418a0a0fa51 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -399,7 +399,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 #undef tcp_sk
 #define tcp_sk(ptr) ({								\
 	typeof(ptr) _ptr = (ptr);						\
-	WARN_ON(_ptr->sk_protocol != IPPROTO_TCP);				\
+	WARN_ON(!sk_is_tcp(_ptr));						\
 	container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
 })
 #define mptcp_sk(ptr) ({						\
-- 
2.51.0

