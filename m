Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFA17ED
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1ip2gpw5Xu9ny+t3q/CJOg3y+/ofdNNdeJfYSGIejo+ShksRNoU+QeT5bFDtacsmdOrffFIHVY065cywViiv6ayN0PMXrQte8v0BVfUugYSddevQM+KpEHHP1v6dCTqvz3Bq2i8u11l/lXTUJ6WyQB5f/5PrWYttydBbNDBKKLfT8ou/kwBL7RABEsUglrpUYQf4VagzMolrjN5hZlDDEZx+4J9vZg8qSpHApeS04+ey+c0TBmOvWNXVMtU/3dLt23pnr5ZGfAQnCHTzauqoyLy80787i+VHofuDXs4n0nRWW5L5oiNaFNbVVBdF7/KjlNIb9A9iI146o0WiTV38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CznGByomJnzv7yII5NYMdWTi4MDe0f8yvIPYD7VlJRs=;
 b=M5aDjOb1VACBCd1BZc6ZPR8ZEQbovgMB71GaIjdz8JzP3Aq1zEX3N/vqZpTs1xpSY6udXCMxOVsjjT0lOCPHCNnmTueSaIdZsztFG5TMc6z9Ld6PXz6DN11lZlIYD3HIBVZyuynmyO1fbwgDdArmV8PYFNKDj+Cgdb6KdEi0EKvqJkQMbrcdhMYo40LMtTweat7e/ci+EouB//XFT+E16znYRwmvpLKXP0zYgq8ol1yPp60NCqNDO9llzCdNy3PenoY/57CsBPQu8YlLaRg1oUXsprIbPo9xj6mgr4Ckwm71Vsz9rczGD1LBgboHsQiLOotdutFQLSewqa/Y90ZzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CznGByomJnzv7yII5NYMdWTi4MDe0f8yvIPYD7VlJRs=;
 b=rnr9TpX/fGFehP9PoyeqkPaI86J1qjkWHwtXK1Pg1ZZceYmAbfInM0XI+sFS1YJxT1L19HasiV2Zjyl+vP7gXQDDHl325OuC6xdXKpRvYElpPmH+5FzsIV0HZWHd+iWDc2KWVBvsppGM00VvM3E8MECOnNIsGCGoA0OhVMoklTy8YBshrQ1urjOSWesi4BbYjSrYPq9NI9kXzSglklasdGbY9V2jiKQKs8xUCpvtDx2QN/Y4s6yIQc0lSku6KKWl3CcRwmMUUXswBy96yfiB5D4cWdas+WkGdJmaeGjLuBqxTwus6eAGfHYQiD2xwx+JZLkvXkety4UKbYpZEsn2eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:11:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:11:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/5] mptcp: only remove addrs in nl_cmd_remove
Date: Thu, 20 Apr 2023 11:11:35 +0800
Message-Id: <8c56e8306c829d6ca42ec34e07448fcee21b5dc4.1681960259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681960259.git.geliang.tang@suse.com>
References: <cover.1681960259.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a0f5ff-ca4b-4f1c-edc7-08db414cf528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/D4Hh1sCczlZNDWS5HsPqMkrEz5V24DDeUXw4BdQBtoUG0GMKfobfH/UR02zulbeEKiCT8A9gCgNrYbWyGBRFDecXzLMoaWC/TqISaWtTgmsZQ2V63e9S4QzpM1Nk21OuNXTYdUYhcJno7Io13pJg+GUso6LDebGU+kP+7IbKFJ204rNIF/KwpqB2xOitLwLMR91BUfui6arnniHxXMk+va8Hpa9WQrywQ9xiq/a3UfgB3OjTIcQi5aoAQyOOHn3bAc5Jb7y0TmnLoBwd4IvVMLtbm/KkeHkPAQeFuzHr2kFHLoglLD43tWxWdMXB1FdrNkmPo+IBGcncU9v4KU4sYx8gLgXNluFb1r8zRp9hg1/IxOwL9a+ELZ+oeNemEwOHRRzEekOf/fv6ABe2lEYrNjdvp92TW59V0dluMzCpxhPUWkel3zp3BhB9iBghocwNwXU9ibB0RtFO2MzGaZIk/5qWdIwJiSjlcrwV0VNUVmDphvhjN9r4Wp9m7glHCgzV63xMqy6umkOexsx7hRVHTKiGsrKRF/7AKvA/Y5FnO3Nj/YIs/d01xPZZbZcP84Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(6506007)(186003)(6512007)(107886003)(26005)(38100700002)(2616005)(83380400001)(8676002)(8936002)(5660300002)(41300700001)(478600001)(6666004)(6486002)(86362001)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pgw36Hzx/+vWJigQbqNQ7wsAfOLbccfDUesKg1TBzLy/cg5wg2+Y/cnlXLSE?=
 =?us-ascii?Q?8quvUKdsEKWKZm6Yq1fJMovmbe5kWbB7v6rYYmod3fddA0GX090kEDcD8cmj?=
 =?us-ascii?Q?38UsXGld0lrBhyhxSO64SAgtiyrQH6xbMoh3UPxfXt15R/5KBAdKNZwYZqOi?=
 =?us-ascii?Q?sqJu/rXKmMWjLvuzfo3oIeCtg4eBK2t5QkFZtT6ju/N+ajPjiSnAnGi+VZG7?=
 =?us-ascii?Q?b27T7N9MLYQIw6K3pq+B0yEM6oPm9ZW64lGtXVgbFhwlnmVmPz2ILHXiur51?=
 =?us-ascii?Q?l5/uUX8IV4Z6u+vy3CKLPOnd6+/4HxigNEX7WEWbPoDzV2eY2GkJidVDiKmJ?=
 =?us-ascii?Q?1mHp3A7I3bKOfqjM8y3e3k1SgO4tZ2nJUXZmcnTo72FJjLZvFxzELzqn53dI?=
 =?us-ascii?Q?AWseR6RW2M9PTFBA2hw9T+kUOIKNXmMqf+d1JQjefu3iarlF/tevZx/xovUi?=
 =?us-ascii?Q?BI9rZFxuEBOe8rozB37phHMsN+41IQGUaDv/wH0FWufRlt2AkpaNZZAE0zzj?=
 =?us-ascii?Q?CK7bofz5L1czai63/tLeDwRcamHMBUdXx2K8+46YcKNj7Oh3c6Mf+QzNO7nl?=
 =?us-ascii?Q?LX5aedBUK5AXNgFtydyjEbs/9dVBrAwPaTvf4ReaiBlUwHCh8Rg78xPMLsdI?=
 =?us-ascii?Q?5vxguT9H2sBCmN3x1omiNIrQKeA1riX3lFJIQKJ+Bqtazht3Bp96W9gCiDXa?=
 =?us-ascii?Q?sX6bQnF5gA/99Q6HvMiryQ0AgRUXm+Ylt58fE+OdFX7YZ8FomPKsZ6WwD0rX?=
 =?us-ascii?Q?ynNzz9jIPXQ0pOnBuVuDvSKsO0tJYo7xbOZ/4Kxkry3dLzyyUlgYEEZXgbnG?=
 =?us-ascii?Q?eg4YQxFnJ/sMv8IpuZyKkrVdTDXLMBuyoqOcs3a9CFh88N2nNXPdgZKHlu2H?=
 =?us-ascii?Q?tPSfgXAFklyLYC9v069s1fCq5VIC9knstDijvCZwZn39+Cmr9P2IKnTUSbLN?=
 =?us-ascii?Q?lC6EFK1nG1zm+l4IWio3/Wj+JEp2xGD+TIBMj16por9n91eRdQE7kqD+xWBF?=
 =?us-ascii?Q?pE4kZGCIG2sYkiDAXsp+WRK00a9sZvUlYfiSSzWiV8fJW5SeNBa40tcrRjr7?=
 =?us-ascii?Q?qQwf9AmrO6b2xwjJlHERdxugAin4D5o8kCohZgWLEa0SAPTJi6Z4SciFiFt8?=
 =?us-ascii?Q?ScCRQshj2CBRPT0+09SjePjYZEaVCZc+Ag1aYvN1H01mqojXiPrgNX+VbJNf?=
 =?us-ascii?Q?Kb79AMKrJtQUruueBxDa6TnpHQpOczNL3E0hKuTyEs1Q5GZ6hijC3m7BwR5P?=
 =?us-ascii?Q?o5OB2W04MMVx/ADxoqL55TO3ljC8dvmnlz8AEhdFLtIzCkA4hq01/U5f1hXw?=
 =?us-ascii?Q?7sB+i2yDMr5BXpw2XjlGN+bsuupzULr9kxw+TrZ+5StFl1OgqpGbwhiOnXSa?=
 =?us-ascii?Q?ECPVbwzORPRiZuZYxBHiqgg6/HbVg3y8WCpi2its0po8g6nh844tx4rXwbbG?=
 =?us-ascii?Q?J+T36vLY5lqkU7j4qx6qBGTAwNu7uOI4BWjRyquY6JV0J1wdR22JwEaS5xr5?=
 =?us-ascii?Q?Dxz5CXpvhL/2WMhNmqyxV+7TMt9pDjygyt6EE0ke/4owdrMW/ivoJJyBNeAx?=
 =?us-ascii?Q?nf/fbhZB61IQOo58Vcz00ALlMvWzo0tvCSxGLZQL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a0f5ff-ca4b-4f1c-edc7-08db414cf528
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:11:39.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cv4Z5gmLPLXduOhOYzZt7zTJrVSA57DWt0slXCGsxNenA5u6KbG6t4Qg9okQuvEbD7ew4kXOi7PuH9AxqAgeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Only send RM_ADDRS to remove addrs in mptcp_nl_cmd_remove(), add a new
helper mptcp_pm_remove_addrs() to do this. Use mptcp_nl_cmd_sf_destroy()
to delete associated subflows.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 16 ++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..d85649bc27e2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,22 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX) {
+			alist.ids[alist.nr++] = entry->addr.id;
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_remove_addr(msk, &alist);
+			spin_unlock_bh(&msk->pm.lock);
+		}
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..6beadea8c67d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c39e172c95db..1a2772902e9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3

