Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2746B6
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIwivSpwp9Pvny68hwCAFRDXoYF8C7bAtscdysu2za9sM58J2dnF5Gbba0ElvHiHA/9dGiPVCOBq6BWePdSrXXqTVl83l1DDKkYuWfnC2YA4Oqo89uOdK0lc7Yh1OzmzDkvtOrQ3/BVtDzDVFxOfWd7n0MXpHFn96uDLjGHJ6u9zdTq2ID+Nhpk0mkkkotpd9+1ZiT/rHEiWTWRm2ilf4Zcs/aTOwnQKC6BYu5YSLBzU5S87iMINZx7RASESu0Ap13WeR5zkbQUq1t/eKEXK+ASkmzcummFWvT0CuLC02U2mIgEiUa8c1rIyjySTCrh4iUrXImpeWRqmZJTW7xDCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlWurWepZib+yAQkYd2NeimJvjJ3sTB8W94upvqAhJQ=;
 b=DYFfTno4O/VaIxUzcv447xGvglhJysWLI3a7gvwbYW9ciTRgdHe/59LBOXf+ah4Psog4qNcDrbDQQcEbg60sTQtK3UZ/9Y3bMcBfJCTqmCr5Ne6xA8XZzYw6BkEkPZgtnfAuqvafr2fz/ETmFL0mCFxQKpUj/+1xu+wYMMgMVOUW8TMQWG6ZLGC3qA/r1t16sp53DO1Oh4l0Vc/KM8dJIMQAMI/MvfO98UUKiDEQ8zaNV47veLJU3mpH1vy0F1Dr2hYYhLNB0pWIBL1G477Mr4wNO0qiTDSESPxEERwUTm5NjvuLRnISgX+v5zv+I/XRL06F6HG/Ql5h+RUdEKflig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlWurWepZib+yAQkYd2NeimJvjJ3sTB8W94upvqAhJQ=;
 b=Zfkxm2oQjFIt4TzM0MosfJQ/9XGpP13t7OIH8DsegkizedCCkHpy1AqEyNJzWSS52vaSCfUZtkgVRSun7xRVVNNF5pR16H1PK4fzfg1S/Qs4klazXK1/Fc8tQ4yxW9gc/+YlWcLkypWJEcgCyqzyaJD+n1IGc7ibOp8dHQIZXp1hXdsX9xW1df0tc2EUB6QCAF3EI5GCiizJXLogcA6fAUvsT8zSROR4E1kjLdF42rgE1dAyWLdhv3y663c+gdUd9tR5YqJZL8q+bnQ+NtgJWMGkXnlX2BCdsuiO9vPqkhIyocvcyDPo1dNBgIvYHWW5iCPkQQonUlnzygSb3dTHVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:48:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 03/17] Squash to "mptcp: add scheduler wrappers"
Date: Thu,  8 Jun 2023 13:46:41 +0800
Message-Id: <b06ecd7746f8224b2052a6991789fc1fd689f6df.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f00598-6a46-4dd2-29ac-08db67e3ede4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0MQQs0iIm8UYzFPui8X96DQVsGtUIteYOcTAFPPO8cxM9R07237KzAjM5J3qn8mVhbqLhGS6BjLCqpj6fwc1ewWpfytpMuUFHHdL1C9dtSC9Igz6YsVkyN6PBLdY/mXWYrhy3enpA4Fu/Fq+kl7Ut5PsdB+f9njNh1RMJJB2Ss0wnCled9b8CQPcW03A2+mDd3lgzAaWF49paIZzgIx4jPPIXdOuea290QUxyA3odiFJxBUBIkSSXLZQ1XH22DFm1jyoz8AIJwYlgUhd4Og2hZ9FLAKJtQphhAiiMmBBn13r0mnJv4d3VlJ0hHNNDVdk3LH93UfhwYpq+NutaIPq/8k8xGRFYV+0Qqka+33JeK/eQ+nFBMTUgRHBa/xKrcsWK5a6h3JgOaE76FQnt72E7/yGvTVX7wQT3XQR+2k4hkmhlJkZQuqDvrI3f23TiAI1Btj1R15F1QFLFsV3b7NVWtqJLgdbIozq4b3CDKHuXBRZ0NiuN86j5SGeGfD31skTxBier1GY1M6UgkVV2oKrWlyskuXz4dGDRHUYPQHt0dooh3GiiHLn6sQko9HOqhBY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D25mXUlruRgekOQxJbc2JxqA3KlJee7G+nn1FN7gOUjZgjruQb9NFlqP6wgD?=
 =?us-ascii?Q?hyFMECsl8v3jdUAoik4+qZ2tzGx/lSvbUblzopM2MZeNGjDtR3BLllk/ryTv?=
 =?us-ascii?Q?YjfRjnGUPkNjcMbIQa24KTaeO1JcxPlcMqZrjBvFj4QsmtI0eDFnchAxygpA?=
 =?us-ascii?Q?uWLF5eOw376MA+FEdMfpnR/QtrK0oscOU0PVQ4uVGYeeeQwrxM3F84c0nPBB?=
 =?us-ascii?Q?7D4YtKDLWnahSM0xkAzRWbONt7PDmeGxWqWLH3V45nwPH0RqqBCr/sj2XLPS?=
 =?us-ascii?Q?rwmeojKnWKjYir2sjaXGFZzTsFYxAn775PhHgyhYTiZwFliM336wBmcEzh4+?=
 =?us-ascii?Q?i9Fv3FsjYhLUgzkTMZuz5x0TQeRneMwZ2R0wuGAmeeMluv4KEKb7nyHXPY8S?=
 =?us-ascii?Q?zBkB+DWFBZErPn/LPK21xwr0utUbuMg3CTLC4FzJBPXZD67WcowrwuSk3nD5?=
 =?us-ascii?Q?cDYCc1ZXx6q6OIHghMgyO5UUwEejtm8c3mteIOHcPH7fMtauYuf5uXwPPztM?=
 =?us-ascii?Q?e0gSIr5m3khAkPb/oSy81bumAvUCYP/8fCspElKLeuh9pO6S6GaPX/uK3VEN?=
 =?us-ascii?Q?uGHxLkwujNZo9jT5r2fg/bsOuBDU33CW/FpyFsYyhe+HIwTKO/IcBN1b+m6X?=
 =?us-ascii?Q?fVOEPbYyu4+z01lP2pfJDgMd4B55cGO0WUrCQ480iXfjbTonxmgqeKtpKY8P?=
 =?us-ascii?Q?APk4fFhZKkcXOd5KtBJv3kuhjwAofPj9FrA2xUBYUjVOJU73sA8bAJC+8p6b?=
 =?us-ascii?Q?s/3/3abwKyD/1BW/lx36PIQ3yS95RbuJHW84yx+euOwPHEkeUmrnerbehxLU?=
 =?us-ascii?Q?DLVtz3F0jIkh/sgW0rPnPHQnkuKUnjimbyWPdWuOGy/fVDm9NX8hT+kvOfai?=
 =?us-ascii?Q?OaDLNBff/965oMHV7VVdAUuj8w4XGCQSFYYN4VV0z19ajUiHexIels6r1Elr?=
 =?us-ascii?Q?sdGP2vqzHFmZ58ouBrlPqL3JhnOQnBI+PXrdPEpMuL1IyOmgkT89orPKTXTr?=
 =?us-ascii?Q?zWzGwGHjuBjz8+UFrxmPMAAH7X4WPgXnKt9p5LB3MhvjiaeA97Hk9jSMPT5s?=
 =?us-ascii?Q?dO4jqunXY4p8uqnMTDRabFq1k1vpZEklkM1S/ZNpvDMoxHEkZNLKCXftnHFQ?=
 =?us-ascii?Q?+zzI+GbfZ+N4PCdP4oUBP0euWT6r+uADKsRAiM/F2V1IWDaG7W5ztVjWbfd2?=
 =?us-ascii?Q?qIRQtdpjXz1YdwK5xuL+h8w35ri5oQEwIpPDnE4Ycu7f/qNyjRnNNMqaEBXO?=
 =?us-ascii?Q?ctcX90NCUw/Y5xaDVwwsSP4oE6VeqYYmVP1DJMZdZ9j3BZBMqU39Cs9TAGvW?=
 =?us-ascii?Q?qiYUoXxB8yITmcrIatRxIExPhfFVD2e9dlUO4DuJEzN/WYBKYhYv4cEPWiLD?=
 =?us-ascii?Q?HnjNNvHFCgtflO/ZaAFhncUEadBuWt0NXDFE6+Qs6N5g3HkiyJt9D/Q/XAKp?=
 =?us-ascii?Q?E3ikV8PjYaMqPFM2NbUPg6T+FBQBdZgHKT+HLfw2lzJMgqCaBYv70Omeblfw?=
 =?us-ascii?Q?Xd+1Ltn7mUmTnkPzF2CD9jS44Lo8x82HfnJ+/U2XfzIx3slElCtB8bi3Ek56?=
 =?us-ascii?Q?VEag9SdRP8mew2xdSKTIAChW/wLMfc0MG7NhBq7f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f00598-6a46-4dd2-29ac-08db67e3ede4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:05.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGMPHMmvLtaLsuMKct07BLEQrbgLef/DLbPoqeuM9s8osUGJTkUQaso9dVzD71wiYVRRL7EtaJpSXWGBudeA4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

Add sched_data into mptcp_sock too.
Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 35dd3683f735..65a22959d645 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,6 +314,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..37cbb62a64c1 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -116,7 +116,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -146,15 +145,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data.reinject = false;
+	msk->sched->data_init(msk, &msk->sched_data);
+	return msk->sched->get_subflow(msk, &msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -177,7 +175,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data.reinject = true;
+	msk->sched->data_init(msk, &msk->sched_data);
+	return msk->sched->get_subflow(msk, &msk->sched_data);
 }
-- 
2.35.3

