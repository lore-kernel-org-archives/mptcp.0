Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720745;
	b=soDLKPb6sUwYLjsg/KahHygR0wp76qA+Mcdgmvs5UFyngzpozXmRNkWbMWLcNxrHifAA
	 /V9/Z+Ejbec+jN87fgFqJYYo2bnPgdCJtE0gje8kOKSD2lpJZgbyHISS54oVydNh8JkkX
	 61R0Bp/C9kzYHW3D6xV/3W9aa7W5uV3Ufap/5SbvMcODlrUHZVMjQcDsPIl0o/TyDzh9E
	 Gb9tDSYaT/cbpkkpeadTgjmnYInDfDeYQWQYuWO1tOQGhuIM+3F7zT0MVBlTZkbMFzF2u
	 2yYvOGgXyW4fbFOmnO1SDxBDt69vOFvER2nEZm2aUJUnaL7osBJXixg0li63LxZBqeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	b=ldUU/2d1kGYJ1zchG/3WShgY1Q3vguhVD7pOJuWecK7JYLm/aDbqH6+Hh3p1WH49fleh
	 aFmeg//c9CEq2jg+C1yCQfq1dE7n8baBeZ1sgamXq/2S6JHNpzvjxm20HAMZASGJzJS8O
	 la+yxjvUbZAera7FdrVG0gQSIxXptUQpCigYOM8HsqlOEcyg3KKmeW+OVxrt+TugOG+8n
	 5qDSNkZ6yspHxwXNcpQWODEiXwIag9QpbddrMi5ySF64b+hfTPXA8+QeZPfps3v3UHtH9
	 qMouvgxAAS555D91k6ILpqTH6HKb56drewVwTrJEjpytk/PYBpJdYvf1sPKhCLQqVzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmNADHpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45968606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmNADHpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38E41F01828;
	Fri, 23 Oct 2026 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720744;
	bh=1J8C7pphSK2zVga48ZXLypGHUwLsv9JZ0n5GsGZOvyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OmNADHpyh7o8D3pZ3lhMcOTCt2b6YibxPI81BQ1N4gJhUSnfd/HOabTh7merUzZ8M
	 QbEyP2RTojWBiVAfl25LeDeq9e/kZ0Cz2sNa3oeSQ1kj9GaYbJqEJmKby6hPOWlKKW
	 BFlU0RLHNAk7T1KkJBYqwFWs8+23Ov09dEo/Dm3TEKpC2vixKanmCjik0JNVGeYtSW
	 Ij5TZgp9CDJ63l+qOcBrdMDfFmjs/fxArwLUqrRosRTMOqI5kTL/TlUgw7qliGalri
	 lMYmWSpfyEyt7NfihbTkKlCtX7qTitnJ0r8A0xr14NRSJ1uN498DMtNcLH9h2PORkD
	 jkw7YYxLKUYIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v15 01/11] mptcp: drop the mptcp_ooo_try_coalesce() helper
Date: Fri, 23 Oct 2026 09:58:42 +0800
Message-ID: <77f2a6bc17dd336ab7c06d3be1bdc67d148bb530.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
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

