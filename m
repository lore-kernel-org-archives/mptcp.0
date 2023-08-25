Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8677E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIXJcWLMi/EIdYbkWB6kGMbMyOOELnvAImdxwA7q4LiS3OpxsuYwTrkMyeZr/C/F8YJiNykgrZxPJnV0pMfMANC7K+aWT2P6sxjqv9X38qYClB4RJphB1st1KL/Q5kCteaSWucvwzkX4ohaYsIeM5n/eLAZsTtyzCY+NuKwbYh43BaeYrOwluCy8MpDVwisc0p2MUujJodQgXoygGni9mk7p1Np7V0a8LWYui7T076umnThU/1aKJCRZnkIvUQKtTYCx+OAzMjo2zp/fWWajqKkrmEBF0Ifye7tt1pkpX/vAbE1Ah0lXOm4Os1xE3og+JpUlPJyo/kP0njHLwcAwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/CQTT/sOlkXyw3gswrvOzJBYPjgEls37Yf8JCq+Ai0=;
 b=nrW1MBe1fsCmbL+/PcRhuVMtJSkP7idoVLHNbsu/SFuR3nsNpjenHha3q75zfxmH7S0LwhbLOnjqGYZWP4LnfakmABDteCYnEJ3drj+lV9iIK5zv4VgWAPQFLN14CFWe1h8SSViVe/3DLiseSgnHwz6IrK63opSqQNKZ18raRSt/uXuMOUSql6p+GeAur66UL+X0m5W3xuvrql0wzJ2I0haEmG2eLr4W649BlDrHA0WyMtG0eiu5HLL253fAfPlc/JZhksNeW0vzoShUM/YEOjeYcCiqAXeIVddorzUulguQbcZ+52eirlbGZwec2/qvSWSSN1EUvIiwkwC41cestQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/CQTT/sOlkXyw3gswrvOzJBYPjgEls37Yf8JCq+Ai0=;
 b=3XZ+gu7YYH7osVfpY3jI7rA//+wNkrZ+sy7kcs0EuKmk4OkszGqUQ161RY0TAhBeXxl0ihnDrX6CLxwyE2wO0bRgqh9qzdF2h6WY9X9LoEb9PFWV5OHru9cekO8VTKT7QZe6Jrw86/XXb2DuFE+Futwy3DY9q6INajmQ3l/QE23ZUQngo3pgHTEX2GICT+44y9skGItcyzlrA+aZWtqQD4FKCxonHytctrX1prxwUMH5ktIlQDr9rJzi4ZxJgTLG8tjPwPWT8sSJG1QgLcjDKGF48B6Jw8hbtoo34Zf1NGP3cAvu6gyZ2m4LG7GAgYSc8H3kf5CLt93Is3xtqavZ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:51:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:51:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 07/10] mptcp: userspace pm remove id 0 address
Date: Fri, 25 Aug 2023 11:50:25 +0800
Message-Id: <06caa421abe4f97e121e30cdcaeecfc6d9550dfb.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0212.jpnprd01.prod.outlook.com
 (2603:1096:404:29::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: a05e8ecb-df60-40bb-4579-08dba51e9085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QYKAdWuQtNF1A8aINHJzOGbz/X31Re11P7DBTW2XMb0oG90lGqimiagPmk73jpm74evaqmLVYQtBz1YmY6VPA7Gko2kfByAxrKtr++/zQmhXxJMWIFmEm8K91LCqA9ZReER1IyzxkeXtFQl3+FC+usi4kA38xB37qTq7h2Mx+lUDiPde8FInCF7PRIWpL2BHKir4tS1DkHQHT3UxOp8NrKW/TgorMSFlrFtvunIYe6G3svfj0xk1iCP2tRZ+J3GLkAN9ZQiyN65iufEoYFQ3BVVttfUoSEpjpdAQC9RrIxNaQB63eWP3ZujHms86QNYWqGsrSmUXVBx4PRLRKwk2p1QLJsStcW4Dg5hLlQaQz4BJm3kvF5rRocL33gu5ULU9zk2kCCGB/ta7BULWl7CtznPOO3H9M+90SycNKfbrX6m+dAptCfDc28KuqiQkoCP2GSi0Zw4+CvanavACWu7eYSYkKUdWhPie5mqTp33jVye4Q1EQZ5zGIhJ8PgJZw82caJPg3NirC7eTT+Yk/4rPmujS0dTOdYH4CZOuDNfp++Dv9BGLbD0GRnjHsCvLpP+w2wcfbIcRVtUfKyszko0uyuUw/efPqy95aD+LnmfxLG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(966005)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8QTU8b46cbFURMWwwMNTpOBzp0JbuPkrtHyfNkYsY4Z75kyDBWSf8ltRuKDu?=
 =?us-ascii?Q?lA4HU9VLNXrdAQNCCYzvp9zrpkBfmttLXuWRyOJqAXJZ4osJXFdeOrqV6/7r?=
 =?us-ascii?Q?0oIKn1ENIhQm611VFkrGg8A4BLt3ci0MNZzwh9Tb2WqMYt8TLfVGUnqyuTbz?=
 =?us-ascii?Q?qtwJbSAE5Q244H7LvPEB0q/YMmSqhGv3/Ln3/7uneFwhx7fYd7pLqZlizMta?=
 =?us-ascii?Q?HX2ShN2hQLmg78V7B79AW9wsW1tRjGn1t5H4GB1h/xej0r3uYHiMH8N6mAPJ?=
 =?us-ascii?Q?+L0Mcjn6esVc4l/KjTLCt0rC0ZTm00aQfcYd30DR13/xjm5ZxWixyUozM4T+?=
 =?us-ascii?Q?dMUvE1HVxRc6vNGTLUUQYHlF6PMbFNQ45j8AgWCupPWSGPWQ27at1aB5EYpP?=
 =?us-ascii?Q?ROTSauRGaamhlozfDUoGWz7AP548M1978GpW/nOP0jO7/aonQSMAcWU/90ej?=
 =?us-ascii?Q?tcZJmkztUdyBcXGGYgiUbMgBowu3VpIGJ/xU1MvfAb2H2+CnIwmff7VLe1/H?=
 =?us-ascii?Q?IgUCKKVcTU394H01h5sMgBxzQychynAORbqUlqAwmKDnmlV3EDOaAfu7AI53?=
 =?us-ascii?Q?6Gzi4wXdTs0DhNBdM9NuGAxRKa33s+Bu035guX0R1ZNIuML2rzAX9zYRiBtI?=
 =?us-ascii?Q?HmP/DqAS9DSW0/jbTtAWwJn36QohcrDbUmoIxbSCVrZiee2yZtYJx/ByalVR?=
 =?us-ascii?Q?JlwkDaDcaNKxbVUGKKn2YXRp43UksHxTEnpYClYQwdwDWwXoZGNTsFqK1gLI?=
 =?us-ascii?Q?HH/bnnDig/+zxhKx/IjBRjbdrj5FxXDobWvn/7kYetwhCryYVSvgrEAy16sG?=
 =?us-ascii?Q?zYnf/DGBaVRK4J36pezpy6YUsypj44ghRGPZVlkfto5Fe7hOB5Zs9f4EGuSd?=
 =?us-ascii?Q?S431G3Cr20DQNWZ7OibnergpWZWS8F2rQWrGIhEh9tkVPi1KHo9l+NV/DbZ0?=
 =?us-ascii?Q?gv+IXY+NTG/I3b7GI4M7eAb6BQ/tINtxTXIIx5PgfOD7aum+PTpdlmj90taB?=
 =?us-ascii?Q?ByYf5jb3yIdGOCa5T9MxQqz4imfZ5epxql6plTvniHwE7j1SXlj2PvBRHNtq?=
 =?us-ascii?Q?/3t430KYWDo2wWeY6quw4cG34bohEphW4HB1/4d2Y3uuKt5DxqjyT83fUAWx?=
 =?us-ascii?Q?2yShDRSkjv1iq6MD3RbEnhdl2xd2ZuW6AViM/g3J/zCQPBmrVjkmqt93bR1e?=
 =?us-ascii?Q?AwD/BjOy5hLJl2Pz2w5ZDN909lZ0GZnZ4XekGZynSJqVEuRlguNlOoKE2e9l?=
 =?us-ascii?Q?6SS8Zhjov86gUx4649a4wDrkhXJWxRHnrXuvmsagGn5rA+2YqKZWdkGQK+yc?=
 =?us-ascii?Q?tYw02KMD0HyexM8yXRzj31tTVgjJ4+ubk5KEdVgkDRe2aiypTIatmE0/JT7i?=
 =?us-ascii?Q?ChXPEuWy+WsBW8w65AmfTOAX+Xyr0UXfrKpFwD4V9w4dfIvRpUfV1eDEPeZQ?=
 =?us-ascii?Q?Kj94tAPIhtSwaShIYAQkh8Ju5fff5ehhRTAEGhGtsS7dGNUG+Ufjqcq53C95?=
 =?us-ascii?Q?/sJ9JTjp5FAN/0drOe/Fx8b5l54/1yV8Ne4HkBK8P+5CeUH3adCsM7BGeUbb?=
 =?us-ascii?Q?TnpJ+owMj65YfpVWt3Hf1HvT0V42oCrlbECHMwpnFsQwbMkCZ3YKBc6A0iH1?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05e8ecb-df60-40bb-4579-08dba51e9085
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:51:29.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yqgCMCNeJdIrIFNXJDTxibtlhl3E4UzJ/qISzJrQXDHX9pQLhlYqRzY5cBrW+wWiqxqCJRrDA9Ayap8zcOz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

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

