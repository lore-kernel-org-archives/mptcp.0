Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE433A0B1D
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121164; cv=none; b=blbOU3ECKG2qo2I76iiGHSrdv/AlbH/YA/5t1C3Wz6nN2nbOoCLFh/PqjQqRtnSHfAN/gTRIIP40uLc7U68+PV41cqV7qReQBCIbFT/ntG2thZnuO4XQVlBV/bHd3qGlylYCFNPP8/gNOFTf4RDIGLAXznkV3KzQLU3/xti4Cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121164; c=relaxed/simple;
	bh=beyNEC/6nwgJ7+a1IEaAQoJx4AREtMeGT5b/RrLGU+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5QJ9GJM0kODorq9qpj4OTyTc2zg476JInubWEgGINmCTpmW6RwZ526l1WHmUuI0fL3K7goTad3lGnPb0OHX5oZVQ/Q0zrXgniPVKQevCV6KD6yCYaEOQeWS5iuPTfrv4imiTHzEygEXmyVqQb+9jMHs5cfL6gmthFms+LAbBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecDDSbBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecDDSbBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7122A1F000E9;
	Mon, 22 Jun 2026 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121163;
	bh=k5aH9geT9y3rx659GKBTGPOVjtHInLsuq5ysP7A2Cq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ecDDSbBxPcawGjvgVfuRUT1z6q0OoKBPniHcPqgQso7Ib/1/2g+yxbeFx/AfFn3Fq
	 sTgSQdgvVP1/5aQ0ffMa+BikpTOuloIGFRiH00Fvayn/NrEgza+mX0JW4j/EOs5/Ne
	 M0SNgOEJE8/wL7wyH0x4my+YF7ccLtixBUq0EGsVajHJoHDSNz43bMG+1rQucoQ1mB
	 NX4x3/4+Uczbn1weKC/EHX+rotXvHOg81y4mIqLYaMvNaa8tw5ud6tuA64hsFk/D7f
	 iHn5SJITz20soKPfuyLIuntVHe0X8fSiwyBbVtK3jLOYKptzxZoJ+BHb3Zd8NbICLY
	 MCG3ztl4Bc7dw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/6] Squash to "bpf: Export mptcp packet scheduler helpers" 2
Date: Mon, 22 Jun 2026 17:39:01 +0800
Message-ID: <9da8028711cbb18a1a7ddddb893c15a9bbe5f4ce.1782120674.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove __ign suffix from bpf_mptcp_subflow_ctx() and add sk_type ==
SOCK_STREAM check to prevent raw socket misuse.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 85ec7b0e00d2..577b815775a2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -220,11 +220,9 @@ struct bpf_iter_mptcp_subflow_kern {
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx(const struct sock *sk__ign)
+bpf_mptcp_subflow_ctx(const struct sock *sk)
 {
-	const struct sock *sk = sk__ign;
-
-	if (sk && sk_fullsock(sk) &&
+	if (sk && sk_fullsock(sk) && sk->sk_type == SOCK_STREAM &&
 	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_subflow_ctx(sk);
 
-- 
2.53.0

