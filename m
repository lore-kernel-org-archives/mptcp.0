Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942418B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItVdu2dl7FxSzdSiAcoUPz8zQv3yFs7xK9LYfwjT+rInuWQEeTW/KOakYfQUNM3T5V221fFMLri+YzopVFdawSCOXrICN3LHXz6Egrp6Ek9Astkx5VzRs4VI7YV1646HcXXTbseFCltX1q1SJocSvv1yCCLDpwFCiLOLwAACu9hqumEAsxZJeWbtBTi0xdpJnXGvDoqv+MEE9u48QbvXgsAPpWVlxQc2JKxeZWd9nIRDF3SolaTu8wB84idXBC2Y31RM8ZNqojOd6kZA/VRtN0qNUycQt7YGIhv9lif/S+SItxnh8lzYut2pe3NrOoL6KEnzyPecX9xBjesEjt7+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhu9S30h1vyyXZqEhHhLodFaCcyMWken6Oql765VisM=;
 b=Xb7E+EX4kPIojwfpyhsq5TA+FyXOt8oCkqNiWNqFaveDop/nntFU80YpMtdcvWlJPOF/Es62bwIzdcZEifbU0dnTsZG19gKMdPhFhMqX6p+jLjZfttqWpAN3HbBelUiGNHv72Er50TTOh4mfTi1+82dh0qgJqcsTtvEIKDtixUYPw5+QigepOPbGQ/UGOgDY+eZgFLqEduSSs3fZi1Nd8qvk55Ek23rWHlZ6bVJGh0pvdCGBhD5wlWmEEYfXbP9tLKKWKUmvEI1v+bO4nmyYMrdI6N4YO7C4P8jlgtUBlHoU25eAeK0twRWkhVAk0FyYtKneFiHz+tCUnGeeiYllkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhu9S30h1vyyXZqEhHhLodFaCcyMWken6Oql765VisM=;
 b=kh2O2GV/OJykwad/4Ewz5yVhuZYiFkX61/PP4JX4A3d7ghYa0s55W+dvG2dLe1oV71vS64bsWYiTtAwwS0ZyugXKfJ135HWwH2M/YmdvRcubkNmCYnQe+wy3yeesUCkLqKCGU/aC6zP62jYOLG5y1utIs+iVZG8JCeZk1L3m6n4FNjTFtguurXT9+rWIuN/000knwcxxDifm7IjN1/YPXv7dd5hInugITdMLVPCtvzM8l92OnwqW4ZG7aZR5iw6IyppFrlTFpfe9Cfwi1Tj/N4KPavbFvEMncSY4MdE51jxoFSlVBpsBjl90tExCpVzMyrIQ4/4mj2k6isyODdDmdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:57:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:57:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/6] selftests/bpf: add two mptcp netns helpers
Date: Wed, 17 May 2023 21:57:09 +0800
Message-Id: <2447b5f6250b3070b53030ec83514932a1c15a97.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: b464c93a-29b5-4bc0-58ff-08db56dea7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qpH72ZKqGFWSHRqqRY7wZheWN125hnnRLMtNTwzl9U6SszX6bZGimM/kkab/C5cdJrdqtxvHIR2/y/ESpE6JeFzQTNHrK7FIHWozsF1aV/dZUxTAdrO740W6EtOIaLfNrpqefYIH6ENJqTlvcSBnhhWah1wvzEWbX4eFD0/nM0sEuFkMViVWVnwSg9WA/q0pTnZDn3pzzkUDjav6vElYIb7Mx0a3iJeiUJ5jMZ6Zu8CwrIEjXSZcx3m+AHljlqUBJI/Fnkfk6/r2te6BhL1xA7gq+JH9M0BQYVWeKbpa/SuStixLvNHnjUkx0LHtFIV14annC4SrUSMGToEApV4L8iyoWvZxBDAl9qq8XlPFqrdGsewdtKLY1po3n98VB2s0LubaIOV95gYlarMMCyR/Z0tE4CxHkINMBL0FVGcjwakpxxrs0BVSe/m1Wcd22+1wYQH1Y+CIPZGoeh/mp3Ee1OFJ6IhUXG70Ke4rvOyrS+zxuDGhtYuxKKS3fD41uC7vLKCx0EN5aOA7B0chp4AHwjDLPOuTkSsNhtRSI+Yksg0gvFxi3DEOWfK+gDMQPzbh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wmycKHqdJ8HuchLO3367fxw2dFyOOCWbdznLuO1Op9G0MYskJA6Snqgy0ad?=
 =?us-ascii?Q?LrW93OyFR79k4KUjuZiTtarRZYWeLuQBaXEstvOgjYeSmgfGQI18CEQ+n9yB?=
 =?us-ascii?Q?sr8HcneBn7zA704uXgk2ykt8FBUvcetM4TN6b3yYqRxdMz5tqFquePQl+9v7?=
 =?us-ascii?Q?o2VbOwQLCborYg51irVd8cofbh4sudn+iMsbOJCf4Qoqud6WAjY2ZpzwC5x1?=
 =?us-ascii?Q?/I8iUd0g25d36v2MB4GY04QC2THWcwSYQwzxxB00L74kwQB2hpXLrnTWTud1?=
 =?us-ascii?Q?tIcm/5M6FGAuNi4sJuCeILnTw6Y3Y/GBCXzT1OTEjM7T9NDXIDto9O+MGgTP?=
 =?us-ascii?Q?ZZz7QQBdfaAf8Wyj1k6kAam4mdyyupO42+o4jcFZvhuBwSXIXfEQwYU0smdp?=
 =?us-ascii?Q?SzbYvh9tsvrt9VERW31ZpndRPbV87q9O9EPpZcStOFj4kcjvNt9ZxGN10QEN?=
 =?us-ascii?Q?8EHAsYQ1MBQbhpfZG00J/njGDBvw1XMaRTtZPe7qHkpeeUDy17nvaB3FqWNf?=
 =?us-ascii?Q?0t59Jn/OOE3hYbmSVo5LAAHWaMVDouUEk+RMPKIfotzkKirkzsy/1skgjlgs?=
 =?us-ascii?Q?u9hl9+GioquYXy/NbQ3SUdIjcrEYz1zbs5owaEZ4eSmRlL91Fl9M2eYhaRos?=
 =?us-ascii?Q?mguBhz7nGT1M4K5UMUwsH5wDdg2NUWWwAQ5mr3PCfMtskY2XAa9BzYWIG8X3?=
 =?us-ascii?Q?QLFVwZXUQ9e0dHhiokcOMhTnY3NMQV7cyM/kHKKhZduS0CIQhTaqlUoGs/Ki?=
 =?us-ascii?Q?T1BRINC4FE90yYsJu8wkRPr9crlPX7xoR3xVQPhf37Pxq1VhwE8Sf9mg+Hm4?=
 =?us-ascii?Q?QIpIlmlew7ij+tgGxX6/j2AO3n3fqPxNDfKuXK3meMpiXHWlES936yUFvAGM?=
 =?us-ascii?Q?eCw7sd7ILiV3q/Ca8QFdciYro3OhIjCm5OEVwt0O2YVlylcQb8QEc4JsaqOj?=
 =?us-ascii?Q?KasR/WO/NN0/zZxO/K4oSp5h79Yy6Nyk4p0CBdY26BiXALMaAk1TJyvgUj//?=
 =?us-ascii?Q?XpSv12qcdkwFsZ9VF1X6POjyebQFSvpVRf/xeh2+Wqpvbx36Scl8y2bD1/2A?=
 =?us-ascii?Q?pJEFvfCNduEuYgHdiO1LwFk1uue2ccht73BgnTQPBhH6eK6PpFOtYv9IiZCR?=
 =?us-ascii?Q?P9n0In6O7Z99tJzOPEsDLokRyIOR2RnHI7I/5BpwDhefrkrecVbpGGiAIlD+?=
 =?us-ascii?Q?ZnCY0VvqGslshMisaVn0Lif/5XCghpgHanxKR5Ggvqf7Q677fkx0CppTSKZG?=
 =?us-ascii?Q?FV/BmBkrT+GvqD85e9xtgitYJmNOudnGGC6DzcqvVGakhepwfjDs9yx5QYJF?=
 =?us-ascii?Q?oC6RvfhpmgZUvNixi42pZrDpM9rDE1h4DxkJqZj+OPBfNkdRPSS8MvETc0RH?=
 =?us-ascii?Q?r5EMIvQmyIZmfobCKtWR3prtm0yK7ur4JfbACQncrUchwYQapOOy2QWrJpXy?=
 =?us-ascii?Q?zUt7mk2Bq/pMgeYtNYJxoyhWQeCS45PI9au+b6pPahIsaNoeJB0t78C5Ok4k?=
 =?us-ascii?Q?VLRMFJ4JTowpDiJwFKKsHXTfVUG5+QZdMs7eJq/09M+pvSw9Hg41Ec5fKY7b?=
 =?us-ascii?Q?Ybilh/LxQDjR/RHD1tHyt1ONo52VVpR/cwNaLiOe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b464c93a-29b5-4bc0-58ff-08db56dea7f6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:57:30.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGA7UWF5sIt9C3qJW22t3m76JsWwHyens1b5DpkECNoU4INaWKcPusw1d0b0mhqMfrbCswMiDbLYLvH5g4Igag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index de8b6c68fc30..d008388554de 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -142,6 +142,23 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	return err;
 }
 
+static struct nstoken *create_netns(void)
+{
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+fail:
+	return open_netns(NS_TEST);
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static void test_base(void)
 {
 	struct nstoken *nstoken = NULL;
@@ -151,11 +168,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -178,10 +192,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	cleanup_netns(nstoken);
 
 	close(cgroup_fd);
 }
-- 
2.35.3

