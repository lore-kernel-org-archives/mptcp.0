Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7547C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsD9eDNZjTZFWlKWK8ENNUSb0QNwRBZTSZaggC51HEEyXKti5RNtnk+TSW31ejVj9f3bLYew/BrLOjvcHHD1kCGcxzGZGchk4IbVL5jVNyrCkgXjaXhC7e08wptr2oTzXmk+FIDurv77sasIlEJRZfcMPFsvnceIrtskYu1/PTdHlMRCLYdDCtsSsH6zpqp5cWb1xyMvdvFZXCuuwn4FClkUmsk3i8xWH2Biek+ffvr5lj1cwThds3K8tMSHzSpfNvVm2i41ekyo0MndjKTV/3AiN6jc3+Zaw9SgFFOzr6h0Nn/bM52kuYQ/5fjjHJ/pfGH+xWIA7/wtAVwBynRy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M/DigPr9ntS13MBQM4aZvaT5hBGjS+6zIQ6rYgbRTw=;
 b=Ea+Wfu3W7ktwGwaSrwdJma7bHLLAdtjLEin8bYwGyD2uN5lMrcAolAK3CqIOA2gdDDGFLXcLsROJTFj1Wb648x5pNA7bH3DxCwiaJjsZrBmuhobuKYbttHYjKaAlbkK1ES9wqLy+9l6mqFKVa9LxkXgFGzd2jpsmbqnX9pA+B6G3JSUaxw1/BoQnAisGCHi5JIWcW2iqoTQSYZdVTHkzSx1RX/u5cOG9V3Um9picdEbbYf1OfhuSCIDBrKOV07ebMNJifpx8wIlgz9nOfSC4v3PnRA3vVPS6wtiU2r4UcOVMDaSo5toY3lkayq9+TS8fNs8qPnB/aJID6WOjT50rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M/DigPr9ntS13MBQM4aZvaT5hBGjS+6zIQ6rYgbRTw=;
 b=1/LI7uZ7BIuX3CCDKuAuHwu7shCt0NTgRbPl5BysIwn6PbO9AY3fI+U94AJkByH8A9mUl3ytV7f8ZkyStbgtBZAfWbDckI/3+nn9oMvoCadhedDXFohM4MUJR3i952GvUOTAXyhKla2kdrWrwv1gnWtaVzyuyj8zyGluVKMNzrDMD87vBZVtiHdJVDxRVp4ciDNiv8LJM+cIHViYNNV5QBdSb3xaioS8tgF5JWxE+4UotLmxE/Vb//Evbe2+E12uVdFCHAvj6wLCIV5YMSNP8WD6VLwmUFYNKSbi9U8DNuTzDOn3rrzCCsXForRDs+IsnAcekKmWfiGCdvFs3P6Bdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:19:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:19:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 11/12] selftests/bpf: Add bpf_burst scheduler
Date: Mon, 29 May 2023 17:17:25 +0800
Message-Id: <eebfafcfa0d998354c834380d02247d42a225566.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a415d4-c485-4726-e7f4-08db6025bd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7ujDb1nh0yT9RywZcbvmhT2CFkt/AA+fJMphsaIr+5z6TB/VM5LOfC0Mq6Y1rnsU+VfMk6Sbra2WNVmqLdVdeQzeKwaW2waus1NhCBTosBGwiNHarpP2xvb7BiDbVXggUdNjuGGnqy3/4jpDjCjZ2NxrhT45N02kEFHrRa9h/kN0tIUkLutqPQJE7ikFmgeReIbHtXPfAPSNgF/4B4nmI8wqjiKW6gtMbUEhfrRyLmCH3hvML+KqWzAJEqcMjmXZjFLsHlyPckiOuv/poPAq5JtkNyNslybDLgrR3dHD77maNoQ9CaFpcBd5gWFIilw5+tC7doOyCi/07utPqBTOSexFT3THR5lZpI1fN+NyIgouQZap8hq83K9uGUbE6dxL1jxFUwEXrqVmKTueVeEeIYycDBs+hptvoSN+x7gI8NMe8emtFENvUc6MSWa6xB2edt9PgRdlLFB02Rg77d7xiZhWYA9tqQougCCzdETlyAQfTwQwixMQ8kv7tS6uQUa3eOEUKg1notPdupLX6turvJRnLkGA7BmCCss6KFxmr+UTC4DiI9+Qv/fsCPGJFXyT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJPDx/d+r9aRsxzS/XGK/QynY4Ok/uMGag7sLAjjWuhcvpr/R/XC45M2hf2R?=
 =?us-ascii?Q?MQOAW344paUe7tkSpzdQLV/pSTYhn9jDJF5kzwD6c+QtxnCkKVJUhc4YAd+7?=
 =?us-ascii?Q?VKQEssqBQcs6aakjO1p8PWZcANRoqM0BJxKfWDS827te9Ah4jTodBFgkSm4o?=
 =?us-ascii?Q?O/UslT67OuufK3+oU61jxu9/Rh8DKFSL7Jvk6cnQTRBWi9bmYTnlRIfuSifA?=
 =?us-ascii?Q?Lpk6DRpyxf27rAwvIaujFXi69Y8cyrsxly97pUeetLBqLosK09JTrKSB7kQw?=
 =?us-ascii?Q?ZqQMR6e/uNKK/ZpP0ccaotjF5XJtkSXt8HsW1Or/fHfqglwilgIPkDAaN930?=
 =?us-ascii?Q?tZ3agcuccZKzUEx2mxTRunYglSoyoD3OCYxOiVtWQoVrlyE6jICoF646WGNS?=
 =?us-ascii?Q?PIaDuEIq4WOw3rwEbGvgf9kNB3TFpYsoXzMRKULD34ePpL06sii2yTSmtUOJ?=
 =?us-ascii?Q?ueRFzvqCg0w1YJrvKZw4h/SHIXViyPW44tvcEcscFQ2+coXK65FFItHjR6xf?=
 =?us-ascii?Q?YznqApSOig6WJSWisuoqS/pelncQ24NwXOCIpn6naaM3npxHGfocEIJ/IW81?=
 =?us-ascii?Q?YCk4M7RQ3eEOTW3mbP/1JfnSE8tDDAtCIuddj9GnL7GeSSodQg09w1iWhQs6?=
 =?us-ascii?Q?ORUS7vkUVxnVXqaktvsuxLwB7SxRQA6Q9JbnDWz7cyTwSzM7WofJJ2TQaru4?=
 =?us-ascii?Q?qbpW7p/UR1vORllI2RpP26QkRfbijkH3oHkHRCWuO+qotTRLJ4shrF6LbzwD?=
 =?us-ascii?Q?pvizeV5itHSnjAZGXd5mMToUfFRagFSxj81eCDN8ubXdkrgmgM4q3aWCzzeE?=
 =?us-ascii?Q?3xsMcCJPnmKykUGbeRezpAb/+YrujOYe3N2UVyOgOhzB4/hwLS4j4KFGsTHj?=
 =?us-ascii?Q?5XDg3ENW13TY2BGCh2nWaY0ycI14V4PcNeZ/qoYb+0yhqaehvHrlKiug+p+r?=
 =?us-ascii?Q?XlhabLFuNegqOhCfnHxnBpMWTFTcxh5GKEIgRwAf+KtqIYpD8T1xrJmJij1m?=
 =?us-ascii?Q?dZiiCpfmuMML5EjXEMb5j2hSsICdtfR6jsDZLcQG+GwxSAmlkTWD9i1//nUt?=
 =?us-ascii?Q?VzNzcxHLUn8+7kdd0Dvz7d6nPJ8gHOqAVi51DIaoqzOj3k0hJPevYCDFdTE1?=
 =?us-ascii?Q?siFA0hGceQKmldUsrMm6jvAS2nKuEsiRS1Dj/ss2vja1NZVJHy8FQNmq1Txz?=
 =?us-ascii?Q?fd/aKgTDEwO5Y9EZaLWi0Y0V/LaU32ejdeQl+DtRDOsdsQwePy+4OAvznCtd?=
 =?us-ascii?Q?sqU1Y9PHw16erbh9T7azfvq3MAc0Vu5HneWGkNU88ZLNxAtmeRcVciNnTfAz?=
 =?us-ascii?Q?xjbqyD2x4DI0/x0t90qgiuQBIWkJdvS+iA9N78A4dSju527VcBEvAoJxosi+?=
 =?us-ascii?Q?ggGQyeSjiTPU2pJ+R/cjcCuHfMLy2HpQ3CpIEQkvtWF91JDMBi+E1czgZmTv?=
 =?us-ascii?Q?Sna7dV5BJ1oSIZYCST1s3kPcX1clVm+GXXodC5MS2N6N4d1okvU+g4PAfk4b?=
 =?us-ascii?Q?3hZk0f4AJW11ZRRD6NltR4rD5KVSxX4vqkkvwIeUv1gybGP8Kh46Lla35gYM?=
 =?us-ascii?Q?gM85/vJ3J/saxsIjvk26oWboVpWwdET4rjL5VnxP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a415d4-c485-4726-e7f4-08db6025bd2a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:19:01.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZvvZdm38K4FpvhScM1TivhRJ+V3cDeZDxrzjHD+MDKfuCmVrZ6gkLFU6ymJJOGiYQ8okPBsQLmZlSSiTiXlWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
which is the default scheduler in protocol.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   3 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 195 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index dddb51a47740..d42a0c00ed73 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,12 +234,15 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
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
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
new file mode 100644
index 000000000000..305829162ce5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
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
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
+extern long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow) __ksym;
+extern void mptcp_set_timer(struct sock *sk, long tout) __ksym;
+extern bool mptcp_stream_memory_free(struct mptcp_subflow_context *subflow) __ksym;
+extern __u64 mptcp_get_linger_time(struct sock *ssk, __u32 pace) __ksym;
+extern __u32 mptcp_get_burst(const struct mptcp_sock *msk) __ksym;
+extern unsigned long mptcp_get_pacing_rate(struct mptcp_subflow_context *subflow, __u32 burst) __ksym;
+extern bool mptcp_rtx_and_write_queues_empty(const struct sock *sk) __ksym;
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
+	int i, nr_active = 0;
+	__u32 pace, burst;
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
+		linger_time = mptcp_get_linger_time(ssk, pace);
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
+	if (!mptcp_stream_memory_free(subflow))
+		return -1;
+
+	burst = mptcp_get_burst(msk);
+	if (!burst)
+		goto out;
+
+	data->snd_burst = burst;
+	subflow->avg_pacing_rate = mptcp_get_pacing_rate(subflow, burst);
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
+		if (!mptcp_rtx_and_write_queues_empty(ssk)) {
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

