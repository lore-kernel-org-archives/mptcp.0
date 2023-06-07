Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CE7488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C79kjU98974PE0Glt4k1bvz0pjSPC8pb7sB+0pDbk+zPFh24/NUbnlRm5gWfJ5Ae7nFgUMnf+yKK+4OXc6Kqw8A+ug0/X32K459NjkTLYz9kD7Fh3viOHIceXH2aUB8tJCVVPdFFU55C+6cNNfHRV5ft2DZMwnlj02uZ9gdA+Q41F52c5isaHN1AFpYVjzKPNXer0qz4lLoMVwzUltQNjk8DDN+ncMd1K2FK/1XRoraHyavNFtzHj5ge7UpR4Bon3Ve2rQ1BpyhIY30SsLncobqfoQpbBoOFSS6Evfod+Xm+FPN9MwB+s1ipoWO+wcJunQig7ISRnw/Euv69I89cKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=AvN/09OS5Jhy6cokcxlujglYOzNQh3GzWIg8rvSe8MmfGMT888PAiMXAtZO4+07VJ3igAFwGwfaN1HtNpNsA+Kipvh2r8TwTJvqAhMc+yzlqzdf1f+AsLyeKBlJiy0kVJL1yANDNDUW8c5R89lF61M8UzYw2qHjfzaRlcbNjZyJJXz0vL2QIKIynp9LxcrcMr4/MYo4bmAS7qDKHMCPhE6sKQ9Rjbtcz7UedKYoDg54YIMozKWhzJCONUB+GKwbS7c5Wr0ZHkY3SZhoGzbkzfUQsTEnXF+2KPi6QM67lFjZpdNoxb1agePy6Uqn6rOBN7p1QGuJzwAOCjTnm6iRO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=anfFJvSZb6+Q/pShqxgGibelkHFTc7tc+Cx5oLc/oC0ek19A4cFjEPy/AwZO2xqaBk00mDaExU7ploeOxEAqVVeQnuCRvbgbAZH+m07TV0GvhAL1leCASfujpUybDuf/iOzTWku0De7gu8JeRDp7wbat0C8nEOQPOBFBXmMxbPWx2rOI6SsULkMOZtlJ0qSjcIZYY8ak6wUz8JJPCx+4wk4BAt71b9evjQfvLTJWe8MDX7Qab5KrMQYhrZAN2kVSLG711sn+WCozTf/e/F+1Lr12lG7dIp4SNwU2MQqkNh/z6gx/MKcZXruktcCKQRAQYnnlNX/OrX4hF2uNmbeCYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:45:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:45:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 1/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Wed,  7 Jun 2023 19:44:20 +0800
Message-Id: <35d417b2557f609483c4fd41b736588819a2b862.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed8021b-1ef1-4659-06b5-08db674cae0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sJ0Zb6ATyZARTGTGfYl29yoHPeWJ3pidttA4dy4nV+AZs4xgqM6/hB04LazFK9mxlBYS93eFPxGnTEk5eHTASkDxbFJMS5fsZOOC5ny12mJrzeQ3la0X1njn3QMlOuamA79aSfF/XoYsREMIUjMh9sfJwEqeBDhbbUfWJI3H1eAs6IrdcfRsvg+LHI4kcAQcMsodIB2h5538MFF3o7tdnhnlMVY7mmVuPgcTUtdi63Mcch9ignaNQf+ihYd/RI4QioM5rknoK2Ll+M7Y0hGd2a2i/5r1QzsUjIbhGYo5K6heiQuu5nVt8Wk4VZBpErcHJS4toLCEQUnfTqUqeG2aSq1GnWKXg31R9J0AnOvUjfMNzpcFCTIdVPqFNoVvK8ES2BqP6a6vP/eL5aLRRmvwdkQSa8+OeY8D7NE16YUqp46SDcbL7ycG56B8f7O0/aLXAbZSiTLmXBckrnBK854c6wwuTP9lX+Br5O1EKAp8zvMnOIczENgkDsdIdzRBgxc1ZsK4OG617NJ40NbcfMkro8Pt7iBgDrPv269Dh18e1XGq1/g/s+FHwXefhG9U/K86
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tclKGOgukgx9IswPal4Xwe0G7lmBFkH/bLp7dJQrCrQMarEIKf9O5oKEZzz0?=
 =?us-ascii?Q?DRUvhg0WEqPQhBxWgPuGa5AmvFeYX8Kd4xdo0o+nqO7Qx8QK3EjechZmu5Cg?=
 =?us-ascii?Q?0YQ3JZenFCV9Ex492QHosPUE30g+3IMCQoZOJxxkVW47H3M7FsC/t3VQSkbs?=
 =?us-ascii?Q?9/Jy199IsKJBY2UJLvacp9mhCmLKe4dhSYIIivGfg1l+Z0rw3qYKXPHqi9yG?=
 =?us-ascii?Q?y08HyLhG0mHI+rUtydZzPmvh2HCWNTuiUlo1ipqAzvdwZoR+b5eeVFXtSNLt?=
 =?us-ascii?Q?pPR8GAozPz12VYgqp/ArQoFsTWl3Oi9aqWaE7fHs65aituVaBomkhuqQbDOG?=
 =?us-ascii?Q?EpInj+tNJnrRnpahAeOYvKAvyNWyNNYRLbJ39SJReQQKtnvG+2HI+gj/FHge?=
 =?us-ascii?Q?b1IcKY+87Y4WecEmyA5snpG1NYtB0JSaGqf68DvuyIJDGJ7ojRBY8F11Ptxh?=
 =?us-ascii?Q?m4bPv4GFpG8whleykQApkelsGA7Y/x1nqAh4eWinWm8S0kVFxQkoTK6guJF+?=
 =?us-ascii?Q?sPnlbqcGiOZlMKsBpX+8VjS9I4e+bWqyJ7XnmuPk9NdOu4927etokXXsWo8g?=
 =?us-ascii?Q?c8rUJ1OlB24Fm9komkTuJ7qPeORf0az31oeXXQPpw1GKds63KTUgYghgWo+H?=
 =?us-ascii?Q?nlSrbUeQu5Ds3Nfuq4XLNHvq5vbF2stUsjPxrJJRbHjWpEbhrQDpS7JaPyvO?=
 =?us-ascii?Q?opbcfwuzvRoWTIK63l76U/j8rJaPNe6Re5ug8ZCdoFuG6+85JXx3WGtBK/at?=
 =?us-ascii?Q?ajMqxQWdkFuk1qIaKeE26OviVsCQEqQGKcRe5H8Qe1RiAPlkD4H0zh0oUyaY?=
 =?us-ascii?Q?xGhQ+MlpcbQYHYWMJrjOa2sTsHvPP/CcZL6lSNp2BqrqbT8Wb4eRIq7P39QY?=
 =?us-ascii?Q?Jr+aoO16GnM7apMs7vWCK5efXXSBaKaFge53/jn3YY6Ys9GPNLmvOEtQHZai?=
 =?us-ascii?Q?pAfmmEO8QCF+c/xMeb5pg84zGWF2TXE0e9TxcyIZgVFWwv0jrO1KRTDlBpv4?=
 =?us-ascii?Q?vTcor/rtEggKKffdRTEBEx0HITmdTfBjSiQiuF9gYbJlQ5b7mWBxtOxY/Auh?=
 =?us-ascii?Q?dZs4XUstHQrzsa2cs7dE4U5hJ/mS4Hq1kXxw/2LD/EGLDEDUN1YlIhgkshem?=
 =?us-ascii?Q?TGdqwFIxdEqL/JOsLeT2KtvZ4plOOrhG4jlnPxBv1ipUuTMwIL2GeZ0gg0/L?=
 =?us-ascii?Q?4LWkFLX/c690ayXQlktjrlYCzNagPWVpLQE7GBCaG2Mm27l5P9bkJhzSGsCj?=
 =?us-ascii?Q?xDtm2tncwqWk0n2ZUQPZtW7XV675ZTcpj9RBld1RQbC7abzQIDPzd2gLwxFN?=
 =?us-ascii?Q?OMcnUkXOAcz3FGaIHoKtj/84vpIDwIhD8dO9N35afNnkihNduadB2uqOwghF?=
 =?us-ascii?Q?068nDzWB1bSkJvUJ5108yjon3PtGNKzMZGwVVrvqwU6CitE+/c0bB1jQ3JVN?=
 =?us-ascii?Q?FKS2PpkuXAHP3LpRRvPLMXzBafrvkOzDA/CtAMD9GOqafzzwM0RDYH7eykNH?=
 =?us-ascii?Q?tXBa/P0DX7ygwlIfq+YS6Ev51Dw4J76bkPK9YNCVOAQudfUehNcE0Vk5LSis?=
 =?us-ascii?Q?4cjq22d2aJvJ9WlPgp2YqPwa7MCV8ux0jU2l35hw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed8021b-1ef1-4659-06b5-08db674cae0f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:45:24.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOWgP9kq9ThisJlrEGkRtT+pnOyAlEjZP1EHJTv7bAj+cL/e4BbF40IKWkK7JEq44JiRyewS7wZNOqjHnZoCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba1406e601e4..724b652876cf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -341,7 +341,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -349,7 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -366,7 +366,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -573,7 +573,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 47a883a16c11..b5a8aa4c1ebd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -193,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..3ba62f1154d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -833,7 +833,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

