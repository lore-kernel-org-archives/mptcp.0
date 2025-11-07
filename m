Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811213D891
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486686; cv=none; b=b0faiFRW2W7HRs8rhy4v0hUUVtlSXDrPTv6aUNa38/BNRN9eNFU2cJiiS4U1awhrfA6bMlXCJuQsWR6WODuLjVTCZ4TYmMEAK1szJGVoVHqxTPHgXmADXBbHgbBAFTEbww2HEA20q/T0984kt8fEXyROYrvPlH98FXDT1gHYV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486686; c=relaxed/simple;
	bh=QkjsIuCIOhTSaxj56q974+fJowLc0XaGHAxmxOcZXGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaSSrOFrrYdDjTIWZbw/dg873QxiryllNyHtdeaRuyY8deKFwAeO4FWHJi9c/XJeuIAHdsBD10esWyTcZwQDjVOmLFxGmxZai+1Fyr5tOTX5dCmFdq2i8khLHrZj7TNPasxAJ8jq9joUfkMaKY8FKVopAf/YLSCXFFDlEWVOMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+xcDimB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+xcDimB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F419C4CEF7;
	Fri,  7 Nov 2025 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486686;
	bh=QkjsIuCIOhTSaxj56q974+fJowLc0XaGHAxmxOcZXGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+xcDimBFijxP29I/+stbdgWDJ4wgwOBQ6n8J4O3XEvknrgs0nv78iEJ96fggrLMn
	 sSEo4KhBQldL6ON4ZQIulyOMUXhNuXkGtpQj5s15FdW4Y6WaFS86SJ+Im985/VFNvQ
	 nbNDz4EP77OQLyPcRgvKMDx2vRGNGdUSX3cfzvGynzodoHX6PcQ8JR+HEts/3qRxBX
	 f8NEGGjpu/vCSXPCD2s1uyORuQ6FeiLcl4wptNDbGHAIP5n6fVwga/gL04On7D2pgE
	 oEyGxXH4SLtVzD3GvV9eNbQny+conVRECbVLLHoX/UC3DlyytEkDJ1zNMD9wtUjkoi
	 5FfTrCqzuw69g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next 3/6] mptcp: add sock_set_reuseaddr
Date: Fri,  7 Nov 2025 11:37:34 +0800
Message-ID: <32da8f2876b30d35602232e9021d312bd105b2de.1762485513.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds support for the SO_REUSEADDR socket option in MPTCP by
introducing a new mptcp_sock_set_reuseaddr() function. The implementation:

1. Exposes the function in include/net/mptcp.h for external use
2. Provides the actual implementation in protocol.c that:
   - Locks the MPTCP master socket
   - Retrieves the first subflow socket
   - Sets SK_CAN_REUSE flag on the subflow
   - Properly handles locking and error cases

The function follows the same pattern as other MPTCP socket option
helpers, maintaining proper locking semantics while allowing address
reuse on the underlying TCP subflows. This enables MPTCP sockets to
bind to addresses that are already in use, which is particularly useful
for:

- Server applications that need to restart quickly
- Applications using well-known ports
- Multi-homed scenarios where the same port may be used across interfaces

Co-Developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-Developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  4 ++++
 net/mptcp/protocol.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f275eae0d32f..3488f3506a8e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -239,6 +239,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 
 void mptcp_sock_set_nodelay(struct sock *sk);
+
+void mptcp_sock_set_reuseaddr(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -327,6 +329,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return hto
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 
 static void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2285b651ebc..34aa3f13e5c1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3714,6 +3714,21 @@ void mptcp_sock_set_nodelay(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_nodelay);
 
+void mptcp_sock_set_reuseaddr(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	ssk->sk_reuse = SK_CAN_REUSE;
+unlock:
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.43.0

