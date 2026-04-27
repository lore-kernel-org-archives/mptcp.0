Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146E421886
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319541; cv=none; b=jIWMthrOZA9/9aCbg2QCoclzIgDsb8G6JVAVHyQq63yrf0xXiUD6PjyDthEqkG474nx5tJL8w3uQqTSkD9cpcf2sQ+poPY+s3/z3kjClk6rUWCjG4t9PdlhJggI84SbK/UGBR7Au8dumdulVpiLlQI4JrjFABYs8qYn5+ft4s28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319541; c=relaxed/simple;
	bh=+bg3kCbffeQ5PtOoholStJ8nA0IB5USDNsz3uv5ucTg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kb7OWTzks8Rw/5KeCpi97ifUdv+8CrDApj+Vjb9lYSS+GQ0lIfBWY3hyRNAI0MsaUUP3EllNG74+9F/2GUWVFjq5FDJCdDaWH1HkZAtptiMVfH6ePhCjFn8v2MphPYv1C56DI51zFlQ8FTifm0iVr43RCxHKqJCa7hFAu+CfwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJacYgUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJacYgUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g/yTm3LII6nhGJojhttzWhUFMSw+1mflut0KHF1M8s=;
	b=ZJacYgUpjogYAcu1NuvFgIdHM3xW3AYa8lOhQCiqJ7TWVFJ5rp8UG2qAYgZ0hELiwK2DFj
	t5OUsUEj/+zNkdUj1UWz6tiau/DZzJvcfyel14R9n5Tbne/hfhwayGf5cLnyMP2X0BDJT+
	EDfInDf4BZOD+gxldZIPEfKHjGiad9s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-ceflMRNuMRKF9JqLIsFYGg-1; Mon,
 27 Apr 2026 15:52:17 -0400
X-MC-Unique: ceflMRNuMRKF9JqLIsFYGg-1
X-Mimecast-MFC-AGG-ID: ceflMRNuMRKF9JqLIsFYGg_1777319536
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9891800451
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9DB53000C22
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 02/10] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Mon, 27 Apr 2026 21:52:00 +0200
Message-ID: <b46a031bf5fd8f40897824ef0bcb1a5ac817576e.1777318959.git.pabeni@redhat.com>
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
References: <cover.1777318959.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6oLnqjEIf3yPbMdveNzCWhuCXZxgmadyI1tewa6gQQk_1777319536
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's used to save an additional comparison for in-order skbs, but is
also a barrier to remove CB offset. Remove the helper, let
__mptcp_try_coalesce() always perform the sequence check and remove
duplicate checks from the callers.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81a9b8077d6b..ad0a289b544b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -159,7 +159,8 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
+	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
+	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
@@ -192,15 +193,6 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	return true;
 }
 
-static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
-				   struct sk_buff *from)
-{
-	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq)
-		return false;
-
-	return mptcp_try_coalesce((struct sock *)msk, to, from);
-}
-
 /* "inspired" by tcp_rcvbuf_grow(), main difference:
  * - mptcp does not maintain a msk-level window clamp
  * - returns true when  the receive buffer is actually updated
@@ -275,7 +267,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	/* with 2 subflows, adding at end of ooo queue is quite likely
 	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
 	 */
-	if (mptcp_ooo_try_coalesce(msk, msk->ooo_last_skb, skb)) {
+	if (mptcp_try_coalesce(sk, msk->ooo_last_skb, skb)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOMERGE);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		return;
@@ -321,7 +313,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				goto merge_right;
 			}
-		} else if (mptcp_ooo_try_coalesce(msk, skb1, skb)) {
+		} else if (mptcp_try_coalesce(sk, skb1, skb)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOMERGE);
 			return;
 		}
@@ -672,8 +664,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	if (!list_empty(&msk->backlog_list))
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
 
-	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
-	    ssk == tail->sk &&
+	if (tail && ssk == tail->sk &&
 	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
 		skb->truesize -= delta;
 		kfree_skb_partial(skb, fragstolen);
@@ -797,7 +788,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 
 		end_seq = MPTCP_SKB_CB(skb)->end_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
-		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
+		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-- 
2.53.0

