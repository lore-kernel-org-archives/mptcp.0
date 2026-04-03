Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844592DCF67
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227975; cv=none; b=lJNJ28CIy0x/rojlYU/kUPH65PdAKPnaPjLM3lZPtfGR5jbCCKQsB+hIgAHGc98isxdOjN/7C3/Tu+tF3CE4f279BHZ9HUQjyeQURi7Ug3e3ozsXNSjbFhKbjKBNLqhsxDGJgS+RNB0sWTczZiG9YloKFOJYzhpaQLmDPKSvduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227975; c=relaxed/simple;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBRkpQMIo7QTOIz+xRz9cMphDAlacRdNOO1MEK2eGYoRYPQL8gIklKVQB7XIHUiLHAcHKIeZV60JuElKZ9TafFbstwx+8nmhPFQRVhW2yUr4+ZRr+KUG7NT2QOQ2TfCnlRJl1I5Bb7M+SOHy4hNzikNHMHPFp4zTPpdO6WlLKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLhzhO0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLhzhO0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA92C4CEF7;
	Fri,  3 Apr 2026 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227975;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLhzhO0vQdhWExRPv9Bog0y6BNj+8vFPWmvEjJLaMlyknXT83/Y8idesXW4cLJE7b
	 TQOMCWR/MCTDeZGQy9R6qJvE3o/S872VA5nQBTYYrJxeyN//AKs1K04+gkzRwWOZdb
	 sNiJfbjQGnj7YUd4ggAlObCAYVrLDZo/gWxyr4fC7CBJIlxvf332OZOabAydNtfup+
	 56/SWkiaONuSIH//8bWOS6Rt3NIhu0FH46SvqyCBzYgqy36Klt/kqMYHQIU2LhkOtc
	 DfPFLjsCKdBBAu6GsLiVnETL2utwu6qskDsiqAjrxC30+iCwpz1Zogg+M0J6OmfcIs
	 xSXHHsJy8ojSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 07/16] tls: disable device offload for mptcp sockets
Date: Fri,  3 Apr 2026 22:51:25 +0800
Message-ID: <b174e74ba8100627b4208620a9b7052b4ef86eb0.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP TLS hardware offload is not yet implemented. Return -EOPNOTSUPP
when attempting to enable device offload on MPTCP sockets.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 99c8eff9783e..6744c2494740 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1074,6 +1074,9 @@ int tls_set_device_offload(struct sock *sk)
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
 
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
@@ -1196,6 +1199,9 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-- 
2.51.0

