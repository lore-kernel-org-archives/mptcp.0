Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA61DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi3HGcMKmEVXFW0qTwCAz0WBYALaqqBa7lwYfTVCOoXIxL/NqcgRtx4TdxOfSKLhzkUA+XZsdaiPs3AbMYYs8PI3AKzZVey4SaUxfbckebl4NwpxpLoI3dU3sKCxz9pJFy2/c7n4IMy4l/Ra9sDwreURfIlEbVnK8S/sXDcAJyvqxuPLvI27s9/0sBgZZsW6H/eMeHV8Ti16ApBD4DWz2IgbF3gvVIoh+98fNjFMAZQH3Rq5uVzpH0kVUGMRBQ86USRmXuuxVwhp/dig5dOfAXC11JrOYpB2Z/PHztaUzIX0MF6unwdfPUfGpNBljR39NE01cZUtGSjuGmG0mU4HxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=W/gExWmbRjBChgB5A9/igLDZnnQ5xxMyRiCQaU+1w6SeX1ble7BkXP/KN/JgbIlVt+uSt4COnaLC/0UeyfcuwhIZy/PJw9fA3iQxncu5dFlUG5BkdWFNbFv7ylHVOPBTONIN6uh6t+7YwusQtILF53yWTlL0pFZglrFNSFIz7qj4/r6RSFaOLj+Ihu279CdpRE2/v3wCsiDiah3+QZM0lsuc86iWLHXe0gDZSONZ0Yppm+i2CLYBta6kHNrOTChkLl6QgApe2KjNPIYJtXpEVDgHt+qWJbZze7ITbAv1l6xojf1me77lcsNyHrwl9pm1xL0E0+N185nXK44WpfG7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=JoBxb+TZE0SxZYYsAuqZRLLMIwozSWvY0v6F5yZImAFDaLga6UW5MFLbHtesRgJsmhdWnQqS3t/yOy/uSa3+al2ELpx8zNdkTqqo5/psQ0TfpOoWooscIr782n1Dwzi8KpNTJN7Se2uYcCQ6187HXKzVQv9ye0qCrDy4yB4x2a13+eNziEQzFXl9gaMD5ci1SQ9HS0bnBlHenBNaYqTQrho8PAx1uzMKhi6RuVAC6yztMJFmRA3NgL5NJH1t85Jt1GDd+fZBaI/UGVrEQSfFLwwYos6MCxPG7aw1w0X7rhtOlcJjVIunx1ES206JX2lUeRJrO0hb+LdoANHzp1sGzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:16:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:16:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 03/15] Squash to "mptcp: add scheduler wrappers"
Date: Tue, 30 May 2023 21:15:11 +0800
Message-Id: <0ef71dfd3f2a8b4ea06aef816fb2881cff68f1bd.1685452367.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452367.git.geliang.tang@suse.com>
References: <cover.1685452367.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0166.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a0f27f-a980-4128-d330-08db61100aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SIz8/WM9/BaMI6u4XVOKAn886YodVNQzIQ+vx4A5y36XOi0JG8IuZyYtYwi3qED081utTeH6RjLbZAkuWJK5uZ3m4Si0Oo0I8PbsRs4G7ftE7vag2CYcL0SSSUgQfdnNTyCcbUWhdgfhBHrpRLfWzs7zXI14owMtweoz2RXKOGD1MmIYFdpsScUh/zjNIQwyN8x+NfrjLtH2KfRnGoiS19Vmaz9m1GH8RE6rOUeRAQDkod35PnzOoCTqSg2p16/nJCL5V/7LIt+zoMptaVekUwQpN2pTvyFubUae0R0rd+BUg+loZrZBvXnMEr1UPGCOIq4hQwBfcw3UfigNA0OxksVyDxKnGPNAglS+NOMpLIb5uhJcO8K2rAopLG+q6puzMpWSF/t8HLaJkazjxm6EpqvpeDgc9tzbPBq9BZQF74va1YrUmdg0/Ii5R3zUqoU3JSepX0YltMFOyUniX3oz9xbM6ed3QUssgq6GJrdIjuU0pqPhJpDOrSF4L1GsT81V2Gm0HBpXFwRvpVPZXe5dzA/zrxFPVRLnQIF4qVtMWyeSWMvHNtgubbeQDddyk9MR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylRWTyR23FmB694xDKZPBw0bE2IzNGdRf7RR4M9dyGQaOfZ1Lfo4PSgKHzWW?=
 =?us-ascii?Q?HNr+QrtoT9BsXaVYa44JaBIa5i+xuP3vuFipzcRHp3gUSiucz9zl0GGgPZbB?=
 =?us-ascii?Q?ZCLI6cMBrxNujkvCKLVXsoHlS8BbePegbmVxxOnisa4mcPru5m+o2scukntV?=
 =?us-ascii?Q?gukV/uJUFjFKDBJle7y9v9FG+C1BGZcFERiL9SyYQc3SXxl2+d8XUKC7najQ?=
 =?us-ascii?Q?irqtwXbeK8c9zE8QkewzwoEd91Uh417KI+WXJrauRHKpVu9g8Nr2wf+ul91j?=
 =?us-ascii?Q?XieublQKxTTl3yTkEF2EPETp0C2Y8Rw//iAF7VlZy9PY4wArsSG/gTCmvgxZ?=
 =?us-ascii?Q?Kn5RNE/odY/1AKQtV0iqfnJGSjtyjXQA3R9Zw6xXp6h/IwxVpE4/WiCLHwlD?=
 =?us-ascii?Q?qGv0rDYjcE/Rf2TrPW5g2fOpP4UCt24DBfc2VQkWrOpsrc2Ku8FaNGJeIK4U?=
 =?us-ascii?Q?Et0Nzis5iMP7jnjvEgl12JhvdUUZHyjfL1DkCknl68nGpWXx0zQjLyuASHun?=
 =?us-ascii?Q?Cns1/W48AkFNZNbes/0uAy3EbZrkz4mDHDUFEGf7FI0uDH9eLw2+v++I5ghB?=
 =?us-ascii?Q?aACDMtkIPAKfr4co6Iok3yzy+yF018aCieDeA/vJsoSXtIbtSx7vVvWpy8Ss?=
 =?us-ascii?Q?nGJRTSJHCuKsoNCzySLYWZHuEZxOGa40eTq1B/6AwZQQ6EKR6bgGs9BjsLeX?=
 =?us-ascii?Q?xgWNMkdEwTbSl9/+JSFglzZovlxeTJKZfv+KAQBg9NT1+QPZkLGAGkaZ3+SF?=
 =?us-ascii?Q?qu9gakrz4HDTmQq7oezHpCbJeos60oEV8sQuBVvNVBXxYrUdd9weNsYkGUVC?=
 =?us-ascii?Q?tKqQqZ3d4g0jVYeeZH2og+aekx7uHDFdgMLhun3DyNZnCNmdAkzQwpuc8+4k?=
 =?us-ascii?Q?CtmPFbro1CAZYWrDmDxKwaitDMoNViu/EVEYedROSYNr4vb2hc5G9k33gE6v?=
 =?us-ascii?Q?6RyY5XYh67U9RgQBTIpgP72fMrjfLQhvSLkDtMB2XtYUFfNZ+HhrcWhhhBDG?=
 =?us-ascii?Q?kPqgSLbMtf3+RlyiToOlRmTMBtpBFkcnChBWUnfvOk1Z/qN7YSMPvsVLGOyZ?=
 =?us-ascii?Q?PjYSYATXJDBe+3sxusjoX8oSUe963i8nISfS6TgqkWyVuOejWKNRdAiFIqxG?=
 =?us-ascii?Q?8nlEdw6DdQvyIxzamivzbSd8TrIV+i5HbdezEZnbEWMEQeIfFkJHnpzXN61w?=
 =?us-ascii?Q?5FPDwzAAHYkT7vj8q7c9IlaOjtrRiP7IyhqchPZWevZnhCbeTJUlThl8ne1Q?=
 =?us-ascii?Q?eqmoZo7Cfy7spZPZlv7Y6NaVHOWyZnhkVNUi/otF/xB04ZCbsWn2qbFBh8Xr?=
 =?us-ascii?Q?b6U2DrhUDj2J65VImD7r8/k+Ko0VADbPhqzmIQ2N9b96MGkJI7bKDyUm3tKF?=
 =?us-ascii?Q?IJ3CbAjkiTxAmjIvB724L+ADYVDLErI2gsRK1FT0+RjQOqrY1stvGKM/b9Xz?=
 =?us-ascii?Q?VCPvhbZ6MC2KLCbPppWxNKHipyXVr9nC7GhkOoWoHsh7Xnxlv/ZEnZZYImzj?=
 =?us-ascii?Q?la/xjEJ7FVzHCOoEzTSInxRf+Hz9lRrSOP72HLfggwMS5HcZIeGO1P/4L9lu?=
 =?us-ascii?Q?vBfxZ1hOPP+l3X44YS545DEJaWUAgF3b+ie/975+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a0f27f-a980-4128-d330-08db61100aa3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:16:13.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ASes+Efw/n7ZEQ7bBGZ8NuVjO+ZGgF4PK0GoTir1poip2NHhE3sW4dqgpV66Ue6Pdro9COKeK0cTMPPR1FSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a053a9504dfd..5438a86e897a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,7 +127,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -157,15 +156,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = false;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -188,7 +186,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = true;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
-- 
2.35.3

