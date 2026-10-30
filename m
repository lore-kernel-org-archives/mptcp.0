Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349704;
	b=nFMOHoqUIQ3YejWjsh/62bSFcLrtd+eCP/ihursJOzZNGQ9UXrjWF3AyqF0uglqJKiXG
	 RyV1Nr1rFgl349GeGuCusMlewWh2OxkgLzpuQ0RWVdSJ2aWxNuZLil+Kpj3Aitk8nhW49
	 DJGhC0s16924anDEH2aTA/mxxG+ys+qP8t7oZplZcIN/swVtU8PlJhStZwPVqkJH409bO
	 N+TXeEWWzfm/0Ynq+zcygcO/Po9UlTRHxmMR7n+Ngja8lrJVb1lcMLLbr03izjuxc2cYY
	 1yPHorhCVV8rVc64t28pqRRQ6SOMw8sdriQ24baMoUbqCwuh6qR2e1csn7qo7Hn75IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	b=5XbTnNiAZzE2gjX2OtMasmPg2oOx+InEDl0989DnfmfpoSSDzCqer7ksRAvadV1uGTuk
	 NLIE/RWtvJ/PmorESRL+1mr6H1y4n1jt9ER1r5dglH4KfjQEZ1puCzzIL2gVDXm7jmQN7
	 yUTWwxwFNPo1obyCefUdyZWCQ0cX/ovMk1pnecLbvezE3+9RiYuzIVnbrqJdrhQOMocvz
	 vqe0RI+COmyzdHhnqwOXBH0K4+NVyrtrz1y7oUBMW/DNtbgBVhqiVJFbK6s9jhGUyXNyN
	 wFERVygpdrT4kqjKD83G2R2QUFL4hUXE5Wz9EqaVzyyX/I152Fb/tzrD0KpfYIe/mBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPp5olNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7D606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPp5olNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A001F0093A;
	Fri, 30 Oct 2026 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349703;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPp5olNVgIQn8SQ2ONiZzuzW08zGOfUP+qa1JGfh4vIvSsInan2mfcSSkY3ShqaO3
	 Z8dvaHc239FAPL1O4BuorNpaRpvgBAREBarI3vX6r9LAFF6yKAZLQlN61i+3VqPRdb
	 4Ro2zAMYBguQn8dUCbz8mgEIRxYb7EV+6Uk84ds3bKQYdcWK7BW5st/T3/tbXMFY3Y
	 3ebDF+W2WD8kIgM79N3c/v4mEK8qZY45DlSmVfzIzaOkx8H+8AiicaVmikJsk+XCPk
	 d2xFri/ft2UDoXTUvFVOMcrlunHZaraqTZ1sKybJnI4enrYQR6Evp4VSCydUZazLqi
	 Hr1w+dNAHMDLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v18 1/5] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Fri, 30 Oct 2026 16:41:22 +0800
Message-ID: <2d215e3e2e2dd8d339239043810610a2618d31d6.1793349369.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
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

