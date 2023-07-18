Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE491842
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUpy6KDLYBQifAkkhLHjcH9/wXejZiiqAUmakYkomwWI2iVcUQRKd5UOqV6lFtfDIcohe/EMBvXQl0cUCULT73l+UXvc5sImiN39FudoGTpYViSNcLMvnaz46iXlTasaXyPIRpJO2fdPQ61OGQRhmcv4jNEoLClkcSef1sJBvppadoddfodiyWrNusgRkjkxhCyiqjqj+oz3xLKoSqWZ3buKjpkx9QZ1+iARpWnDwjpLjPjtab6/eDGIXy91TP/JWONrzL9tc++TgRLljXmgzo7XrAeWtKbOCzS9ZkgCsxFNhvbgawo1i2Fwo1xinvdwJXX4n10oiGrjiSgDdVWEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb23Lm8/TR+/gk22kbMKw3rkwiX66kCLtJucq7TMiaA=;
 b=lmkvQoj6cdqqPNzvDRmEMailCqTcZZDb+YUTAPhuXp2F6BoG/x4IePpX01J4OMPwNorADuMiEyql2SJsDPv5oOMjLLm1SbYnDg+t0tjZ8IlA8KH6RIIyd0uX33emNuV7C+R3SqgEMc/qbxYFnoXUiYyEsDu72dOp9pfL0QEY7UHKj1uBURJWwD5Pvl8140KwX+KByiO0OjSOFYAqVJqqA+Z6Z7scIL89JhInDHiCP/hiVXhe0TgOE9cWrS6PWTptxT7bM1YTH+kaPqIPyeZ6rNg7dBIKDn3qGwXsDusOEbBzFwameLUeBjUq4ICdmTC69v9gRXC7A24MTAgZyirVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb23Lm8/TR+/gk22kbMKw3rkwiX66kCLtJucq7TMiaA=;
 b=2onGL1pv0muDPxqEynAUaU1yZgNWA8HMOzTgw+sBAytMXNCX9c2noPr4+F1lRf/Q2AE+l4oQK9E7fHOl1wGBoQZ/5HimpGqlR6N4NBVrodSJ6IIT7LweBXYoLrjVK2VwvPHWeSJZlXWQ3ZCFB2MvLEl28G+hKx1XYn7sqycFzyhE6ReydFR2df3pmHo7wGI/c3E2+IE9zLF0+/zFUWcsZFqWzyhPCtnKdCSQVRD2FCpN1gmCR8G83VkFykkPIi1dqdbDbM9AbWWJEqPT3eYhjDstPCalA5f4QETGfhtuuZS/yeWa/O8QeAy+eK8oZQG0zjd31hJZd/rPPktNCfSeDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:38:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:38:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/13] selftests/bpf: Add bpf_stale scheduler
Date: Tue, 18 Jul 2023 11:36:46 +0800
Message-Id: <28c69f6bfb68d978ba15c9ceeee2600e21f6b3f6.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0716eae5-7780-43ba-d54a-08db87406a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yREnQwesjYEc5CUfCByQz6+3Qnwz/Lc7KivNIkCqlEaVcEKdRZGgb6s0fzVuU5EHSYwnNsMqwsa0MBl8SKXT9Hkxvr/mzjJGw52E+k882DW9hVUDQci270wdsZZ1nlSzDepjkrngVySONKlYRZ7cUwwl8pYAI0BZ3NnTT3DU2ajKsUbPoARSGiwN+7nlsZBichDIq3HNIP64teEJfHudcG5s1N+HhhMT5n5ZHmxPeDQCSGr+O1E5i5OjDo4tDM5feHklZpAmWDQ9tjOkDo0BBd7UN74lshHlepmdsFYqi1nb5MzjKA/KAeVA3ch5DmFl971fpUC9KJo+E411J2Fmlll7h3laAWZk9+T5hTtiWhuBGleJdlDo9kqXjKYiM6rMS1wKNGYJBRXuGSDki82MR6pk3vuqRV8STPI2uuu9JUDpItwkpGNXITdLnkwLHydrwStqcR5vfyem7Nmirx9RzuVWUU/rDN0SLC2QmCnLosnoPWA0K5D0Syp/0b5Hjuj4QkqE/obdgPbqAk3F4l5EAfU2HtBMdza7zC2curXS9ku4HLtKcDYHjuTwpJeKSSSaVXIZbOJoI+xegQzZtFa55VkeR5Muk34D3KMTDeDJ66U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KkMpCVj+e3z1FB+MYLUygGr8VlbdyD7DHmFH0RIvnJZgwc/9p7AzP9nnMTHI?=
 =?us-ascii?Q?NcZLhlos/jUBwQk+ncKFPl7VU3oDpAk/PAatO8rtyupRz7OD/1BqObvR7Cai?=
 =?us-ascii?Q?aKg0YEVMkcbb30Gqwo88TDBI05jljDzLnOxv8l8IFY/xpQwXT4NrfZqwFFjv?=
 =?us-ascii?Q?PhzIQSNUzRgZl9lUMp+Ve9ZERGplUqbxP26c5R0sj/kj0zkt65WkjFCADuDO?=
 =?us-ascii?Q?jZVGf3w3I11amaCV3f3GylZFemadypuL8A3fmTlzUeSwXMxrlKTg4CQ8z+7o?=
 =?us-ascii?Q?6vfiuMDjlHzvor9KIuTNWPbTGAtevpgkqCp3Fvbd1DrpIRuBaqsWtKtYsCes?=
 =?us-ascii?Q?59SnJwVh3L7vSbWbCVYBc566oAVJjk/KkOGDf76LJBoEb7P3XnCc1dCKB/iA?=
 =?us-ascii?Q?JsoNkMYeGZcJvkm91WExd2k8fTrt4p9iSfwIQI1uhTG0eiwHH4suoJbEzqhq?=
 =?us-ascii?Q?+uJXa3hCflHeRAbIS7g/qrNY7V4kazNUKQtjo6vIubawQdaJ8MKtYBmEejDk?=
 =?us-ascii?Q?8qqD50B8wAPz2iGwrthPRrvQ12fotRQSyBU7RNjaPiKXLhBNQNaETdUvnr+g?=
 =?us-ascii?Q?k/6fOBmxT16khyLzIU33jJH46advKCLEuyzadMqFiqGf6h3NK07RyUF+U2iE?=
 =?us-ascii?Q?aliGcI6RVg4a5VjDv8uGFP3YvC0fLv6k5tkr8ENCsbB+eN70SX0PLQJsWECB?=
 =?us-ascii?Q?HET/Os0dfJPPPyRI19vuPFI+29P45VVCdqbKaHtQLHXL+x7Z98rM3RDgxGNw?=
 =?us-ascii?Q?5kxluviHkdf4z9/spzxaQmrwc+Q1HdUqdyNP7tcofV4eUU7fwtv7I8x1Byt5?=
 =?us-ascii?Q?Jd9zXs0IRTwRjBJNMaSQuxr4FqdKPH+kMtf1RAJmJPUSqJUC2KsX9DjDgTpQ?=
 =?us-ascii?Q?j2ShlklUnoRlWHd85EegrJqgjECEGzkUUIRIA17cTYXpyjGbsxqcP1H24UXv?=
 =?us-ascii?Q?Uw2g/jyHAmY2nQIlPhjMrih9m9YTo9y/8RoFSUQCxRoRMCewbsdfTOifAiNS?=
 =?us-ascii?Q?ZoRRfyB4m0ChbSy3LwdCXmQJnkR/LowDhTbgYvxnOPAiPxQJiMSyYC/U7asf?=
 =?us-ascii?Q?Lce5mV7do4zB8ofPuPtoV5j89JGlPdFWm08cneZut/1F93HmMrqAalHKQ2eO?=
 =?us-ascii?Q?QLBYYfS2lp1xByAKrzTQanFVa+r1e+LoTdiU8WMf0WctKsqMPiHOFE8EDE9H?=
 =?us-ascii?Q?uWq/MDlVKehqitHqz0T6hlP6NB+EDEMwlQ1RSINMyP+M59Bkpnp35iFdXrVg?=
 =?us-ascii?Q?aqOo8mhJHDMJqzdXFJRMlVvE69NSYP8N6q4fxN4+74C6XvjfQ++xicMbH2lz?=
 =?us-ascii?Q?KGLHXecXvyjR2A5N7GUBk9yLODC3fHhbRbrqF1TOz/CiXzHiD6uK5Uyv7B8K?=
 =?us-ascii?Q?W+khvT3YNU3wJwr55BliwPxIUK/rN4On/lOvsokKc5TMIAF5vw2WV1qaQqub?=
 =?us-ascii?Q?QrpwfaxK8LGbbF1nlC+o6pXUtTtxrBcJC6ZO96pku6WofL2R8q/HrqQMJhP5?=
 =?us-ascii?Q?YmdS5SCJSNafkDXSjCOK+ExmHsy9evZwaFI/Vf3E0yPGvstcUSxJVfNaaZck?=
 =?us-ascii?Q?qh6cNPGnxehe8kGjQrcvrqyOuZmeeWAl/NxhFFUHliEuCyJw0U0gEhq/Rb88?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0716eae5-7780-43ba-d54a-08db87406a88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:38:14.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJT1i9uq5EWZUtCgPwKieZVav0hZ2ycEwBT7pM5JkxOxrBF+tdKU8J2MTo37IzbnmGL9oDNSftNYNAJU8wOKsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 63 +++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 945dd46c98c0..c749940c9103 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,7 +234,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_subflow_context {
-	__u32	backup : 1;
+	__u32	backup : 1,
+		stale : 1;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..e8cc2e0c24b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+				    int stale) __ksym;
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_sched_data_set_contexts(msk, data);
+	subflow = mptcp_subflow_ctx_by_pos(data, 1);
+	if (subflow)
+		mptcp_subflow_set_stale(subflow, 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
+{
+	int nr = -1;
+
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+
+		if (BPF_CORE_READ_BITFIELD_PROBED(subflow, stale))
+			continue;
+
+		nr = i;
+	}
+
+	if (nr != -1)
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops stale = {
+	.init		= (void *)mptcp_sched_stale_init,
+	.release	= (void *)mptcp_sched_stale_release,
+	.data_init	= (void *)bpf_stale_data_init,
+	.get_subflow	= (void *)bpf_stale_get_subflow,
+	.name		= "bpf_stale",
+};
-- 
2.35.3

