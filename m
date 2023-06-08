Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C220628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBTbSzX8iaqoRD5JwWiz9UmIIow/HG6NGmC4hOLvqSXLhVOe7WrOpucKKnLx1Grdf6yDZ3DxfssaAT3UsF54wCscb4diyCeIRXosKsShImPy32jC4JMUGOzn1UWoQDDqfs1jtZouokqha4MwI4J//PUPLveFZnSE+DH/Qby/0XnlzGTDQFVtePG29xFX2W5q3mixXoIPrtJbzHAZnVSb6gVcAXPxLc4LgDXcxGaG1L2ihEGsm5RpauCRU1YW+BTsyZ5hfSQT+0QQEc4iM1VlP1djtpR9Ly6SonKvTSWNt2klcqabL8oBa4NUvoNp/p2mVpIvyVGiovSDYC55n47WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS3crXFBFTArqbgLO84Z/OigYruzI0BVHAnNXF5xd5M=;
 b=WSrP5ZZbbHNKz/Tp+wvsyVkI38ik9zn8Tqu5rF8a/4rhyZ/l3vg+pvs9AWSM+A4SE93OEWcXTqMkassrt+pz3+VBMtOCpqKD2JJqwmJfgGGlL1In1cyDXctFizEsjTKrdnOwcBUbhSkrm1+eZKE4X2XN0Vwj7vpQns0iArZRplAu0ePs468RpjKv7LNNnX59RZfHc095QRJJc96FXuzyAxwCimnq6jHmirP0Z9wQ3GYZ0VkFNfAHsUOHd20xM8rHpd1WGmZ3FGWSBI49K8123aXTX+75FK5NMGgmL6X2gVvgUEHSsIEuI1a9QYb349p+QJV0mtOEU3sSdTOxW+cD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS3crXFBFTArqbgLO84Z/OigYruzI0BVHAnNXF5xd5M=;
 b=IZ6+0uKCgLzFFaeBjFusjorzckNMCMj03y1oj5y7B1gVsUrzVs0lM4PHtX4sWP4Wq/7mWzNnLoj4NLTThFXYUd1oExak16BJcJ5HA2Hb+EBZrjJq1kkvd7Qu1aYKkgDiBUvMhZpLe1lGgdl7E+BMlaukodrRxd08AeTZAltitvSFwYVghD2dD7JlYxkOGeGgbkJIfc8DNwZu87QXsinoZX9c3hZ6TwiBsDGfBhsAQ5K7fGSwRaY3Gxxw61oYeGfwgVWiJHCvK6RL0QvKkBiahunqClEGxvSsXGLm006imnFmmLJpsDQxftWebDlBzu5FR7qm10uwwKIPqJCK6Gd1ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst scheduler
Date: Thu,  8 Jun 2023 13:46:51 +0800
Message-Id: <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: f898810f-9a42-4c68-b59f-08db67e41864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2a5IPocQi7z8O2jBU5mwXqLZnoqzlX5xMljBu1/UbGS5+XzQsWq6U6Dup5XRw3txU6RTc58N3Pa9fG0Qj4buXvx+OhSiy9s5pU9w3AQimdS+Q8+eZTNLsygeZC2aKeff+Lw9SeNLM7cnzt83ZZ5Z0hoJS+V3HDUvdyl3de9o1AM7sRl9MXgleUDuptBKX3YwncVyQuaRFzhYJ6xDZ0vLR0NWXHvrmubI1zCcA+L0UHAYo+DnLOxrfyL61Ghc2NkBqZieY+esOYi0tSDGojTbVc5k83MaxF2Ovjx8wGnwc9AVhaANBNktDKyY/JzsOp2yVBfgbq/y8A4i7lV/JwDOW+oJxI3Xkr5g/SP4eI6ESvUQbTI4ptrVeBBdueaABhymZCiDonD/MRWNE4PFDjQMXv+Bur6m1Gph5VQKOIx/YZTgtonAlRLw0gtCDM8bSlt/lTfbJnaH90Twv+l9rIl/5NoH1Hmf+2vUlX92qY0woMZxIymfgDvG3zJllZXRcYuTo0y1H4twq9CTALGjHO+4HKHhKPpfiP+Q0jYbaCXmNMXKEr4GcgRwf4n3jtznUA89
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fusBqkx3kEDmsULntXtyhJpL17LDcChvyBoRLWKphpRdPHtcM8wJqXbVw2gs?=
 =?us-ascii?Q?IwNjh96tv0ZXxQH5pkKT1leAY02gSfnsm17Oo49zoOHmY7y6izwIu9yty9VH?=
 =?us-ascii?Q?8D2T/P39aHhho4bpOLRqfvkGPQ7PS0c5PA3JAUV/3R3Us3RrbRvNSh9IvlT7?=
 =?us-ascii?Q?f+ZCHLzKktmdh/CK0ydxY8sYwpySJowpMtRy6cqmrVeS6B6+ScuFY7gU87Qv?=
 =?us-ascii?Q?hEKNslvObYpJsQeyc7yLsj+bAgEC1tjA8/PfKwgoVXYQ+8pprylsmW9c2uic?=
 =?us-ascii?Q?E4QWC/ZwA6Ah4ij1nKQ+ujpdzRcFqYIG9K1eDQ985j6Paj9Bt/OGbBFOjZJG?=
 =?us-ascii?Q?Jtw+4IcOBkQQThZQYFLD7vrdF4E8JBq4yecBrGN7W4qa25uF5Z5HXBe+t2fE?=
 =?us-ascii?Q?5lg4OmKRhSWvU015rr8TTvMZEqGv+sO72Yg50JM+nhUgRLh3eE7LypZ5xZs7?=
 =?us-ascii?Q?OArsKpLaMY2uqwpKY4Vp5CfpDEORsCcWzZIqDW2+HwveUuQKiZp9PjHPysTg?=
 =?us-ascii?Q?FM4LwjqS1M+YyWPvqjYntaf1WNOLbHMfI8rPCj1hJNV1ZeWpFB1MFnAShLEA?=
 =?us-ascii?Q?T9O2FTS8Vcet/Ugzyfpfwq2kDOhE5W/QoyxeVCR36u7k7o/oJSOslLL+juHH?=
 =?us-ascii?Q?DYzLbCCIfdBxmdXlDZWUX9YKNzVqVGeqYuaW5MRRCUBOvKey3C9V89qCgyx6?=
 =?us-ascii?Q?duYP5nhPDEAsQQqgzMwraxWzJ+L05tEBru6jmTGBT00TcVTDfaGkPzaZIfAr?=
 =?us-ascii?Q?JDPYJnhOcuAtinQgCAbTMxVvNVdizhKIMSOQ7uWBxIgfw9nOcjKzWoRmzOMP?=
 =?us-ascii?Q?McNg7SyhiscsamrjXYDClOUaXAseCQnDq3EiZok+ddYEaQj53yk0bIf91bLO?=
 =?us-ascii?Q?TNscwNyOFxls9yI26idqKeqTfI4bvD13PBxFXi0SGJcJvDdhyXlfntLq65Rc?=
 =?us-ascii?Q?CrNDbLZDm6mjRWD9JkypeoVLp2yCl+khnETCVY3RXi0tX0tApDjiFH9QzlfY?=
 =?us-ascii?Q?tOZPe5rjhj1T7/o2uj21Qy0HQp21H/C3U7wUc9j3bVgZUFKlT84QkIXwzgmt?=
 =?us-ascii?Q?TKwcDf7g0ZCBqgrSNBxk32wlWeU7T0l0dZMy/Gdpbj993zhzubvU+0N1MjjQ?=
 =?us-ascii?Q?zRjcLhKkS31/T85D3rJWvZXxgCWoBg+bbEJidB6zax7mabob8QYBc5mgZ+6q?=
 =?us-ascii?Q?XOOG6cNBCh6rKG67VWWdxw+tDDK5K8SjZPzFzJPGJRDNIF7SDy6LAIFX7txa?=
 =?us-ascii?Q?A6OnPav8wistPMgrFkEPzcv9GpFMrnckpW4aSis/fe0lMBu4BkSMkkzr+DpM?=
 =?us-ascii?Q?M8Diw7d8EqcBn2Sxoa+SbubaC66wsQM6GKmUH209uS8j7brYQpTaVwj+gRkL?=
 =?us-ascii?Q?DW0flLohIat/KVUiQtS0nnPIK2nP1fPD2CL7NxQC4Nu86LQ8LrI0t5/g84+p?=
 =?us-ascii?Q?vzCp0BaEJPFR+seZLMNwK4P8G3pa/lDGht45HUgUdnwvq154MMkv9Fp9nxm7?=
 =?us-ascii?Q?xWn1tiRmj9Fi9zYgxFiEuJ6xx8RhbkDD15GA7TfLSLmbmMolom7SRR6tF/Of?=
 =?us-ascii?Q?a8nxXHLefLNlD3+/9r9mvkudM4t/eFcaJKSxowbC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f898810f-9a42-4c68-b59f-08db67e41864
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:16.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tvSnV5Sp5PydHbtbR6LOui0Vsxe4ENdZKV0AnJeUnRtBvMDQVGuNDAm+zI4Hu+ZTM/EpZUzRiaEDifFtVAemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
which is the default scheduler in protocol.c. bpf_burst_get_send() uses
the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
uses the same logic as mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 208 ++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 44c356772798..927a00f663f2 100644
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
index 000000000000..b860fd517787
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -0,0 +1,208 @@
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
+static struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(struct sock *ssk, struct mptcp_sched_data *data)
+{
+	int i, nr = 0;
+
+	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!ssk || !data->contexts[i])
+			break;
+
+		if (mptcp_subflow_tcp_sock(data->contexts[i]) == ssk) {
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
+extern void mptcp_set_timeout(struct sock *sk) __ksym;
+extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
+extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
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
+	mptcp_set_timeout(sk);
+
+	/* pick the best backup if no other subflow is active */
+	if (!nr_active)
+		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+
+	/* Get the ssk directly like this "ssk = send_info[SSK_MODE_ACTIVE].ssk;"
+	 * will get an error:
+	 *   arg#0 pointer type STRUCT sock must point to scalar, or struct with scalar
+	 * So here use bpf_mptcp_subflow_ctx() to get the subflow,
+	 * then use mptcp_subflow_tcp_sock() to get the ssk.
+	 */
+	subflow = bpf_mptcp_subflow_ctx(send_info[SSK_MODE_ACTIVE].ssk, data);
+	ssk = mptcp_subflow_tcp_sock(subflow);
+	if (!ssk || !bpf_sk_stream_memory_free(ssk))
+		return -1;
+
+	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	wmem = ssk->sk_wmem_queued;
+	if (!burst)
+		goto out;
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

