Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888B17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcuZL8ucLDS7ML3xpoL+kP/MJp5OWUejrsuATkLoXDETVuqhrk5bQEPD1wk6DNqS/COJflAHRe6E6NeBx3c/Hceb+S6jjwvYg+L5LJWLIKpFt/FQ2bHF5ZbA6qnRF7cj1jmedYc3HtP9ByT6BmtLr3FM9iaa39TTXcsp1ePXDWLyufXofxQhauyk4A/zLJNtTLT99VGPWPgLMfACE3ZDhepu/3YL9T54VdghFZEjeh24A6Wr8riw2SI7LQgObdy+wFrU57KW0AioUf9BcN2x8j1cC26czXFcRLW72JRxM6DzJuJjuu3YLITp6O+W03cQ9h2mxNFPjKPQJESRY4SFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=OjhOUeFGy9Zic0XRpSQvScaCw9k4joJL+TNE6Z3vvW7XjBIcHgtfPPRmnKvUUmBpCm6vjz+OAtY8Qz7LiI7Y8hvbv4wxUTbuMNEC47bbw81U3H4mEZFsiPN1inrZ4U99ZOn2WbZSsQ2SuyOl6vPqY3sCC3FIKy+jPOsle90UDGfqn/3PncJasCykjQeMkWCZ+K9htbh+2tNJk0bNU+uu8NX40k0sgVsGHXPuGgErwanNg02u+lrMKT2ieqcA3rKQkhcJSjzwiW9OENexBFj/V/AbFB3+RpLkb1BRXZOQb79FM2joN6rCnobXo/5a93S83cCUo3TkyQDCdE6DdigA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=PimE8/GtcBmzr34ZrMWPL27sfs0ce31DRAfrnvSOQv7KkfAyjhmABT1W+aMHy8Pp323feEL339siBgg7OP9goIjv+5NzE0ToYyTRo7HwUmNXRf54648aWU0W9TQTAdULihVUTgJ1ZjHTEZOsyjAevRWaTkGVWJTqgczKBZ5w3y6HijzNG2gFB2FsnbBNWZtNIPXlaNVcxv6WJL1kRqhy20/MHdqImmChcsf4pelYsPWdDUgZcuR5vwMZLUVflg+oqz0A1cZxfPt3H1Qtra1GleMuFxSmPlwUsy5UIPlUumCaV6NrD3oF6XaPhQb0ZP8mERYMJlUX8UKUzs/XDxo2kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:52:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:52:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 14/16] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Wed, 12 Oct 2022 12:50:35 +0800
Message-Id: <deb773d065adf6973cc108848b68115291797d3c.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 95030512-6aed-44ac-7047-08daac0d8d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d3uyGf9eoef0EPPP1R6eRdiQ2+tTDtU2Hce6QIbtDxDVPOAZlEVjeFeh/SM1HAIbFw6OKRvCzq9Xu/vgMyFnuhJMvhJraqeIypff21FXkbPRhgtzFtNjpRxAXazN/6dsTT5YZUVog2TreIU45JwEyQuvFZZT14JK3oshOz5Zj9xfzXW2qIz3bcyhG/JKQJcjSToDWDe+4+mieUQmnOZEILWrN7sYFhNqSSyRk3dSeMly+2Z8Yw0N/ytnM6BbG5aI/JJQJNpqnM6iW2Wt6F2qee18HQ165fScwPKHvMT5kX/TBr3kwZHpHAcCevFzKiBnKzwLsdRP8t8724VuZ3L30g6yo6++jBUE9D8kCNmaElCFpMW37yvFqNjXQ2dXLNdcSRdd5grTkRF0Dxw7QaWEt1SXYIrCYjF7A8bZv0WlKWfV6w4vRn30QwahT7p+JPy1WZ6PTpH/wt5j46Laf8Bw28Cicbrx1uiCKGETPMw/Q5PvW0KHmYV2oJMRsQZFcj+4tafGjLigfMqlxN55KjpLBora+EM22MQN47iLc8jDz2QnVJN1YZgxSzZrV2PhUX8ZuCAXZqoen9ZuWKSY8VpNhcH1e293PWvV/E6nH7ncby2Fp0czgk5Bt607tndsdDf1iL1l4A81/OOAKUg/UI7GB0ilsLjkotxB4HPiylBl3E2ofWANAutZujHw5L7+Cz4kzSFmV2pTNZbHk7otbgw8mclyFQkxF0JwjvBhJOHBhufi7din8rcoBC96OrUXvH8c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKBy+LYenq6v6/LR8stiHQA9c8I9UOUiM7NcutNGy2DMfAfbct8/bBdsJs3z?=
 =?us-ascii?Q?iMTi9NPy3RxPvtOAm0YsYeIMwDyHrp8+Q3qQj+HMpEI2F3oVdmwpdUvE1Hgs?=
 =?us-ascii?Q?RwMO1fy8pmIeOmZaaCIY4NF8Tj1eR0T2PXV171GxzgdL7wLgS7WyMh1NP2A1?=
 =?us-ascii?Q?NOLEUdveSepP9yBSninsvmcxB6Rm4tpwhCvILgDPn9QqQdzfqYYWyNBt68w3?=
 =?us-ascii?Q?LhMmLk5ViaANaUi7T+PkS+J0guuS5IfiZrt7NzFRU06mXwttsm7IHJ4OO5hV?=
 =?us-ascii?Q?JIKsW1nOL/PnQnlZH2JXQF17qWvbY3i6LDtPnAAwFdKUjqUfMKg5Ap4hTHIu?=
 =?us-ascii?Q?/V2186q7U4nYquZd/0CY+9cKJyLwOPpNWiBMDBXmlMT5GUJVvfLlw/3UI9DL?=
 =?us-ascii?Q?LJ/66frWjuy6ZiRIQz4/axHekRQYjV0tYDa4dPx6mEfFWcdW/+Fzdx603Us7?=
 =?us-ascii?Q?e7THfjSk8SCL1lKAe+Afcuei0TFnves+k1TwG52wvO3jPWSpUfZeQlTsx4wB?=
 =?us-ascii?Q?I/jSFR8gXKGyG7WitS/h7n8P3aujnenhS+zG9K0Llcg2QEw5/kit/6RXI2pR?=
 =?us-ascii?Q?foGCL+U5LeM5fYkZIxmvevcfQZDGKrtscY624QkMT7HKyUYnCUOl2d7RKMTC?=
 =?us-ascii?Q?VTPs1VRto5F41zHvs2G+8eiwM5hN0nwD2Lx7rkiRTEjLILaaxB4LMu1l2ImE?=
 =?us-ascii?Q?gNcuKw0qrleCGaynRVbEWAw/nRTDBmoxSBUWa0QRHeZAI6Xb57dq2GdeuFAb?=
 =?us-ascii?Q?n4oddO9/ek+XmdlE+bFMAr4w1nrAteXGwxYT3K0LB9YwK0wmZEU7GT12Jp09?=
 =?us-ascii?Q?iQgkCtta085WNsLEvXIt6ju0yvexQG9x/S1YCT21D/K1QiGqITM7IlO2hoKI?=
 =?us-ascii?Q?JCw9gq3J0l+zf686PNrzqvn0mFoR02EL0AUUvBS9DfNeWd0ONfcdrqHrkGxk?=
 =?us-ascii?Q?86ce+dVZA3rrPw2QJTcUxE1miecNmxItTDrcgppyblGZ4AOWSyfydHnNRff3?=
 =?us-ascii?Q?VLYg4rVWkLVwNYksk9/xg1pDe6EGbJC1KPnSu75+s5C+SjkhOu63rSzqCEo9?=
 =?us-ascii?Q?F+LNUfY4qkHu5l7zZcJiHWyBa36hEdcWWklskA8CPZ4Xx3i0NuGTbOeBowcd?=
 =?us-ascii?Q?Ma7ygBBjA9h1NUGn0qvfimFO2Yjv7NUF49gkk7HZsRYjbQe1Vgyt6rSloZmE?=
 =?us-ascii?Q?e8gJ9OYeHMyaMKRYDXXeZb4F37BatSUzd3zd0IRlR+Rnn+6WiFDYfArsdX3b?=
 =?us-ascii?Q?HEj6XrCt93g4CsVC2E1ZWeBYWNc9B35VjHIZa9p7WryBWXN7OMXD8NNjuppm?=
 =?us-ascii?Q?4Swqt7FvPZt1fGY5fZBlvrTQ4JBWMCiX5ChxHoUUruJq/DNcuPcE4YwEc2Ij?=
 =?us-ascii?Q?mnvY/nS+/Dq2mS7cRBPm/PKP4vttPqNmskFTHNcfVhquECrm/HQo1SQU6eEd?=
 =?us-ascii?Q?dR+meiZHcoBi4o4HP4JQcntEkhQuEnvS9Vs6G02jib/+BiEYc14Zs7JIcy8j?=
 =?us-ascii?Q?mAtar5scc002PFDStphjX1u6wzEdmmkVTquYRXGpyVyjZcH60J1vT5xy27Lh?=
 =?us-ascii?Q?OJ+liNFA5l1kyOAD+CtQaz5oWoMwztEfKf3yh+csVrNnMJ9m8fpaXRjRQhG1?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95030512-6aed-44ac-7047-08daac0d8d52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:52:23.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U83bJ3xbR7MGjqE5P3NMd318yhPpU5M+i+TCixQxZ/MHyZNheIYjza5sOpK56SPJe25bzVNaE8wPP9wNwqfquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index fcd733e88b02..e4caa2dd8c6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,24 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
+	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

