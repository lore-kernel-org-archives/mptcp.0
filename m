Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139130171C
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926015; cv=none; b=oflimn9RtzjbDoNXGAsTOmgyAJ0E+O61pX5LqOFY4yKXY2fsXyyW6ErxMuNfZnRDJdUj4Ku1F0+rygUjrYV8MF6edBABwnn9InknNTjELN4CZp5i8o0grR430sz8riwDS94NWiYtrsm+0eiz82YstXMDNf4vE/CgaSiFGDxp9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926015; c=relaxed/simple;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ioiw5i/JXjJ1hCswy01cB434r0o02CJRTtdrrSw+RTF+g0CeD/78dSbXRcnucNokUOkjnKGL8Exb7MtXEFo8hFGTT1pMEIaMFz44WcBmWWUD3kROPEBUaoPmuENbWCTQpzfOuNSuQsxXHOb9Z0wDlutepofh4KQ0OxM3EbELG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erf/AtWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erf/AtWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B06FC2BCAF;
	Thu, 23 Apr 2026 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926014;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Erf/AtWQiYK9cwyLhhz2JMUJrLvfmx/u6zH5VrlV18pg8n8UUCJ06zf31DY4PzS6F
	 LrRV/tIRrmZ8zXG8VcWdLaxqf/qEUJFxRV7//KxmFta5uCjFQl01ZNXm1isMwaNrkM
	 fBwIqlMTBOZfnv6BIhO/FKrNIHiYW6oJayqsnVAkxv1AYL0D00PGU1AS8eAjrZZX0c
	 ZxcAns18PL8JCVt3h5lJdG9DAcee1CWbvfUV53hYudrCLT3pxsDuxt/nhDMHnxfiJl
	 Cjvjvc+wGN6mgKeoaLnU2DRZXv85jJ329xeMFEdxvL59pleds4Vpz44sVJ22DNJpF0
	 jrXjj/35aY6Vg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 07/16] tls: disable device offload for mptcp sockets
Date: Thu, 23 Apr 2026 14:33:00 +0800
Message-ID: <6240207baff6bfea8fc3931deedb018b23f0d973.1776924682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
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

