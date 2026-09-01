Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B58225788
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244479; cv=none; b=kYmIYeDSsSmmU5Lk5uY2RpdXLk1dV/wFnVId6hfryv6uI4X0cuLdQ9MnIHNMCN+pur7cSrdAm+7MKSNh/mPUZEbYbVy61S2NX6r8Y6apWC4CNE67qhZdJy7KQLsKfdu1WMeRdNrIHgWkqKsecsI/VIS5l67BZIA1/N4Qc+CpL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244479; c=relaxed/simple;
	bh=TRzRhccL577lXX2t5PyHShMXZd1braIXm44wY6xh4NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8LmInDVTNMhLS0sjg5jpPhkXKsLe0pDvDLJeDem1Vt3XfWy20t26pVzTZJYVSaATicB3nasrWkfiUc8rapDfsm44nq4P9OJplfQEo0+Rg10cHngfhzh0tKZzjf7qgihe8a6GMcIMTZpnGPx099Tqp3AieR/P1sHEIVACqv8UQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ/MookE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ/MookE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E591F000E9;
	Tue,  1 Sep 2026 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788244477;
	bh=U4409gj9h4KP8WlaQ3hmvCcCrU4fIhPmqV0drIj1rJg=;
	h=From:To:Cc:Subject:Date;
	b=aZ/MookEX/3TPJeUhhWVHo992YJQqVLGlNVzMuR8GIYw6HgsveMxrPzLrPmSqeBfN
	 B79jGGF2eDsJimEniYBpQ0QBwUFC6Ek+dkIpx10aVUe02KwRWljaqc/25mPXwq+3iV
	 oTJUAeJrrHoSQBTZjKD9GZMj8RuPr5Zy51Fas3BvhIBgGpK4ki4uApvj2/Q55Os92X
	 HIS/23vSlN8J2f/ZW6LOjTa3wNYcUewxq4F3iYq8ZbmEE51TM3ZX6zoNcpuSN6hz+f
	 TQSpRQTUOVJoJ5NGx6CagZjFS4NEPu1HgFBMg6jES4xDz2K4L1aPzzrkYVgUVJxSo+
	 oNYM5PelLC3vA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: fix skb_ext leak in fallback mode
Date: Tue,  1 Sep 2026 14:34:26 +0800
Message-ID: <70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In fallback mode, MPTCP sockets behave as plain TCP and should not allocate
SKB_EXT_MPTCP for transmitted skbs, since DSS mappings are never decoded by
the receiver. However, the current sendmsg path unconditionally allocates
the extension, leading to a leak when the skb is freed without properly
releasing the extension.

This latent bug will be exposed once TLS ULP support is added to fallback
MPTCP sockets, as each sendmsg via the TLS path would leak one skb_ext
object.

Fix this by short-circuiting __mptcp_add_ext() in __mptcp_do_alloc_tx_skb()
when the msk is in fallback mode. In mptcp_sendmsg_frag(), skip all DSS
bookkeeping (memset, data_len updates, frozen flag, csum, infinite_map)
when fallback is set, allowing the subflow to behave like a plain TCP
socket.

Fixes: 3a54a74a3c5b ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b24e0afedfb..96933a221eff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1361,7 +1361,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
 
 	skb = alloc_skb_fclone(MAX_TCP_HEADER, gfp);
 	if (likely(skb)) {
-		if (likely(__mptcp_add_ext(skb, gfp))) {
+		if (unlikely(__mptcp_check_fallback(mptcp_sk(sk))) ||
+		    likely(__mptcp_add_ext(skb, gfp))) {
 			skb_reserve(skb, MAX_TCP_HEADER);
 			skb->ip_summed = CHECKSUM_PARTIAL;
 			INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
@@ -1538,6 +1539,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
+	/* in fallback the msk ext is not allocated; skip DSS bookkeeping
+	 * entirely and let the subflow behave like a plain TCP socket
+	 */
+	if (__mptcp_check_fallback(msk))
+		goto out;
+
 	/* on skb reuse we just need to update the DSS len */
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
-- 
2.53.0

