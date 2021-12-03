Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA752CA8
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 22:35:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="235802944"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="235802944"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:35:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460185309"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.18.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:35:47 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 05/10] mptcp: allow changing the "backup" bit by endpoint id
Date: Fri,  3 Dec 2021 14:35:36 -0800
Message-Id: <20211203223541.69364-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
the value of 'backup' bit by simply specifying the endpoint id.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b96be1e9f14..4ff8d55cbe82 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1702,22 +1702,28 @@ static int mptcp_nl_addr_backup(struct net *net,
 
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
+	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
 	struct net *net = sock_net(skb->sk);
-	u8 bkup = 0;
+	u8 bkup = 0, lookup_by_id = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_addr(attr, info, true, &addr);
+	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
+	if (addr.addr.family == AF_UNSPEC) {
+		lookup_by_id = 1;
+		if (!addr.addr.id)
+			return -EOPNOTSUPP;
+	}
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &addr.addr, true)) {
+		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
+		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
 			mptcp_nl_addr_backup(net, &entry->addr, bkup);
 
 			if (bkup)
-- 
2.34.1

