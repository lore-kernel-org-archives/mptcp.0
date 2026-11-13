Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563939;
	b=Uy1prZkJQxI00imHWVCQCWVghbafXvhNw8CLmR4vbFRVQOgNxgUiLaBJa6Mf/ux5ei/k
	 IwppInBb5yyAfBPask8VU+WRsLh5hzBPNxS2XDc5Cr+fVW/GMyXbp3tGCjVqHdWkxPvAJ
	 Tb9vTDtxpkO+I5LftJ9rV9IrvTutCczAK7ZdLfJ8qj7GNsJAreVUJr0Y0nS43jZ8SSdak
	 q/5GGv0i0rfR85thMubMObrR7LiqAWQomycaCypJ5ALeHW4sCE76cOe1tkMCBuBVC7BMV
	 7Xht3n9LgDPMCPl/UH0yHs/oJlaRF7e6qHg7k4gQA2T55bwUT88C+oGNzIXRGYaJy2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563939;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5/Kp05SKHtNtpk3tmxGUxvBUWZJxCkxUzpNm5CkanUI=;
	b=lbact+Fhp83Ro1JRGopoyORJg+Dl+3PomCI9T7xD/mro0Pq0ANQmxlkLYr6LmLI5+R9i
	 w+cPHVs2d5iyBFftTzcVAfr+pUw9YXJV1dOfxH2xhPNv964PeFF+bgkyYFjcsETdieZad
	 cV3jfw6RlS35M30QjO5bOskk5Nu3zrJXkOzEhQ44DEX2oriAXv+SvVRgXfodBNm25SvB6
	 9mS3VAtk73oKafOzjTPCrfMWbWPfhLfEofNPr9BabdAfdcsXM1spiY6TkJiHovdyaCAd0
	 u/3HZAoaYsConmjFsvKr6fV5DO4ZzM12Rk8fUOGGLWLisAO/zkLF0cW0oMU8yFJKAlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDXL+jqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6B606A321
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDXL+jqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C96A1F000C8
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563939;
	bh=5/Kp05SKHtNtpk3tmxGUxvBUWZJxCkxUzpNm5CkanUI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=RDXL+jqyC6NnjMKVz+69sNRgN6lkJ+ri1J8NXr1/c7zBgFOxMMn1rXDOzTVzfMWA+
	 HoejDAJ0bO3kU8VG+U77NpaDsIWPVz8binujHaa7u+jd9xyi1yyXjBiDpUOcChGFo+
	 pP0hXk/2v8RG3ehKbL65Sx67SSDcGVdgKWr7CPu1/j6hW0wyTRSSsfNAyHCS78k41t
	 CnQGJuV4FTs/61bbIrbab9lemTI+X5ZHAakz9ZlDMJdhpkQwX2nENo3HNTCd/8YDs5
	 3mi1V3QY3b4uWf9HVaVeU7uwmpY2/lq/60ps2CBY+XmiW0kLalc21XOnxhcw2sQMia
	 cDFzU8tvj+iOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v26 4/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Fri, 13 Nov 2026 17:58:43 +0800
Message-ID: <c2489ce683cea53548e1554d7df99d95f48be612.1794563432.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
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
index f2644e7a6a05..16b81e8dc90e 100644
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

