Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38EF2FB2
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 00:04:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="224014827"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="224014827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 17:04:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="435989060"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.218])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 17:04:18 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	fw@strlen.de,
	pabeni@redhat.com,
	geliangtang@gmail.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/2] mptcp: allow changing the 'backup' bit when no sockets are open
Date: Thu, 23 Sep 2021 17:04:12 -0700
Message-Id: <20210924000413.89902-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924000413.89902-1-mathew.j.martineau@linux.intel.com>
References: <20210924000413.89902-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

current Linux refuses to change the 'backup' bit of MPTCP endpoints, i.e.
using MPTCP_PM_CMD_SET_FLAGS, unless it finds (at least) one subflow that
matches the endpoint address. There is no reason for that, so we can just
ignore the return value of mptcp_nl_addr_backup(). In this way, endpoints
can reconfigure their 'backup' flag even if no MPTCP sockets are open (or
more generally, in case the MP_PRIO message is not sent out).

Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c4f9a5ce3815..050eea231528 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1718,9 +1718,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
 		if (addresses_equal(&entry->addr, &addr.addr, true)) {
-			ret = mptcp_nl_addr_backup(net, &entry->addr, bkup);
-			if (ret)
-				return ret;
+			mptcp_nl_addr_backup(net, &entry->addr, bkup);
 
 			if (bkup)
 				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-- 
2.33.0

