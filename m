Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039E634
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 04:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyBEAr6sCgXJ/01u97+ClT5aGxRxwVkPlGVG5ZdsJC+NN4We0Hh1CHfpYaGZSFKCgB2pEzAuJREcCEl3AjAlZ2IPXAEcWZ6DsEzkZ1hOBI/XPf0xjhyVxEWa6n2XlyA5jUfT7nclrdU2cslO3JLxfD1TY7bGNnXo4kcwGe+42OXKqxzIbkq7XEr3SprKpkJCBdZryKHKtn0T7D3dSu3kLoiQRDS9UDdQr3/y/G+1Fzf/VXnLWWU+/7Iy53MbKhPBtuG/+zwxcX6p6oaM9KUVVL4zS8aYFkl/53INEm3M5Ow0rg5vfN3oqWlEWQVaYs1YuUPa2Ckd7re7twCWeaUEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/CQTT/sOlkXyw3gswrvOzJBYPjgEls37Yf8JCq+Ai0=;
 b=FjdfrvvNztfDm/bYE0d0yRl1xl/dBGxKrhg9pc1Fy4v34Hq44uFuAhlyaKmwfRCV4zArGifUST5YgAwTl7HraTU65x/AcN/XJS7R7lKy11T68qao1KpMrMRsprp7p08Ek8yMcosbQU3ttZUwgQN/b2vxFdl/6XArFvmkh0frBdfiegKOvE353bPGC0Dh8rxmiIkCIaGhHUduspVX58HbFEdAJVRdGlBrqV351fFiZ/e0xGWtq4lHLjIIuMSfywM/amZpZR4gpu9Z06+Rcq/3jPmG5HuBiVQOBPnqDtDLidObXRZnBG9sPW7eH0diQL+76neJPVnRd7lmvWAqr3RNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/CQTT/sOlkXyw3gswrvOzJBYPjgEls37Yf8JCq+Ai0=;
 b=yycWulMnWn/qqYBZPX6rKevtARk0mFmPN8FPXoDfboIlTzNIJqNKX+31RwuWW5Yfjys6XZpWg6dJECBb9lztyEVUJFgn5w4CAe+8U9yEOD8aDqqcjgLfHbMFTPbvArXsDwUPe/N4zB5wcC7+E+t7GzgGOMXps+fV0SBkvBF/99+jPCQ3N+Utip7dR7nZ0hQxXqXxSDeQ9uAKYucZ5TovvnxN+g3+y2INnsgIOgmNtjZohoaPi/Gjb+uTF+w5c+aUh/NHcsNWgK6j4qU0h4/y7MB8PBoUjQnKQ6SX+M6ykvw5Aj84dQgyLrsdx3r/pkYZdnsfSgIdNVzlXz37q32g+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 04:36:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 04:36:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 6/7] mptcp: userspace pm remove id 0 address
Date: Mon, 28 Aug 2023 12:35:28 +0800
Message-Id: <e5458aa0b6448af4d58fac733e1155e182292c0b.1693197152.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693197152.git.geliang.tang@suse.com>
References: <cover.1693197152.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 10019f74-d63e-4253-ab49-08dba7804b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uxmSmKZZz2x8He1kncYVuGp6wMHwH3i53tfbesIQ7rXi1bWaH6ws8mJ7PZxNuayN5WIZ6zoHzYocRbeDwfF/ScT0YVGsYTSuN4HsAZn58PtQaRLHSlo75NrGDmH5OCsBLEXpVwmdrWfcMUytqXnjnfNbDtB/0HRFmNyMDVex1+Z6+n3mAbA/vKNErydsV2LO7S2/WSa/D4W9z0U1SMTuUXiUB+eR+58CZDmsB65EQtvjnWkbl/gD+M54xv1mXsjdQoIqdL6ZkJCZC0o/jnR+XeBl+I+1MY8gUUiMsco4Y/7Ut/u3vWwYnQ2RLiMr9QmcTe86bS290ruj5HGPm1yIPgFbKDXhSvvRX3JCZvfDjR8P+LY+RW7tHg/09b9eakgi6KKYVDaOm4hpVtTw7vadI7fUnBGs9C7ExNuxdT7q+x5gQ9YcjLvC3i/NfvZE3M99XsRHEJfUH0rLBv9pcccMnKmlrfry7UyaBBSJ05g/egIb8hLtJSHrBsmPezro6dLv/vkINoMT179hORUxbP0IOxe2lVIoUaVuWzKHTR3SAys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39850400004)(346002)(186009)(1800799009)(451199024)(41300700001)(38100700002)(6666004)(86362001)(966005)(83380400001)(478600001)(2616005)(26005)(107886003)(6512007)(6506007)(6486002)(36756003)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owCLPMks8GY7psIV0fqCCSMmbVOVmo5un4kYpmd31cDdYQfpV2S6N8XJ/C4x?=
 =?us-ascii?Q?IwlQc5JBofSbeqUJgbPnc844Rk/igWz+zIGoWgKyE6zFTCZB1o96O8odPtpM?=
 =?us-ascii?Q?/XKNV0JNMaApEolR/lXs7Z5OTIO9/1P3RqkNzrWwU1pd2wgNGhaI3/RVPPdg?=
 =?us-ascii?Q?j8aDOPimClL7FUvvf9IrlxII3yPoiC52HXCrGibyXIvrrXZLz/LJYDFfBiOQ?=
 =?us-ascii?Q?YgnUabvfO1gIWoIsfm7HW2N3SWBBZ9kqzGKfpV02/NpxstGIlFFIEtNlfolr?=
 =?us-ascii?Q?Dbe2JjzfJHCJFrH6ZI9RuhpBVC1Yhem9uZ7bbjiFJUBpW7E0Ybxjimbd8/Qa?=
 =?us-ascii?Q?q+ssURGowjhN3Gq94V5RfsF00Wbwf6iKvwFCzH9xzy5fL66VqUHUjE9obhbe?=
 =?us-ascii?Q?71xMZWvmuJdd15y5lNOZ38KtzyeVeZthSgWYfATBxLfdrHwKkzDqy1T1G01E?=
 =?us-ascii?Q?syiYCvfSk+PQUGMQgEKuG+/3cljwdmJ2Xs0athf/WA8ngpWrdHFsagL2906y?=
 =?us-ascii?Q?hAUm09TbuT4iPaJjYAcXau7AkQAzVKuIIM+jTJsYP8nlVRTXB4x+leigKjJh?=
 =?us-ascii?Q?fF4zv4XtvO87owOvzAGfXsJHwQFZVPrcL2pXUCXXfnB2WCHFG88Ij4cKgOPW?=
 =?us-ascii?Q?SM9lQ5jhJtyWRPtYLEenHr9a/RdIqOFqWoaSSr1xxBDu9zcA9l6U8k7U7Y9y?=
 =?us-ascii?Q?1cUo3gbpargAwkCV+X+gKcJfk7CJRCl4HPinyq3w4Nz3dabAkSpXiMFbRC+H?=
 =?us-ascii?Q?OQaB6dNGc+bywItGwExVnXrjm8UO24fTDhfwjNGpGQ4XTPRSa2+aJVJc6o4u?=
 =?us-ascii?Q?eCERHYRuENxN61KzZ5cyoiyp1Q1H6MPIfZaWVj5wG2WZSsVf9P0ya1Pf3LCh?=
 =?us-ascii?Q?b1fW1ju7GLtVzWpfbGqtJwJoIUT92eDpNc3TjpTT3i52NbklNRYhuwZQsUVW?=
 =?us-ascii?Q?bJ8WLEMRNcPlrmrQyOW7NM6rYYUNeY4hcphaJiQFPyaGzCj86rb4Y3q2tPH5?=
 =?us-ascii?Q?9abcvMarZTfxy9fuadiL2WEUwYZXbXbUI3VflJxrWSqZgHXodcESUC4k5vVQ?=
 =?us-ascii?Q?h3r07X9OoWaKYpYHbhmYhA8jmhb3q3qirvLRL1aj287skDgrPMGZQi8gfS8+?=
 =?us-ascii?Q?kJ8/mTRdo3Zp/zTR8utLajEeotridQFh91qZJ/ino6klmTZd9JoTNlYs7ndZ?=
 =?us-ascii?Q?b+5N6PB2eJeHjwjQKxucnUvLUyVkY+Z7Z8syFmz4Zv5i1Y6duq+yfZ0OBPLV?=
 =?us-ascii?Q?HpE0A7YCL1zGkyIw9fsdssAjPb7yqmVvuwyylKrcy51lH7cf0rY/UBHIzROQ?=
 =?us-ascii?Q?fuTh3fCnrzsVq36cAx1B2K6tPr8W66JTDN3LrvhksFgmeiCHpX0aWGF9SVD1?=
 =?us-ascii?Q?gtEXC9dqSkAGEsKaxw7wPESyNKN/gXMZI3GpANEqFBkDY9Q+oAA5wOXdjD67?=
 =?us-ascii?Q?7L0UlgbUlK+1CM5vH5lru6B33gECNCmE69o1TkFTwGQNySrv7+NYxTCivHJY?=
 =?us-ascii?Q?bQrOXM8akR5xhRESkLuVfrhABCNornxvHMcTWpxVz8qD+NxHKaepasOwRLSQ?=
 =?us-ascii?Q?N+slN5fbxerxlV9mX5SGo2NqXyJDa6xWEvIS8Evs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10019f74-d63e-4253-ab49-08dba7804b37
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 04:36:06.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRl3yNU+crj37ndvKRgivoTFMRvfcSjafiyBrqkal+wnKNq3sLdIAEFNAnEq4fLu9quacE2TFkW3j6M3OpyVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

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
 net/mptcp/pm_userspace.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..41d2d57b570c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -208,6 +208,37 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock((struct sock *)msk);
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->remote_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto out;
+	}
+
+	list.ids[list.nr++] = 0;
+	mptcp_pm_remove_addr(msk, &list);
+	err = 0;
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock((struct sock *)msk);
+	sock_put((struct sock *)msk);
+	return err;
+}
+
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -239,6 +270,9 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0)
+		return mptcp_userspace_remove_id_zero_address(msk, info);
+
 	lock_sock((struct sock *)msk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

