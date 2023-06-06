Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3F125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne5+9YJwlpukhGYqzWJG/wGjeyq4cTG3KIFdeUTSwerjcgaTRtEOvnEbTlQW8ls1Ejcgp2U7XFKUUdJEohPTY8293tjC23eeeRqSv4jCiPKqWmR5stRQQv6FPBbZMl7GFb3CP4J2RzF7nK0tKKWD/Qu53CTaj0qhcDm1G2saJgLUJ+4gERHm0T1siQdQCJIAEkvN0MJI1kKgHSbWZiyHj5B0d12TfQo2J54+2dayBmeJQRDaMoz4UM8g9CkYRJ+Okmz/vHz5SeTdE0bu+opys6wwhH+5kIeE4vFKesXpaceRK5HMAAQg4K+KonCYbTJYcacutELk922xMS4/GY0u7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb5mT8p/DfqTuANlM6lZwKOgS8e2e/KTKDixMq+79LY=;
 b=BijVKRBbxU7nt/KTkKBLgCjc66zYqv1aUVUgp8eDQ065EMC7Um9fa1EC38uv1FpgsMImo5zJcAHoXh1/ISkj6YlrIM5YO1htGXPs1y83Vxd8Nn/+w2gAseYOSWOd2XWhjSSGUI1xd58bc17U63kSrshGO4KWaY9ZtMilhjAZCTEnHarKwKmo2uGaF1T5Q5cN5EiNKxfaelaeSEYEqLBkBMsDDfOWV9TMXbehX3SiR640NjumAKPxhWZPeIKw6at/9efhfWPkufVvplujD7HStJYujpSSSir3myhLqYsSEF9iqUUM3DWpH5K40f96jIqz/f1BxxEjB0HOPnhfxTwaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb5mT8p/DfqTuANlM6lZwKOgS8e2e/KTKDixMq+79LY=;
 b=S1aWT9K7EZ4eQawcKMZXNBnIygkZhwMaTM0o0OfrzXMMWU9ac/Gg6qdp2Yh7mjAOJm9BjmNC+VIYPbjuh/zAdE1JnhVWx/16sL4HOhovNPSfh1A0/j8orTEFZ3IScPwPIv/SIFxbKQn8fs7ZiUa/1p6oZn3MXK4IhpMPghNOIQYEXEVIKpdCXg8Q/+tzYTAC6Fi4ZArLxxSlLa1XZ5t8M3TSF1mvuMLkfrIK2V17qDGhM2W4Op2VOJpPBnFU1mAo5tqhase3oOwEK2yPbPvNmgwjP5wSyJQch08dqkbUXkwTYrrKR8zXY+1ikS1wVJ0eo+AvLtUKEy+80PmQfYrNmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:02:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:02:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 15/18] selftests/bpf: Add bpf_burst test
Date: Tue,  6 Jun 2023 16:59:29 +0800
Message-Id: <9f0b7e92e5d3ffcc86f5100e71cd6151003c414e.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: a27e370f-a6da-40a9-15d8-08db666cc9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R1NRKr9ecCnZ6XKYGJejG5AuFTTvE7Zy7GmLSlkts9ORKoA7tUHEB5qO59KOACiyRFnW9AqEE0HwIHSDeFkSkgX9zgyQFgw3odJsTEIK5oQK7SIx9iprHIfEWNkf7/mAAiYQWtnSsih8LGwa1GZdhNznjw2qlXxkhFmsMi0j3nN+bt8z8lD/qxg5qVHeWxm02ZL4NLb9TIwGADasc0UVMW9k7G+nTyHqvqgEzsdnMoc+zjpVSX7PC7TikrCC5eY0JKePgnFHGIGYt7XcRYygVUKq03yunupHAVUzJSVXxTbHTOsX25DjnsMv1zGlNncQ0qkOyLowjYN8+SEzbBvXBuzGrDuPhnFcvzRece4QAzZ3incP/lGrCI59cksx1xNCI6CM3ZxKpomNIuH/+Gjf4y5xgTAOaL316UFR/63o60tb6LMTSmPMt4fh4dwk2mLQFRnbtGezN88AtUhBvqLZRiEij2kcjjObIJAAizI4vGgDhjsg9YWwc9duxp2nNxRzbLKh+y4aZ7WdTfYC1dLwmIAwiz1MfILtfIqr3g1TyG0A9X2JhwsrKi0FTi2FAY/n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(83380400001)(186003)(2906002)(2616005)(86362001)(36756003)(38100700002)(6486002)(316002)(41300700001)(6666004)(6506007)(5660300002)(107886003)(8676002)(8936002)(478600001)(66556008)(66476007)(6916009)(66946007)(4326008)(6512007)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yc3jnV1d10KAJzhVALN267zE35pFjvSAVR4Cl/s+6foH/C7v68qVTABjGvoQ?=
 =?us-ascii?Q?/UzDQz/7Lf20l30+BRIng0/fFjfjg+DnPGFjy6DcPnx7kazt3FRgXymbHq1D?=
 =?us-ascii?Q?I+bGe8v5awVRQlxCzBmAELJiJ5osQGp5uRqRGq6Oa7mn7Mhq4wSaAD/cMUL6?=
 =?us-ascii?Q?Gn+gt2JeFOBg99PeC8iz9DnpHHE2uaLjL7JpONe2AMhfreqRs1AKCvFbAM7a?=
 =?us-ascii?Q?aqwGae50tzt3H6nAX5OKCNGsKPrvJqF5lQ7eEPW8ualzqKd8XvPJqTbC2Xou?=
 =?us-ascii?Q?sDeUGUguWhWSnM3TMhjrM3sJdIbcNhTiqcyoLrhPI/QIzIDOtoxUvrffd1g0?=
 =?us-ascii?Q?X/xmTjrn2yd4KVrQScog7cVJq07RnpFBeMPMyKktlAskSjJ6Xkxatm2BdRSQ?=
 =?us-ascii?Q?dyAtKSi1tq9Jr0TqLV/NS6exIWd/zG3SMs9SMKEqpwzoI1VABtdTnSm7ltFL?=
 =?us-ascii?Q?LRMJFCWuskKzGtcXH3p9lUHOnV7YNh2eBuzhIlVL8lb8NpJYICf4VeyO4BL6?=
 =?us-ascii?Q?7b0d/GipaPxAlbL1fvU8Od3KaScRh5vDKl1QIEpJ5Lgy+mY8GXv/GyLJHHOl?=
 =?us-ascii?Q?mCSRKZPSdFrkVaX8plSCvGz+jDdnXx3lKL0fPcZQksz9RAWl1ow5HGtDc9Eh?=
 =?us-ascii?Q?ecq6LgRnLr5MBONeXPJvidh2KYAAiL8URTakb7ctVFb87/Nt4DRfrOvxZpSr?=
 =?us-ascii?Q?yjdeoOM/TV/KuXfQsqERhl6ikT1mqckNl4D0AUqMHOltM5u1XK+fNnFZltu+?=
 =?us-ascii?Q?oWk0bRaVHqzhK+dHISfMKEGwCqmWO/3k1HCbQMLTsHOBiofMkgLNhaz3f7Vv?=
 =?us-ascii?Q?8ndutr6elbVd4rOsfD46bhPBGvwJ1Ra4BuG2TH0xQr9OR32F82XSV5utibbx?=
 =?us-ascii?Q?20+z5I24qXjuu7gfc2M7m/vwjjmMzT2SQvQlRxCLu8POzkhptxPLYBDkeV9H?=
 =?us-ascii?Q?uzXKD6kxXbPob2H311zzhss/eT927fviv04tW8ct8WnFZ2OTnkBYFwE+5r5C?=
 =?us-ascii?Q?sQ8xSGG0d0I0iZTRbUzMVR1GbQRIdT3pvAg8/AlpObvrMUk47laMq860KdvV?=
 =?us-ascii?Q?7fDWyZWr7d+M1uXxbIPWrot6BVnOM0+pyrZNpcVaZHK13lYjPj+ac8wuQ86n?=
 =?us-ascii?Q?HPAWDD7X0VEUQ+fmVOJcv4Lkbx2syz9iYf5ao8cQKp16b3LwhJsrYmfOm07A?=
 =?us-ascii?Q?FVPaYBr/+AHY0nMLgQhkDgd1j/13yV4x+L3nIxBuUDz1SUVuxKcy1u9C6mqa?=
 =?us-ascii?Q?92EBHcR4YQYJAEywZKDn49nd9IJioMKHX8eHaZQQZ5TAadK3lXbovRibFkXr?=
 =?us-ascii?Q?IqEsorCPHaM435ii5FrKUTyt6ckShRcbDeCXzcTRhsM3nuTMnnw7Y2Rl+aAG?=
 =?us-ascii?Q?tkWrHsHSb/ITxy5RORnRgIqRPhtkKNp7i9/eDz8A7TXikmcgslkrDuL1Dt/R?=
 =?us-ascii?Q?98GUDzx7uWjEZyWpry21gBRd6ELd1qMfsjMgXO0ZBtyJmCvlOUhBH3hyZoZo?=
 =?us-ascii?Q?7+aVICCZgko3E2fNJ2H84C7qOXWbAYYckfbUq9xuEnEi0KKB8Be2vuBcL8Ru?=
 =?us-ascii?Q?hGUyOxZHwq1wkeFTmjb43b3/gPfZgPzPigyL1tpl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27e370f-a6da-40a9-15d8-08db666cc9f2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:02:43.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIwXef8OY0mx4R3Ml+JBj7otzrIWM1g91OHROxo8zRhKLHOYWZmMiKV7VwO2/Up4KCTLz2dr/Y84yHC/GHfU7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998

This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been sent
on ADDR_1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..750e665f451e 100644
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
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
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

