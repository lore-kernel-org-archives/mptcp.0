Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610C323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaXQkhu3h0rYU9hhDnZ4Cs3ijrCjNZI4ueHBpipazdgwiL9dkq4wzG3UqMGA7ffXCjiQzTJfoGXBb+xNXiyLorCqVCF2xyCHjn83bfu6hIM9jC8N+6Cssdj4WI376wyYmIvNLITJfBwJVRyb2zeAn4P+v9o82WbhdzxXJNzH4vzFiHY8Lh4HCp1hUcJgMLJqVJ8ngJKsYhRmgG2vu6SUzwNP/Zn6+2uRVZgIhVjOuVkUli/hYZnp8LN7OpKVMCcZiTyU+/FVMh1ikbjyCKLJu2sj9WwoAYCqGyUSV5Lc/9FCyKGWuaduaCrCbCdCG4nKoj8Vvdb42StnQ2ZUE9ALXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=Seq1BqY21nCFHP20NIeOjSrcETXG5VSps3sj7EWEwqhnat3MnXS9q1Ymi3U8sPl26dM9R0mBbQdX1RYOP43pjGMpQSPHUD/I4p4rSswdd9po/EQ4igEzaBaOrQceJvALM1+zmRmreMf+xKRwNZJZ9NgAn1ILlYQz9acIq2E0hL/9qKQUQl7E7mE6v0nUxIePDg5fLy0Si7d/7R8qNF5eG+keUNuDd1R/mjEFz5Hwx53r3FO/FJeIK7Vox4qjTgjZPl25IQ+SEWWkAxta8DjsGGPAYZk+jqfrOGtlQQWo/HwDLU7IarnUFcHaQLwECgjD09h+Rrhgwm/2iJZs6bQM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=tt5gVsvfF/21fh3Kkuw5wQZ3tC3j31SQ3GzRP2LYyBEfa0W1evM4qpqacPl7SC7lsCNcroM0SbLaWJcEqDkHKuSKBYgjvTMBWSAoI7pZVG79MHp4hadOBdKcRmj5CEzZY509nNNQ8LVquEFViiIQgPfnIf7T5TBwZh47auTgdIUq33CKdVeA4EGEtuLgUgXxOjhIlcRkvlvTxvwGKvVfY5kkICsejib9Zf4iO/82w4CRkbQfuST0NsLUw4TayUHtNoeyIyUNr6f+whUg9g7LFF5olcxGDlXh7miBP6aENnjYyzp3H5s8a7REVy8ltuouj2XP3ckGjerf6V0RqG0amQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:46:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 14/15] selftests/bpf: Add bpf_red scheduler
Date: Tue,  8 Nov 2022 14:45:13 +0800
Message-Id: <05a82bdcb32cc4a5a0c78ab116ec0ab8ba937623.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5970af-26c4-4ee1-9b4a-08dac154f76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gthM6/ITfKVkWCViO77tSeHL9Puq5d4biJBLum/codPgfQWMXyXwHF5daHbTrLt6D1/xME7pfy6EZiKv3aL/8/RwcBviFgmnO1mfEzKA9m4HMN5KMazb+RMDMl4lyK9Cr5nqLwokWkDhaalqw8p32Flyi8fLYL1pGYmLwLEUZi1QjeJjKW8dhqT67YkTYWT00UOLi5+aoukgkobfEbFq6HdCxrFLY5cFaILj9W+1bJDx+Deqnuma3Ln/KmgkRx3ozB34jrnMmIrF3yJOa9n/lvEUyXv1qjHXhbxTNcD8UQBlq2hoKkPDIVGxJe33g6x2rN6Ryz86/ADakqFKSellYbU1Gtg5bf7P4vw9e/wbJURL1X6eDbfgHeK5rO13V8W7SDl7gi6euO9URpCs6774oW2nIkCuZ+6wMLRfzhhbrCBI2gqVPo2r9HxcZXosmS0245kHrp0nczZ6hcSjMoz84y4I2F/IiaZwK3Cudj0rRedSs0ofzuCaJAvKeSqk8Igq7C8BqAys3T3zKqOkrbvqvgkZiA2fWvZC5os3qUiuN+B+LlYOZ2MXxijMfneHpmyyd0RjdsGQjYyV1rFfgsEj7HsgVID8/3ngVBpBeZflZAErpvtLjBjday7CFydDtS/xSRVSkobLs/o2DHi282u9oWUY2tNJYv51yNYq11NXuIdlBprbpv74Y5nUI+4Y94SehFOQiaFi2g+AnKXGAqNid14NtU58s06HKIY5IExRWnBv4zQlBdc4tnel0ikd3w2F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOPfbegJiaYfSxSaWfUC7LXoe6WrnBlYfdwtgHNNpjIG405fnWAXKpiwrPPy?=
 =?us-ascii?Q?bpacXs+mGIaC//e4gxWwZ5+QXHvBvOkE7XbcYDcFqVzPX8i2D2jhz2+326dy?=
 =?us-ascii?Q?ielG/NGlahz3VBbIHmbUvkHTZoVXhsk+yEPlpcAtCOSOEhxH67HTXXs5veZe?=
 =?us-ascii?Q?egpCh6RpLRhsBHPg79qxwfwjhE1n5YMLwK+I5W6W+kNesciM0f1pLD16Cpw6?=
 =?us-ascii?Q?8P1X9/oO6/TVhav09rl9FWW/rgL8ESLNPKO8loZyDbzBDLNZ0OtWQoERFPd6?=
 =?us-ascii?Q?6umFj+XVdHOMGqX0zmeGg4iPYu1uE+xrwfgR/2XRlrzB7Tkr6Gfg0mEuhsar?=
 =?us-ascii?Q?fVShoM7AoUHsuaRED7wnZIkoCmqemCnAMUfNepKNqdDIR9BIqGDWAYgN1SG0?=
 =?us-ascii?Q?0kE1we40c+NbBZa0zWhaTNxrcfPkTr0/P8LYhHExUQp0vF5AoIbklNIxmc6E?=
 =?us-ascii?Q?a3KZflMyR1gIXPXXWpRSzfqk89CKPZAf8MNZui8LJR86kZh79gYoni3rviTT?=
 =?us-ascii?Q?omcJp1CnmpTLHSGqTEZoIMIn2HCbP298ilIP/w78/G/A+irRiau8GmquSOTB?=
 =?us-ascii?Q?EVeBhbMBmyu+eVUgqPvvyG+ZVR9I90jLK9JXthhp8kVr8LcxT0EmA0keMHiN?=
 =?us-ascii?Q?BQnBw4lHLmpMj9es+jtQqCyD1ZSP6htRZbacB3Yl3h/RyzXcA+DEEZOjmamQ?=
 =?us-ascii?Q?DuYmPE1TdmziwfAPDfz3mwmZrnAYg+UI7hYkOm3+8ZhYNvQq0ZfHMlEgdYrD?=
 =?us-ascii?Q?mRISt4TTqg5rLnISu/M6D3/8HeR0wEzyvVBvH/ui6koERxXU6aHcDim4zLPD?=
 =?us-ascii?Q?0nLIYc7gb5nFaLZSXG82Nt1G8/UD9H+sM2ZDe8AWtW04GZJv+zBSjq6RaHEv?=
 =?us-ascii?Q?nZ2hMg7VlIRqiI6p/Q+ks2owvXw1Dm5QOpWyBHNPVPiPbMj0Ixs9YcpUTNG2?=
 =?us-ascii?Q?Xakoe0+VzzDlEuoyOsI+zGer7+xQG52pybaW+YwbRFAFPCPa702q1qwF3dQb?=
 =?us-ascii?Q?wDr7RVXUEQbD60sPGh1gPY/zngdnyMNLbsfun+L9wnpNDJfBf4kRbG4XGh1S?=
 =?us-ascii?Q?C017E2oWMbTQDUT5eaEE8l3aZtsYGWCuWGQ368gCRpeIDVDVKVwhZHWYQne8?=
 =?us-ascii?Q?ggz6Znt4Mue9lLCpAVmGCc/KYeoVgPb3qlZBpD9S1ZPPzTFebciFIM6cqJ3f?=
 =?us-ascii?Q?jKSVz5xbnMctKf5TMlCz6IB+BMSD+virGvNy1S4j5yeaKneLZDtgfT0WYeqc?=
 =?us-ascii?Q?A1n2UM6jnpIhGbGdcX83xKRF/wvmWpf+5eAT4x7ZzW754TDhPFC7VnKVysUs?=
 =?us-ascii?Q?AZ6RsGTV6wVqTG/w+kprM2KYdEmZCNjoY+CKJbKXj8+GGqPNfEHZBF1zFCJW?=
 =?us-ascii?Q?kIEEIfpKwaarewULEsVg5kPeJ/VQEBAmO/kBetkPGLlpkIwAgaMw1eehMMDW?=
 =?us-ascii?Q?/ACRPlZWUGPv5DvK5LNtMwUia3YLUyBXLV2eo7SXtaYy/WhNWipbJwRGFaur?=
 =?us-ascii?Q?/EZavy1+am8ncW+YRo0ElkCO9HOTFet45azV4bC6oO42BgiHjGXBEokh0On/?=
 =?us-ascii?Q?gw2xbFqxrtkxcsXt/Kec5YqsNXQuBstlwMkegHW4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5970af-26c4-4ee1-9b4a-08dac154f76b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:30.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvwjfEIaWxi7uWznLp6NQ74d675mCy+DIOLzL6gR6SHSFs4T2bB7XTYSmfIi5NhtB2d2T5w92BOhJJ5X91DQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..30dd6f521b7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,45 @@
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
+void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.data_init	= (void *)bpf_red_data_init,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

