Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551334AB14
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538063; cv=none; b=Ur/4V3VyYDCF7IiM4Fnu/8lKJbHz/C86Z3sFPbh2DVBpWrYFO2+sBidUEljVtLxvTCEAbaESpxLScnr8i6WoXK893uPKQIFXwNxwvrs5Ka/HS9mynHUDa4GBdVCdlpPeH9LUgDFjOxrvTVIxUIwwa6QJMxLSXWyDZ7bR2OYuG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538063; c=relaxed/simple;
	bh=3Yt5Lszay+LnW1gX+yCFBmPX3Xwe2Ma5ggml1fgUU5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvQNVzuZpWLRhX4CtT0wENm7wREJJ3AMZLJGHcj/ZtEMu+4ol5wEvI+n0khdl5im/F63+C3fhkZe6j0LJum84A4mq8s2lTRo+rIN1v75WmU3nMYnEU8aUZ/kxkkQ4uRgijmQhSvB/wNE+0QqTmEqa3q3qR70g2S/5Slc951CKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC+md8Ll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC+md8Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2031F00A3A;
	Mon, 24 Aug 2026 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787538061;
	bh=WPiQ0Gp8ihIXG5nHE174mBCKN5G5kCI9bi6cIdQDlWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eC+md8LlRRp5xuXsy6rm2t0faheMpTTjhRtW6tFERqGLXx7S5zuW1QelQviYSuBng
	 SwWvriog/FriLf3mQRP94mG4ocDVxiZiRrQLc8k6wFdQMYO3tDi8PfI7yq3wsk7uGR
	 2vgO0/QNXValXMJOntEe0O5arzSJuhkUzozDKWWmb9HAzEGirH+z0ZGDg3JEoAEBIA
	 oNE8uygdGRF1/Hhtar6XWw/l7ilJbvE2g7cDmsQ5iZCPP9T12hZsKck+GJ2VRyZJD5
	 gR/i7buoeKx8wpzOAhl1KiIr8WMRv2zbwavgfjtQ4Gx5MkA4LqsFcLT+HJGbftdwMl
	 o6TzaOt+SZX5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v7 2/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Mon, 24 Aug 2026 10:20:37 +0800
Message-ID: <95bc8d7ca9cdeb86b36d76667aa2c468b106d669.1787537436.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787537436.git.tanggeliang@kylinos.cn>
References: <cover.1787537436.git.tanggeliang@kylinos.cn>
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

