Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CE329E6A
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622653; cv=none; b=aWRYtNRIGwelDL9/JC9GouiOpSb5y51K2s0MUhvXGjgPiOmAloR3ntUZbtz51GRoG/299Dfkg9GRROZBuV/wufHsTv6/gqqKrdZUgTehHMV/p6qO9dnpigUn7hMNErJww9ByTjLa8Pvo6N7k/H65b6yjzpa7NEC5IZpmZvkvRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622653; c=relaxed/simple;
	bh=hrtN9uQddVM0lcmO9wc2o6AU3IK9pMQ70Z6iH5TPITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBesf9KrJEfxZDOrkHHiOnn8ieMbL/jbvtA0OJeyKjENM7SYqp2IMfilIww7AB8rAh68aHSIdzCEUER2V7zJkVCwIF42Z3anEaMFFYejhER1A2Oe5XwrsIKS108xPrKdxYChD3+NOcLogU9VXx70gST+RgU1soL1qi4Qbz/EXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSlPlyhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSlPlyhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587BF1F0089E;
	Fri,  5 Jun 2026 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622648;
	bh=NkVnihIy31dIAYz2JOSqK3T3ETJqUTTxorUyuRboKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aSlPlyhwrZeUvX1W3CBQLqALRXJMeABQOti1woSLkiq8Ne9Ms03xkUJR1ET23sEQZ
	 BdmU0uJg13ajOkHfGHuCbzI/3wVQlGrwYwYlGlKLA70gVQjhqDeI9rc0QXu7c+8nvg
	 gEI3g1AFT/whQ/DFjiQEnGsUmibfKBlJPOr0tJ6aqq/MqIQ0CUA5Qf4qrbnMeFf2GW
	 JHSXxmyH2dDvSieu1W497VxiVFSGeaIF33cuxPG7NmqNbMKwOXdJI/Weyl40TzrVXJ
	 csiAWgViuJDVo4+2rRZs3edqRZ9nWFL/FT6Bd1UNaZfeGAx+Irsc9bg6FROHdOR/I+
	 4zrjd4qDVLCGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 07/18] tls: disable device offload for mptcp sockets
Date: Fri,  5 Jun 2026 09:22:47 +0800
Message-ID: <5ebe902b3f41226014c04539018da45afbf6e843.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
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

