Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC782568
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cCK+VsZ1Rstg9g8QPR+XiS98OOGOL7OFKiOjDIPpik=;
	b=Fb5pYedJ9eVFVTFG0yIPLZ7/lhpTm5uqL6kBxTi6hu73ZaxWB6H5WVsL+vlyLB3vpBxNR9
	qcP11S+fM2DuBy/NfuqffGsXaqIXEkcT5HrKzfzjkr6mgsNZ1aTh04eTWCMuZHBAD8orUN
	7Abm++pBTBA/q6aaMwMn7WCeM676B1o=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-htFIOrdtNYq0AVYl0M5lyQ-2; Fri, 08 Apr 2022 17:39:09 +0200
X-MC-Unique: htFIOrdtNYq0AVYl0M5lyQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiK26/tf4p3pxdpWfaSE07GydVqkkTGRftvBpiorZJkrGXchoJ5B/fbrT6V4MxnvYF2x8dCIVm4YMWgPLUckedbOZ1DnVrpLbDGHTCTy010fciJRfqaN1G7GilRK/6XcPd4d4rpd5sSUFo972KcSCoxH8r97M5aCe5VCoJNglvoQU+XGCOTHB2VwHTwTcDj0ud+yqgLlZgPUvzbJpnOScvD0QJRG9KOUgf347Ccobwh9s3YxlQ9+nySZFkMYRr77bo8yZw4DZyuZWyO+UWgkxfBGByki8gDFgLSXhdzcDAk1VGGBzTtmoC2U4QbCx6oXMtUWYMfHy1cFQZ1jInaAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwmIyL0H0SciduLqq9F52OP1oiM/JvfxPR+rxkBIcy8=;
 b=njkSKmy1XhJ667qwbi75xHhP78v2+xFc47RphdwdQw29T5acbWYP9ZQQCndjMYrrGWeM5nHOQSgBdO0tnLZ/wfPPogAYDJTqPnrZ3FBZsO81GKfOgdvmDS868ryQnA+CIEzrRO7C2PQLbjI56AnC/nmQ83G/my4yGDdBgFqf037N9vR/sYB5g/4Kk+NJO2VwGgMANSB0Qd0WgF9ezZOkCtcVizNrhQGKUFWI/mj/eKZmmWEeWVCW9SoBiAqhi8e2qkk4kMEeHLVsvDScV//8TWek/oA/N/wy/rfE3V7QeG+94A1OtN0vGTAxINkhNJD1SV7WnjnE1U0CXFhQXTh5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:39:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:39:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 7/8] selftests: bpf: add bpf_first scheduler
Date: Fri,  8 Apr 2022 23:38:04 +0800
Message-ID: <75ae045257ab014b9ad3001063485481275668d5.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b70ece-1bcf-4b42-1bf9-08da1975ea26
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995839FB1D541C9C0E633A4F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d/gYmzTcFzXXr1fdbYp+WquJl5/mARtQaxvZrsGzu24EQRtflKO2nDKf2mklU7GbexP5d9KkNEcXj9OEP/yIhoA/PJxW9Ddfk12QNmQLvkHjUDlHPtcZwMQzpNvcMWcWStxnOndYJ3XJYcKjsn07gjaFe2rWp6kOowZV7ffRuScxf+bF8Q7J7YQzZFMNVptRPbd7gyJad4apu70s2TUP1PnMmJU4boiXd47GO+y5c+9rHPwCPvrAVCJu8QlYJ9wwwjcUTOn+yGMz9S2PD4QcYNquz/2hxUUix9TXGsuUFGlcF4X79GeA1wmJcAgINMnJqqoekXKYHmIZmFrDXru3F6mN2BrbfRO8B9Hm94U6TdNhi8pFivT5bhFnmMlo32NHMLWZ3UocSM6fSGhWFd+gHBF1lK/wi3eCyf6rvzOEJKGjhMtcCii0HWuar7YVNpR0U0a4++bXQcLT6LFC1PFtGM9CUwgsCQxCqgE9dGAlY4dOkkm0Y9nmwFzS6iHGnMg+6OfeD2kCccJ18X+d5DaCN1pe0Ue2+5CRI5ojOwyy8kg5CLBSo8Kb0+mUrVqx/GJYyRCOmAl4q4durH5i0FWPdg5vc5xVfPFBbUuqVeXJDs7+blUd3QHcgHtDmno3T3KmodBGxlWqiBPGVnNtfDQu/Su0O5gGV8YrC4fTN045TWR2PlsYq8yNCRe/vAFG/ioZeqchx7fnYRN1UY30kjPl2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqQqru84mOhSM9ooOyEEhZh2z4copGzWsSygKJNPbHt13JEYGP4U3Z/OO1CQ?=
 =?us-ascii?Q?Lws+0yFJKjup3EB63CD38KIMhTd9JqwWC1lBRLkx7QTD+uJF/bnB+k6BYANB?=
 =?us-ascii?Q?gEAE7cr1giC6c23Me1BWa5jnO37s7F+PiLK08n7ehQULantdQuajR0TrPxTT?=
 =?us-ascii?Q?+fST5Av2/4AJzMMD0e+10QFqqy1Ao4E1DFbXwhN1f5HBsPWQDVbfybqshqQ5?=
 =?us-ascii?Q?c0XrhSIN+Zyta3gwWBn37qp7IMam1FZhHTFea5yIHwS3g/kRT47b0eA2Q3bI?=
 =?us-ascii?Q?79W7zBXA7CloZKCmsIDnCXhat0qPo7AE0scSitNVLvFDFirSRYdNxH/C4ect?=
 =?us-ascii?Q?73qwFq64+sTQc8wg+ezzLXoXDf3MlI7eZCba8+zUb1sv9cd1tAcb8jtCL3pM?=
 =?us-ascii?Q?xC6Ngt5hHXya2tVz7H7nD2gN96ucwCCGXFFw+YL0yLDuQbVQLx3zpO65Ih+f?=
 =?us-ascii?Q?TQMELs6CUIhIqgc419Z2dRXUWkOG2DJkoL/4vc0iBs0wk2b+tI30JoVuieDd?=
 =?us-ascii?Q?S2jIy6PCI0/XnKowZv0hGw3ynzmpOKUUtx2i6r2f3GUsyQRRwDB1AR3lAwxi?=
 =?us-ascii?Q?zGA+hpmkfewFYecbU2y+sxwQeczHIvjnWmuTvHpkEdVEwNMSgYntQBBWLZMS?=
 =?us-ascii?Q?gTLgpiutF/KOQK+KYYWVw10novGrVI7d2TCIAx/TzbH2NkUzxWDpgyUQgmzE?=
 =?us-ascii?Q?JHlGYP0PNDm6JlPTexThuBieD8Kfavs4SSx1FG6U9oG5n3PPpiJsZvq0xlJO?=
 =?us-ascii?Q?ZF4Zj1lAMzA2ZtmyNmhv/qZdkfdtf2BCQQSF/gIdu2YcurZgEcyMhwKWpcMT?=
 =?us-ascii?Q?s9tN/fFop8+ZvwUt6kRtNkB8/EQRuW1xKhSfFhKoFSOgUZy7n3vqAnlQRLE7?=
 =?us-ascii?Q?XiJ1L5ttxgKCx3zxl/1eYyBbnuDloDUx+62UaDLuoR9s73yLbUoXvsOHs6Kb?=
 =?us-ascii?Q?QYiKa4u7lVzsf+DpTAZWH3q4Cxuv3tUCWP+qa0rYR0URhGMiApoJR87pFv/M?=
 =?us-ascii?Q?sjsB4YwTYSB5CoPG+5QTGM31pFmtehmhG6mpku4tD4JUXqc5bw1nbTYYhMu3?=
 =?us-ascii?Q?zMv3vOeTxF2lBZRvNw7YKq2JL7GIsbMjF+cqevmgozJqNROW+FUngEnMCz13?=
 =?us-ascii?Q?xFKC/cb8UftYHBU1d4jDrxuBG0TIU1B20hX142dmQLxU8+zIxuGvM6862Ylx?=
 =?us-ascii?Q?t24ZZWr93sotbnVsVlfDQPC/+euCPyOWjt6NJ6Awv2k2oWVO45UGGIaoKb5o?=
 =?us-ascii?Q?2QPMTwZqVPmPVX0CtoaMfvKcb6ViM8fCNOHCjt7AbhJihv7/6lgE3JZJ3/Fx?=
 =?us-ascii?Q?BctRZMGRVKDRi4fhFl1d5Nm3c96S1wJKK20de9Ux+tZ1Hfyyxi1LMNP9V4HO?=
 =?us-ascii?Q?WdctXeglUSnhmwJP6QQgL2HTzrDgKan5EPZJeIUZY+g54Mfv2IONye4mjpNa?=
 =?us-ascii?Q?rGhaUAuYJsrh28qPKG/L3tXzCZGbxDH1dL+RN51ORuOMTs5kDjvPLZ4njYjp?=
 =?us-ascii?Q?hvLndOKG7/GCGwayRGVvFiFWLfiq355Px0NnMRBHN17iAp84/q2fsJJd8e7q?=
 =?us-ascii?Q?C0rS68qxnqKudbq4tbfwPwh7X7px3gYXSBj3JAeZ+P70w7c/WFIoyCF6TgKN?=
 =?us-ascii?Q?f8I/0X2gGjtmnh7AbR+59Jr/MdxQjMgiFmTeKVBm96WG0CRtO+dLe97Jn52l?=
 =?us-ascii?Q?58nWg0Fw2ANkRXJvDXXf31eTMZEi72muAalL/cOAOZ4dcT2GXqCRbar4XXH6?=
 =?us-ascii?Q?viyGmFcCeQw38swo7YeeH8fsao7ksh8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b70ece-1bcf-4b42-1bf9-08da1975ea26
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:39:05.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj5u91WONCsyTRUOLZoZWVmpx1UvQz8odTKy3TcE6XoT5DHTcTEoUFa+WZ2r4YGa1cW4u4zguYJpFCGmKjl/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index b5a43b108982..9a0e3e7766b0 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -14,4 +14,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *(*get_subflow)(struct mptcp_sock *msk, bool retrans);
+	void *owner;
+};
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..e9cf9dd7de58
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,30 @@
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
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,=
 bool retrans)
+{
+	return msk->first;
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

