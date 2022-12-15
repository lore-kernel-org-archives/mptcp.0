Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A7194
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 12:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3IvER3hidClqzXg6H9AS/N/CCs+xRgMau3HR0fcRrTvr19EEQRnKJd4xpLuyCkH03BqbiySfGbsl44fMTyFTwq/Gmnh4MXJMzSmpAoNoC3Zoj3ZWUmyzEQ3wlrB6RjcbVDYW8BBmS5MD27etO79DbwtId4QTh/+q8rL7TSkRQeYGpnGAzrfE/eiVtEdPClzRzd7GWO9tGPtTJrTDe40BwekKgWx1RK/EdxDF0kLst3IAG6CgK4syzrgVozrhNYaNNiyiz42ubsR72w29/2efkYktu0qpkWAxmN61VPksqO/229JiV4ENGMgKZIx3wM2B3YA9Z41n1FZjHKbh5OlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=HhyoJsi+EFKNwD4jaGtnFksegUwUO4Z8tLf9FWgCFC8N0GGJDEL72OfQRKBDDPdeqKXzP6SZwOVEHNgICQSG+1jKE9k8gpaoqrMlzCVxVGL0E4Pox0FcFJDk0YOe3ElvtUVWyAtKyA+UZ7iQ/yW4vz/eK2sRwq0muju1SKPJrdRJpk+azchgeRagYh2cJymRx3LU7lVudm7O+cpTPtMNxd0PmDC04k6xjnjzmdJ5m8KmQlX1COuHmmozJtM5EjLM/7upp6zsGx9ZnIwic1ZkwR8nqMeGlftlP7nu4Ukw7S64dybuA245QPZ0ak3pZ338rN/q76FiyKTkYKpSue55NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=ph7N35xUG5Nvm/ShNhp3H14lChhOPSu1YqxNQK4y+khV7aUJFIzpY70UVG9alDj0c19jPzt6YgQ8NWEF8VbywO7nveXSA5fUXLxqdsj2qWnaJsMC7ghly03kB52cEljeLabzREtMrAwiaCoF5ecORVZSBnovHbIIAs1iE1tSKurImiZ+Yj4rzAbwR884Nz5pvUvQQeYrpmhBAb3Ao8nhnVL8i59V2tMqbE6ROooh0Pmk/kjzmjCIKNcYiZdwEFBWG9JvMUh28v7Z88Rn8uq1+EAfVt0rVOZIYmzh7bu43Zg3PjWVR3lRJey90BbtAIubd2tT2qxE0+rOIG1pB9FH8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 12:33:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 12:33:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v25 5/5] selftests/bpf: Add bpf_red test
Date: Thu, 15 Dec 2022 20:32:43 +0800
Message-Id: <f2247b8c80e438b83f1e8d0340023bc726e80693.1671107241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d98a80-2c59-40d9-c5df-08dade9887a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IXL6SwJkHvlzhcLP1J5CFJ+R+9KlciJrKSFWMODwxc+CE0npLccas/vyb7zSj6kNo5IFGxo0m6Ba80GoRawhFN8bwAEBLG12e63uokun+OqysIl6ugUo0JkFbl3z0CNHvKbOS87N2oeA+pKX2drBVAYc0592WIPQr9BBNWt2VvkHpNhQRmk89LkyksHRu8dJiOX4FWgKr9Wr2XUmQPdi2UE3nPVbHTbcFmyTqK6M4r9HAZnobVJrHHN68n6wB8RtzLcr5fcS8+wGgaWm5BATcg7sunCmlKdroXaYq44T7flDVaOI5pT38srGv6/Vwlu4dTv2lrcKa/H7FLLuCJtLbxN2IoJlmGgwu202Gin4Ubev6+7Bl9KyP2pJzmOMM89C+shwTR/Gh1N5fKEOs2c9lT5ZOVEkpypD32EiZS5ucZGL5vaKdg2rqRxHICl1MydAzq91UfKBmSKtGa8LgDzS6fbYlO8G1IzaaQDkeKZa8wOJSa1L2WqWIUXhxA4O8TkwSiJapahCB0KPXFzQ5k1RxZ++CQd3LovOI0R65avNz7+VShWgXMc6BnysnTl4vWEaSgnn1ifbCeiANDW27RCgExvFqjFqiq71PF1J+i8xqvmHG58vCxQlQM7C3yu22WjG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(478600001)(36756003)(6486002)(107886003)(6506007)(2616005)(6666004)(2906002)(44832011)(86362001)(6916009)(41300700001)(186003)(6512007)(4326008)(83380400001)(66946007)(8676002)(26005)(66556008)(66476007)(316002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bk/x1zc0hSWL7wJ1L/sgQdfPAf0T+y18W+SFe91jAIlYOfTnUGqzrXsdM+sg?=
 =?us-ascii?Q?UHOS2eCUshdSrtg2KDdENY/t+EcR3lNcTlPoldAo9nvCWGFQ8x+a66cqyv5X?=
 =?us-ascii?Q?7IWbc46ZXbxJ2PxLCid4RZbO5F0LCXsxgB1PhwPJdcIOGbwsBojVM+N21yuS?=
 =?us-ascii?Q?rPfKZ06XRth1DyMB/1lF6VvMjYaG3ObtJJLQRS4DMCuR7datWYcb3PVZwsQa?=
 =?us-ascii?Q?eAaM0I0zzyAMr8pRxHidyWPMC3xinxgZ4LcZNExY6H8oibsP2XWTG2lHv8S+?=
 =?us-ascii?Q?9ZLZO8g+T6GuQSbOFK7SMU1Xm1O46/0HX56D6KdciCvPNYBj0dZBBmczN3//?=
 =?us-ascii?Q?t4UkMWg+Xi4CqyP6186Ukhx8iYdQFDySNbMyA2/SAOOEFqX2EfmxkBM4qfRb?=
 =?us-ascii?Q?TqLlpAR0rlviv60O09TyFkTlzf+vp3EPNppwjQZeYikJ6x2ZJT63QS2rCDw7?=
 =?us-ascii?Q?6ErVn8WbUcqKYOTHhYqNH/2YCcCoDFz5H9PGew5/X4rZgQriDg80AWfKXXXI?=
 =?us-ascii?Q?Ptsb4cA4U9PwUJ2FtuEq3K9k6Of9Ori8f1DbtdhYMQ4CZ98AdvwwXcV7lWF9?=
 =?us-ascii?Q?WlMGYWsqUubZGzXFOft3yMJRZenztB6br57EFWnogGLyKYyuepuSrtpXEbMA?=
 =?us-ascii?Q?BgkxY3f84E4iaHe52DiH3NqVFrKsybofWxyg3ikTV+nEycB2Ow4ZMszSPCK2?=
 =?us-ascii?Q?BDF4hq8Iwl7PEKMdq3KHaBzwTIY1SKfIw73hk75Q0GqSVa535wcUnnDQ8ADW?=
 =?us-ascii?Q?m7wzfBEpUf4dBHCTlzyV4FFAawiuK0X6OHINLV/6+habb7XDmco1gcPl+TOY?=
 =?us-ascii?Q?uYGkwB3viwDeb4yI2iwtXEB3LXlDnvIcqapZpDIZplNKUM1my0htqhsE7XL2?=
 =?us-ascii?Q?lPK3vTmDWSCeWwcs0Cx5ua39LJHWJzA6EjNGeojxgmw6k1ZXwTzv7gfT8mLB?=
 =?us-ascii?Q?2g79aq+UqHcuPFDLrdwOTwXs2IhMPWPlW0FI/KOmNuYc2roflYVdMOla4M1P?=
 =?us-ascii?Q?D1FUIb5ifECckkXJu+YKA1EcjKZpThU538bEbvHjYrmErUUnTyvk1QAA15k1?=
 =?us-ascii?Q?AzROxmTo09LZARRzms+xVcHpUDktQOMPM41YgGmD1jnYHox+3+o6Akd3td4K?=
 =?us-ascii?Q?5A1aO849rWxI1ciWfRbG+nSX9OY3NmA1ZRDFrkdDC0McE9ipocynm7tXYlc+?=
 =?us-ascii?Q?JHMRYG/iq6Cnt589oz78PBtGlu/3x8ayjjx4lmcWxtGuVlhYdBbSoYLBa8+Y?=
 =?us-ascii?Q?zCNbB23dnBjno9t6V9fzoT0RWINd5jKRcC/9tnGBY6zL6Z2dGSxd48dEHfoX?=
 =?us-ascii?Q?KRyilbalKoUjr+F4L00LiKmV4pTH2ARXnUDVDBkxJIkSuZAD5uKgv0lrhqH3?=
 =?us-ascii?Q?QxaEyKM1r5yO+tRhfoatm07UhsxVJY/qZA2FCldGeOsqIbeZZfvPF9mq7jQw?=
 =?us-ascii?Q?Gvty6Umrk1oRyrYCbQYs804Fd+dDmOqUGIZWKZtZuXCzo4BNEWwlblETTHT1?=
 =?us-ascii?Q?gaXDiI/CXUdY6IffLdMbG8OFdS0bDKZ9H4BYgDPEuiFj/0LflhLnmPAI7gmw?=
 =?us-ascii?Q?7C3ozSZkyVSwObIP2yesqJrGF5AIVLLgJBVkE9BRuw27YlTj9S1sjlnBntvm?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d98a80-2c59-40d9-c5df-08dade9887a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:33:11.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jean1xAewz5yiLCLJA0uS02p9/X4ntzZVFIe/mrfAEd1IkqsQs4JIFbXpoJ+h0KKB7Gtyr1TAFJHLwC5nj2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

