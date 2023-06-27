Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED477FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3K8bNIdP3M10o8OCM2cRsH12RNmtN3fWNGpSW5cPhYLb9PCMsvwtGP4iT+sW/1f75+U8n8L4g33bIKtcNV/Pgn/zWwTvgivP0tNfnFHhXBzjLJ6V6KBmxtXLQjEm1IoEnz8PomvH/P7tcTDIpRMZvkFFz1SvSEVbrXaPDk1SutxxXZLzs1d0rQa957Mujko9eytVsZO5E9IarDF+EUTgdKvK71dU4Q/O0IsinO83ZocNZ08L9yirevXOasGXee+pHRRYULx3kaATkTm7apv+cNU0VRjYwIKwsGhH5TePkgK0HUup5R5Wlglio6oRefOt2SYnAtXx16LVGEyWilfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX5jkomJDA8IfAV5psH5ZNuC4EpBheFrTXQeU9XkWqQ=;
 b=cAk8T6B4JY4j8xdr/7n6//ih5VaxU96qkVltbilFosDRrTqM0cK0GWs/JhW+uZbvAP2GiL5DLk2GB1ayuWF5LRxXBqC//QcLbCr1iD3RWtKQ8GFWzyUCx6f6iAj/PJYEAFikqgergN1oSEi02sum/qB47Hu0Pr56HIGQaA4U9UH8fFyBIhERK5Tl1uRyZ00bz8sGMnJRLuqX43Rl7zN8uKWPVIaRthVWNo9T95wSHlsdgOnybTQYoaNSWHneqOI4FB7UOMgrQZTXjflVskZozVs85d+sEVY8IsxkuBrH2gSstJthNU3RpHBDNbCvKVmum2wQkjf3p2DfA0V0gMaXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX5jkomJDA8IfAV5psH5ZNuC4EpBheFrTXQeU9XkWqQ=;
 b=DSyMqDO11Pu8MZd+p+ZKpc55BiuVHAIPVbjxtWK348r/uhrzTLUHPCTsqdiF1K4OPVit0NW6rUIYmfhAh3K09RBaWFfJZvBSz4B0ZzuHjdubQYbc0K8wSWpOvtj1YfQ9aogZnZMJJQ5ANEQP7TBoCkNuOd/SckUgEjWZhYD+snWJNrmHwDzXY2VgQ3BNbiq6VYvBlEyJLrmgo0HWYqcqRMKgyq+7VRxkqua7mncOgnL0DA3qHj+208WHLy9j3SH3XdlzD10f1fmLSapzBdVl3xzqW/hyNuiZHsx5Wm4S7C5u6O4QW98sA4NnxdM4XdTTL+rwYFyTc7cKO8yjMM+aUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:08:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:08:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 11/11] Squash to "selftests/bpf: Add bpf_red scheduler"
Date: Tue, 27 Jun 2023 09:06:54 +0800
Message-Id: <5631a5c3aafc101f6ba7a6caba9599bf982979df.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 489d14f3-65d0-4e5b-e995-08db76aaff0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jfqXwc0EntJb7rOHZPJyNkFa9AZxwyO04y2CRU213jIKbaZX5MiwjSbapYHVsJyzbGkrpiPMOKjGj+gIcufmd4cMZN4MAAMmI6QQa2+GMP/CkayfXH7Te/FGjHaSYVxHt/Cx1ar10IPXDve6cLyZhXPmVtbvm+WSKgZrgqtXet7lvdeyblMv2YMfstSEB9BQ28Io3FQJSVhg/18+D0nwHKCsB3CQOX+YP3ADOP9VnsD7rao+lGxLZTxDiDgN3vPSQme0iuvgm7dUSqwKXjStTylZPub+Sd2CJ+Pz9JnnCMWfng3S/KmUidvh3bOW77SYR2Omd5BeN838AjvDYNx2xxPHiHuHUuVs928Qd9Z2kci0GsTjeCrUCMEt3zLhc0/fVB2VgwgPNzsxijj8K9bZMMA3SlzFq3gOSm5LT9JWz+8nwmJa+IcZhTeZICXoKlf7L0zInE2O6vgzdWCz+QFQc9gvL/L6+GT+F5qchfSu9Q+Cmv3xxEIlb+Ew9MfrKUlFVKNf5ByfFYzSpqmqxSG3mGxRJJKCFmk3mPVeUbHBUKLwHkscPTMM0WF5RSeQPBjS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Jy51blsz54rQ+zbaMXkJ3gbvdd7yvlEuDyg2xBbAtes5QwuDKQfAWGfUHmv?=
 =?us-ascii?Q?or64iysOym/E/L9wId2bTQbCQDNCBi2UdTOZ0aM/G+Fo39/sphObUCMkX1/p?=
 =?us-ascii?Q?GGyhzOMgMnqWHiaVieEZ+QBVJYpE5KRv9967F9xQGk5NaPgppxHX7y7gA2dj?=
 =?us-ascii?Q?l0cgpzRu/RU6MRciiObHklxSErc974+bZb5TGrx98OZM4rYmn7RHRIvEnYZ5?=
 =?us-ascii?Q?2bW+bMhYY+gopH/SjaEuZ28lhkJkofV6xmsLDSuIlXsTez8ikooZzYLNw+GN?=
 =?us-ascii?Q?0DBgyCsLMckGifnbVIvomOnsMr9Uv8Dv2b4b8rAJPu93sU1xFbJxv4WTSh8A?=
 =?us-ascii?Q?CiDonU3My0JjRhd+TvR46g+IucHhp5apS+XyE2tR5//tzY2El7Fu2idXxXV1?=
 =?us-ascii?Q?ll+CXTylpTC2qxVyswTcvC0/I53v8pGbf7qKjztuAFjX585Iz8m8RmgsOKBw?=
 =?us-ascii?Q?ZgW0HIO80b1Mc3h3eIamn9sLcHZFs7xVPnecrRBTnUOUWsKAPaUG9/gOEMFB?=
 =?us-ascii?Q?F1aWaNofJRB/Js7IQq2tcuJ7psDxG7QQuJMSfAli/Odf3xs8X2s4iF+SsYul?=
 =?us-ascii?Q?e2JmI2UuZ9LNCK3ogjVFZ0Tw9tLU/aARAishrmKFz2WRgURq6buRXvltrua2?=
 =?us-ascii?Q?bYmJqR0An++QWRHWuQGkG13ULCNQRdKlGwBHHQjmwzo1z4vrnuVjsWwGcpxb?=
 =?us-ascii?Q?9WO4tkhfi8fkc2gYEawYZVpFcgYpgv3gEPR1Ei1MG3V49I34iprGuNtSzNRw?=
 =?us-ascii?Q?s7MAFgD4EZHkRBqrqI71OoPE8r3WbZYPLr63GCKQcx5S1WEmYoS1oSAJ44oA?=
 =?us-ascii?Q?ZwuoE/tv+gj+oYxwpAzG7B3aWEDjq3l4PXKpp8nGJey7fR+XhlZZVjnsC5M7?=
 =?us-ascii?Q?CNGDwOMS409XUfqY99RKWf0fiCEJW0uevtjCCVVDkVBzpaLKsIOjct62jrVD?=
 =?us-ascii?Q?qYFC7OZBMlSeeCaaRWmZWxmzXTXFLS56WFb5d3neCyz3z7+pSXInYRtzRb9w?=
 =?us-ascii?Q?jiGPBQ/w8MaGDO6JHtC4puOZ1w4rtxKiHEG2u7w2BXixSJUDgLR3GR63GeGo?=
 =?us-ascii?Q?6H5OUL/vLYbLpSqKiJFX3NAza102IIS5D27kmz7eJAQf5LyAT+ogqJq3rZ4/?=
 =?us-ascii?Q?uOOIVKtaSz5Z1ZE6AHiyb7uZgBlMWyqZmBjfOW7/IOT01QF3eulC46niBuDJ?=
 =?us-ascii?Q?DyUR6QD3yB3LXg3pA9hpX31efm6NrxqWCP8KlVKUNPU6JznPmKO8o4Evy+/V?=
 =?us-ascii?Q?IL764r+4S6yf63rOYopLUNcqcEc0fVMkehf1QBa/SQzrf0GUR+VvoYxZ8W0B?=
 =?us-ascii?Q?FtNXJ2xD4ZYv4zsRd/gcZDBoICjrDjg49DWEr2sRC7dp3TRt4AZLuDf+/MG+?=
 =?us-ascii?Q?vaAcPEFb7tHgB2yQge0bM6DszfNiqAFt4JZNE9gssKz7+3ZX/4QQH0IWK7hk?=
 =?us-ascii?Q?XZjKyvedV4wFLIJ0rrkrhPQMmmrb8TUfhmeq4M3MIw7cesMzywXN7E5l7noI?=
 =?us-ascii?Q?AnytecLgac5Zpad6FFLUfSQEYqELDVtTuX1x35iuCP0HwnE+iR+0esi4fv9/?=
 =?us-ascii?Q?gWxqGfwDWLJhjgo243AW7bLuDlRuiEECABxxfDC9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489d14f3-65d0-4e5b-e995-08db76aaff0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:08:20.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnrlNSzkbIAERRHjXmEiZbCamlzur/endG+tAs39FhNB3XQPRsPBOpxshQhqwU73k8XckJgj668mf4T//VN9GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/progs/mptcp_bpf_red.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 30dd6f521b7f..576e4acd1fa0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -7,29 +7,29 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("struct_ops/mptcp_sched_red_init")
-void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_red_init, struct mptcp_sock *msk)
 {
 }
 
 SEC("struct_ops/mptcp_sched_red_release")
-void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
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

