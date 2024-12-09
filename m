Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AC1EB3D
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734043; cv=none; b=PfZtSjfoneXVaya8Aw2Mc7CmqOeoxWqst7dEKMHz+vQ96NvvRbLJIWA6Zo6+iFIyqhpHNlsiIJjtvW760J/JDbZVhBgahLPXMyaDzd5U2eHUgp/Z2j44f+Az8BDelsUMyZXQHx3YSVFtjbXctfyhyVxz7VT1UAQIdl/M9fahWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734043; c=relaxed/simple;
	bh=64HULWyzXDYk7pnekHwq+De85X3l90hy6SwEMfu9TR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sssLVy5kj83vSgTfKn8XNOspJeO2ref00uyMEsM1fZb6mYnIAsLzARSsEue/Xy0Ni0uyXajYADuzyKXh2z0IW6+LEq08S1Q6WL7wk11XRZXJuZTtebXN5DpZQgjCJbFSc+VV6vqmQl2lwmI64+ywkZqkCJpFWcqnbQfyJ6LE6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGslamQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGslamQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8609C4CED1;
	Mon,  9 Dec 2024 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734043;
	bh=64HULWyzXDYk7pnekHwq+De85X3l90hy6SwEMfu9TR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGslamQhotlJo42EqI2Nv9W0gJFqkm+PaAnETWk/DCeMLe3+t4ThdkStHyZN3FJyb
	 XWidNEOp/HNbLjnoEEhW+qs/iFEmRcYZn3KJu3klrKmwzf2A5CTObs4yiL4LdmZNg1
	 IaKnY72jgVmC2m035l/4grUIDix45VwACKmjp01xvUuR6yTO5TXnBAJqIUvNrgXXZE
	 Eq5U1KmvosdRBN//5PUg5q3APCK4UMhjxXgJsvAFBpynf68etwh4DLrMP/ZP9ohNuQ
	 8AAUafClrpfF2ChvQ+d166XTbxg4p8bvFe5Nt1lheZi4mz+Z7FLfbWKdW/Q8qVgGZr
	 HStl5nKrBFunQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/5] mptcp: update bpf_mptcp_sock_from_subflow
Date: Mon,  9 Dec 2024 16:47:12 +0800
Message-ID: <8f9c34611d46f96a0047928ac41b385faf743805.1733733573.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733733573.git.tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The input parameter of bpf_mptcp_sock_from_subflow() is an msk subsocket
of type IPPROTO_TCP. This patch extends it to accept an IPPROTO_MPTCP
socket. With this change, the function name bpf_mptcp_sock_from_subflow
is no longer appropriate, and it is renamed to bpf_mptcp_sock_from_sock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 4 ++--
 net/core/filter.c   | 2 +-
 net/mptcp/bpf.c     | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..94d5976f7b8d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -322,9 +322,9 @@ static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
 
 #if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
-struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
+struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk);
 #else
-static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
+static inline struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk) { return NULL; }
 #endif
 
 #if !IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/core/filter.c b/net/core/filter.c
index fac245065b0a..9ac048f0c5dd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11836,7 +11836,7 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
 BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
 {
 	BTF_TYPE_EMIT(struct mptcp_sock);
-	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
+	return (unsigned long)bpf_mptcp_sock_from_sock(sk);
 }
 
 const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..a0f49af85d57 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -188,8 +188,10 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 };
 #endif /* CONFIG_BPF_JIT */
 
-struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
+struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
 {
+	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_MPTCP)
+		return mptcp_sk(sk);
 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
-- 
2.45.2

