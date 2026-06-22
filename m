Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928392D661C
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107123; cv=none; b=tWeAudfgKb+JMyault1lFWj88Z0vLj5a+uODtVVLo24CIqkXkqz6/tpRn5xEEBfJiKqtoBL6/S3w1vM8cq8MzO//0QmprKikdWQknDIPE1UmLB22x2+KflOwOeFatfNzd8OLZTDR1m5J92PkJ7QrZz53eBO3rXKA9aDt7C2ML9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107123; c=relaxed/simple;
	bh=LMXxjI1a1jcwmEtD7nOG63FCumyJ5IAjBANjgI3RwkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVM1pUchrjIFITqgchBdeIJHqKY2vQdng1hjbND79ozqplo2T/s/5P+t+1aFqQxTIW/5tWYMTOE/sgd/O1NRfxzOgQDu0ej+sekAUsPLeOZfRKMD9IprkM5pbwrsY4zs9SMuIwAgQp5ur9eJRAi1Vf9EtnPJBKtbckZBkIa/geA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqdJOmbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqdJOmbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D51F00A3A;
	Mon, 22 Jun 2026 05:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107122;
	bh=ByQEZ+G9rsZ1yCNVeGmUMKIu3yQduJcqXC2bVyJKxrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YqdJOmbvaLUFWTgoj9tGtzx9qY+HxRLZCqHG2im4q04I2Z5vAIwE+qeu6iutDst/t
	 O2NnOloLXikfr2PAtNu8scGYWt68OSv50IkuhcUmqXenRigU89DdVxcXbttiP543nl
	 Y6fWQ06n5C+h//lrk6kS5vrbUVpttFhV91YJ8tDFkR2ARImE0NQ5WBP3jH5CJKD/wY
	 D+y++gUIgYTzkng3YYvaO7MCCIDmIMwt+VBjlLED7Zl0Mmx5LKlaH6I7NzlaxYe0uA
	 kBlgJecWz5CB+86kE8ci2PyS+h7hb37B0b6sluLw68hr/zeXSukfxbUo0fgWDQgS/4
	 bTrrbS93ECf3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/7] Squash to "bpf: Export mptcp packet scheduler helpers" 3
Date: Mon, 22 Jun 2026 13:45:04 +0800
Message-ID: <08252d393466ad6dacaae4d71d2481c807cba8ed.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove the unsafe __ign suffix from the sk parameter of
bpf_mptcp_subflow_ctx(). This suffix was used to bypass verifier checks
but is no longer effective in newer kernels. The function now uses a
normal parameter name, though it will soon be replaced by inline
iterations in BPF programs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 938aa6399608..57ee40077a48 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -220,10 +220,8 @@ struct bpf_iter_mptcp_subflow_kern {
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx(const struct sock *sk__ign)
+bpf_mptcp_subflow_ctx(const struct sock *sk)
 {
-	const struct sock *sk = sk__ign;
-
 	if (sk && sk_fullsock(sk) &&
 	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_subflow_ctx(sk);
-- 
2.53.0

