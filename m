Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B129D27D
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289208; cv=none; b=OvmgJrCZjLUPx58ETqzKf3Tokr5fO33tY0vRIXMiBVqzFyT7MoJ0/ZYdPfo0NIEJpxSLBmlSQ9VGo3hhUaYMJDQro1cQIpgzN3nKu236Z2dtUK88BoH/Vur7I3L1OauAfd10OurGE0MJRhuEgDjUSPKrXnUJgPF4ax3aCdS7wuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289208; c=relaxed/simple;
	bh=X12eV0pRW0yGpoCrRghQUkG0cD3cHgL2zEmdlqoVjtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeAKMyVuEjs/vDvrVhovtkdsIU8cax0xZZ2yaOuLTfwFbT6RjOfxiesc5TVZ7HY+Tm7x2XOrrqEZIJqpkay49Nxwuz7YsWrH1zXu/pcna1C6QyjotTugmqrL3SKlVLvcsaFRjl9fHkXJqsnHenN4tMLTLDl7WVYVRuVKgzdIVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYQGeC0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYQGeC0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C36C116C6;
	Tue, 13 Jan 2026 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768289207;
	bh=X12eV0pRW0yGpoCrRghQUkG0cD3cHgL2zEmdlqoVjtw=;
	h=From:To:Cc:Subject:Date:From;
	b=pYQGeC0vut8HcxU8i1f4tjsXbURIa7uLr2wtQY9gyhwx8kHh0TNMV4R4JIATHGpLg
	 xqwlalDvNHMAWFGFq3ZznIfLGByZb8mAIsH4Q5hLhpQ8BEXIFJ2qBXn6+wz+pfMMC+
	 rRAecBq5iOXvj9NZ3TAgsQ5Ao0G5qj03HVTk/02ltA1teARh6BlSXVKONLHU8J90KP
	 kLZodSg6PJBIx3heFb3u9olB8JZRZhXJnolFRm4mWVVNtoN8Y4ZaQLxLs4XT9lOOGb
	 Hlnx0y6RS/DDGpsIsOH/hsvSqXTen5ZFKFh6LJOa1vlP8QJlcNjFvtK0+Fhm448Xt1
	 3DceOIFS9f9EQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next] Squash to "tls: add ops in tls_context"
Date: Tue, 13 Jan 2026 15:26:42 +0800
Message-ID: <95151965c8e5b49c6246c8cbb5f543177c0737de.1768289171.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Oops, sorry. spin_lock(&tls_prot_ops_lock) should be called after
write_unlock_bh(&sk->sk_callback_lock); otherwise, a deadlock occurs.

In this fix, tls_prot_ops_find() is moved to after write_unlock_bh(),
and spin_lock_bh()/spin_unlock_bh() are now used.

Based-on: <cover.1768284047.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 75e01f2dde26..1da7f479342f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1097,16 +1097,18 @@ static int tls_init(struct sock *sk)
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
-	spin_lock(&tls_prot_ops_lock);
-	ctx->ops = tls_prot_ops_find(sk->sk_protocol);
-	spin_unlock(&tls_prot_ops_lock);
-	if (!ctx->ops) {
-		rc = -EINVAL;
-		goto out;
-	}
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
+
+	if (!rc) {
+		spin_lock_bh(&tls_prot_ops_lock);
+		ctx->ops = tls_prot_ops_find(sk->sk_protocol);
+		spin_unlock_bh(&tls_prot_ops_lock);
+		if (!ctx->ops)
+			rc = -EINVAL;
+	}
+
 	return rc;
 }
 
-- 
2.51.0

