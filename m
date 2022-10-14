Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05620F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvX03bCQhHNpsBMl/5UpqVN8xC9zaS61gBhgQ52ashif1UF60rlcIhJXAvi6WpTsTdo4DoRq2yORbIjo1WCth6+7icZViGIq+/Mz64sv18NXRWnntOIgeRy8Ii6IN7zTLhL8x4nRNMQPnwEICG5yAQdsjjTOFl9BGnWXgQeuR4JFXXQV6fFgNdLq9+z2mAzMJqf/YgKe2ypc5pg39eRswiTsXgj7au0GiKFyv+oeD5m+Bh8a9DpxMo5nNHL2jGg2DxXG63kBiK8ByLEFphUsY6lDH/CGcLS5pXcl/vOHnO5KqZg2w6h01jSdOzb5DUOQTZAPxXmgfQKUk/qYVLdUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=Ajfg82Tg1aIJ7nZ4w3w7T5s8q2KBTiyaZLGJupYEkw+8/pfg4nQJ9Ril0HwTyoDse5bLmO+d1wrLM6tTPGXrLwJ0inX8ZFS1EVzvX2M2EwEPvba4+O4gWudpWRDnAF50FBYjmLf+QqED3Otm1ljT8J3EOCmMJYHGNkmhRk5uPcj3y6ZxPDIEi3JHLajoNS42QMLdNN+AhUKYjoxPCh0fV9S5uaB+/NyC3og6SGe9hgsl8HO/LqUcoC5+B4WT3/lmSUL3vM5p0NfbItqq+EmZlaOfx1uXkpuz6ChtyyQI7ltQ1FngjazlNISzxpb7DENiYHD6oSwuSpi+bx8rbEJ/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=K0vST3r7eLvtD79wq+D+rlpVKtoP/NXZo2qEsrtdFmlbrLzvujnZ/WxdgaemPlxF3zd/ZOZ3NocZkOu41tobb9AmXEYDE2Gw0JM3opOJxswKKJXf725qR74V4SIx6zicHAQbCA51ZUGnjkxuYLVin5isxGpX/3QCuH9PSgGgP3PXZWChCeOYaDir7Bb+gvKtw61aSRCy+zvzbSDZbyXlW5hjtQ9hmyftI45C4f8OEkBMCL/WcwaVbahdJmwV05W5y8cVEePgeSjfnH8AHc2AeURem7tFrlUIHh86oqL73W2IpJjyPGSsgpm4SqHdWkCyZH+fTQWWkRBsdybyJsxtRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:35:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:35:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 14/15] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Fri, 14 Oct 2022 21:32:21 +0800
Message-Id: <7249ce2f418dc84e658062058b39eb0ff9e8de47.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d389f57-08b3-44b8-d0ec-08daade8e4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GZd7n7w3aw8Zh2urOAEIHQB1alibVrxdd3qhxitLuhTylVofud7COK6lwC3vHE1HIwWlSHNNELujt+YS2RFMZf1H/fn1iaSnva9VB8+byFcrB2g/YMxPWFl+FSpke2V69dykjNyHQql9zuzbER2oV4+aSJUwM523Zi6hD0xEmsx9juOnSHmIdiXuTOpT0ABXHLCnvvsMfNOydjsTgFgC175/aSJiFzA+jA9wWTEKf3klScupymwEaURDoG3owA48fcKuGtZNgEteFC+0yvOtjs314Y6V/3TFN8+YP0AhInsQg6+rW20gl7Hhpi5VabDpg6mlGKvcR+wndV88cS07/p6qZA+WYToXuz0Kw9dSvfyfW31ZDTNVeafuw8OLdLuntDr0vVvrttiDGBqb6JQEobQvQ6I0gD72z1XxglsIQaxsEB/hgdsuO5KueRt4D7cWJ99z70jc8Vq5tNxvvBAdQ9g9+2BWtL2SuWFfv7oGSpYaUKbWafqW75otYTiSvyA9uVO6UBX3jXR/Q4rd5D7iNHD03yERiTJ7RGJxZf4R49KMImuLRe465I+cFg4+uhiM7PtCj+0ElMXHPZHK2k+sHZPcsjptWN52EhdBbW2nRpzUWywms1eF1V4uDlDG/ko3pctCc3nqIl2087emahi2ncdxs0eQnKIiQwCzTx+rz2aWSl5N/KcH4808ahYIu0AXbnD1JBFSRpAflpvCPUurU742412m8VAHZVZ4TuL8NEGA7Sj5sWW6/Q46MRGhhtwc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(83380400001)(6916009)(316002)(6666004)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIixKCMwbw49L8GOJxYa/4nmSvAqYRA9N5Ns4/YZz9U2xvbPQQMysn5jo2LU?=
 =?us-ascii?Q?UCY2B3eoWttysw1UMzS62mEqBdKuvfmxEi2Y1f4xIU0dryU8zJ4KtXv1SmlM?=
 =?us-ascii?Q?3uS1cdZWEDnooXALuLgsszGSED4ou5Gt9j2ZbWaxY3mMoKFFiVtB2NK8JhHJ?=
 =?us-ascii?Q?zI9pd3n1Kpr2eTr69j8cfR2SoweyjshfrM8nTLTJT4jGy+Lzb8zvEhYmJue6?=
 =?us-ascii?Q?9xlinQpOTKEJBjank/HYYRhhEjil+19o3MMn43+9dNfcumLx6LSF4BXQr9B4?=
 =?us-ascii?Q?2Q1YPokisIHuFLlBimORPxEUe8prtUax+mz1TS2J/iH2h1uvNk2gCLalLUKP?=
 =?us-ascii?Q?tA4Us2AVCzOgDzQT9YZOEvVw1R4rSM/bgnlopVO69ZPyK3asETJrtoHESpE/?=
 =?us-ascii?Q?TRI73J0L48UYMChz53gqC9EC6R85Lm3gkpBxO/36q4MdNF8U2T9Il7mxOoS0?=
 =?us-ascii?Q?rqfvo/IODLTn7KLoB+xvFxvAm8f1J9v74Qr6wJr/4v/CiDVVpuFZtkNczoIk?=
 =?us-ascii?Q?puQ0NLqDnlGdjzrRnY7VNdf8K5jDkrgTEWBe2c+8IwFnwPQnjp1wBzLyqtBD?=
 =?us-ascii?Q?F20NYPmYhxGXyaj3YC1V8LNjqGTs65IdLy+UEpJyN0fGnC9d7BIyfmSiE1ux?=
 =?us-ascii?Q?TcR59Ma6ukAKGc3wM5IotCiruGwxI4NMV1Wo7zDeOwmb1E0WbmLPeHSXLj7u?=
 =?us-ascii?Q?a0ukZXdzYQLvp294LcRiWLYu9DO9eypdEUhuKNvVT/Fh1uoNdFV3axTNjBHF?=
 =?us-ascii?Q?yrZO9LB/oJq1janNjGLp6JBANnWlqwQwA1i75u9q8m4l/RR5J8XuUwFn6ruu?=
 =?us-ascii?Q?OGiEnLQfsjbzesrGoCJNYWzvV0JR+qyoTaWVq6tuikrzGJFCpYZfLrl/CeRa?=
 =?us-ascii?Q?VWfv8d+nHf1SHt2greYhELL1As3jv7jWLydSBlwxT/HrIyt+x2SlHkJ8lYFk?=
 =?us-ascii?Q?dzOT+HQEeM1dkqD5G5HGthlT4oTeI5QBzBHSfoMOST79cBimjI/NuENAxm9p?=
 =?us-ascii?Q?FWbDgfciMjVIUcaVEYtiArHOZoMjbhGfO6JLFen110RyXzAhcIxonjrePApt?=
 =?us-ascii?Q?xvTcgExsTMdTTFgx4Chl2KGZwtWx8VvltVIAzXoqzcN7OV8d/fr6zv9fuPox?=
 =?us-ascii?Q?6ihBkwVjUC8wJ4/IlvReJWNK+PAQbOR7Ysi+YI05BRuByc/MWi/IhRzNE0Yu?=
 =?us-ascii?Q?8Pn9bIlLESmH/6wvGYSQeYiBEoauNaEUgkMH9D/9daTX7f0iphMEZI/uSRc7?=
 =?us-ascii?Q?SDzbwhMjAlw9WcO4koUvSTGBo8ouKm54xb1aKIqA0C2NCOxsKEZI5UZuoizP?=
 =?us-ascii?Q?3KYpocsObCIslAy+p9EGmWT+7X5naJPyP7KxbxC/tTs5oumyRfIT/K4Pa+NX?=
 =?us-ascii?Q?/gH/2UOtMIvbKCA6VAnlpi0goXtE0fgAeuqB8VVm+Vtcw3GD+VO0OrtSUO0J?=
 =?us-ascii?Q?XiBWCyq+/vUGwPv6VD5MWYHj9t/lAaUcvQjOIUZI5/SGYvrKESKcvP9Z6ybw?=
 =?us-ascii?Q?FRYJQlKZaKdtRDF4Jlu4a3Bowr+rVcdzkT+e4chhv3UsdstFf+ewURTMh0qI?=
 =?us-ascii?Q?WCsCBRtIevrX+Ss/XtierWHWsEpOxkZGvXRrZgr4uqd1WTXUMMyRPwa1x6aA?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d389f57-08b3-44b8-d0ec-08daade8e4ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:35:00.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S3LkWMKycq/FE7iD9tGzxs3ZWz5C5KT4UitOdd/if29WlbTMtVu7nvU/fI16y0p184vnk+DCg5ul5I+bDS+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 949e053e980c..b2724426676e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -32,12 +38,14 @@ void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
+	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

