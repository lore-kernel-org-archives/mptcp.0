Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD56263F5E
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116088; cv=none; b=YjBU8Kg2UInexpLHAGtg0Fmm6zDLOvVft/1l9fqyyQIMm7+idkKKsIa7BBV2eBs6+dT2xGmrDWlZljH9vY59lEOM/GhvRbe5l2i1wb139LClfyPPWgJiGJKmaYdiTySBBaCyGaAxcOWYy30YaOsK/qJtnPI77a9njmiiFOgYqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116088; c=relaxed/simple;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUNWAQzDAU7Ybv+U2e3Xxp+joDa3neekG8fl+ONfhbxkTn2LPsr7ts1S6Cnd1z1RNFcfNDb6yTdzbnwWUowDDkR4Ah+lMDeWIMRNkqHshkyjHfV15K3h7WjqppeQkfFZ3EgW3/FWtCRBRCZ4m5Ej8Cy5jwsIQeTLMltm1dCqkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/eDnXAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/eDnXAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4000C19423;
	Thu,  2 Apr 2026 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116088;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/eDnXAqNeWgzGmkou72t8HKOdRmcufIToQ9t6zv4mBI3YK+GGOkO+n5fLilv0NB7
	 srmAzu8OMNI45qoYBuoNjqUXWyzQjDgDVBUCPq5DdgrJZ1V03yAY+RoXD1NNjCCgFv
	 DYaX/oRR1yYP7db+/nARTW/T0jsoCM/ndxMXC0p4eFvnn4m8X+UGgqxYTTfP4P84rH
	 UBWR4MXXX4l//GMGlX26qfgIJS7ZPn6Hpi68QcKw63aTsCc23jWfuar/h/6WcwqE3K
	 qWEip5zGB0YJG888/3b8/oWm09Aw7lw2uGrU9PrqDUipbQW+2t3rvNgno7kC0SV9Vw
	 rhIerPxz+cStQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 06/15] tls: disable device offload for mptcp sockets
Date: Thu,  2 Apr 2026 15:47:41 +0800
Message-ID: <c38abfe33a336dfc7f8baae2f7a6833e806ba95d.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
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

