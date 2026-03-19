Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D338551B
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914951; cv=none; b=lEoqXjyXD5HRhrrYFjUSsCdCFo/y7RP36yRZeQVG6NM0XTWuraIZegEhbZ9ZyArCUavqxYnwAo5CY9+G7QzjIaJaPDoADed7QFfz/ywaxSTJncOdj0rrEH30napqTUmXWWve1xZGD8e6gSfEMqgEQcga3YRTm9Fw0g5krRZ8YNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914951; c=relaxed/simple;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2zHa1qt9IPP2x7UEvJF8aMSkIkeoEenklSrNY/NMahObATCj2nFaxFQWfsd+THypRQPKtzcYnA4p/dADga0p4pAGMCwfNFG3TCFZlVMr6EKewQtpEeJu2lAd3qo0kCY91FJm59hs0CRMUweVvKgXnRCgucoFw4Sj2TwXnpwVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+UMH4cZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+UMH4cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C170C2BC87;
	Thu, 19 Mar 2026 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914950;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+UMH4cZ4BwfmMJ3cjHDAxcahoj1nQ2mcQlA/Efrk68ETAZaHKEHgdMl/+iLX+IRF
	 pwH6e7h0/UBMGLvWye7JfDFDzEJtAvQc6CO8tt1jte2eJgEcRnI1ayGnSDt3Kgt2ic
	 9jbfM/3Ea1waCkhgPw2zQRgktPKf9PXWQAuENOnGp+Ge2Ntt+5haFSN1G3eOH2M5Zx
	 eX+BzwkUZinQyZCmegnURhyCByVyxYn/wmdE4bmd0LLISN04s6K2tDQdyvAeTFVib1
	 RcNbS2uvtVnAFxvsQN5ukTpOQ0Tn2Hxv/ENybI6beh+8g/4UShoJy6D/psg3hJup4J
	 WzAR2fxMk6B/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 07/15] tls: disable device offload for MPTCP sockets
Date: Thu, 19 Mar 2026 18:08:40 +0800
Message-ID: <75c8462b5cda32b42c56642b6c59b28a417eff82.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
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
2.53.0

