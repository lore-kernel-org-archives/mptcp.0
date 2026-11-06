Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965037;
	b=ioOvCEVKaMu/3LLeJnwuzQlxTyyi8VnSvxtPepf44fAcFyfAThQi0BAtHAI25v0e52xn
	 h63A4Vn9Znu35vMlAOlQzE8n+62N5H53gPwKEY4MP4Akm+ZGj8UhyCxamQ5Qjk3xKqMnN
	 +C2BR/WYtCXMySdNiIItjv8vCYCWk2p8lun1CbD9oqlEgoyLApM+9oB9NBr1pR/wjlixi
	 d9T1rgUTxmAjy3Y+jpuHBjUlkt73hjt58AKpqaUjqcWGl//Id/RuIZltXgbiSWujATdrO
	 2VDIMg99p8Yz/SD7EQkgQ7CLVq2bwsSty7RQG+2zgu0cQET56v/nja0K7fFQeNHNDaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YDfrHzKAp3vQQH1BwFJa1vTRfzWydl6ciGNlNBcEfUk=;
	b=36ZJgFJKlLbS/S9qlrjtSv69x6NTCV1xc7VbLxGtWKcO9AMDlhPcM1XLNVTRNNfAPOLM
	 ceggxtMwswInZ/k9ZskUIcZ4H4BFnOw4up+w+1fPTs6qefVVVfLAOXnxEaIBR14L+KQoA
	 Xm+9GQmDdX0SJyHsxO/Q9Z5BQBR4BvH7N9Jf+QC2SFCQeaYYhbNH3babbQoDgkdcE/UUW
	 BkQrhCuSf2vlcsx9fa7iZjCX5AOWoj/g1s4Iw3PWuYn/qcJeps8FHnFY+2TnigO8p5Dta
	 pan4KD1uCy/a/k9NSjy34CRVcOwnm2I7OBsyblTcjescj6inNC5/5aprc/PigGD6YKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVzQFZKx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C6606C6F2
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVzQFZKx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BFA1F008A3;
	Fri,  6 Nov 2026 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965037;
	bh=YDfrHzKAp3vQQH1BwFJa1vTRfzWydl6ciGNlNBcEfUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hVzQFZKxtAlrYAHzuJ0i4wa122uBrtcYUyao8fjI0GtPiTE/o2oCAE98LLNXhtsAm
	 6T+T9436Nv9sip6229KnrEShcvWl7TDC1HIeTr4qVnUBAkSILA+KkHECpbIyuJJ170
	 xOH48EB7DBR62UWiM9v5d/kaHeoh5sTTRicqytxsoYCqOfl1K8L8F7UESS9o/q0/5w
	 F2/e9HkYo61/5WJB3IUiS6GJyV53d2Sb+G8WD0eMxaeQJM7mDWzo1BLL05OujeNXgU
	 FD3jkGVrjbzFrfbYYDgjcJfBWQcmGyCXEuc0TUu//4WuP9CYxRAVDRV5059N1K5bBD
	 yDrAsBaPsjLSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v22 4/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Fri,  6 Nov 2026 19:37:00 +0800
Message-ID: <fb8930cd7610c298bee3bf46a72b08d291dac3a3.1793964796.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
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

