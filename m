Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624E1C07C8
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738470965; cv=none; b=V3qB5sOE8XExKOfv32IWhUROhkub2eKCBlD0oz8ulvYmDkbjY+pwqlHuTdF7Ba9MfKzUn48MhDz67XJuPoKfmYjn4lBy+A8GiyiZrJz9t4WkbjI2P+ZIUwkfl7CAJ4HLQIn/y8PoAYt0JTXEFkR0C6VAtblq9oEaPPdsUktC6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738470965; c=relaxed/simple;
	bh=7+9tzmSBEyJZstB88VcME9Hams9OlyqDoObVFKD9GZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCDnuKt+yOUfc2ZqhSVMlYBBE5KhyhRYov6A6CwFd2YGv+lNGVm7X4pCoYrUXxSY4OFpl9RE6erd5pVawdNyQfZvppCtPT+YAm3/29RFWO9kUwgdMJzjmNUPqkuUWM6Vh8yCuQixbf8KTGNbKD5OrshbfYH5a+sY7pPoT2dLDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA2xF4zj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA2xF4zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA6C4CED2;
	Sun,  2 Feb 2025 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738470965;
	bh=7+9tzmSBEyJZstB88VcME9Hams9OlyqDoObVFKD9GZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hA2xF4zjqXjM9+J/xPttin+BBblYrUwAsG7D9DbXVKUWS+Ni3zzgwQCE5MOTdstP2
	 2MPLLpP7ac5tgIzFAr5naZ0kr+iI1ITCJ3q+Cv1/mjQDXhG6KgbTF/tPI0HxwH6rH+
	 ild0N2kD/hiUpcgPl3DAcxYpBCSP+f9EQ0d0aWxfrKofPCb24qPPOZCM8djnx//4k8
	 yXY2EJzcyXYK0InZ7UHTg8NKxxGXCEOqV3wzDRNrSoITUv3lvPuyf67XYZblPPMcu/
	 aTlNF+gWQmOQi8t4bwhNPUHT/u4KGmm2AmdFiYqYMPD/tmlYXZIpoMRPKobSmygDYZ
	 XMWurLVok8VtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/5] Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
Date: Sun,  2 Feb 2025 12:35:07 +0800
Message-ID: <d18b087f8bc283ac0c5c224b3626b8ddd018092e.1738470660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
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

