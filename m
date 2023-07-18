Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82D1842
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkkLd7ajwUPsAwrovz7U0H3NoWdLOkqApZN5gcONwSc056xrffwj4AhVLa5NMyf5Je6JVQjFVc1KncZKpUXkdh7axMQhCfJna1tP7jp853lhQ3AFEtKS10pjeBF/Vm4yyYOfh76/KpABqbDsl+iFHjj18aTW+0owMTGrltrQKvp1YoGrppeJTg5Pwp3IB8KWiERv0/Oai3lmBi0i3e7LNnjFFBpSxiry5LJOzONtWERzjqTaaVOJGPvRcP15oSfadVkTpE4FAulPO3Ifr1UggNFOaJVpBk/SIlXgNAMA59JUz6L5r5khsG3MomnXACVpHqSbO2mIIkgBNtPa8aaihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDCt7s4mb3eS7UkmqwoFCVSrxyEjbiqSn8Fqr6DPDmY=;
 b=V/MzS9Ji/0rybzcZ5yekUKcN/CGsnuXS0Bcje6Mc2h3KetTm+EN6720qoVUN6hujrkrbfeUUSDBzjKQ65yHfq/yFzZ2X4fIlXROUoRPUApWTCXD+Cn9bY3YTSQYv6+gPXHE8q/aQEp6ljuJGDAo5pS20fRgyr21CMSC6P2SK5jTMCwdLpJ1gmw4in8N+3ty2ZF9X8dbbL71eoqegHQ89nZ7KyqnlTPM5qN5Zpv5r6Ajzor6A6jMcOf/CC45Ks9sc7A/4UVDAZXzKMRhambGlDNghH2RNNELV2QR/FBVTlo1nSIc94wH95MfILmn2fpxkaVArTTiAOzJDxRpHj5Aqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDCt7s4mb3eS7UkmqwoFCVSrxyEjbiqSn8Fqr6DPDmY=;
 b=3RYfTIQBkaLTrEs3hggQZEv4aN7TXHskS0MKKJ+TJfVGlH41uBBhiOdqp/E6eVk405T92zAvzmr7YzKb+68BicdEDEz03jlmtomFhzEeQ1x0QRhglNQotGVsglB4n+DPIfNZlIwS0NK1HzS+skaWga/QjPXlWyFN/MQqlJs35qj5iK7DLnSqi328ve1qII0SVrs2ARgQgFmOOzqGdO5aRn7ckFkE686i7IWec9YpIXj0KA07QbHhluWP+lFYydMEwjTl8ddDiNBEc7XOrOEHWHHL0AlIgO47Fb9lnHjCfY5ANz0CC+6QZL5a06EyfLecmRtKYXZnnVVSFu6RM3zU4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/13] Squash to "selftests/bpf: Add bpf_red test"
Date: Tue, 18 Jul 2023 11:36:44 +0800
Message-Id: <bce4c824b47db00c99311824aecec70c62bb6f1b.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 517f42d1-5b0b-4b8f-6534-08db8740620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1y6bGBsXL6yMuD/j25cFB1xo9tOKhmuPUxtJLtOCXWFoMqZSSnn3bjRtUtTvqbK4jprQsmQje3S6UTMm6WIRXqOmNyEjxEeYuQBEtVOex7r5xCKPz53KsK8Cdk1C3pLHz7+lG1lqLANAsdyD2vF8JfgJgSOxcXdmxiOJxjf3ysx3EOhJKpF9WeZFlzoVqLNfSAfN7Kd0pCKPqGdOkyNvrb9ghB0oUambZ9E9xlsV2xVe3ZUOKxxn0nSUoTgMEg1qz/QpuSd/nMTvquKIvh3mxT2GtQNSowTfZ/bAwDFeC71VhHbJXmw+iij13FCI4DszNb3TfwdaNSssap4YGOz8BLIkTK6mgxXu2YgCI4mXeExjaWetDpcP4OYZRrT3u+VnqzoI2BKSyWCjGhcfrzByuSDG5HyAaUfH6ThGJ3rhEhveoAyGlOxZSk0jZVKigZb6QtaYEnQP/rQ92H2KpWH/aF43gGOd1C3jhkCnQBecclOj6hrfd5K0hPxVcF1WjPWSvGM2U/Hv4/gmhjjTp8S7UTNwy7OzQJ7m5N/mKNf6GwG4XYERWhiKCIiWNApv0CWL5k9Bo3zDh8ZJecNp/SWLI1zUQAZF/fPy5bpiX3swyfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(4744005)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBEF7IoytkJYIc8h/x6K0Jz9mQZvqFlSDMBzdI9ZBDdkJYw7nrTvWMdQe8qp?=
 =?us-ascii?Q?aj4zP2BLr8fghtyYo7rCKzYwXYB0ImfDOYSgsC/qg34QhYMw+qX1ePQeIAHe?=
 =?us-ascii?Q?d8uI+J7OZHSak09X/1gIl5SG5DckUqdLAVORcZv00tBLD8vLKmbIKTDH6x+Z?=
 =?us-ascii?Q?9Vxgy8isBGuJjV4VYrSu/XSsMtC06Y3RTkULmVdcP/3eInOmgrfFh6T1/+bC?=
 =?us-ascii?Q?UPbcofXDQOWmCPXSKBLVfbVyAza0cO6dZuGYEPF31Zzkpz2nOkasuBkDMSyU?=
 =?us-ascii?Q?80uG39CxT5UjkmvyiI+6/TDbjsksU81S+zBSDgU6klnJo5IE8J4i43/mHMKV?=
 =?us-ascii?Q?MNwMfKeBI4+ayymyb+2rv+a0WmpPEDtnmmdQ3oJs64os4MiCW1/CruotZa/Z?=
 =?us-ascii?Q?ZYb/iCkHaYqGyV6JV+Q3yAwtqYckQCuA/ujEDU20MAj0G37gXQBFx+FLgluf?=
 =?us-ascii?Q?81e44gZe8iiPangvDeHY5WZ+jgGscPhEDAsBrN5Pr3WoWDdOJb7WUjBi5UrY?=
 =?us-ascii?Q?y5h5qAp8cdqyki8aB+6j8H7CKwBhOGC/uT3Q7aAoB9YFa+5/QZ1MQb1pSKwB?=
 =?us-ascii?Q?tescONjNaSw6OrELxHcWHxuESqSaSSAYrpj5j0qDgfXYIfVFPuBdxOUXn141?=
 =?us-ascii?Q?X/FNpleKDv2gAdmmBnM5XhIbTJEQdnjeior6KgDGzQqy6NcSgreeALTatSaD?=
 =?us-ascii?Q?0cRjUaZpCLaHzltdUQ8Opaoo3u7HoRoVdTHUPMYB0AQJx1QfeV3q0rRtRatB?=
 =?us-ascii?Q?Lmkh1zwxDobICOEZjAKzXouFB3u3BP63JwXGRp3WSOM6j+ht7Y3frhuc7wCM?=
 =?us-ascii?Q?iq3sfDVd7Bm7aToDmWaVOxTib0us0iAowhjiF79dSwKjnB5BBEEOKNl1QRyw?=
 =?us-ascii?Q?yea4e5KtPGB7YAYYcdWgsOu6F4Kgn6xmAzrq/RlX0iA6zDv3T7P05ojCg27t?=
 =?us-ascii?Q?K2UReJCU+FIyE0t6rt775kNX45xC09YT0VFnF8V2an6+4wdpkymb1YKn/sJk?=
 =?us-ascii?Q?aWqGazCNq1Q9MxlqeXk4LqJR8aNWXR3eWJTMsjpDjO/OxKGgmmOLejUkELQW?=
 =?us-ascii?Q?Er9wLQT4fXEzmGEhMZxui7Zol18illvWzTdNx34D8rbJG6A08ioG5tRT+FPc?=
 =?us-ascii?Q?kvBOC8M6w0kByoO3X7kOKC7n0CIrESgcARf+1LJ3bM/DuMkjr+mLwY5EE7cR?=
 =?us-ascii?Q?nIj0CnvX6WQUdqOdI9ztezy6mRrWcZjAZ8CpjmDYUorXcwb8XvMQgZjIRTCI?=
 =?us-ascii?Q?9CLKAjqtCcwY7cA/GMN9NZVb6TPqdLZa0rdNVj8ZR7yV7qumuBwu1OIODAjz?=
 =?us-ascii?Q?+qjLaiEKw175RlzeCT5Qazv4LbBKirvkQxuemIqRqRqEp2c3frwsOdxmXUOE?=
 =?us-ascii?Q?xdpTMJAAVWwkvSoXxVLM/4q4P+MQCKkrRAJi2XUc/f2a32p+XI2wJlljfDzJ?=
 =?us-ascii?Q?mCne7Fkh+FPwkqZ25ey99rhxd0pnkd3nMO8NK65W4aq0QnbjVqfzQog1y++9?=
 =?us-ascii?Q?Xa/LYhkZrlKSHBWs1qtXeZ8OOI5+OSbx3EBmMbiHBdsOjvpEWGj0iuCZSXZl?=
 =?us-ascii?Q?D+lxR4HyWZVEsRTuoLTElJNO5zWQuIIzPGFCQuQb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517f42d1-5b0b-4b8f-6534-08db8740620f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:59.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JIjMwN6HEt5FuA+C8xA/LpajlRA+SYVg65obo4jRbBy8rDKI8pS37kQqk8194bYQ7aUIbirO7PYVYnezuHR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Start server with PORT_1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 5e2f6504cc68..30fcc82b10ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -474,7 +474,7 @@ static void test_red(void)
 	nstoken = sched_init("subflow", "bpf_red");
 	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_red"))
 		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd, "bpf_red");
-- 
2.35.3

