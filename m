Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19734C72
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656443057; x=1687979057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HkfPWCq7EsGiUJu3Y+0zZO77SJ0g4FFIxWbiZJWNGf0=;
  b=lfQ9JW0JepB+oib0msJM8RdiG485GCYokaDHhELC7ferqaYJp71P8FJK
   5RQPcYHY1uG8HJDCrObZRZGuF/c2+SBlkwGnFP7HNQKhnU75KANHtSZe3
   smeQYCHUJ5E4hMUUXQjy6FeLPBTVIufRLCmGQ0thSyBV633hbZsfTe7kP
   TL7OoudjhvVF9CG05lH4M7p88Dawsie5tI8TXToGFG2Xdkcs4PLndMS3T
   mI5HxvMVHcVRUhHMvNU9DBCkL8XgmQltH/EGfzdC0WxgQoZ4glE7TBWTl
   b2tmAXB4yBf9OY0b2ZwuO+JfgWpt6FiTlwACDTj1WpEPYWR1gtIMOo/T2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343514646"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="343514646"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="917294948"
Received: from gwbruss-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.112.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net 1/3] mptcp: Avoid acquiring PM lock for subflow priority changes
Date: Tue, 28 Jun 2022 12:03:54 -0700
Message-Id: <20220628190356.326233-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
References: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The in-kernel path manager code for changing subflow flags acquired both
the msk socket lock and the PM lock when possibly changing the "backup"
and "fullmesh" flags. mptcp_pm_nl_mp_prio_send_ack() does not access
anything protected by the PM lock, and it must release and reacquire
the PM lock.

By pushing the PM lock to where it is needed in mptcp_pm_nl_fullmesh(),
the lock is only acquired when the fullmesh flag is changed and the
backup flag code no longer has to release and reacquire the PM lock.

This change also makes it possible to call
mptcp_pm_nl_mp_prio_send_ack() for the userspace PM commands without
manipulating the in-kernel PM lock.

Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e099f2a12504..d04b34fc9a8e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -741,10 +741,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		subflow->request_bkup = bkup;
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 
-		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for mp_prio");
 		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
 
 		return 0;
 	}
@@ -1816,8 +1814,10 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static int mptcp_nl_set_flags(struct net *net,
@@ -1835,12 +1835,10 @@ static int mptcp_nl_set_flags(struct net *net,
 			goto next;
 
 		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
 			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
-		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
 next:
-- 
2.37.0

