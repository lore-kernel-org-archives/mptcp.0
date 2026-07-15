Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB21A9F87
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096384; cv=none; b=GeIZq7a2bjFL9WJdxByWzrePww+6HPq4AyMAMqbGNTkLjrjzyOCGPzr4YoluHxKkgwR3HfVbwgB6QrDnBLYm5JMAgpGVHJ7m40yC1K8SPVNWzECXFmAb9RlZ9W94BaQ/7KJkkYkTOYz8PlfcLyjJdp0kC3Dwug/nbSJxaf4wyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096384; c=relaxed/simple;
	bh=/sUZRm5acvptBbOZV2oLVlZ0OhVUv/7012XK7iAkDro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0AmBoaVTzPVbsD6htca7dAXFTL4Vsd7eG7+5PAIf2oFWKjgt9Je7HkizllVBz1368okjODBWtzV1m43P1fQp/M07cdT78Uc3z+PVFuEPPsqHpXcEKr4+D9d9D4gg5E/2QlrYlQjIL3k39lxbCE6y1nvLhJQuwYxJOl+u+cUU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h5JeUiXr; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h5JeUiXr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784096380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISVTaR4m+RS9JKFYLVmjBjlLkKSh6nxHr1oV7/Vwl1M=;
	b=h5JeUiXroeEGIWywGvpu35FhRwV+TUCQhEP7fxXTxc/orfI87bNnmhSRBUTl3RSfRRmU+c
	Vo5BFut7Qlq1Ssgms/GdJJbkn44nSia0G8g/0qhYqj5icc4PVV7iQ5x1/pKvjixnNWRZ0h
	wY/Klb8weImmuNxYhdVLIxTSciA4CmU=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-net v2 2/3] mptcp: use READ/WRITE_ONCE for allow_subflows
Date: Wed, 15 Jul 2026 14:18:29 +0800
Message-Id: <20260715061830.1057851-3-chenguang.zhao@linux.dev>
In-Reply-To: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
References: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

mptcp_is_fully_established() may read allow_subflows without holding
fallback_lock. Annotate all allow_subflows accesses with READ_ONCE and
WRITE_ONCE to avoid data-race warnings and make the concurrency model
explicit.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/pm.c       |  2 +-
 net/mptcp/protocol.c | 12 ++++++------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c1f5c3ced4ee..869876a06493 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -884,7 +884,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		spin_unlock_bh(&msk->fallback_lock);
 		return;
 	}
-	msk->allow_subflows = false;
+	WRITE_ONCE(msk->allow_subflows, false);
 	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b9522caaf43..13a8d16c657a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -93,7 +93,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 		return false;
 	}
 
-	msk->allow_subflows = false;
+	WRITE_ONCE(msk->allow_subflows, false);
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	__MPTCP_INC_STATS(net, fb_mib);
 	spin_unlock_bh(&msk->fallback_lock);
@@ -958,7 +958,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (!msk->allow_subflows) {
+	if (!READ_ONCE(msk->allow_subflows)) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2844,7 +2844,7 @@ static void __mptcp_retrans(struct sock *sk)
 			 */
 			spin_lock_bh(&msk->fallback_lock);
 			if (__mptcp_check_fallback(msk) ||
-			    !msk->allow_subflows) {
+			    !READ_ONCE(msk->allow_subflows)) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
 				goto clear_scheduled;
@@ -3055,7 +3055,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	msk->allow_infinite_fallback = true;
-	msk->allow_subflows = true;
+	WRITE_ONCE(msk->allow_subflows, true);
 	msk->recovery = false;
 	msk->subflow_id = 1;
 	msk->last_data_sent = tcp_jiffies32;
@@ -3473,7 +3473,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * can't overlap with a fallback anymore
 	 */
 	spin_lock_bh(&msk->fallback_lock);
-	msk->allow_subflows = true;
+	WRITE_ONCE(msk->allow_subflows, true);
 	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
 	spin_unlock_bh(&msk->fallback_lock);
@@ -3873,7 +3873,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	 */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (!msk->allow_subflows) {
+		if (!READ_ONCE(msk->allow_subflows)) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 03f0b33694d7..833c76c41768 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1291,7 +1291,7 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
 	       READ_ONCE(msk->fully_established) &&
 	       !__mptcp_check_fallback(msk) &&
-	       msk->allow_subflows;
+	       READ_ONCE(msk->allow_subflows);
 }
 
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..b04d6edb9be3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1323,7 +1323,7 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
-	msk->allow_subflows = false;
+	WRITE_ONCE(msk->allow_subflows, false);
 	spin_unlock_bh(&msk->fallback_lock);
 
 	/* graceful failure can happen only on the MPC subflow */
-- 
2.25.1

