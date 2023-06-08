Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CE628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfmXl7HtdMGyE/6IxON2haDIOehoAuW5RAAkPtIUB5jm4gdUZGlHWM2XZTPzh/zI9JOw+cDUzYbNf3gy2M2AIJNoP2mEZiewVFUWu1H+5b/O203JdjctS0a/lADFAc+xhNSUtZouhX1QquJbTtVguh0Qo9obXX4NOSzTc/qRK9Sherk7jwHm8EfQTecLMizFBZ6ihbjq0AM7a614D8eVNiSEhD+Ic6SYUfqbE8Y8yUEXV37CLweTBZJOsPnFrsbH7QJE5t1uhG7ctU//k+eMwni1SkQbgB9/VCsaSZYLFj0EYE4m+5U/2753nK0O1SeDDBqbJlZzzjewt2qrc9RFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=Nlu1sLW75QtmVHg2pMI035jHg74SkuqylrYatb9BFPe1WmLFQhOLeoA+eLz+uuq1y49qamjP4CB4lgek2MbcpuC91BvXIJhi9ZtGz74OI5RtKutDLc/Rz3XHXaKU5rIZc/yj/EELXLPPsqgMMAnGMZSwGpZvATPBP325fBFNU9gwvOibkA0HgOVtqw/smzQx873kZQwlnPOzBASxmvgMMoqNAyjfd0LKQkHhWHM6YlQS42Gspkgu1B3mTxaRIN+Yz6oLskxTRBqOVB+G4/dASi65vxnMM523Ry5KICiqhyaSxmmoyBLgmNdm70jmyzwL2UgnAvG9NPMV4Sd50yxmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=pfPn5Gx3fjO6G0r8WB0Vih3kNWd2lM9CLAAU0LCITg8V6UxEyzDSnBmuvcgTb7rkgPBQ6JQtRpVI3Lto4TTXoVOAebuatlDJgvpAMREKeHkpIzQsF+Y11y2aEoGNN9vlfLAQ2yO51Gf66aMaowXxd50z3tTWBKsP0TL022uqgHdiJytx+50exA2gBJJBLiJtCAMltNyb8t0l4XOpouGoOkeaxOXQMCxtitNdkTO6tkhm2/AyxpPzTRVP1NS6bkwFsz61orkYeJ3qoOMV2jx8uUHR3PXoNuYnqgUGMxWmvRRJ6qZttuRmhPF9yjyQXxZ7tHazK7FqXA816anWFCS+xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 14/17] selftests/bpf: Add bpf_burst test
Date: Thu,  8 Jun 2023 13:46:52 +0800
Message-Id: <b3667753c51342007fe683f8cd959cb8595f25cd.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 2900c36c-f5e7-4d15-150c-08db67e41d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1B1+OHPpEe5j0ytVSZ5OlBwIXjmUuvtj4z83/NERCoJvwndD+lVvB+u7ae1s1/wrnA7vtkh8hZ//gOtfBsbVSS//0q0EqI9T6Ff4oachJdczz+zi4dv3N99LCceZTWj/Et1vZm5UTb4JEW4fJgyxRP9/6Bxv4BwYwaZ0YaZTkkKkmy6/OMpT5taMjieiLIDqktwD3RsaRyv6/sqBms4DuOt3Zwx7eyg/C6cWP1RjdEsXAmpN+UdPsEhCtIpfkYMWybuz9ZngsoKlHPMRs7Io98vSD8y99+Jv9ooBYZKr9w9wgS2moaSkaADsvAXneLPS26V8RA0tuA16LeMyxJgLKyokX13Tn10vew9UXc0ig12aVum+0U9bM/lVuMlWgnKPDp8f1RHd6y3FzC9bc9XuguppSHGQwUHjcO1GV4KkgmlhoG36aspzihCwPN7/XBesbDzT8JEI9tY8LfKDqqegI2suA9zQCidrZ766lDjgK/UgPK/9u5QXzxSD6jToZbyREHCiJh4aDVeDXfNehb+BG/4DM831qfDpuJF5+0sVAgYuvHCaBLyY/DeN4S4Al6jU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PynX74dnoWxHZ7VfyLXzXQDesLLGyrBTvoaLvemCHk7bhvCRTDBwQY54ibM?=
 =?us-ascii?Q?0KQvDZzDJ1Ft1F/nqPe9i53qejKzWMLJbwf8EEFbujr3uOr6XdVcYbO+xMDm?=
 =?us-ascii?Q?KbAnrThNTIi1bUNNuMyzXzu+N6QBAgYRxfpvEcqELRWe5/pRw+X1US0du+PU?=
 =?us-ascii?Q?LqIo+OyydgOxsTWNdaKw7jq5Oa4r9BzsySrZJCfzaI5l60A3o+YX6xxYMspl?=
 =?us-ascii?Q?+4cGfa75UGsZGHm0m95xNOAF49vYQyiH0H5rMae2vCXcQASmqCCDfr/bVuP9?=
 =?us-ascii?Q?iUuFZEFQ0ovTazBP1axD0QLLv/URGcGmDZ3Rnwi2sYm7dZ101av+qafG8WAV?=
 =?us-ascii?Q?yqD35bV9arYMIeUXTzFqHF8KI/ikN6UZc2TrXGfxs/QdQX3CTECUvmM6ecP7?=
 =?us-ascii?Q?4AOqBD2G5vRp40DkukaRviYTchvBwdppLj4o9U0OYwHfBnAeTQvQW0/B8Wcj?=
 =?us-ascii?Q?DYY0YOPQ9QE1LTbBjqymy3pCLB6mnLi9OadhoUp++AJd6BHWBAjTIafRsJqi?=
 =?us-ascii?Q?/wXR8xf3vYCGZzTkWiXgECEaAEJpEeFc/PP98yiJrW22rPu7FhC2l/Tq8Ruz?=
 =?us-ascii?Q?M8cbIvUDc0gpJEo0kaLkDWp7whNv/2XOjBL6xVP34WdVXtDQZy6mbfuJIAFk?=
 =?us-ascii?Q?htbqd4xoWQ+U8HDiEV9GM0WTNWgzNgl5N6OW9fKu4mWraHETyMKPdmDjwUKZ?=
 =?us-ascii?Q?VArYaO2nnJjH9d/mPBK7c9kESWSt/ueOicEGYlBVEyLg06ofMUPB411S+H2j?=
 =?us-ascii?Q?AYceQQC/CUZc3MspMCl0Pm2pTjriKi32v7e4tOlnUiI8Ieo8LmZO0g9b/Yqa?=
 =?us-ascii?Q?y24SRqhihpg7PncN7zRmqcohHV959hkeTmXoClUC6UOSGlV7cPUeW2doMbFM?=
 =?us-ascii?Q?c3Ke1UYrXxYtA+I/6LeIjazql/3jq+ZVrRAlUcFw3/WxtQWiokmngU+EppO4?=
 =?us-ascii?Q?Asoz2xhRplShZsO78EFIGp2nJ1WxYrHQu9szAh+BXAFzJfMe/PuI8KKB241E?=
 =?us-ascii?Q?UZ9LA2u6Kubkn+Mo0o6zve20jtj6EN+2KaBJzLbw2bxrify2uy6lWHvcqjJr?=
 =?us-ascii?Q?KxNiSwNayOwf5EKXf73+Nknm9GCJfe7d3QxuTv+oWheab0/fvx1HKNOhSyqJ?=
 =?us-ascii?Q?snTYMuMworkG3Wu+1XTOXLroaiOIR8OTc3XJSlWpk+/oHd9g+BloTMDKpJVj?=
 =?us-ascii?Q?m0EhR+qObNdrLXnD9pRk2sYhwIQV5xeR53f6cuNQAnvKaw9coxium82RbHo+?=
 =?us-ascii?Q?xr7L1ED1yRQYA9FpAdxiPb3P2sZolSxrSL4k2tDaiRhvnIJRy/PQC0ZuAgU5?=
 =?us-ascii?Q?5jYAAn1XXC+wktQ2ZsY0lYvKNDxmm2JRY/J9Z+bj6SFMg/ZtpCse5WbhKnFp?=
 =?us-ascii?Q?jMTEAADDy0yNpdv232DRU4I9njZJTCd4G2M0Nlgj2Qt/pSrmEBQW6GEBVCIv?=
 =?us-ascii?Q?ti0+Lz/XuSUx/NO8wOP68DWfgeX4MHJBh1utf3kbwgXmXOLodVL9BT7Ms8L/?=
 =?us-ascii?Q?T+G3ApJnssgWUPhy2hpcce0Hr+yYWOua4nFu34sUwf2XZ8wDRuaaQEBRraLm?=
 =?us-ascii?Q?rOOuo9c2Wm7bDn462R3WSk+MU3FeJCRAdQH8/gmy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2900c36c-f5e7-4d15-150c-08db67e41d2e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:24.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YUhVbdgnx/U01rRpiFmKJ9l1sDtdZfOnV7hnTNfagfs2mkQkBLteKeYc6iWRLNPYxyamjnvEwrJQAsD/jhlcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been sent
on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..b9f6dcf995fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_burst.skel.h"
 
 char NS_TEST[32];
 
@@ -455,6 +456,41 @@ static void test_red(void)
 	mptcp_bpf_red__destroy(red_skel);
 }
 
+static void test_burst(void)
+{
+	struct mptcp_bpf_burst *burst_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	burst_skel = mptcp_bpf_burst__open_and_load();
+	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_burst__destroy(burst_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_burst");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_burst__destroy(burst_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -467,4 +503,6 @@ void test_mptcp(void)
 		test_rr();
 	if (test__start_subtest("red"))
 		test_red();
+	if (test__start_subtest("burst"))
+		test_burst();
 }
-- 
2.35.3

