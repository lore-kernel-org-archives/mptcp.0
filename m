Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065046;
	b=k0iX1Pa0rBRWURvKzXNiFPzEpOGVAnM9FnNp2mItD3bDB4UGa2qB4Ne+4YcR4UbLFN6j
	 ACR26wBS9eTEkOj1RGxktCpZIpMYreItfP3PAoK2Ybz9hSk2WTwrc++S5eUkAKGLEfCqD
	 q0Nk+Cxil+RBUI15yjiXEepQ7NHS/MyH+/y5pcLOR7qYcF74gwOnb3S1iYngMbCgfR4sL
	 Gz69Ur1kaHpRKktv8f1kbUalTbVzAsda9An1yjPdiOhNPrKDQj1lBCg0QgbsSRr25uCz4
	 MlqYLfCSEdYkZpG0+1DmHq0BnoBYnuAHif/kTnjUw3xd+QheBUBBkRQ4I7aHk1KFinQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065046;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hwXsKc0W7TjoyRIbuL40eSI23ki0mlQ2QpbIs6VL7j0=;
	b=aiO+8svGaDQjzh7WIqDSqceDVzuUAtgs7KiolXrAW/GDNRfIxme7C4kyoFKMbeGVCj9d
	 59trzBe+IgZ8/A5lBL53cafHUR1iDVzw8aqdoBNaerMGZZaH7TCIx2uEFqT+0D6BJCG3U
	 szwhSkA70C5nIBcCtexNQd9q+09FDmPyatvkN4yLUtzre0zx2PosYVcW/BKBqX2AhDO21
	 0l3aOs6nuksO/VbkBZhF0w1a6oofefJ2zIuh5SnE1pr7COv0ydi3x7UtqDhkT5ebe9h3F
	 coUrDKLcnrkB2thshxe7MeOUN/b3pRoQqBpZDnPAdLuoYF9yn+ZT6zT3DtbeZ50g65A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqkrTCtf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66829606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqkrTCtf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5AC1F000C4
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065046;
	bh=hwXsKc0W7TjoyRIbuL40eSI23ki0mlQ2QpbIs6VL7j0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WqkrTCtfpRakvyMzMcbGRU18Q3aZJ04tdpb7hMAfKQIbfKGjOJTwvv2vsHl2UtEMT
	 SimcWTazi6mko+IEl2obWCw90LmYb1O4s/6tFunT5OqmfKJNuzej45wVrcawrvCJUg
	 NjblUiOC+TFy5g9IxQfI0KBIk/WDVDYueSkHy0kB8Snc8gwT355F132C6TK5qBNsZL
	 JjCiCijGhDiCilx0OfTrxYsmyKgzIT3dscLyGlqWL0beNwhSEsfjgXCjsqGrHWGsOj
	 C1lLRVvidomcwnj17W2rOAb6VDNAMYHoYbOBp+4Lj5wl7d8ubNe/0e2HTajbFirGoj
	 MtMvIgIwUYLRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v29 3/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Thu, 19 Nov 2026 13:10:29 +0800
Message-ID: <ac91f7b341ab1b0dde25070fc8872b4eb098f64c.1795063943.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
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
index 072725c6ab5d..485520a7f377 100644
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

