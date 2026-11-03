Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696251;
	b=LyiVFJpN5G/iK+cy+HXvGcsmHdhM1kbDQYLHGM56kEWWy2ObBgJp1oam82682FAAUH1t
	 yuvKRBjd8ERL3HtVAj10+wSH2G0qLDFgYqZSG3QZn6wAwC404Y/WxjOy5vWhLMdFBHMAo
	 DGjRnUlqZfXKXYoK5T2wJSePskuT1QYKu+FVjdh+aI4jHlua5S92l2D7XFgYU/3G7RMv/
	 y6419YW8n5dEfgY3W3GHyeR2e1/XAzi1hPOLlwlwhHQiVfAwyCNHJDmAbuW50ZV8mQvKR
	 /pg94p1xIipGK3DUIQQa1qrcYKWuJGQF5hLtKF0+XwknrChLJsTH4q8hLrr9y2GbcrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696251;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	b=aRUiCvCkBCo5feZPIWLYFUXyxAv0HVR+nzyye1pKrAlHX/JKQ5ElsrKuqdn8FHz+Fsac
	 M3Y7QPDmpgsfmfxurzX0D85xHeRmBC91qwCNjox+IpQLPxt3eFFpIJPr59eLnjP4BP3H0
	 2aljnQ3Mpo6yPwzeOfR9dfAIM/OQMceeDz1V3Tco3/qF9qDpyOBVZonA17sPbTMZ2hkNd
	 AGAuX/A3OHai18pM4GGNmqgXo1Ikirgtl8xQH64ib7bRKFX5uBxKoiSXlQ37juK1JbxxM
	 BKNM43WTQPAFOBEVQEqXrM3//BZ7ongvGYHjH9ayeIlNm64CI83iigVjFmlOOBLRVhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKw4MMPb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1075606A326
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKw4MMPb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA681F0093A;
	Tue,  3 Nov 2026 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696251;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKw4MMPb7aH6G4/gTnQ9tNfbltvxiUHbjiHZwrS6M7fJJz3rQrUkshw3MNbvBFFwH
	 H7dDM8ytJ3D1OKnWFi8BJT4xtUwgcjnA2oxK17w3QilbIRFA6ng7SnGHLIQV7ZNffG
	 OvkFAz+VQLtpNamfc+frfpAKT56sAYOGBjtRGJPpAkJfWl+Gw8ldTi1lka38Z1COEi
	 j6L9z24cC2UOqHQ2yfwxSe643lk7SVKbxtWiGC04PJ5UZ787eVtpF6Sk7qD8cccvYC
	 r4i+X3EALHHylgChleLiZEUzFhqgpJ5eLkEaCxZKDMMgeFYr4oyobAHx8SS+YOMyAS
	 hqzm4pdOjoFIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v20 1/6] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Tue,  3 Nov 2026 16:57:20 +0800
Message-ID: <828c767192751734fc92ee2587957b49e7845a8b.1793695518.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
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

