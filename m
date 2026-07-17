Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB844303C8A
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263826; cv=none; b=iwBY1DdPiKuUnle78EXDkYJ4YY+6Oxc2dZWCMMtHRVoYkyNL1E4iRF7zoOeBeBZBQ0wCVF229jFE0MEeiujfsw1Wi2+lz3BUAQV+r3CKCovU60mPpADqehGrXai/4xe1r9Z4dX/jK311Qxco2YKn+b8v3vm83kvXW9Ryd58/B+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263826; c=relaxed/simple;
	bh=I9IMlFd2xOnZC5R6Qm/LVSZxj9cai7sE5sbfm3aViLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWA1hHkxRQrc2e2M4av3H/rrHL5i7bEnb8UZu4c1Tb0XlXhkwb7GmVXweJoF/MFEzAUETxR0fxjpRQOkJBMPSq0WcH+8h0uQZmcdFMJC0JT20C3XKEAvEaWNXSqLr2eaGSYAbMXN8c9P6dlz2qrQt3rLl8jCBUI5orb5PyxBqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euTl/G8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euTl/G8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4671F00A3A;
	Fri, 17 Jul 2026 04:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263825;
	bh=YmUcugeGeXi+5MXDad3HeCWFENW1OK2xtCUPhv1gVq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euTl/G8YERmlYB6o0ScMG0J5sCuHKltxAB4SqR2xykOR1A9LMrA4JHn888g5NPX6X
	 3zBeyMtEodLN4AtImdjSDnvfYnS2L5znsoqia9IrEGIno3DkP9HweEinurBW2kphs0
	 G6PvrOCCJyLxCqsBHRvoYQo+2bT9RCiSiIhZZHlt4EKN80jGbWAH1BGlfQ0aGtQCab
	 Zy3SRQcPpMKtESrISasVrP0Z1NOtvi18I12EShASlCT/ulQLlxCs9wjNMqRnL/bPaN
	 KYk/sxj4/k5w5kJ3+30d7ZEF60tA4gxEIrARZEm3bvMbPvoghQBKb4zNhcxwReifIy
	 02xGhVCZsLA1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/9] ipv4: fix uninitialized memory in zerocopy cmsg
Date: Fri, 17 Jul 2026 12:50:10 +0800
Message-ID: <32bac661bcae143f7e63905dfb781c98e95cdde5.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When SOF_TIMESTAMPING_OPT_CMSG is enabled and applications read
MSG_ZEROCOPY completion notifications from the error queue, the
ipv4_datagram_support_cmsg() function attempts to read ip_hdr(skb)->saddr
to populate IP_PKTINFO cmsg data. However, zerocopy completion notification
skbs don't have IP headers, causing this read to access uninitialized
memory which is then leaked to userspace via put_cmsg().

This is because the function checks PKTINFO_SKB_CB(skb)->ipi_ifindex (which
aliases the ops pointer in ubuf_info_msgzc stored in skb->cb), and if
non-NULL, proceeds to read ip_hdr(skb)->saddr without verifying that the
skb actually has an IP header.

Fix this by adding an early check for SO_EE_ORIGIN_ZEROCOPY and returning
false, since zerocopy completion notifications don't have IP headers and
IP_PKTINFO cmsg is not applicable to them.

Fixes: 829ae9d61165 ("net-timestamp: allow reading recv cmsg on errqueue with origin tstamp")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/ip_sockglue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec93..59513f15e522 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -504,6 +504,12 @@ static bool ipv4_datagram_support_cmsg(const struct sock *sk,
 	if (ee_origin == SO_EE_ORIGIN_LOCAL)
 		return false;
 
+	/* Zerocopy completion notifications don't have IP headers,
+	 * so IP_PKTINFO cmsg is not applicable.
+	 */
+	if (ee_origin == SO_EE_ORIGIN_ZEROCOPY)
+		return false;
+
 	/* Support IP_PKTINFO on tstamp packets if requested, to correlate
 	 * timestamp with egress dev. Not possible for packets without iif
 	 * or without payload (SOF_TIMESTAMPING_OPT_TSONLY).
-- 
2.53.0

