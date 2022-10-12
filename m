Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20017CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLX/xNwB/xPG9ryVoSMupcmavk3KTF55h/Ikq0LKgkpqklXTDKc6Ys4qpPYmeOyCCzmDiFsQgGUIJiGMwNMMSHpfN6H6EjfeOwLK0nk6eVZABqgRq7oslDeMekq+5GU1+LdSoeAikjmPGeBfvNJy2aFtDe+m8/wb24NrfXOzYD/Js5Fcx/nwyNYTlwrey9lw8KIaafo0ZdS+X042yulEiMkQknNePpAnByjC62NPcS4fLttYJJ72bxmg4RYBjKTHfIy+tCmI0t4yRvVn6kr7NLg+BO9ETl4hrnGnI62EXRo4td2tv1GgJabj97xyHD9kDXRqlDiP860C4zZKspbBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7SG65Ugoq7xWqzXfFPyxFOhGYbg+VUMD9POr5c93k8=;
 b=K8nj5A63BhDPYfxlv2GVm/xhE4UzP01NklEY63n8B+CapySbbqlfcV7Cwg0rX8Z54X8AjJO3jKlrKy+KqXBKgN05bjT7+hX6AuMDjma8K5a5JOkkk8WKAQe5DjyXltP7EYnuYlj8KFLmRvu3kw8UZx18HvFNAYozLvuQFizN+DNA/ZfQKYin6obfYP28LVH6mah23Db7KhaDlAwFEv5eHnZWPGPieRVZ8536FV7u2Z9Lc22Ta4jc448fBjF7YBeOCSK7J4j4T4rTXNYgmvgIvDMyA5FuBwF4LPzczKDlLgDbRzcAe3btF47MlmLnz3k2/rd+pZbSqwW6G0M/96dksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7SG65Ugoq7xWqzXfFPyxFOhGYbg+VUMD9POr5c93k8=;
 b=zdYamHuv50zu/9PXK5fvZRIvTY+hpUSAWMbHkZamIN0lGzeIobYBQtldWx2CoKEmdhVgvoJNbIF0B7dasr7Wz8AYZGlYpj4avE1FQtIixmQMJV4s2RXhAazzYPner+j/83sSwbBRHC1w5eLSHktyiqVbCkv2OpU3rSNC4nKX3t8T1u1P66zjN4ceFs4WR0PGYNrASXksWjNFq1WywnPU6gcU0SYby5F/8aUSdq7bOvkH95d6/k2huViiSjoJrEGvPUA9dSDglWnZ4IB1+7IMxa0pQ1w1epCECiDPie3G710Ns7BiPFdSpJgcL6V/LLu92I3rOPP6hL6p5bKZKTlTtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/16] Squash to "mptcp: multi subflows push_pending"
Date: Wed, 12 Oct 2022 12:50:25 +0800
Message-Id: <24c4007e75f86c1a69d275733a4a1057bc62615e.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 58eab1ab-fad4-4aa7-d5dc-08daac0d6223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Od2aHEpjw9HsA0ChNkcHzqchSwnDTtNHUwGwbsJc0+yEiKu78QJAtJZPG7RcvpaTiG2RKDHBl5vS9xZ4mHeb/4E0KasORIR6kBGtoHB+IXK6/AOacJM02jdWlg8ovkDKGT+WBc4ougc3IoORnS+VCt9l6yIniDe4vr7R8uYk9ThSK1CvJLIYckiAB/57xE19XRwz5JvcAcgirKkeQ3d6qCcH+et2+crQZfdTRGzTCuyaZFLQNyAMN13wZUDbJyfKpxTYhmBTZI03LgH8GVXq+ZKZ2tJG4jwCXQ1MnsXAuWpFXy9wERvG3HsYXgdJiZv8ahUPgWecvw8JSEeripG7wZDBHPs9/J4dg5vCHDtu1G51sUc/kD7+MuZKMjLoe6GHhdiwfLOutqFRXWiTqoyJrAqa8QbDYInqMgpyuKAWril3mnSaL0r/PfrhOy9lM9MUpjtCiopVc2LuwMHmgDSnTnNy3E0kdJ1Zi9+tpms+MnZrLHNvBvaWI4Z7I4oqT90qUaxSPCRLWs7zwLI4ray4NgoHh3QINMsmBmp2LSrLeOU5Ntrkp36jEHA0vz2mPhBrHisXp3fF02FDhNRZNZDsDBkm64Vc/d/qrRAPPAzDv7RwayUTWJWu3iT8+xMmGLOihIIrVI2TXNlRnHY5xYutA/stbQjeZ7I6E05uQC2xFxWzgpVu0huujjkDp8S3LGAUFcdoFkHr7XFfIWIuP+IZ4s8lJ8JIcktDZKoNBTPirgs6R+rtnLjQUjcI4P4xcReg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(4744005)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7H7LQc15y7xYaq5LwGuROtqzdt/hbEpnYgLa/FxJro4aiT3YPFJJEYhB+Jtx?=
 =?us-ascii?Q?sQzkFl2RwWldtm6qIJ88ZBLH5QP8C3B8Y/Tf2HOT9/oKJbiDXn/DqNVvBNa2?=
 =?us-ascii?Q?icp1wLR35EWa04bAle/Dq4dWQatKmaubfQ0jaF5vzhAPiWm2HCeDyef51kM5?=
 =?us-ascii?Q?ddq5ybtkxhz5E7vyYh8S2Ydlx9pgBPfSybb+SvCsTnUAD+XvpPqH2sAv53KM?=
 =?us-ascii?Q?LrCpeT2KroP9STujjdetPx3iRLM3o1gbjnAvMT24Gd802Z6idpASw37lFhcA?=
 =?us-ascii?Q?0VNO8wPNtQzxI9WArirL0M/Fx/yzbS+SfnoU08drLyAj+gK+YQjhVNKeYLxS?=
 =?us-ascii?Q?vrGwRzcDxwGQ1DD72ebGv6YoHOsNiq+QMezUnDom3HBJ0mgg1NW4jMBZHxqd?=
 =?us-ascii?Q?WfqOIRZObymau8mhkhekmCekWqrf5mgTy8c++jYdxCrKUrP27XZGEGyKCgIS?=
 =?us-ascii?Q?cXfpYiSMpDRPzvZoV3MhBkJWZrbHA8O6vWAEL5eSvDGc9ZbpFxp+bF+KT6YB?=
 =?us-ascii?Q?jmik4rXdtQ2WoLZ8RJvR290t/qx0eWEJg6341BGW0/U7kr/lMXEW6lYpHz8c?=
 =?us-ascii?Q?rICE65/iQodXEFLCno3VEAlYPy1We16rsuMUbP6sswmyNyQLAqSoQNeZ6SVk?=
 =?us-ascii?Q?ePBjGkAIBaUKBM1uzLJreYVdeMAawhAsh9oWz2XoaUI5TiQbR3n3pRl3+Pce?=
 =?us-ascii?Q?jVWyTxB7pgg1MBfQNzuTqbpLBh2YmIAC92KAGRu85SQhswl8ym/cSXTUQsGA?=
 =?us-ascii?Q?Ut6nJTlfDkA++1kZIkt0focjPU/9giRYzjUDK2ctnqnOX6S4680z9x+8WJ+a?=
 =?us-ascii?Q?Ou3w4GlU7YOUCXFDNFAbpKcJl0W6Hhh3v13PDniGsSXvh0sGjwp55/QqLpFC?=
 =?us-ascii?Q?6anJ/zzpdrOU2DFuh2BDWg0gMG7/OGQPjaaG9mhHcalYfrRQbfsc8eNTGmN8?=
 =?us-ascii?Q?PLtlqMEiutAeCeO9a2vLrH6ImJuQw8Cq5jJh2HM8MFUtgYi/8al26QU8SUNn?=
 =?us-ascii?Q?ISeZBcYJ0CoCJoDGBdu/KsUfrxL8gbYGGPB/mhCvcNmquOf4L6q0Iq4nXa4K?=
 =?us-ascii?Q?NSGIQ5ZnfFdDgMzGppkiWvTX0eUSybwpuhVYMx7poT0S88BNW2wWijZcWcf9?=
 =?us-ascii?Q?0eLKmBG4X1yWYMMDWt/NLv6ZMQu4S/2ApLPdbByaC9NGrl3jyLfOu/bjgDfO?=
 =?us-ascii?Q?NfArX9XxQBKzwayw3ofjTOlE6N0M8ZQ2JNSY2tP7bMmWtknuPkGgBnGAZYLx?=
 =?us-ascii?Q?acbyQ/r5nusUlis7Jnbku82d3D5Z2Q8jhBekQv6/obabU6azJfy9KgFeffVu?=
 =?us-ascii?Q?NzpIU9so2WhfoawMHAtdeUCKfUxpqqFlgEDmdaNAZ0dEKMcTqktHu0u3j5mx?=
 =?us-ascii?Q?P4mijAEylIqvFMkdf1IQHnkDAf0PQYl0HxF2l5zAfbGrbf6Yzel0AnKTVTOy?=
 =?us-ascii?Q?W5tsPBrFGlFbC7hnj421i5neuKhW08q/F2mFjy44TcoZeO2MGCqWulcVTxYa?=
 =?us-ascii?Q?0NXEV98cLXnu44x5hJ60U+VtqJHjyU3iijBLrV7dsbt4mhrepmQPwAxZTRXx?=
 =?us-ascii?Q?o3DX19qsccH2NOJHdmmOKGdZzfOWCOe36Vj/qMvoQIv+Ke9YP8OYm5DAZw+L?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eab1ab-fad4-4aa7-d5dc-08daac0d6223
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:10.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkP7JDGYvHSq8r5fTR5cf80tf6pcdpaT6TszJV3J5hEHcpNKeAs47P+YUeCUX5JuHVlOn1SR9JhyixeUKmazUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Pass data to mptcp_sched_get_send.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2cd8e18d917c..694c07855be9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1566,7 +1566,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	int ret = 0;
 
 again:
-	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk, &data)) {
 		struct mptcp_subflow_context *subflow;
 		struct mptcp_sendmsg_info info = {
 			.flags = flags,
-- 
2.35.3

