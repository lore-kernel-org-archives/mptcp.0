Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B96264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971587; cv=none; b=Sg50nujfKY2nhUK9jwk+FKjJwbVAwWelX8Bke4UCZy9UcercJbRvNbHhjLfg0pFaau8odcyXE2w+4R+6wOJzRFOnMf/aFFq8Yi3d2kBXmrYLT5G9cG5tLX67Yy7HAuYrUB3l4zb4kpY9QPQ9yF8iVrMWoG75iVdFmUuZSYGNfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971587; c=relaxed/simple;
	bh=G1YiAKeuxGmjNW/LW5NLGQaIjbv75r1U5k8h6PMyMUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPkgPVCOPCo5B+8H44hqIAwAjEEg0iaBEWyOcOLxHNBN1b4x3mYC2PXrJp43tbsBwtJy1eBG6KIB+BafKx7JPZVhwTuMgDbGvCuRYylBKXGnRYk/2rvVG715/NbBSVaGCp40ksAv6p1k37UeaJLGmYuKDIugq5ZMY/6QznBXV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDXcBmVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDXcBmVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C81F00898;
	Tue,  9 Jun 2026 02:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971586;
	bh=w2AX+UV659DwcfB6hKqFldByCvZcsvMhYE3orNkWlnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDXcBmVHY57YpHnTS13PJ4IxOchThp1mQtgpi41OrHFKeoKIBqFP+wXFK74UvLTVf
	 6lH8kuiizjtSDoQibj18U4cwzZvOlSSUDexg0tkxjhJvBC7qdBik7iJjyivlGLxUIk
	 HEVW+ryCT+xl6yJe8Oks3rqjbMZQ2QOs9QCkV5G6O2Xoi0yvSUiMUqjOeMXIl85WrG
	 ivt0t3MOdG54U5/0389yYyGvc7q02qeWfYy20sFtlDF90asgtQn8LODcoo37D/CSQ/
	 /00Yn4QkcOTgf6SXbfqUl+lmzuYp64DQ06/WN545IK8uzUGyPvh0yxk+6SUHgW3COM
	 +QHqFxBS6wsSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 11/22] tls: disable device offload for mptcp sockets
Date: Tue,  9 Jun 2026 10:18:37 +0800
Message-ID: <742032c69ba291edb8a05a8948d5c647e5a88394.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
index c44a59d9d715..e535edc23d0d 100644
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
2.43.0

