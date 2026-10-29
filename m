Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256452;
	b=mHimpaJAZLevnPSPSZ63rkFmVxgoXTgGFZqTiU/t85sfbQyowVugyZGJkTSvb4ivPDQR
	 +RPimgPkthDAGDZqWigpnQDtWx1eU0nWT8XfY0KXoI5CswLlq/dX9k9yqdfeu+v7Ghtmm
	 wOYIoWJDOC1RMEdpZnFyVhToPs9AVB49UzezejhqUvFR7ppXAnHPHptD8PYBJ86QXMijD
	 4bGMc4beqGo2jcAJWMD4ZcRLg+MIcRmEd0RKbT3Fgpz73qZO6f+yJxY6HufgLjb6/XDMo
	 7Rqm7bew6AyfTisebftAWNt2SEyiMtq4m4vc9aHh75+tW4p0fLcT9bjri45tEDQTQWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	b=Ht2rY0zEDIr7+ak10JaxU3A0vDh5APUFTH8AbvufCFUAScho4xsTUzNQmaiWnIjvDye0
	 YAcdhpJ5P+rVB8ek+xvAIGK6lguhc6T+kI2OBXI5q4DdciCuI8LeezSeq2l1J7NBtDJEr
	 lyz6oHRyJUubFquw00dTVLFkpzLlgTg1hDgAofevHHt8ywg60Yr060eu3+8nl4aFcwNH8
	 h8nUTKK36N0OVWYnDFLkbcWm3GHhmsLL4mbSQSbulX3driXBMQFuUmuCCC0r95udyU1zX
	 v1KZi20IrnrYrRPFlNpAkYkVcSwmq09Utp+1fPU4kxx5ACw9fCIHiQuwqqUPGd+PUuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMWM40qL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D87606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMWM40qL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5981F01828;
	Thu, 29 Oct 2026 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793256451;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMWM40qLvJ8llgxVVr4OR97AV2nQxDBw9NEzOQacftiAFqY5culm6UNzHV/0dU7kc
	 2WxMJ+s0Q7mAbvTqMz5ARwatvoynK9527uTNmBtzbi0ZEhBdMazInIqGaMGoHSo+SV
	 jEOSCXvUdXMgBvaWJFHgSH+Ky+KQImY0Nm0MXVODsPL/jjZMgRoYW5XrxsYBoFzTq4
	 efF1kSPlFJEeT9/Ruxi2uVJg+ILhQi9xrQm0FVgdAf8dBAdOddMMWLuCXhp/h4uGoG
	 O4uDJ2j6kaqFzYsPzeBh8FBihzboBu1eeCkpW0K6CX7Vio+MaDgkaAq2ATUbxL1v4g
	 Edwb4bOH4Jn/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v16 1/4] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Thu, 29 Oct 2026 14:47:18 +0800
Message-ID: <5dac2eda41edcfe40c67dab12718b118d6fbb39a.1793255126.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793255126.git.tanggeliang@kylinos.cn>
References: <cover.1793255126.git.tanggeliang@kylinos.cn>
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
index 02a4f479d9d8..528a72da646c 100644
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

