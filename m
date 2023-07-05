Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51610FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO26PNy8828bdglG0r68kZ//8FZeqjTunAdMRJyBqooRHe1uaDEu2Smfzz/NjpqWbyPMkXZ1nwK3OKWP5SSQNRzTx/KoPOVOhn2yweyMdHaZx3bl5an9Xt7Dfn1UyX86YB7TgOY2GLpdN4xfd3n592K8MNLMPZbs6ik2Z5hrraJFFgFNiu2QTKHjYE9HrAE4ae0uSkeuJ8ERG90OglCJap5hV4tej06h8O6IczoKas5SMFZYKnMW+dyU2+mfi+g6NkQWNvm28pBW/XolQHPuUq6kf6P2bz9cJRaHmdV1Cd0vwlQzCJBxbOxmJGZrD0i6H6KU2eE5lVCV83EtPAvQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br7yelnj0N2tUJBUeoo6Z0Y4IFjnIPIoTHsdRWjl93Q=;
 b=Sz2vc5nN8sX1TUaKp5Qfm26SK40gDtbxShK7M2gwr7drByRcbdeDB+jGpz8LQfyHwy/QkFb57cNZT+1HselhRAtZGnjKq8xGqxQkARDHXEbyJi9ep7fF88eIKkS7O0z7rDuiWxsLScv1EUfUhlhetkZ1q1Zdmh5DOf6LbbjsbAd6kDb1XdVQ+0wrmsIiOyjH6H6rxpm8QCGvC8LfhkcJB3dbtV0Mv4iAao3t4KbW+O9Z6TEuoag077TAZUoX5aSdds2GJIBf6SpNBxxiZ4SYu2dJYYbC8Iwqur6wnQPy4rY3OOHWestmLz+5eKeZhxszQ6TN3Pq+g0ubJoORM+MyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br7yelnj0N2tUJBUeoo6Z0Y4IFjnIPIoTHsdRWjl93Q=;
 b=zw3SA3Tp409ZCFalXZ2N3165sYeQXh9cKKDHJ3Pbm1I9+vxGXVlV5apYLLDcMWjSqK1Q9c+/7Uksco99U57a9pFPxKiQeb8NE9kBXup6/5JfQDyJjKpxOs9JUJoiwi1fqFNwkPOfi/g5RR0useprAkH+Q7tW/WHsm9P3qdkhSLBQgtvWuXtoDfFwghpxoJEC3VGVs0MAFcuYry/K+ASgPIIVDqbeX7oY8vLm8hHVaobETk5F28eumDUMbEzIBn9HbtqdCl30215YC6QH/Zp14pLK9v9M5pNVpe0hNSU+POyNyLtl+EjEb/ZRANocLfvMTkMy7NFmr5U+Ro1T+7N4wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:57:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:57:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 7/7] selftests/bpf: Add mptcpify selftest
Date: Wed,  5 Jul 2023 14:56:41 +0800
Message-Id: <9f92e80f8366da93a7a00930620a0ea47777c0b0.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: d4687f83-be7a-49ee-b020-08db7d252572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1PanYfGH5pi/I5yrnu0P2Jn41+JjfyAAzK8DY6e8Tlgk0y7UED4Xd/bjgPUCtAjc0rnTImq/wRYBq3IDSoKFs8gCyF6VQ5nu2a2WAW32F7upiCoBzh2wZDiKLvzKyszxQgVhyfvgCT4yl7hqG+7IqF4HKDqdMxmBjuA131TlGxzw9ezQOPw+6ZhmAtwfm5tRmrLu5+6MG3WwWxwzmziOzeVcZxvwBqi0Z9A6tc+KoN379CkU9TG7uVOWil+u5Wlxv4tOOxtUkB1WcJHYvQRhecaiVGJhM8XE9x63ZSvnryP3dS8o2hqmW0hewSMDj+IIrSy0Je+9IKIoDvhU8beRdS6al6C/jUn7Cq9G7/dkc5Wcn9DF27/Q7Dpysd4s9BozwoxPn5JcqJmcWqW0hRZJ4YuFD3JGgDOoaQptYIzpLyVsh7jWM5yS5rqs404D8RrTLThH6KArYk4qb5SIE7yMfXqJy7twjJNfVzaIAEjHqN17KvV6qrd3d7SUd3pPMjldMZt8v1tzZNQdw/394Qfpo41sSRtPTsl7Pu08h6Ck4ElIo1ezR1BaP0jhp/GCbNz0F865sNl8APW2qGhiRkAWEGVICW9s51aNfAzI5D21fjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(66556008)(6506007)(66476007)(6916009)(66946007)(4326008)(38100700002)(478600001)(41300700001)(107886003)(316002)(2616005)(83380400001)(186003)(26005)(6512007)(44832011)(2906002)(8936002)(5660300002)(6486002)(86362001)(36756003)(6666004)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iI26g3Ut5PO6Vuq4DVlmB4OOLj8pc4A0VjHXEQxEn/5cLoueAvJOZUs1mjoc?=
 =?us-ascii?Q?cmY9ll9VIDYPKbx4y5aB7X/6lLcnrjK2RaCR5feN0C+PUKSdeWyNd/cTA/mq?=
 =?us-ascii?Q?ahwr2tBO9D/A8twX+HWKJu8RnE69k94+3JBzkg7hpS4DhQehVfBDB+TvtK36?=
 =?us-ascii?Q?K9/s7m8sLsFQs+Q2e0Ow6+TU1OkGX0igWf+InqmQ52sil7HI3oQdLJjIjhpF?=
 =?us-ascii?Q?0moDogZwPYUGuBiTIS2R3TzD1RSHD2MzavxsXL4oDyJccprZbJxHRFFt3d6B?=
 =?us-ascii?Q?b9EI9XGDOIoNlukKbR3aXOMsdNFGlyoUj4rv/Z1hhryLgLJgAm1wGBoA9MzL?=
 =?us-ascii?Q?qaJ2KloEl4wk5PCucbWgO6857n932lMVi949xd2xxUbHSeH/WmRg4GqOElYa?=
 =?us-ascii?Q?wH4n5NuopTO4monMOg4ufc8RAyu9RQZcZPbmQpefmTPt937wA5CIZDTT5m3p?=
 =?us-ascii?Q?44YmasEcRWRrtSsFq4qiqO9WBrbBe9CL3mIAqmnbEBbFz52AAOHSE7hF39cd?=
 =?us-ascii?Q?Hd1NRoPeQWeECzLB48gpWDfBNRvv96Fo63e2tTmTzHbKDGvB5m3ueFaqiFxV?=
 =?us-ascii?Q?efvCIyo/YM44d+1rm/XKeohC5iIVud1O4iMm6870FfnFyHmPLapd0pxk5s08?=
 =?us-ascii?Q?rXA70cJ2COOCq2ipLFwiFzJOsjqnau6lOSL9hYW06YHkFd3I6Ei1ZHitJfbY?=
 =?us-ascii?Q?b7J61BhONmIsNVXeG0VjgqM5EEC9rOSfXfEmJP3/swxhqdG5cgA42R0kef3i?=
 =?us-ascii?Q?T15QdREL4U/cB5ASZrLQtWuXwF8u94cVurY9cgZeCG9lgnBVRtXL048ryTNo?=
 =?us-ascii?Q?FKrNiwpl1C643xCNDDFJgrZqUyTaS3qGYyLVsRH79a8vhEZFKy80d9WX1NoZ?=
 =?us-ascii?Q?3LjdSx+KxDBUeifZH5HJaTTMSVamxWsbgkRoGioXED0z+JMH99wt99GNMutT?=
 =?us-ascii?Q?cL+sQbMUu0PTgVIuI9IRZd2+RMGo5ZphoYORMfUqlc6K961twiv88YfFRB11?=
 =?us-ascii?Q?4dLC6zBkTM7m0rYRjWxLQheDCEjPaQh14e11d0ePEXOcCDBnI9XA4jr1mXLE?=
 =?us-ascii?Q?BT9zZUZaDuELN0emIoGZo6zv0m8rCXwFPGvPH97/VH90fVxQI8g4AZ+gHWBA?=
 =?us-ascii?Q?mW1V2TffyD1QKxp4oNUQuZdKfiWpdNdaYj1LFu3t4o1A0Pu/sQVraNrDlLL7?=
 =?us-ascii?Q?OyhqXvz46y05m3a34nw2CLlHYW7U/8ABbosqXtUtOEPxj9MbLQl1LzQVunac?=
 =?us-ascii?Q?eyl/zqaxiR2P+SAtrUilhOXBLBbON6bP6lUIlNDsm3F91KTv9bLZm57g/l5o?=
 =?us-ascii?Q?O2ItbDxkIwofRnH1o+zIbZsI3/qt9MpfR9rEiQiCjBipyHDhd5Zeqd9SDf7k?=
 =?us-ascii?Q?1u9ZyfqtbXpcnleGak27EjlAoEByt6FCBD/U7hQzSRZPNzvj28CfxMA14mWY?=
 =?us-ascii?Q?YFqcXrA8Y13YYp57UKc0LbO/fbMVFoHrm67icgn1bxu6nVfqoxwZefn8cY2D?=
 =?us-ascii?Q?2TNz8g/oY1VrwbipGhO5CNTAqI+47Rk9iuWp3F6WBn2QNy5Ey8qvvNde5gAE?=
 =?us-ascii?Q?v21a4OhNP5szNBiHGd5ZpJa2OkkBpk9b10qpUnVq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4687f83-be7a-49ee-b020-08db7d252572
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:57:50.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IUiUYJYXDDqmFKVgQbCRrA3aXfzv+So1D4mcPBElv3p3qGULraZbN1PKgv4ynpjD73wQ/VYeM0DZwKfvo6OlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the output of 'ss' command.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e430bebebcf0..69c102a02ae3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -200,6 +201,87 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[128];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q tcp-ulp-mptcp",
+		 NS_TEST);
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "mptcpify__open_and_load"))
+		return -EIO;
+
+	mptcpify_skel->links.mptcpify =
+		bpf_program__attach_cgroup(mptcpify_skel->progs.mptcpify, cgroup_fd);
+	if (!ASSERT_OK_PTR(mptcpify_skel->links.mptcpify, "bpf_program__attach_cgroup")) {
+		err = -EIO;
+		goto out;
+	}
+
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
 
@@ -459,6 +541,8 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.35.3

