Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A35664
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOnHIJk4M1nLSS1al5Tm0pSH6YN/Pr4tcvzntmGrjPDplyarKsi1Xp6/LpqtFQoy5USLZF71DWFnju91khqmfWf4WNWaamIgla+LyuTwdyegVwLXTKKwNm29QA02/sgQhLGMm08CtcnKTbWilgFCkvfFMpoXNtp6j7+LkMHE5Oq/bRwcb9JNAzQXyN31qXG/Gd6/QEw7RXheE5laEDH30hncGa7URcRxu7qOJwlCm5jheonEeH0LOPHMXH1Kn2qWd7Ib1n7ClPHdmcxy3rHswTxG7oJAUcNh5FlIxy/8UvEvcnDMkvR21kuuBb4mjNC2JvP8dkKIIK22Ofv+oesTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSZINgZaWwN5iPpA4yt7tqHCQxxxtd2evB270ujL+GI=;
 b=VKn/bgcR2lZrWHM8l2lUnuB6GTYJ4xJVeE12rB2Eo9BuRRLkgBIGHcyd8yd8uJjcO6wAttQPmv0T4Sng6cRzykABHW38UWdKpvEQdP7JvRduqUL407DLqg4B/X/AeE/10FwMBuWIH21O1vCZn/HO0BASHC8/5HWtrJVTsIy7PYdILDdyGCVFNHiz2PiB7YZKOVeSIOOMGebiE/LCHAbhxLrZCEAo0OeTlxVtB8HHRoG/bpDDjGwegq8zkK1K9praMngD2n1iUHDeZ0aYWTpgplHau2gvmdstMA5c09j/jij7wwe1PRfFXtmBBJpVOWxnm2haU0o/yLOIUrBBh+V7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSZINgZaWwN5iPpA4yt7tqHCQxxxtd2evB270ujL+GI=;
 b=aC49mN0pLcAuyW5hGLRpfP0t8qNq+81Zt7JrU5kF9ndckk1uDWC3jSPn4Ktfb9dY+YMZw1FQ0lC/DN2Ldl38KZ8BYULWaEs2bMEnJoA74k0ZqODaDm4xIFu2nyPF/ah8GqYH9NsV0ixcqKxMvD+0pds7Fz6xqMk5JDcAkxlT3cpoMWch8zMELvPXgo5iTbWPiOTognJgEdoF3wOSgqPsMS2QEkiKKfjBKqqXBlpObDz/7MvvYRr83BE1mSvWoBcWHZXTXH5MDIuDaNgGPIHoMv03KVAskhYaUtj3mrYeuDg8+SciklEeI4r9LvHvW4b3bOWrRRL5FrCRxYpykQmVjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:41:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 15/19] selftests/bpf: Add bpf_burst scheduler
Date: Wed,  7 Jun 2023 16:38:30 +0800
Message-Id: <673c7aee92c712651a7f37192cc0827be4e9bd14.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 257ec2be-9dfe-4b5c-79dd-08db6732f5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nlaRQUh3k6QpSfqmRMQiZZ19K+ApNnELP628hP2Q5uQTpILIMeKseF8eQ+rHwD/W1YEAymoQfUSWEQexw/hKzrKEcRsDr62GAcpVlgSvE0PbEx0QepGofjrLi+HVPACVnVtEJMxseP57RN5xGTXpfyCe5YJFLPF4OiQTq+mZYX12I1n3Vi1SkDbOQCo9VSgkhKDrARoaGZ7jlr8DFrdarsL5V+kLf14QqE5YbbYwznb0SfBsMEnipg1OxxN5pFN9uNgsEi2Wy5urXUIQbQx1+bZB23Rgcv8yLgq7xPM2joQJhQ5U0zR/KRjlysy3ipKP2RoCMWIXUI3B1r9hg/gKWIgRaXt4jU6TB5H5pIkK/i/CcEpmUw4u2dRSGp/i9mrLqOmZ6y9CxmCUJczfSxzV0nZGb8pMMEsH9oYEQJ8mA1erEn1DURXRSEbjJhw2iuT+tqVtkweNfv7wll9Ua/1jYBZ++Fef/EkpNiwkb5yDh8slt7R0Af12pHxkvXHU859K6xeY0MHWQthXBolHpv85K6bektgBQfb7vaxVxL6HkIVSKaEeOEBNQkLBvEM1FNNA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qtfTPyyGsXIfJLTqqVbKzgZCw5B+Orq4v26/CZ7u3fBRg35Q6IIgc3dUxDnF?=
 =?us-ascii?Q?y6lOYgSDArYspAEFqcnL8HsAqLZRSk9Bx63ky306rFQD3Neq6O9lclhT7f0j?=
 =?us-ascii?Q?758c1Axpd9mJDCaVecF0iBlGEV8LtXgGZ2WfKTwRRoE8Cq5uFWD1RpPKKEru?=
 =?us-ascii?Q?SXIV1YJHU7ovpDqV0+X7DA0H7CHEN/rMUwyNr2vW7YtjF8AUwxZPQ7oNU1rS?=
 =?us-ascii?Q?mij8JgStf7FbkpWnE3k7iJzqSimAJF7hrBB6n3LF9qFPsDWfwvTIs8IkANyb?=
 =?us-ascii?Q?pCe6VJnsBWWlOfCvYWEgpL3hqv/t5Oilia7D3p1CMxSAR1IZZCzjQH6la49G?=
 =?us-ascii?Q?YaVSNvhKceiORrfSYbi9lKHaV4yrQZx58bFhgOpE7WaqdX2m4NBa6DdZit0O?=
 =?us-ascii?Q?0GIuIYtPRaDCL1znemtEB/TjuXD84zb1a2tCH6Cfrpv2cwkAHjvmjzNQ2EX7?=
 =?us-ascii?Q?Iqtu5Hs00bWX0DZ0a9uxYxUof8boKNia2VWDcxzvYfau0DOgThzgyJSUNibx?=
 =?us-ascii?Q?EDqke3zOOkWyc21S/PyWEi5DREn86yY45HNuzMTwe6zHw41C2mFbCtvz3hnc?=
 =?us-ascii?Q?lKi/mpANu8B2RmuxZfXkY8TfRm+xX8aEfNHCNjXoiA48JfApu2VUPJ/QRY5Q?=
 =?us-ascii?Q?kSoMEJ1v/ttsIda3v5f09zUNpp2njLgT+mfPRuaKAdvToRH5YGmKY+2U3eYo?=
 =?us-ascii?Q?Q4x+VfIkghjcxsZdKxur2IxegMsRymHcOOyqHXoVRRArCHPzlDaYyRyS/1xq?=
 =?us-ascii?Q?X4/3UfrBLX4qXM48Zmp6hfUS6/eWADXMxwcnLzLs9kBQpeA3FOpmu6tGWnzR?=
 =?us-ascii?Q?NMkShubnvshvdpt3MzlMh/EwljxcmFsmGflX8d0OMlwb81t2o2HH3GWHcCeS?=
 =?us-ascii?Q?EOOltH8NEa5AeT50h/sVhcclv6mx3aa3YRRSYh2SwkLYj2M76RMZczVua1Ic?=
 =?us-ascii?Q?I5dxOY5tsQJYrAcrbugB4ABwwksvU8SGoeR9agrqyXOuACOvUQ6fA7oZAGul?=
 =?us-ascii?Q?n8lI+KwFFsVqs0xLGs4prCEjRPrxMOR6EzeFnM+b5wHGpd5/cOnqhoGqqkOA?=
 =?us-ascii?Q?GLPtzkaidgA9UzZx+JmT80iO6XVU7LYKC6a1o4YjVUThNjK6TJU7B3Nx+dM1?=
 =?us-ascii?Q?lwspH+l4UnSOASwqOEAe0W4kQdKhX7xH+wCHxZXoHxlMIzTMgImrc5+PgAFn?=
 =?us-ascii?Q?/prFmMsGtC2gu3GX7N6UTFiHS244dtAvo6KcTxvqo6YbEWir5CnAZjoQrKyQ?=
 =?us-ascii?Q?xTuBDneKdEmUbbO8lJHr+i9cLrB/Dy02rd/PswogJF18f4yHGqUQTjdofOWw?=
 =?us-ascii?Q?8spCbq/kpvBBjwrQ6FeH/hIIF449XC2RTFTQYzs8IpCMe+aY5tfdejG9isQY?=
 =?us-ascii?Q?aFtgOzQy+SfVuM1mC5OEJza/xBbgVQ6Vua9EiTn/Pqt//ablvZC3a+LE+0GP?=
 =?us-ascii?Q?Ya0dpb1/tANHA9+8Xx6DJtPiDmthJFiLHCvp1N4ErscLEOrwbS0X83JLnShA?=
 =?us-ascii?Q?UjbDbej68uNvQcS56smhyl5ZvHOmoBAiBIu8LFDD3rBpbTQlviYMbyEbBxdR?=
 =?us-ascii?Q?fC+rObjtTHlB0/xKvkZoKV3giCs2HkZbItr+90Nu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257ec2be-9dfe-4b5c-79dd-08db6732f5e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:17.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BH93RKAIYcC2qmC5vqWPvuHqlfihOWGbytW+kUBn7+wRYW9VCoJAPs2NUbcxOE6NCEPrvQrWyOqt0cPs1uR7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

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
index 000000000000..15525eca98c9
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
+		if (!ssk || !data->contexts[i])
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

