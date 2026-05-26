Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6123D79FD
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788818; cv=none; b=WoLo0pMDyihlFMbD8Be/y+q1RL2aUrXXUyfqewVo/oL+pWYJReP2QY7wnnb3LtWEA5tyV5ItLQSgNUbYcCkBg7PPP3e3/06/dJzX3qQGnb8jRTfWePN1Y68NZb/rVj1Y/w0OHrHgAKa5Rci88WLpnVe04BGTbIeGXygoDxsS61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788818; c=relaxed/simple;
	bh=hrtN9uQddVM0lcmO9wc2o6AU3IK9pMQ70Z6iH5TPITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/7Y78iFS0E8tb8o4wyI5s9yQQeMm+2xLR4aDt/mPFTm4txERyVK+pTFAvhRZ7kbw2RrdfJyphS5osN7tfghNbl/6HDUTxSSkXllDLTqJdh9B4nNUCP+rlQpWSPX8w5fgfdqpPP9RJhJxV3txk1POfysBfFg+0Pop+w79DMNI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVH3JFLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVH3JFLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4F01F000E9;
	Tue, 26 May 2026 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788817;
	bh=NkVnihIy31dIAYz2JOSqK3T3ETJqUTTxorUyuRboKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVH3JFLSFWHHqC/AgcG1kePrjccRGPZR04Jb1xijQ8OG/AB5RBzllvyYHbWSDtCUm
	 T6n9afGX0anPwvLsKHoN1i0AVUrylS4fCQ89hv+SpAhf/WkQ6WaP0WXKnbN3clMHbb
	 FZud4wKM7LqpfGQfK7CKpnpC8gQ7Rh1ODNqHANYbuvPoyjy5mupuJu+bIz3Bd0m0+F
	 Vw+Py+oiDqnpJfxrxFluamVBmqoKool7nVW2H8r8L+jQcWKk4bgZy0X1t0L4H1/vla
	 WHy2KVV9RtczR7KiTxZlFOfy/sNVZfJ/vAml1DxeNRjzcrGoHtt/OzuWDptZlk48aL
	 Q2XivbWd4mfFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 06/15] tls: disable device offload for mptcp sockets
Date: Tue, 26 May 2026 17:46:24 +0800
Message-ID: <22744b1c36f7d0eb1c32d173a7f9be24576d0141.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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

