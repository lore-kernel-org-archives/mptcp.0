Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670917C8
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 04:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHQhPv12sNr5DMI4lAyEy+BwLD6DXLAqyZcYAYFFkRbaQGxQgqFBSC/H7J4A49mNcEZ+3AfEYLbxlQ8gPughdfrtEfDrXIDYvYOXFHfmsYB1pmVwC5rUfq9N2+osIfmV9889i7NgKKF+iRKsP/ME3lkn/CSAbJOsL3mR9zLiTHe7MmKZINYpJuK7B01KRCOuoMJgbuq6tulgACZt++8TNgJkUXr4iKXYXc78A8WHfchXrywD4KPKMvWKjmklFQkqEzH8EDgmO8eFsV5TIDIga+mlWlLNIDzqExoKhe9yGkQwHkOSLOFn9WktnE2J0KDwq8QFgFwxXtXlZGE0zJmM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RVyuDTgQrbTF+htBlVnE6y/U+/+VnYY6ya8ROYRqNs=;
 b=j3iiSJQ4jRA2qNnQWxOiGjm/jTk3ILlNUyWF4d/A3JTqqc86zMk4Nvp/7uZc7foYdIKK5dRJZlqV21PVpfM415eNfrS/sy1veOhR5qa/QHM7rtkMXz0yw/Fb4utlgCr39vxy0iLH5n/pXMpRy4zAFidNjfX83uFwA6O5Tk0rAfTen8b7q4bf75KSxM/pP7QGU/IWHQZJDPreTmWsSJ4gcXzr/L/MAVOlZIynYrzz3FHDPJJxNf5yEYVYvM4oGAiBdbAsyDzbf+f8ZHcPTzzDjRg2DJAigaqYL+lu5Rc7ukLORRYpCrtnvzE3HNwRRnb1cWSsyu5XRFNpDAi8YVeXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RVyuDTgQrbTF+htBlVnE6y/U+/+VnYY6ya8ROYRqNs=;
 b=ce1t4Jfng8twRa2eceJlwihOZT6zD63+Q3ko/GOvYeF5lRlMn6+Y6ZQazqkEa4WfctAkgkGcZjH7FWx7XKNlwCmo/csfgfYIMGQbVe8WdxDJf5Royvpnj6r8ZRsX5oimOvPaj8HdToUIj1L13tHuI16Gceq8/U1XDVusOpvEoGptWmL8CpDG71ltBjKt3B0ZTq2T4cBdjn7+uYC8VD9jjH0ZwXfkS8gGfznoOu4z7eMS0FcC4PHN3124ColT5iSdZwiSpLeUoUuzMt4JY6dUD3UH1j48WILQ8+Wxqo3SeqNCXEfiIIydHBXRO/N5BinXIWXBPJU/A6EDfWKEes0whA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:33:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 04:33:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Wed, 17 May 2023 12:32:48 +0800
Message-Id: <fe6b0a3f5e7f4a7f886eb34fbc5ff97a7702d5c5.1684297911.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684297911.git.geliang.tang@suse.com>
References: <cover.1684297911.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbb97de-43fc-4f08-361f-08db568fd5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	icGPvCz/kLLJDCmNBPmGN2qHD9DeNsGBEE9f3IrWSLO8tIj7nNXY8J4LozE5p1XUgTLYM7iA3fTOL0AuqoC7OeL+/b94WvvzbVMi2ymoUOK+/XjkamGvCRHvLVXVeEBmbhNqOfa8irUMW+yQIki57kTZQB2pKWC3A85ziLF8tTbNSeEX13mzQvXvK9N2W85j6n52X9DJovS9lpQXRNQPtyIG7489vW8vp3hjhU+IdsgKLU6EKVcDsvtPZAslTseyw6328rFBTf3fMLP6VAJAWloIv7QCccxq83eNYGaoam7uFttWk8I9zuNVTu7SCrx5zJm/ne6tYl1IkS4WzSIk3mdu9UILDUEl558nN85IkAj8d/UV6VYFWowjCRT5kev5QEKOSfQ/9f/CWm6NmFluvh67lkNKuaNV0zm05lJIHqQvGsOnyiTOHvKLUmgujSFP1yq598k517D1GFLz1TgitP2M1z94+7GYIC9AlvrxfkIRzl1JL1nQUw+AQS3Epc+RRPeKPDSpjer2e0WodsbvKzvURsEFekPFZNPH2PotQsdsX1sCAh7JBRlewsQ+FhVD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(66476007)(41300700001)(66946007)(6916009)(36756003)(316002)(6666004)(6486002)(4326008)(66556008)(86362001)(38100700002)(107886003)(83380400001)(6512007)(6506007)(2906002)(478600001)(2616005)(8676002)(44832011)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KU8wKWS5FuKMvcaOr9Hn9wkwrPuCyBoP5zlkLzzLTYr1axpJue0O3qFw1QE+?=
 =?us-ascii?Q?LLKWBMPB8Lksyw4h54el3d5mYatIHRt08L409aG2h/l2/HnPN/sQMTvfeJpW?=
 =?us-ascii?Q?P+V3Gk9rpBhHDh2tZYwJ+udC8DWDEuAW5TAYk0xHtixgcoWuHfE001TK3fjN?=
 =?us-ascii?Q?/ZnVL4wSqxLjYjjaFzH2eyROYzpv8N8DiEKSHR8vuz+vaweJRzFUGSy9WwU3?=
 =?us-ascii?Q?DIceoYYN7xsFOZjPYGKn/9nAIGgR7Skqu6Y64Yry7fiEA0PZhlgLHQ0BmJsX?=
 =?us-ascii?Q?MK2gwsDPdJWgyfSVe3fqMRmd5/Sy717HL0nIxzZw48mlWSw7e3YmUOmZBEyN?=
 =?us-ascii?Q?FfyMaBe6/ZAI5ND7fE9iUa3EEDHn+X8gp81vTEeAAV64lNAjinPpUBnYCszV?=
 =?us-ascii?Q?gQTBkTV/hAUc/D96CZMlW9/SfnesboWySw/ri5nfMUqn3njH8vUSfI8Tsn1P?=
 =?us-ascii?Q?/bn1F15lYxzZVUJki82S8gg55VzJShJ0alIj4w0J+tHgO1rwk16N9eKqRddO?=
 =?us-ascii?Q?B+0xqHSAbVq21RbM62Y6vPeEwrHiiZ6POcAK7FLs9GzLkdjJSk7WHMMxh6FL?=
 =?us-ascii?Q?Vvbt//+GY4kyxHnqjYeCamDmdAXNhzN5h6nk4GkFP6yJNt8HNdZADP9DpDzx?=
 =?us-ascii?Q?XCYF2w3vDgIRzwvfdKTYjFDuGsVLjvsiJfqVXiXu5NTeotUg23KzHdI+aO0P?=
 =?us-ascii?Q?qje7CKucbX57j/3KURDJHFXV6l6Cd82sWXm5ShJ7BPRyojXmFjxGsZ7QJ2pr?=
 =?us-ascii?Q?XERjhMqM4JdHfg6b4Fcwua+zwfRFwb1mHsFnQuKe4/JDmH9IzVcjIFbLuHxO?=
 =?us-ascii?Q?i4gN/Okp7McaumyoR5O5idWwAuXIQH4YkHRDIzoF4UQlVc/cemliXFhexYyU?=
 =?us-ascii?Q?OBPrdZtsdXAtHU8RMC+edGGH02DQB0cqBBeinfMqFVwXhFYOgEpEm5ufBTIA?=
 =?us-ascii?Q?xMGeO7byp9MmviC3OA1QoJdSPqwdkotJUlZ4Nq69XdRT8O8B9bJGmTcJjD76?=
 =?us-ascii?Q?ZltSOpha96aAnhtFpi07KOgKXAp8dwF5oNdxT2z4pccyQf+Q/KPyNKiO/d6t?=
 =?us-ascii?Q?snyzu7gcniaTQKcGO0YQWiZQzlzYb2Uf1dvrMM4YTuf/Laajq+dXPqPmRzaD?=
 =?us-ascii?Q?c3FV/P5s6/qgiSZFeaGBOuAUNKZP+sNuUCeExeUxXOHQKBHWm70C+bjBnwNJ?=
 =?us-ascii?Q?8dAeUFOaYri+EkOKjt84mYOcctKNPv4yH8n1z2OUjCxagzzIylogRIscCvmW?=
 =?us-ascii?Q?bGCW8UtaFQMdybo8emdCucCwwM6NvOlTYKX0GWBJAW9qVZo9LBuVfB7Xkfkc?=
 =?us-ascii?Q?IBbe7+XoReqsEtIYDRN5wUeY6dvyD0pAJhB3xedyuYcy81rptJQI9VwOLfaL?=
 =?us-ascii?Q?IYk0cXpAv4bS+D1q7p8712+60/MyoBHSRuGcg37n1+miCZ9DMPsm8ISbZPQb?=
 =?us-ascii?Q?4k+Mb+RxjaY4DdDL//QKQnIk8LjGiyH+wYrOqjWJGyQSHuE055bvtM1uSwWb?=
 =?us-ascii?Q?KbafI4EqMHHWofBLRSngvs0mw9+Kygxk8EMk7NGybjZTBNsgmCWsECOpcqHA?=
 =?us-ascii?Q?cSsNRYo6UawDSIWnbtWVbTYXkKEPHMft9c9FPJXd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbb97de-43fc-4f08-361f-08db568fd5ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:33:17.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luvI2wOAyEOI/08b9qPVma0zpbn0giU/4Ma5Cel2ILA6ChnC2dKxPX5y398JVAzYYW/hb1hts1ffqCEkwMMvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c6fd5c2449f3..ee5ab996dc2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -369,6 +369,7 @@ static void test_first(void)
 static void test_bkup(void)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
+	struct nstoken *nstoken = NULL;
 	int server_fd, client_fd;
 	struct bpf_link *link;
 
@@ -382,7 +383,10 @@ static void test_bkup(void)
 		return;
 	}
 
-	sched_init("subflow backup", "bpf_bkup");
+	nstoken = sched_init("subflow backup", "bpf_bkup");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init"))
+		goto fail;
+
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -392,7 +396,8 @@ static void test_bkup(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	sched_cleanup(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
-- 
2.35.3

