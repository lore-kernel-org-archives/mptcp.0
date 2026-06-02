Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46823612F6
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367599; cv=none; b=RCQOPM+w+IZ+uvzosDIL9/c3hipvhAqBIjL6pFSDLd8c0pawdx9QfuFfbTtwF8y7TQ0ZbrfL8BVcWT6fsAVH0KpZuUyyIHj4r+TVHWX21qX51hT7Co1U2EjggeOyncTGqaB1wMxh6fnGOZXQtFp7gSbEAIksDwVxjgWkcMEvEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367599; c=relaxed/simple;
	bh=hrtN9uQddVM0lcmO9wc2o6AU3IK9pMQ70Z6iH5TPITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ+iFKYDd2LDcJcoU9nIoy8TCvcPXpC5jtDYl/K79kSDyD8gYeYeFnnJnchsIa1i0WHsR97WebVHWXqsEQAt79+aG0jX8uhoDSxHjN/V0QaMpNr+0P0o+9HA1gPWEQiyyMrhtccjANP2l46x7K/49xCFpxnlH5tfRySPMyReIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv9+Plyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv9+Plyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B23D1F00893;
	Tue,  2 Jun 2026 02:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367598;
	bh=NkVnihIy31dIAYz2JOSqK3T3ETJqUTTxorUyuRboKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sv9+Plynncd2+fv3g1vuJTVZnqfBVBQfSGL5e24kKuoz8jJWILv+FAupv/FTIH8KV
	 A6y1rzJeiS5xgQhqUBnRSEs93dhqHRFtf7bgB4oHYyZITQBGVLpSYmMFGzHuFLfEjr
	 ZwYXXVXKf9cHnp0xfEBIPaRPjkKJLQhexQGymasIFvLwshroZwgZb4r1FSs+zTFtoI
	 1Mm9hBF/4jiYOJKz/RoR3keCAUpUnBSg6nzNht4Bn8JNdNKk+H+c1O/zUgcJbOd9/X
	 EqkFDX3XrkM5oh4KyYC8glNhyI3k4tK0+9v968Jk/tGXbTCZVnWmQouZBX2zmuDMsq
	 Q0/fO7GL1pqlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 06/16] tls: disable device offload for mptcp sockets
Date: Tue,  2 Jun 2026 10:32:47 +0800
Message-ID: <8f1aff39dbd80ed95fe1ae269fa538a7b310ee20.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
index 741aef09bfd3..06f45edffb5f 100644
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
2.53.0

