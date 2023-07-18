Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D417CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZEKISJou9ahKwPRO5veeaMlnz6/R+jN+rR0iU32dnGeQpcagMmt6HSBu1wT1GwDe9vboxQZ/ZH1oonh5KLDlxOJKuVxZsLVAL9wd4SpSOlZpxv5Hdl85ZRhn0PUuNfOT8qGymkhmY0tcoRiB/bGqPl9HwZJ3JKDm62+PvcLo0yGh5sOna2y5v7g+gfcDXNbGCQQ0YeMDxmhFqBPC9PDXwH8tYg6rPl3clm+CFCY+46HPepEgoiUdKpoh2xXK7sEzYluqSwbULqGWhxJvC0mg4w1Z6W0qzeol2Udp9hDEzCBdqI2UPMHFlvJ2R87yIZao4j0+OlE689Ga165Tu11Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kb1GlOsbJCkCAv+4ThXKLC+JJR1SAyNlT39D//a3vY=;
 b=jty/pffRg3o+Y2Q5pz54xkVGwjS5/w//4mlX3teUYjYFCiYzHU+gTN1+ZxVtpSvGzd3d0Y8CIm7PpJVF5YdZBNyUPw/ps/ZT1yb5oCTfX+V9xLcYETBpCkA7q9sLY00pNpMw23fq4eQyoEF/KDHKmXmOn6Qv/abBxBmKmWG7Q0ZtbhvzrjBM92DsReP+YmAl6IMffawFWcB3Qa7weULjI3Vy0RfXzrBz30yI6mZgZ0ftfiCesg4K86HZUt2zPrSEILx4L7/mzoILIUNK2X161EXc8AcJFZTCCGpJJDVcBA5+MDcnKWlXcKms/BfctpO8ek6Bm+gUPQbqLZhZ/Ji2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Kb1GlOsbJCkCAv+4ThXKLC+JJR1SAyNlT39D//a3vY=;
 b=V94hAfFc1+1zksDyQMmHZGqIHpZqr02SJ7I2yYX39MY1qQt9Vb1w8LbHHr6Ru/YgTjsgfRRe7WSWNuv1GWacNibXEdgiYQca8gIqvUsLe3FKciQocv6kiNosHgG1xTXJb5oIQ+13l41HTP8WB15Qa4oHzvoi39TxMYIXnWiT6g/qA/LobcRHabqo+UmqUDRc4UqRiLcU3U3i3kD5SL1pApoYEPY3tohLibnKsyC/x1pMhI4Fpk7mDYI3ALw8BerDYp7gvmVJ7gfv9qSWchetPK9KlsJ27JoIsGLL89oSVejPqf/nVDZ2PGnz6mjnT/K1pnKeDzP8EtMWERLPs18msg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/13] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue, 18 Jul 2023 11:36:38 +0800
Message-Id: <d741720b543889b7a1ce8397a8849fb924011e9a.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0146.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecb8dcc-b13b-4d30-6d3f-08db874046ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1YM6PDo1iG0J1Pmq6JaCCYD1sd5lpZb5gHbScv786bHZNjjDo05UYBUqq+ZccR38oXOHRdfk1wqg8jMFpcMUox30cucP/hH9i/jMpicLy9Kre+3nzvpzSmYmf2BeIKQIhZHUrjOa32BCeeTtWowj1dlO33eazM2ZBoCshycimHadG4o+tydwo8a8PNG3sPyBnnCQwns1waRRMqH6ptRtY8CTvrWBMrqrtlcKjkvz5oB9Ad9SXq9ilrHPJIxoJs8FZSzlR7qXnYNWQF67BUNsn86c1wiUHy+uxzJ/hAyKxL8j0RLd6yOwexcxsz2hTAa2Mee5IWvi3eTcKHZHMzq6U+VyyXxm7s3aVO54W8dSJtprYugNXBbgIVkzM+IT2Au4tMzi2lPlFLxv68yGB5XX5o/TStU1G6VmxVbDx23rabhmk4hV/riNfXNTu0BDxD3zN4LKOSc1tt97Y+CfxX8wmYDp8J9OkpC2c9v0YDh8UL6b+FWjddw1tZ4Beq+xmlNAsAnqu/yYXvVQxmKk12PbGPvwLj5dhagjnd2gl7UP2+nWbuq0xjGEvd4HfQNYqIYPgRLwKGt9oBT6zxk8OioivtKBmkAM8zL7evKoAitaL9s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wQ8Tb6viepQIBfFNwTNGAmWneZCHHUntsLTSIGg6BnCziT1wlpzBz5Etan0e?=
 =?us-ascii?Q?5n1FW7Zvf0KaQbN742v39MEGTZRYaQQtmXFv57vffABMdm3r+PXWDsIzGACP?=
 =?us-ascii?Q?mv6npvBWBUPiJkZAisbWuR/df8JpUBCl1u+8ZFUhpAYK05viYxpMVQSw4OxF?=
 =?us-ascii?Q?di7VsmFGhF5EWi+RZZXGkEUe/bDq4Q+XQL/EuTjvDeFYWfKtio9Mi4Sl596h?=
 =?us-ascii?Q?JsfUypSFRPhsbkSB6xa42r5H+jcNNrSGuEoITQO033jEHP0f+riWmVj0pJtS?=
 =?us-ascii?Q?TeVa1Q2kpnGLmoBpb7NP1f5zkI5VD5iTCs75IvAELxdqueMZyPU3h8FaktJO?=
 =?us-ascii?Q?pZVaTE92baI9O+LBBkCf8xjueTevaUCXvB4rVNCCISarn47vTrEJ1O9UU0Q9?=
 =?us-ascii?Q?smHESJgilLzm8GWfgt7m9fXE+5TyHIasQC0QPSaWmaN9TL6GbxingL28h0hZ?=
 =?us-ascii?Q?TZzqvWucVl1+TBGzzU/tLP9imdCzj+RZAZfbKijS7k9ubAOXaUSZ1Q8Dd69u?=
 =?us-ascii?Q?GECo+hAKhqNyw16DPdbOFiwp6/XFYM3EJcrI11o6ZYGomMQepmtyFBKTYhn6?=
 =?us-ascii?Q?VXNFHM/9CjttltJASYUO7WeuIFSCQZDDgh9Cw9cUUVnAUm5yOGlzzfKDnTh1?=
 =?us-ascii?Q?u07LUArH/CASZduXKVy72ADqgQNoq5wi9Ufh7HRCenfGZ/s3C2f3i/1s8Q2p?=
 =?us-ascii?Q?dcvq0/5H5oONo8pegOH/pFwBrv+HN90PzcN21mezbl4ZD6c+DzPJnB/+oS1y?=
 =?us-ascii?Q?0wg5UJo+Clo3LngoG4mha/AdfaNebLLzBiJSY/XciW0StiGcUdGm6p8FIF+J?=
 =?us-ascii?Q?nigiBDMrCQbacYHcX2HqrcqKTUwTXiPiOUhz7pL+QjFGlQFB1/u4e1UJsL1o?=
 =?us-ascii?Q?sarGMm9viYAhDg77a0OCxpsAW08WQnQAz9bZhIVYugMXnK7+i2y1UwC8SWDy?=
 =?us-ascii?Q?zB+TkxuSrWZ/dLBauAv9FfKHk26FXgOvDe1g2uRj0W5hEolNM5/eApPnbFDY?=
 =?us-ascii?Q?2fm1AZhljNSdJrzpD7fkAmUhjnjQpAb5gIyLLqDfzubWqYsZTuotXkcjQdEa?=
 =?us-ascii?Q?Pqmw+SqpUztpTothjy4XfWj4TqBNj0I37CnRN1Tf6TUCTAjsoqoIVYh/xt/q?=
 =?us-ascii?Q?mEPgo09t2m847sIcRPWG9Nlr7KsLMkJ+9pCvx4+cazXWzShgeSoqotNtvdDx?=
 =?us-ascii?Q?1dXx4EKR9fJYM4S+C3C/GAbcBk4vBjwtA57QkjHeWXlBujmzUx7Uohj937Lb?=
 =?us-ascii?Q?hu0//QfKY8BGoUvRMaaJLbrNmObmlGXKC0SFl02YqdRQT7o6RKDUuOqDaXCR?=
 =?us-ascii?Q?4CZ8uShKJoYrQQX1r+kcbSQthzhQg5f3DDDieo7oLddyJmXFqjtUUIlrzDVE?=
 =?us-ascii?Q?Nl9Qulb3JstIZzqCTdxHb2vp2tof6XC2GPDBeC4O3HNQ6ePOFTqmowBzgqEO?=
 =?us-ascii?Q?IZWlKtJzFQF5ySflj+MBmr7yGJCItKINu4D1ExToasT/+FKwwyCFFO7EVfbU?=
 =?us-ascii?Q?8lMcOsBdZQD/W+3w4fu2CjEBFcgZ1VXn/rfqVG4ae04AAwKaG2pqlPr6TRXb?=
 =?us-ascii?Q?A6V+UlnVl9RM2OefxYeOY6eGfbnKQGFOxHeCS7j4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb8dcc-b13b-4d30-6d3f-08db874046ec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:14.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aJFBYfwgvLTp1xUVIMYT5u8au3qQ8FB/xDFygvSNMYIV5vigoJAswgcjQm+UfW4tUeLh8aET8w8Cmj+e2NL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Some code in net/ipv4/bpf_tcp_ca.c is removed by the commit
9f0265e921de ("bpf: Require only one of cong_avoid() and cong_control()
from a TCP CC"), sync this into net/mptcp/bpf.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c580add9c7f1..f388baf08d49 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -18,15 +18,9 @@
 
 #ifdef CONFIG_BPF_JIT
 extern struct bpf_struct_ops bpf_mptcp_sched_ops;
-extern struct btf *btf_vmlinux;
 static const struct btf_type *mptcp_sched_type __read_mostly;
 static u32 mptcp_sched_id;
 
-static u32 optional_sched_ops[] = {
-	offsetof(struct mptcp_sched_ops, init),
-	offsetof(struct mptcp_sched_ops, release),
-};
-
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 			       const struct bpf_prog *prog)
@@ -101,25 +95,12 @@ static int bpf_mptcp_sched_check_member(const struct btf_type *t,
 	return 0;
 }
 
-static bool is_optional_sched(u32 member_offset)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(optional_sched_ops); i++) {
-		if (member_offset == optional_sched_ops[i])
-			return true;
-	}
-
-	return false;
-}
-
 static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
 	const struct mptcp_sched_ops *usched;
 	struct mptcp_sched_ops *sched;
-	int prog_fd;
 	u32 moff;
 
 	usched = (const struct mptcp_sched_ops *)udata;
@@ -136,14 +117,6 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 		return 1;
 	}
 
-	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
-		return 0;
-
-	/* Ensure bpf_prog is provided for compulsory func ptr */
-	prog_fd = (int)(*(unsigned long *)(udata + moff));
-	if (!prog_fd && !is_optional_sched(moff))
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
2.35.3

