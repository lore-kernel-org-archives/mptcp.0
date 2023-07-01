Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A93D67
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 12:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjEJGBWxpsik9TxcAUB8D3wrSc9U/bUaDDp5ni5YG98D7zaOG6eXs8K4qJNhcJxbeM6UwJ0h4ecuKza2RVge5UOLqUkQqCvarC62NAdRCNAFqsXaOaKn3VNFq7as7ZSfERM3WpNq1+6n9v8G9DyJe21JR5dBgPCQw2n/A1P0sukvSoUL/g79lmmuAN9BZXSoEzFy5EaongczXM+ClaiGKjhjli9n7TBxCZR4hEZCfRxkYSuy/5PGmhkhkDuXkrTAWC1u0YFTbV9vEaDjBuay6qvP7XBpAupy9LwpvdD7i0xnWdeLRwTidaamf8cUu98JKUPYRDXcFvEyGXNqr/Eqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnxtoG14x0dmnyOH/wzo2UmoJfRLpXfrvDltTuMZlHA=;
 b=Ww7Lnh2T98sz1Z8B8m6rRJ0MOH73kdCaP6ZdGhVLl8rfXI91teHK8ax5nxDEuvPz0hCS3xsCRKsSNCgnv1EO3s9DZv/GX/vibWeg+GVq58ETZuYDlwbvBjNAs9j6vdVz7NCo9OFXMiu95oZP5SrOLz2WpMxNORGHAbl/Hg+/hbNsXM67MYAWSzEtL5FNWGYE4V/H3ykYKmgP5XTC6hvL61XU/cxMoR3G1MU2SstrsNv48MUS+wGqOp/kLggHlsbrxhR3p28EmciiihuQq6Yo/PQqRnxkcOaXBkrpll6eh7zwvfmoTCKP/JasJHrxym92m3ZzbwYa/BrXUV8QPmHzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnxtoG14x0dmnyOH/wzo2UmoJfRLpXfrvDltTuMZlHA=;
 b=n+0DNwc4obgiwvQ0B/8v2eGMgLf51TxZHTVrLuuj1I4rv1UeE9uYeugq0UYqnP5BIU2KRikVGJI8u0FWTXxE55FKpks8KJqMTc0hHA3c7B01qClGq3uXxJUmDKZZOYs85B0Xjff2ofScFpWVknX3INFsdbZF7KAynERO9YcWaCm0wGvun1viro2MLgGeOeQsR/tqaTmC3Y+PcvikcmsuYYomFDM4icnM/N6YvYqfwJ/ZTRUsdSS6Qd+dsVPjl00SDwtmu+tlKNXko5BBVhABVHZlIMvYGLeH5KVdDaqFb5yH7ldoDajdBZ7k6dgGE6OobtLyLOc9QIEc7cybNj+RDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 12:57:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 12:57:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/4] selftests/bpf: Test bpf_mptcpify helper
Date: Sat,  1 Jul 2023 20:56:59 +0800
Message-Id: <0e4650e3259aace1a64443a5dfb0e7729f40e656.1688215769.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688215769.git.geliang.tang@suse.com>
References: <cover.1688215769.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a8f731-aec8-42e2-879f-08db7a32c2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MMteyj/9YkZZBdgxQlYy3Ef68ZVUejtR/NL8Fep5avjIwnwz/E5spXlx/Z+gNC/DorbXS8TJIk5tlp0xKUwnoqZllQbfTDrOTMxftSxH4KkYjBjsnM7Z9ui3Klq/DQDh7owJuNVi6FHxSr2ayNm8adHUqV02g+KLkWfQ1x+yNBDifPni14+QX2KHckkajYy3mUN3XtOEra115h9ptFmXjCBXZ5XIY0TOpW0hCqW+bcYoQBJviT3NzjoYKW4uPNRZxWk548miJKvMvPGdJpN4LmIOPqdaSz+1Roq18MuX/Z8k3a/dWNaz3jLGlr3+4n5rNf6pnA2BAL215z2/qBWmNZCfbJEiYyBe52lSIJ8prQl34DJ2/tim9tWmaBn3sy6enye/3nkbaPE4PmYzKP28IOAIT9E+ZRMIi68tI9zp8xliT4WZQ6szqETe8ak31Z4KYb8X5oU3L/s+4uRYFcPaPwCXctGLNA5eyG+3BE5ayzGYteoIWiMzSqmeITayO6dA4OsuunAl+MWQXNtVsbJ3xK/cobb1XH4N9M4xrQm8/QbRkyoIkWb5U1Vs6DmbBNtf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(107886003)(36756003)(478600001)(6916009)(4326008)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(38100700002)(44832011)(186003)(2616005)(6506007)(26005)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?944ApkOco/n8xAUoRFeWumQasoCYOMUUdZul3k+l5wWBzkJtRuL0RwkGPAMy?=
 =?us-ascii?Q?Rrewp164rMdetJH6+YBKnMPzlXT6rdtHS1WfEBOXVMvJzB4MqvmrqD8+QIMZ?=
 =?us-ascii?Q?ZDZg0K2niKJhHuMnCnXbd5Esv8rr0/+JL2HT0hMKyUfgSkOtKOJB/9lg+LHW?=
 =?us-ascii?Q?hTGcy6kpiIGdl8a+oT34URCFzMgJM7F99+/Mybf1jGazM+7LiELG52Lco9xJ?=
 =?us-ascii?Q?ju2vq0XZm1bhakZIZ3Y20lCnDt3a9mSPVCewIRwgb53CLmvqfwRMN3BqSHYB?=
 =?us-ascii?Q?KYDCPfeHKMdqF19grzt03ceW8gvVk1HQGFMTIwICPGM+uFxCELh0jb7rqvM7?=
 =?us-ascii?Q?lGQrEmxjzQB2D8G0Pi/D5ovUhlybQTkClVAymq2Fx2aRIF4BLZpK8/YdQV3q?=
 =?us-ascii?Q?1hFibQXhQe3B1HIZcZKBrtoz07LENEI9m43n28fKOXdsekmIMVg4pd9w6Z0F?=
 =?us-ascii?Q?N4as5OQI73pgJry7GoZrqnhRfXEyhTtH39iC1SdX7WrOHY9AbYDZgTZiT4VS?=
 =?us-ascii?Q?3dI9CynhfZDYC1Hc5hks2XjPW6X5qJ8FTnAQQauGcmuDHBxrfaVIuDzVVWFy?=
 =?us-ascii?Q?ImmAgSg5N2qIBSCyIl9aWnsUSXzPEfIxe5gx+9ISwyjR6Rgmn1WCBy4Nq2nb?=
 =?us-ascii?Q?zq/e4fbntsjdLwvEpL0Dn9zI52kfHT9Yt2hhY7RSB3eOYMUYvIPs7ZFtTQ4J?=
 =?us-ascii?Q?3HjCltbtZ9oPjxKdF5uOEZi1VVDNhdIZkWAw8wwKU3PUNawuIN0xIn1dgDqr?=
 =?us-ascii?Q?SFPxagVFZxH7d7i/oZgUqTYdPlADXqM2hUEQ+WCZcVvMWoSmb4NxrNuOo3tv?=
 =?us-ascii?Q?gUj0BT+VLym6D+Y/dWaWOUxU4OXilDwIwvpx2+M/K+FyD9tXsy5fH22LDOPm?=
 =?us-ascii?Q?fWuP6q24qzYPutS8INrYwWzBLG1vgx1bVFOqIcVcjvbXsU3W4G3l/wdDhoG7?=
 =?us-ascii?Q?bRJz5/0JxM83of0/Rg5RfzS3UzjqnC+Bl2CIba/6ExvhYz38McMTSM46Qxjk?=
 =?us-ascii?Q?MDIAJweiPxuqvplCV2ZxHlo+1nKSjHrTTSQskheqAMYwX1eFQst+3X2vHmhQ?=
 =?us-ascii?Q?Qe4x1AyJpANIbjM/LIeRs1w0ZfwSRydya7hVgssyjVKi9+1tpJrg05IKP3Ix?=
 =?us-ascii?Q?Ffa9rXaJYAk+QPBVgpp6dlwVjA8QXM7f3VEZvbn4L2967U1GFttjXRNSLDS0?=
 =?us-ascii?Q?uIJA68Wc8Mef71lbWiZ3aiOkuqFn+edMY5W2zY+9Oz7HJgVmRO9Lqy1bQK0Y?=
 =?us-ascii?Q?jE0bG/tCMitVoKFGCVMKLr9MGg2dskOPFqpXzkZuy2Eym/sWhFUA3638m7rb?=
 =?us-ascii?Q?VroWD+5m04lOTrJ8f+U5l6TbHZopbhNeqMTgxIf3MKMW23+mpboX+6PRAwot?=
 =?us-ascii?Q?kGvu/p/9tFZxYQfw7XSi5fqvrhJ9X/M2y+5rqqQg5X5LAns8unB+qfO+CXEs?=
 =?us-ascii?Q?NsYciqtH84KkqAbYtwAfGjrSYaiihiGiWu4LrO4cPbhvg+N62sCG7WL8PUiu?=
 =?us-ascii?Q?vwqtKfSiuv+/qi1ywS5uTSDlI/4oncfiJhML/ef8cqH4j5FH7mxMr4nXujPe?=
 =?us-ascii?Q?bo6AM0W22XQ6qB9mPdETIY6SRsJPF/a5QTeqoVSL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a8f731-aec8-42e2-879f-08db7a32c2f9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 12:57:44.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gkK6p+zxq33Wkut6Saff5fT16wIB/0FoLYfTLw9H1jHms7CpD2+dxH19DSrqYGR8h22XveW2sAb+yO4CAqwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

This patch tests the new helper bpf_mptcpify(). Store the new protocol
value after invoking the helper to a local BSS variable.

This is defined in a 'sock_create' SEC, so it will be invoked in
BPF_CGROUP_RUN_PROG_INET_SOCK() in inet_create().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 tools/testing/selftests/bpf/progs/mptcpify.c  | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..f846d5d62529 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -38,6 +38,7 @@ struct sock {
 #define sk_state		__sk_common.skc_state
 	unsigned long		sk_pacing_rate;
 	__u32			sk_pacing_status; /* see enum sk_pacing */
+	__u16			sk_protocol;
 } __attribute__((preserve_access_index));
 
 struct inet_sock {
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..f04b186b9c26
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <sys/socket.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+__u16 protocol = 0;
+
+SEC("cgroup/sock_create")
+int sock(struct bpf_sock *ctx)
+{
+	struct sock *sk;
+
+	if (ctx->type != SOCK_STREAM)
+		return 1;
+
+	sk = bpf_mptcpify(ctx);
+	if (!sk)
+		return 1;
+
+	protocol = sk->sk_protocol;
+	return 1;
+}
-- 
2.35.3

