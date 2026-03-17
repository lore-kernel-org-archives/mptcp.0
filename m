Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531B35AC0F
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738825; cv=none; b=eUe/YfLikNi7SSdzAztyXUUji0Z4mNNIgOGX5qPi70RqHSUC1MkcUhnJ5nQTSI4VbGyK++TqAWg65ekd9PChzVLXGzRxu1R+W7lZiJS8gkCFqwC/z+KCKvTicgIa5pm0LiJDb/22vPyg8q6Qm2B08SIJQuqN4KLaJ4X6g/8AfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738825; c=relaxed/simple;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaNrVnt9hXjtIDX++d4BuoyKgT0YWnRqjOZIJAyf60515gbjnJ1Q2wXesPz8uDTGc4p/1yk0P0i/PPWYNBMKFmApGN/wioTIDYJYjDKpj0Dv9QTuvo2aW9GeDnmqwTiTYXLtGbgDmpKDef+zty8l6mvjsrWk7DPaaGNC6CLYjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU2PsoIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU2PsoIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB3C19425;
	Tue, 17 Mar 2026 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738825;
	bh=QCtkSjLWnfBnI8wObN2ozkvWfxp89TiXkwvv7ih34Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cU2PsoICA7t/ah8ANqRg6hmecYhAmUqeUX3YxbLsAvMqGiDXG+moRjimjoWAEJQoE
	 oJ3hwktYsnv4MmirerP2zy+bgX2l0lrVUjvVq4vFrllhRjeXwVTGKWk9DwS1brQN6k
	 ubYUfx+0eS8R28zZcjqVS0o+iD/ELY5MXLdkusPJppCKmXfSX8HgL01k/DNWvNyd5H
	 KxKZEUocE0kGOcbs7hYkhoPgJw5KPuZaEUKiX8/5Bn4KdkOPnp0mGM0FWn5McieKyt
	 Z92mYUhX6l8z+VNd5hMp3EmOVO5FkD3CXT4ksPOvdczJaXSwkGRb45TGwz8FqwTEg3
	 h7g5cPOiSBGdQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 07/14] tls: disable device offload for MPTCP sockets
Date: Tue, 17 Mar 2026 17:12:43 +0800
Message-ID: <5faecaef56eb3dc2809807a693dcf95be4516076.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
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

