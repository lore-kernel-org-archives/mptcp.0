Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE47FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5BKpegKSz7Qz7iQQ7+xg/Baghs0+zdYWdvQh2R3tXlDyfX0BDaRZADpkLwrrCWML6bvgx28BsyTS/paWtmq83aEgaU3P5eTpCKqBbftK9aS9MRB8xudcg7CRFe0DMO04Kkh/B703LoWkIW9Qk2u+fy4xxQLKjfUeIDR6RUalcd3rryLQUnu55AmM6GGaog8g/RhSV3b+jAUN5xbnCl9/mlrNazcwamVvhKMuYwaHQOjm0zMg/E+8b/X2labgxR46ltQ/sey18nFi91EGEGwFyXVMVd1tuK5fLJAvRT7Q2syCaiQFAXIGyfET1L1kf38CF37q80oTOHM/j3ExXNjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qsk0Ue9+/pXinT0HWfS5nVF9Ns3y7k3CQrOBZfNu2Zg=;
 b=H3HCMFWWPLIkUmRR42lZPr2vUC2+MW7saCjlMMUljofpXEukdVut06N/c+5QWCS/0Z/a2j2GO88MRLRVRYwMoUEQLe23k2Ruop9i9Pmma8sktGa9syO54ueko6dkzdszWvuiwdqKOu4OJmIQegMNI9Sj6FVdWhtB8cyvqn8Ud6bpgMj6mODLPo8IqCDlzUQB/YjK3IgnjedE9LT4ubZc8SekNnxFJ7O/OiCgylZ/V8ajkal618ngK08mxWR43pbjopxaXE8CTJdMbEAvHNbweGlmrH2FrRxu1sI1MPLN8uPipeUiC3WoWZGgPIHE0dKL9jmOda+XneSQ33pbMVtOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsk0Ue9+/pXinT0HWfS5nVF9Ns3y7k3CQrOBZfNu2Zg=;
 b=Up0lMNuWU28ocueSZsye7City48XRdkJWG9wRmebB9fw0byp0KJV22lTHvq0azdovKCDHqTbtzM5xJr15Wwl+Eke8VGKD+pGwLpviADztjZpOBLPQNFWYl3QI6WAGrTAZBGxHFThqP1SXtEFxIkAu11cASUyumJNUvDpQjMHU9csEWhE977FJhvcWf3cpwDgLHNSiyjOP0NIDQYK922JofyfuGMKdgREVlgoTv+Ik7vlmnI0CQ1SPukDHx/a+NwuDnZShIiM5i3XOK78k9/4qYnkdeTj/GNZuCVIjWMxOeh6ezMJKEC733Bd9xc7/Vws+LqdbEu5X9HkM0ZwfQCJ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 13/13] Squash to "selftests/bpf: Add bpf_red scheduler"
Date: Mon, 26 Jun 2023 10:23:14 +0800
Message-Id: <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 274528b1-fdd7-4efc-4f53-08db75ec7d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bN6nWvg/iAf+T4Z1UIOxhiO0WSJKwxovZE7M85P6zB3OkKfYJZjcRgENDmc2CSOVrNIpUQAosOd8PKbyTfTefK02veAg64D2Nk5vzCDESXJwBQH1kpPkzR6DFumuKC5Cn8zoteXnupaQeWs/d52PSF9uomnbdvxu24Qa6mBGauTVTr9lPuJ6T4A+/Mt1399mtt1f2wHD2VoyT5zQdAZ7a8VGfStmc+iLSQ1AF4mIdlnOYUOjTzCFHutaj/FbswU9cB1+s6UfOqgItAGkMcR/i8Iy6peycxTMX2Wct/uoS3cPkyfP66ljWEnWdHfUR9X165jte9WhqQo4etFDUE/38GeVJiGmp0pZ5hx0AlQ+NcvPE8lV04U9PbOZR8UdR7Io8pdhILjpMxC6dpPbbHUMS7l0IrWhkKCgIf/rsMrQbAh7HzQ7tSqFO2rTgZMD1gLfvN4gYuSbkd0KHaKCxKQhQepeDLHQE8p9SbB5rnIbuhCWs/QfZxktb9NpZdj1ggOxuzTGX6vKTyXwJKu03+bZrXf6vf0gfhnm9Eep5NWkpMe+I8dJK/W8wzJVPYUg4zRe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FgaDhE5fv3pmPpj1prWByWFAk9TA+UHL40KKjjjtn17cFb5iyl0zjbCvmv0s?=
 =?us-ascii?Q?s2fEZWXwkBupFHW3QekATLbyXQEbKOxOdLBocMZ6TAsiehK1Iighenq6babU?=
 =?us-ascii?Q?KZNCCWDUzn2dhQCiGgk5mvdKi2q7hTE30TdE/vBdahJzdp8WnB2HJ7brtQaq?=
 =?us-ascii?Q?d/RCRDa4QOYUcSe9Hep7fXNam3jk1UWlD0GINTRFAwrunKi+ri1H/FZjixhu?=
 =?us-ascii?Q?J/qItWH3O8XLOjStO7qSkKnIA1VVmjHp1Tt0gexRy34Es3p63QGNl3VOQxQR?=
 =?us-ascii?Q?4fkG5DSByuyQFU+XS8tJ1Zg0MSVMvNCrW6XiqFCCDkG3J27WRm+1mo+SQws/?=
 =?us-ascii?Q?Pl2vjij6gyB5YAaCRSZmYCjKgLaJAWWV5koNop2euTH7HnHgtRU1Pt0clAM6?=
 =?us-ascii?Q?dMS8Dh+ZB0ldXLAqFPzKmgL4VemNoltI60OTAFePL1Nu7b2o4/Xz6vMOwqr9?=
 =?us-ascii?Q?auRhqBX5YyX/M/OnC6WQS7x0WOjQMvEQ95WqOz3Ts0Z8BNdwcVVpGVwy/96N?=
 =?us-ascii?Q?0w/cNXz0gcCbRns5Z73URZegInVnTQIAZEMtlwmBYs5aHQqQ9ReGUU9hKfbd?=
 =?us-ascii?Q?WlvRgpWaelCSv4/ZVoDnA93A4zo0Mlts31yK2MMIZDQgsxIinwHsbvjUs54I?=
 =?us-ascii?Q?bNAKA1Lj8ukLH2AEspA9alQNIjunxzl7iwjMZ59pAvgdE8wzdnw2z98DS9kS?=
 =?us-ascii?Q?63YNplYRKQHe1V8ZzU/n/eMvUDWNMX7kozkYWO7NRZBgPi0U5bmRg2ByGSJa?=
 =?us-ascii?Q?dmD7p53azB5UOt6Zhm+x+mtxY0D/xT3WYRGCwE9oj5K/+/pkc9XhF/ASiwAq?=
 =?us-ascii?Q?wxsrXjdE/6TDZlAFBjgjUrK7lpx+k2zry0HNnLRxAXEvjx3qFEo87gOHtzVt?=
 =?us-ascii?Q?vngsRqTPBfuf1SrPUyd+nmxGEb39XdxXbMJMT/lB00NNMtN3tNyftj+ovd4I?=
 =?us-ascii?Q?0pznHCnqJDaXCkJbUsW1FfeJ99NovoKCfGcBVWE+YVK1GMtSriqDS+vV/CgP?=
 =?us-ascii?Q?vRx+btF2zRSLFdag32PKF6Zm3pmNxLVJjZ0acGDVmKFKwttDBXN/OB2F8ggD?=
 =?us-ascii?Q?H3c9s2gAIklzUY8LUMpqewxB33H6aM5Mwh0MsQv1NNQba0pzO8RTMOUC8Cof?=
 =?us-ascii?Q?jnxiJwjTn/1R5nOY7LH6FsSOEnJXkwcVTP0hkR1NhCHpIkCgzwxdWGctagwI?=
 =?us-ascii?Q?uiJzLB6b9528eyoaebnTG860g9Agj7Nvn5ujb4s0kV913OnHH4TIO0cUqpSD?=
 =?us-ascii?Q?m8HOwGpoMbnyaItNcxO1odbUZqFfy7sl3WXbFgyThKuBMOxtpi14l6R71Cmd?=
 =?us-ascii?Q?4sxiBIOxGARlMPTWT116ApIRIf6L6HeMPAY0PN2GADhEPSqFI+ME1fZNIcZx?=
 =?us-ascii?Q?LshTCjI2neyIvFlrV6C0uQCRYuQHRxN82MroutQXoap+Z75bC85NjWSuGvnj?=
 =?us-ascii?Q?v/P0HMYYrMpdo0aE+0Zw7BpFO5R743rUfe98KEkuM10jBtooWW8902g8VLlH?=
 =?us-ascii?Q?+fThGt5xHrumEYI2y/dkExyE0nMnzVQANy7rEaW5DoIz33CrkG91xrDJL/Wt?=
 =?us-ascii?Q?MWIvzPYnpOteoDzM6EUof9aeuK6gDU1sa/zdyysc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274528b1-fdd7-4efc-4f53-08db75ec7d86
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:38.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR7y6iTVlGzWQMYuQLoeONqpKvHwMYl3sbM+h/Ir0Hpj/mVlR5BCXSjfmWX1y9C30KBmDlDbDvchmCEvCljWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 30dd6f521b7f..52f40e39fb07 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -16,20 +16,20 @@ void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_red_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_red_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!mptcp_subflow_ctx_by_pos(data, i))
 			break;
 
-		mptcp_subflow_set_scheduled(data->contexts[i], true);
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, i), true);
 	}
 
 	return 0;
-- 
2.35.3

