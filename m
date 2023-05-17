Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844A64C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTIkOIBRMsBQSHiKyAsQwAeo6daWPoYhR6feCjmKTA7zlD/zmcjiKG6RkczH1gNbP27bilOw7weRlR1f7vFLQY0Prf9PbiQ5vSqwxKR7bHDyZhTsrCXCbUYlZQ/hbz557H4JtF3Saukz/nhBOO3+EpwAZ2Wd0yb5jV6RFML0lrVwVsSGzgfMhXW0nuBkYZT0cDhillcPjxLR5PFYcMz+kKTJSSxh/z4CrO3RL4Xkc5LDcZjvpbL0b5REFmqZvHHOexMYOW5IrShZ8l9jpUzhHwf8z4ZIvuSc6mRrIYxl89XsJPDb68zkoFxOq9vLSwgVacTOJYopAXDus0AnWx7w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7wlPnS3cyB0dsei+tcGwG9ixPdF4Vk9W2D1eoE6d7I=;
 b=R2ImvsfhJd7vW740io4gaSND3q4TJv3KBiYNHEWb+xlDWZ2fCBWo0E8nNFR/S9oYj4fS5rOHw016amHKJDej52u5QjxURs5ZHYzjLCUZY6zd1X+wDMHAn9oMFtiZ6ixIT0XgdKRHb8shkZRHiTxthYIx83A8aEkyMYXrMxq9FWzEEueWYC2fnHTvzVDW0hLT3PwpJ60hndVQ30KNZc3Jo7Nf/ZJKi3nC3Idpgj0hy0onleasTtmfS3GKe+4DNY0zObuRzPKYX3wi2eNSCoyVMx9VLwlZ3yEf1IkwF10bdjMXORluOulHOR3VA+yql8YfXmEb3uRICL7HyGEefcgoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7wlPnS3cyB0dsei+tcGwG9ixPdF4Vk9W2D1eoE6d7I=;
 b=TC9fClfiBL/P1f+AEnvRb0j8HgZw6WZucXUr6jmQX1SI/ANnRBMT/5CTOPX3dZb/e33bfVMRjhRd22ADJO6m2oIqm8nVXo4M0zKC/hZNIMRLker4MiFDEYJRuMJGjcoiPSCNwwIqUa285atkeTfp2sMqAsO6vRK+bbsmxxc/m7pX8yEcC250tG9o2+iEt8PJfCPYgwCc+T+HmwLTghoPY3bjzeuvDurNHTs61Q+jZjL9aHmsYyu8KUnQA/3yBqT9b5eCpbfH5yANCNqpFplFOObu3hTeyL5dSb+kIO0PDI4nwUPA7hRZiR8PteomlfhBVvXnI0Tw1/w3kHCv8bAojg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:41:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 08:41:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_rr test"
Date: Wed, 17 May 2023 16:40:25 +0800
Message-Id: <19e6dc364f4a55918ab66c56c8a10faf1f88723c.1684312651.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
References: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 444a0022-9a99-47ad-18c9-08db56b27817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PFn395JnciWvjoP5m5YkZ2aKAaoGL11EFq4plYdraCTtu9pVR5lEIEjBu358tBaEJ0BCgie8h1Thp42LupKghey8Pdq7OTHATy76AAoYmL/AmDFxL/skO2/Ev5kK9vGHv1RP0O6z2k7ZInyFfAQ0pj8NfNQucWzZoXe8TysYDSKO8luWCIh11ddCziqzLDD+naXoJYw/ZoWzootgb4XFxizGN516b1B5W0vVKKo91ID2lDwHlimNkRJjRC5DWpaPjcM2NgI4eBdB4iE7HK3/IqMBc9ag7GpSwKd/I0E3coOABPVQKdKzD7o+wGT6AkTWbEw0PPk8NKa6y4rY3ewoopgxubh3co9RtkID+l9sc8KjgVmymg8ROAkL4aEZjvU5td5OfOhc5NVf2QCRg+Jy5MQIqZ7uFhcrAgfAaAOlGYlbHWauYFZe6kWtuMv2ubNYGjcM5GwE5qSfnlWtSrXXZOaHzo7ZnnoItr0SIUVxbJTBdEHRsD36PMkD2zIR1zpXIVpp+JtVrmNqgzEE4RVA4iUdo/8CY+RDpkletlJquRhEanEe8EPjF3I5fLTEfgr2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(83380400001)(4326008)(36756003)(38100700002)(2906002)(44832011)(8936002)(316002)(5660300002)(8676002)(66946007)(6916009)(66476007)(41300700001)(66556008)(86362001)(478600001)(6512007)(6506007)(26005)(107886003)(186003)(6666004)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zcmSKSPEaWXSCA+p22uBhJOyz/id5to9Sc2w0lKcRBGwEh9luHThGF9xBTT?=
 =?us-ascii?Q?SJ8fDAMLNsq8HHJL3hwvGn1LSoY6ya3lgsIc2TFUKwk8DYTcoJvSfv2kOj/Y?=
 =?us-ascii?Q?0kql8VwnNVqQJMzxVxJTQ2U8PexQFG7yQhXrpXK70WRHAt8KqRv1+GrvXSiw?=
 =?us-ascii?Q?FAEzYvmB0hbpU7xoo1eioGejPH0DpbxVluKw0r1IrZ1nGbkONO6rBgeDTVsv?=
 =?us-ascii?Q?o+hDYgGnendFwGmLH0LQlH46Ba2nMuq7bx+Eagmsyy5P0JQV6+/DlYDaeE6/?=
 =?us-ascii?Q?NasgjbMAvIEVrUDWq65M5hjwBi1/pKGEsvEsJBT9xC7Da2DU3itlh5Xyr/1p?=
 =?us-ascii?Q?8l48bBcVfPmY2QzvfMkSG4ku3VFuFpq8a9QQHan9xBSTChzqrjVaW0Q3lZfr?=
 =?us-ascii?Q?O3rfdjkvDg0Ip8ZUF2OItKhvD+feHC3PuYxUxhn+kLpWBkek4Iz5UFrtgUZl?=
 =?us-ascii?Q?YeU6C2/vafg1w3xtvHsCRA5teX3tfvEjCsfWbbRvyMmibtnBnSaJkTLqWG4x?=
 =?us-ascii?Q?sAt781nyOpqv6CItCCnGtu+QYFJLiq+c7nTxDSRGae8RT0Y6/9HARewVHHDL?=
 =?us-ascii?Q?itmzPRd5m2M4bV00B9EUdRvxiHCAux0or8Czjg2z3ENrgFTW5+JeZE38zoqe?=
 =?us-ascii?Q?ndQuEk4yGsR97KCNM1WNmZb+xE+1n7XA38fpt2cWu0ogMs4ld9r2x0jCgmDg?=
 =?us-ascii?Q?h7Ogwx9wIJY4+tb1oQNyySoPtadx2Sx+dJwdHkzvEuPClRYIgzX2GIIYqfqw?=
 =?us-ascii?Q?CWhPAaVnw55O44zHNhqwgyOkaIC8x/MgpP3S8Mbagz0Bq88l54nNrljwBc60?=
 =?us-ascii?Q?Exb7D8aebveSORwUqpbZb9m8E+r/SDzLHHaR+WFcqmIin+irmj9X1VXkLneF?=
 =?us-ascii?Q?ojr9VXM+rUTSNSqi/7D7genTXZ+12bxR3YYRwT7RX4BvikQZsqVYRex1B7Kx?=
 =?us-ascii?Q?EBkoaHHcv+Ea2xGJL8qti5T2mUJCfWI6yLBY8V2Shazv2EJpYVi7XLiukNrV?=
 =?us-ascii?Q?J9bv8+wD0OoVQ/25alxnFrDv0HYp8H3QD6XpeFM/JeFlGUTMl10qkbEvTG+A?=
 =?us-ascii?Q?H5RK2fI8EQO3TqR2K5RCrzv6BKHWJkMsvx7qGXFHnbjvwi2IRz6Q2aU8XaWp?=
 =?us-ascii?Q?mPFicQ+3GfBymkMjc7UNnYJKcmKpWGcujXo8BgPXWV38JiGL/fRB+AgqT8tL?=
 =?us-ascii?Q?ZE91v2iiwqJO+YYl0UanaOD1QOWwcGdeU41Eq6q7u8yJrQExnJxfxT8sj1E+?=
 =?us-ascii?Q?gcCgJeUXcKjeOK3AxOHf34H65g4zK7CCh9ufiMHSG4vfBSL+QQHDvWefiK2n?=
 =?us-ascii?Q?6zHnwcVQ9A+ilCUjDB9teYdmfXISJtz6KQQFr5zoMLr8N6sym/axWV1eFX7y?=
 =?us-ascii?Q?uaZQE0NxuJc/8WkBKU6UhevzemUT++rnTeQfoPJmw0vbaYA2AmN4ADo6Avio?=
 =?us-ascii?Q?2ptFLMV6jvhS8FClN8JCr2L/Z6riMnxLpq6yt7ZDph9+wXm5tEDYPlydIMsh?=
 =?us-ascii?Q?+79vdk6ZOhSKHpeu48y1b/wxGxA2mE/VhuSGKwvQTNZLwCWsW4lEfH8p5E1P?=
 =?us-ascii?Q?z6B7XgjplyQlwu6HT41opuJkMUFeT++fY47zpnlu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444a0022-9a99-47ad-18c9-08db56b27817
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:41:12.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOpvdE8On/RLaQ1F2JEDVkmwzIrxNYiPYFIWF6pc+4ykvhr0o3d0fleF4nZlDGmNdFdB2j8kHoubzHGfK71qhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6d728edce349..ad1c46b35715 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -344,7 +344,7 @@ static void test_bkup(char *ns)
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
 
-static void test_rr(void)
+static void test_rr(char *ns)
 {
 	struct mptcp_bpf_rr *rr_skel;
 	int server_fd, client_fd;
@@ -360,17 +360,17 @@ static void test_rr(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_rr");
+	sched_init(ns, "subflow", "bpf_rr");
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd);
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+	ASSERT_OK(has_bytes_sent(ns, ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ns, ADDR_2), "has_bytes_sent addr 2");
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+	sched_cleanup(ns);
 	bpf_link__destroy(link);
 	mptcp_bpf_rr__destroy(rr_skel);
 }
@@ -396,7 +396,7 @@ void test_mptcp(void)
 	if (test__start_subtest("bkup"))
 		test_bkup(NS_TEST);
 	if (test__start_subtest("rr"))
-		test_rr();
+		test_rr(NS_TEST);
 
 	if (nstoken)
 		close_netns(nstoken);
-- 
2.35.3

