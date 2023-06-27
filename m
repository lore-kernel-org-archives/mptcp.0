Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7966A23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDDrc/Mfzl61AQLg5X5wha60/igPeG8Pwh7QFoiJnmVadSbgrLREdRfWRndVgpU3XywzVdySzCE0442Hk/Gj6JU/Hog0AqYq695eb2BLuyI1303bD9lpvaZs749UhoYnOT4YTlOHC8pHvadVyXDGEyoopnb9DKEZy0xyAeY5p8mnbZQ0285NUl4REjbG0ROPekox2V7IZwUPBC9STCJzh/xWNdlthGfJtonyfXzPLDhBQI682Ib4De7Br8iez9nfHcpuBra6uFhqD+dPR9Ya/SnNQ/Uk1paZQIQ7uI5tMaI0ox4QeIbODgfYpI1MayAvMwiuPjOoqmmvA40vZ0chIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSe0BMXgt29KWZAt6u0X+N0qZ6MkkdJzUYyFTBv3J74=;
 b=A1e2rmN19A5Y/pgH7p3nzRX6I+RvWEMI0M5nAeC83azHTagH0jfbDGy/9TIshdVz8a8Hs0elp7+6npkLPwZujqglYg8KcnTml+yvykPyKWFjHTFIi1bCFteoS3NNm2E85gYW/RMuqibPQ1NQG8YMGTwENXcSa2Weu1pHECPEJryNbuipnvEMiMR6nmT78WzJvTpKA8i93SA55qw3ShT2gmjcNr+XIha7Ear2yLAZsnVURjdaViP+azqV7aKo4K9pxWLJGyoe5WwsSJb+6ZE2cjhK3fC+jY9sl98yxPqlfXaYsrmc7RLIwDiOnMA/OPGqTJ4Xn3bbibW0FPQnf2yazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSe0BMXgt29KWZAt6u0X+N0qZ6MkkdJzUYyFTBv3J74=;
 b=bPwkW+rEkukfxHtm/VOBJ0wXokhH5qo6tB28gWCCsTnBMQr/mH/MUIRUp1cX8HY/MtNxw5jo5W0DfABPdQMUvZcgAFEVbhxnpzVfK0dTIl1q5Bc069HHMtydDhhUKM5RF/fD07OyeJahBP5dhmDWBmOvCh3y+cfH2VhqmogrwhK1QWBz6gjcJoBiqPs7SIxbkgeO5d/YsgF3B4nz3IluP1eTip5Y2wkg3Niar+HQJ5Cdqss7PizN5skhtF1cAtdIv5a7groAvmVFY/HAmeqNLEDTNOT7oGGxOJkz1QX+ZZqK0x/PgncqBd8S3AziHTQDYivePifgfIIuZdMOWBusgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/10] selftests/bpf: Add bpf_burst test
Date: Tue, 27 Jun 2023 09:39:31 +0800
Message-Id: <d0ba7d12992dda2ebad5b93b201d43971b59e265.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a89f75-8558-4256-a3e4-08db76af8ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hR/Sq4aXwM4jOL6aTJO1cRE1ii8QnMZFfV+Vzs/ERZ1FqKvKJKLD0jGS9DsWDqtA8WMda8NJC1VUlXhEUE2fw5WBU7LGvuCNBMYPprByNo5YfGgutlA2AyflLh0sT8zIc0PAZQz4n4kPHZUk+7dStMq5jvUtlFhEUTZkK9GpeHpuemjLNyVzBXXSSPiGr+bYq2IflE5Hi71OCFOBc6QeZEEBt8MpWM2EYLrC5lXvRE9BqQXlIvNkr/RIg76zHX8hnTEXtTklEyqP5byXCRzqUcX2vUZ5qQq/jv2BMENe+eb5stCq4csT+lgCtg0XNnA5F9il9c1VRkYVh2WspHxXv3/mW+vKpWi1pZh3zNrccUEGEq6D6Ec27OldAeMDGeHy+4+PTA3Xs0gGBVBNzzL+0cwBTfk7Bx8nb9eihydeayD/e3sbktZfapp7KaShRNi/VkG0bNjcllVe+WHSVxkeDJRVX66BxenPtwaUbjK1eoNg0jxo1qVL6tTRladrsbX9OHas9IaXtfDCUNaDk6rrLZb/6OtU/3YLRmZ+kYmiCWG/qIqlAAY2FXvRnIJLTiNK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AOnrtEhXMH75KaHIJgXoi5jrEw7VUBmAmzZgrNSl7AeoB1ee1GXMymZd3RLL?=
 =?us-ascii?Q?i9st3DL2lY/N6NThl34xjMvZLYGV7wm2emlhsB+evnWmxaBW0XIN8+/+N0Ci?=
 =?us-ascii?Q?Poarz2P4orIXAdiObR5kIBgfENP+uYIaAQiCeZtyi9L0wXhhKsIRA9wmLrbL?=
 =?us-ascii?Q?4nDId/tPqz7Ln7XOTtzJUJ/TjZAopzYlyUmsDLC22yTHMwvFj1Av3Da/0LYn?=
 =?us-ascii?Q?ZdpLZxQgol7dprwYO0q6IoednU8PLe3sIEAKsftyunBk1fV4JAbJ9CP5/kYo?=
 =?us-ascii?Q?KgUU50PHtYguqQyDiUUDWIyr3oRBqwGweBJipFuuGQkHhkhgFznizg3tfg79?=
 =?us-ascii?Q?9XGpJKeAfa6WgEqULwVtYdQprp4GTZyWE9hUR7O1DvSUn3s1e5wK42UrdLi3?=
 =?us-ascii?Q?fx/VSk47pjfcH+G0lcucNaIUZUUCNimGUFq1e9wvxMJCf8bSI/HqoPvBn+op?=
 =?us-ascii?Q?WfDwPrQ0adJd5Zb9piu4CbvgFiQHU+Q9Wtj2XVeHLvglC4bE9e0zMt45Y4P6?=
 =?us-ascii?Q?yOMi0m7hLfCdPLhS+d4mVFVAXQ0ybGq6JZLSk2iBA3jhwLif6r0lv06AKpyg?=
 =?us-ascii?Q?aJZ3hPEAiba1Nq/cFay0FA0WWzRyACvkcvXWTMxWuyDqeQfpmVcc7W/982q3?=
 =?us-ascii?Q?/WVxOdENwx+UFjhS232D5M3ABuLJoNHjRsKVWauvR8qLGakmkTr9QxTBPBn/?=
 =?us-ascii?Q?7eYvRTt+iC877P6D69TTnEidFvckstjF0zmcLywoU+U7+hVk52gmfOmHdHQO?=
 =?us-ascii?Q?kbeht653ePiSa+GaYWkBFWkPwCcBIdbQz7IfICZceJ29tF6ZKROkqQjr6TCD?=
 =?us-ascii?Q?FlkSqGnMI/94RfKdNcrf75ZWBF4VrMaD7gQiaudWYbudMOuJqPrQ5QkUYIlV?=
 =?us-ascii?Q?AiElaEWchUoXuP+zIBa2MAzWaNJUkcjjZBSbZbDD1GuAAMy/qVKiPyEld2ac?=
 =?us-ascii?Q?XYCSPsCcu2FaO6SlVkEU6bophONrJw4U1xqD9EYJD7JrSPsiPOEMLq8lK29E?=
 =?us-ascii?Q?pl5VkFAWtnG7ROY73u00NodfpRODNSLC8x4XQW8WZ/u+gPpbemurQTaV2ftt?=
 =?us-ascii?Q?nCReaSCJJJwS5CIx6Wanq2GSC8h0WQGiOh7ktmichoHI7ZvoSZZYv4EfvTO6?=
 =?us-ascii?Q?Te0Jxd3IxouHiiD4nNo+afsZ7TSGh+5emouAgdQxp5aHN52mtJV0WfOq43JL?=
 =?us-ascii?Q?4Q7eRR1/viadqL9HZ8IeSHL0Ru2LEY6USl9Cp3iDF6on29FK3FVB8fCdNxkc?=
 =?us-ascii?Q?IP9PTXsTGHVidtX0+0k3kqv0ljjdJRFPV9ZTKoW8ykdYN+DuUM9cH3kGumGC?=
 =?us-ascii?Q?d/biiB36YClILqF5Ofp99KBwkf7Gh/hgwbFXF2U2cGLqlODNT9I/ZKjYVMx9?=
 =?us-ascii?Q?XKtc1VCsnGmvsnDWb2nhsoA6YKtmRbBKDTx2Rl6+1SBiYlHxGRI8nzhB6aNB?=
 =?us-ascii?Q?oo+oYarJvvr+1hge2pwum/W/MnmZ2kFHcONZz4iF+iz2BRYEKi7/ddyCYPEo?=
 =?us-ascii?Q?jsFj2gmgx5uVOfOnzSTmqw4P1fYZ7Ch65bnE302Z/l7LzBVuEiKcQK+hfCys?=
 =?us-ascii?Q?avR3LJfwvi8rUxMuPAnU/Sc9y0C1kCqukWrn2YXa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a89f75-8558-4256-a3e4-08db76af8ead
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:59.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5NWxfFGiwo88D2fZHzOs3sN8AMtvt2v/TrPDmamBgK+W5ThOLuJT4z3xn2Ozq+twzykOtT4iZYk5dfEuxP8fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

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
index 851ea32dc1d0..43c0645ddc2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_stale.skel.h"
+#include "mptcp_bpf_burst.skel.h"
 
 char NS_TEST[32];
 
@@ -524,6 +525,41 @@ static void test_stale(void)
 	mptcp_bpf_stale__destroy(stale_skel);
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
+	send_data(server_fd, client_fd, "bpf_burst");
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
@@ -540,4 +576,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("stale"))
 		test_stale();
+	if (test__start_subtest("burst"))
+		test_burst();
 }
-- 
2.35.3

