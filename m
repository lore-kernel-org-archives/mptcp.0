Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022421CA02
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135540; cv=none; b=g1ws4od7JYnTQ+7/3RuhNnpGs5UE4Eg8Bb3TwrcQDMSCvkglRa0v4U9RndEW7VEkSth6sV+/Amzc+nWPXARacTVBYQJn11ukgwDgOS2qIp5jtsgi74XDHu+H9pZ2ocphLjq5PE6dJ9Vqs8fwwHCxU5j3eRKSTRBvhY7RijGEjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135540; c=relaxed/simple;
	bh=1WSiCVenC9zwej36F1K9U736CPVWZer0awNxBWGDPZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvGyD41cFxyqzA43xqYGYwJT/Z78FDP0Au+jPvr54IIoQa8h4RY/XjAT/e27GFiKK2adreUULPCYpIrhR2Dr06U9IEnhtSKg6QSQlfZ/3iB8M315p0BhCm6SwzT7Szvs7naMY16q4UzdetirgYJj75gQ96i8iPHI5q5ocrcbH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2iCWrMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2iCWrMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1800F1F000FF;
	Fri, 11 Sep 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135538;
	bh=lmepFHfRHndBGEWgVVkel185s7ByiZmEm4aFuEXFjG4=;
	h=From:To:Cc:Subject:Date;
	b=C2iCWrMT0NtSVIxNinVG6xL0GSAkvSSL98caSqD0NlIgfwGZ6GZf1KUortpRb4jrv
	 sEnUynogXg0u3pIgxtAY69eqUuEuoi5ypeb/u/bb1MTiEdSkX+Yb/q/REnNWDGLqDJ
	 XslmeSo9uGXM4DQrqF+D+G5aXZLQcJ7U/PoN0TjimxRYzxOB3szqkGkCwlhhC32Brj
	 z2gP8pNtCt0jEgeQejp87f91aozAJ+ApdmbZrMsVP4gxtp27ZhikR2xI8fcHsCXEfu
	 bSREijxu9b/0QyZ7TckAxVMcDBi6q3vveKLrTQICZB0Gq9tHV+Po4iltCiSCEpAwbf
	 djEwTmyb298Cw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4] mptcp: drop skb_ext from tx clone in fallback mode
Date: Fri, 11 Sep 2026 22:05:13 +0800
Message-ID: <22e4057bd8f3c7cb5925794637ffa37d5572acd0.1789135142.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In fallback mode, mptcp_established_options() returns 0 and no DSS options
are generated, but __skb_clone() has already shared the skb_ext with the
transmit clone via __skb_ext_copy(), bumping its refcount. The clone holds
the reference until the peer reads data, so the ext is not freed when the
original skb is released from the rtx queue. This causes a kmemleak when
TLS ULP pushes pending records during close, as the ext lifecycle cannot
complete before kmemleak scans. Drop the ext from the clone in the fallback
path of mptcp_established_options() to eliminate the unnecessary shared
reference.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v4:
 - drop skb_ext in mptcp_established_options in fallback mode

v3:
 - Free extensions before early returns (fixes memory leak)
 - Use fallback label to skip mpext operations (fixes NULL deref)
 - Allow TCP coalescing when mpext NULL in fallback mode
 - Remove cached fb variable to avoid race conditions (fixes NULL deref)
 - Pass fallback state to mptcp_skb_can_collapse_to() for correct behavior
 - https://patchwork.kernel.org/project/mptcp/patch/6e4266b0dc3eb7e68f0064e16fa9921f46b85319.1788338252.git.tanggeliang@kylinos.cn/

v2:
 - Free extensions before early returns
 - Added fallback label to skip mpext operations
 - Allow TCP coalescing when mpext NULL
 - Cache fallback state in bool fb
 - https://patchwork.kernel.org/project/mptcp/patch/b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/patch/70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn/
---
 net/mptcp/options.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2bf3686709de..3b52e9f971f0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -885,8 +885,12 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.
 	 */
-	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
+	if (unlikely(__mptcp_check_fallback(msk) &&
+		     !mptcp_check_infinite_map(skb))) {
+		if (skb)
+			skb_ext_del(skb, SKB_EXT_MPTCP);
 		return 0;
+	}
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
-- 
2.53.0

