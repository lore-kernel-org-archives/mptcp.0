Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421997;
	b=R8NVhgxdhvJf50Yg7z/o/DG/gpU/SJVJITgO5DyHJVaQQIMgQzEZLLmi4duHM+s45rlc
	 hWsLthyNQquIjxvQR6ae08ueGuxx7gOlZVDEkcsbg68/idLK25z1DtIIZEVpWca0EH3F/
	 KKZOnoYe92nsGHlu/E62p8dC2sTZMO3BxZ9Zo9eV3l+bQn8ZEEMHoRw3FFtFCYYHZBTHg
	 xFyxpHi/wQ3pBvnNclr02W0otS9U31RXzd4q0fiX9Z8j2Idtq2oGJNmk9PV0C93VklbaO
	 CB7lbJv1Tk+0OAgFwh/QP8BvAuRcF7jfNPJRoryd/A4A8DfHL6JiGBKkBiGsvYsRIUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421997;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZHZ0KMm82BVRVS5RU5OtxVwCMf620+3FS6zo/1a51iI=;
	b=JDRGdgwDoRgJoRjbOweSTQYbAfMrsIAyfBdnD4wXL9rdU+lJNEp9dka9k9XP5YsWpTKI
	 UIJa9q7NF2koUsU/yeGVMSIG6yy6qfTEuHlz6FdlbBhKeo5uHj+6gq3FuNaC8munYhEpn
	 5je9GprdgQ6pAQAk7/grFVgDJ8tmLXJKnZ9/o05cXwpK6Uk9dlTmHTFDU+PflSw3XAaRi
	 oeaeQw3nV2Dk3p5BpE333Xhx+Kz5NaferuLbcofNAGi7zKhpxNxANkNISuLgcgc4OIbHp
	 TgoH7sKp6VmI8QGemEH9nZd9+KE2OaKtZV+qHzg98N378CUAqIbjKJCxKXzMdgj4s2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8BR5njy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDE606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8BR5njy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B81F000CA
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421997;
	bh=ZHZ0KMm82BVRVS5RU5OtxVwCMf620+3FS6zo/1a51iI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=A8BR5njyrGM9y8l71rpvowUgT9pPBeTXzsAAFxrV7rUjJv9IC/AcTO2PDIHE6d/Ls
	 hBCf9+uWxtEaZ+3NECz8wFR+ynQ6q49t5gJGffVwzVn1fUBIyjWJZlr7f/ltZLIAsZ
	 rd7kFedMtcMX6Z0H11vAYnZShAXuhebXfOkVD2KGAav+cdD8VL7x8p2Mu29fsQ5f2K
	 5IiIdAQphWdt7+udHEUPaPmRIIE/2+HqluSHX7EwlbtcrCNoik3BvQhmqQgPd+WXTl
	 IIN1LD4KR2rhH8uqTb/5srAtcprdF9Cm25YnQRCekUmSuhjD+/zZX9TuRfCw3QRG0c
	 hS6WgA9qmrdBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 1/7] ipv4: fix uninitialized memory in zerocopy cmsg
Date: Mon, 23 Nov 2026 16:19:44 +0800
Message-ID: <2819758329599addb172d144f078727112ecf17c.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
index 90d0b5bee68b..8d1a9db54f83 100644
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
2.55.0

