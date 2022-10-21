Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D687B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R78JKrFzDqID7LWcVlcA2iCkEmsikJJCQJ+7b9DmvCVk0zVaExI//mVcEgROrLABtGUvr7DKW7idwX4ITBtskRzLXDGC7D3tfeNyrDd8uzUzv2OPlNXWW5ELnrzWaGjMKUh3cBVaZAKJWVpq7r3pQpM/1E7u7LUEgZ677O94mmkD5UD72bLxjGAoyxsj5I9FMo4fHQ9eTA7f/fMvOPajLdhOWnq5H5Am+ON1ppatOsKyq74HVlzzWexPF374mIQ1iL6tk6a6chOFCwkaX9yPGlgo+tVTNEmqEcvgpRmQ1RHbE2P+CySF0TR2nfy4QEkkq46/E0l9GRQnCO29EAonUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=K76/Ava0X/8bpDIlThNz0HxQslVcrsSrDPhc2srv6FVh7YLuZx+TD536bJ4oK8BT5iNsNv9K/G4UU3vP0qH8wdIN4yg2RM+i5QyObCSgG+fIApvFiGnO22BOycWI4Bu/1jNAXd+Z8ETboz8mKcdmh967cOAqgw8DvhTc+yURwq8U2+dLtnRzllXSaSTrIIdkCyhpYJY1QEr6x2T6OCEs1Xl5chtBJu0Ks9DQ55ux9lmtRASP6itFcczpIonYtl8MYVs6eKz9W+dysj50V/0hTzrisDeHkCnoSHFk/o69hHULdIFXctv6zbZ0NrF39nI7i4KRrjFHOWFSbB7HHfAfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=eMaXP2t1+7Us26j61+MbUL4DyfYRJTDprbNAot/PjkIz0jYrKztmNs61DGakHS0xW3tnYpuCaImGIJM9eu8zSDwRUSzl1eeeTPEzTxNHCWw8uXduCG7fPPe44ZQ5/XmwK/6+X2dNMqaTdf8Nj5Lc+pH+ZzZGhIVD/zbC1e6xQEAz7MyrO60U5UjOzbbJ/41O1TyP4gXbfjrZqz/Ylt4lA6pgJJSzvTg1QtowKtVtoGp1WicG1n8o/gg73UAF0PZivyJa7O+cPEyGmd6J6F7f0ngKmEvvyczxeiEYqkdCndnvOTkQ8rO6OhJXxs+XAzDHtw9oGGv1hFEug9vgmTJ2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 11:03:38 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:03:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 18/19] selftests/bpf: Add bpf_red scheduler
Date: Fri, 21 Oct 2022 19:00:10 +0800
Message-Id: <06e28fa77986381e61adb7a7b7470f1d67a52add.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::20) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5747c8-c9d4-473f-085c-08dab353e817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xLcToLcnGrR6QL/jpmzoH6oR40rzoI55zbyIhv5Voh80ICwv1xnOElOsOjqanhA3MHtXB5xoNFNHUF2cfRhsa8szDkWzGaq/gHHf3dA6FO3tdPoZob+7KFEgDu4/qPEmsXrlvJn8Slua2ICewp21iYjQjryQN5j2dnIDI5X3rpdxJ4TytnRYhZiPyfjZY0ABdNbAwZNQm+ohD8VCl4Alh5vgfqZplJ03+pDkJ6c9JK2dkpIYDbFFIsURiWALnqumLfoEQhWjb+zWNA2Bsxa6jx5I3vw1oXReyy+C7k3NoifdSwii0eNFemN764XN8mVTpdQ5UhZI4Hnd6NyWrAlnv4QlG6jXUm40adArpImXN8aQcm51Y3UkbrgakgiD+ON4kDtplFNmVRx0W4nvU9G84ZVwlXnDHLbq7gAYWblPgxZ6m0F6Q1fI5yrluF8ffv6kvlXVKFcSclMZ7tDI/Q2RHBTLPEs2jG5/HnQzm8FZ4IiAgodM6viUOoNg4c9ko1zPqRAQ9fV4btwgriYAruIUimdqSmS0Odu/kI+MR00ZVcXzPXVCJ8cRLuVjLYYN/TV2LOCPoqIPns0xMdP8SDL0vou6Oce555wdBxMYTPf7lrh5Na24YqEtjzttptWd2nj8hmmJrWiWwPC8yO/WhCicQCZtXTck77majEl/LP+9JVYRqBaoeBP2k7GzEgqinH7xwazPz4aii+Pw01cOfXCpodhdQDjEectQ2i0z27ez/dYqd6AVY6QW/VzAHnHxLKMd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(478600001)(41300700001)(66556008)(66476007)(36756003)(66946007)(44832011)(4326008)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(26005)(6512007)(38100700002)(86362001)(6506007)(107886003)(6666004)(186003)(2616005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFUap3HKVEHGOPELBr8c3qqETJGK969DLDu8N0Gi0wQKIiFnwJQsZLZzZe4S?=
 =?us-ascii?Q?SKNApp9zcS8z2hNjDCt53/QwBX+rO4VvA7lTIeoX6tVzrcDKrfIS7YlwiLto?=
 =?us-ascii?Q?nWoTNyvwCH8epe45YpWYICEWGZUF7c4O5NtWup67Bo1cNmKpATcBz+Ir6e2d?=
 =?us-ascii?Q?zR6EpzUp4jLoP9IFhOusdkLpT4N8KGsatqAjajYQmwktyMk0BoQy99RMjyn5?=
 =?us-ascii?Q?Rj+v1/WHfBRpQOU6phEsivTYOeZm5amKpAhCpKJsofgH8o07T8SiVJs5b63F?=
 =?us-ascii?Q?ZoJBRLEgP1njigyzp2X8T8rv+ESuwefjHJi1LbkxbdJV/n+Di5m/Rdu1ZtH/?=
 =?us-ascii?Q?Nek8LWRlzU3h5v+Ax5vrjEO5gadxDwqPPAHfTz1x+Lxx5ucByacoQqWzvsY6?=
 =?us-ascii?Q?TMzJcfADCxmyHMy+KdnxJQPSgqhtfGwhV5D5nEMUJE4bRo/ECwXIQMzAowNr?=
 =?us-ascii?Q?Yolt6vCxHCYiHhyo0p3H7/e+sN/DwLughoDUQ36qLsJn/yC+zK/csk++pQYJ?=
 =?us-ascii?Q?OpF2vqiIu+3a0+7ocvxQ5CQRTWjgtJJBh05g+26ZVSQWo9tbBg7I1x7fx482?=
 =?us-ascii?Q?BkuhGy2evI830vTZByPG5KCyH2dOo2RJuBDBznBpOTSM67tIZ7j6EqIKnj7b?=
 =?us-ascii?Q?YJqb5JcyOuXf1+D0U+QFLYF87/8zraDqW3jQh9cFb/Runl7YHo4EdXFc38HF?=
 =?us-ascii?Q?3SLW/Sy+sN8owTchhnfNYbhXRR/DzEen2kfjzHSwuI0Gc9E52SxGJbaMUgZc?=
 =?us-ascii?Q?Aje0z4xQyd72HUeIKP3TsGUfB2kXGxU70AANsGO26WdAmUX6tl/+LHEGVTg9?=
 =?us-ascii?Q?JF2sk73OhaqYDfzRYGT+HMO/8Mp2sWH0H5RQaQ7H9oJvghw468mRbtQ+OuM/?=
 =?us-ascii?Q?bw4ABZ+hq6m2U6u6Rs8afc1ivBAOFyBrV3PmKrOiccdjzFehawVMb9Qmk9k5?=
 =?us-ascii?Q?ZWX9DPAusJcCxcKXGINiPvg8eppfqyXc3namnt/bDdQLu1+gbPwyxqWRkcSX?=
 =?us-ascii?Q?2wdg5hlwa81zBGnRTu/HBKsxEJW3je5b0Pe0xxQTWb03317PN5BPJEUIyF9R?=
 =?us-ascii?Q?KR7oZkN0v1O6X2VIMm06UC1qcmbr83bd375mSMBeZ18P/qFN3gg0KP/A3aUO?=
 =?us-ascii?Q?ztab74Hat2F1EQWOgC70L7XI3V/soA6j8GKDBSlme/2nJzhd+dnJrqA2cyDI?=
 =?us-ascii?Q?3V0y2ex8tAPCTYdnGVjA30D7TJNzYTwH6Gpu9AgUBy11Qb5dBxSZFeNH7Vvt?=
 =?us-ascii?Q?VPu+uVCbEBgXEH/UthzqPy8q6RV4Q8QxQYbkptGe5zZ3nwzODYw4y81qv4oX?=
 =?us-ascii?Q?7vOyc9F8ILKCajCr28/FRLCN9tsuiVQIQR7DOQjMMi3CNaZIzJU5LmzO/qj9?=
 =?us-ascii?Q?IFjYEHVLxGQsvFPJk0lhs0BLtZXKIKVeoMRQh+77q3gBk6FutynD1LTTTM73?=
 =?us-ascii?Q?voyg2Mx0vkU/PthXgC2ykwZICrlmm266sbbjw2PUSTHZxpE87NDkpIuogG1u?=
 =?us-ascii?Q?+osww2k25iGeKYgsnqY9iyiIVm2lHQv2PdpK5yBwQZFS5CMkAO0Qm4A+pYeP?=
 =?us-ascii?Q?CqS/pU0LIpGisfSqOMvlWrJrUe6GfdbwRUB602DmCC0TaY+JkwA9QZ6Q4Kl3?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5747c8-c9d4-473f-085c-08dab353e817
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:03:38.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tERlIw1M5Cjz7fyIzA6eemVVakkG5AW18x3AMpy9+Hj+RhnqBJz8wL9EAjpn6cTHOg/R6aVCZoh9wjEqb8xYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884

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

