Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC33A1684
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960461; cv=none; b=tDjPB/kyyK8pGlx3R0wTbmhDJW0zWfu65I9O5aIAqbk7XyeqnRRIVNFxV0c4keZi1RzIU2IJi9nx09BqDD+0S0Dtnhjc7TJ9IN4c2iP89+JIq9qnr6lr6GBMQvJ0VelWQ1+xfrBdrWNtcWc2TWiBNEYKXMAYBn22fzxOfBYrs9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960461; c=relaxed/simple;
	bh=hrtN9uQddVM0lcmO9wc2o6AU3IK9pMQ70Z6iH5TPITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlPKwh0Ye4uuc1PLXjcPUnmXS1XNCGkJJyse5+1r4+esV07S+fSVvokMKvl3ha2Sdb0IAcre3tffVdWjA5Tr/BQzc71ZYnSpnJlCORajP20TQJbOaKND9c4xdowdE9v3FYvl8eLDFVe6xno96gJ//exK7shAk/xSVtvEPNidFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUiFU3zc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUiFU3zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B041F00A3A;
	Thu, 28 May 2026 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960457;
	bh=NkVnihIy31dIAYz2JOSqK3T3ETJqUTTxorUyuRboKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hUiFU3zctHzPjGmNXEB9jBwK7Dbc0qUmyGT+E3nx64W/elUGLiYSACqGefVNNDPya
	 bqw+Y81P4FnQOEnWuz5bxgcn3Se5xcA6pLVFLYQVe5oW3/bkcV2xzzMzzjMNGsRco4
	 Z9kl5xF/MIb/czEmIX+tkQeKoD3yPvpA90CsFR5wttKmEcPFdkykT2dW8Gyp/Bx91X
	 H3PkYYKGfsStTx+xoZD//WmkegWUtODf1v1wYzHS6ATwVdyjctGJTeIqiUfBWloVml
	 JjBnBfY1x+k1vvbMijj5BlBFYENCAZt3y17giNreHGro5nsq+sBIlaauUug9DkQEbp
	 C/8q/+PQzJsSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 08/18] tls: disable device offload for mptcp sockets
Date: Thu, 28 May 2026 17:26:59 +0800
Message-ID: <54c690a3cb104d125a29380d09e5fecb7de39cf6.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

