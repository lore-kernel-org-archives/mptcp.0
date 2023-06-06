Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87A190
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZJk9QONT8ltY11sT9Qww7zWrSmDgwNsdQG0i2gHVOkIY0mpao9Uyyh27dRnMF6/ceWK38wKfbq3T9ODPyDUOtV56lvPs71Zzy0yT8ZWvrDda14dHlSM50PKDIstT7uxH6XqSaw783bZoU7+lQTutrJqDEL+OfaWi+q20+9fVwEYarT8IPIkkq3for0fAncluL+gIXy4Y2nvwH8v2ziBkifLsIyjVw7CHan6uS0oCkXfRcePk455FjuOhAo3fNSQ++7plamVS9TkV6KUODOrpJufx0PlHBpCEJ0RduiZ5534FEkKmAfrQvkyRnTxpJ9vjDi3CMdCRGWXSUdW5OYkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqsey2npaM+24iTflag+tuO/M9PWWZRGrRxDjUOV/YY=;
 b=Q/jrLV980d3YT1/0reQi3WBT1d6tNWI31R6QBh8eexbBgVHhyTusdHx43fZtzuQjPme4mMufPMr+QY6bVKB8j6YLFBlkvPmHhDG5twPT3rbiik2JJRrXBIWw9GCTKlbFJTH3UdcGcZnHMsrkHnGJOMPosP1jt7kAlqlQPOqUVwKKK1a7txF5POyo7zCNfoCJO3wE+HEq7c9QEpfkNAX1BVUbTKK3KDMgFBWfh1pmXwW64EvJPuNr0XbiW4VtXqZhfdiVyB2KpRc2dAIVAr+yBMZJEuPLjzNo4JJH+N7TbQCcma+MyJ3Ost7tVlSNqV8yswzZLWIDHd7/vUqBcEkdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqsey2npaM+24iTflag+tuO/M9PWWZRGrRxDjUOV/YY=;
 b=Se8nuqlzfjg7Ma5wmm724rJu9ORMhBjWGAMbWyK/8wUTbonjBl5gf4v0bYwTf9Fy+/FNEFguUFwZ744SgOVefHZ9skeaAPmuPp46f78AVLhoU8j/eIDFOBw0aA3n5b4wR7vDnzbJkWMwcJOFnveWtkxUWHf32wtGRYFPZhvwgzkYWQHGa7LBkmIb7l5pRloghhysEFi5dXYAHHYi8p8cuLB33HejpJD/Z+RiPjaL+j8INQnHGIHsO523++j5XT7TYDfM25HR8WXJZcYQwqlHgjCgdhPEd0R5vrcpve/mM2hxEFMRtMY1xJ3EYRDfkLBlp/ho2moTA4dcVlPtJzsFDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:47:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:47:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 18/18] selftests/bpf: Add bpf_stale test
Date: Tue,  6 Jun 2023 14:45:17 +0800
Message-Id: <1f005b865aafc8870ca7f8a7c4cc99b7964562e3.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cb7ee0-2d8d-4866-7fa4-08db6659de8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhpxFu3QY9iqaWNd4We1s2fttAC3FitJjlCxawqUqI/sI4cEPX7zI6aYDxhv4DkRUAz4cLVIM2VvDGIK6rKUa0E8gMrndedpncrB7brwyPtEkqNW6vxY96UwC+qmfVw5lPfeaD6S1kiA706hHWa9yvYWf/PEi74iXQ99VUSUmUK3lsjGc0T+m1PqL8109IGGenqJfvI2W+729NWu6JKNqw5mVcfMDphtbQcAjw4gP5FsYuAawovsWhsxn6vyK8Q3jAwO4t/GMOOtk/8tX8a2+agfY/fMAmmdjCBx/7ITTqu3jRcvsFhXFWAFQvJr+LpVFLkCaV9JVvTDnfwbNddhSmGL7Drv8V+hmnVpQIRke4nOh543c1x8jnFbUrPOISzoQUCxCQB96k7ibfgSSaqb4D979ACshxZ8lMOXIXLPFrRx8l7bn6j9bGam7wRbV0jbzewe7i8PsP3ZmqnlYEk3mG5soYqXwCiCkXiBKAdQ+FG8C4LzFVuGmhVYgLQZFOtOqdbvuOeuOdTyqUjnqJ5xh4DbAmPNsDwu2aK3Nx+aSDYbV437vGFxjHeklKdT/8ec
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(136003)(396003)(376002)(346002)(451199021)(478600001)(8936002)(5660300002)(4326008)(8676002)(44832011)(36756003)(2906002)(86362001)(66476007)(66556008)(316002)(66946007)(6916009)(6506007)(38100700002)(41300700001)(2616005)(107886003)(6512007)(186003)(26005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WO3dYiDqpPZ5SRhrIWcNOMih88o0kaIUQHQOKFqZnuv8XPoZxFeS7gSbSMOi?=
 =?us-ascii?Q?4esCRsUz8fafTjgO7wpTpcDfXQecxocG80+K3tuIcXxFErlzk1iifkqhT5Wb?=
 =?us-ascii?Q?XEddi5WhWZTKyNMinIHuoNVhcbevxDvMn7ifIJLFPaufKVvASC1hFQaCMJ0O?=
 =?us-ascii?Q?vngLSezKpZdDJsLylvBuBbUXNYM/wgUwsVz4iZlTs0RFmGgfSEvpfmnfLqHe?=
 =?us-ascii?Q?kr8dyYvMdjT+XzZ7c9EsAVH+WBdtwVilns9MgMvmzwP65PGHcvclqVRfr1Ee?=
 =?us-ascii?Q?8JX0B5cGSjKk/fHxdPVrcJPrmU64TRb23YO7SuNsgTTw7L27Xmb4KDWclnvZ?=
 =?us-ascii?Q?5Ok2mrGPuQQq7dM+MHifCK2g+95WEhpEAMjPYKlaDNJ/DZWcEd7L3xLBwyxt?=
 =?us-ascii?Q?DCR5PfvtUqMzm0q4wUjfr/AwrGuOVqTEHnyd7Ux/qmSc35Fcjsl3giwEKOW/?=
 =?us-ascii?Q?m7rhLOnExSHKb3LXzV0rBSxyPPA9GBeGN3DWBY1JTYQc49NrN+FOcxuWEOlo?=
 =?us-ascii?Q?dWdGOytCL028xatNfXs1JgRKfkLM1S/iuSqyqU9NloJvm4sSwGsnP0JU9KDT?=
 =?us-ascii?Q?UZ39dOcd73tAdIwi3pMV2QDokrEx+hRKeqXjm8g02GdyHcZFrGyqR7V5JZHu?=
 =?us-ascii?Q?/t1+AsmQ9Vp29Gj9zhoOKyv9eCqdSNDvukXIXVnd9ISHM3XKeAtEV5LUmmI3?=
 =?us-ascii?Q?qFqPd92h6KHCm5D1I7XIyVGjTgKv1FDUrgaJ5tlTati7mBwdk5YL+gEmrihM?=
 =?us-ascii?Q?vvty5AV/bHME9SYCeApvpfdKwZ3a7QjrOdfdy4wz7cCe0mC84oBueL/79Ldn?=
 =?us-ascii?Q?x2kVYjDppGBcVLMAQo6leEnCxDOY+ovNgLGUOmMvNYFbSVzBvP2f1MutDanM?=
 =?us-ascii?Q?0AKg6cY6moC+DAxO08wYMIxq4Bww0mkXZWw5NsGyEaB4X7K4sAAdkXyWdLV6?=
 =?us-ascii?Q?tQY5y2wFkOaKxwOf4jnOmLfRZ2/BpddoSXs14NuP32GRwRwYThlYqyVS6T42?=
 =?us-ascii?Q?E2u67T2aVFVjPNHnRdI74RDlnuKwDEON8P44ySf2J5ap8RFDhy7Ilw4q4ek1?=
 =?us-ascii?Q?RcDMR7wdV6oZ2Biye1nBbV5w1NfvVyd8kVHnECOMr8dOZq/tVk6gcS0RyifW?=
 =?us-ascii?Q?Q+mRoqClEwmoEU83FnSehiTiEuYreAxAXxQdVsb4hahFDDou82F3NTAGRfFv?=
 =?us-ascii?Q?WbSJUnPvaOVAxcNBwcvKHq+aQZ6p25CGuk9u2EN4wnUrDRtBQcVswCOGz0hH?=
 =?us-ascii?Q?ieuMmgzfLo5S4ylaEwLqyWXMKI9OcVYmURTS1MSUMj1yeDgtcUtbb2kRMYMo?=
 =?us-ascii?Q?IphQGxgJaQ4MrUvByl1q3t2R/ceDqNW02kBzC8Evi9mi7ThDjUUwBH9rOU2Y?=
 =?us-ascii?Q?HquJIWfZE+NvYwlqdEVkltVm+2sxe4M27Bvfrq8czkmfs6DbvhV1x4fYVeSG?=
 =?us-ascii?Q?RqvY94v3C4rLgjwS3mVahHUyiU97djnDn5bG4BEJ3bSFUFw8/+asih0UnNsv?=
 =?us-ascii?Q?2aMQNSkTxNfWZ8IndZEF64ZCr8dyF7SlXXlk+jBsvFj+OCmJlwrnblR4cWwM?=
 =?us-ascii?Q?BTcgV9cvogdsLh0MJiHlDx3SJIurZsSLcIm/tE6w?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cb7ee0-2d8d-4866-7fa4-08db6659de8f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:47:17.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+EPNUBUyV7/7owKhbAaVwWAMVaQFjtBpFqhvBpnlw6sHiyLgmdMs/CwFYfZS09T5HCU7gU9hC/EwPTq74TrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

This patch adds the bpf_stale scheduler test: test_stale(). Use sysctl to
set net.mptcp.scheduler to use this sched. Add two veth net devices to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
of 'ss' output after it to make sure the data has been only sent on ADDR1
since ADDR2 is set as stale.

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

