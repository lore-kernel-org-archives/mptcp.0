Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C72E7384
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053275; cv=none; b=UO+lvLiEGweuaNwnt2cwXDXoCYRM10LOL7GonwZHO1/fdwJ6zVx72LMuN8wsYk11IZWUBBD46elcJHYmbsCq3VeqkUqRA95bUAhhi5uUvNDzaLdi9CVUgL0P+XJoqcNFMjVmrshLM58G3zjQPIiiBPH4jvo4ycx4pGbrnXa/hOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053275; c=relaxed/simple;
	bh=hrtN9uQddVM0lcmO9wc2o6AU3IK9pMQ70Z6iH5TPITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEW8KuB5ZNuNItCpNZ7skBhhOR+Kp6ky2aTbxP/5juEKIBFE7ZhO05d9E2WOsSWnzutNJoEaPGtpMn1IauGGPGt68fmh1D1oYAqCN9F/BxNLBZd0/MRyQRkPJsoqqX4ZibK4gv9S649uSs2x5eWToJt0z3wsTs3xcBMfnQG5ouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJnf9Ae7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJnf9Ae7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7051F00893;
	Fri, 29 May 2026 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053273;
	bh=NkVnihIy31dIAYz2JOSqK3T3ETJqUTTxorUyuRboKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJnf9Ae7tFksteXvDQZFZjJOE5cXvMng7acUwHctE9xN6OcpDKoAshwJQ/yIeNYNr
	 LUrtbRqzFkrpYJ58E0OH2YAR4kfVjTjEVNJzl9m2pOIFCKArykD+o5N+POkht99i0C
	 IiZWmOwNwOHUtfrmGIKhBEkN3MNPu3Aphahb6vXky9tHs1I6mGKdYh9ot7Dq9lPdUO
	 Vx1ufW9zkDiNW5vmmzoiNgYqgEfJgGlCjI8kkQ9oDBFg9DluuCCpRQQcloJeSb5/KQ
	 7q8msss0uXvfXilmLURbauyaK+jNy/eaKTJr4bCXFE7x1cJo8VC1gFqXGt+G6RJc38
	 wI9+UlMZDDSNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 10/20] tls: disable device offload for mptcp sockets
Date: Fri, 29 May 2026 19:13:52 +0800
Message-ID: <f87315346791706a1487977ac411ba64b2fd91a9.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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

