Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030C7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STDPdmeTfPTx2uim83QBTdYsEzDcje9Dt1g8BhBbWqagM3c5Z0fpBMsNtqBISwAf2TbuoTuyyUxgEv1vULBB0enc1RzdLkBpc+Q7vl7qXgKobmS0pvVK9fN8Qub5xOXLmQiaS70kAubnE0hM4ojwNKBQu41tChX8mPXYCHkmh7dz93s7pdpO+oPkmNNapvPIzmrYFvSZ5Dbw12rTocs7m50TJKuwICdQeQ6QGkzW9vb8Q2jNK84ocGo9AxjanJvG6tDZBNWh5uvqgvojCwK/xpwJ96U0W9AawfwwhrfqIshC1e4UuBN2yyW/dG3kpzNYOWrzadwJBTukqDqshhrZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=a1I6NWDrFr3FZkHAJNzfogD2aIlyPTF3ZJSgCv7H33VnQxOInMW5fZ75SDmdUXXzMx2ICa6RmWxr9idaxkyKb19bz5kgha9lk7NOHgfDmkHeYz/aoPRls+OSi43ReCcWyXLXWhY5bqYU16YuW2QQlz3Zp9yFNlkvS5bQTzteIzRS8TaNJfKK6msc8AiCIH0ar8+Wz3vBlymuZ2KZOY0hWweAcLo3vlZPymaZ6XBa55cuapt0nYQq42QQKodfb8l8urpQBgnADK4kqrAKCyQArUHfCYQqy1CXvSJXtcUi+UruHFr32d+yfMsVp11yc6Lf90x5USuRr7hFGKdVUmvaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=oNQ5gxx7ftajf8jcB5cLCrPBD2UzTOtrSJDuyr5mtbGzOvosuxVtfw1yYgJvioVTWlkkU9jVU1H8wkDF1P+esNbEIIES76y+qUacx/gRJg8Iuu0Ri/QUGnIw8e7bbb4G4zvENLbzMkQZIHlPCK+JbOQKZqvmHKbzM53pMdI6WiByu90UBFtWPZ07D/ztvI4lCzMHaAVhYwUs7tLYeIbGNmbgaq8rANPQPPAfhJekJT7NKOYASg2MNY2s/dchf8SRJQxxPZAVr9KRXRUOg+qcq7h3zNM11Ujr3wGrICy1eTmDX4dd9BIv5xKLtjcAfWCJykiHVoTkXiaNTS36onxuOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:19:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:19:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 12/12] selftests/bpf: Add bpf_burst test
Date: Mon, 29 May 2023 17:17:26 +0800
Message-Id: <833a9d0d117a3f9e1d0c78f0217e10ae2b681f20.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 826fbf13-33ba-4231-24df-08db6025c1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FFCGT69JTilwpJza+QKP2f4rXUe9lbVNpduTurySRZN2Yy2Cau5I0R0dNRECl8s6t/V4FrEPCKUY/VUPZKv0tUWseD5GmDcPk+HsMXOujAvU3v2E6VNdxM6jO6hC9NtRBeswDixLEdR9YLoQQAITgafCUygvmo/dv6se0qkQHLoa/KwgBN6L5xpQXHRK0ebFwJYrmzG+RLmfGgBwrKPLxKSJa8AJ7BwIJYpauS6RqEy2u69ZqoOTLE8UGUv8fmg/AFe6a7nN03AlTliO96pJbRHrN/A6j0a2MWiTHEJwqW4C7FP/tQJHYeEp92U2/bo+p5QNbVKHPQw0ZinAJYotiAqC87o9mrOu0/X4l3pvtZ2BH//ewCa+pfz7/j+S1GfdfNlhLEpkDgOHwpW9hcrk0RTSCvzi5/7c7uaHqJNooL++KJT028RPR8BaPy6R3viZVslGYmVBr56rWXYX1g9+mO81VvdKofbENxHL02IIbIl6pXuaB59YhGGdd5MKb9fYU0TpxozunwMV2xllEthkt6uY9EsBBSBcqUn9ocQI7XmoAyRvUisT4K+abW0M/uEA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBxdP6qIicQiPgfKfQTqh+g8Fyn0weVp2XnQZG4f3mnyBiLo7OskLgWtgQNp?=
 =?us-ascii?Q?e7ncV0sYmsr9FRowd+LpmVi0ZDx1gIKihKC3mM3UTX472PGN9Bk3hGuISTGr?=
 =?us-ascii?Q?N4X4eqHxut5aB4fid/ZDduyv4m+8TGV3oxdVHfiLwvlOXOQwQiq+YF94I2vq?=
 =?us-ascii?Q?twCmID+fUeEW//72plbk1wvx5WLaSA2oTVOOfbbIPtLbVnhlFDw1yPU0Oxwk?=
 =?us-ascii?Q?2DNu0yUFRc+RMFI9yNJ7zHiL0fozeE1EnAbtdvpJsDDJymicy6EiVPlNtqa5?=
 =?us-ascii?Q?K4UKA0kbCCu5M4pjrbcujsjXtdr4cAivZ/PBJTi55L7/MLqtRgCbL97MD6bs?=
 =?us-ascii?Q?Y4D6UVd+56Xnt0RvvzLvRE2mUsAGc4q8a7VF47+Yx0+Ir5F8KwCqPHHRl4zH?=
 =?us-ascii?Q?bHgjYXpBLWXxvYeajkh8kZxeVexbih1aBJdUesFCYYPK42oaOK/HWSsABKw9?=
 =?us-ascii?Q?cUBseNqi3XomlG4q96T4lEnoRkBRR3AXPiluYEMwu2On1qrZkfj87YlCwy3k?=
 =?us-ascii?Q?Ubx2+qYb8qC4OInC0CwwPLmpGJoLzXJ/vR0CPqRHLaFeuI9k65ihNVpnOFvP?=
 =?us-ascii?Q?5gHhVOIfnR9mTOuvF+V+5F9vcFjLPS51fvRm/+Ux0Mhj/ZIY2AoRsVnTaShk?=
 =?us-ascii?Q?dScIOa5AIx2rqddsYHzqe4iWhKW7xgNslpao/gP3bq2xv3//ir0bITCsNUko?=
 =?us-ascii?Q?KnjTJLzA/KBzfWNL9PxtXOQUkdAhs2XalD+3jZ6fDjxV0czFeMXNayTrqgqo?=
 =?us-ascii?Q?npFIfuK0Yo4CyiJN/L+zB4TAkkNcxEOcTG9U0/TSwIREJW6ZGGJw+dwwXxf6?=
 =?us-ascii?Q?ou1XGmxCTROAk67AxbQifNJ/kEN/6MLJQeyZHQDV84ocIw90YxDb8XxByLix?=
 =?us-ascii?Q?+U1PquDLbqGsJTQOawWbdoqz/lL3Z7yqE+3PaBge8Cw6vBrHv3JeX1yJgXeI?=
 =?us-ascii?Q?/8ZglNojPy91tUVJTd/Z1dUwpSvcarjcx2xw+urrNtP+CWmo72BXEt6E0Exc?=
 =?us-ascii?Q?rzyYg9O0gQAkcUk+lYKyqeA0+sdtcFuJsbF+/YkbN9dMY5tg2duiV0GaTY+1?=
 =?us-ascii?Q?TouXKEjAM0BHUEPm6w1gq+98qOtZUoRexLNSPYVALlF72XXhaRpKRBMMHT5y?=
 =?us-ascii?Q?9KoSOM+IQRZkOUjQ5jsoTy/hKeQ5r6uLj3gJMwetV2nO8yEh2K0k8bGVbeNQ?=
 =?us-ascii?Q?r43mtu6eKBz1JV+6D4RhfM0xPRNwLPqY4RbcvdR7NG6vxM2hs/FGPE2U9POq?=
 =?us-ascii?Q?9FIBTjGlFR6uYEm8EEHe/ZZ3tRCFjRPz0ib4lirvyq01tKJCbHxBHloMa6Pe?=
 =?us-ascii?Q?T/TYaTNYAhnr2PRs4UzcVJZdnvr95PHpf01XWv/hdrtp7OtVp41s+egGGPsj?=
 =?us-ascii?Q?Pf0iK1J03SCIPS4ZhXIhAcsP7ZK5lr0mtLidg4JCDKL+vlIPsfZvAnM9pQU9?=
 =?us-ascii?Q?+MKHGLZW7CbZmvK8uRgwUPMMha6s3Y667hgxg8aSUEPQNLhY4L9Eep86utZ9?=
 =?us-ascii?Q?OSqrQx/1diN2O3jHUhFSjww7xUMpDMmFJkDdwocO0dTemqd4kY0HJw1ca/lo?=
 =?us-ascii?Q?8/uDbAENwx40qe8cUfyapawOyb2Kvdi5LAxDG7AcHHLEH7wxU75CT4FiDzF8?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826fbf13-33ba-4231-24df-08db6025c1af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:19:08.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Om06VhYD1m+XUlt1tZTZRwVf9XYctWxGX2kBSmiV1I2YUpXFLexZfSifR2hK6r/tRDzvPp0BgUotVdjiKx00SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

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

