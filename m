Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7A215F68
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788451; cv=none; b=gc7IWcjOjT8nipNS7W8wQxFMfJFiKqSw7tY89jDfhNe2PsYo2hhcTkUAwsqcpGYiN9+dO1r0XlqJXFbv1LGPuK+FQaeRoQGF8my1GahSV3gUnLbXSvBbDYcHA0hAC98GK+cQLR4AkxpnGAR66NVfjlWx4DbMVKXubDBD3v7E39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788451; c=relaxed/simple;
	bh=7+9tzmSBEyJZstB88VcME9Hams9OlyqDoObVFKD9GZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaT5fOOd1MdDyT3/4srI/gGDmCknoB+N+QuIfBdvJDypK72QTS96pBEbXhugKoMVsXS3gGa2afRA64qTr510ZRgU6/jHHbvVcLUM+jw0ciQAohOfISnOwfUQUmFG1wrzsGvBr/y4K3G5/H0B3I2NP9Bje4uWyQ8x9JYRL3mT3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ5y8vFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ5y8vFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47238C4CEE2;
	Mon, 17 Feb 2025 10:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788450;
	bh=7+9tzmSBEyJZstB88VcME9Hams9OlyqDoObVFKD9GZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJ5y8vFslSM7hn6W2+8DW3KtdS/aM8EGs6tevmen4ZN4wNI+9jre0nMBfs1ox5dqj
	 awgtfdUGCY72pIKKbOqb9dH3+rS5Xo56C+5jxHd8xpf0V1sprp5626H01tY5JBxUth
	 aUSD5HY7lMr3aBC5mNj3edgy2EpoPvfPI8uSh/f9N7JTav3KMaqqG5vz3Z+zykmAAo
	 edi0NmoR4gus5L136nrMbrDv6fbfeNv0TOwn15uolJe5+oheRvwAJVdZN3ldBFxMrR
	 S17iBR+wXDlt8eIzFsjbZTBa2lpvMO3gVDTdVPyZn7n2URhsFht91b2vgFj3UiLIZF
	 o9RIm4mj/wsqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/5] Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
Date: Mon, 17 Feb 2025 18:33:58 +0800
Message-ID: <0928d84e9ad5ee43779dda3de9be77ad28006ded.1739787744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739787744.git.tanggeliang@kylinos.cn>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_core_cast() can be used in mptcp_subflow bpf_iter selftests to get the
msk, instead of using bpf_skc_to_mptcp_sock(). No need to add this patch
anymore, revert it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h |  4 ++--
 net/core/filter.c   |  2 +-
 net/mptcp/bpf.c     | 10 ++--------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..2c85ca92bb1c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -323,9 +323,9 @@ static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
 
 #if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
-struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk);
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
 #else
-static inline struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk) { return NULL; }
+static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
 #endif
 
 #if !IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/core/filter.c b/net/core/filter.c
index fc094e8d53d3..2ec162dd83c4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11843,7 +11843,7 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
 BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
 {
 	BTF_TYPE_EMIT(struct mptcp_sock);
-	return (unsigned long)bpf_mptcp_sock_from_sock(sk);
+	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
 }
 
 const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index be222fa5f308..7e9d9c9a04cf 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -195,15 +195,9 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 };
 #endif /* CONFIG_BPF_JIT */
 
-struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
+struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (unlikely(!sk || !sk_fullsock(sk)))
-		return NULL;
-
-	if (sk->sk_protocol == IPPROTO_MPTCP)
-		return mptcp_sk(sk);
-
-	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;
-- 
2.43.0

