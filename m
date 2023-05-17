Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140617C8
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 04:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4WZCCL7Fd5DsN0duNncHcJ1ZGKyyM2JqGeAaLshVT6LZLvbVNpC//rOUNzO8qiAtZZNlL3rpM0rQnsZqbvWXHk4snVT1ObjbvQdMA3WbWtxeX90zFH2bCzE/OmUejUro4njEReublJpTSpW4lYPSFsspnX2D1Q2ploZiyvVFp4Q/BJ0Iflk9G72U2fk/5FSU1BRWgDCO3VFZA9sll052RhCR5C7R+WH3KMfX8U3oLsOqlToVaqhZLSGUqxt9b6fzaP/hOboAVRwiYbtr0gIE21ptGQ+vn0frKRRXB0dhrdplXbYBAEUIaYsYa1ExNp3Yx+YbnONbVTVpvPhyU+ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjz5Ly3GxFPJgaBYK00HESRz5A+VpZPOnPL7eQkjv38=;
 b=PLxepaUnFXqSbL7+NGCxigzwjbJuapOtmetXCD9CwhSzvxdCl1GMHPbIuyHQFZfpKVOqUpj5si4PzjJ5QdjZCJ30oIUq1/ASarlwNFfmxglddaRRbld5sGyyUX1DpW003xJywIC32VLpqai/Xa5f1ZNYM9PZx+T7X4L4SFFXHWQy1s33xdjq6SMsP/eKiTSTleck59m71MSRFZWLSJH8mcmP4EU2nvT8xHFRVZ4k9MlKbMkcjyQSEMQwsNuj6ZXeqY8wLaUebUJAgNc9C7FbjeJpQfrzTzSffO9GH/jQ3oRnYhJ35k0H7OjVZqyGzH+VkiSN21iCetpcaR9awcr+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjz5Ly3GxFPJgaBYK00HESRz5A+VpZPOnPL7eQkjv38=;
 b=qg2aNvVlda7NTLMslDGA/ei91Jfw2t+rb+3Kk8LYsgOF9cmYGUt+I6kuOwdJZq6r6rpINQpQ/UBv4b7gAWHvtapp5qo7KQr09vKx6KQvZoQe8huwYKrGs4I/EPw2VzHP9ZBmXAQxCkwi1mH7Wkeoi4xoT0zM3oP6Gw7kZtchzHhm1gR+fujo055qbpwQBxBLLgBAgOeOutaYdpxFZKGZv739Y1s/Ec7G/iAI5TwydXRwwnYlTCd3OUCv2PYe0tSd85TQ8l5b9yQr85ExM7Lfgo5BWrd1pc1DlPc8na3Ht1gwlr6k97qrhKf+SIcn9pln0JqyGqZnx0EfRA/ecSZTtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:33:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 04:33:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] Squash to "selftests/bpf: Add bpf_rr test"
Date: Wed, 17 May 2023 12:32:49 +0800
Message-Id: <76898c586c96ba77b9ef409310889d686797261d.1684297911.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684297911.git.geliang.tang@suse.com>
References: <cover.1684297911.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: e77b693a-1bd5-4d0e-18c8-08db568fd9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aL9rLoMGaNnN3/VNZ2VCHL//+TgKNF6uCjOJTsCz0fj5ZshbTVW0xW2xtiCAlsi18skoNYetBRUnIBoAnlKKBjAWk590L+7GA6S21hrOlzuRlrXNQ2As1BXNkrep6Bmn3IYWCScf5mBWzbNwgzNoNw46MIJDJ1Msnaxqw0Onqu+FdL+hg6gd5TCWI2fK//VKyvnenFIxaPYg4dG8NjV+O15+mgx5PJGyDx7ouLTPHaxZXFi7C5xH6ghVVhLep8L96yW/J8QoRQugV+IbqcS6/iXjg5DOruI3vLoiJQ7sn7vqMCjiPahdIkETEG+fLCMzXw10IIlWaTn/4YkjPWSTBD0dvT+cqwvDugpgxxvsPzs+IlvFZDg1QbbgGfpG8kHuF08QiOQc3QWDlpah0txYGn4RIhHWDUpHE5zfLftXGedegR7F2QRiagguSVUhqjJx6ssL2CcWd/aCjEbIqmpsJ6N8woEXAUulaN4y7urzzi4npofkL2MDS/ulAKrFSr+Ych5GuAd+pi+FtXQiT6GeD1+3KkwgY1wY3wBufPeUWc/O/lG+0AGMFmc7EY4CH/q2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(66476007)(41300700001)(66946007)(6916009)(36756003)(316002)(6666004)(6486002)(4326008)(66556008)(86362001)(38100700002)(107886003)(83380400001)(6512007)(6506007)(2906002)(478600001)(2616005)(8676002)(44832011)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPMKiaLexPqUSn0CzAt8IHjyQ2GIAXjoCpXYQ1w/kvibYzptOhL3GpPYm5Re?=
 =?us-ascii?Q?PEFtlYWzFwC0Vde1PGdSsoa9lkdZgvH7RrsMa998SYYcdTuO4lgRN+Vy9f3i?=
 =?us-ascii?Q?uhUProGVxh0QgmemdhygXMH78oj+kCPIZB/cO/J8vEgiFloZR51IDz1EWTke?=
 =?us-ascii?Q?5xMmkd5dNtH6ncwg6jBX0WzAwuedHcnFGRnTVqRAOqD1YwR3yv4mm6sEeiNA?=
 =?us-ascii?Q?U+gbuWyZm+x5nJFxKTkIlvH+RKIA/ESvjaefuTOBgOoDCNUrSiq7rJk1/DuP?=
 =?us-ascii?Q?pFk32RG0bhWC73+iUSezcL028KR34gS6wMaB1nCzxXzY3eOQvymWDUrok+Cq?=
 =?us-ascii?Q?fr2r9yK0A/YMSfM3NHh4fB4bjNDLwSY4f2UJZuQ9R0xhgYzlrr06MZ2xO1Vb?=
 =?us-ascii?Q?NrFRiin+x7rsp3k8GmdwQx16gh1zLyWUnYeUsN9XPn3Ac9EZ5ivOm0Q7ieiT?=
 =?us-ascii?Q?aCIfrqpIV8efdqHJBcvDm5aXxcO7Ry2BRb1LBDyy3VPU1oGyAxc6mrVZeOii?=
 =?us-ascii?Q?yloVaaMY7OrS7+lVo1UKXuuZ+N367SnzLmnrg3KC+p4xjLgtVzApYL8BWhuM?=
 =?us-ascii?Q?dweZCh3fGBR0tnbteOK8tfcEz7NXQSscorr/sP+2RiCZDg9uUXdbNgJ1Tmjo?=
 =?us-ascii?Q?T8RMUGS/IVedgPxhX6Gm9mF78fjJT4E6v0XFJzx0uAAJLGvi+/09GzSAwPUQ?=
 =?us-ascii?Q?tNFXRBf9tELaiVPOfqf/MMANXJ9+IziJJbtA5m85FSlmLWiG51Wjf6FUltNf?=
 =?us-ascii?Q?sCN6/UKU5w1tNItDM5ngPl0PXr8R8fQAitOM1FG7rv3XfAXN3phwx0zSN1JQ?=
 =?us-ascii?Q?8sz2Bb5tzK+7oMypcUKPzrIROGsShSkZhs/AX8dCMumhpauRts73PGJlXJj3?=
 =?us-ascii?Q?XE3i/aOHRXnHl9xt+jz9rrqB8theoMjv1vPurLdbQRSZ1eoXndNyv5eUPwGT?=
 =?us-ascii?Q?X17S1ywKD4MSebxK76Juxs6Jf5YSe//xEW6bJILoyiuYWl6FOySkVHIT4o5Z?=
 =?us-ascii?Q?X/7mrUJj7QrjeRAX8qDOD9F1rVgARsoMG+k4s9vU02hHb9j2HRY5WHIsh7iq?=
 =?us-ascii?Q?hpgAmLcAHVpsfv3NiSkFPLwk7UVJ/ZMjB4503WhZCHT6sxgLSazk3RsSixYy?=
 =?us-ascii?Q?Z9Y2VDNv5xADAqN68ZK8PB7HX8xHW3T3mqrck9ws94eOOBaa3Tx8FjCo2ao4?=
 =?us-ascii?Q?uQxla4eHn3SsPlm9qbkNoPDHeWPb72C5X8rrc24tOWUJLZT4bEC1rXBnJ2HG?=
 =?us-ascii?Q?WRZ8aUoJgFNX8wApJR1vz7+CCVneIPKc9aiZYAZEJVML1X0CQWpusxYNisfr?=
 =?us-ascii?Q?yu4VS2Vq6Bqvmx/B0nkWmF8tXPLMZW7Ppe6PLAfGNQ5hf84Q2CpAN07VMsBl?=
 =?us-ascii?Q?ZBYoIYa+RGog2b1wvQC4xVDtFYrkR6ANq8ly/8Gvxsrms375I5l+8q6eskJl?=
 =?us-ascii?Q?DgF1lOfEK+pkS/i96ntObOX225CL1K+ALz01pANmm2I7OZljKdvANm8GH7s5?=
 =?us-ascii?Q?8xQ5v1OmN3jNcmaiQfWqMhCkKdE/vmWIkzb1N/pXRteN8TPVnNjjJh7KM1Lo?=
 =?us-ascii?Q?AEkB5/xAfysIJuhnyOYvHH5Zq/mQa1Kk1my+UD8V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77b693a-1bd5-4d0e-18c8-08db568fd9b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:33:23.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gmk+aET/5QOdzWT/Ude+/AUtOJMrI/1zaieB0SmU1UxM0rvDtXqq2TiDprFNLVPc/zdKtCP3KA0D9pNwsmlS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ee5ab996dc2e..95b9876710fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -404,6 +404,7 @@ static void test_bkup(void)
 
 static void test_rr(void)
 {
+	struct nstoken *nstoken = NULL;
 	struct mptcp_bpf_rr *rr_skel;
 	int server_fd, client_fd;
 	struct bpf_link *link;
@@ -418,7 +419,10 @@ static void test_rr(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_rr");
+	nstoken = sched_init("subflow", "bpf_rr");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init"))
+		goto fail;
+
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -428,7 +432,8 @@ static void test_rr(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	sched_cleanup(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_rr__destroy(rr_skel);
 }
-- 
2.35.3

