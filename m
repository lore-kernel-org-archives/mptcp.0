Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA14F9D
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4Mkz8rBPOUd3Ybwuf6ZHx18fRRlIYCLcR0wBl8C92tCJYivKIuYd5XESJuFhgtq3OPHQcOHSCDHcsQJIjHbBf6Fj6qJRViKQsddfdR7g6k/2hYZlo5T2MGPAc5e9ZMTU7CtpViSAba2zcChyaES+WFMewY89hrgjAvuhHU06MBiQNtaYOZMtuwvRZ+d3ulZKZaUg/NytXYulPxNy6hN0KO/XHjkA5AsHbmvZbo0FYeNB1XMEzdhqAMo2bIGVyAkNKVEkjLnpbHWEwARXynj88Zxz3f2XB6M+ln+jckgw1MpNmA0XxIuKcj1Q00KnTQ+YBOJiyP9oC8d++RoTizhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dscdA8++WzgKceut7UPkkJ5X4Ol4J0klTQlcpZosQQE=;
 b=ns1Lf0/MJeOt5CK7/czJFP6M7eYxvwUGRa7ag1U3zDHNKFfhIfJ3lf+Knnb8c+lDM6du2gmp3hPxP7qh80FiNLB7/58XtNljELiMzPwePIOa2ImfB8G8yh1l8H84uaI8sROvugTIKA522yq/BjHFVb0j5kKjiJhzpzEW8pYErNvxQoewKxDKaQuIqv8qONlmNGPhLxDUlK8PcqjEAYy8CwGGyPBQCqkyv6oObJ2xHZCiptwCwX8U/0+r2hqtqr1RaBi1gvxAle+C9XaNCYL3XjnqKOD/BP5YpBMTY6TDn68BU9/1m4JtHqFUz293evvlEV/pXCAZARpL0z5HBDzVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dscdA8++WzgKceut7UPkkJ5X4Ol4J0klTQlcpZosQQE=;
 b=t7sjbW8e07mwqtDuV1BhukX8ssGDJkIcuGwniT9FAv/EQQl/xuhYKLkWgFYi4AoXgSS4Ha6uFWlJo3wT1Ny2hMikkMAweMvdDvGNo1XNOp/IaAGQXnLuY5j+arTch5CZA+ABP7Z8I6U8UxcJ/YDYQypLSqL2lf631lIsnhG/jDGBJrTGBZ1wGFnaq6NMDQUGTPBXmlLZ7J8VH+UCi5czC1zkOIFExsY7rMu27VQZg6FSLFtboGc5PLS+kgeO2E6/RChfEBZLV59EwZT+Ey23q60uMoEAZ7PamRRJ3o2Eq1endLFgY0VEkw7+EOEkRBSiYy1tZwPnf7zcz95MnHX6Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 07:58:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/5] selftests/bpf: Add bpf_stale test
Date: Fri, 18 Aug 2023 15:58:33 +0800
Message-Id: <4e1f03cb05d07fb06fc42986a9731dbf0aaa5ca9.1692344463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692344463.git.geliang.tang@suse.com>
References: <cover.1692344463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: c18068b8-f6ef-4175-5e07-08db9fc0f5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h/d0yl9DBcyZHEPTjmUIfw+xdg26Fz+ij8Ld+olx6G9MvrwfcPkZvZ29RM1iI5s5GjpYO+lGzBgPuwwGFjw3/sH6wYv5PykxxioeZlv3vH51Nv0xWhNk/yRPKBWp1sPcDJSFnM84wfmuOCW7DqBjZEKXqKLiwVVxEVw9HvA0XvTYqX4vS8tKGZlZfiVlsulBwB+1NhJE9qy2lQ3ffkyapIgmDfA0JYvnN9c5r0pc2DLZ4lcXiEMtyYONzdpfhJ99YsfibEJSFkJHScuIW0a0E8uKUQTPeBXoJNfq5dQz3cUuq1jKZhuMPNGSfp8vjzRrokMGYkl92wD53gEGIRMgbNVteGUCz4MhTerGuK2ki6KWuE9/1YxlRjVhn0tmQoTFd8RRmg9HTYaiJ8mxy4IGq/QNXIU+lU67/PY6I1RqB13VK2ZSIKSnX/egLoVyTmJ8N7SkW72wKiiJjxHHfsyRufjNivntacfyTfAyTON8sr0x3rDVNQQSrzjxrH7EApw8Et2WZ/3pNAOVf+k9EQtJ99+qNxeBqki96cIyqzkdw2LNpZ/s7/3P5j4uXltC+QhixS/XKE6UcSLIfmsdXoYGhJVWMjYIrhgT7eLKeAentgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8vC5C/4gS/5iULHhO8NvXlae0XlDUPvfZQQPtYvrcTtVPAANubJiLKgpwzS?=
 =?us-ascii?Q?+YeQZklc8tegckwLWRYol2nC8x9NWeN1y68FTbEDNTwMcjmdLzB6sGXNBqhX?=
 =?us-ascii?Q?2tyEWFDW6tV/8C77OBJHfjPD8KHv3yAW38KrWmuh6s6HrmcXZbN9PqL/4ylD?=
 =?us-ascii?Q?do0vDVXaCYqll2Oq64qGnn1u1WWbZBLFW1E0ZJv6Y0Pb3SEdUNLE+8N79ESh?=
 =?us-ascii?Q?1tmiNgNDT1kkOVvXJMyc1TJG4T9zEDkMFmpwPL+xvI/QOr6nl4qFv6GdftOo?=
 =?us-ascii?Q?Jm3LVKEyFfUd3tmBTlZDKksySTpSIZFuRxjUDjRRlWIY5mEMGXtbkGs6sBWi?=
 =?us-ascii?Q?Uz0egC5okgHG4r31cFVyuAkbsyMQJEnmUEhnbmIZD9E74GqG+C563pRm+yDD?=
 =?us-ascii?Q?XgtsyAPprf+PhGciYO3KDKRZ+pWGf+yLqETy0krW6K1KaNgbiooeWp2STiuT?=
 =?us-ascii?Q?NTkrbkpibVkrqt4STpQ6UG9N/7MlECEviVUDO5mZg2aplYNmXtkHdw1d9nN2?=
 =?us-ascii?Q?rRQwdbEiq2CxcZuA8N3qpJsqYOK/Jh+Q22NcsfAEwivF6HGrmYP58v8a1WVk?=
 =?us-ascii?Q?LPgEW2RKeez6gk0nEMOtz07h1IrDUnNqOzBywlJ5e9HpjIeRUxj/pRS7AcR1?=
 =?us-ascii?Q?ZyJE23NSUp5RjPsofcNMCCT58s30B5RBAUuFKBoHPaFd+leJ06kc14XYs9Wi?=
 =?us-ascii?Q?1if8mezAAi4M/c+4U1CgIc4lSgG3uesSU/kljKXtXrzXfTYJA9Q2T5lMDMqu?=
 =?us-ascii?Q?tWbDdl4VCD2oKGMSVVxia1gzYAoiONiYZDhI4IoMVaAzfG+xWGV39UIZvXR8?=
 =?us-ascii?Q?NeH+4QjErCUUm+kXersOsAIeRietdhugtwyXkzzdSkC2zxpkwSkPZHVsvpQu?=
 =?us-ascii?Q?bplw1d7MXjfjLUxBimd13aprRWVmfjlCvVvRhaW0rt48eKCEqZaaPl0VuRBR?=
 =?us-ascii?Q?x0iML+bxXoUSLFWjHolIB5A9rooeWP9vXQ9QiEo82HJv2YLxHKetITNP2INL?=
 =?us-ascii?Q?1h3XjT9HEeMLqNinLUTpigkHdmACMtJsiD93TPA6MmWjz5RoFtxQ14v4p4SV?=
 =?us-ascii?Q?fz7M58o0gicgGW/MBs7HJeT3aOvIOiunudK9HTM2FOPXOLi+oeBJI+e/JMDY?=
 =?us-ascii?Q?NPbiI4TTwTmt33+HGoGGjz0MQ/Xbz+PIW2IcI62++SceXB7BnSYO67lLXB9p?=
 =?us-ascii?Q?H9/ZzOZec4WZTH2KgHMbT8ELdvlPaA+CXmzb4SFaZNn3chiHVKhAHiR3ktiZ?=
 =?us-ascii?Q?RZvDRAn2GpoK1V1+jcLh5go0LxgNC8l0y7nZFw+Yb3cPMRXjQQocnL0q0NYL?=
 =?us-ascii?Q?AgrCLBuoRV093BxTIcC1uJN0CCHwpy6tkaqpIQZQqnhXg2oWYU1HSV8ElGu0?=
 =?us-ascii?Q?S9GS0Xestv8UYXZxz+Ib2ddNFmZ9lb1htXwFEfyNNIrEAqmUNDq3+9lAmIu9?=
 =?us-ascii?Q?fptNy3CbA+SRG0DqcDnQKaREMtRN3Ci0j4Yt2l2wss7J6P0W7XpBrpyQlV89?=
 =?us-ascii?Q?Nl5mu51LIuwsq6LrYdQkOKmEpnQBFVy7ryiCSo7HL4m4WmohDbIWbTWfbr8z?=
 =?us-ascii?Q?mg9ZW3pW3a6KBZPIIjrvkujYHhhE2XwLvzIB71l1KaIMywIeMyovS6+7OMBA?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18068b8-f6ef-4175-5e07-08db9fc0f5b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:58:50.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcLiaxlZmri2gwdcZlVubMmW3OHYbWHl6BQaED0TE3ZkQEB5CLGMxOS/YUGtxiEB+JMa5/HJdQEBjew32UbOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

This patch adds the bpf_stale scheduler test: test_stale(). Use sysctl to
set net.mptcp.scheduler to use this sched. Add two veth net devices to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
of 'ss' output after it to make sure the data has been only sent on ADDR_1
since ADDR_2 is set as stale.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3879eaa4fb32..08a6c4c5184a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -15,6 +15,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 #define NS_TEST "mptcp_ns"
 
@@ -651,6 +652,41 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(burst_skel);
 }
 
+static void test_stale(void)
+{
+	struct mptcp_bpf_stale *stale_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	stale_skel = mptcp_bpf_stale__open_and_load();
+	if (!ASSERT_OK_PTR(stale_skel, "bpf_stale__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(stale_skel->maps.stale);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_stale__destroy(stale_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_stale");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_stale"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_stale");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_stale__destroy(stale_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -669,4 +705,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

