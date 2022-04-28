Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBF7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jV8KpKQhTKoXw/ECUgbrlqE1/LWL5bWdyV6o+JDusO8=;
	b=et0EON+jt+EbhqT+eaYmfESZWmKgY+uEsyPpTfBDnyZZ2d5BfS2CqyMsjK6vZmnNFWVwRe
	xrg3tnXSHjP8u2CbnLw61WKNrh83qud5EQJ2PybRTgALwqbt0pk8U3ITYcdyOrVD1mWOZY
	XmKXJ5IMjHmTjlgpWfoaKK95kL3ckG0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-SPHhwM4KPxG-OhnJaPMuKg-1; Thu, 28 Apr 2022 07:24:12 +0200
X-MC-Unique: SPHhwM4KPxG-OhnJaPMuKg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XisWcKJ+OIHXRvZY1PhcuvTnV8ay9Pn4YjNqIcT0ukKfz9M+3cp8X8BEUq+b8PBE9AvQRVQGd0tw/1/kUI2O8rZXPt0aJFXaJPFW1eKPnGrxpwPa7pCxPD3eztBPVgpWR82DMsLR+yU2gjKIiUmZfyT9Ja8C+82JbsydGF6JJm5LR1TRSJ5Mx1vW3YbQz31TtFPHrbJ8CgwatnUbHFURT0jdWKRauWQF4o4NXtO8+/rHMj8snc/ZLWXm4Xp3hJqhJwMb/LVoq6cDIfmnDlx2F3az3byfJKziUv82FyVr6IgRXZ/KVXK4MA8+twAnV5/sBWhZjxEX36EW5KDFUJnvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/ykRk0FLAi9zZKdyacd6h6WXu4JmoNG3+DmvOYNzlY=;
 b=dtImqRVZhqlvkQr0t6UZQhHG9UB25I/Nqdd16FDn/MX1Oaly9BrMgBX8L7M4ClzR9VGTBKEwdEi2D+w7Z42oosO+Evcg85j+Y1DMXZvbij1y28Yl8LmoYrzNRNM2dpC2YAwejiZn5n5b8Wkucig1LHcROiWPrcWyZQU9Yivji2tK1wimNVTOH+k0ACVvaBtye1sEc3Q08uJAmxJSMy78LyqUrdfG4rQes9IZhymfKs+okRnFzMpOygXARqmWI3p8dcBtmvE2FCDqY8awC1fctsB4B6RCW6k3MtGY9+vQhot6jQ1RSicCYOD+/Pell/RDGMNLuSBesY54WPn3UPlKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2885.eurprd04.prod.outlook.com (2603:10a6:4:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 05:24:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:24:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 7/8] selftests: bpf: add bpf_first scheduler
Date: Thu, 28 Apr 2022 13:23:34 +0800
Message-ID: <9167bff943811710c24d8aa5f629912875110595.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651123078.git.geliang.tang@suse.com>
References: <cover.1651123078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7391e74-2b53-462c-c092-08da28d753b1
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2885:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB28854D6883775DBFEAADD026F8FD9@DB6PR0402MB2885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZwiCIUZnmqd3D5NtmxxXLNflrp/p2iJqIIgMbCS1MHUkvf6q0J6SAjGWL8nv7DaTB3/CAxgPWwrafEKvLvFmWhuhADzU2gx52kQlqdwDNBQZRh2jh/Fxkqr9ZycGLfqQPoJbx7coT3DxZBfaAr79RB4HTvDw2sz4HcOpz7yqznNXFKpzMKKD2hijHiK6hc8z3A6BRKJMVcYVYNC3f0RIf+EVnQwW+Wkpk50BxnJ3vuf+TZXuLon1XIwXecpgdOaxIG1lYIomUgBk0nIGsV6SQ94yoaqmuk0R7kgIydpvzdPmaqtziZI6PVHXRqyCh9uTQ30Jw9xgxpmYeb0nNE8i1Xi6Lk88ZBsPobvmCbbdP7WhKY59F8s18YWJnWnl4B8tAQC/C8rUmdKZaNwd7XkK5l5O3JPYc8Dm+2gAeADBub3YiQDdToA+5d+C4eW1kBFDtA1OYWxLFkj81VvsaZxcIk/Uu4hH8LmkH0fdWo9FS6/13L2wfGnD+rI/QF0UO+swVLxeaUb1Lif3RSlPCjYAAQMnlgIUF1WDOLU/zgYegIwRqbaMkf2DSBErur3s0m4uVpyJKZ7rWIwQy9467yve0IU3+VHR2ZggdRW5OB6C2wgMlvYNoBUWgTJsxAnhV06BqSF4hzaEQtwxYODoSnBV7YEAacIybiV5JIHHdMzhV/FOhuqsUVfUz1iBk+2EqvOgFDah5tC/4a/Y9I14Zqs9OQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(6512007)(5660300002)(36756003)(2616005)(8936002)(6666004)(6506007)(66556008)(186003)(26005)(6486002)(44832011)(66476007)(8676002)(4326008)(508600001)(6916009)(86362001)(2906002)(66946007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QH/09oRQYwRG1JNrGwQGmPc+sk1Rxl8po9Df/jLwrOxDlStdxL/xgcLvC1pr?=
 =?us-ascii?Q?DBt5H804+pb3F09ZPabtsSiXlujUoR4hL7fKHhAOLBYV/gFFZpm/ZihqSsW2?=
 =?us-ascii?Q?S45sBElFIHli9p5JWBLscrKKkeVQw0G+bwfhlyZrmzely2AlOm6olbJDsD5i?=
 =?us-ascii?Q?m4mHNwDeSPzceUroq/wmFEduBSevVBEe0TsK0ARfBSdl4pTTYfq9b1Q53x9y?=
 =?us-ascii?Q?jsHS/8crHQzHvC9oyInjUQOimD51IfpgQiv1/ErebNZ982lzQvwRIW6a925i?=
 =?us-ascii?Q?ozrvgRZfMNeFaPxgHrf3O8o1gZ3rvnATynyCqM9uIskgj4EsyYpUMiVve0eU?=
 =?us-ascii?Q?jcBsxbcIMzpk+k9UiiMbzOb9/XYEQS2DgtJeqDInixQO1bIvsLpA48NxUsoH?=
 =?us-ascii?Q?MPEtbrZCtlgSpqlplUQmZy98Wp4bYZobTlBOKB3aBosr5T6hjJL/nUqiq2FJ?=
 =?us-ascii?Q?TU+kipPcJZbr3W08Y/cq5PUEezrgqkHQFBHNgcbxjkB/ZhPeBzIML/Ofos5g?=
 =?us-ascii?Q?pQuT89F4k8i/jA1YAkXOfbC+IYseDsGQMuQtVo9unUbna7gHcOs5zOfBHUR3?=
 =?us-ascii?Q?tDN1LQqSCvNdwdySMuNTnV0a/l3tgSZEdQyksbu5h7BHB+GjoBbbMgypxaqC?=
 =?us-ascii?Q?lK7g2SIj055hN5eDnV14uEbp9N1kYP14sC8arNZp/XVfeH/bHjdycGPpCmyV?=
 =?us-ascii?Q?k4qnXg89iZor0+C7fizbb9+XNNmjoBfBFRhdnIY6nIZ+m2ZHwizy44mXhu52?=
 =?us-ascii?Q?mr+V69k0Dv+JHnSgloqQISHf+jGuTDXvA/YIsrxw0C52dggvf5im5q2OTxWC?=
 =?us-ascii?Q?6hA9/pu/rC4QY29j8P/tS2CvVqExHtLHDucBL873Z1HuNwYhVvvyIoP98Etb?=
 =?us-ascii?Q?txycUjyYisrECPyk1J+nD7sp1l0k9nQJ306O3WCf8i+ofiThJqoxfpsDF4Ci?=
 =?us-ascii?Q?FElpPNGM1jf6+PDq3xUhLYUzecmzFITPfMjliEyQP2vFmS/xfw/6D6dA65hA?=
 =?us-ascii?Q?vDHbObVvkWIceo/0e26j5tDqPu9kJBHKNzYtiSy91RTeFcnPGxTHxCNG35eU?=
 =?us-ascii?Q?5BP3vPVxV0I6GrIQ48qaD3Vv0goEDgo/LpjgjqbWGc9q0OR1EWjYx5Gi55lO?=
 =?us-ascii?Q?XlvrSLQcDNkfLlAFDo8oj3ylJJtQpfImNqF9HCZtXsaNSJk4F7/tzKxD9WtV?=
 =?us-ascii?Q?4ORtT8TG6xc9xxCEAByMDMc5QWfcBB9fJLFCRto0jPzgOil9oE5UFcRt/W9m?=
 =?us-ascii?Q?3qov9WA4feasp16FNPYZtqoz9Nk2rIvwzTMHUCR3syRCTxrOAXtqexoQ96oP?=
 =?us-ascii?Q?Vn+dQqatvorxik3TOc+4YNwekP0968KjzYA3Y4O6MIneDTs0/Xue4e+WRsLa?=
 =?us-ascii?Q?YDLmXA3TzOvSN77Ui1L5uACD4f6RLKL3Ji4lOh1l3A7Degs5MktMEQC7lnsA?=
 =?us-ascii?Q?Vy4kiylvS2jUhhR7duDaNmno6qIFe4E3b8cFgcXc3McLcqtsh1wW4d9hF65E?=
 =?us-ascii?Q?R1scsZNMi9ZKLRnsg2v776P6F+J1RTNnwvfQek31FG7SRHF3xfJeb24xG/XD?=
 =?us-ascii?Q?rCgFopXz9zGTXAumjFaWFF+oe3r/V9r0BEyHHsXpogu/X3vbkLrs0dLLdZ0s?=
 =?us-ascii?Q?kIzNtiI2V78123dyJRc5ZiWiaMFARfErDpvEQmInYcL9Sv8g3ZrIjAJw6D3n?=
 =?us-ascii?Q?rLcznWm7nGgkJaw4pfE9X5O86TA1cBsDCOi+iKJey5s9kAD+mHMU8AEccdk+?=
 =?us-ascii?Q?CwDqRDswF4H4Ip0lWQiNK/mxPvryCwo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7391e74-2b53-462c-c092-08da28d753b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:24:11.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iifyT4l2dCQC1ITIMQqntYvm8Ziz7JS9pknpKNBmjhgJOB7ZzyAVlNRZBvH0avZevLEbUfnGdk0WES9/N6CPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2885

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..9d3cfc422366
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct sock *ssk =3D msk->first;
+
+	msk->last_snd =3D ssk;
+	data->sock =3D ssk;
+	data->call_again =3D 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init		=3D (void *)mptcp_sched_first_init,
+	.release	=3D (void *)mptcp_sched_first_release,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1

