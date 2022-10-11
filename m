Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EC3207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyqzx4Kx7ypn9QfAgHpmRypXhk+G7rNne2xTCV0X3FcKqXsh6oxzYAc1USb9jQVviPYuVFoW09vyTHxsxR12fvX2JquSKRJWFZxwq6DvAZMOJut5wNeFLLg5v4MXlBUme+bF39eKC47mjLljVG3edFKoSAytCBZ/owbfNd6bV0hPsg42ZFUUelho/b3HwXcJ/LILyg7SylEWwcbYGxBE8xMPppxbFAITTX5KL1P8bw9Pt3+5bZDIRW6XfCgU+MQPoqsoix/Mj/ZRbbu0J3FlTd1pGwoCFu0XKEN4crkUWmbaidZ1pkEAifHXlk1X1PjiitgJzFIvdU9Aas9wBkOBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NAzwtDFbpIUwHwByLTGsCfexGOXk1N8mJzhLu2sZHQ=;
 b=l9jEeXIRG8+xw4JyZZuEYVGToA1Aae3qzLsYtUiNBcXcSm+KR8AU+QE+DeIXNxvvUcd0W008Dqq6ycEu31qPfjjlq5vmpkCp8PbNy6SuxzrWJreAfGjXlxMU6NUSs2pATdXREVoYWK5iuS1MzYQqSPstx+iBBw3GhWORHXuKX2k1aRi8+CTiqF7biT2BeQjIQdUeNDsooOXCLxUNLOijWCs45IyCTCg3sXpW1bEGOPB10GdseWJ/IbpOqE1uM/t2Y2QOxt+h5UaZk7lf/wdbKts7pfX1Zp/0P/VYyIvwBiHf2YL9z0oMGNG3fuEl0se5Ptbsq1LyTiExIUI7RcFTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAzwtDFbpIUwHwByLTGsCfexGOXk1N8mJzhLu2sZHQ=;
 b=zzyN4gIGp2EA2ORWVU4FzVZkmjaeVCailgl6h0pGoVumIkGmYK2NbkKWcFjX5giTNk/v6Vqgqce1r3n2e93f3rssUsdfTk4lpphw2j81VarL3NH9/ZKUoubm769bc4DSPjtFEwh1zlKw32+zZLsu9koM2910E4yfXFRZwLYAtZ9AI7GKDTX1ABjv8WmkDXlv34NLMbTcRAaILt1XXijE3HEQ+6m7yKAT8gQcV/BtMOdgXuNGIEOXGrfg+HFHxH2DfGV8/4BPGUE4oXTmmByp8rAEV32CuA5SQCaag64qY8iuhuSPXkGuSJkxUNvZyYjfLkhtfV1tCDnT4aYEOt2Dag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:03:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:03:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 13/13] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Tue, 11 Oct 2022 20:01:37 +0800
Message-Id: <20221011120137.5475-14-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0039.apcprd06.prod.outlook.com
 (2603:1096:404:2e::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f64538-8305-4a9c-cff4-08daab808bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L2zV7rTJIc44UGUkOqq+GlsxksEwoW2gAZUkpRgT1Nc4yo8O0TFKVTFRuIVvW4ycYsnF9oXJ5MTRgh/qX1amq51P9Q74glkqBOSFnz4Y9GBV7HU9Qot5y9yKK/UuhSUD0T5Ojws+CjH3tqJqmlMCnYH5vPQ5MRFYxZaiCkrI5Knp+MIY1QxTAMBWPZszU4Z6YoJLc8DnUoI7fp9SvexMTzAbIDkF68Hb+n8dMxYi1PTDUSVLyiBfRvZDoxlST/7xfAd5CSgsm3IOnBXmbKs41zRtyyribC5SL3XvPutjMNUSkCzzDsdgpf0y5+0PoYJarXMFKE6G8G89OEy+hCo1PzFeiNvxrTBhSXRyjdPYw/8SbDJ8ayizxuDwnEFm+qUjuGNnUx4Zwswl7QsY/O3+W2e5M5nq/IdmFb9hhTyKobN1EIzw/Wuy7PQN0zghoBsfHUKKKPh8pKfVBCDF0ts5TD2LGtbs2N7ASZw4/XFCIiU0vQh30/Ox3sO0Vb8fZcj5j/NxiezroyrdEYUSabhfDl3jNMmE9AnWF5hrg1OQv/d0msXwzJ/NARi3NqhPt7NZJw3ZSrho4xbXiAggxtHqZQVquVscRSuDzOSuWa/z7tPnz7+BDPNeDYYrRZKW17HdmKVhwrEAkvo3o5RmbSxr0M2rv5GL+YL+GqVCRtOYC2YsSZkivqqgFxQRdyxN9SIj0kvTHjD+VZMM9SrgbFig/PCV31v9L7Ob0QxLUGUqjO1mOSvRwLyQS6M9mx4+Y/pr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0c2Xjxzi0BVUDarCDxtPR9gEW77/yLrG+EhaTo8iEHpp9xhjrUlLjVN+2Dx?=
 =?us-ascii?Q?eXCqtNIDXJQ7n+5Xh8EEmc9dpZuM6DVjswpM0v1zD7+Y0ejPT8w2ao+Wp9dU?=
 =?us-ascii?Q?5nreWvk8XIxau9Lr8BDE5Ju0GVqPt1rqwwvIo9adSdjVZw9jBA2t3mTt0rzU?=
 =?us-ascii?Q?RNI1BbFs8vv3rE9fKhYmiM1jB6KaTOsUB0RI9sCfH+ZchGwq8fYaoNhe3OPr?=
 =?us-ascii?Q?6sQxGlsw6zoOb6m4KZq9+MiAdtu3f6nU2pYRHV+NO/ANLjIXfobWLoRXdc42?=
 =?us-ascii?Q?VjKE2EhdRaPGdFaShx2JtKj6e74KvVLNgd6Ad1MftasiaY+/G8R0tngZ0SqC?=
 =?us-ascii?Q?FIIkM+7haGZ8iiiPGBmgVkDGKlbRbTfVome3L4ZCnOPUgc5D8qSI++zKqsFm?=
 =?us-ascii?Q?0idMHed6WD+JQ5Y5AZOVJQtJGn2ZtpiFP4jH/qPrW8RluzHa9HS21h5uWaNc?=
 =?us-ascii?Q?wfwfZBsuLS4Hpghzd9RyQ+PMsLwTdDXh3x3WyTC0C94V/k7d/ya20x3LYBy8?=
 =?us-ascii?Q?8XCKLb3cm8VT9dkFdjltBHGExEaHyU97K2iCRtDn5t8Cvem9f8xx5z0u9Fu+?=
 =?us-ascii?Q?epBblk9/o841boJvVv+Z0mxpcT2Sw69s1o7KY0i/OvBNWKXeT7IbXdZSxN2W?=
 =?us-ascii?Q?/qiepJrH1Sxzq6hTk0x0SAPHJCWYbzsxapkspHgfXeaaOdBF7GWzU1ts0fJR?=
 =?us-ascii?Q?Gq1QKcIjmCTY/CeUPbf4sdCiaN0k6vh0qd5eQWAEB72Gqa1rQYAIxoHjZIEc?=
 =?us-ascii?Q?xgE5PQSBxbLW+FpzFgyX/almmdRNuMaIFy2yLew9j+7hEov1yHWKXsxh2wCM?=
 =?us-ascii?Q?KjgmFSSrcDieeql1pY5Re6gPrt3+slzJdRO8/IL6OL+FxRDNoRT0BSfYeyu4?=
 =?us-ascii?Q?fMPIlwk5LdGODU+j07v89Cj2dAEglgReEadh5oLjG5XhtvbWlqioh8PqXctO?=
 =?us-ascii?Q?tCXerlXMmvLrsOovFC6UrOdA36xaxUwuYbL3qDeRI0Hs0xRPOZAh65N1I5vl?=
 =?us-ascii?Q?ByUFT//UJqLlgiBQoj7aVi2Rf/M7wA0beCabqkcrRO8lCuLZ65Kw6rYGsK+U?=
 =?us-ascii?Q?wbP994v469uNySgvykfuZgmsoen1pjFfeHB6fYbT9ci2ndF/H+djYxz6TpiS?=
 =?us-ascii?Q?O6E8nyniO8zBanXrCucwOwilWCsHCovXfT+/S+f00yraaji8glKJjoHLhKGQ?=
 =?us-ascii?Q?NANUhWrPycfSGNal/L5ylB8ZVefx41ryRFL2GJsJYvVID7Ax5M0XLw9N0wmG?=
 =?us-ascii?Q?xuCwgIW0XUXqZPMYrrJH21bRIKaWh4aXbIf4pArg1sUARvlok8fidxxxpSB4?=
 =?us-ascii?Q?BWvXj3TyRXnB8IMJSI5n0HaWAdklnu82bLZ7Nb259V3ikvV/QW1ycDqyxIB1?=
 =?us-ascii?Q?i20mU1PamQbKnCf8imARc3ugh+znFpvAx4MGCIJhP0NJmD26LcJuzoPQpk0K?=
 =?us-ascii?Q?LSWRrmEB6zbEzGCrzJCDpVe1zsJ59pkdDDbM9JeYRhqQCzbMgbvuv1cKQSfd?=
 =?us-ascii?Q?1kpEbisOxS1SgW8X2FOyQx0kBdILT6gWAODP39vVzcYPLdK2xAGSCmUIaAhN?=
 =?us-ascii?Q?RF1hLFWO26PiffhK1TbkU2IoiBTRbKOaBDvCCPPLcUeY7iI7BjyQ+PFKA9qE?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f64538-8305-4a9c-cff4-08daab808bf3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:03:01.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2bNlsVe0hmw7wRgDPLDrEJ91DDOCHJHPe2vl8YtUSR5grp8KwT7cILTMiLR7NM8W6mctYk01YZdchx2/JFMkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

Use last_snd instead of msk->last_snd, then last_snd of struct
mptcp_sock could be removed.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..c8792e6f125a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,7 +257,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..b7156f6aae8b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -5,6 +5,7 @@
 #include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
+struct sock *last_snd = NULL;
 
 SEC("struct_ops/mptcp_sched_rr_init")
 void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
@@ -22,10 +23,10 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
@@ -35,6 +36,7 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	last_snd = data->contexts[nr]->tcp_sock;
 }
 
 SEC(".struct_ops")
-- 
2.35.3

