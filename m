Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969842;
	b=FWhHzCxIdxmnjzHFC2H9ua5Q9q56xXRSGFkHBtgXbJ3bXCaHdmuXRPxL3MibbowtZX45
	 HCr97VmLqxXS8PXTDhYztLm7h6jvPdR3PbMPPj105lna0qJFg6bKahRNOTnV8lVxobw3u
	 HpN98igJUTgqVEkbirA1BLUXeCtXIC86k5UCCg/z31Ush+YQFdrPHXfWx7fCk5y2G7WAR
	 Xa9Wq0+jcb/hSzF7Osy9s0oASUPjCE0HfELlMuOMRzl30ge/dI/TG8sXXMG7v2bHspUsT
	 37svty3Qo7g/JH7CQeDGzD8SpHgAzK+JYXgt7aMmUKQDb8Eb+SPPOlsa9M6j3TIaBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YDfrHzKAp3vQQH1BwFJa1vTRfzWydl6ciGNlNBcEfUk=;
	b=wjf/ndbD9WINUJGbwtMSZJfujPMN0hu+uWv7cDROIPS5jUEbxUKos9pe9qN4IUvFcITx
	 3cKZpg8U9RmR/uKajEgN8xF9AsbNA9TnH7YtIKa/9GLRB/wrGAfBLmNjZrG87DCzhjkpv
	 EPzTIPu3MqUVV/UGHMcCPLEPVLN7sP27Sr1YUsHX7ZvRtRASw+1A5N5Jh15RJZLBSw6HX
	 nUwQk0DxxYlABgXU7vL5JF3jFK8ps2hJvWkXTnUeseq/4NQtEDZMd01Ub4FUMUGpxH5r8
	 5/wN2f+DdKi2C2DYl1M5OLAb5pj2GFzFFvrjiOeovwtjai2xi72bl+LauVjxZbWfHGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdwRKBVC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD3606A329
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdwRKBVC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190DA1F0089F;
	Fri,  6 Nov 2026 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969841;
	bh=YDfrHzKAp3vQQH1BwFJa1vTRfzWydl6ciGNlNBcEfUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdwRKBVCbUR6o8t5VAlYXLX+aWRjqnQB09EwNi27QhSR/H8aH0dpCX+l4EeJBs2QC
	 dh+M2O8G4LfHwFj3cQV4vTQ9SaNzZ2iscKlkgJtTIH2Cu74A5vdTIubUwxri7Mu7/x
	 kqyjJcoiDELP5kgOo7IUGlypC7BPGuQUA7ZZx9OEGyq5vOfaGvjLUNPo3r+UxQ/mlv
	 Tm/B2vpel7/f8ifHHMBlYTmiqmCPHbaXv0PL1Efdtlew/pt/o8fMPWtfFGqrVSdnhn
	 0JcY2gxLaQytjiHYEn25O0WoIgK0/Hgj6mN169W9VTBKwu8ag1twR6en7cLMyToFtY
	 qVLv5+xhPRwbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v23 4/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Fri,  6 Nov 2026 20:57:06 +0800
Message-ID: <b4ba56f0acdc62b6ffc1b4cabb2bd2ad62e65577.1793969127.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793969127.git.tanggeliang@kylinos.cn>
References: <cover.1793969127.git.tanggeliang@kylinos.cn>
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
index 421df3af1ef9..4495a148b40c 100644
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
@@ -777,8 +769,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	if (!list_empty(&msk->backlog_list))
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
 
-	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
-	    ssk == tail->sk &&
+	if (tail && ssk == tail->sk &&
 	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
 		skb->truesize -= delta;
 		kfree_skb_partial(skb, fragstolen);
@@ -902,7 +893,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 
 		end_seq = MPTCP_SKB_CB(skb)->end_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
-		if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {
+		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-- 
2.55.0

