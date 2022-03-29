Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F420FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwQo84Ioi3cWP7i56o3JEn1BeyJtDLKugLYuEqOUkFQ=;
	b=M4Y/zMpYEVQsLiq4/eDxEvYaUs3b+gysH2E4uQOVJ8Ye8MQYswXCzHergNhwIjzFi9XupD
	P5ADJOALMjneyWzWvH4MlAA4vapd578eHJMWKEx2KKgm+r/hRvPPitUSCDWQlDaUkrHMsc
	5Q5y5MIzV6PRjC2TD65sHNl5lOVM8k0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-XaucOW8cMdCCGGgXQeJG0Q-1; Tue, 29 Mar 2022 09:10:19 +0200
X-MC-Unique: XaucOW8cMdCCGGgXQeJG0Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdoXi5Up9C+PXi/0z/is7hn2AfdYVJhRHukYv22vin3er4UxXzaaJmk3aDfXkAThzZOqCN23VXl+92pnWuwV7CntSG3vctcd6GZyUlLV4aVh00QQmuSdpUJVOMfCXlmARvx1ddOGoP3gmQ0UCm8HkcGhF08zci3OoZ5Xkto5YsbIdWCdTks0QLnqTafdR+vkLTFL2VGFXyE5tWbNEEQISlfb7CNxZePoKHhIkDEigsZMrfRDOlxQZI638YPa1QJ0YuARN61ijMeJ+d4GebamWPilIVMSPSV0bjU0BCYCGtMEpIZpEPs01eLGU5aN9rfeQ9/sPS5H0oXydqH0L0lzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4KNt07m/ibxXdhnDHr1bnpr/qhcffA4QQpMG1/5N6s=;
 b=VM4O2DVDaPle2C4P/+nKo7FG5ql6B+4ODwMrF98BVa8/OFfCUjtnJIh8/KzlCW9mJWmBma8kJkd2NvXNNAdEUWrnc3XtqL7auBipWLxFpRtlpMQx3lKJ0EivRfmkyR8PCWY6o+4dF4zt+ZCZUWgnm5b+n3oUS4ZTdcfRBpb8GFWRlN2dlV2IPo1ZK7JfXlpPJgWlyxwcqlAFWCM8syVJ04s4vkv1xfAfLwN+AZ30QS8EMQkY7hFtEek/VMDASUpslQAp315WzX2kLLMrT1eVrQfjDgOeCzfDbr3XVz1GaMdrHq3fqD392Q+N6fWjjLkn0ZRoFMZiAb4bJwTiYO3Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6735.eurprd04.prod.outlook.com (2603:10a6:803:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 07:10:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:10:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 7/8] selftests: bpf: add bpf_first scheduler
Date: Tue, 29 Mar 2022 15:09:26 +0800
Message-ID: <7643e229a68ece9ec5928fb1ab3c50e33e10d6a6.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e4c19a-ad96-49c5-2c24-08da11532e00
X-MS-TrafficTypeDiagnostic: VE1PR04MB6735:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6735F882554B6F55046E4EB6F81E9@VE1PR04MB6735.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PWCo2JhXCuwqBG4HLyzDxa1rEsMz+WLROsAevHNI3p16QIybs+kVxWmmv+PW/0vQMd/tDtdpYMilzz7wlTVI25P6awP0yiqBOnNrunKeDWwYsczzSPYbjX5s6VjMrLQbwzCuWKHmG2Guw2dvqS+M4qyOvILMaITpiqHQoRetcESn0EHYwxiQVH5l3D/ODGeDqcAhHO6kYlSJ32U4kkV5y180+M2SUemsrzjfttJm7abl+EAORujaLyO9Heg054IaJpMIfZsO/87YpKcgaYDTBhzqHzsWy1IyqSQbhJBruZRfD8+J/lI2nGPmsnYwkGaw94l6E0x7MfPlQb2++4+7B338eBWQF5Xpe5g1jO2ZqfbTx6hbf9FIwLGn0c1zXMju/hYKrOxmtJ8Ya4u1N60ItQa0FFdClnTJDTCYxRTf44OjNAUylVUMRCTOvPb9+WiiS/ZBE0nOAd+6WLuAuMZE6Fxj8kpKc2mANVIjyPvUbRS5pM1xgvvT/Pps65jk44EjKjQotUbxB+JCACtJHx6/ge181QCs/VGJRIa78CexCRAlepkIZIPCeRuyNVx8s9/vu8WqKW/sRSrPDM5EdMk8zOracJrD5SsrsLanzwqAcOYDvV8E+FJyva9VA8gor3dcWW0jshWCdXfGdhXfvN5rWxrvQV8MYshSimR+2BVqnSs0hs8wiLg9HsoXik6QLC2dn5RkmFC/Jaw9xPyccoBViA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6916009)(86362001)(8936002)(8676002)(4326008)(36756003)(2906002)(6486002)(508600001)(316002)(2616005)(66556008)(6512007)(66946007)(66476007)(44832011)(107886003)(26005)(5660300002)(186003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hojpgWGux7YVBbMwN155OYKS/k+Ql2CNFbXIX6JDq1jI85f9+r8Wri+xe53c?=
 =?us-ascii?Q?Jn3TxL5ihOHRcwZHYb244fgHaGFKdG3tkUhAkNicV8iKz3pfbmkBgeDEJZy3?=
 =?us-ascii?Q?utQRwkEagmahf5LbBasItBBDyqirbKKHPrveO8urEPQz1+VZ54EA0G9esg9f?=
 =?us-ascii?Q?7hMGQyuZeCqLVlkiLOjZM9P9Z1ZKNeWDp2DJtp+wxzYNli+3vYkXFd2NCfYl?=
 =?us-ascii?Q?DB8CFGebgInE7cPCbS/AbR8IXGIu/v/isHGE7uiQd32q6yELVnsI9F5gEiJK?=
 =?us-ascii?Q?S2egwEsktNY/6tCFoLTlZAEyfLOySeqm9UDvGPMPfsGt+/rNeYb8hcd6ICxO?=
 =?us-ascii?Q?BvZY6CSRuq7vv1lgbbeCL8AN9RNlqjDoD3WOuVtqTKPl7372N5+Akq6xLhlA?=
 =?us-ascii?Q?7qCOlSUkcCkO7YwAijixd9eoi0gSqGr81ZyH9dmvotuzbqJorZW7jj/ycHCw?=
 =?us-ascii?Q?vowmcU7PFvbt1P1rp3Eey8O5JzxRSjUMRjFprq9ZURDzqxYhlqPo5l/sKghr?=
 =?us-ascii?Q?t/BCP1I7++1vSQvBNwVTGD/MkMzQ7aif63CaiCkznO9RtdcQrQD/qHYFfJlD?=
 =?us-ascii?Q?uoApRWvBSk1yhsfhA58SuUosmuN6nz+BiAiadd2ikZEjGV2Nh/EW75FjH7QC?=
 =?us-ascii?Q?daKR+vVMSxqrbU2YbCeY6r5ESxx/jxxSjwXrL2F/dIfJdv8zzgnPGeLmrxPO?=
 =?us-ascii?Q?OeY2zC4sMGgpe01ry1vOnUDjwkK+EykieSgSPrVnZ6UTblo4kYDgcseR+pge?=
 =?us-ascii?Q?XYzNMOX/9ifzyM25YsBoK56u2sTTfcsXbh8CYTpr5JjfP0Rt8TUvBPoNer38?=
 =?us-ascii?Q?RQ4VAfq7xq3UfFCcFrVZKQoWWJy7Lm2B6YhBxSMbr06kbfblnsa2POrDXoid?=
 =?us-ascii?Q?XOIxPOMP3Htxa5z49uHc9RSGW5lwAJluHAhlj5PZAbXmRu6/r779cGrtKy0D?=
 =?us-ascii?Q?lL/xFxCrgLcU0r1LDW1UCitdX6oThit2dQ2Wo8Qp87jbfvyR3xqb86AM6ozg?=
 =?us-ascii?Q?IUbFAIwEypAf1yqaNTgyi5f8EFsfB7iGPnw4g6OUYVUH+yti0ZyqFPlMfquS?=
 =?us-ascii?Q?0EmcsWSjQf32LXnz4UsX6A4RgMrb4T+//ocpBXikvw9EXjtha85w8W28k20b?=
 =?us-ascii?Q?ce+Wb9/gIfuR76ks5+vGVhr35p2Ea0ja4RoRpqer7wxKOMvPK5QYgi83ONbU?=
 =?us-ascii?Q?3FS3DnznifLUAxp5Cv+RzMIRtml/cV7IBWgnNm17c28rAz3aUtdtHGCutjSr?=
 =?us-ascii?Q?JDCvx97bXKHgY5NSf8NA0ugUP8j7mBdCUP8o1ITuWe0zCHkUOPzzdISOpUGP?=
 =?us-ascii?Q?9rTpYH8NvSe1wVHwMtNYmVQ4xcPU5ip8/QZfJgFa4wP+6dnJJ2RY31MddkIG?=
 =?us-ascii?Q?jTLe130ohAqDAm2ctPpSOPRzo+LX3usfnllH8k162yr4WrGS/b21A0PoqKSF?=
 =?us-ascii?Q?4UXugjhPNuTUi93RZcKh1V0uTxuwZTjHfWx9K0O4Dl6/23bFfJflv7NapKy6?=
 =?us-ascii?Q?Ruo8q8IEx0BLHWOYYY9iWwl5BQ3N4zrx0joZXPUCHhocfsDpLs8IhRpoAyJw?=
 =?us-ascii?Q?Gqyv2OmJdhVTnjIb+k8sMbTHjxwp6Bpn2ZWwOFh4SF6RRRIDbhw/bLMc7QxO?=
 =?us-ascii?Q?jeCjCLdeHP2y3LyFg1VEn+RHQDBTOWN5gpGC9PRZG1JkpYjX9rDmhxMUf8Vx?=
 =?us-ascii?Q?0ZdzXybi/qiCpdzJnLcpNG2t1Jx0nJCaeZDTdpQf3MvLbS62jjoNYMqzkHo0?=
 =?us-ascii?Q?m93k4YDkfbvUxFRB1FwiMO0P1ZLUExE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e4c19a-ad96-49c5-2c24-08da11532e00
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:10:18.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTTFGNRc07MHsuc8fKoYu9IMLOJvDm/qR81GrSeYFomB17bg9LZfJMnjo5P7tVQaI5FFD2TQ/KEvuONnhwehpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..5bb21b24231f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,18 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..3ae5c1eab5f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
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
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk)
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

