Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF24F510
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368271; cv=none; b=LXOsK7LC4A2ZzXkwWhCqndw3LQpNFvEEe17jhPQEf40g/wxaNHM//UyHsGV1XkTV664l0KlEmihDSKcA+lHRUprSB0hLTshvPKNEir8xuT2d9r9nZW0ZycsBfDG7iH6JTVSLCp8qSdkAs/t7NUs3nShsQsqFFFPcvhBYNP3c808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368271; c=relaxed/simple;
	bh=Hsh22vra6lgCNr/CR6pobyolGOO8LbU8T4xyZfbzGbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZJ30O3sWGY434g6zpNzBp3iavHfSmzqgKdSn3BWtN5eDq16lM2H1mPR2ZZUEZQciPmO6OU+umnyVlUP4uVd2Xg1wbLJDQUvFjLghl45TLPeuVo6ueTwkhIKh9BhdsHlHI7KoMtscfFHd6BPNl9VaYSKWx/bwcR3vHJYWQs4AsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsYPjwqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsYPjwqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F204C4CEE4;
	Mon, 24 Feb 2025 03:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740368270;
	bh=Hsh22vra6lgCNr/CR6pobyolGOO8LbU8T4xyZfbzGbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsYPjwquh6EXyBnOhwXn5HX35kslEFvjCBWQnw88TrdmfZvirTEYEPGgevXeiNFQ9
	 ZdXKl/gmFP9fSn10eNMA3M3u+YJNeZcobOzF0UOtUOgtU7CsfOyijsZ1LOqIpKhwNP
	 38ywa4BCcZxDgNl+RaU/lh4ihqqbkV1bzFm6JIb3iIkO9jQ7/d712TlPyeTQ44jgPk
	 BS3w+FvXTwiIampbebCCYSrslFaxSIJu05VS+EdI529hVNdyFXaAc3fmgNlqXg4fGJ
	 GoqUqLg75ueKoZRsF7qrGR2QbShvBaWWOliu7XFcSRefIm5yiL4Qs+Ja4WEgn8HlNo
	 HN2IAtiXBAV6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/5] Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
Date: Mon, 24 Feb 2025 11:37:36 +0800
Message-ID: <e9d69823cd491ceff981f70c5d864862f5128b1b.1740368110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
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
index bcddaf0a588a..6586906701aa 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -362,9 +362,9 @@ static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
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

