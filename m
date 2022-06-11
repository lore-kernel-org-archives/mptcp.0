Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BFA21
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 14:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az3f7E9mhAJycff1B/RBhp1GmslAfbgwuAEaIg5Wm+MBL+nwGAngJZVUuwgW0hixywD8E5MfpG9yqWZ+XrwC3E7l9awLlkWqoVKE3TxukihS5QNuuupsxSGMUtsa9g2HI7+I8/oK3PkUqjgfi3jYj9dT0V2Ehg8/iVqBuc9n0Cg211+++Qz7dfjPsFyFKBKqWSn0ea6CH/l8TttvuFcVL7Fq4u3xSHwqiew2ZUwHEl+vRqhMaYhxdeGVqNwsVvfGaP2A/ZhY8q9PFOZQEddwtG4glFW9BxUVKNWxccjF8mvD6kmPMkOnIoC5tbLClIg51uEIvn0UNTcUGktF8Ypvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdUQ61vXLUrRenZnksFO3mIPsYnrpxYO/+WT4Li6shk=;
 b=n7ELcElB2lA555CbAqfJihWjB/6OH9f/m/W8wsliM1SbwrnOShwOhSZ/DwGxo+LgA1odh9KRnhlhIKsAzyTy5hD16MyMEFYA+cJ6e/L802IddIY1h6g+/dPlh+9lM5Yseyn0DiDwXCvKDwbhv8fsdtWRtZ5nhwUkVKtGCTHQMEJeM+Odn3achF3hRsgi2YT0/5v7XtsxjYzCTzn8/5x6nKB9gbueskXqA47M06rXNBsslUiRqShDe7osB8fYU2CH9QhzPXBA+DuHX46Sa5iXzJjkqyf+e6iHCfafZw4b9KkZY3QSm4KPwHeV8do+5QyebFr/38Ex50hVRolrYLwL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdUQ61vXLUrRenZnksFO3mIPsYnrpxYO/+WT4Li6shk=;
 b=lQMNJZPiwa8x2itWLzFlDUimFp7DW2dASCxhubi1+6shCkKZtXucHhekd8ekbb6c7M8OLjVSPocfpZOaeU4DlErsfKKGL73ujI//h50EO/RD/witgQ5oKhSgtooNCpWUJFwNHPbtKjbkzjh6/6P3YBa0n4hlBe3PZTmVTpVbCsBHQPKJeY7D+E7HCtUA5z8gPDDjlzM05NrR73HSjkVkbdogbvrnhWicx6dtiW6zu7eAhKZQL/zCHzd+RPl7jD9VkqCjuchwvbMNhABEbF9b9H2LK/lGESOAmO9f4MYff4nH70rru3/6jCBxf/lcO1Ekf0ZAN0qqhjF/7xuKCdZKWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4944.eurprd04.prod.outlook.com (2603:10a6:803:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Sat, 11 Jun
 2022 14:55:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 14:55:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 5/5] selftests: mptcp: update pm_nl_ctl usage header
Date: Sat, 11 Jun 2022 22:54:39 +0800
Message-Id: <b3ad5c0e791325a441ba76f24ec13a7a8000a28a.1654958401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654958401.git.geliang.tang@suse.com>
References: <cover.1654958401.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e92956-20e9-4ac6-f9bb-08da4bba6be7
X-MS-TrafficTypeDiagnostic: VI1PR04MB4944:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4944390CEAC3C5F08ECE051CF8A99@VI1PR04MB4944.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Z2I21jMc1A79J2mZiWSsBjy+EL972UjW3q4mCd+SSElbEvigxnUSYpNF8ZlhLFdhTmVjt3ZQZD7322w00LlR7emWj5CuF4aw0Cszjxj4fyvlOzYSsIJ3LnBoCtQHPFu2mescQQqXyPYZkq01EldTRj6tqz6xei04UEMlCDZklc+4Y24YS/i32LageLqTOpKFsSq+KZMvP5D0Xw1M2bhFaddlYmcAeySq3o3g+yCWy0i+qIMQd81KRipsvMHLZhqrpodcwzh+P0IcwSsrhG8ut/BQ8aNGL6vZrOit9I5vS30fxRiqrfY3OA+On3tlyFx9U8PeaTQntZMkDpANH9sNWu5UACXwExaUe9fQJoiMCKEcwaGuzU2jZbAef7kLCXjitoDLh4crKzN9INZAlWDJ/qYv6ivK1Xio6ywD2phZpYGR8X4cgewgQevU9pQ8kBcVLROsLrXueLSChJu3AiJT3FM/3UCW3AbvVOtHtRFveYlRxk0keHk99uiGFmNv0LEsWKbJxQT5jTh/L/++wqPcJOCnDY/gfiIHa/I4wS9+27jf6iG/iclz01Rs1dkUA/rSFkEhcQMFT7uNPuRNTroJfNPx1YdLHirUqMp760NLOtAHZUsE/BY9zQTGWb5hr+yKNisuTYvhIIRx517gnWEeaNPN8cKcUQE4n3XFkYVtWv4QWCZPMJvwVN38iIRiRvhZSF0qTi827xOp8DCKCKSuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(54906003)(38100700002)(316002)(36756003)(2616005)(508600001)(6506007)(66476007)(66556008)(66946007)(8676002)(83380400001)(86362001)(186003)(6666004)(44832011)(5660300002)(2906002)(26005)(6512007)(6486002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKdxIWJlX2Tj6baVX4IDFuHqbeqwaDtZpAvli7Czu8TU7/5yj1YIGE1U/5r9?=
 =?us-ascii?Q?Eztr9s3u4muF3OcS8Nr/EWX7PPp+DPeu4TlhHesYL3jJD4ynAfLw7v9JNMiQ?=
 =?us-ascii?Q?cdPVJDRBVwu8eOePXgUmMrmBF1F3oulczrUwZdgaRbCl3I6VpRLNzoR879Rs?=
 =?us-ascii?Q?RXTBcP2XCVrJFOXG6AqOPLvrIrw0yPMdsK85WA65FAoa3VIheaZCFcuFwjSf?=
 =?us-ascii?Q?9HRhTKo9uQDFCC4MgUo4dW86QiUgA1ICtj62LqARImR868BWl34b/PX+AkQd?=
 =?us-ascii?Q?GrJHLznxtybcfECrXKpA6gJf5ebClPphFPUblNioFC/WEJvUcazd3p3G5CLj?=
 =?us-ascii?Q?egr2tsBpjbfuw2Up5cYCCBFpuai4xHZ+JtNu0LKO/zUZNJbXHyqN9IInCNFe?=
 =?us-ascii?Q?7Q95rAmcZNudjkuWCQ5In0Z5Wh5JhLhbYmqvc01QudpO2PRxdr0ZHjQiLIio?=
 =?us-ascii?Q?A67kzwF/mQImmM+yRRkdMsQrc9wanI1WGisQ96uf/1OiEZMpZUmn7OO+ILhc?=
 =?us-ascii?Q?yxZENy2RgYsLwx63IL5NXKv3Viqj/E/KyUGuQjFxxSEi/3NJgB5H35camAJt?=
 =?us-ascii?Q?57z/eTuw3+AvV9UuAmHx7ffaLbO6SMnqq2OLzv2wjfsdEZz2/i+ya6DN7ZHQ?=
 =?us-ascii?Q?fjFWY5iatYoH8t7vDmkFUu90tBdppSSQDPS+dyCbXzi7qq+JL5QW+VsTnoXN?=
 =?us-ascii?Q?tDZXnO3l22X9oXNqk+dmD4xvRdetvqSgnuvlLsu4XgTP3xIK1+ojLIxgur/B?=
 =?us-ascii?Q?OB6puHwMTCxCX0oirQAmLsk/LVicVpJ+0mDRn9pnfD6Htmd5lQ7w4vKLAdzB?=
 =?us-ascii?Q?UVJM53n4yNVNAJKaAtwWAzbg3gPdTktJydh5Drkqn/o3gIG0qLGHjDgzgz9X?=
 =?us-ascii?Q?FPzQOpcirYKwdopM8ODhj4vMoZTtBuzW9/dEIjQENA5F0oa8r/o5/EUPrmnU?=
 =?us-ascii?Q?9A1gyYW2dgCKn5b6UE2KKIz9fNkY3d3uzXHD+Obq66IqWMgEH+kVr97eL4fM?=
 =?us-ascii?Q?tGqQ8QM4sML5kttCHI4i6dPS8VFNclfMdMuJJiJjQ1XLWCDO/purHB20R6Gp?=
 =?us-ascii?Q?hgU7uSTjGh/P/6B442NtQkG9UI+zWSpRRG7agTzU8Ko02zOQQ6uUu/e/c/Xd?=
 =?us-ascii?Q?H+Aonls84Y2+hfOi+3Mz9NT8GmcbT0nICCFHcS/rMYjHDUgIN2kTFvHrckbO?=
 =?us-ascii?Q?7qcmsAKp9hyPkRXhDoDo6bNoxsTsxPYyEclFnGfbPhoGzgABSfrDKc+om6zt?=
 =?us-ascii?Q?Mk2d4eor0hdQjz5Dzgazr75E0uD2M13sJLOg6mj+mZSObjGmlEI035stCSJD?=
 =?us-ascii?Q?YNpuTEKjxnvSM9quD9tkwPgTg4bNJ/2xMkHbDI0QwBwVFNsJxRnfI7dcTzY7?=
 =?us-ascii?Q?v3yeIXdC7CPCwU6ci9LGzHeZN6JQwwW+Z9IkYwk/xXyP8MPUAsQh+YI4Af0t?=
 =?us-ascii?Q?IPr+6m98MBOlr2qWY6f5pAZwVisQBRxbxbmEQSyXy78rDtJZIfPHsQht4YxM?=
 =?us-ascii?Q?2nbnVDDPXln20xD02D1eE5ml6Z6Mqm8x7fAMOj0s7G2H4qFTRrKATc/i28i1?=
 =?us-ascii?Q?nkbMi/KMMktJdBxNS2LPoPF+flTKU5O+RPk1bH5gUoGmHNDjFWo/U8jvuADt?=
 =?us-ascii?Q?2BNhdR4WEdkg6aUY2p3+7FjoocPElJHM/LdZ/ci0bBTeq6xfJasYS3SZYUMl?=
 =?us-ascii?Q?WETmFidSAdU94u67FTt1bvg04ziWSC5U0mRcDgWcWxZhCq1x+MhE7NE1dJlm?=
 =?us-ascii?Q?3v2nwc14PbbOLAvYqC7l+GxUhwtQp8U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e92956-20e9-4ac6-f9bb-08da4bba6be7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 14:55:27.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74Ow+Ih7EKuXItaNDEIMZRah1k6JAg0fzZRdzv16DSjREvrABXVdagleiYJ/Gofsk66TXRjZnSpVcsUla7fq+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4944

The usage header of pm_nl_ctl command doesn't match with the context. So
this patch adds the missing userspace PM keywords 'ann', 'rem', 'csf',
'dsf', 'events' and 'listen' in it.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 6a2f4b981e1d..4dd87bb9ee91 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -31,7 +31,7 @@
 
 static void syntax(char *argv[])
 {
-	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
+	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
-- 
2.35.3

