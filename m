Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2135684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fewkSTCVezWEbfEOTimzZPwzhv9eB2D4FTl6Chg0nSafoEtjTf0pccrb/3TejSXqAMfdR0jqBMQmUdme7v0XnrmaKGCPKTp1x9FIqYdOg/WRlC/E4ALMXiwANQVFcy9apoKygHH+0TaMS9UmRv2BD57S4LmlWn1kvv2ES5/qvuHkenGAQd4nQ8eSoKVVfNk+D9WYu9Eo0vISPHSBxNrg2JTP2+jWmqtL/Qy6PDcPciYYWWTiB7pTXNSAAcgdd0ECGYfIdJOwDH0knDP92EPes7lL3AnQd6JR39ezfi+jdhV1V6kP7LTjWRlkCRSt13lcU811kHHo3sy357TBbhAQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=UmRlnXIxkyGQZffGujK6tmpiTYRc/7Bo70rzbfJK1b8mB8fFFmaFGLHLlH5gZtblPt6phhcmUInw/gOKqO+hnZPagYDEzatWFIUqIjBg6gZVULLl3BaamxtgKDV5s0co719UMpVq9Cbfq3a2vSRvwYYmYW8lBdOuOZ6fmFAShjYYHmeILjGaZ/ftCe84a5bCeENvTiI9F3JupSPcoQUE8GZmYfP0I30Z3YkUdZFB4AAYnZoyG8A/N4LAU9LXfvKd5dHZZoKYOQd/ZIN0y2aSiWSuOHdaODIk0kSu9wpYbQGPEbpXuDoRFbZfk3vAfZMdtdeOhY7oEuzdBKlfKUIeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfF2ymQTs98wwzrYJcSpzuGafFUO/uHJDM6q+Oopptc=;
 b=IC0bcF98FkgrTpcN76Gw7MltuK4JDTLrJZj2kW4vGh13tSCKDzAcT54FSxWCK4E+InzQ1xhzxQmDKq1NBSig5gj3aReqvl/fqGtaoQjqBMCIxvScDeYG8qg8nf794QMTg9LejL8hyZuNi8P43MmTjJ6up/etqquL1F5fN5JrxErzCqCtNX15hfSxQDeWuJXRATg9cOnJ/TBYQP+RMUgqQmd/9vK8VaTF+bHYjUWKPFOARBMw8mExUgSZjLkp8sCwfhzCGHW6wmmZUhWTTJFbofOCHub2HOa0J4PDu7o0Aj+PYKb8TXmZf1z7Cf1nIB5ssipTY4GBK6uncwWKOU4MCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:06:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:06:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 14/14] selftests/bpf: Add bpf_burst test
Date: Mon,  5 Jun 2023 18:04:09 +0800
Message-Id: <cc7e5e740b2f42bd69ad219190c221cf62fb83ba.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffaf97f-0697-49df-648e-08db65ac82d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VjMIe0Brek5g510zxcwRkZAcNZNqUPtGVbNiZodhoEw5MW8MtYs0CpNlNO4olnIh0HEW6H+XutouQG87xO2cWUAvnZU+Sx7nOmqlq7nxTr/jTgyksuT6aROoz5/6bVDkoCKg6b8ir8po/O78mhL7JcF8Fk6pvzjNICDjbA5kXopi4u1wEEE7Kdg3cGb7pE2sYG83bcEccm9sFQdUkFc0OfZrYfCknZ3lSL7pVgi3iCf6ACgnalZJzmKo6mngJPBZTjDB68HKacydjQL5un4GAb5ZO+AoWkPd5AetvGlpy+53Hx1X/CIrRlEJeEoM6m3bVX32lHB4w2q8SsiwLP17Ffx1fWopNqJDUbU0500S/waIxH9ITNfj9DQeO6AW8Wnj1rVR+0SBZ4h3VmmlBKBMxJTxyuv0qA6XcfJl0fMrR5DxWgEHprneyLzDxSZZZRWNeSvqWqB74HT9ZP+Melyb1cFOYCJDL6D/m5i1RZBm9b69rty4s5kt+NOxvQnxFH1r5bTlRWV/rXh13k++i1agOdVcGZzNxovuZAqMPRWrUcfoo0FO3aMpF2wn5joVjHYI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(83380400001)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNyRHQNmLPQN8SdklNXQJOM2yi3XlM66ZJ/kbohdM/Q2G2QS+9xz654/ZICR?=
 =?us-ascii?Q?UyWPiQAvIXsdKS/BzoQchsPM6cF0zAR0j+OEKmM2HLkBvSMcFIhfeA8+omJ0?=
 =?us-ascii?Q?dVj5B9HnVfAAmteeFqYNAV4pO+0xXe0mG2T/d/90pXJDeh5ONYa0SmfWmyD/?=
 =?us-ascii?Q?yRZR9oiXOAoGWzZ/QICYSr5RXxqA7+74un1sqQn8muIELF9ySa3EEW0Feh7T?=
 =?us-ascii?Q?Yj7xMvVna6hB0b8DlJZnIckb/HvPrIbB8q8GnRXJ+Kyy2HL5hcEuGGIID5Gs?=
 =?us-ascii?Q?feu+Jl616BXFZrPI0x6B+SWkebAFeOddVWMgO2zsnxn9Wt5cBb+28U2T4bKe?=
 =?us-ascii?Q?VIM+ZQlSN1N3uAfGXxBRVGwYNd9RkC5/cDOKb1BDOnVpVO/q38+GVehzTHCj?=
 =?us-ascii?Q?ACFvIL0YSHAOsJw2MWwkHDNdN/BfcNGetKUtSmW2Mfu7xdS+dHtJoi7G+O8a?=
 =?us-ascii?Q?DyFZggUzAc0GPN8jOmyTsACMIu953vMK7SCej/dacZB+/hz26vaPZgmGe6g9?=
 =?us-ascii?Q?NtGz8nYRo2A8aMm2hqeoGX9H/Smbd5KSgKBX3f5A5+VKT87MZRJNhwoe4r5c?=
 =?us-ascii?Q?VW1+CQKW2bCCU9bOCh4QRTWsDGzp0rkAeK+qFPQiplNLmDJH6mT+vYNBCcuq?=
 =?us-ascii?Q?DE3GrpkwBZaW5wq2bKK6t5bAoHX8iNzosUi0AvNKQLrxMvNuY4Yjpc3mV4LU?=
 =?us-ascii?Q?4yzkTpZv6cTm36LclJqSoEJ+V4VVQ5IfFVVPen7pfDQfssj0LUtFzSt/1wrO?=
 =?us-ascii?Q?XeMOINpfweDPS7nuBYH/ExvAo6PrCvz6jtX4BxKh+knpDZLkPIKnsFK1jR6K?=
 =?us-ascii?Q?q0ZP9tNRD0J8xuAAM1cxewBOxtYZkJ434IetLx808mTTjhCBRlDgGFBNLQuG?=
 =?us-ascii?Q?ivSSNyafUhbmVYWQJQWGSDA8hSCuxo1YCodUxqUcSHGrWejcJ9XQ7rr4+4GL?=
 =?us-ascii?Q?xWzJcRoIbmCaGxu10Z73MxSY+t1+C/ezpWbRbI1z/3RvM7mWZ0SKB+T9PA5T?=
 =?us-ascii?Q?11+cFaZXCJw5b6Kd0KFIgethsqoR+BPaJGrFAPgUA6lBf0/R8Lc9I91UYRqS?=
 =?us-ascii?Q?WC/T8TUi0AQ1GYZwa9A+OQoHN99+W5NWFRvRtQXjVrhAxZqJjIU+GuQuuOw1?=
 =?us-ascii?Q?coarFeZMdfzORrYsdDMbWFmXPhFbs0SWQtrMc4U9Bhb25wgVP3OtrI3CTA3g?=
 =?us-ascii?Q?9VY2KJ7wKdun/lrdTPi44huSi6K/2isHoZzRRPOQ4P2tqfe4EmCJ0PYs9Bqh?=
 =?us-ascii?Q?yIMtQOswgSqZF0gZ1MzsBUiYUV9GadLeXsGQEVk9sI8oEznZBkhln1Bmqvj5?=
 =?us-ascii?Q?ldHA+39ffZTkrDgxM1a0ze20URX52kna5N3P+JrYTWoILwZaIyA3VLSyv8hM?=
 =?us-ascii?Q?xhNifp2B55eoF67HI/+0wm9LIbW3mnwIiKej0hSj61hjdBtUuAb/QdBPJXak?=
 =?us-ascii?Q?D1ALikSBzIsSeBWSe4908MpdjIT8I728o9UvP0c2JZ7h5pPdk6rgU0E9iup9?=
 =?us-ascii?Q?6fosmeS29OXjDlcGKdwTaXapM5+yPEzxdQHq94R0N8tBCOETVUFKlfy5AYvl?=
 =?us-ascii?Q?WvCw279Pq2rly90FFyNAjA6vPVGlIkVP9+5x9PKV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffaf97f-0697-49df-648e-08db65ac82d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:06:20.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYzE/o4sSu+Ip6p80BLLkS51xpEm7BfB/uD4pT8YsdI20NHchr4su644yLgGD1W0nPsLsncPxAeHybt8EVB4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

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

