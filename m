Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B3110C
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 05:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX0r9/ABDNFcFnmHuNhWSb+4FIDfos5fM6UIBNp4w/a7FzAWIA4i16KSNMIncZAcGWosYV8n26Wr0Bdryne3lcDpDqUjd7HcldDu+/NSjfCHnrCVi0iHeDsxw1roOwPf1Y+mM7gt51QfGDsu22WpAvL4Ockagmuho1WFvJE7Naf4KfO+uqIjFHIVEotfVbzzHvikTCZexJKIm3fA1G8r/JKNLGhKXgF11n3yiQ1z2AHtREtJZN/ZLQKRTOdRWi9JAlcsfJ97VdQavhsDseuUfWA76wwTvD+aADCSM4HZlckj8m+lTg34D8egypiyIts4QnSGI3gVp71m0GiwK30fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeUyYmF2zArZRqocb1n35kdxnisqA/a/0sIoNi8Enw0=;
 b=Nx4CNpphsT0tOsd2SV3VLUA+T3F/1m7/ROafCfQONVWNUDhAY1qMK7vJ9MIStqQAvxZoFQ0pDR0muNX3FGjHPm2KsvJR2ILAbEDDWQAdkpN5Qa0Sm87ebSkUIqGwHUy5gsJP4nLLcHQJRx5HAcRKIBWVBVaSCkwzRZ3KeVFCk2riS5SGbbWtKEZuDCJSYRI2l0o++kupt6uROp/BMArsX90lt5y9BFHuHIfINeB9g5JAJUFP7Hu+UUUzVcE4GTI3I6RG0ad1sPBYmxU1gzrpTZf+MH9mNZ1iSttG6y1IiwiCehtI9sgeGojaXtkKNNg6UiMj1+MdDsmzJZiU+jYGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeUyYmF2zArZRqocb1n35kdxnisqA/a/0sIoNi8Enw0=;
 b=zPDPGeSuSyKG/yXr7rtZA88Msp53DKVgZ2MqPGwnruVr8sVj7NYZ3l+ziax7NgKQTIhvjx9MI4B7sTU9lPEcINXMlC/t+qR1HhtXKWM2e9QgIU9KDEIO3AgCAHxJAxyfHZvaI43d6jvLCKZWiucYNMYCUM7EX51cVzaLGkRTv09maKe/ycKiLP/EhUPSiSvoHlKGRBTp+o4I1udwYjzRcHPqoFtu7NRXTG6quSoJMI6c1qxOKIb2V+h/10OFh6/bly+/HRcvJHJPgAbCfzr/WvSj798VYgHyD8LZAOlub/9ocHXQDC4wpBEqIfLSMfnncsGj5hd+6dSc9e56PetSKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS5PR04MB9826.eurprd04.prod.outlook.com (2603:10a6:20b:673::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 05:10:28 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 05:10:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/3] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Wed,  2 Aug 2023 13:10:18 +0800
Message-Id: <aaebf8f891475fb3b946be734aff714530af09e4.1690952908.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690952908.git.geliang.tang@suse.com>
References: <cover.1690952908.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0230.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::10) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed82775-f48e-45f7-5e3c-08db9316c98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tZHqSM966zJyiP3Ni4XtaA9EcapTQ9OY29aFO/ovZKRNPPEVhP0McJMY4GhJJQZ/6efBApS7wgkWYlO+vvEi/mgiC3C3+Ffvh1+kzChbVJAanNhihp8eb83Ftybcz1iEPlGcGeNd3984Lk9QEGMydriTZL1L3h6z1GVlmWlXH11S/9Gg8oxeWjMAshEglClH62PY1xM2qUFEBg3fIfklhdbUiw7gtlHfud7KK4lkBbrgyL73s2aqj6hMfvY81dR/Weu4SbH6ecWqhnw5vBFze5XJ2kV/y85KmkYCVEjyAUEf+ZoDJEIm94mksP40lfN6eTMwYMFIXPHVMztYB0nUDAOsBSMJc+iSRqaBrBVAlj9dLGS2dhzMkKv9WqtYeGsyelDLyBrdLearZu7frxu3FgV5byw9Bj5qMJh7YiYDa3MOZ9i/x3h99gzsxYimhZ+xx8imhV6fTqsdxx6YIGruQ36QqppSHKgXZh2XmvAEYv0mg5N1SW/fbfh5evfmAUWOhxx7p8keXyCnyAYcHi5KwJbFt9mJdDS1NGQ4tCDDk8GNJIBa7DjpwA3TAQEbJKbwgQ1smY/mBCVq3j9yr7KQ5USZjqty9sabuwJziF2vZ1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(6506007)(26005)(83380400001)(86362001)(107886003)(36756003)(478600001)(6512007)(6666004)(6486002)(4744005)(41300700001)(8936002)(8676002)(5660300002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ItGFuI7Hv7/L4JVwbfbzRFxSv3WKNUvxmspf4vO+Tenr3Fu6Z4/B+SSOiz2w?=
 =?us-ascii?Q?1bG7EqAKrEGHu8f99siRlhe+nKn6vbzzQBKjkvMUY1eaFoadVWcyi+Gq/bav?=
 =?us-ascii?Q?eyV1+BOg5LiXOrQI2Vd15lgXWS8bLeJq3j6daXBhGufZDbsR9DStXiDCzDDK?=
 =?us-ascii?Q?oiOk2/GYG00E8NKJCB2z18qaNr7lKk3530AHAl+5NxsRquzwdZivF0IcHQzz?=
 =?us-ascii?Q?Lnoaw5eERx3+aK8RUfj1JmfTn1o0lcCSvMHnXn0coXzYEK0Ibxo/rPaauRpB?=
 =?us-ascii?Q?kHcu1yitSWT0VYXAtVWzVxz8UNcP3pi2cwSsfbI96RXw+UZpDO8Sn7LzXxgX?=
 =?us-ascii?Q?eKYT4LYojsq0DtyRT3Gfu+aW1WFtp4EhQhU7jCzfowFP2p/dalEhbbTrWYp5?=
 =?us-ascii?Q?pjH3eG1+T2SuyAaew+xzPI7OlxJRZ+YClnP0UsSegPUM1x8H9ho4jUmDrDTO?=
 =?us-ascii?Q?yOR3u4izDV5ntiCqHejCpfU4saDe1mUpFTudVVcDf9w1N1VCDrj1wAby6kkW?=
 =?us-ascii?Q?8Q1BmLRb69U8v3R8EAgemTw3ZPdUqEzdTRZfR/SUW0xTF3t6ORZ0Erd0awPl?=
 =?us-ascii?Q?3upAOx6uDPdhiiQP8wK/pILKTPS4o0JqkrRG8kQT19zRtBvOgeHhI0CC5p2C?=
 =?us-ascii?Q?q+eP3PGGBXtKBycImel8xbbtr7lFguN/sifcK+pNSBI86d4x7GR8XDjR0wKz?=
 =?us-ascii?Q?GYfwAC0RP/K0TQgIIyj5E4i3xesPOHhk7xI1IjQOTiTjZyYZEQbklh6rzSK9?=
 =?us-ascii?Q?Jltvuf+AYBS2zxbAMTThPVv8Ig2dW6NewNOYQtg2OxC8jAUlFOOzk8XyfaVy?=
 =?us-ascii?Q?PUZIx4o/Y3+JattkgmJv/M+WEjOBAUAT54lqhaQf/eHlI6RMD5DIv0c5ZtIP?=
 =?us-ascii?Q?V0Hg2pfcw48Hkp5O6PzBcPW0zHH3ESyVl66i4lAsqueB+CwUdiFku3xdP4yw?=
 =?us-ascii?Q?2Y9oqy1Wl+L714nON1u7ALRRTy0vfdXi7wqnSKwAZiSXczXw0LRRbc5TcQYn?=
 =?us-ascii?Q?Zu8bjS+syIIKhwMFHDqPNgeZ8Pd05r2IqaTTsUVJo55SVm/vEFNFcy4bH618?=
 =?us-ascii?Q?pF4bt+G+eupSS2CWFCNgUbMet9zbYrr+FeXJ95XPKXCrrFUGLn626sTh8wKH?=
 =?us-ascii?Q?olCq2k0VCkPbjZnMPKwV04HiLR+I6mSw+oLJGX1jPV0QTmfUUXG9Ijx6zz8U?=
 =?us-ascii?Q?BxB7BryAGFKbDumtQQHagSd8rSE5Eg8VXiAfo8gspd6/lW8Gp5bo+jdsenp9?=
 =?us-ascii?Q?fAW3HyRz708hTCo7qEifIvXvEmO/ut7uF6hK387N0hYKEnrWlQ91dZpBmriQ?=
 =?us-ascii?Q?n++tR37hxBjR181mEFf+m26ezlilrPWbTwDtu3NxvyiYuZv7eFhjcJ0GOZou?=
 =?us-ascii?Q?3/6BKw1OnZJSStbEeWJ+n+kwzm/3djlT4ClZfS2W8VHVsRdIzcvcfog12jyj?=
 =?us-ascii?Q?VB3PNCnwvtmcLuGUEcIvpn6tf2rg5k0bX4L2SQN3yRgJN9OHF/a2+tV7cHez?=
 =?us-ascii?Q?szBhFJjdf/lym3d2JGHMESA1k//UkuGmufP4Egr13FY8f3/QeKrALUQ/NfBr?=
 =?us-ascii?Q?22stkVcM0hXGSoyuRoXjJ5jCqDxKX/YDwb77/wj0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed82775-f48e-45f7-5e3c-08db9316c98b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 05:10:28.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zTHtUAy9HmnWxStg1KsJ2zg/LJPRB8mjyeht+BnmXbqqp2mCEowspNIRqdgBbCTjGRXxOYZtx5RqUwHr2acPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

No need to change subflow->stale bit-filed now, so drop the writing
access of it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 51634efe4741..5c82cc35bfe0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -52,9 +52,6 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
-	case offsetofend(struct mptcp_subflow_context, map_csum_len):
-		end = offsetof(struct mptcp_subflow_context, data_avail);
-		break;
 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
-- 
2.35.3

