Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9C2F2C
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 01:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643850233; x=1675386233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FC2LolPe1mWrv7RSaMwzaULMsfbrfUJRBuphqssZXwY=;
  b=ZB/g3uOgi/XtGAdlcqERq8T41BwgJShgJxD0rJKgNNRS8abA9SgEosg5
   2m5VmTZOsdlD9t8AXR8D3ZtyKjxtSG0/U/jFSUcKLoJqudchGgewcrXH2
   oLFg8Ds/LeX+GSi2UdUpoWxRjj/iVPLJ4GcQ3gKbdLz9/DBZ65BU9luCG
   sg1ZVMTxvVLskjg0W6wDHrEVODfw3EEocqP9YhbX2IYfv740CgCkWhlgV
   9BiICFmlAwNtrK2PIx+DUlUcHkkBuwGXuBtzA4ScUb0vvr2LuYyHVTrDy
   EXyp+wZTWWrIEIZy16ZduiO/F3B2b3QOi97YOrY1pRXFGsdt0ka5mTTIF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228023386"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228023386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483070832"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.1.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:49 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/7] mptcp: set fullmesh flag in pm_netlink
Date: Wed,  2 Feb 2022 17:03:41 -0800
Message-Id: <20220203010343.113421-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
References: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch added the fullmesh flag setting support in pm_netlink.

If the fullmesh flag of the address is changed, remove all the related
subflows, update the fullmesh flag and create subflows again.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 782b1d452269..d47795748ad7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1728,9 +1728,20 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
 	return -EMSGSIZE;
 }
 
-static int mptcp_nl_addr_backup(struct net *net,
-				struct mptcp_addr_info *addr,
-				u8 bkup)
+static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+
+	list.ids[list.nr++] = addr->id;
+
+	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
+static int mptcp_nl_set_flags(struct net *net,
+			      struct mptcp_addr_info *addr,
+			      u8 bkup, u8 changed)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
@@ -1744,7 +1755,10 @@ static int mptcp_nl_addr_backup(struct net *net,
 
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
-		ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
+			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
+			mptcp_pm_nl_fullmesh(msk, addr);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
@@ -1761,6 +1775,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
+			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = sock_net(skb->sk);
 	u8 bkup = 0, lookup_by_id = 0;
 	int ret;
@@ -1783,15 +1799,18 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
+	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
 
-	if (bkup)
-		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-	else
-		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	changed = (addr.flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
 	addr = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_addr_backup(net, &addr.addr, bkup);
+	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
 	return 0;
 }
 
-- 
2.35.1

