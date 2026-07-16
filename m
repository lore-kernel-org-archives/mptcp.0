Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B01367B8E
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188288; cv=none; b=ud/jslQazt3Qp7sE0ib80AadczCsCuuRIdokQZf6wkQHiaSVNVb0QMwAMf8v7g7NQTSnN3g4SRGtD8q23S85umTfJkZfYDHE1id/O/r06D4EH4Okgsi3N7GpPB1VA4CMYvAgVKszzqh2a1QyNhrzmxH9zW+jGH0Gkk7E4ix0K+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188288; c=relaxed/simple;
	bh=phbrK9CKbaX/jza/2ybdzrTHMLm34AsBjKs9vxqW4aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgKLULpg9yKJLDkUtZ9y5F68E20F6BZuvy566FNI4Rf3Z21veSLqusfOWCkEBckSjdiLGg+8MhXKLBLPvwfk5UA/0qUlv4tAbiTSUE8O9fuly0/nHM9d+Fx3cYqXZPKE63MnfpuJDqlZ9bmIUyFBYH7dUoYavXrBZCw3o6cjdDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KilayO48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KilayO48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BCF1F000E9;
	Thu, 16 Jul 2026 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188287;
	bh=XtFWhmYdsPFoAA4a9XBCiFdmlUrhnXPg5kmRlJYXFxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KilayO48/HQ2UTtNNQVn/MTkS1tYrFMNe1ZsEb2As92t6PTUFdPyCUOtN/cJ+fjZC
	 qtbB15L3ydk0iDDrRwCp9x3VtalaDLtUqqG3xWeT3/QBuV/ZDqFrKnOZ2PKJVD0UUB
	 pzDWzdJTyE5QVCElAqk2kK1/Yes0Gjy1fSfurpOI0kKkSfDEyKV6cudtYOpPs+E2NA
	 Y3T6hgoEYcVQ1DgNPFSty3Ji8ZcWJMStazx47Nq+VuSnb+qc0YGTPedFFpD4LcyauN
	 6KuR7xeLT0YVr9l5N1AELETBD0l+I5NB+dahiOZeI8woi4el/VEqRH3t5aPxEtWi7Y
	 zty9WKeaZcocQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 01/10] ipv4: fix uninitialized memory in zerocopy cmsg
Date: Thu, 16 Jul 2026 15:50:40 +0800
Message-ID: <95c4e348a1a222f83b143a4f526d0458f9d278af.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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

The issue occurs because the function checks PKTINFO_SKB_CB(skb)->ipi_ifindex
(which aliases the ops pointer in ubuf_info_msgzc stored in skb->cb), and
if non-NULL, proceeds to read ip_hdr(skb)->saddr without verifying that
the skb actually has an IP header.

Fix this by adding an early check for SO_EE_ORIGIN_ZEROCOPY and returning
false, since zerocopy completion notifications don't have IP headers and
IP_PKTINFO cmsg is not applicable to them.

Fixes: f2457533c4d3 ("ipv4: support IP_PKTINFO cmsg for SO_TIMESTAMPING")
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

