Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF33C5529
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227971; cv=none; b=KHHtKSucneYJppwFbzD1HtvY6vHKiPYatfJJgsKumEIbyZ/G9fxhz8soT6RnYpmeqokxuh52StqV5ZEllIBdm15NAutA+3yHsneCjSbjfi/HQDG8kNhzdmpm5H/q2rrExY1u4q6VuW3p57XJfdcRUAmOEDwUaaJLcnC32CF3QYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227971; c=relaxed/simple;
	bh=a9BA3RROZ+6Yrz+vdVhG7rEBjuXHlU7FP7q/LlVozCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH82T8qYgiHNbzV6dM0gbso0Al0PYEMjdIURlvqvc3Zu079nBGDbwW9GW0h8dKWWMWfychnyLYEzDKQMBkqO0rbavHzC3w9hgHqEsgLGxyVPDc1fRWQKe9wPsGLhrZF4vj+xHgeztQUejYSNcYvQgU0zoCmUkVMLq9QsWKpv+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5Hd4Fn8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5Hd4Fn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85592C19421;
	Fri,  3 Apr 2026 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227970;
	bh=a9BA3RROZ+6Yrz+vdVhG7rEBjuXHlU7FP7q/LlVozCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5Hd4Fn8O9KvC2NAc89XsV8ed9zf+TdhNxVVbuc9WO977HqtjgV5FgEdS60LfxAjK
	 Z8JcrlbP6xHA5ystpjTFr9gVHUT53ahjTswraKM/8rm4m2wn6wzPGvJ8deE2Xh8VNT
	 RKy5Qrg+6SJfdNuiGgzmSXYy8ud/Ei4q9PmkXVW3LtAEjw9DpgPOT+nG9ajeSDeSMx
	 seZ/Kixr0979/DnAb3/NuxKRtBzRRSfP46ovFOmplAT2UHDuKTsF/+Tv29BNPMlTfn
	 c7zSHND8G4A93iyCssvZHTvkT2Iy1gMTqi7nYInYT1xXsIg64wHOKy3bRtnEYe3bcr
	 vAIMkD4V2QkLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v13 04/16] tls: add skb offset check for mptcp
Date: Fri,  3 Apr 2026 22:51:22 +0800
Message-ID: <bec0b49220007115f841e6296cac9f6f3d078957.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

In MPTCP, subflow SKBs can have non-zero offsets due to out-of-order
handling or partial delivery. When walking the TLS strp queue for
sequence and decryption checks, validate each SKB's offset except the
first using get_skb_off() to ensure queue consistency. This is specific
to MPTCP, as TCP does not require offset checks.

If any invalid offset is found, return false to trigger resynchronization.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/tls/tls_strp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 71f44bf9ed59..feef440d49fd 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -454,6 +454,9 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
+		if (ctx->ops->get_skb_off &&
+		    ctx->ops->get_skb_off(skb))
+			return false;
 		if (ctx->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
-- 
2.51.0

