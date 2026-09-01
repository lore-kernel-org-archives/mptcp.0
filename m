Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF647607A
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253092; cv=none; b=W84o+hYihAxhnb159Y8wjCMEdnc4oB2DgQfIuf0N/RfD33lGDOijpwmQvhQpgIyP0G4lkAWfdKbrOVnXMsSjz6F3f3BTHug9fqoC8/R0bAjEtohWPXMlfvKGbz5OHofoTcJLA/0QX0Ci03gzcOpsPt/OT6Yl8WwAkSyGDJjrZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253092; c=relaxed/simple;
	bh=ZHXQnMXuxVMM84ZojfRqMmdUdqvqfatMLXNz9DDVzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsm3DUEUgqG9ZKr4YupU2IbAJErpq4+j8pBqC6WTtRiiut0n1WUrdGxPP7Lt5E1FSIMXF4jDCV9aoQsz7x+Vx8JAmQQ5fI808kWCLouB3cVZLkWT1qk40Cj7YaNoGfwrGDPMMK09CNmanZyLtXlavO1F2Jy8Y9BQtlxgr4pl+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c80K3BME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c80K3BME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0EF1F00A3D;
	Tue,  1 Sep 2026 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253089;
	bh=8TZe/DMNIMMYRAbaZEHJce1Acv2+6H4hKKB8pTWl+3g=;
	h=From:To:Cc:Subject:Date;
	b=c80K3BMEeFcF/6vbi7NwsNqnEWPwdmxW2fgi+IllmzrmGcQ7WdfVD0fGYwvd6+esJ
	 QjqradJHyknvrFoWkog/Ee8X31GgY794YhGqZClXpeFLxO989ug4uKLG/6Juqufxm5
	 mGECmfNdy/37HbEZ5cDdqXXHT4pEI8RpPBie4XsEZOFWAFbqWMGjhymAbCofGU2EdT
	 n3L/BMUlYW7dAwLvof9Zx+vTWdGVxahP+zOrpsW8svxVBS/+7Er+erDAzSQU5xwOjH
	 ZCprNxdu+1Wix6PdoFPWlrc2IRQRr9MOY492j6+ZooPDfydNRovE/PNfobcP70jkxG
	 Rq2ccrsgK400w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2] mptcp: fix skb_ext leak in fallback mode
Date: Tue,  1 Sep 2026 16:58:00 +0800
Message-ID: <b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn>
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
SKB_EXT_MPTCP for transmitted skbs. The current code unconditionally allocates
the extension, causing memory leaks when skbs are freed without releasing it.

Fix by short-circuiting __mptcp_add_ext() in fallback mode and skipping all
DSS bookkeeping in mptcp_sendmsg_frag(). Also allow TCP coalescing when mpext
is NULL.

This latent bug will be exposed once TLS ULP support is added to fallback
MPTCP sockets, as each sendmsg via the TLS path would leak one skb_ext
object.

Fixes: 3a54a74a3c5b ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - Free extensions before early returns
 - Added fallback label to skip mpext operations
 - Allow TCP coalescing when mpext NULL
 - Cache fallback state in bool fb

v1:
 - https://patchwork.kernel.org/project/mptcp/patch/70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn/
---
 net/mptcp/protocol.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b24e0afedfb..15877aa601ce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1158,10 +1158,13 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
 	if (!tcp_skb_can_collapse_to(skb))
 		return false;
 
+	if (!mpext)
+		return true;
+
 	/* can collapse only if MPTCP level sequence is in order and this
 	 * mapping has not been xmitted yet
 	 */
-	return mpext && mpext->data_seq + mpext->data_len == write_seq &&
+	return mpext->data_seq + mpext->data_len == write_seq &&
 	       !mpext->frozen;
 }
 
@@ -1361,7 +1364,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
 
 	skb = alloc_skb_fclone(MAX_TCP_HEADER, gfp);
 	if (likely(skb)) {
-		if (likely(__mptcp_add_ext(skb, gfp))) {
+		if (unlikely(__mptcp_check_fallback(mptcp_sk(sk))) ||
+		    likely(__mptcp_add_ext(skb, gfp))) {
 			skb_reserve(skb, MAX_TCP_HEADER);
 			skb->ip_summed = CHECKSUM_PARTIAL;
 			INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
@@ -1438,6 +1442,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool fb = __mptcp_check_fallback(msk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1507,6 +1512,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 */
 		if (snd_una != msk->snd_nxt || skb->len ||
 		    skb != tcp_send_head(ssk)) {
+			if (unlikely(fb) && mpext)
+				skb_ext_del(skb, SKB_EXT_MPTCP);
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
@@ -1518,6 +1525,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
 	if (!sk_wmem_schedule(ssk, copy)) {
+		if (unlikely(fb) && mpext)
+			skb_ext_del(skb, SKB_EXT_MPTCP);
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
@@ -1538,6 +1547,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
+	/* in fallback mode, skip DSS bookkeeping and free the extension
+	 * if allocated
+	 */
+	if (unlikely(fb)) {
+		if (mpext)
+			skb_ext_del(skb, SKB_EXT_MPTCP);
+		goto fallback;
+	}
+
 	/* on skb reuse we just need to update the DSS len */
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
@@ -1571,6 +1589,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
+fallback:
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 
 	/* if this is the last chunk of a dfrag with MSG_EOR set,
-- 
2.53.0

