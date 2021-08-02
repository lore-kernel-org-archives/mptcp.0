Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83F70
	for <mptcp@lists.linux.dev>; Mon,  2 Aug 2021 23:19:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213537279"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="213537279"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 16:19:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="584326356"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.97.195])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 16:19:20 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net] mptcp: drop unused rcu member in mptcp_pm_addr_entry
Date: Mon,  2 Aug 2021 16:19:14 -0700
Message-Id: <20210802231914.54709-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

kfree_rcu() had been removed from pm_netlink.c, so this rcu field in
struct mptcp_pm_addr_entry became useless. Let's drop it.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d2591ebf01d9..56263c2c4014 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -27,7 +27,6 @@ struct mptcp_pm_addr_entry {
 	struct mptcp_addr_info	addr;
 	u8			flags;
 	int			ifindex;
-	struct rcu_head		rcu;
 	struct socket		*lsk;
 };
 

base-commit: 0541a6293298fb52789de389dfb27ef54df81f73
-- 
2.32.0

