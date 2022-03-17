Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587642F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJByU1y9lTFfWvuTjz0s/ZNdj7s68LKUZq6/vkbEpJM=;
	b=e8vHgse/BBWJl3svKjV7aj6gYO+yubIUSsdEy/3onyrzeduGdPNoclo8LYgWELAnhUTkuA
	NOzjoWesxQGSNcL4LLvgIY9OBe1wTWSRJluyLz5QGifNK2A9MFwc58LFpD+n88gknebS0v
	JTZL2uA+BM00Y7nazCzYFmRRVJNXkYo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-s-cSokZtP0G6I_wv3RI36A-1; Thu, 17 Mar 2022 12:05:15 +0100
X-MC-Unique: s-cSokZtP0G6I_wv3RI36A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do1VeSc3XxJ4m43xe6h5WC2pbEYIwQE2oXQ1gh8ElHYgrrP0qs59Ru4nteBOHUcc8ddj8snzUvbuAIMtQ64jTs+l+W84gGHKlfoC9k60e/10T+n5vZ/1qnju1sHTGmgnabOeFGr+fOhCCNCK9r6C6mQRlzZE2PGZRL7B/NSlUeO6jD63cH/H4bJa7ezYaWYgjo3g751FBgVXygKMyPJ0lXo9yWeoK9vGsgBDn/FvuHkSdC3Fcte900vaTYDB1ldShY1Kb/h26zQtG+XPdGfTZVngRlvZm83w+AUTcutGN2vUXU3MQohMDgNJ3O4ze4yrCOYJUwJpANWCuYK1y3V5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Em2ySjHZkmDPytKbR5YlhVFD8xJjmoP68oBRdRFGC8=;
 b=AVql/2LtUI0xNsaFetitsjGZRJfhuZL3QJt9pCoWH3DTypV+wBs/OHSVeopg32PvlxIu07qpmIR1sCrmT+OpQRBwY5a5lgdOoxi0THCYJFItnvmxMWxqB0e1sPLKRUnwlVcR4s3MXF8neQ4VVHQemPLoC5nw6eY1Q8f1UQHIa0zEdQ9ShJL9HNEmX/ksKqlHsJEnwJAguBU1SbR28a2tdhrPv0ngsFaNBXje2QJQGOx9mwWhpoLKW3CCfYrga87jFHiqswUOrh0MO4mXReLPqrt1JE2eERy/zftTMfLrsqNS2n0aELbmJmyH9fOODvcDr6dQtnNnvQNDBQZukIXQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6256.eurprd04.prod.outlook.com (2603:10a6:803:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:05:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:05:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/5] selftests: bpf: implement bpf_first scheduler
Date: Thu, 17 Mar 2022 19:04:45 +0800
Message-ID: <1fa592f2770eca00d33baf2eda3c264acf368cfe.1647514852.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647514852.git.geliang.tang@suse.com>
References: <cover.1647514852.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ff3f95-a635-4897-7b65-08da08060303
X-MS-TrafficTypeDiagnostic: VI1PR04MB6256:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB62562223BFD8BD2D2235BB86F8129@VI1PR04MB6256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ju68vvT9gr0uaLd+Wpm+MfzhQcykBxM5gc/aIHpOTD7MOlsg50AGnwN7Z6LblDIqTOPz91QUNRgaHuxMSH66nrMXAyYPBTjULioBEE8M/FEjag316uT+WSuHTpVI7xVO1b9QwdXMh6MQwlAPQA1mc/3xZGFoRzO22UKZTn9qS30Vruj3Cud5x4e2JI6KwTBscqYX14eAw20Eumv6KGgNlf2q6D5QqtitVKTzYYPfEpmkD+wyfmIhEKRGIQpIXHpfaqyiqj74fUBllCeP4wKER7SmPIhHHkRLBn8oP/D4D4SvusdX0vk7MI9+FSMdpsAiSlPsro30dFIzD/nWG+k6U4rHmX/4usEz6312tJCyb7WlLoT0yafOTa0s0YOJ681idS+0de9c+tsNjmBMLOgFd0w7CVcaa7oDfKuSIsH08R92yegXuQocIW06bUuqqaScvip3Q7pD+PqfSEMCd5ya+ieR7M/Nl7ZhgiJY5NcG1feRgjy8P6hXtLsethsJ83yikSMszjSQhhkd6ePwWEBv7Lxm/G1CnpgAl5crf6eEMv1bhA/Efm5fw4JWHGXAmXRcmqR2BBoNxgXqVQODSFfBmRrMc+8NBJdFZnFZFla0OSMoW/fn4MVDxNwM7PNthsrNLz31JegqEkRxORVngGyAt5QyFEYrOtAotKEpY0JNpwCUgUO6UKyqXTHk+4YJGge3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(8676002)(2616005)(107886003)(26005)(186003)(38100700002)(4326008)(2906002)(6666004)(6506007)(66476007)(66556008)(6916009)(66946007)(86362001)(44832011)(508600001)(8936002)(36756003)(6486002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3SU0VYVdMq73tAO9PD+L8i9WtzJLBxiLhc7lGLDIXB5lgXqmyugSMcnuvb9?=
 =?us-ascii?Q?8Lm+vFIPrUi5LbA/qUEA9s+ARAE1YqfbKybioKUCBNKKEs+pGB05m0VrhiI3?=
 =?us-ascii?Q?c8SNKAh19HJiZu6tgWjWvotmFslSH2x13ZqwOhmdEsaa4f4WwheNPt3pdB4j?=
 =?us-ascii?Q?2u8Wh8GsBJqqREC78Kj/THoz9K9yhW0EeCz/weOXMWpkqqDsPBsYKd9lxO7w?=
 =?us-ascii?Q?QkSg13N8L+MnyfUtnKAS7yJScW6CkZQay6WejJviLDbITWG4pGw7KphvrCX6?=
 =?us-ascii?Q?YiNU95aBM+POP4glTMGh1aDewvsijLo9CgxKuA3vByko5arHp7AVuVl7wl6n?=
 =?us-ascii?Q?lomEusjYYarcLLjn3GbJHLO5JhxE9MvQC6eZ3NYRl9r4xMvQ6RHrurB3Mo+4?=
 =?us-ascii?Q?W/oB7lMdEuppBC7uSAQEBuYNPRAJNIGHXG5xBe1Pm0JDH4KuQ1iKzlXV9Sj0?=
 =?us-ascii?Q?Qfp+XgX+PRBmueH7kW2//UPQ82zTixVw+BzrCHt/zCkMbjyq3py04mMHhkpY?=
 =?us-ascii?Q?8juGKyG4ew0pTSjQJjQWfDB5XL7czBbDYOKfvChBBj2E2cmCv088E2K3/0kj?=
 =?us-ascii?Q?1MpUSTHKB/8ZuCOASKOi2Z1dRuLdAblqiWS/LHsizSaXl+P71dfOCEx/LFih?=
 =?us-ascii?Q?qvkwBAd5/CchEp2wpyqAgv2SzGgGzRQQUw4w6gR5NoFcVXCbIZLmyqdOhrXj?=
 =?us-ascii?Q?ENugUPBpxDsDS9YAmG6x/Dwgf0HbPJb7PbttACYgqZ0VJQLs5zvGqdefRPum?=
 =?us-ascii?Q?36Vt6b1pcKfbUBAoigf8NqF+D+ENV55M/Ed3pLuOD+c4cMsVgA3K6NbD9PFn?=
 =?us-ascii?Q?MQHczJlXDqSAfi2W1tU+O2LhxREZqEITxEL5hF0PuP+o98IhPaKQy6kcVBQi?=
 =?us-ascii?Q?7KVz5Mw/C1Yht3i98AJD7G+13LIB5MUoC9IDadAGiD9ryooJVtXBSWKImfTP?=
 =?us-ascii?Q?tCvP9/VC3Pa0WrSDgOLaqALGsg7mE8VESRXy9u5xVU2yEz6k07dtsx6WKhS2?=
 =?us-ascii?Q?hAJl17NH8VEeFGU+n7bKT8XH52uLN38neSOoh9QG50hrCwetkytR4cCiXfd+?=
 =?us-ascii?Q?foy9O7yWeegwbEsQJnNPerGa6viXnhKXuNV6ls5LnDgtqsTCJPBg7oD/RM5f?=
 =?us-ascii?Q?V+Hzbui1YcX5fg7Jhrp6EECKo/1w2uIbkGfHlAN1ebHtQi0PCRNXreomlg1T?=
 =?us-ascii?Q?ALBmhGMz3JimluwRqYimouiXf1HQvZGdOaKRRfDydzkMplimdr1yPRkt3q2U?=
 =?us-ascii?Q?pW+cKXN/Ml4XCauDwRlFLipGxOuy3GV8w0Jz0iakYvIHfRBE6410J1PJmRMJ?=
 =?us-ascii?Q?dv1QhLU4sMnjLut0SUjH4Uo7T3C5ZXgAGbRgyh3I9cB2aauJUCA0OzRy35CI?=
 =?us-ascii?Q?ZNnetkGaGoI7kq1XdpNG9WEwFUJvQrjT+hZJO/HO8+k2/TZ6oyIRE4mcrJ52?=
 =?us-ascii?Q?RzdOZRmdUndq9OmYM7mWWU1a8dsZaBHzxeL3bhDTkhbBvPp9SreU2A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff3f95-a635-4897-7b65-08da08060303
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:05:14.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7OwgGFamKsII/CcR+zv22lIJaKU7GepyZdS9SZHY05AX9lKkNtBpcXOxjuWgC2IoTvxKb8J891eA37wuW7f5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256

This patch implemented the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 14 +++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c | 30 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..886d6fa100ce 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,20 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	/* initialize private data (optional) */
+	void (*init)(struct sock *sk);
+	/* cleanup private data  (optional) */
+	void (*release)(struct sock *sk);
+
+	struct sock *(*get_subflow)(struct sock *sk);
+	void *owner;
+};
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/=
selftests/bpf/progs/bpf_first.c
new file mode 100644
index 000000000000..c30a7cd3b932
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+char fmt[] =3D "%s";
+
+/* "struct_ops/" prefix is a requirement */
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, struct sock *sk)
+{
+	bpf_trace_printk(fmt, sizeof(fmt), __func__);
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct sock *sk)
+{
+	struct mptcp_sock *msk =3D (struct mptcp_sock *)sk;
+
+	return msk->first;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init 		=3D (void *)mptcp_sched_first_init,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1

