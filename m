Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70782E764D
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622629; cv=none; b=fJhq6pJVaqKT92mXVIzweAGA42ZnOm9yGJ3tW396s1MwqTdp7iWKrZBZt1vKY115xmaUfhir9GYrqOf6EhAcaDFXPMg0hfqaqSIf9K3hmu3U3zBsQg6JMP4m9HedU7Zwlq+bfEf19cA05xYyjZcTu6QIK5Lm/eZdG73by32z5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622629; c=relaxed/simple;
	bh=T9pzYjR4nP+ZbJ/0E0pAYmE0zL4KcGgn08+F8Uq8KM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYwToAct0UgeN6urRex3AA/WRh1Ebrldku+R06um/zH/YYDNrSTT883Kg62YiGLN181GjUXh5Vx8CQ9YGcYx7DYI0RveRUegmWj6k54Yny2qcWX/WV6bSryaLhabnaA+nfisnR3m9VJpx1YTD8VNqgfHuqoEavuEndppRGG20LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCdtazy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCdtazy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1151F00893;
	Fri,  5 Jun 2026 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622624;
	bh=5KFfqZIC9/gx5OgaUNtX+5UM8ICakik9uNzS+rxhEJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCdtazy46Shyi910zN+ias8mjOjcx5GskfA4VGH0pm7Cy6qfD26B0aWqLtN00KTGw
	 b5UEnS+iDjA2NaC6FDReWhuEIAZplVU83b/HM1nL0brUPNw2J2OxdKgRg1cS6YKGRa
	 r6+yGOMPDD7x4rYAmVffXazU2kj7U0LH0j5IwCrNJgVadAVbZrfCUrIHI4sN3RETzi
	 AhAa1ZkDnvP/SpvlXGKD2e2aA2lYndWPBEceBfU9z4FxYy/IrKnowjVpHsrI4IT5Al
	 tHdPp9jIq1xNu266dydoyp2zYlBmF2X7W6NS5TkEpr8dVuIl+cU87FKYAxZo6BPG0b
	 8i4Q/Q5VpdGgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 01/18] tls: restore sk_prot before calling original destructor
Date: Fri,  5 Jun 2026 09:22:41 +0800
Message-ID: <4eace29b1e3623a5100cda2c5e1ca2f982474c94.1780621326.git.tanggeliang@kylinos.cn>
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

When a TLS socket is offloaded to a TOE device, tls_toe_bypass() replaces
sk->sk_prot with a TLS-specific protocol table. On socket destruction,
tls_toe_sk_destruct() calls the original sk_destruct callback
(ctx->sk_destruct), which may rely on the original sk_prot (e.g., for
memory accounting or close handling). Without restoring sk->sk_prot
before calling ctx->sk_destruct, the destructor may access stale or
incorrect protocol functions, leading to use-after-free or kernel panic.

Add WRITE_ONCE(sk->sk_prot, ctx->sk_proto) before invoking
ctx->sk_destruct to restore the original protocol pointer. This mirrors
the restoration already done in tls_sk_proto_close() for the software
and device offload paths.

Fixes: 76f7164d02d4 ("net/tls: free ctx in sock destruct")
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_toe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..c9c1a0952f4b 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -48,6 +48,8 @@ static void tls_toe_sk_destruct(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx = tls_get_ctx(sk);
 
+	WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
+
 	ctx->sk_destruct(sk);
 	/* Free ctx */
 	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
-- 
2.53.0

