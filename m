Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11738E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy1SXPy991b4AqU/2WL0dAhJ0YTY3v0mBLcqJPNof0/OFZhcI16EY6xtMNef+8xAjPoD+piSmtkUhnBQUr+u8Hq5V5WHxnG5E4DPRtySaklAQhv8lJEl/BwTymhuE7l1NaP57Fycc+zwgbpGIGXXBn2zLq0aavdWhHpj/6PwujgAfv2RXf6XPjIZrCZHhkI/J/hd1BHDZjkZXCdpTMEYTEY3BmzGZDjxM/8OI0HAynmmNHzXvxRdYDDHO//X9Xi58qhcniRNUVnWT8Bg5kH+CIEz9uoDweAzYMuzvbY/bNrdP2MBQCSVlYlarxqLIDfvP/Gd/DKqmcvXuA7WUWnmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgsDyY0vTYB2o0sK/fDUXM19faPWLKks0hj83Xoq6Zw=;
 b=jCXJjx6yEwkj1SEPbQ9j1syQOOIqYpoPpQx3PNZIqyJ+oq+wEmA1gVvakhKV/ZXtAr93DC511Bv7WFQmRWReBEixjF+Nd9HWKBDY23zAaT80yllrR/MrMZzTOVpmK4gMqDfagOUQik+gZMv/+kxCSJXt8svvXwlGQfMHOI4BCYtuxpesP5IT515VrCErZJoyzy88wYApW7ncvLBp3SRsDIse9MSujl8YkqUo11Ymcy6R53ZD1SsdWrcpNUcnl9Ta/0w3KZ8kSHsPxt5eAj4LVILyFnblnXveB/uzM7y6lxcSro3s9QuOPCKF7Ik32TGJmNCeflMzFQKZZxuIuvNmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgsDyY0vTYB2o0sK/fDUXM19faPWLKks0hj83Xoq6Zw=;
 b=0+wxBKb0uNdP/C4ynInaydogj71uQfiwne9gOlcF9l76R/vZCMvox5XfpAP4Z1SK4B+aa0Ty1phlUkVjeR0OKjh65xMgZ3ucfhHrnN1jAm+RPrWKxRgNrKYSkWw6tUX5iyG/QoZLM8GL0T89mlkbKnu4Xy7kl8xDqzok0ZcvZzYdYcPmoL3FFVnRla2/4hh5yPpF3YKzKU/iKzF/kXG/1qT7MYQwkz+Ibza0rX6Vku/JoJSG5cerWIQYMgoez32nukUMVvU0OWyUoLtDr9L317TiwV0A+YAwuHfuydBQKATH9iOjbtZn04eDtPehVBGAIo09XC7/uos9+E+32Btg7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:25:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:25:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 23/23] selftests/bpf: Add bpf_stale test
Date: Wed, 14 Jun 2023 10:21:10 +0800
Message-Id: <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 91eed440-0069-43e5-e950-08db6c7e9bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KASA/vDb570c7hc2LBczaSAfVukm/69PhKIBmyKrM1be4WYdPG1cD/dZ3nbcdrj4PjduqaXUF/ZCtci42cHuJ48srdrhKEp4f8W/1qGq7yispUep7M8WNizaJJM1IwhiGtWPnYERL242JcVnRDLPi1CquseAFIWlBdSPl1AWzO1Bq4r0hI2Cua/kuQTz+w8Jv6Rb/k7GNcXavTYWpzgxDwkdM4yH1xZU1oIcTZXMX1jK+XUOENMZto4r9rg1BQgHW9y9abpNjLv+CzK1DxSq+Jqz0t84P6y+n1OwUN6EyKG9kL9u3VtLv0VuXObT3JpCltPOjIx10cxiV/0GiphMUpRuh5G21G6eeQdlOSo2Ti0oT2Kg3O2ditwg/7BcxEnFmxI1PzWIwaGrJEFZPXl082ls1qkE7dc8wRPdOec8KbxxBxscBcdzSGtU3oDTe3HCbViTkHLSDtz0+7cBSEeBIggvkqQJ9iJY1xgmcGcKIY+j5tiHQrSvWs/8lhuCrVThfSbeObxgkgGlxVGMULWO2/ujZAZZrSyxphP76Fc0VKsTtFmOLO1TlRb0wGKBb/Lg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HULXZb6fgHKNY4mGchF24Mfsqa3mqdAtVx3tKvagUk9TRbv7uDUFAJlFCtmD?=
 =?us-ascii?Q?sTeHKxKRELE8Q4gFzGwj8aldwSSFuJtXMlosilKmC8YgppHffY/RIoX7blYT?=
 =?us-ascii?Q?uwB+o85tKfQdKAabUW/JrHdmo+7r+P6T59SuVhnK1UIEc1ER1qILP9eMP4fy?=
 =?us-ascii?Q?EKvj9aT+6if3i5ffzcQFpvM0JAw0jw+XewoHM469jyT/b6a8fcxcak3AeK5H?=
 =?us-ascii?Q?VpsFMTNrypv5AgVBzKhsQuLvhzWItU7TJCF45bUYouMZPmuiV7HnfGkqtRxg?=
 =?us-ascii?Q?0Eey1/TGqDqBi+cgIy9xlbwU/s8u0oHdfm5EBBNvvzMzx1TFeBZC4T9otwoO?=
 =?us-ascii?Q?WWElX8fEA4PV/zYIKPUFtG3RMAdUKnR0BYeogJbNz5GU2RLod4zkXBCYp8bN?=
 =?us-ascii?Q?HojP23IvZmN+KP6vqYZAhvlLdwgkZH1twiZebtwPY7sMrey8jt0hGBNTR8DY?=
 =?us-ascii?Q?3zJlbNEixApH+pRUHZDOfxmk4gVYtohErFpXxSSBxOvIDGGdS1SNIc6h1EGw?=
 =?us-ascii?Q?+5gp26/roYSgopwPx0xO0W3aj66lXLwk4rlmqWZNskT7FT4uq/jMMrrlYon9?=
 =?us-ascii?Q?VrbuY35h3kBsEartMKY0tSBuf3UH4V4AlZ2xt01znZZ6FsjDwx2Lhh7IKZLC?=
 =?us-ascii?Q?TaHL+aL6yCWxP1P4q+bit0L8RzPj0o/XEMNlVykMw2U3dFELjap835Ta2UsK?=
 =?us-ascii?Q?c6RhbcMn07kIjq1iraEmN5exbQJi1JEnNTB8zk8YOXKs2QVj1sxGImFNPJh3?=
 =?us-ascii?Q?AuMdl5cNKZg+NAMF4xLnaa+wMXTD3jH6BS5cnhOi+adnh6/0hMawAlxDdmGZ?=
 =?us-ascii?Q?qUfr0u1LF+HqlX0He6sYUCYBVwOyVRdYnken1x45C8iyrh8ZahB5ukCZgxbV?=
 =?us-ascii?Q?4Agjh4NIDEdH/5hlXKgwnULUQixXzeLNkwnBD2CbxjNLz4ASQQokDNZAp0ln?=
 =?us-ascii?Q?AshBEHhMPZ4E6RAmP1KrxZ78KvkmefD4vJzrvbc5Tv46TFcPpeC6Kds8qpwC?=
 =?us-ascii?Q?6YIwLf3USSZg+zJI1NdNV4E/zE4hx9+a+8yO93xCx1TMZl5DfTGG9FGWlzYY?=
 =?us-ascii?Q?GTn2Pitmmx1WyIda3c1k4umYzgfWkn+nhiRyul5HwDsMJCRLAYR5EPfMOX3X?=
 =?us-ascii?Q?kWmJVjyV4B1/LKBCeMEju2TtBVvFeR9fLv/zoyyanCmD9tu/zM3DTW9+LGrr?=
 =?us-ascii?Q?YmkZNFGfbrgJY+xDOuDvktEPkJAvj06K6KG7rJrrDVCyF268z5oyK9vHAs8U?=
 =?us-ascii?Q?rIt99Al1c/tPrYgSS0Msj5axf1rUf+rDwnfqFMBnFwyhOinghRGNoy5Cf5F/?=
 =?us-ascii?Q?gZHIC4xUCePHnKXTdh9iAKz8nUs3RqSViENtYX3XlJJ6mUSjVNWHFM31DUTw?=
 =?us-ascii?Q?n++e7hJMS7fpzzx9MjzFUyqXLMb2AE4g4RclUQ6iovBvQtky6s2T2myyy2EJ?=
 =?us-ascii?Q?+KXlqHRe8hUIvzJuagC49JavxzlHfjybxkaEd3uuuqSvcwKRiMR/9FYFK+ds?=
 =?us-ascii?Q?+VrYORykitTdOX248gL5zpaApb3MSWYB08C0ZUUrCKClWIjpyCtxHpzvBF2g?=
 =?us-ascii?Q?R+/E/FHmsR6jemzmdWRYMkJF7QqPq8sXeQWi71Zf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91eed440-0069-43e5-e950-08db6c7e9bf9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:25:24.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shm61dKmdEhr1NzBUCG2S67fiLnjn09m/pGwfUJCoFaj/T7pJZdykqwISyCXgdGD9uNC9bnm6evPTE8Qjalrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

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
index b9f6dcf995fd..94b7624bdfef 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 char NS_TEST[32];
 
@@ -491,6 +492,41 @@ static void test_burst(void)
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
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
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
@@ -505,4 +541,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

