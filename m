Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A0194
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 12:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXxO62HpDO1QhEJy6vnsSL1iTgCmaJ/57pF4XyE2eNPwGoMuhagnZhfD+V3afXxjnXIH/ejdAjpinNQ0mErfdXcIX0X3hZ7GkHMrnz6Q1EL12WhkKRaZ2ZYsOu4ASlxgEo9WSSDjhiJnBpV4uzpgDm7MwOdvGDQFw6rwlQkDRTcJT/IhcsqJlfodyApbMKQ0CfjtT2+AA65mfRu+jDGmuTrA6uISFI5Hez1uqQ8ntgZ/LubK6MEIJ2Keg70E6smLd+nS2njqu1hM6pR1BkNzgVXuh4t5X0iQiLVMa2W1/iGQdFKu62HUQ2EBKsdwT2dVYx9AEqTIah5s7rMTo0CGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=dQ3dLgBU9mMo2/PUKzUROZbCNH1yoNZn9/mMoCaOVz3mLUqfb9CyL/lj9mtPFgoCOelxV5zOi93/iut065dmYyFOgoliJ4i4A/yw1Y7+KEi/R7Vdu4MoCqjcpNaVL3MIcuUAzvTSdjVzjB5MO3kPwN4x3XjTgTeygU9j2VEd8biGhQgoqnLPcfPN0NAU4x8bBulFmz0Xq97OU/UxsgSigK1l9sytXo1WqOsHR/FI1mqpVd9vPGGr8dxzK4QRGRG/06US37mn/NwKOEKju1mSVH07euCSUN+A4ybXDeku005julddsmS9MOC1WG0nHf6GNHprjvEkBZWvgPBegrd9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=cGQ0nX3u9M/uuygcYmBI+9IGSx55ft33YXA0wzjz027jfhW8BKC59yyKIbVzA+09xUvV15/i+zvd6oCSnTFydytL0bRtkZaHLOTWtCJs5J9s5gKFhiqdh8zYejPsGRNP2oR57i4q0SBCKI8+4pL1JF/xbyH8j1uWljaKE0dqJPSQMLlEmKikxmhC878XuGBYC+XAIXjxerAL7gMLJ59Ttk/7Epv9Xl/w62JRMS7qwBR18D+tU8CQPu0bS3h1NEaedfTGr8Kw6EbyAzsh3WSUwHNvzxEWglptPtunXvkEPXQ6vt+nCLL1zbXXvoj/E9vX+lGMlodXX+oQ2WpCZpErfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 15 Dec
 2022 12:33:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 12:33:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v25 4/5] selftests/bpf: Add bpf_red scheduler
Date: Thu, 15 Dec 2022 20:32:42 +0800
Message-Id: <0fb1835641c64be23fa9840fe1164418fb1fd338.1671107241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 56da7b7f-2641-4f5f-c75b-08dade988423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7TnDpTEbAiE8LATdX1Q7bFf7nGIxg2aX5NJtkZP5c2NPRizUwIl6pYbLhR59vqL+Tq2t2GZRzM7tgGaCRPTXPErwqgCxwUC7iLuVMR/lB2wU9yuIwNqIjjDRKTqFaezgASmnWZkD8+4olC6J5Hwy174CDZFwmYppm/z77CcZut7U+QjAp74ELqX6VQGlvpKMJV9YqhqiK0pFTt2f99fixi/nKnPI7eABoxtSWgs29Yf1klsbHUbtRK07eCMNQ2aJpewsZHX7NmJvtTWKwp3bpeN1bFN09z4eEW4KMK4bCCMCgiSedX2P57NkyHdDtDRhVpNghJdTD0rhjINQOFRk5xh3Cm6GVwKfRaKjIIvzdxNYev+dbSax0hbSgzsDvyuIJgG3/G9jH6KVBnRCR+45iF/QTqhM/NHcsEJ8LVoplkpMRblx8vnf2v8B9TBvh1bqhNkhhBveSmwFzjIF7OjRfhyMMbmCn8f5DXiF8wdwr8a5nh75WEI0tmeP9mhx/LFzZiRqLwgXVxxBBx9WLMLMrl6813DbkQ7TeHRl7cDZx9fHbxLMU9EhDof1wpbJBJqN230xuvRusAE6fc5DeJs7IohVqwa1ZJCigcox9vD9Wo5uofqPakjVG1SUGXSSGWNbBappA1hEB8YVjo9LS7sNfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(26005)(478600001)(5660300002)(6486002)(6506007)(6666004)(107886003)(38100700002)(6512007)(66946007)(6916009)(316002)(66476007)(4326008)(8676002)(186003)(44832011)(2616005)(36756003)(2906002)(8936002)(66556008)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OwNsHXwhZJ8SFL+cY/BIp7cGi3dL2pH2MAZ70ukIGcmK87R3mRIM9Wed20zu?=
 =?us-ascii?Q?L8lY45mh9H1HnpT9QIzUKo5zuQ6cL21Ac2jxM7VfWpFX9VhR5DkxnUjmzYfo?=
 =?us-ascii?Q?yh5UPPmJ3R4HFSTT9+v7KsS0dZ0uy77QMgflfcWHUGsen72HQkbgEhF+cHXy?=
 =?us-ascii?Q?vAPtKWHJ8Dxba/uw8bsADy1lCzYSTDgnXxfwt9r3T/t/FFHr+zqYfrfmrXW2?=
 =?us-ascii?Q?iAIarh03wWaF83mRlElxmszEtIiokk8eL9K3Fsyu0tn8QuDgrydZqDWkq6fp?=
 =?us-ascii?Q?Tqu+svxUGFrtNNAk5hzBDyULOOxcZw0YypfDxua9UP6Hxp++cNSmtxG1t7yY?=
 =?us-ascii?Q?rsBTa6nXyCsiX6jb9y176sOE6wWQfvwZnr11mgf+VNH2nAsPuUkN85rU1Oq7?=
 =?us-ascii?Q?3cLnP/D73AtjB4+WelveOCgBj0t4aZ415pubyheXbrsDt0sGTvuZx+mhttDD?=
 =?us-ascii?Q?MszjmQHsLZ6oLxOsXF6kL9CY9holiTYj1/mg8qDFXvGlcEQ7qxAFiz6+zvNm?=
 =?us-ascii?Q?UpzdyWPj0IRfqc/zlkj1ZLhXH10/yDhzQXOp+3tuxJaG+K4uYxax8SuKwpSk?=
 =?us-ascii?Q?4eztBOs/eGxP5izOKOGDYNClrl4nnD0vrd0etF2sEIT/6R+AVURiGJSsGYDg?=
 =?us-ascii?Q?keFCAYp/nx58LurygoiP0gUtwgTPkM+4xL9ziSCH54cydYcq3gSnlyD5pbgu?=
 =?us-ascii?Q?oXBZS6YhBB+CrNRvu6AElHAZH7bqZa4J4nzcjEElzQmDbDqAnyu2YmSGxMcQ?=
 =?us-ascii?Q?B9ynC3crJpZechoYjk95RU1ro4fIxr9kTk0fcUxRz+iovXV4qBz/4sOg7tu1?=
 =?us-ascii?Q?1qaaMLD3Y7XnpdE+tbvNshj7C0WPSL4cqrYq18C3ZU0SP7CKtvNRACG8W1Kc?=
 =?us-ascii?Q?Xnel6U5W91/Y62gxMvpB2x9QM33tFc85ZrdecF99Q+ph3/71s5p/epxv2crW?=
 =?us-ascii?Q?eKDMS9Ump++0lYxsbmBFcN9i6FR5yQDgugPEFarvN9Fp/FJysWnrjkX7QKH4?=
 =?us-ascii?Q?NZX0Jh/IXCTibLxglsQj17nLDQksZuZmAMJxEIQJBA3PnnFue1Ztz+MYkWky?=
 =?us-ascii?Q?0sqixyoMToo+voFGvyNynOMqIbFcdh6M58mDKRNjM4NMqpPuFqalX1EMucif?=
 =?us-ascii?Q?vvnEtKFw4pXNwrkmpjsdRYSBYqnXk9tq8dIPgsLjiDbsnuzt+kLZlvwpgL3U?=
 =?us-ascii?Q?94riKach+JzmwI84923jcoaUswigRKjndenL5Vmb0Szb5mMjmwWTrNpayV5z?=
 =?us-ascii?Q?0VTu7sLN6t7BKpZqx2/DX9uU4Z4u7G/lF3JMLBsciSHTrd4QvXq0HA2khKYg?=
 =?us-ascii?Q?gomgZN/sQCuYSVWCVnIijPXDooGN14A6j7TVzmQK1liMKwNXlIdK0+BSu6wG?=
 =?us-ascii?Q?FCq8cXXp1n//VZXariIw8ELsOZ9/awc2WM76a3VFTcFo8yYTKj1zs09w7NfA?=
 =?us-ascii?Q?NprCV3fekzSbICIKWfcHPCwGgLwCmMjTOmC7aAJJAw6cpB+T6QZOJbmfJy0b?=
 =?us-ascii?Q?b1rN+8rD7/HRk+A0a/sVShx1Gccgfc5qgZ65fZrycOnrlRiNb6Si+kPAXyPF?=
 =?us-ascii?Q?ohgUd01wz0kAjf396ymS0fhpfaG+ZdPXXlLfJwighaTKV51tLNmVIMVs/bLd?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56da7b7f-2641-4f5f-c75b-08dade988423
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:33:06.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HCSpFSGxEVnij/ycdoWc8WtaNiUpT57P+0YuD0Q7dNKDgiAHKx32A20BjjvKsxfUaYz1BF1v2DMFLBGWT0hRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675

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

