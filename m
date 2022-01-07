Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3672C9D
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641514851; x=1673050851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pl68bDSpC4qdweZRyObhPBra8XJEPL/rbRE6WRFpyfw=;
  b=ijzq6LcAQ8jFnZ1dVOao6nM75siC/av+sP6Fl+fmfUVZoIDeQ9mgAnMf
   Ho88sQvtRXlloLPfPJY4tkhNH7Fgd5C0TiRd3nA8wgi0vPMf9EjxS81Ud
   MK3E4CzkADVjhEyNeoWOHoTpNbjQxYBiWYA+GXNUmttKd/xtxs/433HvD
   vs3AliPh4jSsKig10lkDNiKwTg/tg0bPm845GtwaPRfQJk6xNgpquJvUD
   nDzzhV/hAkHEacAM6zTD/uVW1+7+RpScFskyeSR4cN5e6bdy00Tp6rX3s
   TedTYjorQXvhRHOPhRNIQEsaBThIGZ3SUYy2ZiLgaVl1mq/89/41jLHux
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329111038"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329111038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="618508506"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:35 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 07/13] mptcp: fix per socket endpoint accounting
Date: Thu,  6 Jan 2022 16:20:20 -0800
Message-Id: <20220107002026.375427-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
References: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Since full-mesh endpoint support, the reception of a single ADD_ADDR
option can cause multiple subflows creation. When such option is
accepted we increment 'add_addr_accepted' by one. When we received
a paired RM_ADDR option, we deleted all the relevant subflows,
decrementing 'add_addr_accepted' by one for each of them.

We have a similar issue for 'local_addr_used'

Fix them moving the pm endpoint accounting outside the subflow
traversal.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6cde58c259a8..27427aeeee0e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -711,6 +711,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		return;
 
 	for (i = 0; i < rm_list->nr; i++) {
+		bool removed = false;
+
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
@@ -730,15 +732,19 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			if (rm_type == MPTCP_MIB_RMADDR) {
-				msk->pm.add_addr_accepted--;
-				WRITE_ONCE(msk->pm.accept_addr, true);
-			} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-				msk->pm.local_addr_used--;
-			}
+			removed = true;
 			msk->pm.subflows--;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
+		if (!removed)
+			continue;
+
+		if (rm_type == MPTCP_MIB_RMADDR) {
+			msk->pm.add_addr_accepted--;
+			WRITE_ONCE(msk->pm.accept_addr, true);
+		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
+			msk->pm.local_addr_used--;
+		}
 	}
 }
 
-- 
2.34.1

