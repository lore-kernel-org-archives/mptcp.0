Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5C134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS5CZBbEcWB8RcPRIUSgvKbthXJKOgkfvDp4bqbmjuSO7syUffcdad7B8uSzj/9LohzlzRjOnrRBe+S2QFD6syTKnvfjb+D6ooLaV4edClBukTha8TvBe3wHZCYZOSpng1d/+2YOd39W3eKCcWNCYXROV3G+2aOqo+k1Sq3mE/H58Ct+q0lGtMKmmbKe6iNzyQh7etf4PwG8Ajs4LVMPZAQ56M/7oc5rLo5dfJcwuc07dBhhl87ngtUVagLMwu4lZ36BbRgIprhW1cTi4HhiJTzTfn507Jobf5Ko7e+rIdJHiIThABjrchLUlzDxWTwAQkFlajQIe3RA0/IGu7Ow6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M/DigPr9ntS13MBQM4aZvaT5hBGjS+6zIQ6rYgbRTw=;
 b=QgalVqpQWnlzqzar+OSv+IaOGjiRj5bfETlG3QIMG8RuXxwL2eWx41h25QJwTpir7dr0PcI8/ffP4Dj/DzD8BueL/+PrYTr2w76YhIFJ+oNuf78tdsK/EZ3sR11wXQ30drciXI3VlYFz48pYhwwdLAxgnueTUGNMORvUtPDxQ/8ec78l62MYQQGUKapYp+fNRIVAzw0d/wcJIxNl06C4U4j83io5CcJhOub2tIM5XP9kjnJdDvjcwylcc0olOOLJI095aELjxXHHqOf/Xc5Q5wgSCCEde3KSs/M5Wd+3Oz1cEbDsi3BZJVRWXNEqIs4ubmPnL6DFo+kIBWGGvvP57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M/DigPr9ntS13MBQM4aZvaT5hBGjS+6zIQ6rYgbRTw=;
 b=k+Yl9sGT0/dBpyck+ZUV29KPEJYYAWv/IFJ/7Qy8pnI9/XUwaVFlf70SdPsqXYeExrgb8iKHp7zkxtZ8ccG/WVM10UfbG8+9mlemLqJ+BI1e+73daMT/1RoKl5nAVCHsOOoJmooUqI/iWFX3n+Jams7Gvm2x99TBpU1Y9p8mI9QNzLOYxtUuc45pP4GDBNnSQfGTrL61P79EqVGD2gJl1U07jD1OyfR7uBU88sPsQuU9yvnVSZvDuUBjqcQLJsGDbCfwDNvyfa24ZLKD97jFY/jFwezMcnC2xOfSh4VPdq7OVLi+vlezRDUXHZUQNflSXFR9uSqRfhVkuDFZ/6+CYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:19:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:19:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 14/15] selftests/bpf: Add bpf_burst scheduler
Date: Tue, 30 May 2023 21:17:34 +0800
Message-Id: <bd209c2426adc1a210b1ded5fc87f42dc833d632.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: af55f03e-9bff-4a36-7894-08db6110900a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XMKdX3ZY8I9TCkYsgwQWazI0BwduSOyH853nVjOEE3crijEOxyY5mXngPh2ZHNjyWsfWGTXJjGrA3MfmmS2jdGdVMkWEdnyyIf2Ytz/ZgRqUw55gYUUXH7hLz84B55bo6/so8lAYnR9pNEkwkD0XBsUpfVtWy/IHgb7FES00983YJl7c1YDM+oHQv4GMILVB8ZDo5yq6YW1Uu1CKlkueAxlow4kVdUqvPAOMJ6V4lbOZdoXb5piWxjL/qjDl6AFYSCWUpxk8/sBoDaB2WeyinlISs0hwS67GjEHyCspu1KNRSIUjXqDHIlU7HA/NwXRyc5zm3MIb1Mj+IEIjkd9NmSlo5lGQg7yuzOvbb/mYcFJ0gQDDxxtBT9364t3WBF4iAbiLvouUA5TiTw6PpiAmwYm+osQOseHstoNT0WaDn8ccs+EhkxVrIJZz6sCV8tV1z8WfrWJANjH2oCp+Py9mWnCRTRX/CQZSpB1XIJBgazkWd9B+U0MocMOg5AJXhGV2mNUT1MIunzAmBaLrOiYQeJ/UodNQNdvDN6EjNV+3B1X1mys4SgEbSx3bFNnIZnzW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgoiyIZJi2XvqP5cgESxDUZtoxYTElmFTQnmoqqoBW7VP+maALmFyf9qqunz?=
 =?us-ascii?Q?E1tnj7AFOCCISMjNbXiIDpvsKjZJ3BEYH3FY0C/Yy1gMjuIUuhx6n0JrSW6Q?=
 =?us-ascii?Q?SOzRCqRilK6pkdDrrFJPWIXn1SDDprN82osdsifO6sKr4xshcxooTsC0dbGd?=
 =?us-ascii?Q?g6ef7s8bZpeIC5g9HWV97K30sOUoPSsG7J2UZPlNQIF29wIZYe/cn06ilSRb?=
 =?us-ascii?Q?MJM6dcDceiEdSELW6auWSvJbF8uYjxrKMO1eYcxoq4KlUx4PYSvCrU9CATdy?=
 =?us-ascii?Q?HOVTCPMqrytr+rVB7cJ4CwdbFaYagd11lpi33zgtWf+AHEm+O/bRr9/aIgG1?=
 =?us-ascii?Q?BpkUKI9xIDn9chl/WsVO9FEwZ8qaZTqJBNPEyOhN5JRZsM5Q6jhYyKN9I4rX?=
 =?us-ascii?Q?oXyX5H1ASi0NU6k8kCEbcphkMDyZ7lDMJfbz7mccbZ077CO/9av+9oskX8ud?=
 =?us-ascii?Q?Dk2VEVSoSMRTJhpQ7NzrjBfYHOnXlyHv2hQOifye3tmXiHI7RhgZG/N7dcsb?=
 =?us-ascii?Q?gZDHkRkfcDedjjnD3ck7J0EEj1hAsysxJ/MXmrId7enSiHpJXBe0f/gUNPSV?=
 =?us-ascii?Q?/YJqD4eNwwASlQqn9ANLJLiFvBn4E4oMZu0Hfzgc8MsHvAHJlIX6OD13FW2a?=
 =?us-ascii?Q?mcmibcCw50zl53ZdOrz6Tz8CbfdY9Hy7kC78lL38DKq4B2AYXCyDMI7UEdlu?=
 =?us-ascii?Q?TgLzS8Zm0SeyjmYXG+nvvQQIxUx8wouMGBSPXAEev/yb2aXVp1l0PAKUdeaV?=
 =?us-ascii?Q?CMNHCrqiicKamJ1jCbSM9dGyQYKalG1cbSnyBO7lbwDP2Zd3ZtK+pq0rxHOf?=
 =?us-ascii?Q?K4XXm54ihgKu8HSP/YoPka1Dn6kD8xqvgEWIVZjYViUOwM3wBahW/r1VCtSv?=
 =?us-ascii?Q?fkCAfvpRECcMwLoKaIS+gOjKQZ39ifCD56U7fQjkeIyQmbEg/QWBu0/wdEuj?=
 =?us-ascii?Q?4Nn5wgKWaEMA/RQRFmNFlhHio83MgfmTjPZOEaV/qCw4fgWbU3GyJMkFgrPY?=
 =?us-ascii?Q?PjTKCw2JiEMM+rPZaVPkD5s8z1y/BKrFq0u3+rVa/bI5jZ8nXG6w3TzzHrMp?=
 =?us-ascii?Q?oVz2ccF66tD8o7jO1FEbs/5gguINx9nu9YnFeu01wBPkBZ2PNsSzjPkV7A0U?=
 =?us-ascii?Q?DqymbSRe+zdJOmouWhIJeiDRo9Sy5QrA0EofMCaaHhjn+UOZq1d8eCn6kQb/?=
 =?us-ascii?Q?PykewkAZ22BdQ27d4bfwbnYoqX/FSl8czvr+Z83f/O0m0vV91AWcZLS6Ilxi?=
 =?us-ascii?Q?QZ6XPNcuoa0j5apWmy+luJkEHQn8fXPla0HUDiViiGQqvzdTFTY0BFHNdX4L?=
 =?us-ascii?Q?OQXhmPXwH4KeyH7n4eC7fI19b5dhW40BXZpXcEIZLSHIkn2govZrSWah4PjG?=
 =?us-ascii?Q?hJJgGv/TzF9G+/fuhOqQas2M9h8NlgVO5mj9+9k6Zu2FhwmLTik/lCvl48e4?=
 =?us-ascii?Q?YM2u7zxfy/F477nrVWAzJ9hzNcO2AD6ZPVuF+OliUCElqiquv9PxF7bX40dR?=
 =?us-ascii?Q?iUFi8vDPyDJCPe+G/731Z7nWlab6Z9emTvSSPeMWOGGy5M+NYl6vMtXnyXkL?=
 =?us-ascii?Q?O9fbLX6fxU2bsc3dnmUdGJ4JI77YYzGBxr3lomwX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af55f03e-9bff-4a36-7894-08db6110900a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:19:57.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hgBZ1Td5OPMW2Bht0duUL/KaseUnL5E4Xhm5jU7oIsKFiBH4J73VME4QutATarb843HUAjdPYeMuBRHDVyGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

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

