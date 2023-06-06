Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24997190
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMiWO/8qW0GevpN3woQW5giN3R81tOYA/xZG9MkpMrlfCfkhEsJGprUpRr0yT4HgQyeJWqPRT+Flq/CFn2o9cSurKnbt0XR6+QHy7wEcFLRkMvfrJUrM3g9r7fIXsn3o2AZesMalo6+Nc0XY6gRL7AVQBXUBKJ/1cUPG0ZLH08/it7kpnE4SZ67o96iW0wDIWBJGzL79uG7A7gHeYhFH49wKd0f5TyvUP3BhSRGlZ2V5LrZ+3rnqP/ciXaIjzVVqdKJXPswhsNvCkIC83IXgr386BdQbbWFQD08eBTQiYaWD4E++Q4K/vGSaB/Y/tuB/6Gz0HZVr264rfzzHclYCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L+1fgeGxbp75sZoe+QVUhm+7LpP+TFCngB8VyGxLdg=;
 b=VL/IC0aTRuGi3+KzQDc1kWo2X9e11LOv6Vf3cdw6+Vf1OfE4/MrrK4oqTxz/6YsLnJgYAqoPmdVVdvPtja8zm2eWLD6usBBpzPR/hBDpSKAjevkz6aFdy+t7UpccpzgBj37nm3Jr1e0Ci2KCNtOYl7aeNnTPNJiKeBGKdm8076fAfeSXppRQemMyu0emB0SOPf1ja8yxz5rj8Vjf6q+iuXlrCuUyftKf5XNkzmGZbCxHJ0w+Jt/BetLunMIMwuuuIdugz8E0uBQMyhxjc6c3K5JzlrdxqqK30WxdYAhijw3v145bjvNgqZWSsXEPdYqd2XrRUSGle1YxESulvM23Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L+1fgeGxbp75sZoe+QVUhm+7LpP+TFCngB8VyGxLdg=;
 b=1FC9IJUb7oNGms2JjXx9PhLNP/ojkW8Pv9nQESupAJOB5Znf5kVgHJdEdOw3AocMa8liN98brcdv6hje9bo3hjDxrMc4zzQLichzqf3I5q5GivgGg4yfEJar8+jJ28hnL9KEADRpWJ4lVCkvIZm3GKk/ug7Hv/lKsgnRm7EL/IMasH2cWdO3BBGNU3pV4jT5Ii8U0zxdAHE5SxkE6ahfMLV1Ci3I9b3lQrWah6QfWPtBs0jEEc48CEPJXBPQ9FeZ65kWq7YR35ycxJZaEIQFebJTE4d6xJ2NbHlONuodpi5KPp/2ndwjC7idqsGtT1TipU/zVGOXZoyNg5dR6yTacA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 14/18] selftests/bpf: Add bpf_burst scheduler
Date: Tue,  6 Jun 2023 14:45:13 +0800
Message-Id: <dd0f78eb1040ea4d5e7c6fa7679f0b875f1c8931.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c87a9e-0c0b-4c02-6715-08db6659cd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S0zdVc3VSrrM3SAIFzO38mg6BlgAsYXQgCyqaoPI5wI89hNHMZjSy9KUktHEc8zalFPBxoJhr6Cb3Ahejv0GbUnxEzGqNJWxxVJWcyeLF5ashRT2WqQGokJUnjUGTgUswaHGk/6PYRpcICulzdsCQ/G0DmbGLlcSKktBEaVsxOq0xeDXA0VDu0VQQJrc8DVZcPzoF3g5MMXU/37OLCD73EllRKQHK6316yHNemX6NTDBxrhJAEs4PF4EI5TpK7CabLMQnPJti80QfRNXKzx34kQlfKZ10vz+BV7gURmNGK9KL22rng8qhUMSvEHn8c2C8umN/ULjdEnxUaB0nVkQvHxH/PghhCnxy0VbMCGEWLoHEp7vLEAQk/JInh3gAYEdbPgFl7uCRycphk5PVC45jfT6KmvPekG8FfGwxkJhsFeAeJg5MBJdzZBcpfNgq3UsPNEgLNwGA56iA7T5A+7MUbHWMNZUdiRCZ2ALJhJuHhQvkeAL1ZmzSam7j3VLfpNF4Q/Dv0khdEN3+NGENN+9CS085obUKkguYm+JQLvQXkRhhJBPcuD83TxarhNblXQ1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mB2HTUupHs5AX0kbbTUyR8L92mIVShqYIVzGIjWQeeGFCmV3pkX9ol2Kjw4T?=
 =?us-ascii?Q?OURpnXp7BZIufwna9Hkxr7fgj9yzIjKBnwoCKzoujueoQyJqIgdTluie1yGf?=
 =?us-ascii?Q?RQ73YUSVXxIVbjgsmBBtwV4PIHrrPxoP5BpJAF7R3EuVK2YWAgMJ9E70Nr4g?=
 =?us-ascii?Q?bdbcz9AVXDESqlOTNEsEYnGNGk6PFUyXSWXXMiMQ5IfQnO/wwUXyxHRQWSrY?=
 =?us-ascii?Q?ryi3WtAbX6xisEfe2GAjB4+Un9qWbnlvqjDyOZc11BvTq/++SaG1zP43UMkk?=
 =?us-ascii?Q?gdlDGFeik4iXp00WIAqBkQEmtY8x8/pZJspyPX7EGjCRBbAbQVsUtQTNBZ2r?=
 =?us-ascii?Q?yWUr+4WeHHj2eTa9GX3OxnJHFP2hYhqfHBUtq6pl5LEwGsPbf2pxBuSIbrBX?=
 =?us-ascii?Q?2a2LeLSGzBQzhJQrNtO5Zb/lXVXupP/v1cKzkCRTtJjom8SEV6O3lMghxYEx?=
 =?us-ascii?Q?CwVJZ7Jp25AV3jlq0+Kn7n5Ucq4txfZ4c/F7vsJjn1/NC02VwQWXUovvJkRZ?=
 =?us-ascii?Q?qoIZHka/hqgnThtvo9JrJX1oaFP70QI5OM0AXDwUBj0eu9uSbmiqnHVChOEc?=
 =?us-ascii?Q?paCdAA1TtDpDu+WBkaeCFwRrpOcEPoGK2vG0SlOIjMBhYa54Q3r6rGXC5JUg?=
 =?us-ascii?Q?L2SyCqhDjdX4W4ItZ2O0Y8/T4JI+V8Mo7gXXbTwQ6ASb35eXlMyyhLidNnXX?=
 =?us-ascii?Q?8mWnTKKMH4140lGCGF9sVIlcsm6Im7jg5RbLB+Sz7ixMN3p9sSH9/EsNu2em?=
 =?us-ascii?Q?CNMVQEAp/i03sXMyTkIRwiZd82ausZWNWc0sIaR5TmgLlOFWILffb7LFajNz?=
 =?us-ascii?Q?2FYUChRzuxaQsnd49pE7bmATc5ORi2Jj5tnjQLW4ZTLDQHlO9/cxXSLCpbN8?=
 =?us-ascii?Q?q0d0fvw4CjNfQX18Pof/FTIdJL9G1pBJB6rdyu//BfslfTYARUMSVM0AaS8j?=
 =?us-ascii?Q?N/SqVK4+q5Y5OZb2ycGvW1/5DsV6PdQm7JSMfFP4ZVUoZ13tbenpMnfQYost?=
 =?us-ascii?Q?1MmbwQrjn+cVi6B+LHJl+JxuYJn0IQVfrO4XZNNDSx7SyvIej70tSD8tSRG1?=
 =?us-ascii?Q?Zz9EXJ67XfNPMvh2Q9eu752tCLtgz+0cMSwCFeas+e7hQye9c4ZAUmjuL7OQ?=
 =?us-ascii?Q?LBfsCXM4lxjGBdPvrucxKGP5bwgQKIsoI+xFGQC/79fzFDmZgWVlPcdA2Q/k?=
 =?us-ascii?Q?DEf9YorBe8I29z2XQNZSrZIdDC/AG3b0IWzKFGuc9tngl9H25fQppkGtTQxF?=
 =?us-ascii?Q?+zdAgpjCj4M6B+0+98gX2wCASdTks9bvdKp/nYHMv9Zg86zf2dDQo/Mdc7Y9?=
 =?us-ascii?Q?mCw8NwiLQKYuO5GKGXkzJKUW9Pqnzbt/ZmgDdr/3tJX694KzNz/4sajpEECl?=
 =?us-ascii?Q?M2M2HBb+7PUv+ciBVGw4iaPxa+wJdVzs05cx6LElFT+o2jr3IfPfSVBj6udD?=
 =?us-ascii?Q?3yadGMvW//ta2pSsI18mh0PGqpy6q/1VYww3KCbUkL1GyWhxPl94FMPEF1VJ?=
 =?us-ascii?Q?j1V1plCgdK9o7tGMEqrHvFpc6c13P8gKTRNaklp2Otq+bhsP8lElXL6ZylQp?=
 =?us-ascii?Q?7x6aA53ZyvaLpZEzj4qiSIvudX3pTSjcIFI6epnA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c87a9e-0c0b-4c02-6715-08db6659cd82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:49.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl8MDwKozg+nImAkW/OE2k2XfEb4FSCGOCSTo2P4PLdOuuUAmLFa1qHxAGovz/oBBOwRvJtjHP1totw7Thvicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
which is the default scheduler in protocol.c. bpf_burst_get_send() uses
the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
uses the same logic as mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 213 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index dddb51a47740..2c35cbe05d33 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -36,6 +36,7 @@ enum sk_pacing {
 struct sock {
 	struct sock_common	__sk_common;
 #define sk_state		__sk_common.skc_state
+	int			sk_wmem_queued;
 	unsigned long		sk_pacing_rate;
 	__u32			sk_pacing_status; /* see enum sk_pacing */
 } __attribute__((preserve_access_index));
@@ -234,12 +235,15 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_subflow_context {
+	unsigned long avg_pacing_rate;
 	__u32	backup : 1;
+	__u8	stale_count;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
 	struct sock	*last_snd;
+	int		snd_burst;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
@@ -260,6 +264,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
+	__u64		snd_nxt;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
new file mode 100644
index 000000000000..1451fb405559
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define MPTCP_SEND_BURST_SIZE	65428
+
+struct subflow_send_info {
+	struct sock *ssk;
+	__u64 linger_time;
+};
+
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return subflow->tcp_sock;
+}
+
+static inline __u64 div_u64_rem(__u64 dividend, __u32 divisor, __u32 *remainder)
+{
+	*remainder = dividend % divisor;
+	return dividend / divisor;
+}
+
+static inline __u64 div_u64(__u64 dividend, __u32 divisor)
+{
+	__u32 remainder;
+
+	return div_u64_rem(dividend, divisor, &remainder);
+}
+
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
+extern long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow) __ksym;
+extern void mptcp_set_timer(struct sock *sk, long tout) __ksym;
+extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
+extern bool bpf_sk_stream_memory_free(struct mptcp_subflow_context *subflow) __ksym;
+extern bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk) __ksym;
+extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
+
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
+SEC("struct_ops/mptcp_sched_burst_init")
+void BPF_PROG(mptcp_sched_burst_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_burst_release")
+void BPF_PROG(mptcp_sched_burst_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_burst_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+static int bpf_burst_get_send(const struct mptcp_sock *msk,
+			      struct mptcp_sched_data *data)
+{
+	struct subflow_send_info send_info[SSK_MODE_MAX];
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	__u32 pace, burst, wmem;
+	int i, nr_active = 0;
+	__u64 linger_time;
+	struct sock *ssk;
+	long tout = 0;
+	int nr = 0;
+
+	/* pick the subflow with the lower wmem/wspace ratio */
+	for (i = 0; i < SSK_MODE_MAX; ++i) {
+		send_info[i].ssk = NULL;
+		send_info[i].linger_time = -1;
+	}
+
+	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		subflow = data->contexts[i];
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		tout = max(tout, mptcp_timeout_from_subflow(subflow));
+		nr_active += !subflow->backup;
+		pace = subflow->avg_pacing_rate;
+		if (!pace) {
+			/* init pacing rate from socket */
+			subflow->avg_pacing_rate = ssk->sk_pacing_rate;
+			pace = subflow->avg_pacing_rate;
+			if (!pace)
+				continue;
+		}
+
+		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
+		if (linger_time < send_info[subflow->backup].linger_time) {
+			send_info[subflow->backup].ssk = ssk;
+			send_info[subflow->backup].linger_time = linger_time;
+		}
+	}
+	mptcp_set_timer(sk, tout);
+
+	/* pick the best backup if no other subflow is active */
+	if (!nr_active)
+		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+
+	ssk = send_info[SSK_MODE_ACTIVE].ssk;
+	if (!ssk)
+		return -1;
+
+	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data->contexts[i]->tcp_sock == ssk) {
+			nr = i;
+			break;
+		}
+	}
+	subflow = data->contexts[nr];
+
+	if (!bpf_sk_stream_memory_free(subflow))
+		return -1;
+
+	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	if (!burst)
+		goto out;
+
+	ssk =  mptcp_subflow_tcp_sock(subflow);
+	wmem = ssk->sk_wmem_queued;
+
+	subflow->avg_pacing_rate = div_u64((__u64)subflow->avg_pacing_rate * wmem +
+					   ssk->sk_pacing_rate * burst,
+					   burst + wmem);
+	data->snd_burst = burst;
+
+out:
+	mptcp_subflow_set_scheduled(subflow, true);
+	return 0;
+}
+
+static int bpf_burst_get_retrans(const struct mptcp_sock *msk,
+				 struct mptcp_sched_data *data)
+{
+	struct sock *backup = NULL, *pick = NULL, *ret = NULL;
+	struct mptcp_subflow_context *subflow;
+	int min_stale_count = INT_MAX;
+	struct sock *ssk;
+	int i, nr = 0;
+
+	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		subflow = data->contexts[i];
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		/* still data outstanding at TCP level? skip this */
+		if (!bpf_tcp_rtx_and_write_queues_empty(ssk)) {
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+			min_stale_count = min(min_stale_count, subflow->stale_count);
+			continue;
+		}
+
+		if (subflow->backup) {
+			if (!backup)
+				backup = ssk;
+			continue;
+		}
+
+		if (!pick)
+			pick = ssk;
+	}
+
+	if (pick)
+		ret = pick;
+	ret = min_stale_count > 1 ? backup : NULL;
+
+	if (ret) {
+		for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+			if (data->contexts[i]->tcp_sock == ret) {
+				nr = i;
+				break;
+			}
+		}
+	}
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
+}
+
+int BPF_STRUCT_OPS(bpf_burst_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	if (data->reinject)
+		return bpf_burst_get_retrans(msk, data);
+	return bpf_burst_get_send(msk, data);
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops burst = {
+	.init		= (void *)mptcp_sched_burst_init,
+	.release	= (void *)mptcp_sched_burst_release,
+	.data_init	= (void *)bpf_burst_data_init,
+	.get_subflow	= (void *)bpf_burst_get_subflow,
+	.name		= "bpf_burst",
+};
-- 
2.35.3

