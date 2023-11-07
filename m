Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D01FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KvNYs4BK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj45XYDIanagwBKxE1lbLNKYumY8xRxJyaoLgwhQWEMPX/tyyA9qLMHPNf955YgDvBUmW9Y4W+Nd/0E6E8AA/ZyPZNpF5qi8p/X/kbndJvBAFQkGF5KnIv8fmAabm+JjsMjZieufURVGMH2fSGjQInuZiPKLcLPmWdu3jejmU/hQVj0PX9jDpn9uj8YTXPvNXOkXTa4OCC2J3eJyGXe9nDquMAadtUwSm1wCPj1AF064dkuW0cdoE31x5KCifBr5VKCzaYJ0TDUPnURL1LHuouzpfvd+V3U6qGuiUXLmSO+ullLjPJ3bhu0F0+YClZlQZqQngM17uT8H6eN9ZYSWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu9CrCfDzUavUX2oZKjGvwPBX6f90usa1TcCycyIL9Q=;
 b=hLc7aE2E4nloFuAp6lOvR8PUwFtbQli2BtRYhnj1kCemokLcjP12Rs62WgYafNJobZX9RwaYDhupZojYVbsRDLgMka+4Ow0Yj9EfccR5t9ic5oHhHd+/NNGmtU4eKazcP2eNkPojWBWvdfSDMhvTuHK8oWIEZ3PCqX2iOKQW09t5hQlnDER1wxzeVAq+rNtWejzwk/VexAEIN++JBVbSPF01VwuRv/jQMPCluTCVzJDBhYWpnZtAlnoqVKiNRW1QamS1WY09D5GDahCkAeWwj/CbWpDWhpFOmcYN5x+W7VxvYkS7vAz9SLP2HxxNA8g7iHS3sNUa1hvIfcFrbK1cbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu9CrCfDzUavUX2oZKjGvwPBX6f90usa1TcCycyIL9Q=;
 b=KvNYs4BKwYrquK+dF2kIaruZxnE2htwl4qbwtzcEBXiDP3RMwCgCVksSFm1lXnGnbWnBRbFwFPk4lffECgY3pmGVRSB3JpAZITFPsjqippfKfT//AJH9sjbxrOrh5O1Tq8KiNoKmiqBTWSyKWSjuwzDSnsNEQIVJ4WXVZ3IT6HYGt1YYghv1xuCTIo3aiASTIcnm8UPMbJoFFjtr2yU627C1dbCffHQT7Xfmttw5npNU+RxJUHhs5eFUJc/hK1bjkWrh9HktMNPZnqG976n1Gg9wsSub7GrPfvSA1OZRViSsR4pxZnuffPrCwAOBxjEekWgBS9U3nNWgBtuXH8RqTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:04:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:04:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 18/21] mptcp: add userspace pm addr entry refcount
Date: Tue,  7 Nov 2023 14:02:02 +0800
Message-Id: <db426d23a6dd56b6546e998ac637d71069931124.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:15::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef21365-a172-4df7-7997-08dbdf575a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1kGhlhw0iJwMNZyq6VAR+ACdg5eoWxAoLVGhxE1QLsRkd14p3EYC7JONDAgMUrdkaPPi2SLunrFakd3dLOH7lU7XoO454Rs0OxJOUB1bJvUZ63JBK/68rAqXNlqrm8afmLaMYwes32a0STdI1PzSa92QcBzoDBI1VvJgYL0avWwoACn7AqYDfgDpA7VvaZSJT4jUHc4akIxUHBnzC3q+apJS3+LJ7Qf40Fm+/W992ibX2xcz6hSz+6ie03I64VRiWQ4F/DbHPasP+Iegi0shJica5A56zLgkJkLfOmEQJ0xoZU2bGglYLAuWvYVJ3EC+WEYXorIbTLwKFcWTD6XwnGaXZCURU2bkYpxZwMJLMieb+Npv0StOoJizGihK0Ap8ThheWuk2hIIHL9RBGIq2bxBgqEl8wdgy9Ts7/f+Scyq6y02Ca3XgWuCO2naEkQsZWURzRIXrUuJimyuNTUNPU/u0gpUsKKxrIbDKOOnCxvthcf+NItmXKTv5EssNgmNWHuzMq+F9DEnxIE3qwEW05K6+p3MDNCkuQXAxKdBqJ24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(966005)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+y38xY8CrAasqgd6pK+mLXOa8FjXrYHTFM7bF7ZQiUDr5M8P5hR92Vfbjxb?=
 =?us-ascii?Q?8odwwmwWo/4D3UEL1WbcuRNnv1hk7KvbWLyi/yCKXdQNZ0Wj3iZqzaH7Ei1U?=
 =?us-ascii?Q?3zX1e0TSauxpqN1su8kJxFUDdknmsLtuUe0EM3Iuc7nENkwcbu/j+jHlM3CW?=
 =?us-ascii?Q?9efwiUG24uwzH00K+YkwmV+fvEoTPRTQlpB4Win0+vaQv/etL3qRIa46Udlq?=
 =?us-ascii?Q?qisO5ZfzjoLq9e9kCRHGMfhWfQ/0H5wIjeMmxYzgH6Lp7YIbJX2QQzgxbmuS?=
 =?us-ascii?Q?m6Eu0qy/zykXRTpiVHnvb0jtGVXamaSq0xQ8UnQv7Iq7OZaM9UAFnToXSKh0?=
 =?us-ascii?Q?WLcTC7TLge272nzU646/vcB1W5CTBMCz0WkMvgYaWTkKd/BwtubVmYsqwPee?=
 =?us-ascii?Q?NdN2hNGDzN3Ue4yft04Kh/gBqgmyB5ja8tWy6M69Kgj1EQfBhMTKjKKgYPPj?=
 =?us-ascii?Q?IeY9S/R8xE/AlC6r1kFNpt8UJzkLaWIh2zjb+9GE/K2doq9Nx1ywGbL/ArJm?=
 =?us-ascii?Q?AkrpX5urmberWK7ve2s+FFuRLtdvwRIiYDT1WugwB0BYngEy2UvY5I282RNk?=
 =?us-ascii?Q?DGIZmKdM6wvtjGzR782W+N86upQYGyhHYJwAuGI3wnY8OXfQyDOy4WwAxINi?=
 =?us-ascii?Q?AbQpE3/iVs9CCG3dHSABX3qfSQKVe+RnuHRsCdSKvdNGPEj/pSlj30WCCIil?=
 =?us-ascii?Q?AZj/qB+v73Qp0/wHbVqau3b0HonO6VzpVAUM9QX1XxjyVyRMZapAlSEXLqAk?=
 =?us-ascii?Q?+nV9v9J3aa+Cyz7e4YFMLKGxqvZO3Po09/l9ESmYW4kYzQFdju3dVq59rj6L?=
 =?us-ascii?Q?UeBqXsNPjakVJC5CU8tV35renlrwpbHD1p9GQ3lZAYemPtrxrzGBhSoDlofM?=
 =?us-ascii?Q?5K2aKmFCbwKg9db50ItFqPZQKxkXyvswc9jiKjoi1qTBAkbEXPp84OcM8RRA?=
 =?us-ascii?Q?/OrYywVBPO8ylVEWGEf/tGqvl5LK6i3PGrzaWbkw/8sevJUk8QYD4K6oAerJ?=
 =?us-ascii?Q?011D4jqQSxmv0I+4PbXDD+M5XpYUDXKDPMOjA4hRnm2A7x8sDfzBXets7wCn?=
 =?us-ascii?Q?z/5/Ea8lYPE9XnE1PNfF5dc32LLm0u9u4gZ6NX6xQQsMUSUMlwl9xH7kFr4T?=
 =?us-ascii?Q?qoRkx0tbWRVzTSVYcZPJTAJfiG6OW2vrkXIH9p0ZRON5WdnT0+9RntbkNLt5?=
 =?us-ascii?Q?4YWBw1PwC5+7T3lAjxv1idohvwdh60qyM77X203xq2b+ut7ppSRmjH3Mv84o?=
 =?us-ascii?Q?Yn9PZJBKfDpPdd4wuy5u5bF0Wwh2ZBNVL0WCHeH76RdYEV2MtKysYU/+jpp6?=
 =?us-ascii?Q?18PRkvkmtACL3VkDfdAfsGW1u4S+zxUqsaK5MKgMoKFwc+G51WrB5tH7ZUDW?=
 =?us-ascii?Q?7Oy7Zyzx3GJxLgK06GlePIYYeWw2zsy6RG2x5Aer69TD6Sr5wSZdaFO8rmr3?=
 =?us-ascii?Q?kW/l+z1Jq7TFKP6FZhijgz6ZhZJGSwQBceDRavD60Lku4e1HVov4QboWRu4r?=
 =?us-ascii?Q?TP8kHSX2BQ2QVTHm7tN9vRnI4tklthPk0K1Y7mKBIhrOfRNSfo4aw4wbcoQv?=
 =?us-ascii?Q?al9pCd+l9F1mi2tPbiioMU7WJSk/AA615dNAG/hL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef21365-a172-4df7-7997-08dbdf575a3b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:04:07.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pag6eG9oQ5+ON8AzIr4HRaC+WP//nF3gkB6fSJpRf0ZwZKrUTb12o9pRo5JsVijW2CDR/P9JExYO7fLqAcCYYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7ba872813933..8a2455a2187d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -83,6 +83,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -108,12 +109,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -207,6 +207,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -312,8 +317,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -398,10 +405,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0eb7b84a262..3093766dd224 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

