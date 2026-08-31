Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFF3CAA59
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168759; cv=none; b=brSDh9gkcjtlYdPxbz29uEskkEX3mhsYlUut/KIaNnLVMFM+x/1BCn0T9MHp/AIWgsZMHKMmaIv8yDYMNEGhv4lXwD+tlj7kzyZ8JDgZMzELN0F3LzZoOQCn4tGFFQCNRuyEGA7ajmtOzb/rfyWX8Mv4phBcT1HOPsYeyO4tVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168759; c=relaxed/simple;
	bh=ws/E51gGgS3vg/9PEA6emAwTLsLkVDJZ6mM04VkDJ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv+1fcZl0J3OMqklRcHRIP+7aKecpHm9m4/TOobWJXsoMlGW+QM13hMUclNeVxEhNl4xWD/z0oefgV2WGx2ppeAiEerZObJsDsLS49gzReLY6kvG2driicHvUXplVlZwxkoFDIUvdul4xB1s/+cx09RbFmEunLU9GBhrMaveTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YSDUlnCH; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YSDUlnCH"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ws/E51gGgS3vg/9PEA6emAwTLsLkVDJZ6mM04VkDJ9s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788168755; v=1; x=1788773555;
 b=YSDUlnCHrcBcjDPgp6JxPQ3rqmL1rWdT9dvOAkFcT2x1sMIvn2heDBMZAqA6n5C/EmeHgcsK
 xQ/jQlduBYIiUstHSLz9qW5pA9fBoY+pUlQq1c9E6U3rUwy/DOMipZtRAvpOoTTgrS3vpotlQFE
 JBrc8pZt0zzZQNE1BfBCTmq0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5234ddb29e01091d;
	Mon, 31 Aug 2026 09:32:35 +0000
X-Mizu-Trace-ID: 5234ddb29e01091d
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: pm: skip extra_subflows accounting on disconnected msk
Date: Mon, 31 Aug 2026 17:32:06 +0800
Message-ID: <20260831093206.689827-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831093206.689827-1-cui.tao@linux.dev>
References: <20260831093206.689827-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The WARN_ON_ONCE() guards added to the extra_subflows decrement sites
turn out to be reachable:

mptcp_pm_data_reset() zeroes the counter with only the msk socket lock
held, while an MP_JOIN subflow can still sit in msk->join_list, its
reference already accounted by mptcp_pm_allow_new_subflow() under
pm->lock. If the socket gets disconnected(AF_UNSPEC) in that window,
mptcp_pm_data_reset() zeroes the counter, and the join list is flushed
later at release_sock() time: the leftover subflow then reaches
mptcp_pm_subflow_check_next() (or __mptcp_pm_close_subflow() for
kernel PM sockets) with the counter already at 0, firing the warning.
On panic_on_warn kernels this is a remotely triggerable panic, which
is worse than the silent wrap the guards replaced.

Skip the PM accounting when the msk is already in TCP_CLOSE: in the
scenario above the state is set before the counters are cleared, and
once the msk is closed the accounting is not relevant anymore. Keep a
clamp and a rate-limited pr_warn() on the decrement sites instead,
to leave a trace of any imbalance we would still not know about.

Fixes: e99c1ca89071 ("mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c       | 11 ++++++++++-
 net/mptcp/protocol.h | 14 ++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3990f6775723..1760f4c51b62 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -676,9 +676,18 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	update_subflows = subflow->request_join || subflow->mp_join;
 	if (mptcp_pm_is_userspace(msk)) {
 		if (update_subflows) {
+			/* The PM counters have already been cleared if the
+			 * msk got disconnected while this subflow was still
+			 * queued in the join list
+			 */
+			if (inet_sk_state_load(sk) == TCP_CLOSE)
+				return;
 			spin_lock_bh(&pm->lock);
-			if (!WARN_ON_ONCE(pm->extra_subflows == 0))
+			if (likely(pm->extra_subflows))
 				pm->extra_subflows--;
+			else
+				pr_warn_ratelimited("extra_subflows underflow, msk=%p\n",
+						    msk);
 			spin_unlock_bh(&pm->lock);
 		}
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 06a107d4e839..f5dbafaf4551 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1252,8 +1252,18 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-	if (!WARN_ON_ONCE(msk->pm.extra_subflows == 0) &&
-	    --msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
+	/* The PM counters have already been cleared if the msk got
+	 * disconnected while this subflow was still queued in the
+	 * join list
+	 */
+	if (inet_sk_state_load((struct sock *)msk) == TCP_CLOSE)
+		return;
+
+	if (unlikely(msk->pm.extra_subflows == 0)) {
+		pr_warn_ratelimited("extra_subflows underflow, msk=%p\n", msk);
+		return;
+	}
+	if (--msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
 		WRITE_ONCE(msk->pm.accept_subflow, true);
 }
 
-- 
2.43.0

