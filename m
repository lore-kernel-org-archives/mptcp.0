Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF133A23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNO0kgz3K6YU1o3Q8q2UO2HiZCFdObWbUh3iOTf45WXLY5vfnYlnt2uWu9H3bOkcDM3DO1ZZjR2ApgWuZ8zczUZg0eJIw1914aOmMCcvYyLPxVknNJeeqvXqoiBwAbS8b9OBbSNP1LHaQhhJA7cvKLSLp8KnmVfOiJ3cj/gFEGxt0T0Hsh/HEGzlYB5ZyRGOCJTeB8MmuWsXdmPSwqWVBhv2wj0vS50IQzwtJGiSNYYutS5yEGkkcH6UiNDRUaOd+Nod2j6dcXChgLga3yNzJbvLWDhokQyLsKl4vJyqHobRs7BMamMKKu9CTLs5bwbJNKVgebqkzGxiY5TE/wP8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2v1k3uje2I7jwVa4ZnQoEjOIuW0vy4FoIti+HCK1D8=;
 b=cf2SwHOVgUt4nasR3m0y9aDaLR9GA2AkQSiFhY5HEbsLymQ+64FetVaGizgqzYtzkHuu2nGYHKvSOVYksvQkyy0/0IYO0M4rkql3AuqZYH1jkro1OzFDtRREac5Jk9WUxy2e0sw89SST3JwgITFkRdygAjy9sAUCdRNcC5T79sE0Z9ROiFAO04M4ROXLu/eFEXtGqfchz633Ft+GTuldVLVD4ev3rrC1ZBa3sjmFcI6TlOlSHQL4b75ZYK4KKjNjml1eJUrPFeMBnco0XRfhyi6ITeP1HaST0s+H/CfqFGCEgQV88P0ONN/ImE7dBp7iEx3onagTFZepzMTTOIvgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2v1k3uje2I7jwVa4ZnQoEjOIuW0vy4FoIti+HCK1D8=;
 b=E9bbZpaThkiOkDjrgNPTn0sPNf2ZU9DS8kot/WY8gmsqtRJrzt82BdQsPqxmoVM+eAJZuc3EI37Q5qt4qIBpiDD8ZFCcq7ZOyGUsROAqtKCRLOFYR4fojkaO0gkeG7d+SvEnhOl6oCfZ7vbgtm8W1+uApb3dx7wNmom5aHaFKu0aTfCQFcNLSrZjvpbEUdEeh8plgkbvVRT5E6iO7CCF9XXA/oa7k8ATJtzBrbPjwiXd2nQzvststYJRhUUAwLYI8n1y3PIW95Lrzr94mF98dtDE3rCAxwd2p5jmOUOxSIc1UY7rx4Ig3I2GaVYPPpMsHmGql/mkxO6kOBw5/BpJ/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/10] selftests/bpf: Add bpf_burst scheduler
Date: Tue, 27 Jun 2023 09:39:30 +0800
Message-Id: <a65e19eb002b474b070cc31ca471b4e1c6ef8533.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: b472f3f5-aeeb-4849-45f0-08db76af8aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQ87P7l4wiG4GByQWiMuDS4dFeNd679O/jLeE/uPbBrNr+ddJOivM3U9Twr0DpDstciNU/KNLb3zdPN0BS1YjdIyr/ZYzbOShcqPgARbM7XVBBmv9V0PuHNS2mrHyNkiVtll6DbvfDr/6F13aE0bOgz/P3Mh4KTLlhkv8OOnHj5ZRtBqvrx9uK1caM9aLCuJgWmCEE8Pn//2xvM/93hip1d4GeJyFwzakmFPwzFkxGqpaMeqtO8XZWGO2W0P6Vx/GfSesKQRuKFoHk7JLHzw+WwCCl2NBGc7mU0i5QuhlCgvpJXwcsxIzg14vC2/mSJWKuYiI41DTYUfC7eHCF4X4tDmlo27Bjo340YOZ21+x6W5lu3nbuI1WEKtXi7/Zwye4QL6+4GHlE+oZYzKpN7JSTf6LFeOU278ewawVWTQzXLDlIqrPp/VWlK3xdHJ9zhiQIdmQib36OHSQ+VzpQc0me7m4vcNcnPWuxCQ5cga5FNezWwE7wdjwDriln2TUa3hi7xUQllOWz2zczO2zbGTuYFmdBFPpmBibqj44XBmDdY1+pq03FvGqEDk6EuQNALw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dPE/YSESFtySb3f7MrdQK+HSuV3Lv+qovO8zzA+aYCLX8XP7ar2ZXRS0eKg6?=
 =?us-ascii?Q?j/fmILGfXgFLTueRhxmO+m1tGmZ83bog/WxRJRD08uKc75KJfQ7RUYEmmPLT?=
 =?us-ascii?Q?4vYs/38U5vbXpO/jrFcKsGiZ+lB8fdFFDNPUhu8Dl+glYw5JkMeYcoaxxFKL?=
 =?us-ascii?Q?crEM4qtpp3Fc4EftS49//z+kLfx4cbxlXbqDg902rFqutcjJdjq2/+ngFAmu?=
 =?us-ascii?Q?0gmUDB6BybGWwhOAdVCiU69SpwAxO7hzRdaJXwZGah6/pKaKYiruEo25lWsC?=
 =?us-ascii?Q?k34AWqhQrU3bURSbSIdHXoBLn2QnMyPOkyO0QnpivIsg4SsEkWBUhe4sPxeI?=
 =?us-ascii?Q?RV+NkQrOO2mhMTmkbggN0ZWL7ufXUTuNFjoZHuL2hwVaZ4LYzIoe51/xrzTV?=
 =?us-ascii?Q?FRwU8/BwXbjQJW/nGlHELIDuekosAQ1ak6sH3mgMu+XhbG0AGYzfhyMPmKqz?=
 =?us-ascii?Q?8SfG/JD35CXUTds+CF24HxiY27F6gACiLJCB6ECRck0ptY65c1gu4njktm6d?=
 =?us-ascii?Q?kxIuXet3X+vIeZ8z/PEW6h4TX/qm82/7ZL6j+xfuit9/IgNgg2NboOl3yxd3?=
 =?us-ascii?Q?HIJVOJ1vkCP0OQbA9VlAhNFEI+TxR/NqBMS1BJ2/PsraBvo0Kyn8YsgiCsjY?=
 =?us-ascii?Q?T3oKldarhnUEuyMUFijlK5RvnrTnHwQw/k1CAL5RSbLZfl7aclkjOC16FiHr?=
 =?us-ascii?Q?dbxh3prKmjAzwsnVOrq1grGMT8bY0SxZJGy/VPn0VRKaUUyDV7Q55LsBP2v9?=
 =?us-ascii?Q?aIDPYLDXWUw9OLbqpN9wpQzyQsC5kl/LByo1n/XZ2SSHrmen/AkB1GywpMhX?=
 =?us-ascii?Q?9EQRRYPXgeyWafT/nVOSbFEGqX1nHJf/VLUWH0TIVxoTBAlm4u6R9w1Oc0sM?=
 =?us-ascii?Q?5PhnOrcq4It1YDIppHovwG0GXm40r4hkbXb0hCHWznN6RDiXYIGlWk6RRZYv?=
 =?us-ascii?Q?QmIiOkGI4rkfJsfCRgXc/it7luiuT7yA7/fcWVwGGHbRsjITJeoMEd5Jb5C2?=
 =?us-ascii?Q?XPJhwqN6BWgkRFT220CO6JoBp/+a4BbRVpI4D9kfSjjMZcxkwyw+XPHSVFQ+?=
 =?us-ascii?Q?WbwM10AJTr5aR7GFUB6nwrafwJiS4lsUlRg4CVETKYDXbT8/vqZZYQzZGR1I?=
 =?us-ascii?Q?KWVH0rwktUB+fEDpqJdKWskFUQ5aGxejTP+HMGoiFwYFR9hbOcqdniQ87HdF?=
 =?us-ascii?Q?VeRGCjUNF7OQaS6vTDBWJ2Bsn9anjdgBQXGldGOedNOpvsIEBLzNbup7k/NH?=
 =?us-ascii?Q?ms2uJ4VsteUzuEumN7+t2DcxZrW/ioI/pPEL9vhweNuu/72Q42JGjPBxruW3?=
 =?us-ascii?Q?zVIXYkWRzk73+abzkbfW1XcdcYczqEURqO4/p5VxBxUhP5NHNLHO4Tus1tqi?=
 =?us-ascii?Q?wZjp0xTdhZ5w+BFZt/J+ETuW6rQViDkBlTsZkLWxbyVpUMqvHi4GTrpwQkFW?=
 =?us-ascii?Q?N0uBbJWanSY7oG7TLH3WQQXGQUd1EFH+kcZOZF22EsTkx9WxQkNz2zVPuzV5?=
 =?us-ascii?Q?V+FicmqY3Cdp+J/8NBPuBGg7Glfn3shSLCHTM5KDrDN8ibetN0ZPq/2wrVCP?=
 =?us-ascii?Q?orMGXQP3H80Etxu10b9JMNuzgBVcnK0pTisP084n?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b472f3f5-aeeb-4849-45f0-08db76af8aef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:52.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCA4c7eGYrvnpltGTZow59SpdpNxdWJh/2D8gzDbWaULv/v/S/Mit743zr0RJCY87N9KWFoi1F1LyKb5/93qeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
which is the default scheduler in protocol.c. bpf_burst_get_send() uses
the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
uses the same logic as mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   4 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 205 ++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c749940c9103..c1d7963c3bc8 100644
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
@@ -234,8 +235,10 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_subflow_context {
+	unsigned long avg_pacing_rate;
 	__u32	backup : 1,
 		stale : 1;
+	__u8	stale_count;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
 
@@ -260,6 +263,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
+	__u64		snd_nxt;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
new file mode 100644
index 000000000000..1886e2f7aca4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <limits.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct mptcp_burst_storage {
+	int snd_burst;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_burst_storage);
+} mptcp_burst_map SEC(".maps");
+
+#define MPTCP_SEND_BURST_SIZE	65428
+
+struct subflow_send_info {
+	__u8 subflow_id;
+	__u64 linger_time;
+};
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
+void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_burst_release")
+void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
+{
+	bpf_sk_storage_delete(&mptcp_burst_map, msk);
+}
+
+void BPF_STRUCT_OPS(bpf_burst_data_init, struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+static int bpf_burst_get_send(struct mptcp_sock *msk,
+			      const struct mptcp_sched_data *data)
+{
+	struct subflow_send_info send_info[SSK_MODE_MAX];
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_burst_storage *ptr;
+	__u32 pace, burst, wmem;
+	__u64 linger_time;
+	struct sock *ssk;
+	int i;
+
+	/* pick the subflow with the lower wmem/wspace ratio */
+	for (i = 0; i < SSK_MODE_MAX; ++i) {
+		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
+		send_info[i].linger_time = -1;
+	}
+
+	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
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
+			send_info[subflow->backup].subflow_id = i;
+			send_info[subflow->backup].linger_time = linger_time;
+		}
+	}
+	mptcp_set_timeout(sk);
+
+	/* pick the best backup if no other subflow is active */
+	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
+		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
+
+	subflow = mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
+	if (!subflow)
+		return -1;
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
+	ptr = bpf_sk_storage_get(&mptcp_burst_map, msk, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		ptr->snd_burst = burst;
+
+out:
+	mptcp_subflow_set_scheduled(subflow, true);
+	return 0;
+}
+
+static int bpf_burst_get_retrans(struct mptcp_sock *msk,
+				 const struct mptcp_sched_data *data)
+{
+	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
+	struct mptcp_subflow_context *subflow;
+	int min_stale_count = INT_MAX;
+	struct sock *ssk;
+
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+
+		if (!mptcp_subflow_active(subflow))
+			continue;
+
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		/* still data outstanding at TCP level? skip this */
+		if (!bpf_tcp_rtx_and_write_queues_empty(ssk)) {
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+			min_stale_count = min(min_stale_count, subflow->stale_count);
+			continue;
+		}
+
+		if (subflow->backup) {
+			if (backup == MPTCP_SUBFLOWS_MAX)
+				backup = i;
+			continue;
+		}
+
+		if (pick == MPTCP_SUBFLOWS_MAX)
+			pick = i;
+	}
+
+	if (pick < MPTCP_SUBFLOWS_MAX) {
+		subflow_id = pick;
+		goto out;
+	}
+	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
+
+out:
+	subflow = mptcp_subflow_ctx_by_pos(data, subflow_id);
+	if (!subflow)
+		return -1;
+	mptcp_subflow_set_scheduled(subflow, true);
+	return 0;
+}
+
+int BPF_STRUCT_OPS(bpf_burst_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
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

