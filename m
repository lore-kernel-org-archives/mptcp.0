Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B582908
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655386005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qmrq5tk4tb0kC0Z07bSNoWqxG2MwlvVhX3vvZnysFM0=;
	b=eWseO5ppf8aYBgdaCtIoZEcA+PsdiZ7LWzc9A1qZXYCUx3JcolcQTc4te/E58gJ5JkiWPr
	UIsTVBxrdr8x4pYqlb0N5SfMAeyqZFRPVBe7tGMyWm/OaH6fCE4qSxyreF3rST2qh0kuqV
	O6KwHwJJs4uIiAhTPsq09RvnyvyMxhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-HhRFW9QWMgivHEsHUmj8Bw-1; Thu, 16 Jun 2022 09:26:44 -0400
X-MC-Unique: HhRFW9QWMgivHEsHUmj8Bw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D2EA80A0AD
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:26:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B18D91121314
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 13:26:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: drop SK_RECLAIM_* macros
Date: Thu, 16 Jun 2022 15:26:37 +0200
Message-Id: <ef00799c90f79be73488f40fc3b29949cbdb912b.1655385956.git.pabeni@redhat.com>
In-Reply-To: <8a8f923a2d66057e4025892a4e83fc81fc7461f6.1655385956.git.pabeni@redhat.com>
References: <8a8f923a2d66057e4025892a4e83fc81fc7461f6.1655385956.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After commit 4890b686f408 ("net: keep sk->sk_forward_alloc as small as
possible"), the MPTCP protocol is the last SK_RECLAIM_CHUNK and
SK_RECLAIM_THRESHOLD users.

Update the MPTCP reclaim schema to match the core/TCP one and drop the
mentioned macros. This additionally clean the MPTCP code a bit.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 390ac5d95664..bc79afa7e76d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -181,8 +181,8 @@ static void mptcp_rmem_uncharge(struct sock *sk, int size)
 	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
 
 	/* see sk_mem_uncharge() for the rationale behind the following schema */
-	if (unlikely(reclaimable >= SK_RECLAIM_THRESHOLD))
-		__mptcp_rmem_reclaim(sk, SK_RECLAIM_CHUNK);
+	if (unlikely(reclaimable >= PAGE_SIZE))
+		__mptcp_rmem_reclaim(sk, reclaimable);
 }
 
 static void mptcp_rfree(struct sk_buff *skb)
@@ -961,25 +961,6 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 		df->data_seq + df->data_len == msk->write_seq;
 }
 
-static void __mptcp_mem_reclaim_partial(struct sock *sk)
-{
-	int reclaimable = mptcp_sk(sk)->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
-
-	lockdep_assert_held_once(&sk->sk_lock.slock);
-
-	if (reclaimable > (int)PAGE_SIZE)
-		__mptcp_rmem_reclaim(sk, reclaimable - 1);
-
-	sk_mem_reclaim(sk);
-}
-
-static void mptcp_mem_reclaim_partial(struct sock *sk)
-{
-	mptcp_data_lock(sk);
-	__mptcp_mem_reclaim_partial(sk);
-	mptcp_data_unlock(sk);
-}
-
 static void dfrag_uncharge(struct sock *sk, int len)
 {
 	sk_mem_uncharge(sk, len);
@@ -999,7 +980,6 @@ static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
-	bool cleaned = false;
 	u64 snd_una;
 
 	/* on fallback we just need to ignore snd_una, as this is really
@@ -1022,7 +1002,6 @@ static void __mptcp_clean_una(struct sock *sk)
 		}
 
 		dfrag_clear(sk, dfrag);
-		cleaned = true;
 	}
 
 	dfrag = mptcp_rtx_head(sk);
@@ -1044,7 +1023,6 @@ static void __mptcp_clean_una(struct sock *sk)
 		dfrag->already_sent -= delta;
 
 		dfrag_uncharge(sk, delta);
-		cleaned = true;
 	}
 
 	/* all retransmitted data acked, recovery completed */
@@ -1052,9 +1030,6 @@ static void __mptcp_clean_una(struct sock *sk)
 		msk->recovery = false;
 
 out:
-	if (cleaned && tcp_under_memory_pressure(sk))
-		__mptcp_mem_reclaim_partial(sk);
-
 	if (snd_una == READ_ONCE(msk->snd_nxt) &&
 	    snd_una == READ_ONCE(msk->write_seq)) {
 		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
@@ -1206,12 +1181,6 @@ static struct sk_buff *mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, boo
 {
 	gfp_t gfp = data_lock_held ? GFP_ATOMIC : sk->sk_allocation;
 
-	if (unlikely(tcp_under_memory_pressure(sk))) {
-		if (data_lock_held)
-			__mptcp_mem_reclaim_partial(sk);
-		else
-			mptcp_mem_reclaim_partial(sk);
-	}
 	return __mptcp_alloc_tx_skb(sk, ssk, gfp);
 }
 
-- 
2.35.3

