Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4834ACC8D
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441313; cv=none; b=fIC0FynN+WB+SBWVNqfByWG1KJfnmBRzrEeFvn3A09FmGDYMbZhLhkYAWR1JZ4oZYWpgStWpjCJzdoaXq8Am1xchWcdRvHiHCYQ/OX/abK6AXaSIqo/tNP+UcuaiJ3kKBSwtUhqbsSfAdvoRKN3iE5AhSh1utc6iciRJs1Se/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441313; c=relaxed/simple;
	bh=2nuUgjgidPHLBNI2V9fz+MDWuBGphq9N7I7kryTPoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t559JZfb+/u4ujc//RYpjbqdBBnxlAryQC8WUz8WjNeBGcHM4d91A/Auxv1exFy/DtPDMLJe6VmQD4N+TdUOOZ/fiztxZIfumVofmtWCIQnYmBnGuXOxMdOPA1EXDCrxsBgMxKbAt1LKoXXT5MJV7KXMWJRBbh/n3xYPdUap+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pYPFBHUG; arc=none smtp.client-ip=95.215.58.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pYPFBHUG"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=2nuUgjgidPHLBNI2V9fz+MDWuBGphq9N7I7kryTPoKU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788441274; v=1; x=1789046074;
 b=pYPFBHUG8E5fpQ6cLcka8N8g6vjCinCwiB4LYN7dgK7R3JJNL0S7PCpbo1mLKkh6HIqLZCbL
 q07KFUbwMluLpMZFRLwxk4x8EVUygMKA0Gfpmw4nYumJ3qhyrO/OdVQtzip+UNbRiFCsnPfarYZ
 IuLfgCJvw4wbWYSXGFR+j0Rg=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 6532a9406f735565;
	Thu, 03 Sep 2026 13:14:34 +0000
X-Mizu-Trace-ID: 6532a9406f735565
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	quanyeyang@proton.me
Cc: geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next v2 2/3] mptcp: pm: skip extra_subflows accounting on disconnected msk
Date: Thu,  3 Sep 2026 21:14:15 +0800
Message-ID: <20260903131416.1112393-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903131416.1112393-1-cui.tao@linux.dev>
References: <20260903131416.1112393-1-cui.tao@linux.dev>
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
index 07cdcdb54b15..cccf5319cce0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -671,9 +671,18 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
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
index 87ccb84e9927..07821551499c 100644
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

