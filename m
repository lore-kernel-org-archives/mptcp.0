Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D9190
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn1jnMZwE8akwdwmMRUQp66CqZzLc8QyCrM8OG7IEm+ZPDW4fpbM/3zz0ZNbDai/lFdj4DRqncxc2NPSMsZj86bqb4Rdh6/L8+RDk1uiGt1LRSXN52uq8OELdKgUSwn866n0NBwWi1y0kx+Ybd18D5QvesgLMLqwKaF2tnbHfE7TgrzJrj/eMAe/5Zbn+53B6Kn5HZJxkX/ErYFzVYl6PdvfPuxXyMPVfuj34NGTu3mpnrOiEb/X3ndaF+Tz3pEkUSxMS8n2fLrHTZPcfGFkfVf9TBXOv25KMtRNHrhaa+4jjjHGQQeDkRbhIxZYj3t8ZsmivrkJFFYW0AexjsEhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Ro9XRc4QMXxeS35DjM+OwsCfuaHyAD1TxDPyPZFtI=;
 b=K1+e0u4FgNbKuZDWCWekGvsaQYRntCbzAHuyODvgc4dLHbbemG5KqCGj77hwAYkJYsQS6Maft/92IL755vsyIrWdPXLeMLx9/JEa66Vyr9F9EZ7zSSCusJy7XwXMzfsYBKhoSigB07CelYgHzEO5znpYbKmh7ly5wQAVa1TlQPadTdwt8OeM7dUWmZffX0ETUC7TpvCNV6YBOLwjQw1aR1s0ytLGARjAEtIB5rx0Im4wuLZgvqAisjASR67DFVhAizno38224wBscXRXlJEiQWaiZA1DQjehNyT5+aytHKIu0lp80jQ0eGvcgWTx4gqGrAD6aKlTFEgLYE1ZJGSsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Ro9XRc4QMXxeS35DjM+OwsCfuaHyAD1TxDPyPZFtI=;
 b=eZkUsq5Mq2Tqtcn1FCpP4WICGbeAV7cF7sL9qWF+ilfS0eq4nZIiMiUOq+1UfJb79oIpb1QxGSsZLgnBcLQKNZoms/3wn2tXl8VmBKdm42BpJLTD9gAN5ZGddQkmhz58/IZN+hn95wIbSsrVJDH0ETVY+uJmYwLtIrbyiQqLLuAbVhLC5Rd0CEfGhP5MC5AfqzuUKX8lVTg7OrJ4Gnz5HHe4keeHZvoaFc5IG81lvG2Fg0xq1TZHrtbkO03AB+jFiZP2IJmazZY/7euYoI2caBdVFJQClSD0PLwXSfNAXv2N2wxZwSUEyY4KSdJWeV2g5cqw/L0/N7Sf2v3J1q+FMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:47:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:47:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 17/18] selftests/bpf: Add bpf_stale scheduler
Date: Tue,  6 Jun 2023 14:45:16 +0800
Message-Id: <7fc9f1871a0df06843c9657dafa15fe8076c6993.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: a57475ef-968f-44a7-6798-08db6659da31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bFu9QU78K5Rsj184CLUDIuoUUCqIoA44RAknNdPPMPDP3kL9SCpurZxj8yL/a3RbPyPObs8FPgT1+JRTgmA5N6sJdCl178f1NTS+DOqyI23x4n8YTgnDGzzKVmz5/+XKY6n+1zrdRF7EeYXrb0CUma4woxD31UKNwoIdYaj4/uZM6/+QE2XPLOaGQ1WDhAzN/Nn5paKB9Zf9zbpCKUIrbKgFuyHd8NbRx83WVcHJbcLa03EsvEVjka1rWFn3u2RHc+SPf2ReRklFlrQNdl4tXEpjq30CTUjhhj+4erLVVL7mWm1e5toznj+eDGDox0e0LovZQBFas2f29gGe835KJNfdFsXAonKojRatux/8BL3Ie+A+EbNzgimwRJOLFsTA086wt0hgKgu+2JLElnzPm1VoxYRv/yzA/ghtmUqzpm7DqR7iWpxWu9hnMGItV6dqVUZBSTvojUW14R7CjwCaJTsZ0c53RU+BrZ2LEcgjQb+MehFCN0xbz4UUH7+aQviAlMOTYIw64seosNr7b2mKMu2fb4B+ZwhwilS9A07EvD5HpCjMRpmVsriCuXdvgDvi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(136003)(396003)(376002)(346002)(451199021)(478600001)(8936002)(5660300002)(4326008)(8676002)(44832011)(36756003)(2906002)(86362001)(66476007)(66556008)(316002)(66946007)(6916009)(6506007)(38100700002)(41300700001)(2616005)(107886003)(6512007)(186003)(26005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6vxKJpWYZl2DPmZk6DBaxnUDrBy8fq1MyqhYGGF+nPcHOABF8E1QYkKsOY8?=
 =?us-ascii?Q?Z8fg0FJA5w+NHYl2V3V75dvsa3KXFaQRRAARee6PwCKBfe2RukKtJ1I2Rczd?=
 =?us-ascii?Q?Ps10KJaLaJSXw8yEptSksXZnByurGRSnb6j+zD75N/z8WH8Mj8CwiTCum6gZ?=
 =?us-ascii?Q?3Rmv/5IJveFSjMW39AVBAiA9nYXMSayyzqN12jKFi8CEuVtTt8wclBEz/76D?=
 =?us-ascii?Q?hvjPG5jvbIfSdVZTFR+GgNUbXC4jTPrqY7zgxFXEdjJpMSLOTGIE49QWcVnr?=
 =?us-ascii?Q?v141OTiK2vmUYjAL3JXQa8t9KDk9il0LfagrhgH2Q8eZl9phT42XCMepSlui?=
 =?us-ascii?Q?f2t56s1UGP+bJh4zClutZ9kpUhwbKdp9y/FeFpcGh7/2jeszCJc/QRWFfffJ?=
 =?us-ascii?Q?JHODWpnHgKXRqsfvnB7AFeSt1lnHXgwNjJg2S2AnHpW73XDMqTcSjdkEkGwG?=
 =?us-ascii?Q?cSNzWaJJovOaCq/O6HFEt4WLd/k621+QwNgpAAIezz29CarhyPGSPgMX+fuA?=
 =?us-ascii?Q?+kA+w5UtelBNP1GN5nC7KMoBCmx2xciWDfavhkMd6nUJ5svMEnRh34c9Pl1U?=
 =?us-ascii?Q?H9SQ+NRrI2LsfMrTZb54JNYPD4ou3NCTk1Alru4Y5b5TfWaedI+g4iJG+vNN?=
 =?us-ascii?Q?56SYh4tQRuIDFjPpoTwWJcL98E7MPZxRqPAQ+pIsK8m3LYdKoEQ/h1HBekH9?=
 =?us-ascii?Q?B3w5ygas24KJ3CI3AEQQgmB5IIv089UwrmX3qTHhkdJtSY2cF2+z/HCSGxfS?=
 =?us-ascii?Q?YmZmktX0im17aEWQY2N+ECTAYUWi3SpffaF4RuHXzus36fprWfW+lPW/Pndb?=
 =?us-ascii?Q?ibIAMhXzdrJzVpx3hvkTbaNLlDf5rJk5bio2FPzxQ7jlQqk2vpVLGDZMDIv0?=
 =?us-ascii?Q?BSbWARVRFMfX4IZtCYn+2hJj4yR41HHiyD6xJ5MiO6bqzlKT9H9RISi8651l?=
 =?us-ascii?Q?f8TitaFL4nVnYf/aBpz/HSQr8y5aLK4dqnmAqwHXLO7OhatoAPYFwzaow5rq?=
 =?us-ascii?Q?wE/axEiUdXKab1MaI9yVd4aA/tMfwx+NOLavU2EaKOYeFEbe69SDBcmMqTCe?=
 =?us-ascii?Q?6NDg5GO5a5Q8q/6TJEZGvCwqPZdy7XpdY98h8PtDCTVtRcRktfKECPtYfj58?=
 =?us-ascii?Q?AXzySFYlC0ueMMJcYdx5GJ6Ee8PIY0ApvD2O9CHkSpA94C+EUkYPh+3sGV+Z?=
 =?us-ascii?Q?8+IQZ2GlCaH/jJ/lRhAQuCKSo3AkQ+yvW2PkIhHUghqjtsNxfR0q0hPplNpa?=
 =?us-ascii?Q?UG6RJFBsR82z4yiNDkgEUm02j6i3FkP+K7Gg72XLo2wwDt0sc2buB/jqAyeG?=
 =?us-ascii?Q?YYrgwsriRtcfRxJpuByuRZfPriNYldGoNLh2SD7n99X/qRjiqbt9YUyCo91s?=
 =?us-ascii?Q?9G8sxEh0+CFJdZiX8UD0sAyJQjCIirKHx2AW8jjVwuA6EfAdhtDW6nkBi/Mn?=
 =?us-ascii?Q?ZIXxh1H565P2Kv8hfkjJTr9rWxZ+mC/fNmRIZBFEM1a4LOPpH0eneQcjUsKC?=
 =?us-ascii?Q?5JuEHUmXrp0Y1yz8WL/LjRIT+xnKyzfL7aFmG1wky/Cyvfo1GOGuaFQ1e+5F?=
 =?us-ascii?Q?jROktd7RIWxHNOLVGErfY7Q0jhv5ZbMJmZVPuMvV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57475ef-968f-44a7-6798-08db6659da31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:47:10.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCkoC8hegCB50Gk/pL5MOQbKO8VXBdQaWLWZSoBKZPb73w0p/hL1Az9V/DRHDYAqtH+imTvbD4CV/9ijhIppLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 2c35cbe05d33..9fef10fa8aa6 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -236,7 +236,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 
 struct mptcp_subflow_context {
 	unsigned long avg_pacing_rate;
-	__u32	backup : 1;
+	__u32	backup : 1,
+		stale : 1;
 	__u8	stale_count;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..125e84a1e49e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+static void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+				    int stale)
+{
+	subflow->stale = stale;
+}
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+	if (data->contexts[1])
+		mptcp_subflow_set_stale(data->contexts[1], 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	int nr = 0;
+
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], stale))
+			break;
+
+		nr = i;
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
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

