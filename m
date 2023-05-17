Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8B13ACC
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm8VCKpU6TfmZXLiOJpmdv+5R+G3w/12G9okzhwVOXGZeOyxaq3m0BcGBB/0emqUNrnnnCda2ru6n2NJP4VCKidgeZ37FuNO2kXykFO2paWOrWlGdYG8U9YObe8wXZI49OEowf/xoLg4LySkNDst4Syn85T/3UmQDveUotDKECtI+FLNmfalathfewZRPJEOMUGDL8TrHdigqMmb+QYd30VGCl4oz4XHoOKaXqsAbcBuQEFbz0htvJYR41NcpZray4Dez6i7unf1v5QMCSmeNCOwy9W6hsV77IBn2gfZZn86ECm/sgfAz1G4t0WA7WZtSWGemoj8ELU70d47BVmL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3K5pMCh1PBYWjGDAUtWNb1QEi0LgeBFUdykgvcgqrw=;
 b=KWpU2b6Op+fz0kdnrCYpqOmDobJJIlCwWOU5YP0MahXUCwMzWGlunAMiwiH2yP4P+cSAKaijh13NPnfzp1OAXcsqkuHBogGIMJBBRQAUH0wFJ9IqCYIpurBzLE7LwYx30J2hI5rl8zATL7ehR6q0cdzpJwsW6CzLx1hMKPHRcqC26emWb31G/B9M/pR44hGdj0tf1nGAlPo1dduOjAgosSrxED2FlW50vnMSjQz6nF6MIFvKLBalQGKiZ8xnmK0eqvMUE/nRYXEt2RaE7ECE2LOzkMiexlUPq/OqcHL4pvAatOAG+f5BWztPz5cPOog8u7xZ5U4cNAJp+8oESTzrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3K5pMCh1PBYWjGDAUtWNb1QEi0LgeBFUdykgvcgqrw=;
 b=VOzU8KGT2Uah8/hcg0JJWmTd1HWgQwzJLKQbaXKgdhbY9kyR0TytqRuZDZKI9ooesKzUdCrRUp9DiFvV+31tGPxp/VvhUqV7wul6YL0mZLx9yfKjCOICtt7gkYsFlUnarWAX9nWRY/M4AC7melyMox22pCUR5EHTGQJzS/woEoQ+R9g1F5aSlgXlKnZNeguqQRFIniZtvXBJSNTWFBETKuKr2LJJr3zqF6wMs3pVuAK3oCZPHGKrT7gvCwUKA5EE5magLpdH5U8x2NAhYkFY53NnokUBdXN5eS/SLajacaJI/sPLKl1BRE0gZSAbD+Emm2XIG9dn+HZuDTk3OIUwkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 17 May
 2023 22:30:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:30:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/6] Squash to "selftests/bpf: Add bpf_red test"
Date: Thu, 18 May 2023 06:29:42 +0800
Message-Id: <b2f6b47d2d9d23bf00211ed098c2f0d3227175cf.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
References: <cover.1684362296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: c98c5a18-ad47-42dc-f89d-08db57265929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F4iuEnDeCInp04ariH7Zgq0XOc+3us721QYlWa8HwZj26o11v0FcCdzJz+5XldsL7gca9m6dI9pCJFA/FfSddHxLj11pLlHiXacYBLZxfGGe2G3R/QdI/pojBGg7te93XlwHA7g/4xqBL+XVxL9X7bhgSshNEMikWJMQcgrVkjNGxqvUXw2v5YkPgUul7YUxFqur32G5tpGXHtJwHRwEMwv1cDSxZmzbWyXDuHlEU8x9wBGr/LhIG78o44HZnySqT6QMcov6dRUJflRHr77YyA6kLHjEtb6ErFhMfFa6U1jRuR4XyEm255PkZVF4GTPuAMwXMHixr4wPMQIck0bHcYkXLjCpMZsjpC4H7NqHOOiWBoxyigdhd7MCrayTarR6nvjTJ8Si55cDi/RTTfPrM/bhEgMz4OF7KQXozdEEsMOOTgND+pbXiUhi9vzBSEo6PgmoySm9gQZuI7Dn0HPZchRtIObeU3teFjm4wL3K6q9/O/T/8ajDCkTSGiR4vHsaxkeeywsnGoso5pGC5+belTkxaqW/7Ot4xa4iwgjnfVFItmXMfFIWvp9aj7LVGNUY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(86362001)(38100700002)(36756003)(316002)(2906002)(5660300002)(6916009)(8936002)(6512007)(8676002)(186003)(6506007)(478600001)(66946007)(26005)(107886003)(44832011)(66476007)(66556008)(2616005)(41300700001)(83380400001)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uqOu9kuFTCvR6AkHyvIJXxBaVFiPnjjD/JrDTHdd4119acIX04Mii74DHsc?=
 =?us-ascii?Q?pFvNjY81aahaGHZJsB47LJ8bCmQY4fInqu355UbFywIhwPZnqIHhdyFHkXPt?=
 =?us-ascii?Q?2yp1nD2oAtsjLpUMhav/FQpq1CMrfOQmxUphPOhPvKMVHXJqWR0E9b1s+/Hi?=
 =?us-ascii?Q?/tyGJ8zDumbd8MKW1li5bu7bmcT55qnEXtQYFjXAvxTgEP1y3E8v62p+8pn2?=
 =?us-ascii?Q?KmnHD8inOLspdhAI511d769LfwsFmrbNHo5YyfUs7V2Idia2U/c2BymnKSuQ?=
 =?us-ascii?Q?8qcTpTDdWmM5Ot+NSiek5R979kzhwQEKsr85GIqNMHT7eChQnHwG9FAvtb0S?=
 =?us-ascii?Q?Ca2yhPVv+JAlRmvIc2wFPlv9knLlpvJY/mas9Uz/U/ikgGUoLLphsl0TQsK1?=
 =?us-ascii?Q?UbMlzy/k2L1wrCYxVR4OzMvsAtgFc9CFaXuEVhPUW6vBo52JbcLCtJ/9g8zx?=
 =?us-ascii?Q?vHcqjQ+t8jyWTWbW7Vni5bUc6kfp5Sg5kfGkDY6k3p4Vwug9tNrLE73vmQ78?=
 =?us-ascii?Q?gqdqPNOwB8CYRFxMZiCbfy6GraaHc2a4L1EWALqm3oVe2CdbbDsbncGDb+jl?=
 =?us-ascii?Q?5no0/7W9nvBxb8WQ1CNhbp8EetU2yBrYFkDYUTBOsksUshlVUPvcJHk6+QZQ?=
 =?us-ascii?Q?UgDIGsJOsgXu+EOrhtogsj/Dp9FEVdnoYKkJXFKOEHOjOaJ2W42e/xukV0Ah?=
 =?us-ascii?Q?v4T0MYpPEszuDmdCu2wkDJSH186re9WyRXNr+LZm3inracsnfXfXnQuBUSJL?=
 =?us-ascii?Q?I050L2pluq7hC3S5uLkJtWNQxVwDqpX4w1pCQycdcycatttc1TdxZsSuHaF8?=
 =?us-ascii?Q?d64CbDKx8tV/QmiOUN8OVbctHP9udZVJDoTgaZDq0SYleaoubMH0EkD80xkL?=
 =?us-ascii?Q?UrS6nd03JKs2FdrYzA+s8G2fpJBntZ0llfYnYAFcTasMX6m5+mHfW6ccMto8?=
 =?us-ascii?Q?m/zNnM2Wbb8OFkkU3NJJ7w+nDF6d8sfA9CO0IiN4C414IBUyaHYvyaIyYB9y?=
 =?us-ascii?Q?0tQFXr778hYYQbZ3r+xEyJVD46SZyFRbevUeSY2Lowc8lK10Mm6p3vKtOqbS?=
 =?us-ascii?Q?INjaifN/RAahslYQxbEVZ1oQ8UGJPIso9nQNd8YeblMEo4IvHEFnArVbM17w?=
 =?us-ascii?Q?VrASh4xV47byr0H2ich6SmiyuApfsuy/LDtF/mjWdDqz98asDCCXhri+32UG?=
 =?us-ascii?Q?VIRxrCoCUwQDTT+Uhy3ORvNaSdyRSMFWfwCsOl9plkSmqOXGRrR7jS9Rw7GM?=
 =?us-ascii?Q?suQ4Z+Vsp2Dp8Bh9p2wWNc1QHrZW9n/C+1P/wcnUtneqBW3/OAj7PIEt/ADf?=
 =?us-ascii?Q?LV6tMgypgm8V6v4f/3mr7dl4JTXLKQvbxyDKWmhCErgDSehEqq0CqAcIxBwM?=
 =?us-ascii?Q?EiaNNnOH6BTA2b4S5J/trBfPFb4ZfDIPGvqbhw1/FLMa3gxjzBDh+9qH8gTJ?=
 =?us-ascii?Q?idop62T/lFueZI9/e7rssYcSXItg/QVObFRhGldsndMcbBA7qzEUJiAar6Zo?=
 =?us-ascii?Q?Q4qbW/By/OnnOkgp6s+7t4dEj6ymdRbwKZ87nNgXu9P7168mnOWFTtzz8yTl?=
 =?us-ascii?Q?OuoidXxGCFsiRfvwuGBfqw2YDvTQO+81IGlJ3sYA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98c5a18-ad47-42dc-f89d-08db57265929
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:30:42.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9/5AF11SPrJux+DDJ/Gx7zcw70kPchFr8w8XCofDGeg4OAGWRc03ChLpSU1Ii28xEZgtDASuBEG01lNo2431Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 13594084d095..a968641cc94a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -424,6 +424,7 @@ static void test_red(void)
 {
 	struct mptcp_bpf_red *red_skel;
 	int server_fd, client_fd;
+	struct nstoken *nstoken;
 	struct bpf_link *link;
 
 	red_skel = mptcp_bpf_red__open_and_load();
@@ -436,7 +437,9 @@ static void test_red(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_red");
+	nstoken = sched_init("subflow", "bpf_red");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_red"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -446,7 +449,8 @@ static void test_red(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_red__destroy(red_skel);
 }
-- 
2.35.3

