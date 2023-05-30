Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D9134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg/vL+ve02uNWqI/pxurrVNMy7WrNBthdunfWyUNwb8s/clf7khqqNnHy7heG6seWCH4MR8hhjqeaI5Q23VCK7idKpKFZiwtKGlD6EqfmH4JY/qiQHn0POqhQThSQWzcNx+lvZ2gOVF6ZpW2eXiRPuBYGR1LVKxDNPboTpr5Np+ZoDYEzxFB4ycf0mAsPj7LSgE5mi8F0O1n0hY0cQEzhTbdWHZjYavB3wElKiCgtgBmb11LT1/zqt6mz23CflaTw6647JDwpaIkvZW1gJoMqk9lAon2ULYpI14tlySA2Lud6GUJUDe2fgEpCx0oh7GQmkyc7ZEyGifSx/DTPLVvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=Adnhb2T8wYocMuw+J4HNtnEWwyOaqwxcoS5ch0kSLt2JT5bIQYqFovrP+S+4ClUJLjWSDQOITqp24vBY6mCL8N0jzkUo1u5V+A1nimOz9rOdktWCD0UcZTn/sCh7Dg5oPSrMSW8FU62f1xyJsO3NDzOvvtZqdFcueLazZu4HsukdGYSowhfKh1ugec3g0hPxKR9zP7Bnq18wroUXv1Zeta5o4xMlypuYhx8jGIblLwA0g4NsGEkpXmamCutF01q5ezHRObmxtfJEIDn4izX3dDPA5h005WZOnvLwQMuxt4n2pjAZpfjrZyxS7Xc6c+RLbI9q4fN7yuUMDC+0JCA5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=dD/FQ2xU4eEW0oGViYYuPdixSPe4pUbMB4eTABITGlXrzE5R+XGACTVLXJXLbOnbwsa7eKM/BpT6RD78FBpqK4SSSQKzC6Z2SS7e2yke3/fX0BvUF5+83lXOT2FgO+1Kt9/Y8dkqi+DBB0qjmArSZ41ETa/pMosll1I81FJRaB1slc7ULvHxhDiGMcI7cajA2E+QrezLlpQWrvkp9VW3o6kOOD+83SoqgXGnDX7tSWsM/S4UsZ9L4iE4OdV+CpgqGRI92cz3003jix9lBD2Hecbqsh6w5GdEy0MmasJuiMtJep7jkvtN95xVKtbgw4l+LPbgMKeq9dk8leuKb5/icw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:20:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:20:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 15/15] selftests/bpf: Add bpf_burst test
Date: Tue, 30 May 2023 21:17:35 +0800
Message-Id: <3be9b9fa90210c4543212c088bc7b4ebe4dc8ece.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a241bc-10eb-48c6-57e7-08db611097ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HZqx7XhDgvfW1JPQQHJ1eakLjUVAAlt2wn+gEY6/XaY6ImZVhUCerIz3LMF0yaNyXcAkoPN20bv5A7Ik5Eo7TcDFabz6GC+rA76FK3JfyG1KFQqyJNCUXNzQyrIrpDABxppEFz2eL2Fd8U2qZ2a3aFZKBrFcL6LaUI2zXbGqKrvvnO4kg3rY4/+LLju43SwWzVM4L2vRjjGmcUdXsiPmZTRIh/V1c2BJfvGpH2Xz8wzGtuNGMJRgujHhd6oI3uD1vGL32GSPi6W25VKO69LIOlBm4AFNtvm+vONNOJv+3hrzchVQySKFgqFpS8JC/C7cmzndrCrOcAn0vevrO8YK6jzdktu4+ltqHrg+SQov1rqXkvhwPd1uGTHnqKi2A/PaI7bkwNrG5azHG1v2L6/9c5lXui5GDGlE7QE3sICowb75kj6Mv4JTsW+17WP0OJ/K9UvCV8fgzR3tMGJ2ehxM/7UNf5zBRKqrYbDbahFBHQjoJ0dwWod09PWfVlOqAS/VUsY4Ug9gVSTBp1eM8R/iUvCbJN/mLLPooO8PkU+HdP1Dlv2n35g9wmwAn3ILFcye
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(83380400001)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UsQy5NfX9W3vRPOdxESXZY8iNzGqfkOwh6FSvvaGaobMr6gxLu767RXn13kC?=
 =?us-ascii?Q?SIBKp1p5COnkHw1Z69hlvWJi9gtOIFf/RocVZddFDJglNEa5Y05/oDMfS68i?=
 =?us-ascii?Q?vAob73UntBuBcPv7yZH5FON12bcJp/J0BgpqJCbmV940mWbnCQuigJma9CdW?=
 =?us-ascii?Q?y+3YmzNcX/ohQR4GlBjJ206nAIc0HvZPTb2NuqX5xV44mZkoXXQR+JG6CvQk?=
 =?us-ascii?Q?SaxgJWQjWGd+2XwAJMhMKO7RT6gAP01/4P9kOrbmRU6wHssP+ZSlcK/gOufc?=
 =?us-ascii?Q?RxzdqTL2jdHTG6Zo28PLQ6T1DyB4yBmkw5ih8B78ZxW0vMxksyJuwERa8N3z?=
 =?us-ascii?Q?zvzKAetiFbmwsNANZLcON25Qoo5H1uXFK6iisUOxG3P+yQHTqUGRELZOLZ7Z?=
 =?us-ascii?Q?JJrk2YOPEc1PBf2HcekFGg1OJf5vDPLyaH+HKVCK8/sycKV/auY8yHp7jekh?=
 =?us-ascii?Q?b7MmKjh6ASji1Umu/7AqQIwPuwD654GMql8kSs6G76IqSsGaUqU4lb5h0dB7?=
 =?us-ascii?Q?ShUVWaRapFQHPdjXEd+uwF/Sr9G8dZjvWmH7MfbsG2GmKViL0Ov7I/W4wvpk?=
 =?us-ascii?Q?DdM954lWh9Mo4tklxUsrwp8SPpnqIBD0luTFCpYYOI399egqNo/MECSfB1YE?=
 =?us-ascii?Q?BKMPJb+WyTQF/uRQCxOyPUcOLKx2c4KERQoaORGzn3iiX9e61EYjP/HVLrI2?=
 =?us-ascii?Q?/lS227I+pe0Q4lLLspEzVNQ5qKgyuAxT/2njD8N0ICXB8AjOaeHP1f9B9XjE?=
 =?us-ascii?Q?U1hEhee+si0LY1ZRuq2TYEYDQQi+mBLAoqHkQjYzBYhDuac5oKEfYnqflthm?=
 =?us-ascii?Q?0/ZKdAsZ8F9kMnlGGTyDz1rhF6OiQIxhlFOJGXiKEzrPo1phiVBBEIA3ekvz?=
 =?us-ascii?Q?T8xz4a1JOqAiiVd9bggMgdSJejnthgUriJ7hLqzJpce1XkSahGot28aBIdqB?=
 =?us-ascii?Q?ZekjzJhUZfBkN50DsMR91ti0echakt4su7jJGCQ9hTeqNZI8TUrOaC4gpo+V?=
 =?us-ascii?Q?aR9F6P1l2c0WRva7OH/XVG9p1c3BqpwTPkF+6nI/uVVwOccXZot61AM5ASwV?=
 =?us-ascii?Q?dMR3yJpcyJfDR7+02xRuOOZkKE8gxuO68HVc0S/fe03fyirHLJGm9mM6OeIL?=
 =?us-ascii?Q?460COUrBOQTDihWVqiIhwXMxbYLu+Kus1AXDfEU/mlL1HjKTtw6QpwGzydT2?=
 =?us-ascii?Q?DBCMMGUZLRd3PsstLxo1N9lljQN8gB78PAXNEI1b7bvsodsUZGH744Va3yRV?=
 =?us-ascii?Q?uoV8cyY0qmp+5Y9yJzYhQ/ob8LBjMJcnNJAGlnI2mdQGuCtRRh7mphsX2RPN?=
 =?us-ascii?Q?wGKfSNAs2JoeaCmP2C6hUS6oHgTosGgIPQ2HeBY32wApa6K2rZ8gxz6p5LvK?=
 =?us-ascii?Q?aGhh+iPdwzYSkQ09SuRpgWNXlMrVBZVBXIwMN94IRTkdkexDlirT/MMYuSa1?=
 =?us-ascii?Q?IgReIP9Nqfxm5jtGgouqxooPxawXKqh2DvMaCdHdvNx7iFPeDUkN323N7DVC?=
 =?us-ascii?Q?iBJePYiTzd2PpcEKTazOBH4a01kSIGsMEDNmzSy9asWIELOn2kZJvFHp2nID?=
 =?us-ascii?Q?6vJMAohB7RnDtDHiGjS/c5EdG1cYQtQK8ogfH5xl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a241bc-10eb-48c6-57e7-08db611097ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:20:09.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAKo/JnKj6nlNMnuzwIaQs/np6ZxH5LpSoNeB76XHg8UfFSjhXWzHZqOQ2o5nl+XjyZAlQfEp+ROTaZr3k/wOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

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

