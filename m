Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811153;
	b=k54O7kVT9ChK/JtRtY0/zGUzfKd9VQ2gi+iInnElnagQQmDs0ZQs4X/GtJok4rvnAVsn
	 wukpNkMBJwGhNEDLY+l2H9pyseX8h3Jp6R6WhQHfKEkHDKks8t+UK1zMN9hPEgLiJ7i0k
	 LpNbbzRSNfU3FfRpU6CaqJvaf6SioRybtOhJCnXC0Zb1zKVPxWHlgBMImovFxFRhp1eio
	 1m3KGMnZghhMkwTCNoNCf0C6OYgSPpb+oCYbwcuQLuNUrIU5YpLQztPsdMYZyMy1rkzh2
	 q8s7iFVcqXGbIt18Nfalbk7YWrCJWf0HQRgqh69pjx3TrnEgP0/g4+VCGOVwQBCV0KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811153;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5/Kp05SKHtNtpk3tmxGUxvBUWZJxCkxUzpNm5CkanUI=;
	b=gxsMSX8Tyj3v+pL5l+5e0Nz513xMj1WcCnR1KBseeQZaNuKrAzKMofp7wjCBVTHqLz4y
	 dFIL1m1gqtUPdsvr3mhgo6jLraZPCp79uw2yTXHWg7Z7p+7MO7cgWgH+8xLEaR5wlFLin
	 uKQC6it//VO6Qg89dAXKzg7EROju2RbUZkBaGuThbOOddqRqxCVeXtbSktd+lhvXwEtNK
	 r+LSy70W6yQJ9gQ0X9LB6xaDMqItZMTGy2fAVvlNaRFUII3JHCsdx5lDWXCPpEtQQT6Aq
	 C8FsS0/MwPWB8TUQVmCAVM7+5/8dZx0YM5JckrqS8sgpeP02w5OhDn9gygdQmnqulIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt98LVmp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78389606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt98LVmp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B571F000C9
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811153;
	bh=5/Kp05SKHtNtpk3tmxGUxvBUWZJxCkxUzpNm5CkanUI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Mt98LVmpQQTIuO/RPP6WVQnnYBt6faRTiUi9tkmPkmo3HgLMAHXYdQUFCuj0L7eGD
	 QIHmrQFKWg5PsSVkqML/ttcdJeU5Dujk1k9Q4F18jkVQCICwhkXtjHa0DuT9zEigl9
	 R7boFNs1cBVAOB4IZeTRqVeMj0L7P5SUlnGaqVwUKNgbKkwoKTSDtg1uXtM9SeqXFT
	 8zlkccqj1tj/0WoMVpP/g0XKnGN6Y1GCslf3FB1dytu8R6jAC9SkXiqjwG7WT0TvdR
	 dTitLK+a23iWIpCIJQIIVjO693hOzOZoXxuZvMQM9FL/T1bdlMmXKwJmQ+tNvqQIn3
	 D1XENo+J4LvfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 04/11] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Mon, 16 Nov 2026 14:38:57 +0800
Message-ID: <38dc8bef455cb79a9e548a1a6a69f2da89b174b1.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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

