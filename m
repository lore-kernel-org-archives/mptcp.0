Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15573FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629481469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmTOYucDNswnuZbk6/riPe1n95QEjruxe9vbGDmXLDw=;
	b=Po7Tj6KuPavP8tuRXdW4GqhaGIFQn3M3IUPdAZuP4SCYAAi8kkdeoB+S4D57OwHEJdKRRp
	ZR5RB5sIpTSJfnj6ftFNLFNWsT5acQnipzlPQwYdgU/eoUTUMp1NtaieDq6Am/dqjq1TRy
	YuEl8BpVr+4siLSyD9ma+5qBGkcWMJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ivYgBDEhMX-i8FCsvKeKcQ-1; Fri, 20 Aug 2021 13:44:28 -0400
X-MC-Unique: ivYgBDEhMX-i8FCsvKeKcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8EEC1008062
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 501025D9D5
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp 1/2] mptcp: fix possible divide by zero
Date: Fri, 20 Aug 2021 19:44:12 +0200
Message-Id: <286de8f451b32f60e75d3b8bcc4df515e186b930.1629481305.git.pabeni@redhat.com>
In-Reply-To: <cover.1629481305.git.pabeni@redhat.com>
References: <cover.1629481305.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Florian noted that if mptcp_alloc_tx_skb() allocation fails
in __mptcp_push_pending(), we can end-up invoking
mptcp_push_release()/tcp_push() with a zero mss, causing
a divide by 0 error.

This change addresses the issue refactoring the skb allocation
code so that skb allocation always happens after the call
to tcp_send_mss() correctly initialize mss_now.

As side bonuses we now fill the skb tx cache only when needed,
and this also clean-up a bit the output path.

Reported-by: Florian Westphal <fw@strlen.de>
Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5f8ad634571..84aa11a0b2d5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1003,6 +1003,15 @@ static void mptcp_wmem_uncharge(struct sock *sk, int size)
 	msk->wmem_reserved += size;
 }
 
+static void __mptcp_mem_reclaim_partial(struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
+#endif
+	__mptcp_update_wmem(sk);
+	sk_mem_reclaim_partial(sk);
+}
+
 static void mptcp_mem_reclaim_partial(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1094,12 +1103,8 @@ static void __mptcp_clean_una(struct sock *sk)
 		msk->recovery = false;
 
 out:
-	if (cleaned) {
-		if (tcp_under_memory_pressure(sk)) {
-			__mptcp_update_wmem(sk);
-			sk_mem_reclaim_partial(sk);
-		}
-	}
+	if (cleaned && tcp_under_memory_pressure(sk))
+		__mptcp_mem_reclaim_partial(sk);
 
 	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
 		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
@@ -1179,6 +1184,7 @@ struct mptcp_sendmsg_info {
 	u16 limit;
 	u16 sent;
 	unsigned int flags;
+	bool data_lock_held;
 };
 
 static int mptcp_check_allowed_size(struct mptcp_sock *msk, u64 data_seq,
@@ -1250,17 +1256,17 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
 	return false;
 }
 
-static bool mptcp_must_reclaim_memory(struct sock *sk, struct sock *ssk)
+static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
 {
-	return !ssk->sk_tx_skb_cache &&
-	       tcp_under_memory_pressure(sk);
-}
+	gfp_t gfp = data_lock_held ? GFP_ATOMIC : sk->sk_allocation;
 
-static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
-{
-	if (unlikely(mptcp_must_reclaim_memory(sk, ssk)))
-		mptcp_mem_reclaim_partial(sk);
-	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
+	if (unlikely(tcp_under_memory_pressure(sk))) {
+		if (data_lock_held)
+			__mptcp_mem_reclaim_partial(sk);
+		else
+			mptcp_mem_reclaim_partial(sk);
+	}
+	return __mptcp_alloc_tx_skb(sk, ssk, gfp);
 }
 
 /* note: this always recompute the csum on the whole skb, even
@@ -1314,6 +1320,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		}
 	}
 
+	if (!can_collapse && !ssk->sk_tx_skb_cache &&
+	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
+		return 0;
+
 	/* Zero window and all data acked? Probe. */
 	avail_size = mptcp_check_allowed_size(msk, data_seq, avail_size);
 	if (avail_size == 0) {
@@ -1526,15 +1536,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			if (ssk != prev_ssk || !prev_ssk)
 				lock_sock(ssk);
 
-			/* keep it simple and always provide a new skb for the
-			 * subflow, even if we will not use it when collapsing
-			 * on the pending one
-			 */
-			if (!mptcp_alloc_tx_skb(sk, ssk)) {
-				mptcp_push_release(sk, ssk, &info);
-				goto out;
-			}
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
 				mptcp_push_release(sk, ssk, &info);
@@ -1567,7 +1568,9 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info;
+	struct mptcp_sendmsg_info info = {
+				 .data_lock_held = true,
+	};
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
@@ -1593,13 +1596,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 				goto out;
 			}
 
-			if (unlikely(mptcp_must_reclaim_memory(sk, ssk))) {
-				__mptcp_update_wmem(sk);
-				sk_mem_reclaim_partial(sk);
-			}
-			if (!__mptcp_alloc_tx_skb(sk, ssk, GFP_ATOMIC))
-				goto out;
-
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0)
 				goto out;
@@ -2405,9 +2401,6 @@ static void __mptcp_retrans(struct sock *sk)
 	info.sent = 0;
 	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
 	while (info.sent < info.limit) {
-		if (!mptcp_alloc_tx_skb(sk, ssk))
-			break;
-
 		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 		if (ret <= 0)
 			break;
-- 
2.26.3

