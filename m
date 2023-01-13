Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DA659
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 07:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPlMWnVW9SfHAVP4ZHB0m0rSBb+BExD+Yr82s8e6QcYvCi3sV2bOkk/b7HTzvm8+stxpbCM7uWe1q+uTPcLVIq8h7yZpNcBsyX50dOE/CsjrAtGz2jOMJBnGOdZ7zmknbmQ9iKNRMmFSRNLvGJgNr/lK51+w4PDuJObx1S5ub45X7DtLhQMzI13sF79WmR6nJ7o8FHG514EKx5EOY6gRcN6xp8e52QCPzVz6WNvRACZGiNKtJR5FgULQIUPTAuy+M/8D0WJj8BPNN+uO2Alr9CDBoZuVj6GPCTvppxyBQTKrAVHv3413d77HdjnstKujDWSbAM2nYwLNFV4nlUvX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGWlqAqSdlFz+znkitnmMZANyDDmEpTc9VNKnioJaoU=;
 b=fD9pfPkXMNFZUtEnBvOxTUxubpKnqFJdqTHiQlGjpvbIt8kQ8CNOVmS0s2ukhkNVOg5MvUc2pvWjK8f1ySDRMfTXStEPYl9Dae6MrPko2OjO9mC4RuDWKDjyQG56SbPD4M0f5xeSE2mmu6bdjGW2k+FpY3NdMs26fvD+K7UxrgpadtV6M9315BQp07QFbfiNRDjLZWdpUjPosStXtVIMsovY6WFabtOGclUyuX6vQOz/8v9IG78dcVo5JvzQBWBGwlDe6u7AWoTS3itO6Kby8chHgf88iV9RBtK8N7eUHz4XtDckH4YDMtS+iU3n95XeO1/z+2fMm9IxjiZHbuIvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGWlqAqSdlFz+znkitnmMZANyDDmEpTc9VNKnioJaoU=;
 b=yVEPbSaoHOmw+pu1Eqcj2lhlgR/c4VDsisBmzSuY8QWohSbENMiCb0r4OGkOokw9ivw1ZCiPnYRUAbUFQbc5g06XnFfg9ILEJsbv+sQ3wKwdA2yFkWCYHhpj1GtP7KBXwu+8haSE5WmILdg6KrnFXk/zcRmT6rGEBasA0IEYkLeRkQErS6rFtvFNb5ci154xO77Bert3ASTuYW/sQd2+7siQUXqgWwzE5OtTrHl8nWFLTRfFoWx+c60YGFQ5t25QKHy6Zk+3/e9BrTO7Sy+xmRbi+T8go/HuUaaBPr6y8voxW6BrtFwSy4aW1t4gAnFEwyno+4oNDL1QgCclGaI/Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 07:09:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 07:09:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: update userspace pm subflows info
Date: Fri, 13 Jan 2023 15:09:50 +0800
Message-Id: <f54257b96e166712f86d8476cff83a0db5fba902.1673593769.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:403:a::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 37253fd9-33a2-470d-4779-08daf5352473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ZygJ90HIAQdXwQmOOp+CNJ+d1bqAN96zG76f2kzhfo03fCDjx5MK+FuGn9M2HhVFoDIJXQQBLPLmuG0zNYpiusB+ietU6NBBC4qVVy8hR5rFPw87twyA0hY/hBNCHa9Ww3uhqesKYGCjsXkbAOAH8p3X6A5FKRn2iRREzpLzeYhNjbQ2egjEWu5gZPJhBoox7PGIRk5n7AAD8pJIlwRx5H7KqDkA1DcZbfYYweujdXD3/9GD4uie9ivtt8j7nsVJTDRoUO7h89Dz/0cyn2BIpB9KZtjXgtGqI5MDyGeRuUo0XNgbLlAe3eHlI9WsiJ+sq4HYLwfn1qOWlYw9GegqFAkXlnthtRuaXiRusctqi8A9/XjqzE+lNEtYD6mmCoFSrmbTZX17ySO62KEbsrU46+xwc2xI7TzW/eUXuB+jv1tTAI9xNsovhjI4A+I3ICP0XvaEJKnJt1jYYEtMPq+wqm+VWEt65KeCg+ieLyueWo3660FqR/Dyxng9Zpp+VakV6eBtvXV5mKyR+4tVqKQRgtQL+Fhs7jdD+ycCG7aM3z6dnmSXlZd60P5ImiSuzzMvASHgDzWmjpXe8+23uXCsABqe4//sMpwhnfa442vMnOQxBIbftdfUuPZxIjedwLfxCWDPIa9gP4x6AWahdUzGDBh2wwIIPMVu8KH9T2t6Cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(478600001)(966005)(6486002)(41300700001)(6512007)(38100700002)(316002)(2616005)(86362001)(66556008)(66946007)(26005)(186003)(66476007)(36756003)(5660300002)(107886003)(6506007)(2906002)(6666004)(4744005)(83380400001)(44832011)(8676002)(6916009)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YYv8igCJwRKCrDpipkUTvuOHIJkTdznNVC/xSoFKxTxPxlYbifR0ciJKrSem?=
 =?us-ascii?Q?GltlDGmlmEq40H/Y9cnuVP5oT5+HQJoofqiCuLiMtsyUVRKlFl7d+QW78WSX?=
 =?us-ascii?Q?iXNQhPAC1vLBpJ7ZkaBvO71NhXRAAouYh3nek/SDn4tpULNcmuA5Yyrnv9hU?=
 =?us-ascii?Q?LWU99cxzUNrF/uhKCTgZ50QLLEc8EIVllorOwA3qp15IeY4+pR4mbYyfUIMm?=
 =?us-ascii?Q?78AIXZ47yuIM5q4PoQ1WJfMSOGFaslKrPS9iz3z5VT1eo1VcyYKdBOoFx5+5?=
 =?us-ascii?Q?TbLzeysT3uP4Vc1Ef8mGxpaxAcWwEMFFk67uTZTTPMkiqfz9KJEvAwznuW8m?=
 =?us-ascii?Q?mEIARftPtTDobMLWWTVvLc5b5wReXJ+QZ+aWAprtFnfWR8wpZgyrxS0E5p0W?=
 =?us-ascii?Q?ipY7m7O3cS6jAB8kqBKhadndYZXf58rnupxrAecsZFsdjqVOa4+uUrQn4+Kt?=
 =?us-ascii?Q?054ZFyew1c6wALJoi1xtJKrpoPWfrb0GVSfhgWoRSiYa4Z+1k9WUa94xq/dm?=
 =?us-ascii?Q?TGHE7wFOR9PfXn+X3cxSHvlax8yXkxK5VZvmFvfo71FxOWK1AMFH7WXyFaY6?=
 =?us-ascii?Q?eayi9Mhun8Lquh08nTdyOEHbxbJfWl1ujMpSNhbxC8ki8WwukseCVScNeFei?=
 =?us-ascii?Q?Pz88mDPh924HnwAQlXIRer6mgsQ+kgxk/5XUjGj/UmQm3lIze7liSlPTCkF5?=
 =?us-ascii?Q?oO5gMEey2TlSVdzPB2/B4GJG+uhXokECo9RtZPtMwfrDkJLiP2JV9GlX7Hbn?=
 =?us-ascii?Q?1eV8VynX+wESGQ9K+k45Nt4DEr0yY7AhnlDq+9u2f5PuRpY/CdGPaBOaSRHi?=
 =?us-ascii?Q?Vl2dK4LQc3fp9w+FtpNyfykt/zMWJXjZsozkJ5/JTTJW+1UehiMJOc/KQY84?=
 =?us-ascii?Q?11K3+CfbPLNkq5HGkowNBCil9niIMFOGoq86lbh0iLYzqNFTJ7ARjqDaiggR?=
 =?us-ascii?Q?V+sYJCrKSqSRo3KDPCuwOt6JIM6p0l0xLfxjAOWSIM6L7OkpPb4Dly8w+Rm0?=
 =?us-ascii?Q?4NkApGicN+iaLIJK6W/ZZQYiF0ltn8tleFxfvN9+GFWmA4mGkaw2TbpcAJW0?=
 =?us-ascii?Q?RZmu4/ssc8lf5r/kxGdFJP4JtFqM13JLv/Fahob05JraPg1WK69PnP/4idWy?=
 =?us-ascii?Q?AxXhlQCDkPS70xWNnXAQTdN5zxlGXM0zuopbDYvl2VzM9HYhUV9rWLqGODWP?=
 =?us-ascii?Q?/FJGyb/XwMzaZMUD7jfNgKmVYBBl/Ve7S/5Lkz5x9RJOsutLTOzRm1hchjRE?=
 =?us-ascii?Q?ukKchq/zR3KUoQYYYiPr+exJDjQkNpI3kNx4F1a8ffe6D5+wktCDU3eP3olo?=
 =?us-ascii?Q?FCigC1dAWmRbcx/qRKBMJm16jC+9p8VlNnVvQkMsBseXjkMidifPgvfMr8H1?=
 =?us-ascii?Q?Tz6ZydGyD3zAJbzMgqr7K/EPXCjMgKMZkzJ5pEMkEK+7r5/TfEHNn4/nG4BB?=
 =?us-ascii?Q?Vlikyjf90E+Ml144fOa+6PgLGVh9vjCv0iBqaBwvN/J4bRhVwPHEln/y2Ix0?=
 =?us-ascii?Q?l0opFKPHFe9473i6PsEpyTvYAftJuaXHxPNBI+3KoEMVbMPkqbFZjPXzVX3v?=
 =?us-ascii?Q?9ri5H0bNnWa8PN/nvYqrOmOp03H/8Ktea5S1148H6vLaRD3PF1KIYk11id4b?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37253fd9-33a2-470d-4779-08daf5352473
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 07:09:42.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSusvrtKZaZG7ebL9o7iKfwc2S+MZXr7Ka2R/k4+7kj6KzRy9Nk56fgYDlXIwqR9w/kwE1E6UlnLjPi+XfEUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

Increase pm subflows counter when userspace pm creates a new subflow,
and decrease the counter when it closes a subflow.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..36e10f6e434a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -304,6 +304,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	msk->pm.subflows++;
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
@@ -424,6 +425,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+		msk->pm.subflows--;
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

