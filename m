Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361986;
	b=BV7//hGZn0e7803tj0ImMBp8zR/X9/H0DJB1ltLdhGBItyKNtIG7ETXN/2Gt+EAmBzzZ
	 OsqfDUPMqF8pKQ0uJMf+SrdYiAmjnd0bS+I5d/p7QO1im+bndNewYNGPZX70cY7231rm9
	 ObDBS02dRVeIs5JeIkCccVN/rpMwetC/e6uxiXEUuL4pd7/zxDb4Dr0J8NNHuyqf60g+R
	 puhkqk6sa33XA8MmHf5G+QbrRWtcBUSJhhC3dSjYqGHlQD154/lsfLjH9TWc83OAqglEn
	 wDk5Ly4DQiqN8nsWcICmrdUFjdlRSzEHqCw7S1gRP7amFh24qluXf6PTWy63PzefuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	b=hqYSBdTkjvukzSJGfhdkG7JgwHlrCnSBA5vmOPgXfhl50bryLZTI8wQzCbvd+J8WIFRe
	 oEqk2pniu/781RRnic6nuF2R8Qdbr6NgIV2m7RHWxgLXMSNGV4cB/+VkzD8RgSHmOZYJ7
	 R+qFHqx/91lEBDp2ylNWpy7G2yM8vidGmRwK9wxFsylqFH+h3ziO1XWFrbXHec3VInjE8
	 6ZAz9/OP2Qry/5GCqMH5a9K4vD5gSsAGCoSDyb41DZ9s4T7EU62CbwnYkiVnnqSfXmp+E
	 kvf/EfSCykyEMoE6WkJUGScHwOuLj/UoGo6NRkrj5EATo9YTKqHxe5j88Xykn4oFSrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnzPp1xO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11001606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnzPp1xO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55B11F00A02;
	Fri, 30 Oct 2026 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361985;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VnzPp1xODWD2iCzPTZGItYDzVouolsPhnFf4zzKS2nUZKR6jE8DP4uE4K73ZZuTSq
	 kQT6KxsAX9F4HKWQt3olirOiP4pm3v8zGItqEhF4QkEoMRPC0fLULyS2gJFwXKw6Va
	 9Jpp0ddYo0PEj0i5iNpfiGhDhRm46+SakXAWKgl5JY5LrlL9lbkmbZXCKOTE1EhhtL
	 4vmJ/sAM5K2HaAseuIEZpoyf2sGwsOlruK9mo8O3Z9DMDLMP2dDGi1OjxwatIx1i+H
	 AwsLcYvsJTltNqtYWvuwKBdxD45hMj5fRuFSEhVlKlSM5IgboIQdeGj77H7SSZGGzO
	 Lnk5HXfXnRMUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v19 1/5] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Fri, 30 Oct 2026 20:06:15 +0800
Message-ID: <2d215e3e2e2dd8d339239043810610a2618d31d6.1793361629.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
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

