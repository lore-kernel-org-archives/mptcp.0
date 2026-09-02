Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B0258EE9
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338398; cv=none; b=b0Y3H0AWQYHJ7HDdmlFowkvcCEawnY+3CJe8LnZKtkYuvTmNk8EttfWcqjteBWER0ZOLIr2KO71iCncGnv1nvGzY6QMxZM6LlTfhGMB9LPALqiIFJ9IXxuP7wKjPEbG62Wqp/2xmuTsEoCqqnz04ZFYuC1YwMlPJwyMdD3lzWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338398; c=relaxed/simple;
	bh=RwTkp6U01ksfXUAu5UVhppTNVInK17nJ5MP4izC5bTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzdkfnDh1vbZPggiAMd+fOvB6C6D3QsndaU5pE6GMkCFDivLqS4/aPtdCfn1nwccEwpWDQ1uQF/unmgNURocZfWQWSr4PLt8vD0iVzZrnAyL8Y5vhhH0AwDIH2eIoTqQVjnL55KkgDGsYHUyGA2l9z4oVrGzqZnG33T27jofkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb7xKZFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb7xKZFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB94A1F000E9;
	Wed,  2 Sep 2026 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338397;
	bh=ZythBnuU/OL+9fkdsf/IffLC3rKAiguodbPj9QJHTWo=;
	h=From:To:Cc:Subject:Date;
	b=Gb7xKZFCrSlzN4bw35QQmQnOz4PClxGE5LEgmIORzbrz3tPKFyEhzkmWAMC9ducAl
	 LaI6JbL++12eiargJlpNQHcRjzqNb+1nf9gijRhFVLJv/vTszcxZen+lePDBTyzgmi
	 n+JvREcHJcH+xLB2JkXDez29JCFP8C4/j7oLJo0Bb7ezknvPRb9bWEW+JKBDqFRzR6
	 naNGVk7dvSY9HsYsHFcV7RQsYGn3Q92iKNzZu8YjLXap44CgwSdXBFqGAh/hmanl5j
	 A39Spi2Zk+sB6vYSyfoHitCNRn8WJuxBJcEwg6OQGsZD6DKenqnza6NlGH3YKNNsA4
	 klParIjnucomw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3] mptcp: fix skb_ext leak in fallback mode
Date: Wed,  2 Sep 2026 16:39:47 +0800
Message-ID: <6e4266b0dc3eb7e68f0064e16fa9921f46b85319.1788338252.git.tanggeliang@kylinos.cn>
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
SKB_EXT_MPTCP for transmitted skbs. The current code unconditionally
allocates the extension, causing memory leaks when skbs are freed without
releasing it.

Fix by short-circuiting __mptcp_add_ext() in fallback mode and skipping all
DSS bookkeeping in mptcp_sendmsg_frag(). Also allow TCP coalescing when
mpext is NULL in fallback mode.

This latent bug will be exposed once TLS ULP support is added to fallback
MPTCP sockets, as each sendmsg via the TLS path would leak one skb_ext
object.

Fixes: 3a54a74a3c5b ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v3:
 - Free extensions before early returns (fixes memory leak)
 - Use fallback label to skip mpext operations (fixes NULL deref)
 - Allow TCP coalescing when mpext NULL in fallback mode
 - Remove cached fb variable to avoid race conditions (fixes NULL deref)
 - Pass fallback state to mptcp_skb_can_collapse_to() for correct behavior

v2:
 - Free extensions before early returns
 - Added fallback label to skip mpext operations
 - Allow TCP coalescing when mpext NULL
 - Cache fallback state in bool fb
 - https://patchwork.kernel.org/project/mptcp/patch/b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/patch/70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn/
---
 net/mptcp/protocol.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b24e0afedfb..7338dc3b70eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1153,15 +1153,20 @@ bool mptcp_schedule_work(struct sock *sk)
 
 static bool mptcp_skb_can_collapse_to(u64 write_seq,
 				      const struct sk_buff *skb,
-				      const struct mptcp_ext *mpext)
+				      const struct mptcp_ext *mpext,
+				      bool fallback)
 {
 	if (!tcp_skb_can_collapse_to(skb))
 		return false;
 
+	/* In fallback mode, allow coalescing into extension-less SKBs */
+	if (!mpext)
+		return fallback;
+
 	/* can collapse only if MPTCP level sequence is in order and this
 	 * mapping has not been xmitted yet
 	 */
-	return mpext && mpext->data_seq + mpext->data_len == write_seq &&
+	return mpext->data_seq + mpext->data_len == write_seq &&
 	       !mpext->frozen;
 }
 
@@ -1361,7 +1366,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
 
 	skb = alloc_skb_fclone(MAX_TCP_HEADER, gfp);
 	if (likely(skb)) {
-		if (likely(__mptcp_add_ext(skb, gfp))) {
+		if (unlikely(__mptcp_check_fallback(mptcp_sk(sk))) ||
+		    likely(__mptcp_add_ext(skb, gfp))) {
 			skb_reserve(skb, MAX_TCP_HEADER);
 			skb->ip_summed = CHECKSUM_PARTIAL;
 			INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
@@ -1471,7 +1477,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 * SSN association set here
 		 */
 		mpext = mptcp_get_ext(skb);
-		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
+		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext,
+					       __mptcp_check_fallback(msk))) {
 			TCP_SKB_CB(skb)->eor = 1;
 			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
@@ -1507,6 +1514,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 */
 		if (snd_una != msk->snd_nxt || skb->len ||
 		    skb != tcp_send_head(ssk)) {
+			if (unlikely(__mptcp_check_fallback(msk)) && mpext)
+				skb_ext_del(skb, SKB_EXT_MPTCP);
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
@@ -1518,6 +1527,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
 	if (!sk_wmem_schedule(ssk, copy)) {
+		if (unlikely(__mptcp_check_fallback(msk)) && mpext)
+			skb_ext_del(skb, SKB_EXT_MPTCP);
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
@@ -1538,6 +1549,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
+	/* in fallback mode, skip DSS bookkeeping and free the extension
+	 * if allocated
+	 */
+	if (unlikely(__mptcp_check_fallback(msk))) {
+		if (mpext)
+			skb_ext_del(skb, SKB_EXT_MPTCP);
+		goto fallback;
+	}
+
 	/* on skb reuse we just need to update the DSS len */
 	if (reuse_skb) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
@@ -1571,6 +1591,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
+fallback:
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 
 	/* if this is the last chunk of a dfrag with MSG_EOR set,
-- 
2.53.0

