Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CC10971
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV2dkb9mSkvhad0AfpqUEhQDujKRYENnoT7jz+8EyCnp88mchyocVWda+DAOJyzYBkc+7utXxLfBTvqz/xDbmMgw4UjUs4tCLtbQzMM/z7umOuSaxlc06/xaLUqlxNaJwv00wrkD2NyfWD3cEN4p5qJx57Vt8VLQ6H0Dg/RCGaFnaB2AOZaEzTf/Eg/0y8dCGWdX8+ztFXRNV4JjguN8WHdlnhet2FiZi8XwgmVtkgtn09UP//UmriwUE07sAuYFR99lwt/t0K7j3vYvpRSsv/WYmhxmeGdBY2P3OItzlkXoO4EzQoqq6MUT3VNE3U9KkMsmlBYD+FDDX/9fcAxs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXT2QaREdLCxv+2uHZWig1av2cW3NPhWl+JoQgOfCNg=;
 b=JaETidERSBR1k6mqzvxLLrVFerGtcoIfNwgZd7CJ10FZ65X7aieySnbVryCWqEE30QZJDDJ55AB2blYsyvPv1IFYOqIR2YW7108x5VlORWN+RpW7rbzI7GuY2eWJwGdHasgomAD3I34J6t5j2p4WRS6XFkzS9ttZCQOQF/RtTK4ExGmjU9RHH+IYBLfg3psPUA2YcUMFPpzPPD5tfEQS7fkFPW6Th1Vq4Sm4rDTq0l5FnfBgg4JCryad2HKGsg1CdhSrO7nhT3rXTcssjVqm9NLpX0lwjXL3Uw1NyWe048Ce3GCMLlRmy41TWyaI7Sad8AtSTXAK7gZsUFhqlIu2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXT2QaREdLCxv+2uHZWig1av2cW3NPhWl+JoQgOfCNg=;
 b=sr30z/FgGWEN9Z9F04KltfjqzK5yI2oUagKisR+ZgMuZj73PDQK9kaT5FlqjP5sJ6VbIRQxL5TETKRGLbZxSlIle8t7P4blqUoir8ZnX45h5vidooZ1I0/HHmGGkYRa/uP5ZzzYxbqvZeJJrxHJUtfh5n2TnbtGx0X9sSt+6es6DuJvRRZuZvZnRQEnpEsa4tKRNTjjEcCH10g5E8IA9KY+FsQwDhFETvR8jS39//fjD0WjlFpmldv/mlNeEpZYNwvYwz3A43mgzW60yOG9ah1oUYcvTrp64VIcFCNdA5USxVXL0ih5AZI/1HBcQKWUhIkT88PsN6nALV0T4BUIeMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 17 May
 2023 22:30:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:30:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/6] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Thu, 18 May 2023 06:29:40 +0800
Message-Id: <1ad83800ad1ba962e5f3e4d2b4363a6eadcef622.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
References: <cover.1684362296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fa937f-e6d0-4cd1-28fb-08db57264f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xGSkj2wAZzwT898CgCgy+07vJCyiilgOTAN+XEwIXHx+Diy5aevJHiqxhT/MXuhwgJIoput3eGKKK3PFxgttzFLI9gozP3PC2Y0dFfelyEE773Lux1wLaIMX5WqMfwfgxzHdM8iOZ6GMHtIp0fC6FPKURmgSRF4WGfkec/wXvhw1ulNhsbcgs3z3WrnmOIziKRLO3MMACDupyjSTKNGL89SpG2a90S2yL961S/XQS38mSnDQO8KMKFNbsGwqyP1UBeJTwOD5ujVA/7/v1dT0tfO7iAW/6m8CXHQ6YCAx6Qo4vr3qp60gEWFdorLAHimnK0e+uSnKIeYGqiM6PxTg3k8TEC2gTqndxBVvvABAC8D/mI0gcOBXiSQh6M6eFlNbFfsKbsiVWL++DfdjuLl3ANxYuW1htNukeo34Hox7FK80FAUyqABwWh2lj9E1n4fxX0Yrt8zZcsA5yYHczlDvuEDzWjjdLIGPHeoRoPJ7zjGvFz99WRT3uhIwlV5qJ2m5XbD6Uy2fBEbRn5nsFF5efE7k6klp6z3HGsZmuAroeJMPxdfKO+XFXbU1J5IvCQwu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(86362001)(38100700002)(36756003)(316002)(2906002)(5660300002)(6916009)(8936002)(6512007)(8676002)(186003)(6506007)(478600001)(66946007)(26005)(107886003)(44832011)(66476007)(66556008)(2616005)(41300700001)(83380400001)(4326008)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrmGzkRSRwAuM3hDwjRBmc3L97nbNWhzL3iGSVz+KShy5no8ZDmoSHqiXJJX?=
 =?us-ascii?Q?IkTl/lpj8S/zZg/so9S+qfeXRof1dMcS6XocN5k2wgvPQjQ8Z5mQm3TKZIZd?=
 =?us-ascii?Q?Bp/bDf+oShPlXXwWdC2bOgyMiVBQk17iQ9ePty9h+ER0Mru450/CDLb5J7Hd?=
 =?us-ascii?Q?LvO2HTlejCa+wCYJaCWKcinVa0b5BOMz3ElRVXyi9vCJWVEweq8hOCcdEyWZ?=
 =?us-ascii?Q?u3NHjCG98JyuY+LncDEb2acmO6GF0vy2uW8oN2KPBPoiEdZXjEl1yfhNODD0?=
 =?us-ascii?Q?RHx03joQ8JXY2qkF1r2H80Gdfw0IEvgDxflVHq6VkGVUSx0oIM1oTPEe8f0Y?=
 =?us-ascii?Q?oSwIKrjd659wPZmMay6tbDYEUM31C2yfOlQRsUln384pKsGmV1eMaNO9OrPZ?=
 =?us-ascii?Q?0n09V88xx5I3eQdieVNvivGFj9pKsqDt/wxuS6XEkD/SRC62atZIh6j8rP5a?=
 =?us-ascii?Q?j0tTaZzllcXVyWM25tLDudsDE9FXHksFYuf8pOBNTmsOofbtCSbu4VIIQ8fa?=
 =?us-ascii?Q?m6OJ77nZw6A1AMTa6c/5RGxx75baYBrrMqVH1iI/t3Kc7qjkfRQohnjzihRk?=
 =?us-ascii?Q?Y4/JgJv4r3PCn/0Bqi3wLOnHMt+Z8nwoWeJhri4WpJ6BoNlfchgl51Ekf5Gl?=
 =?us-ascii?Q?k6gKcssrLe2xO1RDvx8CwU1eJRQA4zK7OEheUl9fz/7fChV92bev6gXIrpDK?=
 =?us-ascii?Q?Rn/iRvlyRGoWtgSBlFO704EaBcJeK8WdqKwpRZfd5h4eZ9LfyeJcfAPmIhpZ?=
 =?us-ascii?Q?5qT2zqQ6NtjqglNWjNs+PzsvXpJnFC4WZjEgufyHx9DU5vQ+JaUZn7ihP+40?=
 =?us-ascii?Q?H4M6M+gp3hER0yzJorIDxQZFWNVROXTabJQwgV7Ib8QIokju0lc5U1O/juBD?=
 =?us-ascii?Q?YetDEeWQzSSW32d/RbG4cCGeqipXoCmTacuCnWrSajBXsllUHbiA1pW+2BO4?=
 =?us-ascii?Q?CX6PxN7IDHhPKPtInKLgaPfkplqcCm4xC8xamsuIfvjOVPQGn5H3CA6RoLDp?=
 =?us-ascii?Q?xGm9aO0+y2S0KQSFvxWgKGAjrnpLWOjRm/dQ/5V7vKQa8YLOP6Rtw4LEshIf?=
 =?us-ascii?Q?wwQqHiiYNPmGqG5wRm7D2Bdug9p0u6AS9ZZ1E9QdbLXTZEP3sd8Jf59r2uMF?=
 =?us-ascii?Q?s6oImb3N+PDlF4Slb4gSJ+2L57kH+A25sGo4970q100AZBYunGDnTTJx5hwz?=
 =?us-ascii?Q?DVjfWhxHVu21LAvVgHqarAjxPYr6zIJ2reTPjBVU5FvST2XVI9XkLsBx9ovC?=
 =?us-ascii?Q?mYDrPBvY05Rq8l79mLwawGLUtKcd0Zbbkbv44QpXrgoN1ijh0gNV1+dW5Esn?=
 =?us-ascii?Q?T8y0+GJNh/SI8MmQCcRy2+n1NDtay/mJZNJfLhR0/L1/o73HSSaI8duLxbpr?=
 =?us-ascii?Q?yW9JLc7sqe4On7vpWLxQkaRfa0bkzxi2SUYl7aLb1Xl3+28NP+O3SnwYe9pz?=
 =?us-ascii?Q?io2I2giDNdU6dKHH4Bz0AvBm9XL8jrQKpRNK2Sfqlvs+KrET78/9Y/xhDsZ6?=
 =?us-ascii?Q?LJLROoe8n+NgUG1FaB0RS0WQNdJpKhpP1o4dMrmfdOQ8ZNdAPwbxw49RxlsO?=
 =?us-ascii?Q?5SkCH1KGOUXU1GrnXYz314DHdIhduevtLU9Jsw9r?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fa937f-e6d0-4cd1-28fb-08db57264f65
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:30:25.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBW1zjhAvQt1E7mOYpgmgRISTuwi8LpYxJLGwQtH0SE3duQ4EKZJ0abCaW4qWnA4djcFYguM8l+yhEDUe/V1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 85e37e0f64a3..3d99b6a1aebf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -354,6 +354,7 @@ static void test_bkup(void)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
 	int server_fd, client_fd;
+	struct nstoken *nstoken;
 	struct bpf_link *link;
 
 	bkup_skel = mptcp_bpf_bkup__open_and_load();
@@ -366,7 +367,9 @@ static void test_bkup(void)
 		return;
 	}
 
-	sched_init("subflow backup", "bpf_bkup");
+	nstoken = sched_init("subflow backup", "bpf_bkup");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_bkup"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -376,7 +379,8 @@ static void test_bkup(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
-- 
2.35.3

