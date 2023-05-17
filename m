Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B811C8F
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuOuuAST64kzSSZ38Ur+eow+PWRN+u1x+3RCgHHZXwfDENcjpoPMlPvBmnyTCFKBZoTSzNpNg6iQKayrgFx2gCi+XZvKb9NehwSXDY6HX6D4AG37wn7j0VxKUTYX7VFArrilfXNe+a1DFV4d2e3XKhnjK5I1zUGg0wulG+gu1yf5iwpxmUEVzktbJQ+kHjRNcJhQ2I+Ewjj/W328idKPxE30DEafmvImxzB12gdN1Q1OrQpoAQ1C9/rsjDESQ49oDzhVbdueviQk334QufieRjc4iYo2V0KzHr8EeSDikna/1LRW1lTMidH3RBPfu21L0GpLcDd08CCE/VJ403pmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwEoI2W5Hra/NvK8NdRoNMhFP8rdwflCL60l2tY0nWk=;
 b=klTzPmLo13c6DnPd3kZRNgKinArVChOvExl9HzkkyB7YQY1upn0gZ7+sPuMSa8bTZ3ChhPiVurtc1tUblXnoHsNkWUT07Z4b7sP2ruw7ba+OTo1wDAapP5Laq99ZYvLzocEhU1jN6ohE1Un49r7PGFZogIKw1JNVlL3i8TzINRWz7lqGUeic4iYwIACaRwZWfrIReqPz0CI37p+8lyE22Cw1nxZGZmImrHe1Ra7HVG4Ta8jZIMVyZpOdnadrdVNLzp560kzf8wMHn91hdqF0KS4cZ3H23WfSadQqDHMCAFzrICYSeIN7o/iYxQtF4yh/fX50Y2bg5+55C92zT48A+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwEoI2W5Hra/NvK8NdRoNMhFP8rdwflCL60l2tY0nWk=;
 b=yNAnZ2+C5IZuhTgQ7sPT7XIayhpYU0VfYOTykTnIQacowUnWefVYnKvwzi5wFS3fW3+B1RLCs45bvHdpxjJbCL7hpyaala5BrIKPuUFJq+WoNY6KSSPG6OP74LAvxAwoQ3cAWopBMc1/wT43ztNF6YcgkTmXCpGVJoPtbACEb8yW225GiIezIFLk64+kENd4Q6s2vnYFjzVrWB9I0e05UcMZ2qOAa3kNN143gb6HKvJrNYyO/x8lAvzpya+krNZj0BsFVyfgBs+tUC6ShGNYbXVVaK9iCOHcoJyRE3W6yqfYNWhnTTFvj6z3JqKIT1v5UyJW3LycZD9JBKBK3isrUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Wed, 17 May
 2023 22:30:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:30:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/6] selftests/bpf: use random netns name for mptcp
Date: Thu, 18 May 2023 06:29:37 +0800
Message-Id: <ca8f8f11a0437a4d0cc43582342f8780f262f888.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
References: <cover.1684362296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a056e5e-8420-40ce-30cf-08db5726423a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DzYbFiu0gv9wSl3xNXixdBN/ISYRE/iKybXIerCJD+rm+CdeF6FOY2EieUpogeJSDKmCq9DBkkH/Njx+ussd+UKG0SBxXcQSrG739zQ7V/Cqmz4l8rGd1GLD6I+Cq4iezy//KQw5aCy49Yies7EgBUXlbdlJwyExlnXx6FLjtRPnkOHddKA4DPQfJYPfW0IwcVBHkJFCHTAfBAqVxTQqpJQSKXJjanLlUnI9sMRQbWqLb89pq9QfPh0WE5Iq4OjtBPyELQSMPpDflCWR2JBzef/Wz7n3WH9kWwdRF41G6gWfoMekS+mX8td5yUiV+d+xYbCGF7GiViRJDwYW3x8bmlpO6RAM1oRxdnvuRjodRpxpSbJGG+dqHTruD7DlBiu/kS4VwaJlzjk7dyWlG9mL0e04k+2FFJY4siu/nioUoE8U/AKBLBOU6EP57Dl0471+XKNyZupk2rJboSQLPepjvi4IAnwC/g3Yy3vXree4eXg/eDATlZBgI5+e0BrbkV28yQI9jHiruJGEUEgxbth2Hqc82CW8vM2fPKkxol03f8We7d4u6Ta9NNJdsrNqwhLv1XQDZQSQWiIiotKAbry/au/xD0FrcEMqBC3hweZIh60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(86362001)(36756003)(316002)(4326008)(66946007)(66556008)(66476007)(6916009)(478600001)(6666004)(6486002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38100700002)(2616005)(6512007)(6506007)(26005)(107886003)(186003)(83380400001)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sLdnQUvH0eI6lZDAdLblTb+vxfPm15lAflji8iDd5Nr/3TLaBygniw4Qz7e7?=
 =?us-ascii?Q?3wQ/p+qFLs4fkl9smUk4q8lYSccNaPZYjU1EqpCYy1nng8lXrPOpp3Kw6zNa?=
 =?us-ascii?Q?TzcOKE1/0l/Hf9ZhSLxsXqaCWab0lTGOiGwhCRAE0dNzE8PufmLd9yPjYnog?=
 =?us-ascii?Q?poKy4LiuiM45H0//pb1l2Qxpt9Cpzw1lSmMEBzEcLkwMwHFCvtrjraoG2xCn?=
 =?us-ascii?Q?v+euvnV8xH/9lvpivgtlR2ILOzSS1pFKq18qNZ+991M1BgC/849/1f4H/4ko?=
 =?us-ascii?Q?zKOVszUE/YqHA8lhPYEW5T1hRH9VwjFJ9Lun9JccbWYjXt/vCMvLg+5IerKP?=
 =?us-ascii?Q?JiqljahgcikPR9155lHNGe2KOAsq8HBiU23uDRwxRWVrZl4fsx/dVaNqX3q8?=
 =?us-ascii?Q?IUdIHiQrvxW0xMDIfks4Nxq2G96vyadEUV/H9ji9o0UZndEdyW502MyjIWtE?=
 =?us-ascii?Q?ls5VS9MYE3Omoa1xAv75OQs0bjQmtPoODtA+cPvJ/YXeTfANKkj/YViQXwFH?=
 =?us-ascii?Q?d3GF6bB0cESbWNpxEnGhC5djVNRxPMr5LKCBfRuzcfmUnoUE4Yrn0BD0gFou?=
 =?us-ascii?Q?uLTIYt9rTAi+RsRHfGWWLf7mRHueF/4gvKI3m2+FahNQb7bpDaSrcCu2Q/ud?=
 =?us-ascii?Q?6xjgBMRXzrc97Yig7nIOJUWoV4H8t9pt6JjnlENKGJBmSgafHpyca8g4zy9I?=
 =?us-ascii?Q?YdZEMenytWr3BjSeNuKCUOi1hn/4UOqh45DClHhvYj81G800iBf0H6b69sjJ?=
 =?us-ascii?Q?4fkNqCLvcyTLZkPD42/zROMnf4K/uCYFrBH/ZU0NoBC6CmhOCH8LSgsZSjjp?=
 =?us-ascii?Q?QYgs4T0WotBRlsKM7g46rYie39chFyliix6FMcLYmKKcbgaDn6KcbCF9Gda0?=
 =?us-ascii?Q?KKuLg68VQsr2T3GhaiAPPotprfRXhMXhbWAFikDX/f7vm4Q1ac/W8Iz3PHg3?=
 =?us-ascii?Q?vyUinR1ZQ+Ls09dpsSkRJtWl4cOJmGJ59wM0UYv3C54BD1udEN1BnHmU4GaU?=
 =?us-ascii?Q?SCQxZW5FuspsGtSc3fptGkHWZBZtC7dD3D5LxS6r+r28lHrQ2wvx2nEyF45x?=
 =?us-ascii?Q?G5j35NPJjXlevA7JebwGZzguKPi13rauH0YeMhNJwMkDPAdGRyNqZqWWWMjJ?=
 =?us-ascii?Q?Tng6IW8gx3Sydkn9rgJsTZTPvLz9wD8HXElhXajwzPQGIDVzphAqHRrHZfb5?=
 =?us-ascii?Q?vh5Pa8sGc0ACYJ5o/Tq9y2wjNJxk5Ma4/fQ2AudGv1+Z7yb5DEKWe6p/5KN8?=
 =?us-ascii?Q?3lsIns4RuiR7krJjab4wG7IRF10VJucRRxv8Lk5J1ceffQQtAabAODf1cgZL?=
 =?us-ascii?Q?4tiu8/zmm6HTmHz6ED7WrK0ZdakGHDGKSddHYv0AH9YccXivoVf5pYcxIRUR?=
 =?us-ascii?Q?GlBHWSpKlLQVb24w9Lqb/DS+2YWQ+GeXMlr9DBrrJJa/u2COBcOCsQkQJJmH?=
 =?us-ascii?Q?moPfzL30mzHe18udbB1hA203uyWyi4KW4ocUrgMzoAFEDtE96LTH19B5QFfJ?=
 =?us-ascii?Q?F8oPOOeEz0s8cU1zJD16Sf3Sy5LmBaJ557bQXemHE/uCNjkmVb1jRT7AhpE3?=
 =?us-ascii?Q?oQroNDmOMmGsd+H/QVpyCiydN4YxxWiAybtot4hB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a056e5e-8420-40ce-30cf-08db5726423a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:30:03.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrKC75Am7ZzJ/iYmoDapMwml63OPsM4EBlxMDNqQIejdS1Ntl0DVcG3OwuXnAgbaG7JSmuSmi2Y4cYo+WK/Jvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

Fixes: 02d6a057c7be ("selftests/bpf: run mptcp in a dedicated netns")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index de8b6c68fc30..8040997e4aef 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,7 +11,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -151,6 +151,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
-- 
2.35.3

