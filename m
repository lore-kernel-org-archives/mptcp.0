Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D28125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX3T9NQsjDj9sAtcicrPm1XZgskGRG6/J2Pd9cZefnJZlG5Bpmftlo2ooN2/hDofNbaUYl37QAtq5xW8P/pNEPWLK/t6qWecxbmC78yfgdwshy9l+IPghPu6PW7fbPiIPBTPH8i4WIRBOOwySvKOGVlt4MKHTBbesN3ZFLLDgU478WmftWhKFw77lswYzx22Uv9TIuxhacCg4v/IVdTOClokzMBA8GPlM0ctmUxySBICPRvbKAmG7IjLn40PZENMGEuJR03RcK5/9WTGVzxxHOAsctSL1NU1EgmMmuPdu+W2oVluNVRfA3iP4plG4jUlNSZGfQhkzJmbArceoOQTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNOwNZqlxpyY7gKJPyKr1k6xOtjGxNKITbt3yJsp7Hg=;
 b=d7zbMoNUgNeMLOvf+Xx6iE2qBcBRilyScfoBS9tr72DRH1MEqe18CAJBHI9C9Kt9cnhJU5TlWy4Z7HJtlLRt3Oh16BDq0gm+Bs2XhEjHbyXhlbgihQz9emeM8iu4r0j9B4GksNyqxb3pc+m3Cd89iXsaPfCLNBy560KlvnKiOcEoyi0Ni4GR9AKqtFZpzifKZQVPwJu3TTaBtKKYs6NYJ5Gubpv9T7hulN9HMSV0x/0oUrCclYbwT4ypC5dfVwpJgDKrU+pI31gcQN+2pE65b08iuQ2OMWVMHWrqQD9n12JiD4uBKvapL4rDl94kWiOtkcE3nLCXJ5kmNzE2nejcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNOwNZqlxpyY7gKJPyKr1k6xOtjGxNKITbt3yJsp7Hg=;
 b=eSbcNVWVVnsrthNIBlmFFlO3/YeFog46wIIvfSfGNVYkL8wSsV8/UBPicfT9JliIgXYq2P5a0tFb0wmGVqgaiQ0yrQwA0E6EchRLW75O44CLjRvKqp5fnq8UlprOKCJ5m03XjmF0bgh0V67k/0ggZvAnbuwgEktu26bwTdxOszn382sYmc9DU9WitDQ1CxcEsnCDVq6fw6U3LOJ9zVbD7mzN62EHS/2Epnt+kJ1i3Gmh0km30e+THfceI8HWlyEkxpwf5rnwyDgQqB0AKgFpCfVAgAB94pC0x/iLE1TnW31tgwOVeHTlFJ1IFbpC7E6M6eCExyvjtlDfic8EZElokw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:02:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:02:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 14/18] selftests/bpf: Add bpf_burst scheduler
Date: Tue,  6 Jun 2023 16:59:28 +0800
Message-Id: <ec8ff726c759d5a2c01975e2081ad0ffd17d9e06.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: a66e85e9-b945-4aa2-2f73-08db666cc182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XA0kaYXriwvdPMjWL7QyNJIdnILMOAecaTbyH1OkwquTaW80eoYFHPznuxf2WIiFCI6f0D0YVTvo5UCXBvbV9wCKRz8N1+B6cskRnUHXZp6rUpvXSLsGbgOX1Aqh7sUq+DdMQlKVUMurMEH3Nusx10Br+b356hFTJuLRLy5tRIgB/71ulXpEBbpP1LU5vxc/G1dA4A+BM1cfI/bLZ1LB27lprC6Bu71wWkYQAkMlWrzUCyNM0ZTiYATiY1BXOSuYDPegyuGjegHybj7RBOGpr98B535QMbhHsLU1mWNwTuprGs3pKFtrH/tcYz7hElbclG4lqZXDUjh/s8ftAyozJimJUGy7bg1FWtc5mfpkaZm4mU9waHqscTU1dexfPgtj8c5RB1xTP3aaGyy0ykQiAwR6FOcQBeyF0d3wOreAkYj9wdbCc2HUqkhTlBHAryAX9s/wng1w/uXfhHpujf85JEaRA1YgpB2OzyeckpthCnRiHK8SlkWHT7PPUJD2awUoQGnTkka8tbLgs5ZpNAKT0sgc7nebHWIOqRcSTaaSD2ASajEb8HgO82Zctzb7Xmno
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(83380400001)(186003)(2906002)(2616005)(86362001)(36756003)(38100700002)(6486002)(316002)(41300700001)(6506007)(5660300002)(107886003)(8676002)(8936002)(478600001)(66556008)(66476007)(6916009)(66946007)(4326008)(6512007)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9mqMh0KE2Chs8e2Xgsr/Z9idPsZFDJh0FWrbt8tvf98D3cfgPq1qzd+ySxZ?=
 =?us-ascii?Q?72ZFDWD3DhkGkySVWD/4k7b/5WCoyQe2q52l0HJAVZ5TYEQpdp54oIe+eOZw?=
 =?us-ascii?Q?IuqCXs1/QtsYNfyp2K5q5GPxg+7ZEEVSv0gZPucFRrVtKRc+IOTqbnEy7LyQ?=
 =?us-ascii?Q?S/JYCFo7MN8bA3D32p0VLlHFjW0k2bMtsnMbwfhDbRTYssesFszn1IY09df2?=
 =?us-ascii?Q?cbiar9UKABLzbHNc+UI2bqqmVgPWeLkPg74DjHdIx6pM4AxQ7jfBnaEYqxyB?=
 =?us-ascii?Q?9U3eUAlrCXCk5XD/HnXTIt46lbQ6ypBZgETy/BWmunBZO59t3XlUla3WnffE?=
 =?us-ascii?Q?Ttq5YH0l6lv6XqjR2lgq7w2u9IOsa/j9ki6KUyIPPIT6p3x5a2dvmb7hN2BH?=
 =?us-ascii?Q?q0TAzXplG7Gua5WJc6SNpuIa5WjfsC7JEY4U7zjF9jVNvudaZ40Gz/VHfSbH?=
 =?us-ascii?Q?I33MBQxU+5ByyjK2Hgz8dzgO/j22rG/f+MUq1Po9fXIz8RIGl+wCtSC1yHPl?=
 =?us-ascii?Q?u3Tbavfl5Vk82tPy6FYK9oZ0rvX4D+UlkBpiO3JxVjwDp9RtvlvvVt3ykQbv?=
 =?us-ascii?Q?/EQ45Ncx1K3wBC8VfQCHqL7PcKOMPoXNRep52xjdQWroWYgguvZ8Uc4KE1Rd?=
 =?us-ascii?Q?34K4ofzGaHvRcMvbga+yfZh5D2XE/alE9S2Wmm0HunXAkeqf2oBRzkG8r6WE?=
 =?us-ascii?Q?+52/TWBN5XhlKC24kOMn0mqaNolfrn0wfXprYG2TTqu9s5s2yUxjpFqm1BJP?=
 =?us-ascii?Q?FukJceo0FT+jFAE2OdAJ+tpfNoIN1hL5GhQK5Geza98Rlh3H4fKpdVSgvimL?=
 =?us-ascii?Q?/r1yK56n3h4EWKfY1oREFPZ3nGMtiat9SBcujPciCWPzTxpXxdX2gOH3EH+E?=
 =?us-ascii?Q?5cZXUw4a5N/cGmHvgyVjAFB4ayKsvol0HAv/noQX5MWyPJztzXSK8rc5ngzQ?=
 =?us-ascii?Q?Pnl3RE/5rBQsobO94Q5zXESgosxKpfo26tzE/Fnup/F+m+np3BUQpFA3BDpk?=
 =?us-ascii?Q?A4oKjUVEMOg8FkmtqnVSycNxmwi7ZQLyrSkQ1O+CWOA/rHPk7eVYF8plJEOb?=
 =?us-ascii?Q?1mPWlGavoc185VVdJU+YWBLrgNbRBGP4NSZd+0POxlmJSymbw68dBAoxNHZ5?=
 =?us-ascii?Q?h3a+9pWiQSM7X4rUdOL8tfmxEzAjWaWAkfgQKp84VRYPJC3RFP/pe3OdXk2q?=
 =?us-ascii?Q?j0usvQ3SX5sqJiOx7f897bY9ESdc8mG9Wl2BrHXFcTEwqgKvIig6UF/HXfAa?=
 =?us-ascii?Q?0Y75e1A/GBKyK6ykZsyH2hvnhz4VlPHJ/onK06piXvrdQhT2tz9o1wIYCbts?=
 =?us-ascii?Q?oooZQ+klMObfh51IBbH0W5J1Dh1MoEUuOHwEGYGTwwaA7sxrb8TYSOo+iLw8?=
 =?us-ascii?Q?+VhtslRJmdZaKFSKyMdzKO+hC5VBY/WDblVykn3oByqY8gAJzkxrQdYrKfmg?=
 =?us-ascii?Q?5IRuzXgxbbHFlgN7IcRkDuiuXD2wmQhcx1i21rgsC0OwiSRKjOcNc1q52pSn?=
 =?us-ascii?Q?S73DGmN1TY/6RPQl2yRXFrc/cTiqBu7yQTV+7m11Tp5G9nLiZVhMKERhL/PJ?=
 =?us-ascii?Q?sag/b6y4GOCVgXwj35MCGxi+/Pbd3VRaFlnE1pDv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66e85e9-b945-4aa2-2f73-08db666cc182
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:02:29.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtRV91u0NO57p2D/iVKnN/G0VZ2lv3FYSNY3/cgq2MUin2fxUTc1yCCqMXTWr5z4IdCfC7nx9X9wL9yLsurplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998

This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
which is the default scheduler in protocol.c. bpf_burst_get_send() uses
the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
uses the same logic as mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 216 ++++++++++++++++++
 2 files changed, 221 insertions(+)
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
index 000000000000..c45dc1ccad1a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -0,0 +1,216 @@
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
+static struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(struct sock *ssk, struct mptcp_sched_data *data)
+{
+	int i, nr = 0;
+
+	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!ssk || data->contexts[i])
+			break;
+
+		if (data->contexts[i]->tcp_sock == ssk) {
+			nr = i;
+			break;
+		}
+	}
+
+	return data->contexts[nr];
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
+	subflow = bpf_mptcp_subflow_ctx(ssk, data);
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
+	struct sock *backup = NULL, *pick = NULL;
+	struct mptcp_subflow_context *subflow;
+	int min_stale_count = INT_MAX;
+	struct sock *ssk;
+	int i;
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
+		goto out;
+	pick = min_stale_count > 1 ? backup : NULL;
+
+out:
+	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx(pick, data), true);
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

