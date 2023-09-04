Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADD7E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLhPWMiKeB/G7jZeiH7iX7RjFk8aDt/4JdJ7vcpUKfEo2DQUmtFivwWAfaNbK2yPV0ESZYw1/c74/5h9ehVjNmfKjLuLLFL5DX5/RosXaD8XXH168jPUe+pJ6Rt9uuhKgXJ+ZPdeA9dOHtLV6u4iMqeKayySoiKA9RHimleA8S7kzmwJ+4xo1ie2LlFwR9qK41QQecUzoK7RreOFntFxQoXGJGKuk36LU1wxcnU3d6FH2DGcAPtvAtqSf8H80Yq6T1Fyc+XtxnBsz88E/utu8PoykpZB+n7nBvHi6hjg7Zv14Ve31bZl4Q091t33jTAP1KYbJ12hU9Yv8A5ZrlshCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ55/f7UK6rn1dpkBFKFcwueq3VBXM9flqdDf1eB4M0=;
 b=Feq3Sxlhct0Ysyo4veJsVBb2QCG5Zw4j0ziuYzEFg8EySnUFHIBeRm6gh8YifFi5Cv1NfcIJuBUN36eLbQQRJlRF4k7MBQItGnRbXhQHjAoTEQvIjmJsD8KPi0nuJsTB7mNwunAS5yzbPHnAA9pQl3UUHBErKFbxp4xt01jTYe0yARiRLWz1iWREkQI/mHBpHfAC6ok1il0G3OFUWe4WdRRB42hVEAzv39d+OAW8rG30qDV9f08wPEur3SF1jpkfSi7NPiHUEKPq0/bSCW32AdePp6fmPDCcF/xqNUKay9ESm9YsHX+GYUZdQr3NQdg6KsK0Rpk2yHg6/3gminG8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ55/f7UK6rn1dpkBFKFcwueq3VBXM9flqdDf1eB4M0=;
 b=FX2qdVdjb1l6Wah4HWYgd8/ULLfG39XLIBW+k141Ku7dtvbQA7j6xwEggqhNiRCSKYt4iu2+ONhljcAg8/KcOH+mdu+ybuNf/C1G5JlOj0CF4IV9kE/1GHGd8EKb1uIx6Dcf8acVrCqqPIhhKlsN1q+0WTBAK/1hkjoaPrUlFS0N4yHwChE6/pZ2d9bksCZ8M4gXhEx8SnPkSCPzdQGM+hC5Q172X0M0BJqdY5CpwY9ZVnwygHWINeAwZHB96M0b4LbydglCpNhbmezEfu98M9HDwnOeh3OS10Fxl+Q94iYxAz2UCTDbcy9/lJewMX9Ftgm9pAD0UOoVuF9FjaeTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:40:29 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:40:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 8/9] Squash to "selftests/bpf: Add bpf_red scheduler"
Date: Mon,  4 Sep 2023 17:39:27 +0800
Message-Id: <844b3b6b864b5dcd8f0fccd06735f33a6873ab29.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0295.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::10) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1bd4f5-5e73-456e-16fc-08dbad2af9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9i6ZhM571550ltO2ZzJXZVuGKVuJ4OKDBRetgWnmskryqzXj/JUyz6cSg+Lz+sYs+wIFlQ7aQmhhcTDcEQHdSLSOZL/TsVBiddx5e86WIr4LQirTANiJkLhaD4mqJxtPW2ok4bF8YJ83/lyKoDfGQqNv5iun2s+L4aBFG4D+gknR3l5iH3ACaCy6C2m5Grpzlyg+ualt4rBz3dH3DzCz/azsmBaJ46pSuGfxekJ5/CPpgTcfJ453Rb/ZRHFOpenkKiYcA4PXRZTLdZpsMxBtYup6pG5Iq56oo/Qx8hp/XThXnPp/RN4H5t3Odmgi/LJAuwDvImaJtI0563t/e+JRJ2jSDya5KIzbHSNPzwxb+U8HhNWoSRE0AJ1IUXB4kahQa9e6XaHx03HFlOAFUAq3j20ECcA4vhfif+5YspLwTnu+CsXS4t3gk3qG01KAhtakay24xzru7P4SwXjoVC+bG8PPsoPxtiTiwjYQP6e7WTwcPoeJ5zqGTKbGz//iLyljYfEuINYj6dnYY0a6k989MKrA+Sa7sB9HxudH+qsnBvGx00W6eEQg28URCA0mX/NB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pm4JZ+KmyYsipzMF/xN82fx9znr17QZv0oSjZulzvKDuFPOAMqvYOlnL+pZz?=
 =?us-ascii?Q?BOCazhwSzUo8svesltJ1I1UHkD9SbV4Srlz3eXpRRD9GzljUhKIovbQsKe5W?=
 =?us-ascii?Q?OgEDYUYyQm53ywdE5ZxJC4le961OFVGv5rVhzp0Ba2CkIukSgGYdv6jaHrXa?=
 =?us-ascii?Q?8tGsrnd0ftlR/dImPyorIGPHfdwN8IHFVLj/tm8O1UomF8JJOh9zitQGBXzq?=
 =?us-ascii?Q?6Y9xzdj416XXgdhNW/kqZqFpdKZ21XnPFEyMCv2JOd9m1K2/wDS1jjMptQKF?=
 =?us-ascii?Q?B+A94WE6tCYk2AciAKGyteJLgBdA62X8XMF8Son9kMGsZvG/WrXGGEN8jc+L?=
 =?us-ascii?Q?YwUkotzulKCyoXQtVvIlLtWzV39qMoxjmrbf6hpWyCBYII01veT9Z6AV2gRN?=
 =?us-ascii?Q?kKQxa8nfHuGCXNVCr7E9hlBxbMpo33Jzl+DR+rwy3LVIGln8qEYMI1H6bUKn?=
 =?us-ascii?Q?jcBfLGjC27Kuw9W3zFITYf2jOEJEy5U9nA7uByONv/UV2LOihooW2iwQDULG?=
 =?us-ascii?Q?qzoFRGbTcBJ9VIm1Fs29kNHzlWV0Dy0dax41nGJuLQNdk3y2BJ8BtCAlyKJD?=
 =?us-ascii?Q?U5qysXST7nAhXghq9oFieb71VzP/TxrzNuugJroCNN6KKDFkp5xqCJofCcyH?=
 =?us-ascii?Q?BxwaHdzRXvoV3AdkHOghZR/EHsOguQIEayfZM1fwnsnKnRf349FVPn+RBY8R?=
 =?us-ascii?Q?wHtze5G58gQaSohgcQQT+JODNfrobMIv5pGMe5d6PdNoFtBwjGXiRLWMaa+G?=
 =?us-ascii?Q?P7ZgSw8P6aZug+kcWtC3tQXEp/iPDnxL8yjPxgrCi+7j8p6p0k6uON63wZqU?=
 =?us-ascii?Q?4CBZRFRrPUGeg4Y4j49ceaU26LifIHZKdTbx10Jkj2RLB2qLsUJZODwmlOod?=
 =?us-ascii?Q?C4LYynrlvMDlM5D1i4m86Rcx7bL6iEim9ugaWWFvOd3BWcap1wY6DJ/Z53M8?=
 =?us-ascii?Q?guKbec5gPTSlrNqMGhahgL/SX+vcBf2qcIX8AIrare+8NY+Oi6IuVmv1WFGM?=
 =?us-ascii?Q?+OovcfuOcYBoaXjdCr7sQ/lo0c3bwpKe8ZY/BbiOWzh9h0fOOgdrcHEPFi7N?=
 =?us-ascii?Q?bnPjYH8fwDWI1RQXhe8Mownx921dxpAnwloOMH/VdDJ0Qhi/dVEqJtPq1hp4?=
 =?us-ascii?Q?I3yJXTJ1GDPpex5gmd7iNpWBsU8QtAnWfxpHIo9MmK++aE0Z7KusS98g6oqL?=
 =?us-ascii?Q?OO+q1gGpj5E7uzLcCG6ogy3o3mtp38sG2VBIEa0q4CSjf2YwGGpJqbwl8+nV?=
 =?us-ascii?Q?INe5K1oSrf4+HeD1Yj7U5u9131VG3VVkYGFNK268x1Ip2dNv71XxyH+CguG7?=
 =?us-ascii?Q?mG6d8e4eAr6pGoIIOQzd5OppR+dG+uWHVP9wWQCmKXmJfaPq90iWpaln0KG3?=
 =?us-ascii?Q?1miEieEgTVOgvPc/e9jDlGDm16+yd/IsvuUVQqfsbX8v6XiXV0CFYkQmjwIm?=
 =?us-ascii?Q?KnXuAj7XA1ne/y7go14Qg31qyzRiVaJnmyMdOYxFx2Xl1lvN5PxhyhUbjTr6?=
 =?us-ascii?Q?pThhKMudBXxTUbKzZkDbvDo2tK7rMjVCawzYegr4khQ47Ux8DlCBD/WjkkxN?=
 =?us-ascii?Q?rkcR/hJECFTY4+l0aL5LpE8flvlbtY0JZkhYhjTu/KQpGLUPWHnKuvoljsNE?=
 =?us-ascii?Q?hzWTG0aSDk1eVXMd88HcUGPQPpsSr0T9FRkWJcT2bGmz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1bd4f5-5e73-456e-16fc-08dbad2af9ce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:40:29.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSrUEyufsIa2X6qZahpEqfF3kqWuMChk45NN9+zHdI7iYrd1bwJUfx35SEFOdTKtW+Q9CZY/XyDROhvUrWr5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Update mptcp_sched_data_set_contexts and mptcp_subflow_ctx_by_pos.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index eeeec6250f64..a3f3e5ca5278 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -19,13 +19,11 @@ void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
 int BPF_STRUCT_OPS(bpf_red_get_subflow, struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	mptcp_sched_data_set_contexts(msk, data);
-
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!mptcp_subflow_ctx_by_pos(data, i))
+		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
 			break;
 
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, i), true);
+		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
 	}
 
 	return 0;
-- 
2.35.3

