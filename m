Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB81E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEZtGrYfVTamYmQI7mMzB8ipevdPtIk+2L6FjAUN3Fq8WBfMLcc3SY/Ekgg+zrjvWLKopbJHCrXADTyHS01jMgjuybUchL40yO5nSnLr24sYaMq8fe+Pm2sFAkYHBeYU44/pt9ySm535Pcy12scoLjGlgylexoi4yPL2PpRonacpD6/9fPUrO3gjzCjgTSa7WIE99IwtOufCDVoJ9EvL1JZUn5DW3G65sFlNzUJvVVNcAS0xzS+/k0T4553kE67ZQhnOtfquD0RyOkdFvizE4hLqWAldy2BxCaTSn+LLai/TzFKzCenF3RIQk5nCNrFYnW4sNcaBkTft3YxOjkXtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKzKU5Gd/yBxw9UlqmeDsyGKToCYW58FIU+teWZ9hVY=;
 b=loFDbdNr7PCrlCp4LbvxANe/kqMjFdEi3QlQC8+XxBDSk6ReaP7vql19or67NzXhUm0fcIyw/SZfBdqXyU9botBBNFz8OPqwCiteAOOYvTNQWM+HCzIzt/oUKIClWksrgjhcP70LTonQGQ9Cm5tnhniaWvR/T1ltq7xITNGm9kdanjE90YKcux7tuC7TqTAHrr8DYupe7xATJxs2m6w+wLxCSZbeZYp+K46E51aSY6fh8zSKE9Fpk3EdTUJ03mkeaDbKZUaJk5qbm8XsAw3mgD9uvdODoQX1RJ1me/5JVbpJgvzQqobllrUatvX4b4CsZUhOFl+XcXqTTX35ZI09wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKzKU5Gd/yBxw9UlqmeDsyGKToCYW58FIU+teWZ9hVY=;
 b=njdNtWOjLOjPYId8RTz0whDTV9AmZ/HA+Q6ZFdC35Gom/zelI+UUNthJdyh7bd26GoxI7Wv+/4U4E66uZZDveUehoqhYvLXz+mu5Rxl7tdeTr65jiUtN31w7DntkkKRcwvkJJ/PE1SGkHnz09VQYIl4RZ9f+ORfeV+dsyKmaBz+soVdhclSUqPDdB1S8S4U7bGA/maAldFsc3GQY4R5u4MEwCN/KmAeLwHaBeMhZs4IXAYhA2T5h7LLRtk6Ai5xwxV4ujSg7rBl99qUvcaITAVbzVdwSJ46UKoAqNMwXo/Gh4wlW9zU5Lyc3HpBlwLLXAR9cE5dvyZTa7fzu9XlUdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:11:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:11:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 11/11] selftests/bpf: Add bpf_stale test
Date: Thu, 10 Aug 2023 22:10:03 +0800
Message-Id: <550e3eaef481581e8c78ff4e6548bf27909b0936.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e642a9-a229-45a7-a7a9-08db99abb147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wTz+JIznQwthv244OzIXOGpEGT/uR4ZEJ1iVvV1K5gciyQ9eKCVPAqcH1yocy04AUqBOpro7r7moyLqghOq7AiVmfpDtfYzjVAF21eaEQW4Ofg59S1Fur6ClzfUYpcAyBXgt5mIJRPsvpBhL/a2R+sQ6r1HvXTWzYTaMs/hWlBcg8q0tAvi5JmTPNwfN21sP/s30C8BRV0NxIiOSVL0IOOYQ6+4R5KjfB2nF5212Di8k/buNPUYP+LEl6YjLOLBiGDfQLjKNLWysCy9u8W224S6qkM4FYLonze2O71SAIh3jIzGberkpLvkMhklRaYOgd8bnJVt7IqWkUAlaaKfByldAIJIkPpVKt9buB1roeXJVvxO6qyGk6h8fh6hO+OowgXT2x1Nl7cqocLv0B0m6aEtIAHIbYICf/1Y/I68RjeLeKa8V0x/FW00PhDVPYmIgtok86onmLl8JkX+J/HGfoRKrpxgKtT8h0WTF1ffYwZH9tLd1OTZtTZjpNl2KxLuDnv26EwuLor0coUa9AkTBD4zF3mH4rILwnHKOYs9IA2ozMdqe7UL5jpCMRvd4rjzZztQK8EgCnsfvNeQ+o4TTv0iN+UXHxLmF1zGdCZ53XjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(107886003)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hwfOEXFaFOseCOdzhMT2aMpz+EFSjWho0cBhGqBTuxVhOKt9KzaQ/IK9CsU?=
 =?us-ascii?Q?kqrpRulj2CF/VgnOBBY9O1TBoNnjq2Po+5ufvVUFEs1PGELEmYmzb3RuP+YL?=
 =?us-ascii?Q?HTq1HZl+cGvqs5UG4N3thBJvXyJVPVu8MEeZVGWBw//KFhtFcnzoZAT/yNVe?=
 =?us-ascii?Q?iy8Pum7DrFmuGSiOmzyh/yXniapSbVT3oaMKsRXjBYMJ4lq5RHpfMcVOhsxs?=
 =?us-ascii?Q?A9Z97Oq59lBwyP+o16Wt6ene+/OED2Q0SBnUVNqLA9TUyE4dYsZoVx1NEHmy?=
 =?us-ascii?Q?6oZv9rslbdhisuql3nn29WYK1dTULvAhcWSgyFtT8eb23IhdcAcZC5Ui9/BP?=
 =?us-ascii?Q?tkzAPZ4qb2xtYf+/x4ixjIviPhmbAG0u0UA3W3+tZB1K8x02W7KVXwDQf9Wh?=
 =?us-ascii?Q?j6Y74787xGYr8aXrRegwZ4Ef/RPfqCvP9UNoM8ehgBjhb2Ml1M8NaYitWBus?=
 =?us-ascii?Q?AfGmiF+QKgNTJ9FAB8pXm90J+3qHbyBYBTvupwkGIoNP2lhJioEkFB169M8p?=
 =?us-ascii?Q?x76rqTChkCzsM5dnvM53N/LhjqgyRN0yf8ch6ojwgfGtHRlvcDVmdM0UhlLF?=
 =?us-ascii?Q?Uz2h9l86rX+GEJRSU3qAV2cj16Q6zjAlnjd07KcYrtsvbd7lpGAyM/p4/HNZ?=
 =?us-ascii?Q?uCfmC6NWNTJsIVpc/5m+myaelGXQ6j317/694K1KQFh5nMrzuRorPeYT4N++?=
 =?us-ascii?Q?XYQjgGTn/7ftUA3SNjP/3WxCkRIV2O2AqrIUCjXnwrzar8sEy7FwN3TSIxtS?=
 =?us-ascii?Q?eNR28Z6+qEYts7x+i7ucxa65Ji96eKovqhAlsXn4ZjBAxkiVNDv35BJJmxom?=
 =?us-ascii?Q?f0inWLIH9GCNOy4fcxmMK9Z8Xf8tZvn4bbxaNDKfQUnbewdO6Tt7u+Wvs871?=
 =?us-ascii?Q?2jKt/QjcADIapc8P0t1AZ8iqJ7MG+JKd8g8EbHb3F3LFsEfloEemGurNjtfz?=
 =?us-ascii?Q?TdSNce06twU4gsdN//Riy/O0iRURGn0UzpC2YWYot2K/qNa0D0ASHG2NuuSw?=
 =?us-ascii?Q?5FZPa3AyE7pmtDD8OvFkDIAaw6f3spKGtok//v8PSawZEM2SARG7ZyWFXhxc?=
 =?us-ascii?Q?Jj8Dt02GHGcKBpCDHQeMX/6dxqqObCnbh5xdbsf8j6kQiN6ul2h+Nu1RDed6?=
 =?us-ascii?Q?jGMdhVrFrilGDBJAR9A5Nn0TMyucrHKYv8XUmCieJQPXqwXIm7Lg74wwOlk/?=
 =?us-ascii?Q?t3R4uTCjHpVAKDXGQlKEoJuzl5NO3PZOHdE8msOnrFDyoty6bTIo7JqHX4xK?=
 =?us-ascii?Q?b9nxD89PhaHxvIN+Z7s2KnzQo/Q4MjeODJuI25vDAIN9zQ5JuavrOEbHrQq2?=
 =?us-ascii?Q?L9RdzRsgT0GlI/XzrwLClk1oib7/HplabslYhCb7ehx34h9fZTxodLB0hnuZ?=
 =?us-ascii?Q?RRS4ACOJ+NGlulNagQX6/wvcsaccAoueLCwQz5NzmdGFlltegqYclxFHT1hj?=
 =?us-ascii?Q?F+dILmKfhYZGbXJ5DLU6S5w8Cp/Lz2GHUvQP2JT8LvAwC6uvM26OSJx27Oqn?=
 =?us-ascii?Q?zeChigyQs8ERb2H1kNyzx/ZY3XEPRqdOqSAT1B8IZKaiu2WwGj8p3rSZ3NTE?=
 =?us-ascii?Q?l/URJgtRdVxfrvPZbpjmIdSYqRJi6bWO3gBnirEhlxd0TysdVlpiPXB4uRjH?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e642a9-a229-45a7-a7a9-08db99abb147
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:11:29.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK7TVNhc6bto6GlDJak8jM5kBtSe3ZfKCZfSCozvN6vV2ExM2Y2dUJooBO0DvPjuDdfcteGXyDLjIrNTZZG46w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314

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

