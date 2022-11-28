Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7B364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7ds29BgMo2cr/km84V7w9dFHWN8u1KAtN13IKCFgmzwokhJkoe01+0Sgf/IZCl/idYRXnz/q4A/gzcog2krl/hw1rCuwrkMyzA6BWsNzDqpQk/UkuKC6fVWtWqhXr8369UPLoYn57hb4Nc1c+sA4rfnE6DQEoQdjJsHE3ctLIjQg7fHor2Irkc8O6D/Szt4HriSe6bRFM9FSat3PGPnKQeK2Pxd35NYst3id5Usqy3uQTtnSs2kDn5Nfatu3f6jjkrr5PwF7k4zGQMId9FikTwinkQUfVepoIaYXXVEYuUIyBu1W1QKtzhZaMrfUPYDbbmU2pTByLb8t72FeaV3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=I2v1s87h5N6Fcsf4veiMAi37VpK7M8PTxwgD8ZEWQEalD1DMciPEoH/Y4gnZnDzO/hTB6ZFS/ti2Mr0bQ/lKBmnj3qdMekhHA5k/0EgfIqGgR5in9tHFyYz5grk+Y03oXTozbyQOHvDWqla4JKeM1Kp4ezmuK2W9uW7bQ2BmerNpuByKATgdRoFYZ6pp3Vi8fTuWl/He5nT+wt/VYGyxbBapJVTy6uTQGTn4HeoE0z/e28CsqylyD49cOGspsEBYaQ6MlyOFq8fHO1w9abJwuebxDxxjZ332OsUHDygQp/2niYZ5KoX9x6uYQwLlHcwi4+T3//a0bPhmKau/JHN1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=1M99noUvE7fjzqlVaANjuNrzGzwiZlTDBRFXfg6uSxj5aqT1SNWM+lTAg5mAkN/oB+2j19LeGukG9whvLtZ9oTKLNm3Pmbnip2HeTRgsdjzK77DzffCK39W1QN7nV7w3tE0UpfuwwSO037e+E/mHNIEySDzNzmN/zC7/icFPjlnifdMmNO3HuiXwwJiwwuHR830CvNK8OTB0hYa9bdhORvvfADj2/T+5NQ3aVEZEwIURZU5yGhqMAPTQFnHRSOmfEET4qim6PbUxehmyCN202KdVMdLiY6NNmx3tBNCe5BN5Dm3EZND66qSZgsMF3VAmLCm39NOV20IoCBVj1C/x0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:24:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:24:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 6/7] selftests/bpf: Add bpf_red scheduler
Date: Mon, 28 Nov 2022 11:24:02 +0800
Message-Id: <558825555797998234365f47a8976693b953529e.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3cdcae-c6fd-4ad7-e067-08dad0f004e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	okOARNuj61XBj7jIUiiN8w8YqaKubSD+KJl0bOTY0YvIEpsVJbdL3mbpOwggvKfTB5EBaZxAVhlTU2K/f7MTCP6+NVucL5EBp/3Qhs7oNkG2oLeLwZITIvOkHlMMN2dmh7+DLJstZr839ajkfzeElNBzAbJ2+k5EZ6Tb6R2MpynNF2A/U3ekcgVB9MzosP3z2f6HU4ED/gA6Gx3k3qrXQnKW8GsxQKbZEzzDgPNexJr3+i0UvAC1bzq/alFGgkCRU8XPSZ4Y1e9U/P/mRR6wQ3Nwcklh5Bi1MoPu5Zpn44NWjgdiPQlk/wYuYG0bNMdxKhMhhtMqqBfcO5xoelGZR7KFQyGkrbL6GIgvIXPqqMFZ/a+mO2oPuPNcOlVgN1IL/Q+YrAvPYO50ir0vgiShZ5H0IUheWpTqsEGqrJK6BpAgz4zDa2xIPJt4ZxtbRVGuD6irZMsRWAuqLsK7+vHhmOh69Bp/Jr4TkQCBnuAHhNVEFqMPRHY/6D0a/FfxeVWySuvcsxroAjC7+SgemU+8mAf3Du3H++xHvb3cngI4D6jCa2KK2jAbM0/pCtyDaWOvfIzlF5qbEcrybvZvDUDGrauOus0kAYMng/IUCjz4Sgag5dZjSNnfef1vmv4pDa2ULTnLURRguP3+URmH0KkPsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JwAIq+Eaa+EKyq4ZPIwR1BWv6WgcWoM6Xwk3FIu/JSMR5wjnt43lR5DsWz5?=
 =?us-ascii?Q?YstGCGhtcXHCChRWXrVUvXJT4AAgpviLOOj9GsyB01E+IIX2DYCefzrkSfBi?=
 =?us-ascii?Q?ltMpMzx1xV7DpoWnCOeB31Pa3e4uFAiGkz+Pv8dObgqHeLFwGnjS1/NbQtcu?=
 =?us-ascii?Q?eLly6z/LJmBWsnOy9Orw09gNvOpNJHmDS8O/pqq22wRnVN0J9vaCvDouIeeT?=
 =?us-ascii?Q?5sgKbhrjNxJ7pHCs0YHWXdULXo34YuwyzSBMwhy5I9Ja9DMhc6Na1ipornSf?=
 =?us-ascii?Q?WkecPK9t890s9d+m5Qd3RJrjcdq81ix55KHlEOZ/OSDqUy3s+eSyW9pJ+AV8?=
 =?us-ascii?Q?bFM/jJav/DPPjtpfUC1142CibXT9WLn947SgpYkP/hstQKm3WUsnE8DvO7HP?=
 =?us-ascii?Q?zZ5VM3hnoGZIfHX80Abi6HUc7pvn7htD/XmW4X8cBP7isKhPCdDTCnT5Y8B9?=
 =?us-ascii?Q?bS1KMpM7OTVIr9Pec8UFJ330LVCwBkLMGIZ1JS4wnZS7J0n6ChAB0w5xHPs1?=
 =?us-ascii?Q?j0TFJ/xIvvPC/wM/s7CbgqP8SwNft38t8bDLVOeH6yJwQQHct/adsFEcKLRz?=
 =?us-ascii?Q?sk22zgGjp69Ktya+C0EV5oG4tI1sSp8/YDri1dM1TMuCmRLBHLWq0LkmEi7c?=
 =?us-ascii?Q?jwS/uDfq5dfjierbY8K1OrggAaHtvrci2uZFaiaMxOZGW9CCO69WtlkaAj6e?=
 =?us-ascii?Q?s4o8kqwPaniYL+rarFoEAGPq7O2enx4THFSWOawbshmvEHxzJ12DCNfAb62Z?=
 =?us-ascii?Q?aEqr0vkgSyFnzqHRkiXaZXEPdf0C4L3mihzHhU1PXT+xuS8xQ5KQP7W31DmC?=
 =?us-ascii?Q?NVYVM/nZr3sIUJCUa9t/Ry+Wv8dFhAMIdUrHnRfL0qqYXKlYQfWcLPY/6vpS?=
 =?us-ascii?Q?xOWyg6NmyoITCafr1jxA+yoWK462vTYev25uuvo+hY4ePhxn/mGH7y10lktz?=
 =?us-ascii?Q?ah1odAdnV+0oewVOBFR/xpJhaKfkXTz/2xjJ/EdBa6CXk9Y3l81S+9N5vaa3?=
 =?us-ascii?Q?OPjfJlEzfSgDA+97o53gPjjVoeq9CZ1ycqZu8UO3sMMHvUl1EM+HomAB0BLk?=
 =?us-ascii?Q?YkM30DqQhisdw/3ONvorAni0tw8Fei2RwvAj6X7VcoJ40i/E8Q0tAeTG7ZXV?=
 =?us-ascii?Q?DvF5hS4t1vnrjThXyd+ZwcwUvNWiLfSmkP7vLjiX+LVYcrVeyBuulPaYO4xv?=
 =?us-ascii?Q?fJNmetGQ5X0/4t83sFDFPJCIirvT5bPG02tqYwwrgxbRs98pq+swGQRwIV5K?=
 =?us-ascii?Q?1Du+r2c8hOMfIa5lbPzo1atZtS9uPDCeoxnhvuiyolDucrBeP/JUGTRWYMkp?=
 =?us-ascii?Q?O7j6A3fMMVddYCfVyqrTMZmtrycjTDUXq3Vpgt17hXKw/xaf/qgirZIMhdaA?=
 =?us-ascii?Q?Pxn+spkds0bLtGbXZs8wtZ0YDeCWgkcvM5uREe3q4CL/Xl6zN1+AFTAkzG3/?=
 =?us-ascii?Q?fcME3Cd6ZL1aIAXeUDHfdiPQZUV7de52cSXGnH2Hd1e1npHnuLIX3Qg7BH6f?=
 =?us-ascii?Q?EKbZm3ygvr4nlsMVc6uStXFPbu5Rzh8MQjH2cKj8yE/+BXbjEsgCjD5bdydv?=
 =?us-ascii?Q?x1tqW6psNo584h/D3YyYwYzPuGkYiT5dnAnbQEt7RuaXfEvN43UaHJyRLYtC?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3cdcae-c6fd-4ad7-e067-08dad0f004e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:24:12.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwnzEsfMO6G4qbg6Cng8DGF4VM/3mWBSiGGIe5BNDdQg1WseFL4TlkpOxdkEOsoTg6zXutSsnh2h+kqgy6wXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

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

