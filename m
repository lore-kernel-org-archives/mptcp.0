Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75552628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3aoNZgx5L2HmnBnTbM+SLv836y7SopwNsXjnQmDxi8+zfWuhog7dGmVEw2VlY4QIH9ERJbBz8Ao7fh3/bSXGyKwI/SnR2+1RcsyNEbjpPL4COSo6dHGZJU+C1G4Lo7n5CahhnErxDMOQPn26z1vvoUeBRP9MiikoqSIg59XI01EjGB9VLFGAuIcW7zOm3vBRtMhgQOyNNXYWC70CdcyooJKFshXnDzaH5f6TJhSVB1HEi/hAhBrBwD5/YZOKzjI2k6hvTvPEij4BT9jlofTiH3CsQM7QGqYWjtatA9mwTDp3371Gx08bHZ0tBvDBgZc2ZlkuDdYB2Gxpk4575xhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgsDyY0vTYB2o0sK/fDUXM19faPWLKks0hj83Xoq6Zw=;
 b=RImuH2hwW2ABidz7F8PAoBwzVPuAgDf5LvEJXJdRQNwFg2sIDRlHIWEQTS4EUZl7HE8Su4di7rPc1xMNo0VNW1WKY2lYNkuNJqQb7V/riEhVUiDOLSG0SotfIidQACHFrqFgPlYp4e7MRxH4Qqz2OKyMPX/SKqzN+R28OO2x/lepI9Tkiv1m25wax36IFZsNLOsmv5PWIl/R9SIjOQk4l5w93oZ9vLpG71panmIjELzP8e+53NZHKCm0pPLSR4rzaNuhVVIsqdyxCwzERoK9P2vsbQ3QlpkrdbDsdQkMZPEzwMdrslik8vjyVnxr009MbxIuXJWI28qsNbarajP0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgsDyY0vTYB2o0sK/fDUXM19faPWLKks0hj83Xoq6Zw=;
 b=MCeSW7M/uQ70xz//hK67BCoHNVswa7J4P49Tpm44JorGXEeiaLVG/b9O0G/ZxRlUiVlRj6M170CxH/LIFtuNOn4WaZJByjWy47wPbzN+4M9uLXRLexht5nqU6rVd1C9CKs89NGgGlm8kk/2iRR1WfPV716fZZjhtdvlLbNxSTA34ziheklCVDXz6t7i+VuH3/jTKYntXhCDb6BpgIkYV93yT6Hr6GCLDcmpQ1xVfU62xhDU4PHLjKkNIstngqGnjeNTLBWKBzGqJxCPf7+/cAwUfIrnlG6b0o2KHQhwY7t0fP/wyqBUQlwW3eqkPRQCm0X8lKDV8LIzNwTeJtrI1EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 17/17] selftests/bpf: Add bpf_stale test
Date: Thu,  8 Jun 2023 13:46:55 +0800
Message-Id: <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 713628ee-a1f4-4333-fe13-08db67e42c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NekqiItQGXwvukFJo+rs+OpsWQHxTrDP2zFTK7Y//0acnheRmoirWIE7NJz4j4OiGnqOKD9RWdk63zZb8IxFHJqdxbT8P/Ce52sN7IRezpmhmAcLDaVqsxaeoF0ENZBpdNO+yq4iaENfbwuk62ukXQLRxNW2wxscptQNGB/qmxhxU7UqaUJq5aMjOtVSjTlRCv6/PTpzmjQPTP2WcKB/DY46iaEnckOg4HH7bQhQNX5AKGwRgivTgSXpBco6f70MzjFglN+MxqtW39gC576FfYcgEJPMa3HJLlSWozh0pcPMfSKsqVHEAZVdJB8GfRP+uPgDuxNaopIyCMSgmctHPVLaeiwIF8ecBmjXAz5LoyBIFaq9z6FLp5qlEpHathGgPBlcz69j7mnh05RDdbfijCKTuwfc1q5KQQd+Xy7SgliHXz2m0BpvPk/fhWUSdBhik2e5UUlLvl03Uo0XDqLd9IfM69KP7NvztYZbDu/5b+0svL7yLQd3HabZwQY/tiN3tV479DMrC6PrPbf7e9alMkBKHTFB4pPp2Yfo4VJ731LU1VSrg3n4rZelk/EX4L5M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qd0r2Cnf72arXH9a+ZElOyzywtfIZmh8E89E9G6p+wddLEijJoar2jpHjJG?=
 =?us-ascii?Q?rQgXDvy+lQBO7sOl3yODdlBSc82aareuQSFuh7+ZlspY/1ryUnc3SUhfy+oX?=
 =?us-ascii?Q?xs0UhVjhXEyo1fjDg51Wz0gkwRs4tYUiRHWiyR8nvYL03dVF+sS98sqbc5gu?=
 =?us-ascii?Q?QUww5ycPeA2a8hpjruTkterzn54eF8MhAMOp7MmW4BWg9rPNgon4mb/TmxLR?=
 =?us-ascii?Q?IKkLyUNY6G8dYKtVxEdVOUAzj/HCAPoBaCKwSi3GFtAz7+sVDsd+9+MkrbJz?=
 =?us-ascii?Q?Y6lhvkfcBTDslXUa16mzu/iqBShjdmQgXEF5F55eM9jyKQfPjnHnKgJ3WfO3?=
 =?us-ascii?Q?OTxS3hC6eNkuiCivwNisNs4uwkoZRyfpHUIYUcOLI88xeRlHdaz0nT7HJ1OO?=
 =?us-ascii?Q?SX1NJ61HPcmU+6kyDMysX+cYjRBjcWloWlRyQMGt2yZuK2AOdNDwPq1p/+cF?=
 =?us-ascii?Q?wavrOh2SLtIkZiEsP0zp1ptrRi4OshrDMxkgrofJDhGWxTmhzKaEjoA9sDuE?=
 =?us-ascii?Q?WoP1iOsTENBEsaY/7VMNFu5ltsfYGyWAeU+yBiHlKLOrP2Cxut9f9T2lzt4Q?=
 =?us-ascii?Q?NQSii5Glv51c5UM66amm5gnu+NCpUNqCH2TLY7ZOGNBYCo9/QI2bECmN5frQ?=
 =?us-ascii?Q?cLVmJcAAnHNUT73BHUejf6ZdIWZ9cOHhzrndegkK6gW2Y8x2uX8j4DpOug48?=
 =?us-ascii?Q?DEWvz3LNCXbAKMWmfx9FkOxzKBrG0zKTq4KKWHWTIjJOfU8y7mOBwHOk/S5I?=
 =?us-ascii?Q?9UMSf/Og523sjt3ckEMSpcu0ops5sKreXEjL/Z91r63Z80wLeHNsgj4tdMRH?=
 =?us-ascii?Q?XwKWHFXyyiYFjo2EPvJpLV+u084nx+Jk8Cfc0Cyh+Y/ekPZPH2Ah5HYnBt69?=
 =?us-ascii?Q?cxVJDqOjpvPbgOAWZfTjfsLAulWPiW36+YDBEjbuj+6LLYOPGvBTJqsbMt3e?=
 =?us-ascii?Q?xbENxgmfjheyyJW+Chh9CmOEkN51/mk9k/VPCHAwF31/e0hf9cfdc/9cZy9+?=
 =?us-ascii?Q?IRbsNvRmtz8f5KIkO6zEentIbVL6BsA9IgvzVhHy94aV4YCMvPCF38hC3ZO7?=
 =?us-ascii?Q?VYohNLV2VEf8MHSDutAKz29BMaRk5lMlK9XUKnWJEiHzmStsZvXZzLPyFcub?=
 =?us-ascii?Q?DvQM2/TVk4u9mmUGjXAh7oM9crFAK0W228USz7BcGTIgOJ3Esxf41MdJRFVF?=
 =?us-ascii?Q?sCtNS58clg2IwiOr8ImJeWFkhJZFZeTwLPBjtccrfxlQFVSpbQKd0P7v7aC7?=
 =?us-ascii?Q?vDgR3umoPPn70JXcwYeCnt9jcigvESgqsNH3yIBQv6cM1Hr0JNFgHEowNp6+?=
 =?us-ascii?Q?gfT7OTCeB3GgdlBeS9t6BktD3HoYkccogl8x5cbXYfcK0srN4SPHHUYdJqKe?=
 =?us-ascii?Q?Pno+Z1J7aucyXn6gmRZ72tz+M5hveLBt3PeDic1vvHwJwODTc+Kk7zbe2nLq?=
 =?us-ascii?Q?pOUMDh1AdoZz4M9B40EOFmVExGfMVyNJQ+E6rMquTNyRQ3sPbDR1DLvdEzBJ?=
 =?us-ascii?Q?cm97Or8tiRG7qYGVVKx0aGborDh3dqQrXqNt817UKE6hqZYPxF/43BLESuIu?=
 =?us-ascii?Q?V3W6tfib6P0eslTBVuSmeNj+56yWh9twmLyA5kR4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713628ee-a1f4-4333-fe13-08db67e42c5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:49.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFJdaOPlk6IHKWfdbLba8IpZY29wZBrqd+CtQ8B0MVqNwaNIk8/uDIRS9Xe9bK/MZOxv/+cJtN9pajIot05VJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

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

