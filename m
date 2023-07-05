Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6210FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIcm+uFh4VdlgT36dAUvoTf/5iPWa8BWmji0N2a9oC0VV8/IVOJjc3ysv+Vz9nvWE/NWqcaoS/JNUD184OU/pedke6U2uNxTLVLVAERVCuvHHeVYkVBR4RAg0Uf4OcDe+DCnZ5s2uukl+drZ8jGJgmD2ND5FuX+OnuJvBs3bVNc2xqoG3/19Ku1d5x/FqG/DLC+/T5PQlMq3rBoLPnJ4PpAsj4hTsD+iDUgls2pDN5VHT1NUn0C4a9cGwY6lAEhYj0xMzF5pfY4g2x1vedncBz8iO7BghkcXvypOXNILrgeGyfinS+b6Qikqt0qsyvG6RXIt3lRIANfaIhB2Ioa69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=RV/3wElnCcTNyCN3qZlyrSS9tZiVg0yM0EkX3KpTKE6zZ4vJ+GUa67Vf7FGJJeSYig7HKbTdi9sSaO17aE59SYW3eOQcCiGy1QaAoHNxkeaUOOgAH2yKFUI8hnQ1UZDU1xuDZp94xb0c5MG/Ou9luR3yLTwr3tqajBzt9rcBAPR2p3IlTTUOLoxZDwvqD/WHSKduz+LYUAdzS9KUsIvdFcbkMZQQgokvFDKc+znzBjxoMrpkJEHVAdfAjwv5UwLE1wHEroSnyM7K/X5hOauBnP3A91ROa0qEqUxTfqFMkKN2dNiVg3wCzBGwnmRgwiwNN14OBro6B2g/luaIcU9HSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPH4bwg8shk4a7dlucecBOgYz1Xs3eVluKKT5Ey3zWY=;
 b=mUu2xVKkzIMJIyVyLTfOHWoXFuseANunJ3eFf0m7ffchAb02FjBJkP9gUSffMb20Yh8AWjSssf8HDdKd0GrcP+/Pq/OY7kTA1hn9qFI+kKsiQg3BohnWcEN/QPQcU4UsipE/sg+59sgD5cU5Nwdl6XYwZiWFOZL8sbdA/k+QE072/MMc4FZt6hOIWkPOR2tvA/+l2j0HIIfaYEyLXzM5NCOzXotiln9gdeNz8GxQ4JOdfzKmGaGknnASSIrAyka/wVLib9QgrAYOc4RZnFBYDBxkhhFesL8N+OFg70G+JzhVu+TLIsFn6mIwIjQmxWkuRKpN9sqxezIToVEi+XOmYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:57:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:57:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/7] selftests/bpf: Add mptcpify program
Date: Wed,  5 Jul 2023 14:56:39 +0800
Message-Id: <11450563449c884a23b499bf629a661b07dc13e4.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: b392895d-4bfd-4633-cbda-08db7d251e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxfbijIzE+ay32NUCvFHdr/8vQECUKrY9OY/jXgOFsPTIGdgSN/P39nVJcgqL1SYEBzS5DLLYr9JWpgymldWy1K9X6qefNQjVGu2iGevYEM+7NMcHIX4uImFZrw8ML3SCXK0liJHO6Ayfu5H7mjVJ2PHXGCLQ6vfPrtbCMVhBw16snac1rdZAMq9Po6Lan1FMoVQqDKOq0GIVjzMTrTx0rfkOOY2KYpvDPPR/bQlSTKDZk1+pnjAZXiIlvllEEkkFc11NRSedQZ/gK7Gm9GJekJQAqchNH/yIYsNXAWpkVNOzH8G4K5OC7gddwPQ+3+W3SVyhTAhLCs+6MTgc9yOUn5TV/B/H5ia+yfBT5NNbrK30cAFfUpa7jFRJC28cPUirc4AEHMZku3QG4pwlovBXYM62CXY55WJu1M0kn7zYUH7D+R7JQExzRVkONeSbgfX13oZK3Fle/BnIEkgZrKC914DB0cItaYg5LL9fvQXCe1mhD/laoJOays4/RTuXaAGssM8oo/IiYPRuD7nJHQ/LJoY9s80+HAUyCMimp21GYn3B+kojguEe3xjkTwpArUynYS+6WADg6HOZRKAtf7b8MqMBr/jWFqd4sLQ5DzMQdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(66556008)(6506007)(66476007)(6916009)(66946007)(4326008)(38100700002)(478600001)(41300700001)(107886003)(316002)(2616005)(186003)(26005)(6512007)(44832011)(2906002)(8936002)(5660300002)(6486002)(86362001)(36756003)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UWuSghwG2RkhYxUcDCho48NxG6z5Eul2mRjoogXHtWLpb4Q6ci5ndmMo8p6L?=
 =?us-ascii?Q?oOcbqA5HBIO9wEv6wzqAJXnfzqCEmMw0pGIHGQYQHyqPjkdFoM8dm9T2oKjy?=
 =?us-ascii?Q?MdcOU3b09yO1tcZ+gxAraT5UFS1fYwwqcWO6xWq2VnevDrOghVFlx4a70wQq?=
 =?us-ascii?Q?YecUNw/pYzJkCKGQPvYb6p5B+eHzpj1ceOuMu3PJ5Aem7prQ6rBKBulqdZzs?=
 =?us-ascii?Q?pJZesCDLFYaVmqO9B2+DWPfkmKLm0B7nTYMBkX8NEyDx4+R948lL7uKPUrCk?=
 =?us-ascii?Q?IEQw5fKEiGjhX4HdukYqVgj7/iKmApEajZ/j2dTNjW79y7RUC2PkzPpXSOef?=
 =?us-ascii?Q?MpbTvWwfrZMxerh2b3Wm2iMdeRkCbRknX+G82McDYtdHSmh3M4nK4JljyF8S?=
 =?us-ascii?Q?P7DI2LbdT5Oj3ab+iUF9nZWqEtvM0j2EtDB7zWgGB4IZdWBqacgpwCe7F9yv?=
 =?us-ascii?Q?FwXKC7fQO0dRpBDcHoB2ZXelvm9fmfM3vJ/zUxRTJ7I08HTLVlO+Iy5LcWbW?=
 =?us-ascii?Q?fkAfacySv/vmSjo+/ooXVX6TptCnz0LDSnLUxXYKsHIQeZSLVO3RD0CcGeDu?=
 =?us-ascii?Q?icOG2Rqjt1996rMS3/oh2P9D/9Qw05tGDt0lo2e4lLbhGapHQBsbh6vNsebk?=
 =?us-ascii?Q?h3Lx1HeY+CnkM7evNzA/+74EuBPUsN3bbHvBqwdK39y73dIxu6m28hkoO5l8?=
 =?us-ascii?Q?LJzoj7lUtEN3qr1JqPVkkEiMYdqMv+vX0HNx8sgW5p7pfIUw0TXP2w9/cAUy?=
 =?us-ascii?Q?yuddOnWN6gGwvtQEIVWWthKXo69UU+x4cIulmNzyNe+4xj+Iy+/HzTSGX8jM?=
 =?us-ascii?Q?bVWxEpGIggW9Q3UlBamZyeOwMgjl8lPkXlSMHvexl7rr6lS5QCF1VqLsb8C2?=
 =?us-ascii?Q?7TyC7QpsZ9pVwA+foqMkV8LSx02RyM3VHl6eusY0lzwzSzu8FJ4vp3X8KLeW?=
 =?us-ascii?Q?Rs905koWHtjtAfN2orQS1LquEeRf+aPPtLV0CZv044UESLu86CQaMlLPlbp/?=
 =?us-ascii?Q?OYpkmxl5umfn64eT9fVi5o9kppbaTvcBDRrkfv3VELHWY6tZoQtfwVLlmiiu?=
 =?us-ascii?Q?knl/5OVWrqRcl0CuQuzTJ9nA/HxlGvQnPKBVhch+ydOF3wE9Wdg/ccwE3NQM?=
 =?us-ascii?Q?qvx0MO7GoS+s+NRmVs5ncz+z50tRU3G2GhcIjuj5n/NK/lim9owkbiJLTEat?=
 =?us-ascii?Q?R4nkMjID7RTm0phtwQ+AyJmOBoFdf+g8cGrvgY7K1PN6CIZbpBz8pSK5io7Q?=
 =?us-ascii?Q?q4J2NEK5GbWko2DTCvmIa8cXOZp40UfALP8jF96r/yH/NHBSo5XybgegB1Hp?=
 =?us-ascii?Q?LI4BftTtBr6wtCSVjroRSMYkhHEDheskGdEm0BcVctOlAU1173Ymkuf1oTz7?=
 =?us-ascii?Q?V6Dmf5lAZkTrF89ltdF5RzuZoyvg2dvwYS/Yo0G3OYFH1x10TJGIoGAdmWrh?=
 =?us-ascii?Q?WbK44v9t4ts8V/Bf3eugg+ZHWcBxpaiT6rWtS6LfcJMcvEwqpsZuIWfVuvT4?=
 =?us-ascii?Q?D4B5mngNLVPto4XM6I2xSUy1i/wk9lPWUeYmk2jHQACi50Lw0EsJmKSUyaHf?=
 =?us-ascii?Q?WxH36949pAJhjrTwF1RJHrdxdU8zSyfNW0PYc4UP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b392895d-4bfd-4633-cbda-08db7d251e0d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:57:37.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0kemPY1a4Bu91Fq26qDw4lJvOvDEhFtXBPEwnh2FIO+KNwtzqmbQHu5fGGC6SbzJKqBXs5jqV+mXlJmtXPB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

This patch implements a new test program mptcpify: if the family is
AF_INET or AF_INET6, the type is SOCK_STREAM, and the protocol ID is
0 or IPPROTO_TCP, set it to IPPROTO_MPTCP.

This is defined in a newly added 'sockinit' SEC, so it will be hooked
in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../bpf/cgroup_getset_retval_hooks.h          |  1 +
 .../selftests/bpf/prog_tests/section_names.c  |  5 ++++
 tools/testing/selftests/bpf/progs/mptcpify.c  | 26 +++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
index a525d3544fd7..0ba09e135df3 100644
--- a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
+++ b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
@@ -14,6 +14,7 @@ BPF_RETVAL_HOOK(post_bind6, "cgroup/post_bind6", bpf_sock_addr, 0)
 BPF_RETVAL_HOOK(sendmsg4, "cgroup/sendmsg4", bpf_sock_addr, 0)
 BPF_RETVAL_HOOK(sendmsg6, "cgroup/sendmsg6", bpf_sock_addr, 0)
 BPF_RETVAL_HOOK(sysctl, "cgroup/sysctl", bpf_sysctl, 0)
+BPF_RETVAL_HOOK(sockinit, "cgroup/sockinit", bpf_sockinit_ctx, 0)
 BPF_RETVAL_HOOK(recvmsg4, "cgroup/recvmsg4", bpf_sock_addr, -EINVAL)
 BPF_RETVAL_HOOK(recvmsg6, "cgroup/recvmsg6", bpf_sock_addr, -EINVAL)
 BPF_RETVAL_HOOK(getsockopt, "cgroup/getsockopt", bpf_sockopt, 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..52319c45de57 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,11 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/sockinit",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
+		{0, BPF_CGROUP_SOCKINIT},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..f751e6f65eca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define	AF_INET		2
+#define	AF_INET6	10
+#define	SOCK_STREAM	1
+#define	IPPROTO_TCP	6
+#define	IPPROTO_MPTCP	262
+
+SEC("cgroup/sockinit")
+int mptcpify(struct bpf_sockinit_ctx *ctx)
+{
+	if ((ctx->family == AF_INET || ctx->family == AF_INET6) &&
+	    ctx->type == SOCK_STREAM &&
+	    (!ctx->protocol || ctx->protocol == IPPROTO_TCP)) {
+		ctx->protocol = IPPROTO_MPTCP;
+	}
+
+	return 1;
+}
-- 
2.35.3

