Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C5310652
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291643; cv=none; b=D3Eub/SZUR/4Fj6ytvAXNWHQ7uTePTRvS3BPz8MWURhl2D6epRZThkxv0acfOp2O1dFT5tOSgIL2cXME2PZclwuN6+1ZY9a6EAsFnpSQOMf3Iouuch57HkfSFsTwzZy7kCF3yHmvCMPudm68zOnp6UVGm2amIZQQ7uFmUAtttUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291643; c=relaxed/simple;
	bh=RJKifpgaqHQhDE1AXoD/9qEm32hIbVoBQgMbvrpY9X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syiTSrooMqf9iVXsODsj7KEEVrApbEV9x3BtbueFX6k8p99mTy9xJXV5tkx4xk0httYFYNOX/quBAX9snyyAGSCn+fXkBhoIueSo0kWsl9iIf7nBCGs1SLHtsehjvqXBHtvvmshYJktNuRjLr3dntvJDg+Hqabn/phI4M1hRP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syIyQ6+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syIyQ6+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF981C19421;
	Tue, 13 Jan 2026 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768291643;
	bh=RJKifpgaqHQhDE1AXoD/9qEm32hIbVoBQgMbvrpY9X8=;
	h=From:To:Cc:Subject:Date:From;
	b=syIyQ6+onB6D4bpeIfXi+ONs2E6y2o6+JDoEMx1bH1Z76GNJhrejJ+lOpbapLvoPh
	 d3uwvdR2WHOLJrLtS183rIF6toXWwXZVe5MW0wq+V1Lpu7VS8m88jaQytVVjoyXdgC
	 SMU4ry2m8Mz+xA1eoYYfGt007GhPJS7xCnGLU1WgqycBdVHNSmP8d0cov+CILLz0tt
	 fR4jQIVxQlNucj3Ie7Wno+x/x9v2ljsgJsC1EoLcIXW43f4iSv3cJOZ/JXyrlUU3/k
	 sm2qbb1T7TZ5venCV51q+cuPJ1lz0RXf7Fd5XNw5Ii2jIg4aelRKp/funB7i1glL5w
	 2geNDV66BfZ1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2] Squash to "tls: add ops in tls_context"
Date: Tue, 13 Jan 2026 16:07:17 +0800
Message-ID: <24196096819a0557b38926fd53ef1b9121465b11.1768291283.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Oops, sorry. spin_lock(&tls_prot_ops_lock) shouldn't be called after
write_lock_bh(&sk->sk_callback_lock); otherwise, a deadlock occurs.

When calling tls_prot_ops_find() here, it's unnecessary to hold
tls_prot_ops_lock; holding sk->sk_callback_lock is sufficient.

Based-on: <cover.1768284047.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 v2:
 - do not hold tls_prot_ops_lock in tls_init().
---
 net/tls/tls_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 75e01f2dde26..1051cb53bc5a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1097,9 +1097,7 @@ static int tls_init(struct sock *sk)
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
-	spin_lock(&tls_prot_ops_lock);
 	ctx->ops = tls_prot_ops_find(sk->sk_protocol);
-	spin_unlock(&tls_prot_ops_lock);
 	if (!ctx->ops) {
 		rc = -EINVAL;
 		goto out;
-- 
2.51.0

