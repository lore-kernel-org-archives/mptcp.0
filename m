Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4141C862F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053261; cv=none; b=tEmmorRyyVW2DOk7DGQhyvfZKTioblN5281J2HOOeTRVm20J3khQR0E/RiR2RiO57pEadrANxqa+sm76AyiX+1XRegjPZ47BozN4nZtC1+jAkldB35IphAbrVntSEb0gTO2yclXjKP5lJtdAWMODsk4o3XwKsTnbIh1bLXiDlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053261; c=relaxed/simple;
	bh=s2CQBlnblQ9JBFQhSMtEwGgOCh0C2SDtC4WDSQgvZx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxIaWYmixZ9yTRsdWllYcQTLvhGh8RFAxs6RDkAzaTeeEnFaVotw3jjkjynw+12d9eutRLBzqr89X8QlfBJ4WXqykCD7XG/D0RW3BVfeh/4vqArndoh3xEJU1y1bWBrwfA4eV/PfKm14/SyXc9M5Ep/T5l+ikSirEU3WMTFRQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD3+jW3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD3+jW3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126CB1F00899;
	Fri, 29 May 2026 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053260;
	bh=StnTNuvd8trV9Bp5cMPaZEAky9zIaIYtLYl08NI1+EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SD3+jW3RWKRDElVrkya9mOLTidCPj16QqYHJjZsxyY2is9e0komKbyjqJdTf7PfRs
	 WkDnnRwGVXqlTNP3t/z1UL627ZJ/Fo0TyT4GlFrO3aU/xpf+1aXBUX64HAwXbhOHdZ
	 vph9BtIpa4WeUeeI4Hi/VsVfmJSamjsVy45qUKt4lXOMA//a5BDyDVW3FeqQrHj9BB
	 oA5K4ve6/RXlm9iSjDAC3y3ZFzFDMHVlCtNgzHnLlqPj7hcb+TnyoExFnoDTFo3Hl8
	 6RN9LzrRgqOkTQBOFK+LPQ5pEsPNB64U75mhOnblpThi4fFX94FjMbydpV+UVlr+qX
	 yUZh2f0+lsuJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v22 03/20] tls: add ESTABLISHED state check for TOE bypass
Date: Fri, 29 May 2026 19:13:45 +0800
Message-ID: <faecb7e60a6deda1415f10a20b38e218858e734b.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When CONFIG_TLS_TOE is enabled, tls_init() calls tls_toe_bypass()
before checking the socket state. This allows a listening socket
(TCP_LISTEN) to attach a TOE TLS context via setsockopt(TCP_ULP, "tls")
after listen().

Later when accept() clones the socket, inet_clone_ulp() dereferences
the ULP's clone callback (which is NULL for TLS), causing a NULL
pointer access and kernel panic.

Move the state check before tls_toe_bypass() to ensure TOE bypass is
only attempted on established sockets. This prevents unsafe attachment
to listen sockets and aligns TOE behavior with the existing restriction
applied to software TLS.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6d1272dc3c34..8809b056290a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1059,11 +1059,6 @@ static int tls_init(struct sock *sk)
 
 	tls_build_proto(sk);
 
-#ifdef CONFIG_TLS_TOE
-	if (tls_toe_bypass(sk))
-		return 0;
-#endif
-
 	/* The TLS ulp is currently supported only for TCP sockets
 	 * in ESTABLISHED state.
 	 * Supporting sockets in LISTEN state will require us
@@ -1073,6 +1068,11 @@ static int tls_init(struct sock *sk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return -ENOTCONN;
 
+#ifdef CONFIG_TLS_TOE
+	if (tls_toe_bypass(sk))
+		return 0;
+#endif
+
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
 	ctx = tls_ctx_create(sk);
-- 
2.53.0

