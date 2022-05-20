Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE37E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWaSsYeBT/crz+QpmWIwDUJ16Bhkca6PspThY4dUU4s=;
	b=ToWvdQP5sHyyADwPW/b/yaNQ20SPx+pe94kGEYUXS6TTUJxBSMRi9/KBMil4SK07eJVIOV
	DZpY1oVbL0UnpgO2BuA597KbvJfNqiR+uJqhzSDIKirTwREKBEh2S7iZEdvKulcLgEAmKX
	miUJOPSjzLP7IILUYL7n1xBkIJw31fk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-k_Z0IOBCOf-d1ipZqfAILQ-1; Fri, 20 May 2022 10:06:08 +0200
X-MC-Unique: k_Z0IOBCOf-d1ipZqfAILQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbChXS7V2FOK2G0RdAKkUph//rMciAdbmZI5Bj42Wi3nyfjCmB2xz7EpAHHGQFJp5nJUjVv0cV6Bs6XX//LS+hMnty9S0hh8L89glG1ryPdPfvS8Xl/XpRsEgDehWzbwcMo6N4V6M+Ox3u9FM1ck5Skm6WAvNXNEDUy2bViZ6UD57An+Dw/aE8SSz6EuRXKZju6IcIION4Oj8QiPwGM6CXI9yVuLrZdVeyymAUIHBmdtjQod23GAobi3t4VUG+42R3xLkf7lk/h11H15GiFaci9g9Xhrilozf+dlTYccJYuFv+hIUp4+jhdBFm3KzzMmFvTdyocPHOTiy+5s+ZPwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9Qtenbl/uIUIftsrou1rcIFnTD4vUeHayUYrbW6Owo=;
 b=erFjIqXGMA3+lbg1GJKUAUOcJwZI5k7cLLT06dIFLXwcqXqmkrAn3/qzBnbPNtuOVJzmbJ70nlMQnwebse9uJQncw+gQI+C2gC6ALEri6RZvWjLOgn4hD8y7dGLjbtkojNYtcO2YcHX8fPi6SQ3E/7H3CobtZNkYqsBFHxhV94VY9OvRidZJd3FKED91RL3afB/OWQmGoRQba6yDc25vFLQluL0rhcPwiobMFCbrmLlefMmpYUVH66KfmL3zVAOvjgQO/qRBFxNXfeghICQpOL1qWCouq8yzwAyVgFrL9xLvqZz6hbe56YxkgBVM/G/jCNFzCPld/EBlIEDFComaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:06:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:06:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/10] selftests/bpf: add bpf_red scheduler
Date: Fri, 20 May 2022 16:04:54 +0800
Message-ID: <628bf12ff15197c6e77d3fc3aea5d7ddb9dd591c.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:202::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c18183f4-3bde-45ee-f1de-08da3a3797f8
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2757:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB27573C3592015B314CBFEFDBF8D39@DB6PR0402MB2757.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Yxrd9IPCq5ngWSMcg3PYg4vkCKGXSeDwZbMnfnJScexmxEFhnN/dJZ63JWrQ/dIiyh25gMQaGwg2qUz+PytwwvqvLu9FwysYmqg4i0vpkXKkcIQE307yyl6eMczR5zx64F/mpAdlrReFcjPNoY1xuHZwr0uZh84byzMcUXqUMRLvUzmsC/bPjCvbKfb92xE3CCZD2x+JPsWgBsb1gKxESPllV2ihk8zx7oJdhEgnzBalyIPXcVEHeTCwproiV+f/rZodhtQmq7JTRllOeNMcEW8r41n2p3PBoSfIxtuMdn9809dxZkKxMR19JnqpHwUkwEBvUsAD686egeIuMIAnFclP9dPmFJ2nniTwi16alSY74KEiryDrwbtdjNGfhpF6oeFMHAED1+s2ZrCvVDLgVijIOPFwCTUSNQlTTPrzHlFRg+45e/EMpUpjTQZXkvXrDGjuCK9EAwv3eMZBk+MWJ+CErBZGjSA9DNLd5dqx05DHlFAqntshjtwW7bowHkaZJK3tTu/Yg1Pvflru1Nb9qL01HePcmKO1NX2nWnu5cvNvpg1W2vuM6IFFh4ThSsNoJDuonLVwcWJlvpRbM4yh9LWfqHpvSN4XuBLlsV/ki6uQHFtoXmnc7azgvKO61mKsG5q/lrdNu70pwkBKaVF+6RNuqWmmgj6bxpStF8eVO2g57P78YUG7QXpcDq2Dki9QhzXp5qSEUAN7/pceWl3qQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8936002)(508600001)(6666004)(6486002)(316002)(2906002)(6916009)(5660300002)(38100700002)(8676002)(107886003)(4326008)(44832011)(36756003)(66556008)(66476007)(66946007)(2616005)(6506007)(186003)(6512007)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWrNjRoZWF325iUnzHJ+30qjnkpTLl/qTyWveXdV2fsyvLqLAT+xHf+LCw5n?=
 =?us-ascii?Q?u1Ifv4xp4i1SkROVGv3iznWwaN1VQlXMWSDSvSvKEOXbefVaXyc6VfOCoRMl?=
 =?us-ascii?Q?ugeBrbvFJdRZrNWVG0sYBLNamxXb3HSp56WawuNyzJC0vV1/L+5oWpPT8gH5?=
 =?us-ascii?Q?zdyfyzUogjFcOVlvSw/11GxnG3zQugjKlqN/XwN8PkF2TyvcPcQICf0p+5+E?=
 =?us-ascii?Q?SAiDl4GanLvAqcM/ZJ1bDFDoYtboWITevCdIdnqoWB2dHrrZ/oJvwkO4Ejr1?=
 =?us-ascii?Q?qofpdjp/2nqQLngSnbqFVUgPCb2eYaiSaVLTAdwuiwNeLt0UYwyD20ZXgNZP?=
 =?us-ascii?Q?gBKYVOxOjB2QZxjEu9s2O3YSrdsUUHMz0SCKouFa75aaDLNBRavx1mQ2po6a?=
 =?us-ascii?Q?l4vO2rAlPvrVyFnJuZbgFEDk5m4DKoXjP7dOfvfZjSWSGGoqjrFcDQ/0mGMk?=
 =?us-ascii?Q?h6hIB5g2LdPBMernXeTXmozgyqhKSQHStlLa+Bc0x4w2av2zmIRqcEXJ6L0o?=
 =?us-ascii?Q?iX3QDx01gRxGahXbrX8WSHTENLiUDP1Tp6Fe8z919bpSDw8diG2ZvccZVx0W?=
 =?us-ascii?Q?DcFnq4lJiCl90Bhpf1mV/EwZ31WngiSM24wQV872nYbB32/nMsjaRfByWIOJ?=
 =?us-ascii?Q?P2fQW3jNsXr0cvhnalYyzB+CkxgaEYcT4O6txVxFA0VN8SvandMo5VkHb17c?=
 =?us-ascii?Q?+5eED7KSshrjIlO9OYSFfZgwyeEoEv9qRIBZDsI1jz5eRh5Qayx+K4j84Fu+?=
 =?us-ascii?Q?3+V9fm0FlUD1Cx82SoptKoKEdoqh43KFkx4Y7q4KflWHJwdKS9+iuDUAx/9S?=
 =?us-ascii?Q?qcmMG9SF1TygvvgZCpbYrTVju0YHMnWjvrYK5dPBNkbSDwHrGYiWU1/mD3/e?=
 =?us-ascii?Q?y2zqW/9TDoowcQmj2FmBibi+qaIm57I41xp8jO0JWXHqSJEofJS2UdIZ7tdM?=
 =?us-ascii?Q?0si1lMYjIqhvb6i21CohxXro0FThCwjRgUq9+BAOjbw3kbN1cyD1jiIVQ3Mf?=
 =?us-ascii?Q?o1fgfH8Yf8iQCb1+vq2A4/WWM/HltaLomlb0xlgJK9djWzd2ifqgNY970Xis?=
 =?us-ascii?Q?Lp7csw8sBAt/991jbZ7kqrkUevXDsf+UTwHostr8CP2fU3QGHND7rdGg3keq?=
 =?us-ascii?Q?Xz/BSIxG6cGlCFb49pX6w5HzSlELMvnAynni0Np9ubwyp9tMsh6hi9IDJCRM?=
 =?us-ascii?Q?Z6uAUZFgzmdJK5GxAzCTXfeeiXBMXP6UdzM/N45W+uxHqZfMjyJTkT3gdgyL?=
 =?us-ascii?Q?Yt7qyjkfUR9trmJpslsCzZLeiWm5hd8AIfqrQmvNlMK2H7xuCp8eY1RQAtLH?=
 =?us-ascii?Q?Ib1JXARZsPi9Ee6e3zH9/f0zMgkOuSkjPKy1YFEaxAUsObQ8//woZUl5p1xb?=
 =?us-ascii?Q?0cUPmHlgP9Lo8Qyn/TG5t6HgRPKXKdiIoZF9JVAr4xiho2UP3RmA+xVVgdyx?=
 =?us-ascii?Q?CkFU8OpBKEQQs8JU0csvoP06XBZIGBnxVWIx4HrKLJlMQDenIHQsRG3TnLZQ?=
 =?us-ascii?Q?IpKK6eW5m/jIhPr/GMRnFfWMMO9vjWD+pzJB+v7LDK/JfA3mKWUesKkYTTgv?=
 =?us-ascii?Q?hzfFaBmPpgio7a58Lqo4FU6oZCfah24JaK3DAKCAfxJ4s1uqz4xV8eSJKJOd?=
 =?us-ascii?Q?bNkB+12G7TMaBPmABRbIyTUMJ/vCFM1iEJXQNhdsBe5YsvEo9E+VgWI+bIi6?=
 =?us-ascii?Q?oH1QJzQclsgiewYV9/5uYIH8Xj589Nx/PZdzDORVvAkKg78c0uIUPCzg5IMe?=
 =?us-ascii?Q?9aKNY41RB0vh2IcJBeTXF+DVAI4x7mI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18183f4-3bde-45ee-f1de-08da3a3797f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:06:07.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LO9rngBjxydTRdxkuaqNQgDt5ny0j/a/sP7IFpnwEacCtcwHCLCKxnQFikYrl7IvC0A3UO5DbSZbSc+MnTESrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/test=
ing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..e82181d23931
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
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
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	unsigned long bitmap =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		set_bit(i, &bitmap);
+	}
+	data->bitmap =3D bitmap;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red =3D {
+	.init		=3D (void *)mptcp_sched_red_init,
+	.release	=3D (void *)mptcp_sched_red_release,
+	.get_subflow	=3D (void *)bpf_red_get_subflow,
+	.name		=3D "bpf_red",
+};
--=20
2.34.1

