Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41A7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK56Jeo8HiidmS8Jn82zGTCz6f8MYluX4EtcWBFxA9Dk2vZqKRXj0R1H5ruEpI6d5WWFPgGZxSCXy//KWk7+dYwSg4dYnfH96MQzbKfQxtLl7OUb2Q8BX6bwtYtBhFK9QPXiS//76UBEweiuy5l7D+sNYnH1E5QNuhzvUIIydxR85lewuJuwAvpcBAIDRszEOHR4/VNA7h8rxO9zAGAei+Coswt8Fzw4TgxW5J0Tomvwpp9wx+QbISDG3rViQ/83IpI5PhsBkWQy46jXFr0D2zaBWf/GKnI+COpHaAENRqontvxwL36tHV5X1GZO11o7G1gjn/3S/w3V5a4joO3XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=Cps3jIz8Yk5KuisgjrC1hAx+xVdfqSSkypJG1iCo27GJh/wGF3OR4QGT/CQ2oJJWL/IVNosxGjDBbTLKfsdgC0Jbm3PylsngjESwOtxTP6nJT02q+LlvngKUQ0BMn9UR/w4g643FbeofpcGAX07Kc9Q5e2UGnMtJDrdqTQkeBuMic6eMHdxz4iKKKouOkSqvYUHx3qZ2VmokbbtvEQmv/cDtnc8xpbQYBmBTb13WIehisFh7hhkHZvbCkD078UTy/Pnv5ho2Bm6uRFNIsyfJ3loLV2ascBdt4CTH87amVdY3KFIRHd02cRHn620cGaiI7NTfumpIVFjNkx9xGuzPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=egJqVAlgtuxRJaChj4kpvyw2mOdXIE9o4Y7oUVw/NuQWBykmsOrlbLyeMBX/PPBDZxNPVm9KH1OYbuWQcc+QZgdHl22BniYgqzycsH0tr/T53a3a0GX+NH3sbbqPQfr8W9QZmXDCt0L2GIvCPL/JXg9J6IUKTVTHQMSRSJuvVXEiUIUoH4Vm/XAhV/6G5/z6SBLYTT9mGC+PGJtuuhpZak45ljTo1M4EyN661CvrkSLQnN1rXe9ab49e64oZiU0uVFjXEDxjMqD98peG4zW6t03e+EPYZzXt3NfMTEpyb6As/cSiUHImOt0UaZZKMBcA3bO84pW/Eu1D3H0mbh1iig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:43:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 6/7] selftests/bpf: Add bpf_red scheduler
Date: Wed, 16 Nov 2022 19:43:07 +0800
Message-Id: <6fbb817dc84b88dc70ed797fe9356b1dfb69ad02.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b73a418-d5f1-4128-66ee-08dac7c7cf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sWpNth1OwzD4dYR+Fa7O7H9+UiAiJKsMFswvroHaTl4iAnbAElBs9R3F4pjawiCunIDtM24bTtpbReZbHy4TNdfzxA5sL1rroVWhNT4Z1lFwUNNu036NtEsqK3X+VzeOD93amC2z5V2EsY6DltizzyOfATz6AqrFRPR8KA1osuMCZqT4Yp0giR7CuBmRAH8BfUu5okyTSejNOEA3UaN9Jhk8moAg9u0K967HQNXXEPM0Sa31H2O/dMd3C6GVSoXSVNqTBqFV5feXrBJ3vC13rRB5E4O+H6Ar73wEGeKYGwm0g+C3pyvbxGVAJ5AiDUWmeO9enSQqE8kcZm1/Gm0KPU1ki9z2/aiAL3gdotAVJFjV5LQ66I5RcYdVdFscD8/YaFCUMl+td1LNy0+D+rL4kGDfJApz11PcSUyuPMOH/rUJn2BjTYqE+Gz1PhzBo9xOR1ZXbK401fNfzjfVMV1IaH6fAePCmgd+gf5H8KRmYN/y8V+pMjg6VRsAiKVtliaxsvzHpnbHYDzN13HkZDbMWYvqJS965WYJufqNYohLJ3TKLyhIwNwQurwyzo/iIHNUEHU0LfbxsHPudQnNXfRDn9xwK+byeti7OuqZJq9MnmIXRixq8AKLDUoZ+hj1vqYbUtsxwE8MaQwRvj2cqI28LIWhLvgzI5ftG7ALN6NuS+6+Fp8uUiR7jLNuZjzi/lg/EuodODPsIZMkj2dSBVa+/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(86362001)(38100700002)(478600001)(6486002)(6506007)(66556008)(107886003)(6666004)(8676002)(41300700001)(66946007)(4326008)(5660300002)(66476007)(316002)(6916009)(2616005)(186003)(6512007)(26005)(44832011)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlEFLN+ZqC89iJurWREJD0oILUR9pLb/Ep1qkXGkNrNIcBsZkrE9d8KTarNw?=
 =?us-ascii?Q?XS6epBeZi3nz290mo/Eoqaia1oA7xiv0Jxj6ORMI/IVvxqn0x88bWET76koI?=
 =?us-ascii?Q?sp1wX7A+Ij4Ho+s9sMx72vsocjdnvEJLs9xBXBFlonbiiPvWrawvP06lQkwR?=
 =?us-ascii?Q?IZmyALeILyfwAWUFWxOdQaVH4vErCTYBepYMxb8aew+Vc5v6EnPv/HoPjbSF?=
 =?us-ascii?Q?iWBk32SIcswN24GuGHEGuFvp83zVhE7QvDuln13X782xr7KDBidqls0twKZA?=
 =?us-ascii?Q?MNPoxLxzFctTJNy7sNukzzK6zZN2G8MG+0T+k+Tg300DNQ0bM7uwMUpzxhQu?=
 =?us-ascii?Q?6jhRXzN0zikyq2Ohb+PYedpAbyBXMeZzL7Cir8X3mLKLXXIiGToo1+LoRgpG?=
 =?us-ascii?Q?RfZqOQ119ZixNuYW6citUoRRvB+HWy4bOA9aEWzI1KrbwNLYtbyQgb5ITHR1?=
 =?us-ascii?Q?1m8wbdb0KFNlpxzN/lFTk+SQhnckHq5PdCyi4G5SfaNDzp/zeXTBbmcVwNWE?=
 =?us-ascii?Q?BY29QiHmNao4RHoSGTT6B5bbSOcap1s2WcmiO0NPBP6YMxoxHknfl4pmFND+?=
 =?us-ascii?Q?w8KESZ6O9HEebEf4czFuZnk8M0Hgkik4L7iKeH+m+tVNVkSPVtNdq+vUhA6D?=
 =?us-ascii?Q?8gvL47ue1mNcgqnN2yDOP+LiJ2M9cCagMfZVILlpUfkEHyzdVUey9z7KRb2l?=
 =?us-ascii?Q?hTeBFPRfnCwsoXmS8Ix7jxRK1ajhO9q3WWu//8DW6CZnmTOxO2Zer5eRz+3S?=
 =?us-ascii?Q?ilgkfSPGSpNfsdY+159SNsuq7xZ8IEbLdji8agzwtyFfvkn7UXOlZKpoS4JL?=
 =?us-ascii?Q?p9vKyFAj3QlyqM1hn52c5/vRdq4IFuC3PqXxWBj39i6guBu/467q9QGyb4jb?=
 =?us-ascii?Q?7XvHOZ0vS3QIX0mq4F5OMdB9spVPdNAsO3wZivlgWPxDzOgtPKCMAcrEdHZW?=
 =?us-ascii?Q?MP0Ko0uQnBtTl/leS7fKOf3uxi6etWOp1FNw0zZojUIMOCoUeKYn2TWFElP0?=
 =?us-ascii?Q?fqT9FwV8/m52d+lmepAfKyuZBTAdFsfO7EetlnwpVMSDNg1daAIviBM/0kOt?=
 =?us-ascii?Q?fPHaqM1MrDNOP+QfyrtfX9I5iDCqydU0Aq3eRfJJGU6kmmgOdvYQNXnfFrcn?=
 =?us-ascii?Q?hIwGoVuFmmr3Cl1vYnawS2NgkVYSPIlBVeYfa2qvr+tPG8ioaHa3dk+A/kws?=
 =?us-ascii?Q?/UBfcRW3rnX7LXtULuXHH30UvGAexp8obdhddqLX8IMF8fqytqGveI+38txe?=
 =?us-ascii?Q?C0IPxo+YUnnv7FsQN2XRBLcw1mlXgLhAT1hHxrJZdJZpVVycUlV0V6tuYLRL?=
 =?us-ascii?Q?JRRqtkXvxPdhjgKwhawIjr3P8noFKsLi7aljNZfkUyqaqzioZqg1yqa2SHED?=
 =?us-ascii?Q?a7xLxej89ybqZEiFfspzlYw8Z5xMTS63vJpG9n/x1GjzqlbK4zWgGAIcXoif?=
 =?us-ascii?Q?R6nT73M9A0OKUKQW1ot6D99/MUc499By2D2x0L5PVgWlNf4hMPlsvL6ws/Ys?=
 =?us-ascii?Q?oTHAkBlpbeRKw96QgSxigLsUeEUI4Otna6LmrIfZEFUSxQGtrd7szhFpoRVN?=
 =?us-ascii?Q?135HFowqwuX2GPlnQOBe9TCdsxk2ZWRvxc9g5wQZ2GXxiUdCTkc7r+umeBRX?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b73a418-d5f1-4128-66ee-08dac7c7cf6f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:43:42.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH1LjmeXDuIVavkPpzj8DrW2WDb/5baazGNCPkv66GZchEOI5PvZbVBUjr535RggVIC8dZZEJg2l7unrCn488g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..30dd6f521b7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.data_init	= (void *)bpf_red_data_init,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

