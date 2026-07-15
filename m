Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC131A9F87
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096382; cv=none; b=GdkoRUsrr0RnbFasLjqCUdfFvzbnCaPxP8M23iZyggo0FnQSlTdmdaEuW+pwtgAyTpMO0ald/ik0OH/xoPO/GMKOOD+iTKCO9SyqHbFQB7T1ehRHvK1idawd0CbSf/H0BxWlytd/hi+G6zFFYxZ7xbLIS0Uqb1CniwSdawLGYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096382; c=relaxed/simple;
	bh=r/bjAF787YnMeurZmEiXjc0WKidwk8BDsEleEvwCqtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJ5ea9bLkCoBI520KFps2A7bZna0euPrJUbWen7Rb0bsB5tMrp1fYRGXh2HNows88b5fO1/n+T+Q45cinouoCF53tjlQNsa8U15aTj9LCCW7UXrL0PolDPcXjZiUBlRoQNvEMugKZb0WDKndXdMD5ytp4V5lVQr7YujtS14vdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DrSttWl+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DrSttWl+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784096378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGk1xKvMfQgHGFKW88bje0ZDy2uPlZHZXH6PJ0kY4c4=;
	b=DrSttWl+9OI/cbCcr+aSvfi6ItOdlbtfSM2WpQxqxupQMIXnTIb/257ooe05hehfFOf6+b
	Im3uaGkgbCP4am/m+CwxApl6p4ZpVqVyc/PAG1IUzsmhmIv2jhlif5N0IzuwT0BPqWY6VO
	5lwhVCw/wIOUcT2TUSlGLwqn/BIio+g=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-net v2 1/3] mptcp: fallback to TCP on MP_FAIL with a single subflow
Date: Wed, 15 Jul 2026 14:18:28 +0800
Message-Id: <20260715061830.1057851-2-chenguang.zhao@linux.dev>
In-Reply-To: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
References: <20260715061830.1057851-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

When a valid MP_FAIL is received and infinite fallback is still allowed
(single contiguous subflow), RFC8684 §3.7 requires leaving MPTCP mode.
The stack only cleared allow_subflows and deferred the real fallback to
the later infinite-map transmit path. Before any data is sent, a peer
could still complete the 4th ACK as MPTCP and keep using MPTCP options.

Fall back immediately after sending the MP_FAIL response, and teach
mptcp_is_fully_established() to reject joins after fallback or when
subflows are disallowed. If the out-of-order queue is non-empty, reset
the subflow instead of leaving a half-fallback state.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/pm.c       | 51 +++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c |  7 +++++-
 net/mptcp/protocol.h | 18 ++++++++++------
 3 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..c1f5c3ced4ee 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -870,7 +870,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	/* After accepting the fail, we can't create any other subflows */
+	/* MP_FAIL on a single contiguous subflow: fall back to TCP.
+	 * allow_infinite_fallback is cleared once other subflows join or
+	 * non-contiguous data is retransmitted; in that case ignore MP_FAIL
+	 * here (the peer should reset the failing subflow instead).
+	 *
+	 * Send the MP_FAIL (+ DSS) response before setting FALLBACK_DONE,
+	 * otherwise mptcp_established_options() would drop all MPTCP options
+	 * on this ACK. InfiniteMapTx is accounted later when the map is sent.
+	 */
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
@@ -882,9 +890,50 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map\n");
 
+		/* Infinite mapping requires contiguous data. With OoO still
+		 * queued, do not leave allow_subflows=false without
+		 * FALLBACK_DONE; tear the subflow down instead (RFC8684 §3.7).
+		 */
+		if (!RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+			subflow->send_mp_fail = 1;
+			mptcp_subflow_reset(sk);
+			return;
+		}
+
 		subflow->send_mp_fail = 1;
 		subflow->send_infinite_map = 1;
 		tcp_send_ack(sk);
+
+		/* RFC8684 §3.7: after accepting MP_FAIL with a single
+		 * subflow, leave MPTCP mode and never revert. No dedicated
+		 * fallback MIB yet; InfiniteMapTx is counted when the map
+		 * is transmitted. Handle pending DATA_FIN like
+		 * mptcp_try_fallback().
+		 */
+		spin_lock_bh(&msk->fallback_lock);
+		if (__mptcp_check_fallback(msk)) {
+			spin_unlock_bh(&msk->fallback_lock);
+			return;
+		}
+		if (!msk->allow_infinite_fallback) {
+			spin_unlock_bh(&msk->fallback_lock);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+			mptcp_subflow_reset(sk);
+			return;
+		}
+		set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+		spin_unlock_bh(&msk->fallback_lock);
+
+		if (READ_ONCE(msk->snd_data_fin_enable) &&
+		    !(sk->sk_shutdown & SEND_SHUTDOWN)) {
+			gfp_t saved_allocation = sk->sk_allocation;
+
+			sk->sk_allocation = GFP_ATOMIC;
+			sk->sk_shutdown |= SEND_SHUTDOWN;
+			tcp_shutdown(sk, SEND_SHUTDOWN);
+			sk->sk_allocation = saved_allocation;
+		}
 	} else {
 		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cb9515f505aa..5b9522caaf43 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1299,7 +1299,12 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
-	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
+	/* Fallback may already have been completed on MP_FAIL reception;
+	 * still account for the infinite mapping being transmitted.
+	 */
+	if (__mptcp_check_fallback(msk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
+	} else if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 		mptcp_subflow_reset(ssk);
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a2d40cd7b13..03f0b33694d7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -369,7 +369,7 @@ struct mptcp_sock {
 
 	spinlock_t	fallback_lock;	/* protects fallback,
 					 * allow_infinite_fallback and
-					 * allow_join
+					 * allow_subflows
 					 */
 
 	struct list_head backlog_list;	/* protected by the data lock */
@@ -947,12 +947,6 @@ static inline void mptcp_start_tout_timer(struct sock *sk)
 	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
 }
 
-static inline bool mptcp_is_fully_established(struct sock *sk)
-{
-	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
-	       READ_ONCE(mptcp_sk(sk)->fully_established);
-}
-
 static inline u64 mptcp_stamp(void)
 {
 	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
@@ -1290,6 +1284,16 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
+static inline bool mptcp_is_fully_established(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
+	       READ_ONCE(msk->fully_established) &&
+	       !__mptcp_check_fallback(msk) &&
+	       msk->allow_subflows;
+}
+
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
-- 
2.25.1

