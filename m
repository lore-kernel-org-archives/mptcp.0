Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F61A23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0AWi4yV0HGkJ/IeZrJSetZKiUQV/LC9pd6eqQP/DNFkbCtYhkJF0zXzEKEfhWTjMF4tkn/m0vXD3V+cy0w1SrPb/dpghqwouA/HTUyfbz8e2Oz41m8/prY3a+uyU442akzi9AYviYAX1wQq7E3x+WjqTsCO/Bg9ABWzt4fDkx/wmz9pBPiEybblfKuB3xiliyyiI8iYX0my/DaQr1vYbejxSa6mOdFf3B3N4jlWy1/WRRwp7vwulnHA+nrNIBt4Yfai339n/qIgXBHJkGt1xsVwfL6Ju8aTyci6UPOXLX2s0G6bJXYjiQ5LRfsi41DjYfflJpHhR0WBKCnMj6zMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTJjLj0ndVUhUgxPC+v/MhQqFsbi/Wicx0j1tCmgMrk=;
 b=nMj5xAYvnv6Q3vWIywWrzJuLQc69WMMByvHpwBf8qJvhD9/boK1ASyRBGeyHb5FeEa3fhGIJXo4rLJzydlXMtv1M4gGcEJG0bFjIfawwuPpt3DlKtlK/Akx7+ExiV8GdgHBYn5xiyPWRYRDlFGY9r935Ej1wQBI6e96BFdW/5uO40E3q2N3KKQYUiGt9ADgAAUld4aqX9zmWFHy+sgyj9KPocBV57OQrg3jw6syYaYOWzBUveLVQs6rwrD8Zez9UwMpVvDWs0DCC7zHtrQ6winLN7fQxoFbWsN4qX0SkBnp46tHI7PUNXHkjL0SV3q71qz/X4jlV97D7OipFuguBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTJjLj0ndVUhUgxPC+v/MhQqFsbi/Wicx0j1tCmgMrk=;
 b=lk9Cbw+ci6CdFlyKWvp/z2MnofIn02wHG/LDgHVi421NP+3Mc9p657gN7e4FQ9R/QrPkAlgWGzts4k4wYqW18QJ54nE/2pNfvcw/jD9ugWYf7eQhr6mnTqFrzKLdYCML/OIZ21ic8z79VMSVnmfieJEhvRrD/iR3nxio4zFankYpYEu2Y7FGf8gGKYtzVesHnkxeNS0XZgve0kRiEJnzFBQbpc04IGsQp6c9GdQeTEbGOX5jCCLgYXzQT68eQTVQ1Ew+Z6Y0aJd4tlt7Qp3o0cJR2vH4C1B81HBXxHsKUhwKTP/0HpjjxPvcLwyKbPWuha6ecYPzWldq4TGR0d4VKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/10] selftests/bpf: Add bpf_stale scheduler
Date: Tue, 27 Jun 2023 09:39:27 +0800
Message-Id: <e6aff4b48202fb575062d13a5a6efe6c1da5bfc3.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: ad092d61-5d72-4ad6-21e8-08db76af7f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gdpSW2uTcoV+UDE1XhRQGIehDuEYkikjhNYORjdC+uh7f2xNxwHTjfS3SES1zesRW7s8jSITHeQZSd0efZOHFXRwhDAVwcY9Jm6ouXngoRLMKaD5DnLcBpecXWdPkJZ6pWAXDlr8TfkTKKkFM57aQT+xWbitSOLTQOI8wp3jqIs6yIaOBB56MMvoKSCnYGexiBUcuRRtlXdqERan87azjOEOgBpuGIWXbiRtkvYUVqmFN7NYv+NTdBUL3Ibko3H6Rmn7wVnw8K9FUYaZtcj8/1tqOszqQFIWfIrGVTRZsznc+Gcqo+Na0umlXgxUpaMuAvjeoaKh1MEyW/N+3tSEdujER3nb7Baz562P1sb5eAjjzk6olQ4GNQqUX6ezcAUgEQ7SDGv573a8ylyInVd7B+rlQ8BqEmBLT10IxwSd+Fd++U92nVZOUwWCKkdYe9pFxhI5M32ftN+rSvAcFCR9SP2dBrdfrzAFu1wL7yIy9pIKmGoulLCaAgup9VghGBLCfFAnpss5QSgU3m8Logt6ekmk/wOtPGxa8U87a5FBn8ncLQ4Jun8fS1Gjgod9OIg4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h3BWbWnUX/MMmlkBx0Eccv7H+pa/+mHoRh9X0b90XrHUS0LJX5hcf+lXN4nH?=
 =?us-ascii?Q?BMeOzuJZoTqGWcwREzON2/TLf1PdavgrMxloUlATSqdNlARjDg4ILsiwrruv?=
 =?us-ascii?Q?Ndy9SaJ/8Pgv4dQtPj+kuCpv3nbdnXEkWRnxIBD52dg9n2XiRRC/xscM9Ngb?=
 =?us-ascii?Q?oskW/KkBEzvJIomIUGL4QdA9+CKED4dRtEusEcS+kwwu2jEMmi8zFEhSYbwa?=
 =?us-ascii?Q?NllVwA/wiQQ6XimbsRK0MdPaUAiw8rGUYzOkSYRz5ZagAFZ+pt7NEigdsW6a?=
 =?us-ascii?Q?yIYW5ITE4vGNzTQqY0g0DJHmkkAPYmW9SJXSUaG8vGCPH+66P2BqsLL0c5Jt?=
 =?us-ascii?Q?6WATJxkiokA1jXZip5zRnrNJgIqob13scn7QYFy51t573UFSow1MEKlQ3BfG?=
 =?us-ascii?Q?QHY07dkgbis/b85033st8ubCUwCVBXGBm/i6Z4lrvAJ1WrIr0HCE+p5FlfBo?=
 =?us-ascii?Q?X4psHWLbvZyhRTjzlodGD5U23NuOpsYHc4ZjiC2Ves+4cpy3IpqjPx5iRi13?=
 =?us-ascii?Q?ckLMOqDQeijCPk4kmXC7N6maGm/nLtDkifrI7woF3Y6hmtuN1XD5mWKdHC8C?=
 =?us-ascii?Q?Z860iKYVnBjcyIpb7gvqqO0lzLDqb80uuUfm/cA1l8/xpgDMEYay7CJS9HSy?=
 =?us-ascii?Q?+lQL/9AfpFowEaYb4fFmXT4wzsjg4if6t5joWMPfLFKdoFFQiWmWDd8/1RFj?=
 =?us-ascii?Q?fpEGNEvyC67FSdJv9MoIucKLaNo/Psz1bR2dZtuk1SKFqC6NkR6XgppZpL4w?=
 =?us-ascii?Q?z27+1AzXa9Ar3NUwHUlBM4+LFQnUe8Lv+JcJc4AROu7bQzmhFiaiVSGz3d4h?=
 =?us-ascii?Q?8Kgga6IZRL6dNzS3RuG1JHpjI34AZOzkEwXLA4SZT4D99js5tulCTJZPxvxS?=
 =?us-ascii?Q?qT8H7u4JUPecwaQI6FKhjV0087NkPL3Zn9GZ1qBD9l3CUR+NjZZiZ5EnafQU?=
 =?us-ascii?Q?qTlS61c7I86YsCF9QossLpV3c1XD5/P5otd8Rr9dwp1GyzEyGxsVLCStvyY1?=
 =?us-ascii?Q?4uFeudCwOYKvirCe8K+iZ0AIh66QxLO67iglbBLXmKWW9jLbI8Oj3LRAo7Eh?=
 =?us-ascii?Q?5SelicxCOFzsIGCPYKwZJj8S75cVa/Y4lVVGCGU0623YC1NZNiVGvrUv8VnF?=
 =?us-ascii?Q?CYLilx8+Dq7wKgO46SlNCnC5GHPFEaSfGOb4D1atzdpwOwgWQQXXagyah2h2?=
 =?us-ascii?Q?fJsGfbdlIrXLexIBprUGwyzTdx3Pw7FW8DVnegtUsT1rGpNVEb7R5E8r016/?=
 =?us-ascii?Q?i9kp2zV9MyNb1WAzOOQ/ZZHXrcLPHzkCucrOQAaxI345tTN2+4MK/hsj4pCf?=
 =?us-ascii?Q?N+sXLsdGMm9XWLkgCV8P6U1BbwI6P6PXatMI4nTU9IfPYyVZYmuKp5wxX/Yq?=
 =?us-ascii?Q?pSlP9h9NjSu1NisPKsPhUw9gbZTDpl4cmgvZUc+Reo5ed94bn4RUTw4FdHJz?=
 =?us-ascii?Q?To64A03kJyCTujTnb3Mu7cT6XoYCamCESF0cAXo5ET4uv4Xru+HmdS3NSw4g?=
 =?us-ascii?Q?xUaLYWqRj7bQD5W7AzivsNtVKbavllEwlInc0ilFUJDWzUQJuetEELd4o/gD?=
 =?us-ascii?Q?lUJyH+AbGVkIdhKhz1vPu2HttqRxgedf6Ws6mWSp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad092d61-5d72-4ad6-21e8-08db76af7f25
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:33.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsTWGbffQKl/It9PHHzYbBZnMyGz8UQON4V+buOH3t3nVZtBRy3XT3Dux3QcJmlld7H2TuD1SmBkWaJxrAHOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 65 +++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 945dd46c98c0..c749940c9103 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,7 +234,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_subflow_context {
-	__u32	backup : 1;
+	__u32	backup : 1,
+		stale : 1;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..8ef0c71a6b37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+static void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+				    int stale)
+{
+	subflow->stale = stale;
+}
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_sched_data_set_contexts(msk, data);
+	subflow = mptcp_subflow_ctx_by_pos(data, 1);
+	if (subflow)
+		mptcp_subflow_set_stale(subflow, 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
+{
+	int nr = 0;
+
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, stale))
+			break;
+
+		nr = i;
+	}
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops stale = {
+	.init		= (void *)mptcp_sched_stale_init,
+	.release	= (void *)mptcp_sched_stale_release,
+	.data_init	= (void *)bpf_stale_data_init,
+	.get_subflow	= (void *)bpf_stale_get_subflow,
+	.name		= "bpf_stale",
+};
-- 
2.35.3

