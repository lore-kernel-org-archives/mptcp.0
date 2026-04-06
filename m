Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39893318B9C
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478009; cv=none; b=Di1EAk4FS4nBRK61avJcu88dVxjHP4SySRLtDHtaOISI2fo+D0ww3tMioWbwYJVEFNMG/dzjWCJ62H5LnCfZeTo5ovcNQULtkKNvjqL9QbG1FWxmcRbtAAArSI7DNrlBiexb54zqUNkr4hR3s4e9Ak3ISHB5zcqRtlg+pr5l//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478009; c=relaxed/simple;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxTs1rxw6W1Rirg/o7F/3Y10PJesZ0Rr3O1PIvPdk4D9ZipBZX9E5Jqh7Uxw8dLfTa6OyWxZ2VGnXpETIfuDhdf7ORwhkOyn2GBout2YNQgtDIfyQTzuPVrlAs1mwDg5MPMgDzw6cFhYiAHb+L/YKENWuyHhc+yi0CLX13gwnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcZ8pS96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcZ8pS96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C4BC2BC9E;
	Mon,  6 Apr 2026 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478009;
	bh=6GzcsaFMq28d0FWn520aOq92c8IsBigTgiZ49vjCiME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcZ8pS963mEhOzhI9TtU9cEX+60o20EIOOvnLvja1du9uiVg5uCQdIpdLxrCkLoFr
	 8MS/PWple0EcE99+Ydxd3xUNRqbiEFXcB/aqYreFl7TBL0gLUIbI52EJ77MMOpDMgd
	 VRLCB5Z5g12wqje5j3WgeNhtLXaLjRk0IWSaAlgTjtRdV4ZgNfjSsZTx/pld4AYZxg
	 Romt2t2gi/Cqkb7unqRJBhGtQsvjpfZNVMyd48PCLddYCrxSmO3i0DrF0B1W8cEtUp
	 pBqBq6u4omrkI0Qhry8pM9+kSpnOotEgqIrc28xqeT0PLA0x6eCv1Jv8p0VLLp9qx2
	 RgkDKDD0gRUsA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 06/15] tls: disable device offload for mptcp sockets
Date: Mon,  6 Apr 2026 20:18:46 +0800
Message-ID: <2509eec8a60a3a34074b11cdab205fcc634a7d92.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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

