Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283301F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kW4kUCRJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw7lTmzA7VWd6XiUHwnisiHN+2QgpHLNr5XsTdh3f9eUwlQ42DLesKYI0KoCws00C9aViKP+339Yb6k6LIpw5gORVW99RVGSBMUyMj8lPktFVbOiW4zuIodFkQ0lpobGzcjbicbeG1/4XAT4TcJMBE+ICq0nOBEJAzVjgQcKego3IMhXiGPb4eVp1hPiGX0WmpMnzjSZniHfeOt0/gUnfERsDjKHH5oS8I3NL1YgA50LbjFFS0jKau3Jzh0BU4FClA9Rn4yVWgIDq6l3CtAKVnuiSKLcDX8FnNALF+Y0ZPb2UnGjszMx6YuEEKg9W/+lOkL/82f2RyubkZ4np1aIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=hp7qi4ujcpRZ7uIDIYLXTZ+tKzGk7ICzFsJKkSXrTjDWKPx6+FKf6nvBlMghPcZZeP5snvieAq/jJ+a46mfM8UdAdayzKjT/WSvO6LpzmTXglQxafLjkp/HDC7yMigmFA8LtL3Xt9Wojk4zUtV58NN22zw3oQGmIMOYxIoi+VB9t6rYlehxOTMLLtvb4ZX50ypPcfhK/lYZ0CU005Y/X6JrDTjUYxCw1db5uuMcmCLTJFlFgvJDQPiBhFkzCtMOzZFUHozKIVyUoF6ReS3y7v6tLEXlAhZ5mpGMx3cbS4EF0CGzgvvHIPq+qyXboUaeCFcJKJTn6Lbe4wGGVtlD34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=kW4kUCRJ1Gyv7ijJOzW7Q2BA6wvIeEaTRnKlru350MwwNpbsIZSAd0xazAzlWRfoC4+ExkrF+mXuhc1VH6B1Qfgv3anTo3WXkiIC7gTfIfW1AC65uvswwI+FPhFf/amy/+uIRPOz66cRc6IYOsL72QUG5j/3GOPix2lJQdzyG0Auf4Cy9630Alr8aRFYLJKqhpluwXS9YpcQBnAl/dE3bzMEeEVloQ7ZRb/ZUDmmljW1qZLY3Hc+hIjmxCQMkE5eQdx02vsLGWECVnFxlQVBnAMxoAfvUYoblexrFBaWYhksgMlEPhfTzGsvANC2gmjsW5vRm8PewtFCDSZTF0eMrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:34:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 5/7] mptcp: userspace pm send RM_ADDR for ID 0
Date: Wed, 11 Oct 2023 21:35:00 +0800
Message-Id: <072d67ec54be6e114cee2f5962419dc504f2e217.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f52a953-c9b3-4e6f-ef8a-08dbca5ed381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SHjKK2wDevpCiPJf66AAbWfaOsolhw1SwtnPXIkx2G6Kup7eyjUj1TydondisJE24C+PoNz5UNzniRU/03bPkzsycowxQqK96Vu+CSN2mssvglqhEAYjrKvJrWczhFt1IiE8dA1B/Hmt06qDl+dW8PAFXY3XqEs4MKWmnMXJylLc2YGHklMex51TP/asJ6BkF8sqSX1r31FGKUJd/Qk59hyQoxB0I1JgLg4Uv64AFPvYgrcvb++f8DJblachYla0bcEWzSHJUduq/61BUQ/Q86l+8GDjSaqAEY1nvVW8zSWndelE5TsU8aRflql00+h86Lks9kLN1uO/GceoDfjvFAnz9Fm2BivZk1vULcSl36cvCMer6dC36Vmw4Cxq3NcsPaEPM73h0mmR4/k8fCScNvxqxPfbEHTXYxzdUxq+egY0u0R5Mlv/QWgSDTbsYjpk9M+yHsZY2JMh7q8tL9asKRK30tzD5VWHf5fVmcD0VICY7Xw0Q+EKnLYz3XSdPmEInSxNIuOFxPXX8R1GdyQMQ9hKSI9q8COX+H0jYisIJWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(966005)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3+pOm8ELQcMe/zLzw/x8X8b/+DRC9hQu+z2UYxDOiCTq8IJJgfKRvskjmCB?=
 =?us-ascii?Q?y2PnsyPp90blU/m1+BmWz3Ztf7jYuhH+V3xTyBfLnVfSIPxgwYs8/Kfc11ut?=
 =?us-ascii?Q?fEjfa0kLu3XiOXIze8THSWnSJgdhmagIntaTB3l5EFdoOw0KIqHbfzOnpJjz?=
 =?us-ascii?Q?JQHYdpS++GL46jXx4HJ9X5BzLU1pTdcRDi5qMwY/u6gMsIvIsyX8M6j9Wseq?=
 =?us-ascii?Q?mevFnltczbEluXcy/fHfJ0ccS5BGMhCufMxEP/7ItwwgoxTBsM3ESlMUh/mS?=
 =?us-ascii?Q?97Hfx3pT5ZFX9/dLMaDKxZX2EA/4AM3HyRDjvKAcCORIBGBhGbm72gBzNQ4q?=
 =?us-ascii?Q?+82v4BZIQR6V+Yg4lrgeO8O/2EQtNOPnPRLry8MjB6tMvTLaYbk2P8B982iV?=
 =?us-ascii?Q?ap2qjSugq9xx0/aYLQiV8SIZYZWzYfVTAvJYcF/H0Av+wdguWd+xei3K9Iqh?=
 =?us-ascii?Q?yerfSo6Lo2XFdTGXlIVU1cWiwOcTZ9vHwxuEQFDQqdD8deAQZ9mGAKK4+S8i?=
 =?us-ascii?Q?cVPSg2Jn4AWSFVFa0why2Cr82ZdNA0Cy8Lq23/J9H7U4F/sENi0NhnDAnbUl?=
 =?us-ascii?Q?I+wd1NU3Rrj0wfkwT1wx2F3bktQyDW4eFV5RpNILOL/di4nGItnnk5PeagOb?=
 =?us-ascii?Q?Z4f3ubgm1WhZxFcBhcj03sdJCoaHyRogFBQopPka0ICoke7bmYTls2c5rosJ?=
 =?us-ascii?Q?p75aYUec1gQlZGX9Ci7Sn07bHrXWfr5EjIiBZWjZ3/QSkyRfHOnTxBgesE+b?=
 =?us-ascii?Q?TahWZRuzIcZwJxxMYn1nMRtYSm8ZVkTqa0Cvu/oTFWXi7tc6ncWjoIeTa4TV?=
 =?us-ascii?Q?wPzfplt/Zo6xB3p0YqpcrMfA63fCAZihjSnns1FdRX3ohwvmlY1HBDP/5kSn?=
 =?us-ascii?Q?6sVGHfyt40ztAp4N6i4BcnrJiHqfKykrEuqAtgTqvl6cUePkDlj5oJtb/9BG?=
 =?us-ascii?Q?QdggHOrqpt61IWxft10hOSjB06UAFkchYVNR+p79tvjK19NejQ8TObj3vCuy?=
 =?us-ascii?Q?6PAi6KupJIOfxKhJCXw6kN95VhklHoO09i+aNVWugjl6IkoFouZbYWTD3RVD?=
 =?us-ascii?Q?RjLsQuN39rX/TqaiBvOu0EbkbDndkkgmIc3szMCei2CZZvqjUA6rF5q0Bl+2?=
 =?us-ascii?Q?Yh6OLuNa9yyc52CUr76ycIrcxEeoYGInWGgHQMd8dAuNWAqGsqI7l1iJwksX?=
 =?us-ascii?Q?M/PoyKzAp676fqazS5ccOW0FZ7+O0pjyl8ZsU++qAwB8GSgbocZwkLSJ58x5?=
 =?us-ascii?Q?inbrjzf6TubS5Gz3UqXPF7XcZ/V2a2EBX7WmyhDmXGnaBVhHi6iE7ekbJFJn?=
 =?us-ascii?Q?Ww8pqrMU4UoEGmayk85O8XUyixTfB80RqOV3bETrI6uCxeXcmtiQGEYGCYe7?=
 =?us-ascii?Q?4dEzZru5m8fUmobdqk1mktfw4fha8+u0sRZnw7P1XGbxAsZ9hf+4XlD9ebOS?=
 =?us-ascii?Q?xFVk7XxPazdhmWBV0V1H3RHHePIpxlfqJhDwEcSbMchlR/GFLk+zsgFnnmsU?=
 =?us-ascii?Q?twuiZeQT+nRcTjJASXxMwU95t3wq+wa1YvzilIUBXo5lQynEZ3w997XY0gQc?=
 =?us-ascii?Q?81zjIe/cwhIhXU09yzx12jdSFNFOeIDssM7ZPjlc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f52a953-c9b3-4e6f-ef8a-08dbca5ed381
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:42.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ye0NLd9TVax0lpcwbhE7avqHJolEbF9YBDBii/urIIkgu/46UUa/LXjbXNfFlJnsryid3OnfI/Bt7Aq8ybo0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..ea50e694125d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,40 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto remove_err;
+	}
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	err = 0;
+
+remove_err:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +279,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		err = mptcp_userspace_remove_id_zero_address(msk, info);
+		goto remove_err;
+	}
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

