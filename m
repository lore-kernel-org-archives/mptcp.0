Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EC566C
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWIRzptZZVVKDDCSicp5R762OeoDMruZW/4dO62ozZ4h1AKXTmEZza/UyUX1lb9JXr6AoceCBmWdzBrsOWyOsM3lcH9YLKholX0/qaCXD58Yizy7x8N7TJLnrmmRa5mK141SBrXykkE7httJAeGJcnzzo0/6kH4qFU7VFJAAm/EJ05g+fiVXJcCE1QCzUnR6GoV6+O5AN8X0pTd3gkMSWyhLubkzyX3xeCeZTASLZZ2wbDP9txWY56hf2h4InECz38FqyIy2pZAf5C8lyorU1eqg80NLlb+Gi/MNnox9viQFEkYXxGPIQqtqYkKQr0SQHH8srsRAlYXvlaBGYyDr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/CQTT/sOlkXyw3gswrvOzJBYPjgEls37Yf8JCq+Ai0=;
 b=DelrA+d+HCQAuejLvwVsd4jVPBXYAiLEq31BRX7ukkBAYwywXxHGjTIKRwBvEdc7r/Je6UcMSQMM+W4+ch/gXG5DqeIaxpHhbpe77IVeEAz7OdIVwF3Kh2dFA3SduGHcsLzlFrdedRqZPmrUSMdg6msiekR0+IuMMx4ZajZadJ0uD46aClQOilHeZJ4O/nHOJzHGhk5+AEZEfRtBdFzWpEmBrFc0cjhjGe5xkUfXQ7McBMXHoAjnvXlNDzn3BGMn8ikG+4gpyAVPcyY51fHOFO4HZxeE9NuS7/CGypYg6XzV0yJmPIeD9O98KHXRnVxDI1Injd9obO6fy2Qx9pHSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/CQTT/sOlkXyw3gswrvOzJBYPjgEls37Yf8JCq+Ai0=;
 b=PYhtiETBfDeC7VCRgZE3lf4J+7KQBWOsnxVkucL/raf5kgB0Om8tm0f06dKRShbpMxe6WEjA2EsGVartVvwuMwvWK6FdeQIBPf5n8mD9OwE2YOdU7XLpyPdaTvb2C88apLUIl/kSZjv3t9NutBL4xG2L8Ltbu+e1M6fKHybbP8VxdNhx2dOXmsmvP8vm1YtpWtAjjM/m055inwjK5ijlZIQ/lYRewBUti7yGdvgTqg/XNEJzcEj5Zss8vJirlupQaenD/dzFVZaVMtyK03PWVuKi+nbYl7TM1aJlVOIe+NS9Jo933stB5EkSgk9Wevc3Rpr+XrfX+kNAsKr3YZw21g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:07:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:07:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 6/9] mptcp: userspace pm remove id 0 address
Date: Sun, 20 Aug 2023 20:06:37 +0800
Message-Id: <74070fbf4c71f76e51ab9af472b9840babea2a33.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 72efeee4-5083-4db3-ecf2-08dba175fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N/BNSYJiHXzePGT77VCEnoTT/OsPqTXRS2UA0MhFFt6zCShHX16m2VGLYzUaAuTcCTiaGtE+sB4VVu9e/EWkOIWKhQjV9LEEmc9KQ8anILg8+x69Lqy0SGogsQ1wdfUt49rwDwUcaHi9uvhc3S+EDEBQ/MX42X79x9/7nB/ZYfPsxUPKoTNER2H99tfUlkknxJd8rIZr0FdQkMryK7FiQyx2uRVqDRyH/gTVfajgiTzsWYjcIyjRPZye75+CcdEhtqtzrjOmDLbKVHbKtgyGaW/N5UW6MSFM3HZB7SUNT5/7CiJLuOzt5dbcoFB3xIvzOHHuwrkpM5A6j2CCl4TqX3pnk8CTn1A5Q7UzeFiBJyxCn0Hb7L3R0nWHrZUrZ7s3vo5Tp/BFr7Iiqsyn63eQYbe9gnqkh2ow9CtlRui/o4Zo6wjsYaWoELmpJ9/XSF7Uh+L4awBQbrdwQ2f0YaOIjqHDJqMpXoSqPcigkAVuUEslEVdlCJ2xptZXhYdYcCl0lsdwbXdFt4t5JZm10LlVg3uvrtxIC5r3UJxHTxWtVro+O1jrce8OD4+yd0zpU3j8UXvCyh3b56HUCmN5/XPx+L8tQzGjvBio1dkaOpxrZ0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(966005)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZRD6mIv1tKaxZVF77oaR0QwzPtRWTwDWH2TuvRrK2z06cxUwFkOZpgKWRxnb?=
 =?us-ascii?Q?BSKZsm3SnTBCv5vfE75a0AwrcEBbvPT8GrV9dZXDMYLZ8uDDwmklZ5BLJzKB?=
 =?us-ascii?Q?B9+XWT+fq8+tjCNGVC5XA6yy0jL0aOkOiE5jr8N12TpAw3LLK8fEmqRiVIxA?=
 =?us-ascii?Q?VCvXrhqfyAHeyFLL9kM7YbZLTVq/08iGpNUq385oDeypGuZrk76W3xjYcm1q?=
 =?us-ascii?Q?O9jLt5fw8PEgr4LD1LM73J7rCx6pJ9jG6dqVScmDBKVRx+zlJQo6pN86GJgq?=
 =?us-ascii?Q?OIr1CZ1Z7b3LVlu0qOHn2HzVudfmiOaHp2LGYnb9Oq0Sf608aAWtcABgc6Me?=
 =?us-ascii?Q?lrYquXpgxxu/JSrmEVRCreN8cwGgVfc+TCyUxWKi1rKCVZgrqytJ5RUuzW8+?=
 =?us-ascii?Q?skZaoKNyoK4iSN50xQw/k0iKEzBvf1qPljku16vIPbp//gCY0/fK6cZKyG+3?=
 =?us-ascii?Q?KxPIh6W5AsZleu+ha2dL1KAV9rhB7XvQ08uQnsfj71EUeNt0OU1kHzeSU52v?=
 =?us-ascii?Q?2rVd/6rcwqaUvp9ksOBJIWbBXV2iv6KjZU1Ywg50UiPaUhpm/ftpphubWlnj?=
 =?us-ascii?Q?ROmbGfY8vEOHIKczt8ADeAZY4xupHtJUYlgcNhGYX1aWVNhRCJudrB/mtgRV?=
 =?us-ascii?Q?cUk4gC1JnvAYVDLiCgqncf/83WCyLe0mfq3OoR/kKHr5+jNCo4RcXSdPCqnF?=
 =?us-ascii?Q?SgMNdub4xM36Du37qW1hGsf49DKKSphGGbIDkzY6SdI2fc3Lx3xavn89utd5?=
 =?us-ascii?Q?nzTSuzAl2cC0sy4gUTi/sxsZtyyO14qFnFFMGA/xei87zWC3xAYl21NMEvpd?=
 =?us-ascii?Q?0+FZ7galfwb7fp+E4LCuoLV/CDC+xhbn6X+62oCjQHi9gzqivVuYKMePTSqF?=
 =?us-ascii?Q?2OQ9s7IFr9jGvDXEOe0+9gBaO9uta9bLC7vNF0hnUX0gwj+gmkF/XlJR5+Zq?=
 =?us-ascii?Q?XwZl3zmOd1R0itZKQszb5U59UCP59qrx11vS9cvWxFD2/uR+BVcRzkarh2rV?=
 =?us-ascii?Q?lQjyUNpgIj+fl0atDIRpZOOGJWHiwSSEpRxi/T39OhF7jJIdWEY7rrKTmcec?=
 =?us-ascii?Q?iaIeNJoSq3Ghw/UcmKBL3pY5BVLi1Xzhu/zbDRc1CIE6FyRMU7BafA90QJXh?=
 =?us-ascii?Q?MeyUctDkw22ATsqYE+iN4gaaZ2LrtFSGzf7xNPzyTj6n9Bjyqq4Dh5Ygv7OR?=
 =?us-ascii?Q?G5+r4l+kbVFwHl6ogyYkxTwI5xGSvr9mcGd77a6j52fX/1npw5L/Wop04EgS?=
 =?us-ascii?Q?bl1ekchzwQb2ysB31OPzc3wmizL/mkmULZhQ1OBfZ5Az5+MGCny336M+2m+r?=
 =?us-ascii?Q?qrRlLUe7jwCCYs3Asq3AVZUB8FT8HYMmgb/xZhv60iQEmuM6xr9qgBuadsF6?=
 =?us-ascii?Q?az2RysnDgdDEfRNhj5Q5RnjspBchK+ZLze10QKv1NYn0Jttx4Z49UM5CHCz5?=
 =?us-ascii?Q?aBNc6aHpL9XItEyxEe7w4UZp2azUUprYRTWvLhB7MQRm9mCrwUrTGNkgG5D3?=
 =?us-ascii?Q?bLxRcJ1eKDcQ52+Hgla8N+zp/Heur2GefKygehLKOEpgTQixce40iAox01aB?=
 =?us-ascii?Q?1+cPezqstUMQsmsBxWeEEhs3SIrh4dTHIDr3EP3y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72efeee4-5083-4db3-ecf2-08dba175fe8c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:07:16.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mItYPaJtTjIjEfkNqSy6wjG1BpnNoi/F5AnwPhEWy4DAT7QVUhi2auLxaM76EWZDTZIAqiW7W4Eumif262CUFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

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

