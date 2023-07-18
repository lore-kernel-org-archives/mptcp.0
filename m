Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330417CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcZF5sq891LjU1Xpj3K2pDP0JjNkwf8/NsGCKbX7eVVKtxvi/OfOLt6XCrHm5vgXNqf2tQ0KRElR+B4W5vH6QovVi8vCdtOaD0sy7vtchbMR7yHUB5fFVGooEyrpPMSzn3p079ONJnB4RBesChgXmY5IdxzqkEfOp2Oh4r7zbRl4Zn05YUNjI67iO272qXuj3aPLNxi0VPtDYLNAxLn+j01XSmS9Fw1638Ik1ZKg5j2YcfVqZI8J42aAqJ6bSsLlvqFcT56zM2SOWPgF3cw3QhdX3EWsJGzuouuf0U5WYmFpkdUwlHNyDG87htS7nsLBKAHropnyio+IpA43aI1GLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE7ZxTGsDMpJ+Xq2HU6y7lVTLwPGepeh82t1mev76DQ=;
 b=mzbHk9kMbAs8uNx+qi0fb2jevsKHkMX7D4cnpLd7ejYQYdKCJcfbS7+6v5zTAXgBc1ZupFUvdFzK1ZCuZ/RT9QaBlRyS5+hh1h3HfECowoVZO7CaeltLELv/7sKrC+QUt5Juz7A1CG/zRQ6NYOlqnO/n8oZ7BKSDYGb2675HyNRKvfgqF4eeN9+vAc91nMowD53oYY1th//a/tIJsn4ZDhs7zm95pe1TR3Sxz+TN7kOGDDfR63gxqSO0V3PbMondvcOKzadZUrlgavGqJgr2eo5kF+l0ZHFBbyIrEk8L05BVsxJX0gDULnLZHiZAUIkE56EfgacJG+snKoPC3/fP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE7ZxTGsDMpJ+Xq2HU6y7lVTLwPGepeh82t1mev76DQ=;
 b=CH8qeoe8t94/iqj/a5w71tdYuONE/YEDWO7G9wfq9lscRqho1JCcAVtbppKBuSILsk76zh8Q9tFtu/CET2WFrs8b4qvq1AGxG//HOHPIcW6DIRG8HqD1w5T/ggvlgCTLbZQs3yhGJDLcYLS/xxzdW70+JzHxdeMV0xGXIzqRdHpHN1MCoa6QA8MxUdwnEsNI7HWTC9Tq0UU/jXbZLiRpIuF+LtYv52tQKrLVWJPoZGEKEM6PPgp48wbP5GtiRSSQwg8jb8NhvQn+7WXuUa01ZQ6qIp1gOmBytSToG/DkwU9a8pKdwN6+OeTjsSFo/BwSAUczgo/FpjIcvPds3XGH0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:38:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:38:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 12/13] selftests/bpf: Add bpf_burst scheduler
Date: Tue, 18 Jul 2023 11:36:49 +0800
Message-Id: <f5d580e1d49624f6b69dff2c296185e03f1f9625.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: e901a960-4f24-4995-3cd3-08db874076fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DwsEcsaa/qRR56EGy+zyRavfR7KStNC5WARU2ASEBbyB5uCVLlholcgx6i1ARWKz4KMNeooQzlKFgneh6yNwh7ZGUu6YnHPheyyeWnQoaci0cRUieHWQLUa0+TDABG90SyV5Z/ZyMPu4bCLMQw/WqUOSlUubqd/w3ETNqKhqeRs8P0J3CU3pzJUufpM0X6yNLnH5iL9xJFVWdgk/6IYfkLSBwXl1pM4lc0A5zkd6NYLIMuvqrLbT/3bwmmTj/ZpcprXMziSbpkCGeRpimP5UeG3EuZ/jXI0ViB9B/sa3LUwJiprHdNiL263/ChTHVV/k6WRbyT68FcZ+NNB9F7TXptpmhc0H21AXVHA78Qw/Ybe9J26jr2QQEAPK0vDI6RBX8LWP3d0dcLArSjmPi6bw2qFxLoe/2iTiVH7sfa8dtZZkwADrw+ySGwc4g8L/8Y75WOoedygozTZaLI0jo9idJzQLyI4KmKsIfxU3gqj49grYvikc6NHb5kcXShMyjxyfg01tE6eZltavFtasJc+s4TWzRNwqhX6wfyNljzGUVEaWq7hOJ7QMq6Z3uNW2YQ8G5LOpu2Ld2U1FEejEzmqHh+x+jjGUv2ywtrFPX0fKQb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?49NnGE6y5Hd36TqzmrOc1xvKpOOMPDVl2j07zMtu9sbINHKGQle1k9zPXUsg?=
 =?us-ascii?Q?TxmphRSDf2eQ5IWz+5C3YHfFtgsNCZbATrxcc8iHxcb3lfHRgTIDufqg1sfM?=
 =?us-ascii?Q?Uo1/CAYuepgYkkJPn9rEk/c6SlKC4B1Fn2kW1Y/Fp+BiUuJHHIsA6H8KATIC?=
 =?us-ascii?Q?0eSQoySIlBalYvfln3oSvjyLYMiD1MCdCTTAZjCb0nf7B8Xdy+VkFULOfUiz?=
 =?us-ascii?Q?bGzsCx9f0maKnMm+z/abWi419PHWPoWOfTdWnDhdWsiPLS9V9e8AfIMSTkO4?=
 =?us-ascii?Q?z0nbl3rzU0SEXUiIRN6dY/LMznLe7HCJ0C6Oor37E+QrIje0sTbWnnHmUUD/?=
 =?us-ascii?Q?diLD/ontZzaRnlYXyd2dhjgVJJxrQB2SZiOqXp7Sw0fRz0Gfmc+3MtkI6waO?=
 =?us-ascii?Q?5QsvIoqvHoAWcPYzL7Juf17LT18BLRINe5f2HKNEGCrbvjuTDEP2X3G/yDhR?=
 =?us-ascii?Q?JMn0668o/mKSB9b4xouSf8D2WmEFWZoNGkKrk6+BpNVYQVknHchUoW064Mpp?=
 =?us-ascii?Q?RJ1PDcpjTlANG2sVq7mwprB/XEnsiq+/a8Ka7hS/2guv5Nub5lKNvfMUCotT?=
 =?us-ascii?Q?VlrNlcoztdjHhFtJPjT3aKdDEirYZijIQG8W9N9q9WfKmjfr/ZUoIpnXdCM0?=
 =?us-ascii?Q?LQGVFuOp1ImL8FBQnezYJHdRaAC1MVQ3yOzjVcUUpchR5tr3HvfTT29Qer8d?=
 =?us-ascii?Q?47qaL0Dzmbt5Zvj99p+CwZpsLFps5QhZ+ebLShERdUz2WrH/GU+EUPLAEdSq?=
 =?us-ascii?Q?FTptRPVZ276LLknaO4YT3ZLrgal71djQrhaD3MxQ32/CpQa7wnjOuT/IoJNA?=
 =?us-ascii?Q?tBXeqvbKvk5D4CgUeyu3wSnEFEN+hBCGh5T7BU8JC0b2YYVEj+qpD2VuiRqs?=
 =?us-ascii?Q?hEKMofHMP3FFY+cWbP5uOvfiKEpUwqzMLiuHJ73kg7GDkzlTzLjsAoyy1mMW?=
 =?us-ascii?Q?xvv2Tjdxelh5VUIzOmADwKfcAljggw+OoSx4uBn2GSUTyE240F6rXMNWpjhK?=
 =?us-ascii?Q?wqsrxZaj7fnauQbzxE5Q0ag1zdkqv9N+CVNEKWo86qrzWkCJd3JeBFKTtT1+?=
 =?us-ascii?Q?zdikm1BTZ/RY5HxXyE8j7BRQd45u8aTfi6dzMtDF2kcV8ic6cotDHEQ8UVlt?=
 =?us-ascii?Q?71wzv59BvCsdOSm+37UeqjVmkHWWwc/Qgf29rcycY8VehONxAy9xCEf27ngn?=
 =?us-ascii?Q?bWOCr9L7r80754xqEIMeKv8FgPMc+97hE+WxHxEnuPc2MOdWoay3cSgaRhQ4?=
 =?us-ascii?Q?gf7++bHNOQbOv0ta1/uaMLRSIbyvzIZfSRtjkE5cjz2NY+40nZg92OPeLNtX?=
 =?us-ascii?Q?LfQHOWI/46fGeZKbhAHg3LEV7BtH2b+bJX0JBgLcLgwJLEiNmZSPDGVSI5C9?=
 =?us-ascii?Q?TJLRsGaL1H6Jdpx2eCWvPxY8OSftPRSMJkAn3D6kEd669VXV2EdWy7aHPUax?=
 =?us-ascii?Q?2yuZR66f49iTP6wc8SrrTHibGbs+/JVVdGNlLaEe2CjFMHfdhymM+zp5CXbn?=
 =?us-ascii?Q?t8eYQyURs2wHQM2treoZQI3K1Ky4OK9PDdsnK2TrFsud+rzNKWCTr1W8RlVY?=
 =?us-ascii?Q?LtMBV93dmHcSQo7stvgk4IYYpA2Gcwp15PyPySIF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e901a960-4f24-4995-3cd3-08db874076fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:38:34.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXIO5BwJyVFr77VVBUbsXM4c5EmrAiXCU79AcmpYsyDo+iXjIK+YNCkar37wEWB/9IKBZY1UZPN2zgGdoIhS6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

This patch implements the burst BPF MPTCP scheduler, named bpf_burst,
which is the default scheduler in protocol.c. bpf_burst_get_send() uses
the same logic as mptcp_subflow_get_send() and bpf_burst_get_retrans
uses the same logic as mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   4 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 197 ++++++++++++++++++
 2 files changed, 201 insertions(+)
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
index 000000000000..7af21d03277d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -0,0 +1,197 @@
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
+static inline __u64 div_u64(__u64 dividend, __u32 divisor)
+{
+	return dividend / divisor;
+}
+
+extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
+extern void mptcp_set_timeout(struct sock *sk) __ksym;
+extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
+extern bool bpf_mptcp_subflow_memory_free(const struct sock *sk) __ksym;
+extern bool bpf_mptcp_subflow_queues_empty(const struct sock *sk) __ksym;
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
+	if (!ssk || !bpf_mptcp_subflow_memory_free(ssk))
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
+		if (!bpf_mptcp_subflow_queues_empty(ssk)) {
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

