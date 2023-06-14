Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E007F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6l3j78+uGGYyL8rWVGP41mWjwsjWFpZ9FhI/ZNLHTDklUuigxiYnH13E2Vqe/gVZorB1VNUPJ+bMrHyf0TdHWloLIruTL2GnmtOUsFxkcxMF6t78meNqMLtNU42LXemGuK+jAmFuFMG1mgO10i581bkHjsRVaOcXnL+XeDW1y44+gCzqZxqJimi4NY0hwx+dx54A2pwBPqe2QH1yLMzyQjn52TutJgf9/bGYCU8IBiKyjVfIUD0SSO3u7XcaQa+iAEcuAU9j90MwqQYro+OFuGL1ObMDHIDntvBnYer3j+KuyWXDMKEA407pzlwYMAyu/Le3ZYgGZg7mXz7yH5scA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9XbLa+Nq1svGJDbOozza9Nk4nsH2SEAV2lkGMQbkiQ=;
 b=T/ZFbFtjwEf+7QVER1X/UdERrqcOqfKy/Hdz4+qvTnQRLr2bpcy6Q2hNnMxE9idNwjhKZlwibtqBQ0zE29WmIe2C/SgG2vLtx4o9vbiu83ezgVBDSqHezMVUCkQ0T50J4e+E/bj0V8qM53pUNs+3ZeWr/aPlQsQDeKVqdSv2gc1Yv7pcIoiwH5XtqJbNBMvqXRwZnPpV9DfeDhuT04AT1nQht+awycVcytdQikFpfllw6lfNcOshxN5gOThKhcgfpTiyUdbKRRYTS3eCjGddWeHCLPlCpxqdl+Nt76ucNcoQS8X8MP0QvD8NCt5Zh9+CTPOPThkHz2KP/pBP15/1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9XbLa+Nq1svGJDbOozza9Nk4nsH2SEAV2lkGMQbkiQ=;
 b=R9Y95WIMHIT3jRTr2Yl8oByA57GmXfDhZes+tLjTb4Y7yGR51Tl/qFmsJ0dtrBnOKha339GP9tOTAbejr/ZDFbc9jZLF0Y5TqX1pj9l0YEcvu0TphvGqBph0eDC6E5kvlEUpYar3TJh3vvLy1K9Bfe3eYURR80vAbcVBp0LJkC555AjjVujV6l6aGrnyj88iybkMqnXz7ETWAGU7260fKZ/b1wwz71h1qJfdhgfExfAMiAtoFQzQWtw3dKRPqFJODJjdRyLrOwqAC/6qEU/XZ7WfxLCCqUYRuhc6f2Sw/5Ou4KRx9KOASOxeHfetuvk4ALQBM1ML0+16uD/w1yX3fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:24:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:23:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 15/23] Squash to "selftests/bpf: Add bpf_red scheduler"
Date: Wed, 14 Jun 2023 10:21:02 +0800
Message-Id: <0796cd47f401102ee21d618625d24f8945bebeb1.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b1078c-5cee-4b3f-578f-08db6c7e6991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pPKcPODNOQLIP1LsjnQ5zmhl+vSJEldNyBJjVrRDe2++3YQKpNDNhlTnV/LtU11U8RtB5iuHfrh+0FXSP0u5Jc+PwcBmSx6pvWNXHkUwuAJQfHujfScB2hbHM1RQQvPz6AJZUVY/BgooSZg3gOhfQ9AjMsdMpK/FKCitKpvYhsR+dg9RIwBWOmPulJW+upqz1yF3C/UCAN+rbXI5flvNnErtLzJJBjQjgbPixtFmPKALD5K0Nax8Qp1zQUXnlMIfxeXjcJ6OPmBMEL6AiWZxgUzfhkUV7pUl3ifq5P0pW0X6EUmSBwZj/HQwaR96PPiCCaHYxl+QIiFp/umwYkFG9cs7IVymf35d1nWax5j5fHIJdEFUmNWHzI+gBtvF/RCI87+RCuCl+Bxo0vwQt/1UI99iWDcu3zyIKhl5l0LfpeCjkaXuUib9BQ8eLcDsIQL+uRVs/uUL49MPJOT2/LnIgdPlRwSZHJsRHP/dkYnN3B8jUm5HZHddPbQWhbK4idZ5+QrdBh63b0LAof39OErBrwmpuQfaOQi6j6UL/T1CQa2C9Z9Xxzgcho5Wm9OiCeYy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(4744005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Kjx2x/OAuOq/G6e0MzIPbxGHvXQFP7mo93sGIfkKL/i5X+2JZPcDXqm+1uT?=
 =?us-ascii?Q?L99ddj4OKb6DblL13OZRPtGK83wYuIf1fNc1ntPNJftHSHedVSdCRFWZ9h+Y?=
 =?us-ascii?Q?V4nsRNvAee3buD76VWYi3Zq2RpeJQTe8vj/9o4EzFMvMnvg+GwJVlkGeYuAw?=
 =?us-ascii?Q?33L5Qz6e1Xvwm/ApuKNCFJ68ikmHKmwKiDr/tdJ4Z5pUEecMSje85mkwFB4V?=
 =?us-ascii?Q?+5G+7EKVz+fffeGjV9dw+6oupQgUxPww8GEoDssy/uGSskcECSo/hBCjXt3b?=
 =?us-ascii?Q?vDXMC9nJwosMkDWSgGtaL4eSbYOBIKN2Iqowzn64nyk1hpclqB0ih5GkLY3k?=
 =?us-ascii?Q?HoJaLFiJSTyBQL5jhjtoq081f8T4jXQi1DtPDhJR5STvJveMeWxo590/i0Gp?=
 =?us-ascii?Q?VL45Yoe5CFf9piG2xWtjUk/E30BmQfIReHSEJKeL4irjxqSUumo8UlWRyj9v?=
 =?us-ascii?Q?/Ovs0dcwIVZaBmhENU110H5zB/aAq3YNigQxWoXgpplsmKEqfzVIyfxbaAJk?=
 =?us-ascii?Q?9U83AYBWbVhIuhN8kI5a2x83+lVjyGg72jph1et1mmXTZOf6I9Wccyncytgx?=
 =?us-ascii?Q?pcGwlxD/2gSHWTOvVaXZiq/FKckDB6N6SSzez5rPdS7DJ6SKNn+m2G4KxRpK?=
 =?us-ascii?Q?Txijc6QS2Ut5j0qgW5rYPhNcOwyFPDNXnVm4FZveUqSuOm1oNO8KJWr9JWXW?=
 =?us-ascii?Q?IGwwjiRfe57mP5JxWW7O3w2+8c1VJAyUJRYfyEevSvqX63F/0xil0rrCnbFc?=
 =?us-ascii?Q?AExsGWeeFYcImAFvJddl9cjFb+VaW+aTn9XKWVIJg2DKNfxVuPdVTuTkpb2/?=
 =?us-ascii?Q?s78pRAIQADyQ96oAmZ3Pa/t3+Hww4M7XoVdpwEkMrbaVvNjTIq3DIC95Kgx6?=
 =?us-ascii?Q?HXcE7dbjpa0T2ckXNO1Hheujw52VKnemc9GBO9SJHpblYED3NRWzGJiA/CyI?=
 =?us-ascii?Q?mUkTZ0PqJ31ZhIC8+x3EQabaJJLgdmoQPFWmTs0ZuNTd/e6rMAA3lBE46p1W?=
 =?us-ascii?Q?BwFdRe/JqLGSdXsTgxqilyTdjYgeF7/mPCAUWwseFgOJ/ZOkKvXIcer6IB8N?=
 =?us-ascii?Q?paToj3wTMcRMGMTtdSGyfNsZ9xyNEdN5MjLUuA0aOgKlNIJ1yCYfDT+IReRP?=
 =?us-ascii?Q?tW84Vx3/7/zO7yRKGCnkzpwDHqStfTIeRyLvzORunCGwtyQ9IRsslpQpjLXG?=
 =?us-ascii?Q?c94aZCVjBnGoUqgoczJPGxjhnfde+zruUm9yYKlZ/GOGsm7ypUNxu1uqYPp9?=
 =?us-ascii?Q?vPjmMwSa2KPn+xPXSd2rOd6l8hHoDrSFfEv7Qltm//kJidve29xtAf7rWWCq?=
 =?us-ascii?Q?9QgOOLldnFAPwsvGvNn5587zwYltQHXS7PKocBWLXk3hGwLgwonQNDdGgW5R?=
 =?us-ascii?Q?kPSAo1meqjlsfomLJ4w8t+uTnqYJ+guTN32CS6UWDgukhXBEFVXwh5U7wlNh?=
 =?us-ascii?Q?qCv4zSBHXb6QqcPnAof02CXd5+Fzsub6eUFnkJubyPd1CD9M1qQzF5T4xaA4?=
 =?us-ascii?Q?FBlqZSW0oztT0TxogIvuTJxFTEcaRL6QMy4hQvow5/VLMfcVpSrr85rlfVX7?=
 =?us-ascii?Q?/8zYfIXXamfHO7rWk8wrB8PohzFVj9baJ3gt5D8n?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b1078c-5cee-4b3f-578f-08db6c7e6991
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:59.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/n8lOhe5hP442LmKx/maJleFv/OpAyc241BWEWHUGlk6tPKBwq2URpx4ODVd8ICxZN/tbSi/M2D3tFCvvtyUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 30dd6f521b7f..320d46d78b2e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -25,11 +25,11 @@ void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!mptcp_subflow_ctx_by_pos(msk, i))
 			break;
 
-		mptcp_subflow_set_scheduled(data->contexts[i], true);
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, i), true);
 	}
 
 	return 0;
-- 
2.35.3

