Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216265;
	b=aHgiYd/h4kN+v6JbZ+M9fQUzWF2w/YbxuGaZpuQxC5e8mkQthpZa7FJAkJMU1iuGysWj
	 xPR+VRvnKfMdQMDBMwrdcIO+/RQBWNzFXXEqDUTs2CZSF3E/XSObMAbsgh4wz8f2uS8xn
	 tHVSrJN4A3xMk3Eg6bXg1BEd1m/5aS9uduDlFBIsa2rq1fAlpPfvUUPQdByWSACI2LkCT
	 s9O8+gaGo8P1EYzxGTSTb1MLCE+SQvY4e9exPZMeuq9zEAqPcN72uQQKolRUaVdL5GQpb
	 mECcs+Y05v4MX/lxASEhK7cGtGWHMn6bU8Sm+Vcf2x9ja2l3CN5pXkayDE8tBVVh8lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216265;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XDb+YnJ7YCU2Wk07FxmjUJYiMQTtGXc82amITCCPGwY=;
	b=KfAOnjyn5wnPGeEv4nwo3Jl5njLetpitqWS6qyus0/0530XA83CKR8uZHycpurIGGsC8
	 c2YGdrnr9k2sEM0UUY75qRRcKKwGYm1A9BmHRi/pb1xu7RQURtjpU4jnnM+XEJXHQuRqZ
	 nhMaqb9Mv4xp+sMhFfZ4/HX7xvtoO+viS8aU7VL+5+RCDmeQ+OaoqKQIj0J3bmUsY58fr
	 FYj1kW/Dus6cyOz9wlpVgkr6iso0gytEZFzWw+r7zUptgKTUv44SCjcSv9+tAym3n14Xi
	 Pe5JkUN3t4jb/dh3hI8Iy8Vqk59uptwnbXYOWL8gzJmC6V3NG6RI/Rd1Mc8fK5OmYEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmyKM9JQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE89606D809
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmyKM9JQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6E71F008A7
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216264;
	bh=XDb+YnJ7YCU2Wk07FxmjUJYiMQTtGXc82amITCCPGwY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WmyKM9JQZ+HjWSQyenRHspUJwOHzLpVN5qPHdYyb36/WUv2zD4rOdi1OGohS/SMxh
	 XcauiHaFsm5Ng2oEg3pva7MN4xUNiTFV/aXND0vtc6penXoIgqa3+FjBKNoTXx5weV
	 GA3nSWY6V1g21hPmdJd4hVBP5pgGt/ecUwZ7bWEv1bgjoRvT4jTk+Cl8kqX2whrM5P
	 AA+wIsIprPSp/q6YdkMbEeCqwX9f8EO+sPtjWTR8NZ2LcwylLN3XifgFkXZoXGOMZ9
	 K5wfHCGAKhyfDDlVOrsravm0DOeVjQ595cWmca/ed7YkuNTWyTSpSS70pMsacnT0Cq
	 RKX95wMGs9rNQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v24 4/8] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Mon,  9 Nov 2026 17:24:06 +0800
Message-ID: <4bdbf080e0af79539b2d59f38e452fb184d2d7eb.1794215614.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
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
index fc4ffa326317..71f5b0209192 100644
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

