Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B06ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJBN5EbnEO/XwZb0GGl+sUfoigQVM3G0/Jqum81dwmJDzfTWULlfnntk5LEN8j3nU35YIT7W4Eja+2dzCKJq1WqwnCtVXVw3bF7knebqhHcl13I2mxDxpbdpiS7F3w6lHcU8P4Ofks9lzsVvY2Nwzjj//YP8bKsKKq91HcsjgN4oOI88q/h4fwQHdogR3NRKrEUj7DyKMihmWvvVtbO6eWMt2M7jhjjK7JVuJmcts8/HyWxIAb7xDsWWShPfyWIlcFPyb+p5Wl1tJFWLEPmb7uUQFlvGe4p7G9ba4ToD548IhWfy+/uDk7LQfVHhBTYD+A7GP5bUeoD3UV7b6zktrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=bB/nNRHZvDIK426mIh51n3/m+aYdhwbMfNNxUwFL88hayQmBoia6iqw/KNfr/zeXjVVfPXgPxcGRI2yWfPuJF3n8ESeEryOVTzbcYatv5PLZjHsAOTPB+C0m203DJMbdKgpAx+3LiXt7o3b0FQuoD8wuoRU+C2FTii8vCHrUtpjQO7SNCCj4wcyYtENXDR7rYuwdJOfSGsBK0TsvyhrrIzWi9C5VS5yjixcYEZqnIlyQsomyTI1cJiz9cov3ZxRgwQwLm9ZpxpeuVPksUFdHYr2HCj3EMMzdXuSfJm0MOJpnelRqHz+boE01/GKXe5UubKWqFxZRHOl7z9VEp6QQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=WNOrdoFkMm/9kVC3LnJGBe2apNbaptUMrN3MTIBvMPtmP3ydxjdG7a0NpVdeT4r6GGEiwk48P2kdtylGbngq/Lf9sk0mQJFTMhqsZEbWB/2a+ulMP++xp3jjILtuave1KoJ1/anDHtTLknESUog2v8U1d2YsiA5uPeJFZ/UT0Hy0XLMpy7w671s2bV/qDtIJWZOjzuwmQNGJPCEwPZMdseayK7ZYJJNjiqSJ4d61QF9D6NecWxBiX/hUji5CYT7PIYA+6nHl234YyjmXGkmawQjphar295vkeNOkgGkxaRDZkvRWf+kQIxubRXwEguApcTVuFyM3Q8+FoeOkhjBreQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:10:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:10:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 14/15] selftests/bpf: Add bpf_red scheduler
Date: Tue,  8 Nov 2022 17:08:36 +0800
Message-Id: <cb9659b8f1a217ed2c05dd5ad07f39e35cecd57c.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 019c61ed-680a-4631-d34f-08dac1690b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bSlwy7BAb1f95RXFsHuPGqG+ipTx5XBDj44/HdoK7Q/KvlTHrV4HI/3xs8F54ERoIPWZjU3hByLEPfk5yJzo5WVsC1RTBR/RJJM2MJHVAin+pQakdLpxKvIfrfdYlpgliW/yF4b6l0hT2bzEnjAnHLB3R9ktXO9COCZBHqIbW8DJeHggfAKqSuKWGMHFNAnxFxj4jv9TO1lgrUVrfvxl0G7b9FqGW/8M8XT33ruPeA9FIB2PoXzHeMDklQE5WD2/sEKx7zBzYen/1D05n4H45axrV7g9MvJPiUhGge8p7X84K92wQmkVOqYqYjwDZN4NyvjPVh8Z9UlK/WtcQxDgfcQlzdM1Dbh8ArflKQQ6btC6aYjlkyCDyrAdvjhl1JJpcEvuQi1h/DUAvQAQENeyaa+d9TbbsQWRMh8Z1cEnz0bLmQeQTGVOz7zi/wIJzX9Bsz3nUTEYe0mlNhZQUjdcWX/E2H9zuSvNY4sE9sb3s2y8hb3Zty8Z1j6aC0Pg9EZeHT2j/DZt/ufSTzIIdmgptaJ8yMuyaTuu5SZAlBSQii+ZD/QpreSQusEXBbkG57/QLudxygKE7IbGSAdv0ZHrOUajsh9ssFYMyqEEwGGnuec4cNFgp93xe6Ne20KIrjgBcuE8Tdf4Qpqaq0Iuoci2ORUeKFa3hin6h/kKDHGIA87YjjuAdQ/OqLW7WCISdGmuLIkSLmIRzJePgSmYirLHYmHjqk1EuXwVLHGGqTfDafoIK95AlRVw7+sotqXnFImZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(6916009)(316002)(8936002)(8676002)(2616005)(4326008)(186003)(41300700001)(36756003)(66946007)(66476007)(66556008)(86362001)(2906002)(5660300002)(38100700002)(44832011)(6486002)(6666004)(6506007)(6512007)(107886003)(478600001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IuWZxt43zNIzogRyW9m6nCti9cwLfICuXiV7vsUYZX3tpWTlmUslZ2n6Ki44?=
 =?us-ascii?Q?xfboJsaBJUNMIrORMS6W3WxW2DZqQ+3cy9IV5rg1jiH2cV5N0PT5r/eIAEhH?=
 =?us-ascii?Q?Um7NstsuX/ipoOGuTmYpXcw3uwOnkXYjH7ZzXBLsOT82tqvxNo8kQ+QZE6wh?=
 =?us-ascii?Q?oywup9XMW4oTTueZ1OZSm/ntOJ4jHMXQw3at+tnTsJtL+h0LrSruPUSQO6sw?=
 =?us-ascii?Q?qDN6HBdGztCriYv+C11R1NDZqQ/L6mtHX52GVC3PnXv3ks6Wmu+XuErg/PV7?=
 =?us-ascii?Q?nURVojjPc4jJ3hAL5Aqa9znVLGlvnnB0vldh6zRLVN9LU8LtngTLJPxflYlw?=
 =?us-ascii?Q?K9osDj50OsHDVBIuyIJj3RFXunXrplbXyzmcZpc+jLobQ3wL5Wmb06PoaGom?=
 =?us-ascii?Q?dEe+Oa3HqxKcuNN+uzdu6K6r8RoYFm2whwZuhIcGKjrofXkpcQXwYNjWWpUQ?=
 =?us-ascii?Q?EhSsDhYxuzTFGtmk7nCrYA9fgs6xnwpiv1YMgh18uJI6sGl6AuUN2AdZOWJ5?=
 =?us-ascii?Q?r3vET9jDUArPdYC+u83oiiDI7z3H5/N+uCjGgYr3JrqiXM0KCtDVH2kP6Ndn?=
 =?us-ascii?Q?BAiOpy24J9SIgwSni99Pusz+ioHYmqH1EyjoxycagptyKXqxQno5ZmUBjzTu?=
 =?us-ascii?Q?PAbv6zviXbM6xq1DRd9Uom/HWyfnFPWaS99NZsr5RpH4IsZtl29RNjupAh9h?=
 =?us-ascii?Q?AAwpZfq/6Dh9KEo4XXW6wA5w6yPejWEW9twduHwGwLc99PgCYPxI8JI7UFyT?=
 =?us-ascii?Q?Mi0Q9yISI+wgOU1HfGzxWmYG9fSncBH0OON7HIUaLpTGMaFpAfnuG6hoH6NO?=
 =?us-ascii?Q?ZT6saQtltsjQ0XEQ6/ZFQBZelXvNh1lP347sCNOt5huTw8d2LtT8JoLyBLxA?=
 =?us-ascii?Q?vfJI/rgYjcbkm+IYXVlCjdrUExZwTeJoJCZTTsEQNLGdE0hLDPQ4g7oNHEdE?=
 =?us-ascii?Q?6EjqoHW3syKdScn6Yqf4dKDgDpYQjawlWYrGMVrt1gSZzDWdgaX92OXINWT3?=
 =?us-ascii?Q?T0z9eq0KGBS7Kk08KJWNkWK1dtJsDAk0nfgikVHIt4WZtook0z9Y5WviWYza?=
 =?us-ascii?Q?2Wq8zQgnnQhHy1+/v3tKvom1kZp6amwIh5H4MImHWQBvre/ChQTbPewXHh7t?=
 =?us-ascii?Q?xBwVoiqHTP2jtBynC6G3zy4BycEbW31o3RRCaaf15BWum9PeT7ppJTl/AxwI?=
 =?us-ascii?Q?78R0f3az+2B6JaIu9Ty9rRam8DjxpEkpTHQUz8avFu0KU5nz2q9TMs0i8UKE?=
 =?us-ascii?Q?9qOPHr955Oo9uE6ql12y8d/iW1BVCSctiPtuP1zOtcpzQxruZTfczqfbgjo7?=
 =?us-ascii?Q?fLO9iTXyvlJHzBUuNwS6m9e5CrnJMzhBi2CYNCV0vqskDutiOhLdn/G/ZUWh?=
 =?us-ascii?Q?D+mHwa1W+hFMJs0U68PajXyCDI2x4XKHrt0sln+a5hS6OC5qm+OLh04KjRo6?=
 =?us-ascii?Q?vFv/A+Rgu7LKn5MZN7yifXHuvQAgzDXVVDTCOPaocfOkqWWrC6A5d97uTDet?=
 =?us-ascii?Q?lZHNzX9nbsd+1hzGxvSZUpLaBkiyqHRZDPXzv44WXQch6jGNc7QTTr2GhJhH?=
 =?us-ascii?Q?u4NYqPr7rdWfLsYnHI9DfpXZSUCRlxHDxeeLPWVE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019c61ed-680a-4631-d34f-08dac1690b8e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:10:13.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKgoq4V4Drs9jw5dhX3zLUkoK6WRklrz0XJgHE0U9gY/UOXUWbUFndzLPOq+Cph5TPKLlZWYTRnIHGbzXc8IOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

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

