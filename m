Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5A3016FB
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644683; cv=none; b=R3bf3HK19/9K5Q9zs+Oex9+UCkRqr9t6viiHaULHUzfG4TUO4FX5nC/EbBG61NIx+agDsXjsnFJJhInx5/SjYs8ED1MOjUJ7fqus4tv8QXYWFWeoNL0bIFjZW06l8MOOF4sOY0MeTot4i21sFg0ZNHEdOTHY+iE4NLLx6wlyeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644683; c=relaxed/simple;
	bh=3Yt5Lszay+LnW1gX+yCFBmPX3Xwe2Ma5ggml1fgUU5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCLICsPt5eTN+1QyuEMtMlzE/kpPuYlYXomuqyIlfRAX1X6GX4sqzoOGtnbxo69WpgjK4glexNg2TQ227y6cbgcfsLz+wIu8OOKubXR6sLCmqRXOFj/5bDwUKF1kK7cw/azQxH4p1KP1jMdsuljJJ5wkNr/YPr1yk+Kb3xWp9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVSPs8Nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVSPs8Nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A65D1F000E9;
	Tue, 25 Aug 2026 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644682;
	bh=WPiQ0Gp8ihIXG5nHE174mBCKN5G5kCI9bi6cIdQDlWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WVSPs8NcUjjen9yugvWgdZFvafxOF4T2CSfPidx3n26vnbtExANgsgNFmD+4nto4W
	 RiX0rUGklqB86HRMvy1paygUnsFzRSRyw353CjwmvdTKCRREYnLQgodK5cIB+drc5M
	 5KBzE2ZIFS169TZB5uiOQ7uM6aK7pPkpSaeJ1dXFHpzdFWbM49BbN8e/SnBETCq9Za
	 LhjSNv2HFDW0xH79AVaIhMapfmo66m/l8yjji3NoOz5uCsEvXAOqJx+Bn2caG87eF2
	 yOZoBLnvy4w+e0YVTnZevlfFlijDCmosX2ITLBICc1MxLUejT21PyPD8CFVwqqyVeY
	 t1yXef13FM1VA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v8 2/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Tue, 25 Aug 2026 15:57:30 +0800
Message-ID: <ce2d1d1cc2b21fd2bc15ae2753318d3ff2dfd023.1787644449.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

It's used to save an additional comparison for in-order skbs, but is
also a barrier to remove CB offset. Remove the helper, let
__mptcp_try_coalesce() always perform the sequence check and remove
duplicate checks from the callers.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88bdb65a9e87..1682a90951f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -167,7 +167,8 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 {
 	int limit = READ_ONCE(sk->sk_rcvbuf);
 
-	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
+	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
+	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
@@ -200,15 +201,6 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
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
@@ -348,7 +340,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	/* with 2 subflows, adding at end of ooo queue is quite likely
 	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
 	 */
-	if (mptcp_ooo_try_coalesce(msk, msk->ooo_last_skb, skb)) {
+	if (mptcp_try_coalesce(sk, msk->ooo_last_skb, skb)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOMERGE);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		return;
@@ -394,7 +386,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				goto merge_right;
 			}
-		} else if (mptcp_ooo_try_coalesce(msk, skb1, skb)) {
+		} else if (mptcp_try_coalesce(sk, skb1, skb)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOMERGE);
 			return;
 		}
@@ -779,8 +771,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	if (!list_empty(&msk->backlog_list))
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
 
-	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
-	    ssk == tail->sk &&
+	if (tail && ssk == tail->sk &&
 	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
 		skb->truesize -= delta;
 		kfree_skb_partial(skb, fragstolen);
@@ -904,7 +895,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 
 		end_seq = MPTCP_SKB_CB(skb)->end_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
-		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
+		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
 			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-- 
2.53.0

