Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A2205E1B
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886726; cv=none; b=l5MY2yXpXV568JKSLshTQyrcCb4t/BJpArWfpJ6yLGqpT7vjVn8PyXELk57Zb8LesYfRK0H6ltzKlzQ93IfOU/MD3NTNDoX8tk6teAHqA6/u3scDUOBXIk9xysCYANH6CTs/c/3fCzxaufn6qnYasOaiLifhBCEyS369roc36f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886726; c=relaxed/simple;
	bh=M01EiuzHoOxggISi5fFfJVRm9VtHusNpvppZs7ZUozg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdAXKV9olQeS2gUX6BwYf+tHaW5F+jH2kYLoYEsqBHoxXe4GzozeHbJd23e2GOfzybR2ytYXnb7ap16ODqwZhU6NMosUhk+EctcyRlfCDBYQoK3zlOh+73TzcNHFCc/zS57XsC0acpNDAf9nJRS6PVSTShNT+47XHUAsjy/VhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCvcts67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCvcts67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB6FC4CED6;
	Wed, 11 Dec 2024 03:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886726;
	bh=M01EiuzHoOxggISi5fFfJVRm9VtHusNpvppZs7ZUozg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCvcts670gIhCgHRYYLPNmbAVA5tkgB2hBWnWRfNtN5/ckPJrvRJYxZ9ibYMBYN42
	 bmOj8NqT+rC8cALaL3cAJQPvdEjuxmmnkN05rv6WQeBzF3frtoZSLzplm0EA1puplc
	 E2SFWmEknntnRnMoIOI0TDNy69e5IpCSM+goTOFEeBGmV9Ua+Llceil8aL86iDUShj
	 tnecvJhm8/s9OCnD8SHWu8znDlV2dvQ+aTwZAzkuD+ibLqSx2LXfpIjL27fYvUvIzG
	 ksMmgseqwnPp0GAciSNyfdm3Hs49i3+hJ0Z01HcbDemjEEVTyoLpUrA9/gQcNR7imF
	 GO7JtbxtwqvXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 1/5] bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
Date: Wed, 11 Dec 2024 11:11:52 +0800
Message-ID: <ab952481d5b3fc949c310d95b46f0a2612488404.1733886326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733886326.git.tanggeliang@kylinos.cn>
References: <cover.1733886326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, bpf_skc_to_mptcp_sock() can only be used with sockets that
are MPTCP subflows: TCP sockets with tp->is_mptcp, created by the kernel
from an MPTCP socket (IPPROTO_MPTCP). Typically used with BPF sock_ops
operators.

Here, this helper is extended to support MPTCP sockets, the ones created
by the userspace (IPPROTO_MPTCP). This is useful for BPF hooks involving
these sockets, e.g. [gs]etsocktopt.

bpf_skc_to_mptcp_sock() uses bpf_mptcp_sock_from_subflow(). The former
suggests any MPTCP type/subtype can be used, but the latter only accepts
subflow ones. So bpf_mptcp_sock_from_subflow is modified here to support
MPTCP socket, and renamed to avoid confusions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h |  4 ++--
 net/core/filter.c   |  2 +-
 net/mptcp/bpf.c     | 10 ++++++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

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
index e9db856972cb..1e8efe9cd4ff 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -188,9 +188,15 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 };
 #endif /* CONFIG_BPF_JIT */
 
-struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
+struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (unlikely(!sk || !sk_fullsock(sk)))
+		return NULL;
+
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return mptcp_sk(sk);
+
+	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;
-- 
2.45.2

