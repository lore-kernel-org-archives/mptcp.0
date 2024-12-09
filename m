Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91E14AD0E
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724759; cv=none; b=FHVAqH9TaxIty19I7y0Zosv0feILa7UsAhICDoqXczYhXwUGM1eosdb6lHb5R2dyv6l+0ifvttrXm5JlNAeGcLm31eZuqi/09Rb4Ctq7YBkCqKCb2q70S3D+wx2KabuQv+ARtDKrrXZ1u8zEJrqdDxQcvx3FgEHWL/b6WPqiSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724759; c=relaxed/simple;
	bh=64HULWyzXDYk7pnekHwq+De85X3l90hy6SwEMfu9TR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQOPU1vuWOEZxmI8+6MUWnl2beTzVD5Vi2FLnzF6I2hjvjK8rUQx2YvJOsA331/6bz9UNqtFJvTtwmHXiDq/HFzQnOYugP0yggSWiPokCRwo8C5WH5ZbbHWzsRJWL6IzcpagtkDnEe1i2cM+O5Rbd0GrMj9vGl/YizRxpG+OEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIBABJO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIBABJO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7810AC4CED1;
	Mon,  9 Dec 2024 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733724758;
	bh=64HULWyzXDYk7pnekHwq+De85X3l90hy6SwEMfu9TR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIBABJO1Ol2GXd/ekgxKgEfpDpf4QF4SFS/JJRjdaRkJq/CPp6Vb929bRTjz0GfJt
	 bySt+Te/T2zKBXJ+oTRpAqe+iV2CcHuq1gqVdbEJj38gBvyS9m8sa8iL2pQgsPhPwx
	 NC64M5dlC+7Xyh6tAjbrnFgqnlfF01v9z55aPuurQbLDPxvsJ/MbEtGMveZXTqzy/C
	 SlCglGHW2xj3hncl4sXZVMKH/8vN+cPGITYGXhFiGTZHZJvZyFvwDO9rPiIGpYqVo7
	 BbfgJGJuOU5NWcm4mO/MNiDkafeiuaBSs6Ppd+8Y+YoEJ4w3G/xkJaAL8IUt3EWGfU
	 y2+yi6iJJFSew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/5] mptcp: update bpf_mptcp_sock_from_subflow
Date: Mon,  9 Dec 2024 14:12:26 +0800
Message-ID: <fce976c5f62f991f7f6d51a4d08a5f572aec656c.1733724383.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
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

