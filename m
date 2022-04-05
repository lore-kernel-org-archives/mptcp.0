Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C615A5
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649145211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPYZIgeeGh3Jsu16ptEas1eiGVhJlV8x1PzOtKjsGb4=;
	b=XJsvbw2dCJSUYXbkPHAKO+TZ7nHy3hSeki7bn61emdxsCVQzb1ScAftYSrJmo3e3APrB68
	5t8Poq0A3RNqncli3UvHy+N8q6u5HCfwHdRH3VlyvTD/vAO8+iRPx5JZchvDKu/MvTqEdd
	aCB7lqG50977SZ92mEvyNPbb65OSnZ8=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-SXMks8gxO-aN-QG6GypFKg-1; Tue, 05 Apr 2022 09:53:30 +0200
X-MC-Unique: SXMks8gxO-aN-QG6GypFKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKGbBwoQdmtVBqLKIsFXANHs5gvzgJSf9VqsS/PKn7rDtAVh4h43l2Ba6wVZfvJLBbS6dhliBZXeLH/MfcV9kCLzTcCi79NJupQ05H2qopsNYNoXVmts3IueO+osqUw8+IJI5zXNCH2/6dHsey9+5hlBhCjLgNyPOiRRJVf2pqBvEVqUAROne2+lkuG77kPUzo0cJ09kK8zxTVB+k7VIHYUGxF27pwJw1hgx4ZjEIlbcKXoMM6Sr1fxmQwhBW/11+HKPHN2drbBg8poq+0wLmjKPf0KR4pQVNN8TVH4hdbNQ+s2LNJYKthxmdYSagW/+O0vHb2IRDlG4dUbJ0bRJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H58i5Ml5vGEYCG9ssbsYP5F+EhrCZ/SVuUksjLT1Ldk=;
 b=UPP+yt4767k8WKmK0BH4sYCPBZSFMeOu/9tvu63qrQec9z+ST3y4k05U8s1bxALPku7FMWOCQlKOrXJQZo/t38Amj+zJD2nR9fSYMAWsleg5XVqHGSeBNEwfFr32oVYrMRG0+b6uN00haEmB2bthnnBhQzJotQuEiAMIlpgDtLCDwDNOMngX2HJWD4CCg8PTI3W2NfzDX9HMVRrsS0/PCpOn6yQ3vi9baUjpyyEZZ+MXYKKlUwtucaZiKEdFtA3L92outbwvo8M0g/N8fe99DyPO2yTJF+aDTclodEXqdqUQMbvWO3n8/BoJcHhJEIE4aUzaNiCo7xCO9GY3tVMV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4950.eurprd04.prod.outlook.com (2603:10a6:20b:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 07:53:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 07:53:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] selftests: bpf: add bpf_rr scheduler
Date: Tue,  5 Apr 2022 15:53:20 +0800
Message-ID: <dc8ea0839231d58bde89bb1c350e0eca335ed878.1649144853.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649144853.git.geliang.tang@suse.com>
References: <cover.1649144853.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0104.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed99988a-1b30-4871-27da-08da16d95f25
X-MS-TrafficTypeDiagnostic: AM6PR04MB4950:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB495073B14CB403890116C9F4F8E49@AM6PR04MB4950.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z/4eUvLVmJ7aC+KSa/mnUOmLXpJqG7IA+O+DdEoC33zpiU7/jIBMMoVXiWzXtvGcQoZmkuTRSLh6gPvDtGY82rnmc9K1tojPWrNvGysNvl+wrqgYaI8h73P6XU+FHt0gEIbyOxPXMsKQlXUUSGYbwYqlwiQNhMVXgovFZB67+wnN7exCdB7QSjDfq3FB5xvvB0btB7CCQVQ7M3t5A5Ag5DGiPa/2HAaCo7y2USC5qGzOILW8pmHnXigTb2Z711974CZOl/d7P/+dGjVJhssJLPTm/bp5lXEk/M5/hJzbx3xpF/LkP49cmDVrP2wV7FlCiajEAHD35Rg/JfGpkgSPzR4S1+eE3hPohLOkD7576rCR8mB5PL426pg4XdRDKtVKWALuoDG7TzXXWf/8NVfTcjt1RfT7oQ2aWd9YSSeLdQflsyhF5gzvG7K+2pWosANGqs7dTRMHK/odn29zVZ+akvzXAar+hNHYM8ShUIq5oDrx72FReyj6owoWzNXtwjDU7ixNo1Rm7Ut6Z+BEOivhN4N+r7QW9IqTGFwOrKZ3jCNVztY/NYL0yQviOj7BQMFT1ydTlR0mEHUrJfczJU/sz7JoUbFyK005XXBXfRgGVXJe9mG0t5RlJj1yHWXBUfzd8zd9I58+SNGdx1xXoiAXcoKxD9reUy4Wq2vbCEEdB/Fer+XU5ZeC3+CbeT+g/6QYWMtqkho0EkX7Os/EFsJIYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(107886003)(6506007)(2616005)(4326008)(66476007)(8936002)(86362001)(66946007)(66556008)(8676002)(2906002)(5660300002)(186003)(6916009)(26005)(6666004)(6486002)(44832011)(83380400001)(508600001)(316002)(38100700002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jqr3cZ+b5nqCdMlpDUsRSdbq2Rk1NN0fGLrv0X9aXmJTEA9rJLPnWSAOvHoo?=
 =?us-ascii?Q?fDKcGau8lnps+OZBbvhhJgXFC/LQu4mfha0nur3Eg9QfcLAGkwmDi0caVYZB?=
 =?us-ascii?Q?7Ldkr6DjtJMAijXgCMgK0Debsw2Kqik5nZ4iOGBoJSSxWOan1/aJXYYlSYEh?=
 =?us-ascii?Q?QxAmhCYngWc7iYJnf8izjaZvffy9YXAI+KWWwHBSeTJ8uujjJGFJynhg0Ith?=
 =?us-ascii?Q?MHRE0Y5Iv1zi9UEkACF+EpuVFcugwMoGmURAxkWb4XhAvoXFAzKjoGgoTCcJ?=
 =?us-ascii?Q?0+5ei54ZaDKXPCEWhHtfwlK9MVDC9f5hSAYSgju6/ah1ip3g9iD8p50t0TTB?=
 =?us-ascii?Q?nzSmcCjncoaSsJByxPUk+Cgic7QvreMWs9+j8gHX2nK84JpfwIrMErhuxJ8f?=
 =?us-ascii?Q?ZkWwHTwtYoErhZRWCEm0YiI//QP1Fb0hUBR2aN22v0HnFZCmYcWIjdzfA0Uz?=
 =?us-ascii?Q?TAdEOibWifzmmOJRgnCWfxWI+EjqdZDipoLjgFzJ6+lJn0Wk0FnziDpSNDHj?=
 =?us-ascii?Q?fNPIEbdGlUUmtoOQOLB43waHiQ9nIUDYrenG+Gm9FXIE5iWH3LulYuuMHX1v?=
 =?us-ascii?Q?IwG+hRJcdp5bkV/dtYhffHmfYrYxYJKdmX+ZuavMDjz2+m8PWyG5a25SUJXn?=
 =?us-ascii?Q?wdiMv50jtMhtYhGkhV56lf0+0L/Xc0zflSW1l0iPJz8seWRqJy86EGJr39iY?=
 =?us-ascii?Q?gFrZJAhI0Zds2f31E1DSlTHGHPzl/jmvsNfJFvcNSt4Reoo3EiD7mYhyq8uH?=
 =?us-ascii?Q?ggwsZ1RbrUo+wRvuqeR4w3L5DsX7ryKE9mXYc8OwGldE0MpNV0A9g8CiYw7h?=
 =?us-ascii?Q?fEifjkSCM1p303DJrv00TbnOT2zOAAMVzzemadrtoXCB0mTYY6xbFFVENXBj?=
 =?us-ascii?Q?yL17WohvNCeKvV2lo2mXlYKtC1RSmtRuItjTiZJsW07kORgA+JeqN03yZxnZ?=
 =?us-ascii?Q?HmDB35dErSes9IDwvFdWlGAQGkMDZoYl0HWSJ1I06/UyjpIEVit+Do0fLoZr?=
 =?us-ascii?Q?9IurD1ldsWALuR2rQBRtjl4cU2wGDpcAh9Bjbik3i3pwbRDq9SV62x4NbqoV?=
 =?us-ascii?Q?ksMK7vLAriwc3SE6X5K1n4AtcCmId5LGQtvt50SMMIIOtPXRRVIatRUysyWa?=
 =?us-ascii?Q?wa1bgR1X43Lpt+fPBv+2fSDWdC4rcXcoOiCP+2gTrYkOeOGRqU/FQY3B5wia?=
 =?us-ascii?Q?A0q8yvXnC7IypHXlOtknZQB3YsJLM1Lzy/gPZr6ZFA4QEmAUC+5tXhaE7go6?=
 =?us-ascii?Q?ri19bEUe5wcKCr1JvIyf+dE8KNTljXRrc31630UpdMq2SxOz/dm8luATR42s?=
 =?us-ascii?Q?wdJJGHCrrn0q3DlzgO9Al6t5uoyiDxyqfi6z30wrKaEVGFYE2+vxdbrJtA0K?=
 =?us-ascii?Q?nbbf93sYpFPB2KKY574wk+QEax7F1zcFZ6/QYIWbpES2MVkaFhcG//+F0oAK?=
 =?us-ascii?Q?vsUufqNFg+R1I9xATwFxrnVLMlKqHnFs97/MB2IYeZwQ6kV4GuTIyc4hkz+9?=
 =?us-ascii?Q?qmJnAeqUyvsqHzRiKDWcnQ/JOcHkYSfE/YwOL01nmNJuFHIghaW1ZS05R08a?=
 =?us-ascii?Q?8vyK6iN6JhiHB0ISIyvZ0XmOzCHEhzRBIhQA8aSVE2TGfqXKz2FHw4TYZDd6?=
 =?us-ascii?Q?tucH3oTMs3RiXpuc+zB7uSyEcjvaO2inSrUdkvHdNE/DmV69tEU6mBgRPWyA?=
 =?us-ascii?Q?WNhfes4mZkbdi9XqPAdzX1B4UIJcEEx/BZQAEKuOfEF4KeLgeGg3R2nGcVLv?=
 =?us-ascii?Q?c80zTJR63+Lkih9psae4IxgPfmIMpj0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99988a-1b30-4871-27da-08da16d95f25
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 07:53:28.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5x43Dct53VL+DE+hsyOnxTc/rZWeUq42jAXwQHJmUTeHQMAnCEllUPCpz8fLySEXYE99utwSzBABIx7GsFJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4950

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Use the helper bpf_mptcp_get_next_subflow() to get the next available
subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 27 ++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 42 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 5135eb6710e8..972fd2e56ed4 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -26,4 +26,31 @@ struct mptcp_sched_ops {
 	void *owner;
 };
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	__u32	request_mptcp : 1,  /* send MP_CAPABLE */
+		request_join : 1,   /* send MP_JOIN */
+		request_bkup : 1,
+		mp_capable : 1,	    /* remote is MPTCP capable */
+		mp_join : 1,	    /* remote is JOINing */
+		fully_established : 1,	    /* path validated */
+		pm_notified : 1,    /* PM hook called for established status */
+		conn_finished : 1,
+		map_valid : 1,
+		map_csum_reqd : 1,
+		map_data_fin : 1,
+		mpc_map : 1,
+		backup : 1,
+		send_mp_prio : 1,
+		send_mp_fail : 1,
+		send_fastclose : 1,
+		send_infinite_map : 1,
+		rx_eof : 1,
+		can_ack : 1,        /* only after processing the remote a key */
+		disposable : 1,	    /* ctx can be free at ulp release time */
+		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
+		local_id_valid : 1; /* local_id is correctly initialized */
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..0d0f639c8745
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+extern struct mptcp_subflow_context *
+bpf_mptcp_get_next_subflow(struct mptcp_sock *msk) __ksym;
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	subflow =3D bpf_mptcp_get_next_subflow(msk);
+	if (subflow)
+		ssk =3D subflow->tcp_sock;
+
+	return ssk;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops rr =3D {
+	.init		=3D (void *)mptcp_sched_rr_init,
+	.release	=3D (void *)mptcp_sched_rr_release,
+	.get_subflow	=3D (void *)bpf_rr_get_subflow,
+	.name		=3D "bpf_rr",
+};
--=20
2.34.1

