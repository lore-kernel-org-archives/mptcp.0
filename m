Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75242D7D27
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459649; cv=none; b=H/2WOc5m2A/SRVmUXGuEaIS7OaJkNBqKZLADJZJ5tKaV3uJGGovxKoTDfGOitW9bBew0KanY+qd3/37YZVNk2yBf0+3HcGpwUXMB3RW6Sg7v04W0HPcMKIClHdzuoGB+LnkpEp7cQZgdLrcToGxWse+xNILE8dpY+JnHAMe0S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459649; c=relaxed/simple;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+hlwS2bC41pvIhXY3dFhPJL6hCJcEUfJrA/sr3go8E2l1LvPeqzeThT0HexVWHNlhbz3gsfzcgqSIHBPz7/daeBFSs8C7Uq0QvrQrSXyr/j+3RSnleNP96DD0hjiwEYk1u70+ijGKj5FCaodwpqEPxHU2NA4aDguPW07u1Le7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgs7h8A1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgs7h8A1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3F0C4AF09;
	Wed, 29 Apr 2026 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459648;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vgs7h8A1Bs0ccNIg5DHXdGQ/GxrFfal+Ly+NKLhmbWEZPFwuuoCwvzgAqPRPRgo+o
	 oK7TtOM/LTBY1lLNXmelDeI6Gqh5tk6nz+bfdh28bjQxChSSOdO+2eYWA+qIkCPtRn
	 wH8Os3h/M/6fBERczLtrDs4ITMmmQxSkhzE9vu5GnVpztB/hzgMR8dHak8BdxLzswI
	 HAvTs/Nw9javgut9VNGI9Vub7Dwg+gptUNQwFFggwe+v2XECxhrAJrijcJiO/byOKV
	 Soa9tQDnJrJvwRzHSCF8CKFZYkZDYJ7t9mb26xD6OG1w7unb2HyKapo2YFD2Mn0+zh
	 L5HSKB+pvW7tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 06/15] tls: disable device offload for mptcp sockets
Date: Wed, 29 Apr 2026 18:44:54 +0800
Message-ID: <76d9b89472d3b8f8a57087bc4043e9445db175ae.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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

