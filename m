Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EA6D19
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 22:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656627484; x=1688163484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+nXFSZV6auwwe5r6EZ7dcssoTkxwua1fREwHRzORSDY=;
  b=G4/BPWtbKTeToUyIcmYStDxe8KdQxHozGFy89IN5HvP7fawuXk2jHFPD
   Kw8iMjYckLYragD9+h439Jv+LeKsJ3ja9PyHiHBpBA8W8kncINEw2CtuQ
   OhtccGNiMcHlMs6kCp02aupEkshKcLronFQsBRAr36OQfW8VPvEmfTtt2
   HvHcTLAHDbEsaAnAMIeNPSyBhTwrQky8OUMb6RbMHl5qYJ23U1P060Q1o
   2NWPdRbthfAjGhxK3sTr2G4Drdwi1S7vfH+FUrbkH1uUaoE+vN7JJYwJF
   1MjiB6XTtQQqUNK1fjMjVRVI5LiGTW3eSjaqW+ZatyuQYMwT9643nNhzm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368797905"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="368797905"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="733804540"
Received: from mhtran-desk5.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.176.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:18:02 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/4] mptcp: drop SK_RECLAIM_* macros
Date: Thu, 30 Jun 2022 15:17:55 -0700
Message-Id: <20220630221757.763751-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630221757.763751-1-mathew.j.martineau@linux.intel.com>
References: <20220630221757.763751-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

After commit 4890b686f408 ("net: keep sk->sk_forward_alloc as small as
possible"), the MPTCP protocol is the last SK_RECLAIM_CHUNK and
SK_RECLAIM_THRESHOLD users.

Update the MPTCP reclaim schema to match the core/TCP one and drop the
mentioned macros. This additionally clean the MPTCP code a bit.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c67c6fc1fe04..e89a0124023f 100644
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
2.37.0

