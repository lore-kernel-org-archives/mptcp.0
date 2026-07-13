Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF135F5ED
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924888; cv=none; b=VaB3gS66wwmjPquNvd85EFhBVjMdrwR4dSd8Z5tGwtXQ3QQpAABnJps2GqpIyVk6Ke9nyTYS3uQyGJU3kLqkofjR/ve2XnVFRmsZjzaDF2IwYqJ80kZO5zzfjZObsAl4A2IzAEpEovTFO6ut4/uVp652FBteboE7QPPBqOJkOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924888; c=relaxed/simple;
	bh=hElE0DfmI6pQnbpGykO43xX+8HrBDVS+GyLQick/qpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lI94xIqB7KvfPA7OW/lJ7XtUhF0Yk+tsWwODKJsw1Ztn+c2t4UnlU24Lwy8OzIm2YzHt7tV4FxFmIk8nFI5xmkwNCAa6JRV6zXYrtLn6+mYjzblrCQwer+/DQbYp3f3L8qpTw100hi1MhH3/XtNxApu9LBBXs2RVuSFfJtOSmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HEl1m6s6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HEl1m6s6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783924883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lq4rQ1dDvYtVkvVaVUja8jQh8QN4x+hvDS0sySRPP8g=;
	b=HEl1m6s6zszu4GZ5EefZVb0qynaFsXatYUlwij21kwDrg2O2qXUChRjgE3PewisYc5VsjV
	5hT23HPJGt84bzfqB90aGU8LVoOZGtmbVUmznd5SMXLPN9kHs2Y2DJsaLm2mPEr/+G+5bU
	9mfhu+4AY4RRApasg4YU53zmYoWkkhM=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: fallback to TCP on MP_FAIL with a single subflow
Date: Mon, 13 Jul 2026 14:41:34 +0800
Message-Id: <20260713064134.914507-1-chenguang.zhao@linux.dev>
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

Fall back immediately after sending the MP_FAIL response, teach
mptcp_is_fully_established() to reject joins after fallback or when
subflows are disallowed, and annotate allow_subflows with READ/WRITE_ONCE.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 - On a valid MP_FAIL while infinite fallback is still allowed (single
   subflow, contiguous data), comply with RFC 8684 §3.7 by calling
   mptcp_try_fallback() immediately after the MP_FAIL response, instead
   of deferring fallback until the infinite-map transmit path runs.

 - Send the MP_FAIL ACK before setting FALLBACK_DONE, so MPTCP options
   are not dropped from that ACK by mptcp_established_options().

 - If the out-of-order queue is non-empty, fallback cannot proceed safely:
   increment the FallbackFailed MIB and reset the subflow, rather than leaving
   allow_subflows=false without completing fallback.

 - Add the MPTcpExtMPFailFallback MIB to count fallbacks triggered by MP_FAIL.

 - In mptcp_update_infinite_map(), if fallback was already completed on MP_FAIL
   reception, only account for InfiniteMapTx and do not attempt fallback again.

 - Extend mptcp_is_fully_established() to require that the socket is not in
   fallback and that allow_subflows is true, so new subflow joins are rejected
   after fallback.

 - Use READ_ONCE/WRITE_ONCE for all allow_subflows accesses to avoid concurrent read/write issues.

 - Fix the fallback_lock comment: allow_join → allow_subflows.

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/pm.c       | 33 +++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c | 19 ++++++++++++-------
 net/mptcp/protocol.h | 18 +++++++++++-------
 net/mptcp/subflow.c  |  2 +-
 6 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..4dc107ab1aec 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -83,6 +83,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
+	SNMP_MIB_ITEM("MPFailFallback", MPTCP_MIB_MPFAILFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 };
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..9db8812d8e04 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -86,6 +86,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
+	MPTCP_MIB_MPFAILFALLBACK,	/* Received MP_FAIL, fallback to TCP */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	__MPTCP_MIB_MAX
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..82d3dbedd603 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -870,21 +870,50 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
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
 		return;
 	}
-	msk->allow_subflows = false;
+	WRITE_ONCE(msk->allow_subflows, false);
 	spin_unlock_bh(&msk->fallback_lock);
 
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
+		 * subflow, leave MPTCP mode and never revert. Use
+		 * mptcp_try_fallback() so pending DATA_FIN is handled.
+		 * InfiniteMapTx is counted when the map is transmitted.
+		 */
+		if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+			mptcp_subflow_reset(sk);
+		}
 	} else {
 		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b32f0cd262a7..181403f43e54 100644
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
@@ -2839,7 +2844,7 @@ static void __mptcp_retrans(struct sock *sk)
 			 */
 			spin_lock_bh(&msk->fallback_lock);
 			if (__mptcp_check_fallback(msk) ||
-			    !msk->allow_subflows) {
+			    !READ_ONCE(msk->allow_subflows)) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
 				goto clear_scheduled;
@@ -3050,7 +3055,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	msk->allow_infinite_fallback = true;
-	msk->allow_subflows = true;
+	WRITE_ONCE(msk->allow_subflows, true);
 	msk->recovery = false;
 	msk->subflow_id = 1;
 	msk->last_data_sent = tcp_jiffies32;
@@ -3468,7 +3473,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * can't overlap with a fallback anymore
 	 */
 	spin_lock_bh(&msk->fallback_lock);
-	msk->allow_subflows = true;
+	WRITE_ONCE(msk->allow_subflows, true);
 	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
 	spin_unlock_bh(&msk->fallback_lock);
@@ -3868,7 +3873,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	 */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (!msk->allow_subflows) {
+		if (!READ_ONCE(msk->allow_subflows)) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a2d40cd7b13..833c76c41768 100644
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
+	       READ_ONCE(msk->allow_subflows);
+}
+
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
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

