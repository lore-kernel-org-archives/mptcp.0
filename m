Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FA612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YJpbeMsr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVWzMR+NVYBOBY3phvQNPPUV52PiJ9h3Ar9c4rozsU7FiRgojoreFIXk8832Px7TRylBuGz/X/DwsKfnJeSZ2MtE5zWb+qZGY5Gf/A2SRdAdRB2pJDMseBGajVQO56uxha5nG5fsza4F1eNZ1kc6C9BT1vhLtkszFuemy+TR5zcQDcABAG2XunOA6vosj5Yz1xiU9/e4lLzf/SxWeZyESn/oRFNsdWAShySqVSWJlr8LrADwqiRpjLFevs3I9+weq6+vOFggRL9XPtmUmKonUdwIPsk3sBGVbBhCVtAOPYI4F6Ry5CHIQh2tbRnrI+LrN2NMk3zMzehWLJ8q1fXQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=au2jUbfocKOhBJ+bfoJ2YrF2V1nIlCKLjqi8hpuur2hnhJmFNIYZBmy2vMwF0oh5bVBg2UvXq6crQD0UmvOp3scM+2fvxgKz/cPyENFS0YCpxaqZ84TQ9ouP8NlGuWzxlblP5QYJb5XVxsrW3jkGnAJu+Nufjzyc6U/NAgzUt5lNi3bogohN4xUn5XZtLEbpKzuCPongQzHSolVaPgH3MoBb1jUjV1r8gDRIRB3REnhO34/SHVex+Xm5R+C2FX7GnBdAmi9pNGft+xP9PGkKhd1UOzVBz5DMoUtqWzsvat28+sXZkps2J8f4dmjjcCdRO8WuuxumeyzeDaYlwKJY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=YJpbeMsruIffkHTGNk130QheKN/tYNKtYUwFIoZE26HM4HokqKf+vug8kL3eKjpXhZAOpEpM+852GbPORqagh5xAcqs+dgwObeKKxEPxQe/LmMhCII96SqhxUS7dAK/+1aOVJ+gFLCowS/afQqDPnEY5EG0PLz9p8uACPa4AmJZmW5lapC2XtNqpImFn01fvwfVryJd51+Ant5jftfDytWBzuI405YDlHMco/RUzGUBIcZ0elyfq1PPeYmVZda6PsUx2z17VDVHTfVRTThq6MyL1C2oOQTwgU+32Zp7+/yhoXYacayZfnmjL+85LcSB/2+kOoHuU2sqQy/SjOTWZng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 08/21] selftests: mptcp: add userspace pm subflow flag
Date: Tue, 14 Nov 2023 14:35:05 +0800
Message-Id: <b0a8cc728f8dcac896750341835863d6e145199d.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 116ffb94-550b-459b-6ff6-08dbe4dc0843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EMx8EPWEYzQvezDdIQbGtBWBbcO1z6iVC5Mhhk7dfcmgYb1zF3RTC2oaYLde7cLzDcK0MMVXKDcvSz6LXC8FG7BnTeh1SO1US+7GNGt53FbqfEKfo+vumLFApgzu0urhMVv8/MYbLc4oejQ1ofGrPc1MR9Jl5cM7cjXOYNJRnqMtyrMDK3LngZggpZY1LBi62gzRwVxLas5xPMvtEqoZlR7lalQz3xusGQAusqFcX6K5KR4gEPbjmF3xBTbrRuQ0p6POrfBJM3W0LD3XbRNLPauM9AqAaiQHiCHfLb7SUaj1KqwvDzNdFGzMrqd00FRjVfRSQz0vG4MHfKZxqiE8dZJyIlVEeJVuWl679JQaXKS/ra7J260EIuJBP5ibrRb9St8Y63Qnt8MR2rWtHEIE7QWtbYgxCK7CV85wcHAvOz/Jf3ikAwsLvn+4kYn9NnFYX0wGdR5xnq1OOOFP356mhUxye+Xy84OTihHpewHOs0Y76nPAZ448jS6LgSoe5dGbs7aIZaqAIrszj0xE0lCz9VVzujwcCWZjinlwvn9FW/eoBu+SEurHNLKiOHCQflAx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjDGp1hi3GlZfjEGSA5XmdzGAYT7H1nzdq4SK5P7XOW6Ytp6W7McRk9pJwZR?=
 =?us-ascii?Q?q4Jx6tP5LgpVQIfRxKtQq9CgrXpDW43Re/sYvb7sss75r/b7FU0A3pldsGSU?=
 =?us-ascii?Q?0+ri68q26sdLx5SE+l6DsEjpMbmHhfzM3avtopLqOM8HkGuU0jtiqUzqKah6?=
 =?us-ascii?Q?hQKuAN7niq0JluboUzR3DVuD0ucO8kFJX+vwi/g+n78uRASZf8xaGGQyrsnS?=
 =?us-ascii?Q?tK7yLijCL6s+dbPKkltTig1b5PgSCla+1pUYfDI+f8eZN20zPPJzlfY9CaVt?=
 =?us-ascii?Q?s9iGkt6Am71l+q6hb+xhgw7MF62v163w1VPZC3C8yahDrHQhvA5jSe0mqR1K?=
 =?us-ascii?Q?gaMk8lbQDo07kSh7agUAl+3eTkv/Q3KN2YeUTRFEBha+5aWHC3/jjRtJfsjA?=
 =?us-ascii?Q?MO+nZ5jKQQSVmC+J5G+1ulOsCn4RGkcua1wSlJS/qpStwiDEz0hUmvb+OELn?=
 =?us-ascii?Q?OFaNtqzHpi9y4noN0HyioRO65wFYQsWIbAcELE9EH75uJaPooZLtNP+iyCLs?=
 =?us-ascii?Q?js8ZUdIh3j0HXvSxTh0QEmQdKzTVMUnCLmI51c/L1giRwpHq+/SKkCzrhdRJ?=
 =?us-ascii?Q?m2mMUOU/NFsCYxd19Vk9BQ4pysaZpsVBI6DRwqyJwuq1OoFH7bPtRjVqD/Jz?=
 =?us-ascii?Q?FvWbIqZl1ZWsVobC/rXiv1PNftPnW6SmGRKjoZtDXw4Ya0utKSX2iUQZj7aD?=
 =?us-ascii?Q?ZGPmtf6W4gCmsMsTNNo1nf6gRzlXJFXhiQV6zPML+ddU40i0qEjES7Y6S9hY?=
 =?us-ascii?Q?R0fyvtCh6vJWVry2wqaLgh+d1mUlMakWpwG7l1Iq0EJY0aox88C7IVULbl84?=
 =?us-ascii?Q?h9AP1HyvLKP8Scn8Wg4q/XUsdicAed7jY127AqNuwDrxGtZx8n97l5OoH50Q?=
 =?us-ascii?Q?U/U8r0HDSdRSKLicteAJ2NoqKXK657p92RmWCJjWR+BwuLLR9wZS0/mrrFx5?=
 =?us-ascii?Q?FGvURrHkVfU0f4NQRm08Nv9TwWg41b30eHKQkPmsOZkUplGbIPPooIkjKXP/?=
 =?us-ascii?Q?PTrTq/nZRB3jqG6sUGA2wgf36EfRUAsg2YV1MhteUO6IN4KC0/b+C9lr73x7?=
 =?us-ascii?Q?1PbwuCkL7XNpsSsbAs/pcIPtfF/Bqc6bXVEj/z+UELuDwxHCLjnXCs8ereQ9?=
 =?us-ascii?Q?hA1WFjhpMfyWHzO+tLRA6NVoo8n3Pk5FRADw6mMLuH/sqqJ2HGlrOIQvfVSL?=
 =?us-ascii?Q?sbeFR6aipHMbtgwu3JGGxXMkNvywKREHEVuGHb247m8/lFlhcrrwvlk9SgeT?=
 =?us-ascii?Q?BALXe5DldSgMWxrgx2LTOg9XO8UcB6O4/N9i6cng3LFXlK1XquWo/1emFQbI?=
 =?us-ascii?Q?PTV6Ux8Ht7EZyG7n4faBH6SwdU178ELES1vewpqKACHfWAXcI9DcT8GBc0Zo?=
 =?us-ascii?Q?l2nIrLP530urqMY5LCl7Z+4+7ZgnxQfmm3ha0D+zF7uzl3FTa7hTFqnigqor?=
 =?us-ascii?Q?OGFX2bhO2dabu8DO7hWVcHyEbJtMpwo3i+ot7AU/w8vy/Rj7BWQHH7fuxz6z?=
 =?us-ascii?Q?mKDLwLaGwJVvm9Ruhf2L4NuAz0Vx2vHKyb01DwI09/4ItPWCMS2kAAbu643W?=
 =?us-ascii?Q?t6nYLfwAZEARvKJ37Ox6K1T1ckC//saX8K8XgsnO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116ffb94-550b-459b-6ff6-08dbe4dc0843
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:28.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEVPLe+UkGbJM9V3NohiPkUbRYDnU0WkJdP0jv3b8JQwD+kZEtDHnXhSvkLz7fwMor2cCczwuQkXWGUhxQSCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.35.3

