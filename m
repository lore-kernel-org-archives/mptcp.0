Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DD1876
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5DhWBSxLNU3E9HrBSjOSy/hK7r6Zj8IJTtUl+hm1D5Mw6qRQUxxGBUKbdFz62y5EtQtcsWosUFwa55LwNJAy2wecWwBygZ6KYKZIBMrUqPZ9rwowbvNLWTFLHcW7BrpRAe7a3bKaBgvU/E5LrmxF0KMCyMkH67JWbAVeBmi+P7EX/1G11WcdyV7hHQvYZX4jT5YAJTbGeLSycSicS4us+ZSrHziQoZKLo7FVEriPWqmvRuCMzcm55xD4R0ZqOZOT24U1LtvO3dlNxHN7E7ODeayFZk1NdRthegTmdQorXgjNhYaP28hGOKuXXzVBPnlt0lPHT9YUGu34shPlGCz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=c8wPb8e0JC4Bi7PoQF2z+6Y9tTd5s2JPXH93bg3I8RLZKUswcZSrnGC5HqqR8LT95k0+cQ3dBzV0MfjwHsNfgszpDikB77F/UL3qhnqbDcQpRYMaWFpm+3P1/kLCBdP4rN/195RJhCTjduY+pOEUjsSa4wRy4Nguo2onXbzCiNCrNWAcQmzt7R473xjB+pZfh5SolDa9fiByhBMEy/g0LOTxqMStjlARILH4JahLgLim506fBOC9JKEDJISzPar6Yyfsi9d4D7BzXWpcipjFmsmrKkUA/G26Iqj1X1KJak8KgDgX/M2D+qTCiX37GC2ZLB34nXd5oJjWyXCzpMqHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=xJFdGKScQt6nqStJyhEXs5Wf4EBa3foJUGP1ZcOFPmyHUD8FuPAjjZ579XyRQ0Lcix+wk/A2SXzQ4KUOF8VVzxekwybKiOdUNc+/9Lg7L92Gw3Ss9obQlmcYwdNAl6tfD/HZgCGQ8mvDwqcGi77CAKTORvcxyqjBRCtLKilceYfAkd3vHg6M5U0+0zsC3+bo6mjFG9KlEkxp8vXLS+AKhPo+b96Hc2cUz4cw+Q//brqyAyjGOvaIHMYdvlMfnrdoG9j4c7FZpf7BsUjHx5gePWSeQ40MQIpRjjtJpsrT1Zu6np7fDhCbC6dac5toozkCL33I4xSYm8JbgFFc6KgvzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 10:50:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:50:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 5/6] selftests/bpf: Add bpf_red scheduler
Date: Thu, 23 Jun 2022 18:50:27 +0800
Message-Id: <dbcd30665c3f2cf242f3ca3b6238a4eaed19fd59.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655979747.git.geliang.tang@suse.com>
References: <cover.1655979747.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e782312e-8429-4077-f0df-08da55063ecc
X-MS-TrafficTypeDiagnostic: DBBPR04MB7659:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB765925F12EAEA9619968580FF8B59@DBBPR04MB7659.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kvYc4R8MlyD7qB8aXozLup0rgXHLbKSez+taY7M9X/DmvGgaT8HDI7JDl8n415P0uLjcXl+rv/ibor636A9wq6kAWlneUku3KG0B7dIPFMu6x3N7WofRZgKZO0b/lZW4AXzFTLP1cTO2mw87ZiJ/HGo92eqgFNkUsu4IhXz+zJT9CokhqBoHK3sicFdNrMIF3+6n8Xg5iKcYgDA7EoTJZ2jaOXJyhoUQfjcX504RlHq1KlJ/LB+ZTmKgR712cgNAqWBR1zkRS1b/OfLRPEyOGxu4/pVw3oGGNbGqEXDMyVgjW+4sn+B7MLcpuzFqZPnUmQvPD/uhLO1CE5EW8kieuaHResxAPYKZouaka5pFDpPcfOJ7ZUTlKuRQtid4ZMwKo4CVCdpXktn8p0McfAaSJ3pmgDyySLN29rpuCvsMz8a7VnDrhN86qbckBLZiUjkGwcH5UHTuiHFQjbe29V4ILPA+XEXLVegqElofKMSASJ9hd31bDNuqRrl+PvSJVwthtRSu1X1x0LECkKpPVydGItLCSdv4S7usYk0R3uyfu7yZUTLXOiLwGn5cxWU60/sabXuTh4yMtMNR1KEh0f3ckO6K7+LRfeQ1oGcjf4xfmCLIa6hmXbh7IJ5hRU2l9XbOukOdd5xmIX/IhYV4aUx2xli3GPcfl054O5B0EuO1eeHwG0QSjZ0fa1ai1g+pHZo4SdqYpuAQImoPsHb5yKHTkNDviGRnyJs6RCT+Yd1xcfL59ImOlYhI8WV0PWDFyVk7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(8936002)(186003)(6486002)(6666004)(66946007)(478600001)(36756003)(66476007)(4326008)(8676002)(41300700001)(6916009)(66556008)(6512007)(2906002)(316002)(26005)(2616005)(38100700002)(5660300002)(44832011)(86362001)(107886003)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eoJJSYOvoXzzZ6VoSxsucxNQkA3Oiz9SCBLhHAuZe53MvdOs4y/Mz2ooQ4zs?=
 =?us-ascii?Q?niUYecqGIx6/9Ipg6qLcf5y+NsfRYGq7gsmTL6+Py/rfBaeE2r/j9NIFogqn?=
 =?us-ascii?Q?hkZ0/CFh1EGa6XckJouM9CVc/sGqhCY1EGoRfbhx/g0IwIBe0Cwh549ti9+X?=
 =?us-ascii?Q?6kwGNX8uxCgKfllqsOLBc4uAYt46FQrjwYJbq/iZl3kNOsaygeO7X0vPyybg?=
 =?us-ascii?Q?PL1k42Ar1l7Phr7yr8gq0g/MfN579pznqesNWXVbvGyEya7Or9OSp4vOzLea?=
 =?us-ascii?Q?3V8bSfk4/Q19aH6PndiZs1b4BDEROqkrsQiO3JIGuLl1mvbtERW9rWK9x9RT?=
 =?us-ascii?Q?KPj8E9jOC6ov48/UzbRDGJXEtGxSDLZVlyC3SqR/d2vNyO8bm0vGstB/MBJW?=
 =?us-ascii?Q?62y0pMUGvFYnrTECwB4uTXdChjduC10LBhAxS5sfJHGR90fmFdcAt/KZvJTA?=
 =?us-ascii?Q?Y+OogWcsa4bhaHEtEFi8jr/tTlpYCFrk+wKCSkfWvoJ72NAD84qbtZ35VUcn?=
 =?us-ascii?Q?aIUDqJy2fiTThE9NGsYMaaAgkFX0QoZRskljY4DoTBgvPyVydqD1EVtjN1z+?=
 =?us-ascii?Q?sOVjj7qItE8CiYtI88wFBFa4cP9znIK//ZcEY/hxvUjVYn7ncPVFh+GdXcGV?=
 =?us-ascii?Q?Dm3pLNItQV7+ZXN3wIAas16ydZTQqOYSr97MmBg7i38LICac+QSma65Nu8oY?=
 =?us-ascii?Q?cnj8UgYOj9PrcTe4TcHui4clyVh+3mIcxGCqSQmsCmCwJEU48hU3y14QzYgI?=
 =?us-ascii?Q?q65ExN2y6OrZVeS8t1i9NNmZnxgRVIMKTzWGtNvp+XefB3Bo/KJXSaPeS2QK?=
 =?us-ascii?Q?Dfk9HSJ5lqGBAPLfGQSdvs6XQUZZG3KBxELl6qiEpYZEYlcJdJuI93KfVTlH?=
 =?us-ascii?Q?sWea7iFPtn/jwsopYa5kwWtY+82kifpM8nTQx0gW9GJPW+OinCoWTZ5Zv2Jq?=
 =?us-ascii?Q?qGxbNF+HBvCxev8T+ubWtq41OJQjf0b4WkjO3qgQTglDzNyov7gCBPiaRyrz?=
 =?us-ascii?Q?00oXXkMT3LeS/bovWgVjEFmk87owHWtPAVT/h2/yq7CmJon1lj+oFHP43v1R?=
 =?us-ascii?Q?qXKyKg62UuUL3fyAZcuotJPYPei2Bk45Oh9xCS9p8eZpxO9foN2WoMG2nIDt?=
 =?us-ascii?Q?Yp1J4eEjHr9A13BUptTOZlYlOek5GSDcKTcKV0oLE3FzuEeVwXfOqaZnH7SF?=
 =?us-ascii?Q?lELsk3Z7Rl5XGEEawWFcT4DDD6tuSjbeFdAHolNyU/ZiWl9JaSLcnnJGOOWM?=
 =?us-ascii?Q?dXGF85apFH2Nz7/cIWbKG0Tw2kR6+25tzRcxk1W6O19w/i3aKLatrbG/Z3GQ?=
 =?us-ascii?Q?3NnyIR7VIJ9g3xcBbq6ohzhh7JQ0c2MqJ+Q6rMNfn7C6QQJjM6aGwi8QRmQ+?=
 =?us-ascii?Q?HMR/eG6kthT9mt6VqiDQdaBr83QogDeRpwPvth7AIoKXxi6Y2tRdvcK8tcnf?=
 =?us-ascii?Q?18cPb0qqZGGORW0ChNbxf74uNfmcIuWMmf1iCbcnNrlgBAlbX5O/L9hVk0u6?=
 =?us-ascii?Q?n4+Fe7Gvmb8nqdR4aSVTwbGLYgeFpCTjkCDeADhZfC6vlBKoSVKaqIGdax4v?=
 =?us-ascii?Q?lE+jbvz1+MGHPHWjp1Y2NWzk7Y1lD+W1gT5bMaUHH2luAwHjtybqUNEoNwNX?=
 =?us-ascii?Q?PtQ7BtseLx9WU6QuYRo62hkQcM0IJiOSptopqG2GAfSbBx6SOXfEtU7cW2qN?=
 =?us-ascii?Q?RHR5ezbYiIqw+IApEbdeKh4RCTDcgqMSLKKQtu6hvkpsYTPcRLP/AxxRdBPn?=
 =?us-ascii?Q?n+TlIq/kwr/XthBdqXcEueUimrNOff0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e782312e-8429-4077-f0df-08da55063ecc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:50:53.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ystvptcLUMlQ2MTnU+AvL1LSQRIMNJ29QyQmaQew6oIkIn+UGqaI0XyJjJ365GZiOC43wiy0KNr+uIOEtUbv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..58f90473e495
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,36 @@
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
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

