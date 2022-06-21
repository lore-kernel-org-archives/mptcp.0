Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50089.outbound.protection.outlook.com [40.107.5.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34685EA4
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5YUGM8p9PpSKvlgmpmHvYS4SQlWTzsnjIuQiF7RoyRXwO9EZdE/c+tgHunbxZ+R3H3+2JQSWAxWcBAS1cSTdWLZBhl81Tx5YTS4Jzn0KoKUR8ZzOT86q9R25ERbZkD/OicU6dg1woHetLdlBKiSjX42mM6SpIs9qObyO1KgrQPwsc+Lg/u/HXSzcX9UjW1wSQ+IF2gO0k/3sbKZ330ZSD3Xh11hRPe2sAAtb1GWffU0VajhuMbXGpvGQ1s7xOoT2CWTOUCOy+Dt7ijNoWn2T6YKiwUmMWNfm8NvgXxHkLJq98DQ3f9WB6h84YYHvZaiMD4DJdrKe7pPSpbQKiV12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=gWSbGrNSJHH7g+fQsHFExNMHDFB+rGmttk1x/NzFVq3mWRTU06Nm7pL4aCF3wL6hoZk0e6EXxQgrQJtOITQxYDsRrEY6djQhFCqZ5iDz/qxuTQgH/yF94Hfn757wQ1Eb8ztJ1v1W11x0C1zgoCuoV/FqsrY+hS/RZNoBa2Jpq6RZU1OJdn4R+/e5itjy0L6SzUEny1Qib7ToWdAFABJNlEV3/vTT6M9OU5NX9xxFU7qv7PqVQ6Qk/XpiJyMfVNb35kTiQqoQWMfghF+kouz9pE9ewIv0E06elkUx6RvWgmF4LoIS8mW8o7WDRyMYqaK/Ds6GhCxTviKQnzLm0AqUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=STLNde7COewSRdmJ3HwrddTS8XBgOhSAepsBIQ1p406/8YleJqFeV7tM5rrdScPAqsb3MvohVV7+cQX7c6Qnv7uijcwrWRlQtpObwHVykPTklaJPY32/62WWLh9RUII7vuqsKm96jN2vd8+2QSp/sJnfYlYiqWIt4EW2x8GAsyeapmkYRj+Y6n4jAo8yy9iPueJaK1MGzqSGrt775dFqXYt5mdmHQfjP51D/6n6RQorflmj/4hJpdeXQg6HheGXFM/3/kAdI2cLJe6igcQGiebvx9ltBliVDtBIHTpY1EGNFgkQvw0xGSl7y2aNWuORC7S5fQtu8/L0AANDP3Q+yRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 09:54:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 09:54:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 4/5] selftests/bpf: Add bpf_red scheduler
Date: Tue, 21 Jun 2022 17:54:18 +0800
Message-Id: <cec95a0e848d8e85e0674ed4d8e952ec607774fa.1655804700.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655804700.git.geliang.tang@suse.com>
References: <cover.1655804700.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6358f5e1-0148-4497-1fc5-08da536c0fd3
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB942735B0761378B0321EB334F8B39@DB9PR04MB9427.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ndtahuL0wUMIcI0c7ULVmw0q6+eBiUOhEXbqVzemI7Ksnr+uhy1vaDwo6EovfE2uHwjDqlrjQZhEk2XpPs26Lq/X3U503JXPbuFn713/kQW0E+6+gj6C8FQxMrZg/7dsbqkw6qSCHQ7trUSsjsHqnNb7bte/xapFWDT09CZ6IK8npFsgy3Jwraiun39lMmwsiAysuhFPEug55eU4jMV70y9IG8/mvihh91siohod2rsC6osKXNI+zWWK9PaZN+qZ8odw6JKPhNFZViHk4mwUBI7zPfLx0Tqsvg2mQZzfVqhGxaS3bvMjVFI7RBC5lu8eOXvABTU5UN/SRT9v2dXvnTz/Q72Dgf3IPHOEuF0zY1PbpvSyzcs9t1qGy6dhPBmr1umX9lA2leV0YXKUv2NrB5bW0XkwpN/k1wGqABy2lJroBxR3Su9b59gkDlCgXFc2833/5UExsMoPZvi04X6ok45dwBXuRer4fcjLm3gRjjvDdSGmSHXvJFpR9dha/owySop72zmHgoQDungoLgqksGBwZEmflU1vmFeY+t2p+uGtRoM0Zdekgn6tqVTqNULNKEZwsY2Z0TMG8a9j3A9mQeeI5GP8sZySvniF3AGuxPCLfcQq9ZX2A1qK2sgVosgi9Ycqy1H/3AuG//rCd7VupTBEsQ6nH1/FdFYutvrbiUkqRcI5vWT2qeADm80YHzPsV1M/BpJ71tho/Qnnf8g2mg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6486002)(6506007)(5660300002)(6666004)(44832011)(478600001)(8936002)(36756003)(38100700002)(186003)(86362001)(41300700001)(316002)(107886003)(6916009)(66556008)(66476007)(66946007)(2616005)(8676002)(6512007)(4326008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXI3whm17Bhir7t4ddS9TbMlKkwDW4uWNuzU7Qr6+KZSIcOSEEVrMpZOZGUC?=
 =?us-ascii?Q?jn/vUJYQvdC/dL8zxg5uPqSbvV14fBrUSbyuGGECnCAqVtgRSDaRaLElN618?=
 =?us-ascii?Q?VDkPBtkF8zBDZ5n6cTIIy17Y0OIG5IPg9Rn8BR+ebjFnWq0WDcRQNSiWInZF?=
 =?us-ascii?Q?2YnGyDXLZTJN2eyQl3+sROnGzxU4J8U6CS2mYMKtXPKo7QVXUYVUVRYPUSrn?=
 =?us-ascii?Q?oRGDQ8U6JqW+E5+Kc/NZd6AEg0EC9is3Ed+ZEVkbgAs3EVHZ6xObU3dFzav6?=
 =?us-ascii?Q?xmEMFOs8SOxw45TE22TzjM1cF8GAlUqEUilcUln+pDE3Vm/dyGsmdCR7PBr8?=
 =?us-ascii?Q?jS6IC0uv2SEbfAIdAHaRnMxqHzs/iaZRXves7N3V2tsa7/mmf4WAm4vl3yj2?=
 =?us-ascii?Q?G5TxR9SVAg5t3nZAS4QvOLl/6MqK2m6USgMRcXUV80kg9vvhk4SDRKm346Kt?=
 =?us-ascii?Q?av8LB3rzHpj37jEOQaLAWPU9VEolAR9oRG3xdbGJFt93ywp2h6xgFQWUDLsn?=
 =?us-ascii?Q?+XW08FatwSOkNNgM5AW6mlFCKwJkTS+tfYta80FZwX8d/sGck3fOt6P0i+HC?=
 =?us-ascii?Q?77ulEXaNubgTnvysIu7ZTa9oqTk3EyB49h9UMmWgaP6JHICBH7sIuXJVFsZQ?=
 =?us-ascii?Q?qwhlPELFC0AA66mXzAieR2k8jH3V8CvHPoJ6L9+XOZWS+Mq4hNmPsfXakuEP?=
 =?us-ascii?Q?vtb9kJ6IbemlUQvvxPcSjsqCUO1aucsL6S2vgghwbao34tTU01htzcrU/a2H?=
 =?us-ascii?Q?2TdxULQhILqIrh418EKmWImnzMa1Lx//BQxFw54RhdMQFItGLTrqk2O7mVtY?=
 =?us-ascii?Q?tw+JrZAChELt0QU0O7lnOFeij4QzE89rAgWP7I5n9OcV3dkZR3+O4rrB6mYr?=
 =?us-ascii?Q?SaxvgCsLpkElannRhNi1TpTWpH0irUcHi+jKgW52V8Mx3kGHN2raFS1/9ku7?=
 =?us-ascii?Q?ZG24G4ILDo84TesOIjrjwKaOycMDymzSRdiIbLJfBdFI6U4eHLdlsX+0oCdf?=
 =?us-ascii?Q?1fOoY7fJ0tRGwd/X3EJL2d9FhnWzQHEXsaNR4yXIg+LEU78w0NTJ03fypeJK?=
 =?us-ascii?Q?FevAhH0m7nnZQYOWEpoB8bfXrs1qGTDpU+GEUYeIDz8dEEtd9ibVRL48R/ZI?=
 =?us-ascii?Q?FUsvecC8cn7x0Swi2JoMS0xpV6Ya38oALNhbBfGMA8sMfKfUkFQA4wR6eYx3?=
 =?us-ascii?Q?ci7I7rv8iLaq0dRzTMGcJrKkff5A2iBXsfP4oly0vBtlsgxe8zeWXizR0UXQ?=
 =?us-ascii?Q?Zvol4IgUys6pbAkuqJHBhsz9JkmZSdlOJU5e+aTBaPeR17VWQfVqiizDtCGX?=
 =?us-ascii?Q?+2smj5gSPQ0ujJx/7HNtl8deyV1N5CWZedEZAQhAuFtYvdZHoeL/vdajOf/y?=
 =?us-ascii?Q?7wm3gqQ1ZtQsmAp7a+3gyxOCBX8h1KyGShJ/rN1ifO7pEYRHpmuDWLSdPgSc?=
 =?us-ascii?Q?jcfbk2K2XPzn33XBfx6ZAsdEr7RoJirCak84DNqQ8HsEkZhLMvW45av6TIdv?=
 =?us-ascii?Q?VbozdYmxbdEQ9UzWj0I6IsJEM0xyjgUonmqPOVrxRn3vYLHboKnIYG+B08Xw?=
 =?us-ascii?Q?lXjX+vR6pCPTCYeqKHjS/ksc+gwphqBbtb69DmRy0QZMIsq3x7qcjLbF87le?=
 =?us-ascii?Q?EvwfH/6MNBl95ttPlH4AZcJJPLFJpsSeo8qr6RCb7IuFMoubIxzzZQsDI4LR?=
 =?us-ascii?Q?fzayU2b18RCxEOs/mSwOC7/EqkXjohsP3OjMOD071bbluQfREv9TkcPIYNBJ?=
 =?us-ascii?Q?ztJC47AiPFaW21IwDTLz5Mf/Uvb2Aho=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6358f5e1-0148-4497-1fc5-08da536c0fd3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:54:41.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psiu/lAGQnsUrcrKIxI5IT9feyNeSLRwq20iJMQ0+YcbSllAczaofvRwF3RjJ9Ts0lrUTSIFS3rS4lkH4h8A8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..58f90473e495
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,36 @@
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
+	.name		= "bpf_red",
+};
-- 
2.35.3

