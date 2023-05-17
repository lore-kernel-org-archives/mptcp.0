Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD117C8
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 04:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkGDi5IDaDLAhiMEt3rpINbwsFYbJt/v/68bLpjutIWd0/ZowXV08q3swYtME7+oQuLosULlUB7EigUJq4o/X15zIDlJdO9iEOWvEcQjAVWAK/dUDCbYxYFnwpxpYKyAcwr27EOYzClZy5tBEa+ETU0VR5UJpTYAIqrbsOC9IpCLUbdXLaETa9HIsPn+L0FhsL7UONvxDWKOwwIw/bK5Zaq3dll7LyEHQenvSoudhuEE0hL2U0MN/6ST4pgWrnX6vHnEp13hahVo2Y9KsrK078S4S90mZlzFD6ldxaNbEBm62ABWI9Xz3fs93NQeqzmMt3ZnIr4DBzlGEZTNLg3ZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOba4dhFkb0E8McjMxQmcJkYzB2hWOWDw5/7QQd5GgI=;
 b=aTM3AU1YmZi92SnH7jwV+WUYNxOb2mJZd5zy7u8jDwRAPF0lX9/QOfBAmJ4jRi9/EauTQFM2qQLA/MMctTRoszT2Lqk4sCWW4LTyBJqgpe41WFbXI14ODoZB1qjjtpPCcwvq7bG6rWbkU+sy5dfyLmXvctstiuTIH3mG4+XT1Ap2cR3GFoxxDWZKUea/3hnAwFJlyeEe8wvJw7fdJAEVwBprVGMOxd06EyRJW4IJ9iviM0dUf6zyFzC1jd15GPbcVnmDUlovRe5mB5m7UvrxOXgwN7VRkfTWAFHngv5wTdsydF5NJqTzKN146udsnrdCiYdRUBbPfOqIiaFPdLXapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOba4dhFkb0E8McjMxQmcJkYzB2hWOWDw5/7QQd5GgI=;
 b=gCHBQLqGZz0pk7EdCCTVBEE705GeCDGZnm0vXrfX1zPYvaQ8nbWlliOAT+UjRCu2XazVcxzE7aAblNzM3Oo4C9sNtlzb+480bhYo2CXiptlshZhW/7QFCKyTTFv8V6MZbcDnXEfYTpGOUz6tvfuViNYNXgh6zQfw1C4xa8twosx/KZDQHR6S2JmVBRV850WV+TZ9A6ph9WoOp8pwmVwgaqkOdHeZfqP37Cf82b1NSIPf2oBw5sa9FvA5oypQ4ZkM/J0zc/tN5BsBxVpmsvPbWJXYRu0XDEJ4dvYFriqWaf3FUbmTmEBoV4AHrjxEGdPcT5EdTYiGvzz44YXrbchOug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:33:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 04:33:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] Squash to "selftests/bpf: Add bpf_red test"
Date: Wed, 17 May 2023 12:32:50 +0800
Message-Id: <ffa2a0c237bf2046ae89bfe8334a4cf88953112f.1684297911.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684297911.git.geliang.tang@suse.com>
References: <cover.1684297911.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 1002435e-0bbe-45d8-bdfe-08db568fdddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hjyv9ZU+CVRx/zzJjiDCxJw7zEoTfnt+2RXw4eULGvvKHEy+imTuyRVPBIgQdgqeHy/94prRI+G2HShtcj9moQIHMhjxTYVEh5S0zgDu/EM5U/69EBWFZ+jYVksGkW2nvH7yHqC2zmpOd/4hfcK7j/QSHDq6gL9Xse+k2L16Q+ZGCCWPxW/tK5JjCT+S/jMFQXWZiNT9uH+OCZ1vuTmkmS8R38MmHHhnBWI24+Zb/wSFlo/KBZD8wuca6B3vtQU7bfFZlCdJzJ2V61MytZzYwV0z8nmn1tMHal/qZ1XCw8PLox5Hlsrxr9Wuy33hnkEL9en++w82D0H4/9Dp5b0LMmo3/pND7xIvlkDApjS9Ucpzm/BwxBjqUHw4g3+Pj4N/mrz5WeuW0Lt7z0ZYzMdCTMYSLdKabuzChNFfmD1J8h7cRVBvtpoMulFB/18JXtlN/GfaK8D1MJXBwX5CAzu7FS2D5aDyxU3m2xi3TxO+tVyXcVJiVBJzKcUMgH0ZvZ4Zc9H+G21Y8W2IcX+t6wE6jDC2osqjvG9xfibGXLURkioC7P12xuEAoD+bt7h21HUd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(66476007)(41300700001)(66946007)(6916009)(36756003)(316002)(6666004)(6486002)(4326008)(66556008)(86362001)(38100700002)(107886003)(83380400001)(6512007)(6506007)(2906002)(478600001)(2616005)(8676002)(44832011)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9njp9J2M6/c7bm2pA9suIcyYQuTKppkQdJmBYiW0UbYfuM/sblvMzQ+ian5S?=
 =?us-ascii?Q?jEn/xePslAw/e+iQjIX3nWKU5dm/X89GZ+MNA6RMUy+jk4rGqfI0c/exFlZg?=
 =?us-ascii?Q?wpY6Ik1/oLLoDvmXzJKasmpQ/soG5j4NgOprd89XF7A1F/TeqnJdeI973L5I?=
 =?us-ascii?Q?RShtFk/+n3x7BCJbAB/uGFr+BjeDhUiewm7Y0ZTnhxn0ispfWQKfrCkInZtB?=
 =?us-ascii?Q?k4FOaMhPhQ/6kfgoY9nz5wl4FiofM3aRgjTk1GKyxoSNcsaUqiyCe9JE15b1?=
 =?us-ascii?Q?sN1HQBRwvy2IgxBqqLufM89XdwG1djCMW9uA5ZJv4i4L8D3fKnlXEoUd/qdA?=
 =?us-ascii?Q?OPYEISW/37nL7Yk2Ry+HQhjEC6ToTfBI7N3iBMKSkgILdijZvdu6ZwOhHfoF?=
 =?us-ascii?Q?GFZCzuX2ZaPaF7KwyCwjCAkQTt2YTWq1PW1FB6oL8OV5aDFKvbwKvj+rfeED?=
 =?us-ascii?Q?XNfBXvfTLKOyyI0V8VIYByWLjm/fVqfzH58W89RPqaG7lNe0EIsetAzbkcwo?=
 =?us-ascii?Q?x5ZEb8WwSMsfCiqe80Qudn9yj7DtYgY9tgydrQOEJ56+E7EWz7b6SzP2QlL9?=
 =?us-ascii?Q?CwqiCYpeuG3/f+TOGoT/k9KHdCVanVqHrg47xnw8rmyMokdFL7JmplOia3uZ?=
 =?us-ascii?Q?7XzQH0tgebj8nQyRpfC/Qha0MXcdocSVOyzJMN5wxcUbr6m/w9fslD9YlYxq?=
 =?us-ascii?Q?hM9C3Bk2AvQnKAuI0pI7arr06J1lu7HBIfKaKAb+8jO5JLOGlFVU6v2i+zvZ?=
 =?us-ascii?Q?stFf3SKn1l1N+5W0H4Oxxd0WWNG/ubtwnE69f6cyUEsMhOVvSb8IPIg1My8U?=
 =?us-ascii?Q?iISoF70TwU50fToIjQ3Dbrs11OFUoHw4Ib7oyg3mBYE3qnwl3ntGMNqddxb/?=
 =?us-ascii?Q?+mSEmCdmQPTcatwFLhC28OxKjyqRejarHBYMj4W3pYX3fb+47nay7qkMoKpX?=
 =?us-ascii?Q?9ystIKbY1VBLECZJFisXyeIhC4knIhpOFNe2Zb/AwYuWTNDtFHWX7cozHAC2?=
 =?us-ascii?Q?JE6WO9JJA5dOlipCxzNfYK2p3bqbouF2l7JQ7W77EeEyfSb12BIQjQhRtBtf?=
 =?us-ascii?Q?HZVwo/YpRRTfmW6uwuyxRyvP03BO6MtKnse2C/kZbyHGAkX6f3HrFgONJTZI?=
 =?us-ascii?Q?zjZQcG/+UdsryNi4SoiMihz7NNk9WwzXQYahr6UPyPmHdkGgalqot90l6rnM?=
 =?us-ascii?Q?kv46/avLFrjplT8Wi6jfqUp6YuUXszGf+MCTEvxit70N2tZDcyMvanDF0zGf?=
 =?us-ascii?Q?77S64X0cDmqZCpedeg6TE91b57Uyg9YCAeSrrGDKk74gnFapICeDXbvo486J?=
 =?us-ascii?Q?LVIvWPYArhNbC1MpM6oIMKFTIc/6M6pdzHBPSLX16EhYgQ8ioeAuVcKGHuYE?=
 =?us-ascii?Q?SVuo6PCVsUqsTNz6BNJR9lYM7Jyc60bQ5Nj8Vs1MOpnr+V66+Rgv0rR4tC1I?=
 =?us-ascii?Q?fyCEnEOQ7dOqzkCJ9rtPzY8qt47BZlPWhvH47NDle9cfA0Jx4/A8gvtvX/c6?=
 =?us-ascii?Q?xBbGBAwxJln6VQbUY1dglHq8ZMi/z/o96ygopBlMg5tatcKamrNZ0CVQGxiK?=
 =?us-ascii?Q?1DPaFJjzuVLSUpG4VJFy6+63BCGowmg+vmUIdqEW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1002435e-0bbe-45d8-bdfe-08db568fdddd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:33:30.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2Zl7jtjpARJ2ZuiVvFXeO9Z0iM0sJexkFfNuQ2QIa9khyVBnSaeDDOMHVHMqSva/pRoB8TaYbfRtKG8rXeDxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 95b9876710fa..24ea3b89aa6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -441,6 +441,7 @@ static void test_rr(void)
 static void test_red(void)
 {
 	struct mptcp_bpf_red *red_skel;
+	struct nstoken *nstoken = NULL;
 	int server_fd, client_fd;
 	struct bpf_link *link;
 
@@ -454,7 +455,10 @@ static void test_red(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_red");
+	nstoken = sched_init("subflow", "bpf_red");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init"))
+		goto fail;
+
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -464,7 +468,8 @@ static void test_red(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	sched_cleanup(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_red__destroy(red_skel);
 }
-- 
2.35.3

