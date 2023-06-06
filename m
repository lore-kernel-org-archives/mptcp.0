Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337B125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDBReMij0lpY/P6FrQQSLbg7qqOTQRV2xrgBxQryVgTiEEvdIog7uh9JNktWd+KjlNPUCIB27pIXukWdDhXqlrcXC5q6GXGwa/4pr/db5pTVYJ+HlK0jcNb0oAO/yvIirWk6/EDBwNw5TaJF7PKz+i+GXZqqYFueyF/n3CrmUjdPDrHYQBfrOgQazXd0N7vPcj2xb+S2URjpPa+j3VJzIyMteey36oMedux5cQVxUtddPwsF3bCLKsAJbsfQ4cfACC524TgcWI1DwUgEOcSc/s68AxGHFTeRb7WwOeQUJiJBZh04RVgc/PUyPmr3hxoMHmylq3yw9fGr77RX0KZxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN6TXIcWdS+ORVfeL9aj/nw59t3Vqhtb0FsWc6gWKpM=;
 b=aGnbDrXKfLO+9xoDStdB2/hd3J6rO0ejOalUVUdvWwfNsAmsr9SGGkACJnacRkRrVz/aKqfmsNvgzm0t2A6AVQ5bk1TSTjmRKDATA+GXTzNH2BY/SoREP6HUwxuSODZfn9AXD+v1lV2iNVqy4Z947jIOWMrVX05V0268SLFvNTznO8y15pMDAC9PhXZ5iKwXKGo9kjZ/GgPgcx1nxjaqmaqE34V00csjWwMvID2cpdIpYZF0t6bavMkVV9He/BMvtPynbNY+rwJeE8aKt7/hKLkxKSTylFfl0yo4HHEPZnXq9KJzA1OcvvURATXfc0hQ42ElV4/M194CcRbpqWUJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN6TXIcWdS+ORVfeL9aj/nw59t3Vqhtb0FsWc6gWKpM=;
 b=XYhZ4M9poRu69LCz2bbwJ7Vy/iEaYXm8Tq4XniWMksjPvOGqwFBoNYFZI8qlL2Fx7Ne+5tOX0+yk4zlt3eUfHtlcuIVB5g5O5gLZffr5McjPVgFnMIUO8fg1zP4cvyEqxRo9MNhAoNfvSA0+Owy4weKCZlOPXy5E7iu8v3rjCl9Gbya6zQ6tezXtzbztXZuFZLdfmgxh4lpvEOMNOIBWoIQc+vNVenTNCcKwP+x+yXtqPjEeUPXR4Jx/hkvmsiUIThsiwjmSDpyZnsvKmdIXd1cL0heWlsZZwsEyj1xxXm5vIovnMqotKiCgW9lFQavs8BiLwkGwvpcWpo3QTrUytg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Tue, 6 Jun
 2023 09:03:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:03:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 18/18] selftests/bpf: Add bpf_stale test
Date: Tue,  6 Jun 2023 16:59:32 +0800
Message-Id: <1cf433961986135e884dfc35b981c82ec6a5f528.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcdec4c-5dc3-43a0-42c9-08db666cdc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8YwvJ4h8rnXEklIfscRPNorC312AQnXHW7nMyjxzEsZgDkmRAkQFuj9t2AuEKfyJmlVQMXSqgGKDRArnbgyy1lwUxmITMCjsG/qZeXnosl5tLdCqMM85k2rz2hkIEHygqI8JL2S+eKzLsioRt99M/emA/+uGsowAOPzIZJ8jLrrMJ4cDTL5E3F+0u4kSzco8xH69LvaLIzedNLiwNZ72ybMZxAkKWW5JkzWUYAkGGgoOk4FVARdug8IRgGIdIDwE6x2ePSNSNS9wfbbbiGr7UopR/k3mLKXZTDimn8xSDOPf5U/eQoDSB3ZiU+JWYnx51l2cZQoN9Qgu5Oe1xoUQCqCY3HjMlWWeWV6wuZ8nGBTRW50M5vuzhWBjnAXWs3QwBcFvQBubSlyodNWy+Z7RSEQDhgXvQxRNZj9UOKEXPql50HQZyV0EpN4FeccwyNHf4gG+CKkDdKpVTK3wxSCJD+W7JfoyYoJgITrpAFLQ/YG6CztJcfzL+6kIiXo5n9Ukmhk6/mhjs094viWSmlykNjqPE8UqaJNLlfgmknJ6UT6UB87kOx7MUI/X6VjtVVSB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(66556008)(6666004)(478600001)(66946007)(41300700001)(6486002)(83380400001)(2616005)(36756003)(66476007)(26005)(107886003)(6512007)(6506007)(186003)(86362001)(2906002)(38100700002)(8676002)(316002)(4326008)(8936002)(5660300002)(44832011)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cz80pOsPpUMMVaNh/SO7WQh5tD0PIzvRlKqCAeAwASbzuFa5CedUR4VqvXmf?=
 =?us-ascii?Q?nkVIPf7GxQn+KuJa5ngw9Ylp20oBhq6hfS02ycfsLLJ1jouwLS+eQ97MltVZ?=
 =?us-ascii?Q?jeV1wV+Ua/P4miTObyUfo0PrfAt6mPQ2b2X1Eo/IUC8uWxEnin7SvxfWVpwI?=
 =?us-ascii?Q?GOzSDqMxcRo5HA+MLVRDA8YkbG0vkm0JN/GyZS+sSWZqDc/t5D1ddckq5VHX?=
 =?us-ascii?Q?C92OEoxrrBzfALRKmLdiZDswCn70we5RSDX5GoT0H7PbeD7QJcs8dT9+t0bY?=
 =?us-ascii?Q?wGWZbaa3p6M1xGrMiWWwBBx9CRZWpwPpYU1rThBz6qAtDMK+w9EWIa1+hNeL?=
 =?us-ascii?Q?Ke1b6mm+/BJ8OIsAyTizLcO17kR8YUAuGQSW+Ekff8umidDzELdiQ9JOj3Tn?=
 =?us-ascii?Q?NnlSykDMJxKN4AO1IdAjLWalypa1xkEwH7hz6NCqNq+ndJDvYfiOqLCD1f5W?=
 =?us-ascii?Q?w+KO0/VkbZDSXkGCoHCGEwB1qeyfGjW7FNZ+AnRKLK1ti75Yd13f4WuIBWZc?=
 =?us-ascii?Q?sd50VKxplDUeud6SvKGMRV9jjPyR9igZQz7AfTFcPiJMmdi3ffBjOU1PxYXS?=
 =?us-ascii?Q?/DQVx3gjMD4wDdjiIqbbP/UR+BccF/Mxl7c4UqQFO+IRxJlHgCVJzE6w0Vj/?=
 =?us-ascii?Q?GSo/oHYvUiX2l76MaZWdLpF4qwPxNXBAHwx1SSBviJk1r0QXzNYpPvuHUAL+?=
 =?us-ascii?Q?pfMMIpKh2LO5x7R4+R372emF7L/fbH22AGrXRxj8p/rBFiv8ruMw9i0SkkzZ?=
 =?us-ascii?Q?huwzQAauG9+rfmENtr6zuEesOC/L2Zsg+FfZu4ejIRFKDp5K4WaclDyvUzXC?=
 =?us-ascii?Q?Xb9Y4I0gLarEgG1/02jRF8cM/QOBZpC3d3HK8dX+SF4xo1aywav8dDdsltwP?=
 =?us-ascii?Q?bDWPzrNQyIW2pugO8BzcxrPnstkZa48RjnckbYclHDv9kaXQKAHdMAKHcVCp?=
 =?us-ascii?Q?cs0oDLOSRHYkdtPOng9+gQcBs2YZT5JR+i1iv9gliPHw8MiFjDwty1g0wGIg?=
 =?us-ascii?Q?ZPHdSYCgXulbBY27bnm4KIa/GDsWiGjNQpTg55ZCpPTDG3AUWqVAn0MhpbTc?=
 =?us-ascii?Q?lt82NlzE5SwnOVH91XaSpAamxNemLcqsK5UK4CWf8YOt5MbjvoSNJ87c/qr+?=
 =?us-ascii?Q?//hlOnMqXzlSTOuzcXGZU1VQjfkSYme0gJkjS4/u/q+OHWQqOGkvWjCAlhk3?=
 =?us-ascii?Q?8M0JdBtGuq0iKgUiNmhTG4nLM/PIkJb5eyVAgTFOsxyXsqm1L3mgd19xsNIu?=
 =?us-ascii?Q?aab6vBUie3TsshtsPEHX7aPmC+TlXsL4fKHWbYUtamdetJYL9+5UkKn7fAqv?=
 =?us-ascii?Q?yh6FEZOs0/eNUZ254O8wmocOk6Ps/mme0w7GcmYsxKn+fN72/YthHxPT+602?=
 =?us-ascii?Q?/D3PoyE2kUehixLKhRwfrzNMKCFcYj2jCMDDuhEkCcQ5R0mxLlVWYg2asL7T?=
 =?us-ascii?Q?zNRSZN3lRR8pXBe/1KFHB0GA92W3q5+t4Tci6ah2eDdIeqsw8gw6qogv+XHo?=
 =?us-ascii?Q?GHdaNo2ChQcHz4PMocpsT8ZTpgFYo1yGIfqI5g5Xi0nxW/RseN+XfMXDCM6y?=
 =?us-ascii?Q?7BdWfQHu84kNNELYwvrpyugghxRuCGrJFLi+atJF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcdec4c-5dc3-43a0-42c9-08db666cdc1d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:03:13.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGBsBnhx6+2dwJfeNxfkScivocItWvGzt7AHjSg0Gr3erZ4KzysH/mRZN2t5Ae1+jdAeTxCc3JRMX5a0SMWe6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

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
index 750e665f451e..227fe513a580 100644
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

