Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A353815DB
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027145; cv=none; b=XbEPZDsoIjdp4Scjk4xoemH8Y+EWLS3gVZJPr+8iRrIRDiLmwAPTdf9hhZ8mYGUO8dDIrH3bOwi7fmdhcUWUPzCiiAWy62iB3Ad5KAolUiiVLwAdmATeLZ5z5kCSkWWlssiJZBid2Ye2Ulf3VGkfEOcyRp7XZ5gDl/CnU3kBAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027145; c=relaxed/simple;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLikj3kTdsFn63xBvRbwPn81lCWw1DU2jeN+GIPPpjn6/popGi/JTF8X90cM9YWZ5IkenBdYQ4q1E3pC7QDYQo7ZxI8yhZ8l4GFJ3pqTZFeiEOwFt8UoaAdRLEl5GniK3RF/64vQQHaPwllnnD8UNSBDFI2y/kUGJkXat2PfaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbWcEcaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbWcEcaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58078C19425;
	Fri, 24 Apr 2026 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027145;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbWcEcaGfNT6CuY8RJNCLZXoe1AiwR2VLxgpVOGJmNgUpgMvi/FerygpnP++rM8Ia
	 o5kNrMmRDuhjTkJh5nnhiLQubVv52siIhDhPnnDXqO3kyzlIuJsCBmRxLUd7vY1UdO
	 2N9V6iquCyxTwoivnGNAtEFBPb64nJCYLtuY9/Fl+kgchfi2CUA9pcGd9IqgmKx0ii
	 iddDojT8yZl8YbneTT0wYrsmiMLOvqkw/cNf6ja8FrIiPYAZaHKAY6CISj5mZNbuaf
	 EGWkqxWlM7UTmAXLN4gH1jVQS3G4SAquFc9kMDkNjLtIhy7YcB7jGSNwwZGUCK0+DH
	 vfmrnkvHR/9KQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 06/15] tls: disable device offload for mptcp sockets
Date: Fri, 24 Apr 2026 18:38:30 +0800
Message-ID: <7ec5bb82393099380e838dd98b7209d30dda972b.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
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

