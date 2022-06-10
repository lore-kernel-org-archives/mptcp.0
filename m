Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DF7A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDdVmu7JF9FaQTuiTwN9b2Fjr6K3hkKZQZnqwW+CkDnPEI3pS0ZesU2gmUgIAdxj0air8DPJB60LlPOGqn+W/a2HUXT3ELznVz6H6ZILtqN7Jd0D3FD5Zj753YvYnxJNI4EY8rAkDkMQ2HfxRzxazDznPDiAITr018ORU8z6x84ejZkUkf+6SGQSS12BJoz6AHYJMoNrUGtJxDQMIZh/mZBVANTNAbniUXJdAkSMwjG1/AguK0zN+hYHWr/2gx2OcA1PyKsBI2HYiC2AM7fGajA2A+i85ztz4TsliKv1DzD56vPUNWgfNR5lZmpkcRXpTI6LyW6fziZU68bXl149JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD/hiDlJ52z8ttz0eoV469FO5fEXYqXBe+l/EsYolp4=;
 b=d+NA18GsGV4PHARdbKRxvX6O6cFR/sGjlqKb74vDtZLe9FWbVaeIEtm8pMi5sucNNekDKTUknncJYTX9I44HtjNYTU4gCp3Qj5CSAbUTA0fLeP1slZFRmHtj6YTo3lH+y6UkKCZpXyvbdzj2wWe30gJfu1HoJWvask8oRKvxeNk699zjyiN7xOHzhN3f6NmbSo7DV1+2AdNYDhg+sJ2Ju/3Qmpyf5SbmlHjqOocsAlvTmLblsPw387yWXfNO+cm2IJUQiEpP3LG2dvtjGFZTJjOwmOxRiFUhetC64hP8M6F8weRAzR8xXWc/2suit9bq+EXYA6eOpz1/rspV+UbIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD/hiDlJ52z8ttz0eoV469FO5fEXYqXBe+l/EsYolp4=;
 b=BLL7qzSemI3mcG+XUD7/AM23ipNtHgUZMpwZIYLF85mSNFaSXLz5ORCT/zlqvRE/LYCUbC1HqsiV7Fdw67BV7ranthsDU8sZPiLoKS81cSUYlrM+d8ybK47OYShI3Wu+RxuvyYaIvh2Izwgr7VyrH89Eq+aLxTUkv920EiEZ292QdPSdMIYLui64Qyp9uBQIqSQWMQU3jVYwGs5hnWQgKGcJpU1Cgg99FUtiinLqAYcOHMKMMVxKrZgOaXkGZdGLgUgtaEYeiBxYjT+MlsjZGG97WYlWcuQIH9s260qVlMezgLd6lIGGqb1c63BvFluB35BmRN7KkYGr5+fdg7SB8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 8/9] selftests/bpf: Add bpf_red scheduler
Date: Fri, 10 Jun 2022 21:05:33 +0800
Message-Id: <95951276b9af1983c94f8e20a28d04cf3271a659.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ea0c97-1dc5-4252-9dac-08da4ae21404
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2725BA30715517BEFC5A7B02F8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	extKAdKrM/X42IV+ox7YCqtnAM8Mz9y1afIlLqk/QMm2XipXmYpSGqidPtcU04ePHw4H33p5xX89NdezVZCNQgmV5DzsL0UasKDtUytYlKgPQ4bLnystvAk54aDRYhKQc2BLterqPOb4bN1uQAzdMIKTtCeZlIDvI+/4lsmjlZgB38NDXZUjg6EI/uCTvspuJ9fgC4IXUKDl+pOxDyJsxy2nQGmOgh4TN7lpUkVTX2I5xbQRYs/Eva77uelpze/ncR9Y/E1j+hGSW+IHx47nZb+QtgfNMVLiM6KnUDxGLukG49H4jUA/vGWd/7O/gwj09Qgpp9opl/XMuyjxNHw5Fj/4kKnM4bUtgGMgvfkvlODiwJQKW/Tc3Ka07PoFyfisv+BhG1j2d2doPFGaJNtcL5pqFXwruUWZnr3LM+lOTLweMasdveD/doVLcd2yuJL8TKPLstc5yw0VtZVlY5YlJaUIo1jBF62Mnv7I05QDAwyTeng/Kt67131joqPfYWjI0vxazeEa4uEg+o1vbk1Z6K45ka/NP16Cup+xq1rxoMJa7BwEt1FKURGnJX1yz+vnYURLjfCs4r/UzJo/b9mMBiKwI3DPJMThNAVeuIi21LN+PKHPzOPRcAf6EmxchqTukCFZJ+Jfx+rRfPQdvJHg4t8I1L9MBpHG2RW4a5URZx398Jz0DMJP0w8bmeXF7s+j8aV4pOp6xcWq+CL1Nq3XRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(44832011)(86362001)(6486002)(508600001)(6506007)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtkVzhRlLuVJdMMACCql7KlINO7P12ehVKWXaKNuO0uER03OuoK+fuhcGo72?=
 =?us-ascii?Q?H3PIJEx0TvblY1KVAQSJ+U7PuSGJ54f1MCxkMxdcb7uw8ipxir9LYwkcJoEU?=
 =?us-ascii?Q?wUUf99E4CsSet4UW3BXAapCV+QqRDiihHWhG320bA3sAQwJ5VPYo1dIp9S0z?=
 =?us-ascii?Q?sl2GM9Wak9pt6nBLsSfws3BsBReBRBviFHQb/fXaJRx3nXMseOuScjCx/tFA?=
 =?us-ascii?Q?GwQwuiTh9UJOrI/qoGDDHspPO02RIxL0qllCP6pwXm7pZwvnDAcVdtZNScAl?=
 =?us-ascii?Q?rQR8ltJ/wJemC5lOWsq4aUkXR7foXhSwhV0gVZghZkgCqno4ssseJ+3Bj7io?=
 =?us-ascii?Q?GdSDBJO3gT96rYwKAgFjV3xC8k8DyL2kQJNuKh3fqik7rZsO0ynY9AcO8b/X?=
 =?us-ascii?Q?46pUg4zgVo1I7rj0RGYT5ploFq+hqwy+spOdHDefYEapgWQ5qYUvr9oWLvBe?=
 =?us-ascii?Q?6qa+Fmrfs7/AwATt9LaKkjz9ic8NnpwPAhy2QG1g/CpucXzdsXYZDXZ30vxW?=
 =?us-ascii?Q?H28RQzpqKSrvkf+mtuCAwKxxM8FO8y6OBiVSSTGwH6992RjWd/BjLHWHmMsp?=
 =?us-ascii?Q?q0TXM3TlO/YbLmh8vz6eO6Nq4aSTDS7OHjzJfbXg6h6/3ZV2mkieJHaYYeFr?=
 =?us-ascii?Q?xJh7HyHXhtWKWiXGTV4GClwVStZ58d94dOB65twlKQqIdnf8wXUXnmvlBdn8?=
 =?us-ascii?Q?7QbNhlwCnG0ZqKAM6ur5KtSOsFxST7Xo9hEBzRRmoccGRKKCllPXI6lW6dr6?=
 =?us-ascii?Q?bZKlMYkM+CYxvjvh9pGPwVvbOjZeJ3A9vFlcQQ+B9J+za2N4rTvYHJtFyXcW?=
 =?us-ascii?Q?N+Fetet1DArq9KKooKLsV3QsTzbbFSz7Qy2U3x7fgFQIKZpz7HrpyTJNjGRn?=
 =?us-ascii?Q?P3ecbwI/XVs0srLxX50UFEoRBHkOLHx88NiXAkIydABLxqVV8mxtWFBjvidt?=
 =?us-ascii?Q?ZE0kH37NNLtLo1qiDUdo18rRmRP9fJv+J4qc192qDEL7Go4tgG/nmx0xFmbe?=
 =?us-ascii?Q?wlVfrR7RHLi0mk9vFpsolB7VC9gQsy/qunN68/4m27gW5Ct5uUmN0O7JXELf?=
 =?us-ascii?Q?Wsy9kAoWu6uVLyQOm2sAQqH+8kxY97bl5qLWRQNQl6cw36mBE+ui4w3C2ywn?=
 =?us-ascii?Q?n7pHbc0FQnC6FqzQdt/lkpz90K2LJXWujMO4wZ1rN7vp7S+EWJb7MNZfsz0E?=
 =?us-ascii?Q?NRD33nooogczJ1Hn8sGZTIhXq3YU9aUZexyVTN1LhHj04mIN61QmwC7tSAL3?=
 =?us-ascii?Q?h52pnrCl48NmXjBQbA8S9mLkr0x+LYFQNrGq3//k9+1ANDkcmt0qhVKj+MQD?=
 =?us-ascii?Q?liq0DR33Is71WS56zZGAMj7k+Nzd4qK/h4RO+tdLG+3YJ3DWcBp94WMs7dgq?=
 =?us-ascii?Q?CrfqkauGN/WTpZKGY7vTSfqEXqKcApipQz8+5Pp8wABemj2NNRhui+6bQ5g6?=
 =?us-ascii?Q?V25/Foq3c/Q9FEsmIqtPmPICQTwkGd/vhjBJpj1gofTvnXdwXVHoML4GbPMB?=
 =?us-ascii?Q?nfMouX2z2XoF3wtsq9/axiKFgJBQVFOh04V8BqXwVu2s0HZt2xUYyb+1NgGk?=
 =?us-ascii?Q?Ij4ZC9HkkDBKqoNfPafSBEiiRzeZ+sf2TXXZF3FvbN8s0djHaeMmSNfNU3QG?=
 =?us-ascii?Q?NnfkN6CPOp444Qhcozl0Yp5lE4J3h2GwSxfipP2Mdq17Satf8uU1CbqqeMa1?=
 =?us-ascii?Q?lsw+sw+LAnNxgGbJSf2LmDkgukxErLfBoLPLfvjkcMIJNPSu37hemq9y7ie4?=
 =?us-ascii?Q?JCz5/846ai7IHG7mfvNY/LPtJBDjYMo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ea0c97-1dc5-4252-9dac-08da4ae21404
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:48.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C5cHn4YU86k37H6UKAi8jHjjcK64bxmOunfyElI0TfJz5mfaW+pz51VTOzzaEcgQn52oHmo2PBX9px83r4ZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..8592c881471b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.redundant	= 1,
+	.name		= "bpf_red",
+};
-- 
2.35.3

