Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868434DB6D
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469710; cv=none; b=j9tcg8cmK9QZ4T3+HQk6akNs69weYf29gqtEd+r9mr+56ohcSuud3Fno4biLbWkbNTwI2Zi7L0Ufuq15FBL8B+MZhRSX8d24WiLVy596saUXgIqAWpuUKmoYTTzuZsL+rMjlbqAdRjuJL6EJot+kpJC0PaOsdnWN5xJNzgTIq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469710; c=relaxed/simple;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/RdhaYoH7dZ1Yyftet0Jy/Vz7a3hHZgTnt8Qimjqw1sQdZcJPSdaXhsnsUoeIXQ6GR+ndIo/7WZdcXwnawVRMvRIbCDMw7MK36y7SRDLwaK1PW6/CtK5F5CSfzdSBACksMz4QzaueLt0OL9+8WyPhwt0WKQxzKts4xbtPiMTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKhtNdXO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKhtNdXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EEEC2BCB3;
	Fri, 17 Apr 2026 23:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469710;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKhtNdXO+RM7ERkIoUzOWhtmI09Ah9/auE7ebLugFw9FQDwqgRfTaDyDPyJx5xDcu
	 2mqk9hou5TejEYzCcxxMH2MAcufJ2hs4IFgnLu6dBTBzI64YPPEiQdfi4grH26kj/c
	 OUkqvZrKRDJSld75QVV3NAoE+kQ1KsrDGeIeO+eRo0SmFntsgtHt1vmBLezL/ghVBy
	 itG2AU4FjaWL1un0TA1v/WpF4SC6SeJeBDsPZJKHRk5q5OroBiOIsoYy8SuI8q76Lo
	 ENUrGgZq9f0Jzt/LWpaSQQ7KTcUVEyiIvUCx/LOYp9Pe0RHtzd2Yi0ur4kuZimt7ts
	 niccX5sq+edlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 06/15] tls: disable device offload for mptcp sockets
Date: Sat, 18 Apr 2026 07:47:45 +0800
Message-ID: <f4978e1eee21551d00d894f653245808b71a8dcb.1776469068.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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

