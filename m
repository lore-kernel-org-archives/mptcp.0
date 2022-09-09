Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B07E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 09:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRtzNiJ7RQOz1iedfTiFAz1NS1WvKK/HTCeQCSWK/6V6bjGtcuAe2IpqshGD07mfGQljMD+sQ4rCeADbq1Q/NBnP1xXlyfQeY1NXx2hI2gcmkgCz59N6uoL0TGHgViLuTC21vAAeOnFw2qqcCrL9Ru7+VBWEAnT12aqGhNeQ8lWdVouLFjFUuQsdPl52xYOxL7/FtjeYubkU6wEZ0swZ55mF9IHXpoWDzlyBZemQyoLj+CYAGdiUlISmcnU7jHcGLzjEe0ricabXf/mboF96i1MPJ01u0zr6V6zmYNjC4ZAekBux6ebr/vjcVaAhxSDXTkQXtQ/dGbiO2g/smnVV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=AZ3kY3KMM8ifkR8044Kmot6N0uuIkbdvG1BHr3EUuHGg/7cUPD3A/DOS1R50XpXhrdZQ7yL01BnqDxhLRPEI6iaB2BP+Xbl6QMKvnYfEojRq2+jOuKsyC97g0jVte6zINzD64dvwq2P2VmbmBt/E0ZVa6tRCk980mcy059WshkOB6VfvLhwtB/Xdaq3lF4q/BnF/SJNfdEE8ftGMSor2x881xGDIOvsyzQwjF4XwJAQUq4v1UDlKNde4jmD78iOfqi2TBGEVvycV+zOIkIQBpaL5B/b3fV249g0cKsdc1NUYj6uJPbOj7XsUgxAJhTnV6wJnTwDM6wRXSBzkOYEV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=yk/S7afqTmAePJxabtQBeCJPNvB7cVI3fnuB7AGXOARPxyb2xn+ll8qJEa8gvRR/31nqrtrUN2jbtyMfdAZzrM5LF3+YvBWBXfCnHatCWzgVcGKyEUS5hRVh3enewCacr8NUbzAMF1a3i/DBpFdAI3RVO7X/Cc1lg5OeMCEZMXFFITdn+MZMDicgB2pexucxPts5usEM9giivi9bqdm8Nf4vmUIAmiYsWMOq4Y6Aaaphu6Wz7+emc2yeu/+EG+bQsWwpXvS2BG4Qud2ShH9buxmvKs6cQmyyvPdv0YoDZkdIhm2taxb19AmKvjsML077KksnLSFF9PuEil4pFnOSnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7542.eurprd04.prod.outlook.com (2603:10a6:20b:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 09:11:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:11:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 4/5] selftests/bpf: Add bpf_red scheduler
Date: Fri,  9 Sep 2022 17:11:35 +0800
Message-Id: <b6aea6264995012bae2da58b41d656462074c59f.1662714028.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1662714028.git.geliang.tang@suse.com>
References: <cover.1662714028.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a621048a-3215-49bb-50fc-08da92434fdf
X-MS-TrafficTypeDiagnostic: AS8PR04MB7542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxj1qtaL21+wf6dWyUwmiqKNofEzK3VjBoSzeJTlqmNf6QjAZBZ/yZQ5gR0X+DLe0shordGG+/YKrO9lnkMxoG1uCUNiy0KNuLxGUio1jtXmsT4IroXQU7AV4zIyASg18XomjDlfXkiFSy9PhvUnQbYMnPs6GGc4E26smx1uQeh04ruqhoLmfgttCOFWbII9M9/KnL0mnjCYCvsiZens/9fTooiyvh2+ndK7OShAGc3MQKSdbo8J6UE68SI41ZAkPPTgvD54yxAmk4wyTs5BFtiEkr4qMrYCISrC+cU/r9sMt6XpIRyLTJzioERPDgoNrbBUbRkIIsz0gtvL28EVQJpSjTnCK/wcZshm8AFFOBL6JZPECjEZg4HOwP1wM60RsbwzVd1jrjdXCRrq+poQ9xOh2yHNmdwxiO16Gv60/TlSMbBgDcGAbB1IjMrP+TFoyUz4OZJ9BtY1glP8pxak7u0RsE5iN8RomfnZowXoCMCVIyQz2Pg4BVjmCmfEqZSUWO+hx/Nj67/6sO68X+hDbf7HyxbWd2/uBpzYHrA3MUQLSDPPzURKnJbTRQmzBNC/r5OKp5lvyTp26GVhh/v14g0tQFF2IKsz/cYMUizegJ2Zgvtp4fQrYyrIcqaMLLbhOQGE8izRL0J+S+8gdGVVXkuEWqfTzPeRS5UQFf8nmBWPddbocPedjq7zU2LrMpusy+lNXYlNPj6z1xOVpN10OEKp79oEwClfZban147swp8g6dfQcJbx3PI1Roejpwnj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(396003)(376002)(136003)(86362001)(38100700002)(4326008)(66946007)(8676002)(66476007)(66556008)(36756003)(478600001)(6512007)(26005)(2616005)(6506007)(107886003)(6486002)(6666004)(316002)(8936002)(6916009)(41300700001)(186003)(44832011)(5660300002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NMpCy+/x+htxuAhdQZN/lj+HKxIAOFdnYhvJvEuP5yInOXYM8sbqNn888Wi?=
 =?us-ascii?Q?HcpSL9yJ3Xc+VxfeZrpKI2DIzzC0Rrz2FkpwWcv/yvgqlg2GDJ3vmA43KLJC?=
 =?us-ascii?Q?PKsmnWDcV4hWPcyiMxUfbvOENsFc8dFjlAa1ynh1UBCs1H+Z8plW7FUe86L3?=
 =?us-ascii?Q?tSUHNZalrIMN9q1MHrEHY+XlFn2ZVgtiTqNb4PtNFD72ZAg1s8bQrvZ8W0ba?=
 =?us-ascii?Q?hroUtkZM72U/l5VcbOVFSEf0e0YKYMfUBfM7n6tI7v1qYsv2XcvbkgtobTj3?=
 =?us-ascii?Q?FMemCv8Y82EahbkewJoZusV8OAmOWxclE0ThL1bBiuj75lRqPGO2TONgahvh?=
 =?us-ascii?Q?1N99EEJ9sfe3lkNFB4YOF3YNQVLDHKFUfU79fk7XUx7hpk0V3FE6mfkcT8z+?=
 =?us-ascii?Q?PHhZh0ZDijvknKMc0RNAzv2OsRHKN+p0l9784g4RKhXu1/n9ijoxiPZ5v2v4?=
 =?us-ascii?Q?a20cq6pPYtJMPjF/F7ZuajrA3bCZG0bS/uTxmh3PDvSbKc/hBqvr3t2EiSNL?=
 =?us-ascii?Q?uSxYmdei4XK27rniVx4zWPu9APE3axmyUXfYkjXy+LcUx+WrXlvtGZUVvcop?=
 =?us-ascii?Q?P0kf10bwZom1kUE/FoH6/jI4EpGX5ESxoAJF/w+Q7eOj/3yuMhB5S2jubPH8?=
 =?us-ascii?Q?YQscfZZcBvnjzk4KlUjA5QV21clHr/4of+pSw1fCU7KaMlqGju1NHnvQdII7?=
 =?us-ascii?Q?lE5F6L9Cdt2yKql7OmGVs1/SHezjPo2clEUo1HXiRTgKiJcf6WxyfL/rReWh?=
 =?us-ascii?Q?TDyTt4sd+gu+xEZ1BAZrT+xWRmzBy7u7imNJyETgWaXlu4J04SHuKFHoynep?=
 =?us-ascii?Q?SxejVdXygRENqOTfQgdPshcYdHtDyJJtZbx1vgtNR23RtyI3jqJyz+V8YYk5?=
 =?us-ascii?Q?f506LWbcdk4fMDXA0klttF4F9FUbcTKJDAmOdBglZZ6TiFfE5TxO8CopFEW8?=
 =?us-ascii?Q?LYOx5xCVf1G+UiruRgsOturD1GdZbW+o0/VMDiw3Pf/C4AuddGOj8/xWUE6N?=
 =?us-ascii?Q?+88G2lHq64XPtP5/I16aYgWk9AdZLrmT77THzFnDEDbIBXIdaL+DzI2xSIgt?=
 =?us-ascii?Q?6jF5a0NPRTymW7vDMwgoYNmpjKcqtZv9k2XISjD/PVKpEk5vlccp6UmK9Hq5?=
 =?us-ascii?Q?JD4qLF8LTlO6a05r4ycGdsTLYAZ3tbbCJvokde2zo2K4h1kr3s2H38WB9grT?=
 =?us-ascii?Q?u/WDQSD1a6+xJgbrKm8ppZeeNT0Kmfy3g2UiQDm1q8/8wqOXCjn6vjFFrJN5?=
 =?us-ascii?Q?GPYz7YKZB68r0v0Uq6e/OwGLrT06u3z6NLFjk+uMiEZRZXcHM02cCKAOqDn2?=
 =?us-ascii?Q?fEPvC8XM//+sFavb14PmJKqhFBJIUz6JPA5tdM9cmMhlV5phP5E3m8EvQUez?=
 =?us-ascii?Q?UOxHlzpYxVjMN5aTTpS2BnnvX6f2Xrxjpx3RHruOcatK/vpwARyiN+VIPh/E?=
 =?us-ascii?Q?z5FzjFiUpr3IqogKhNuAhFSmDITRpg96cMqzEjNU/giYazMK1W2lXeF11G6y?=
 =?us-ascii?Q?qom5MLBHop0qZxzAfPT2+ZEA2hFFsXVDr8YZLJUmvvXFOHu8ITUMuQmwhNyz?=
 =?us-ascii?Q?Thl2glCbe0G1j5IYUGoqBIPpVml0/5SDGPZpJyCg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a621048a-3215-49bb-50fc-08da92434fdf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:11:42.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zblmymFchyHbgH+r31+ZH+kH/l5CgoL46y2lDefkydF2bd63phpe0DAMVkTQ4klzuXaY988zXQBa7dlLtNg5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7542

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

