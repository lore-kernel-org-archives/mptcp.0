Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871850;
	b=vCDcBMWhQ33TZk2WPQLgfxMIxWf7pFepDAES8wfr8OE8OhHuImGAfRWnr9zahRvRU2md
	 +4NbERf4TBvc8qpO0d/3RUKzGJzxsdN/yu8MqZUT8788JG/GizVf9trQ22Iyg8GnjYJn9
	 bPcvWi2/yoRPAY4JDiwKpW5DemhMNjxtwSuXGoi7hcJbzYo6h/QBpLM1BTvNdIBXhSbzQ
	 O0kDb58+tPdb8hk9VvnG5D7GRSHNrD0nySOU94zvxAIVgHmw264OBQkZO4fCZFwVTfF50
	 5OAqUuNh9biZJM8gGWIOQdg7p5k+RWR+3MLmC90T7X0vHEs+44YjqZ3xHrr2E14SlVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XDb+YnJ7YCU2Wk07FxmjUJYiMQTtGXc82amITCCPGwY=;
	b=2arlvXmBzcyKSXyIBcT/pR8OglWGfmKkUbK5f1Hmkw4ii02CO/XwqZisWOu9RpeGXWRf
	 duH4P8dyS1WIJ+h6qwKfGv5KQN8/GIvrKB0bnq1YSncGywk5NC4mKT2/MT7+D3/kM+UTR
	 v47HisQMz1uXFnXnBucJ3FQ6gw+pog1PqJ173xn63NZsX2P9cLGVFj4+x20aNL2T8zx9d
	 iW3DMxhapKmvESiMWVxMJJeeTunrysArIakcHz5jO1JCBTlm95nu5lXtIpW4j7AbX5zF4
	 ZHrtr4ko3vSeMunfvxGO5XwpOYOhDvLU9aBUrev6jHv5hGyBsepKfJFQtETkR+o78Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crqr06ir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9C606A339
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crqr06ir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB81F00A1B;
	Thu,  5 Nov 2026 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871850;
	bh=XDb+YnJ7YCU2Wk07FxmjUJYiMQTtGXc82amITCCPGwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crqr06irJeSOFaqYJhcTwrDo5b1xthl8XLoYI+4RQhUicIJXLJ4QL2Aj5uOslDHAd
	 EVTwcoH0fUHVaYrKwO79EoiCxHVLMrpzA/2Qvw+bNmDvkMYc3lwMURsLcEBsQ3xeFA
	 1AbT+qk4Qivxq+AEDR/hP4g7dAR5BPP2Yay/jPqdu6ZN0iItPw2VaEkP8u5CRDBNOF
	 ZBBPR0VNye9s0ibr51ZRE7vQpfqxDYlwbRQQcRBguJOYw+OFsvFQ68uonw5086OZ2p
	 rDXKO0wKW22IL39QeiQAJTK/VcxOQmqlp53qgavwVz6rhrkiKoewcT5nBStVNgg8o7
	 7YqOcysIAOqsg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v21 5/9] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Thu,  5 Nov 2026 17:43:48 +0800
Message-ID: <7b69e1fd9ba664d9fd0aecffde42588a194d75c8.1793870710.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
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

