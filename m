Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432E2585
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 06:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abXlcipLSg0mlnADLNtWbng5wIsT7XTJezI9yz7SARq42KqdYwEmRGxVkrgNpnqU1zcD2uVG8ch8AwgOFXhGWEniHgDTm/gc+z8GsrInDfSnmhARxo2G26lH3JdXyIBBYbLgGGDlBOeYdlk8fJebYxEo3bpRfgQltDisMAcaLLZZC3DQd0EsxUokr+7QL7P7HHrPHuqon2OmFXc0R3d/muekG+g6XcCwmWFGdHbdOdolJYFLRQFxzpOCxrP85XYUjZTY35m4cVGrfdf10Q3cX+jVqZw7UA6EZXV/DVoxcg3pW3U1RJV0R5JTvnGOikrEbJ+Uao3W8pv8Zenis3UJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKzKU5Gd/yBxw9UlqmeDsyGKToCYW58FIU+teWZ9hVY=;
 b=K/raRUe9ECkjMJb7nyMKjXHhL931ppYKJ9Uz+599hraLaRJLEPNviLFoso+Qw97OLvpfojxvj0edvXLTtD6cOLd31xeLhXKWBUaclFY93dgo2mLTFdp7j4Q1tFioMoiNQnETajIxg/eck+5rq5hHPb5jpuBGb2l0aC5TarWa1FVkcCYEe6o/gLPK/QmkkOls03Z44TF1EayJvJDkvgPkA1EmOwrdBh+oe+2N9jwhKxhPhb/ivn+Dgkxxj0kd0TdQGYVoSgOeGtZoDcsYQT4idzft6XD6rP7LwMzyu9Axko7DysaU8EMLFCnoAY68I3birkEOiQFnZ+tuba1tuAs1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKzKU5Gd/yBxw9UlqmeDsyGKToCYW58FIU+teWZ9hVY=;
 b=xc09Hv7oKkArHKBdlch5pg8DsHJW9Ju/LCzF/0G0+qOOPtlMpVVtcKXI+/PReSeL2FBEjw6GcsIwa4JN5GDNPXDUtrasyl4bw9OBjqFpa20TdabwKh+qwiAfmce4GbGYL3js1uhAt3vpefLltEpbPWHln6EimwM7AOSucSfvbzK6bpSdY0RdjblB09hT0JiX2WFyvvxJrSfNDIO+nrDeI8qJV6fwRWOY5qwBEm+Nz/6ZfSXOttBrzW3HSOLel1In64RC6hRBbiwFBU2yyCn1Dk0mLw64f4UnOlAzZQLsTVBCAK/JCrlZfzezzvMqw3tauxMZqdm+FgsoddTyMQdCQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 06:51:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 06:51:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/2] selftests/bpf: Add bpf_stale test
Date: Thu,  3 Aug 2023 14:51:39 +0800
Message-Id: <c5e97a0fe0e542080eccdd4f4a1e99bddeb344d1.1691045340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691045340.git.geliang.tang@suse.com>
References: <cover.1691045340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfe8340-0557-4657-6bb0-08db93ee19a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	34jlwGwfoTYd5rfVr84W6uOgWUv1ebbJi+rNHHIttA/nfIqzopfWCKy5zbeYBvtfFfq9SWJE5I60of34jggG22Xs6lxJYo9Qvgx9PGaTjlvLw35ODKvPpqz91QzJb+SMlcdfLeYF7yNJkoCyr/Owk8zWum9b3hqB+VwhYrI8A9vOcoz8AUTzZxGG2YBrxlbpdR8ToqaKSmDIn4t4TscMlTZuH41yAiaFHrEcfnJNC4jsYi7qW3wbW7lERuQhp3wOYpvizhJYckYV7W58T1HXw4AIo9eDFFrLTbB49T/3ZDID4Dh07akjFU1qEWQ0QZDyg65NpjlfkuTgbyQ1VkyL8Q3mbl2nOAE9jLIh9hBvzqumHwQnKEFLrNIfD6/pivuZgpHSJuxF4c9HPO+Qo9M/jpv6qVoIWsELPPXfE6kTMolS3MohZzPkxbY4du6jVf+BsQ0qQjLD6Uwv44GPu0JFJfRc7cOxOVwVaWaCb7PpshXaP35l3Q6MNEYfatgsNl1aYTkAGTh7or7P7PDca/mvgU2iLAagz4O8PbLc9zJ9bYY034g6NvWYAUnlJbyp6bBkdnuTyXYF+KBS29SCVsb9+DSEA8oQJJ4cTSJRYFrc+Ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(2616005)(107886003)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ri2TSZ0V65nwX3yjtKofg2OUNrTtYbaWDxzYOmW8ZUrKjQr97eoja3gY8kF7?=
 =?us-ascii?Q?MCKC4Zc1cWWgPBVABuoefnoo8NS5o9rcosYnJZQGVWnWQtoV5BlAGBKEdOyY?=
 =?us-ascii?Q?6zyVbr28laMVmO3RXoE2Fq6MxUMzAQq5wyyojDDoZB8PLQrp9uvuDXtfNsK9?=
 =?us-ascii?Q?Ze4SHmYTcRDYqqO0Vqg83UlXDSEiACGzRLANPmiFCNKwQ10u0qzONOP67W72?=
 =?us-ascii?Q?gjOaMg2w3OTJPFfrzwH4PtfWf8+OmqRmKregP70Bl1QJDTJHMR9S3WgSNOA0?=
 =?us-ascii?Q?oZNjy6ex2eqoxLPnsv4UmUPpgYmHx8VFFsCgs2HkVaLVNZxGv2VkBTmMl8/y?=
 =?us-ascii?Q?+mlPCnbntoG8MyMimBkCs/AXQTurzqWBJC9BUeZwxVri6IvA9tF7eazCzue/?=
 =?us-ascii?Q?s2YahhoyCOv0pPXGylMGgACw8bn85nPZNEPWRianslEzA0BnflCuJs9dN74k?=
 =?us-ascii?Q?G6XchzPtIAMOl0G7mx5Cmf24BnH92Je6iI9vbBwFyZK6i1bb81iak40UD0Cx?=
 =?us-ascii?Q?vsZvrG5RT3ohq/nR/gqDYTFIaqhazXmVinkbK4G1xg5Xc6NhkBwORdaoWcj1?=
 =?us-ascii?Q?pCe5tZSKM/1v7BfziUQ/+s5zvmMfkBsfdUZeoM2MXCO7BxIHGci2xfWhyROy?=
 =?us-ascii?Q?OfRO3QzM3YlaGb9iF0Z0vy3CVZjV0IS1NGZdzko+x8Kwj8GSiC5sE11whejd?=
 =?us-ascii?Q?DxSpxbv3Yl5ZJ0MJNee1K3xCDG0x0LjDMJ0DiDsZSNEU97tQQzpbq0aDREdS?=
 =?us-ascii?Q?MfI/DN6dyvRTjFZgwD/CBGBxp4pzthZ9zk/jvDIHGQBVgamBUxymIhwLQX/C?=
 =?us-ascii?Q?HVK0gteffM/xKDt9zQEsntVdMUW+xoiNnYVuCwKV9JoLLOOFGSe9s6CUNboF?=
 =?us-ascii?Q?r+hHobhEee68Vtde8dwCFnW3RBYzhk+Njw3oe7d3OXQU3PpMjCHHyOJyfhaa?=
 =?us-ascii?Q?o7SjHXrlhLXtG7wwGdT6q1vtTrqVsQERutmzmbzwcY5kc7sSJjuuD89VF51b?=
 =?us-ascii?Q?ubk0edW2yQHRKSqLSI82DCwPQpgMRT1VXTPyxfNUiXj3jhcssD75Qbb1g00y?=
 =?us-ascii?Q?ZsjlgDrkJYc1kzoIhgjjcq2/H34ZM3VTEDJ9ykqBYYh2I0DwlGe4QXitugXq?=
 =?us-ascii?Q?LJCMPzuRF3TEhaXhCL5gdU9GByyhjsfyuByr1fdttu51XrT/+cA6GLBgR84c?=
 =?us-ascii?Q?uXsqSbo3MjzKNc6oDpcos392tMPlNC1z+msS84ORDx9I2R4ZlU2cjWwIZZba?=
 =?us-ascii?Q?Zy8fgdYzUCzUkHNeh6wP+dGP3/BeKiw0SAeYbdyehuM01EqmRrMXKEEdr+Y4?=
 =?us-ascii?Q?WAE3l0kgIKQ9yplABOl3Ko/QGLhYxQJPIqgjxZ2d/NlWrJ2p54OwzAxbw5fn?=
 =?us-ascii?Q?8uhbLjPdtCKlISef6jXwz/mOS/LQaQcGkUBJ/NjGIXHtJNk8Z4lIJvJ+8gpG?=
 =?us-ascii?Q?OAg97x9UmOvxmcLgGj4evg995/3GQ4NKide7eOJ3tpB58lK0AQKRYdnIIbTo?=
 =?us-ascii?Q?8PEQ1qx7e4OJZ72ek3sk8H0WU5wz0lLNWOgiAZowOQmJNUkGT3fpd+3CaDSr?=
 =?us-ascii?Q?VJD+EaAxyoZ0lOV3mINoPV2voX9T/qhyZJwNNXJgV1APy1cCecCkZMUOpC2T?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfe8340-0557-4657-6bb0-08db93ee19a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 06:51:45.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agoXpItLS+Q98WpkIaS8t38v+c3m839SD7wMRj6IxdCiT5ei0hR6ETOBeY4dUlOmsM0oZ8rjUazfw6qENwbPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014

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
index 09770aa31f4a..5accc34d35e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 char NS_TEST[32];
 
@@ -524,6 +525,41 @@ static void test_burst(void)
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
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_stale");
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
@@ -540,4 +576,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

