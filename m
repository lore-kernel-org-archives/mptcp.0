Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810D3909A7
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622637; cv=none; b=f3O90rB9KtE6nlUPmjU6UYA5oTQFv8aeNgMJcI3duMT5g7KKVoHnVS1VUJxgxKsvh8o8C4S0w5+0eg8GJmbePqwnifuaREdBfMU/pFTxDphQ9KWXqAn6ObV8TN/wuuIDI2NmUKohzKmgBTXKq7xGpx52EW4lerrLAPoSINR8Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622637; c=relaxed/simple;
	bh=mXXXQ1hTFX5YwHbN2eRMya+XfHKAY6qsw3TVQSOB5HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db+vDW/+T9u1XDLSvi8eXa2bQWDmPr35olkJYmduZM839gFzt0vlWDPWM93ih606uZoRdFkG5JIQI3CKRQRR7+PGzt3nF/XLEezkhTHC47OT3K8SW9LiJyYh50m2VYIKudBve5J/DXUQl0b7R/IqXAOxu6ki4hz7smXIaMg6plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSMCgrDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSMCgrDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447FA1F00899;
	Fri,  5 Jun 2026 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622628;
	bh=tWofvDHpbrqfzq+HQx7fPnFXtYb0+inkOq0FwYW4NLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSMCgrDhSKTqtNeylzNKB2f2SuZR+nAjiW2YvSoUP8yRT/bAC6LOQ0fJZ05XuaeHZ
	 wzfJDmtEW1sl7XDUKRyFtdcMY+YQzfbfFfPg+G+ilZKeYZepEJDZOIiCkfbGMSNlGy
	 s/11dBFsLLAfrI1XWUOAVlF2VnvMzwFgw3+sMvINR2+uZljr6UDeeyYUcOiejM+hOA
	 AnmKAiyehmHJWfi5YXc3akdbXVfWubQG614SpHUBHl0IoLi2ae1v6f7UCJgV/+somK
	 5RZf0Ni6qFYDUqkco68MovQtmE3k5UeJ8Ck//dgMpDRaEsg/REGds2qh2WunW29TMN
	 R2TU+SoY5AB5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 02/18] tls: add READ_ONCE and NULL check for tls_get_ctx
Date: Fri,  5 Jun 2026 09:22:42 +0800
Message-ID: <15f8380158a1bd8cd185fe1f28c4ce4d573ae57a.1780621326.git.tanggeliang@kylinos.cn>
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

In tls_sk_poll(), tls_get_ctx(sk) may return NULL when the TLS context
is being released, leading to a NULL pointer dereference. Add a NULL
check to prevent this.

Additionally, the comment in tls_get_ctx() claimed that RCU dereference
is not needed for TLS data path, but lockless readers such as
tls_sk_poll() need at least READ_ONCE to ensure a consistent read.
Use READ_ONCE() and update the comment accordingly.

Fixes: 121dca784fc0 ("tls: suppress wakeups unless we have a full record")
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  | 4 +++-
 net/tls/tls_main.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..28b21906091d 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -372,8 +372,10 @@ static inline struct tls_context *tls_get_ctx(const struct sock *sk)
 
 	/* Use RCU on icsk_ulp_data only for sock diag code,
 	 * TLS data path doesn't need rcu_dereference().
+	 * Some callers (e.g., tls_sk_poll) are lockless
+	 * so READ_ONCE() is needed.
 	 */
-	return (__force void *)icsk->icsk_ulp_data;
+	return (__force void *)READ_ONCE(icsk->icsk_ulp_data);
 }
 
 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..ffedc5553a47 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -417,6 +417,9 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 		return mask;
 
 	tls_ctx = tls_get_ctx(sk);
+	if (!tls_ctx)
+		return mask;
+
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
-- 
2.53.0

