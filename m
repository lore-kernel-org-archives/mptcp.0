Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA64696
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 19:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657567001; x=1689103001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NEiJvTKvSTMVTvV6Cif8kN1PwHk/e+jtjHvC50aicgs=;
  b=HDvZ6VsRdLpfGWGG384/5gcnkA6nYaFtKFGW5WkjCdXtaajM3xZWv7Ho
   i4PGH8W8lEG2QBr7buHjX2oidUxIc0O0ae7ngapQPULqYG+cdozM0D+PW
   vmNJjQVcC2RFd/dI560wuTf8IlICgQVlq4NyNBLiBCnpxBo2Gw46OXGuo
   gerliS812/dxsqhm0aZ3m/TA94gSa4qZXilaHpJa9VW8fUAk2r/D7sYyH
   JUCdrn0cd3t19sszOXfZric++GPiKXqh1ByV8cda7PshS2C/a1hXChfdh
   11v2rvpRm3lriI3+QyddnyUaS8jWzqUJxoto7MoPakp+PLN/v7RupYAsB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284775357"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284775357"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697742714"
Received: from eedeets-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.2.111])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:39 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/5] mptcp: allow the in kernel PM to set MPC subflow priority
Date: Mon, 11 Jul 2022 12:16:31 -0700
Message-Id: <20220711191633.80826-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
References: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Any local endpoints configured on the address matching the
MPC subflow are currently ignored.

Specifically, setting a backup flag on them has no effect
on the first subflow, as the MPC handshake can't carry such
info.

This change refactors the MPC endpoint id accounting to
additionally fetch the priority info from the relevant endpoint
and eventually trigger the MP_PRIO handshake as needed.

As a result, the MPC subflow now switches to backup priority
after that the MPTCP socket is fully established, according
to the local endpoint configuration.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fe8e22aff7d2..b767a336ad98 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -514,30 +514,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
+		if ((!lookup_by_id &&
+		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
 		    (lookup_by_id && entry->addr.id == info->id))
 			return entry;
 	}
 	return NULL;
 }
 
-static int
-lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
-{
-	const struct mptcp_pm_addr_entry *entry;
-	int ret = -1;
-
-	rcu_read_lock();
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -555,13 +539,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
+		struct mptcp_pm_addr_entry *entry;
 		struct mptcp_addr_info mpc_addr;
-		int mpc_id;
+		bool backup = false;
 
 		local_address((struct sock_common *)msk->first, &mpc_addr);
-		mpc_id = lookup_id_by_addr(pernet, &mpc_addr);
-		if (mpc_id >= 0)
-			__clear_bit(mpc_id, msk->pm.id_avail_bitmap);
+		rcu_read_lock();
+		entry = __lookup_addr(pernet, &mpc_addr, false);
+		if (entry) {
+			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+		}
+		rcu_read_unlock();
+
+		if (backup)
+			mptcp_pm_send_ack(msk, subflow, true, backup);
 
 		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
 	}
-- 
2.37.0

