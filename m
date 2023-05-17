Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426FA64C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIlxWn7BJ7aiYVpgxYXO2xQtT9Jw+6IwiI9PQTMrs6zdDyb/y6FrCiDLmoWYEteMRcVFkYo12h8NPdxOEe/kLZMsn+9Wty0hEy2QfBciehZzzc0RTZAmozmXI/Ac1e8HhVz7Cujf9Vac9bx1ViBiZGn8Apfa/hjkK1gRT4P+NQVxfb+3BsNry12aHylP+6fwBp2RUJpO6h5qtpGyqfEnzyO5f9RCbcm5GnMo2HCp+YbYP3u4nnCW34hemJ0u0C220Qu6SKbudOx7Bsj4HKkCvjUM4KoJtjW4emsvGrdTaebXDDkwkyuEAAJuBT5cRtAD8IdSTMgpIFJjAyM2+ozhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vgK38LcEnZPBVFUbrtnfRS/pU2Sj44j7kb64cdHG6U=;
 b=VSehPSagHri+y5LlxMX+3ITlb3WRBVzEtwWnik0oy1unbI2TYZPWVEUgfadVy1+mUH2pVYTfB8WAzgD4mvV2tDeFvf7jxpstuboRL825ir/76werVjBVd5+TPWp4gQGzfsTvTR/c/o66xB6DLkjSQjgd76Cvv3JduSvfl7lf2V+rrZUPLvDGDGNKNN6+BVPfHcVfZ5Bavuw2tJKzyhUUds/OR1kzNL/tqA3u+0TV+YGw9LWaNc3Hmtp5ezMTRWHJl+6K0bDnvewlxndlmRIyD4NUWCkWxk+gpizC9r72Z5GdUNtMJsSu00D25U9wTQzD4eHp2UpNJHmX3vOqbUcfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vgK38LcEnZPBVFUbrtnfRS/pU2Sj44j7kb64cdHG6U=;
 b=bVaEi2APgqBO+uJboDEsa9cFXlLjcB6jr71HYeS4nROF5UUT0XU3bOIDErBJuCJsVtokOFHJyXE588aeLWvhON7F4irvyMArk9Ah7lvgLAxIYy+EZyG0w12Ap1MGiJMZB1vtWfHokEDL1Oyx8mdhqi+jZtKeRVNal89ioF87I3VVr7PD69Y8VZZ1r9flgXpmOScwlvEHTGSHoxb+ybAhTc0Brq+8kqwxvxC0NWBN+2r5myH/LG1RaPg3P/ahtMZV8NIL9Bh3+XLdTvxNTTNrAJ++SYPtsfalaERzBTDhryRw7kCB65cP/bgNPTXSPZJ5Ewoy0OFXArxms0QHD3FvpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:40:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 08:40:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] selftests/bpf: use random netns name for mptcp
Date: Wed, 17 May 2023 16:40:22 +0800
Message-Id: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: ca698a56-d401-4c27-45cd-08db56b26689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JoeH42lEHEaI6yPX9rUOaDd6tMYML0whJd8lTGMgnHubw448Ly0C7/NRVmjSBtv/pMyYMGM4fAfmRmQ4y+j7V6UqCGYYuziE1dxcECEMqz4PGMbZ0C178oUCHLfQ2VeDO20SCCqMph1Nk+S20dOeGYeUV53fX6HP1rXUv7xurn2rtoU9I7pAVNJSWV19FKzkhw1fPRMG6YEdfqUDt/0wwRFuOB++QOKj+oqLHzgq42Sat4q+820QpNz9tZ8dwOIEYjNU9O8KniRgGvBz8o2IdjoCGydlSXASiCOEnZmZHGC6vwBhpUBieqpUTYp1MLw+H0TKtikRqZ0IlPYDfqBJyGj8aey92wIyX+D6j3wQTmZuBYPf+beyxLWBgbljdhZzQMy7xy3syP9ICrPF0CeVh8fmxdYwJ95ZMH7Dl6EyIHx/eKM434DGhAkui4LGCEItaW9I1B7pi3E80FWaqJFKlU0bBZ+nmaNdr6Y4aMPaWRwicPYL90vC6U49q3oDo0f39ivD67jcotciU8WtKT2J0LpDKFkL036o3me5upfnt3KwsVvzgKYAgXZE5nLyv5PIWyT5hYFsRYKg/dagKb/5tYIWylBrdckh/CLQjkD+4kA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(83380400001)(4326008)(36756003)(38100700002)(2906002)(44832011)(8936002)(316002)(5660300002)(8676002)(66946007)(6916009)(66476007)(41300700001)(66556008)(86362001)(478600001)(6512007)(6506007)(26005)(107886003)(186003)(6666004)(2616005)(6486002)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1eF5NwJLyKfpnRBoyxwrdPUjOn/KsdeSz3FRTNohGxgLJPiq2W/qveBSZFc5?=
 =?us-ascii?Q?ltWoMchItOboTdiEjirh6RMXhKGGsk3vzxEh6maQBep3WVRMLaeRmnowPV89?=
 =?us-ascii?Q?YFlGZVvJ0o0dQNc0wLZ2TcISkpHHyZ/qMmVuqqSjfrto4DwnYQOMYQ0dFZ0g?=
 =?us-ascii?Q?PvFpwYo9c5BmMf1bF783HiFXPbpcMq1+JD+FiijWL2BGxbWT8sD2ilhuHISk?=
 =?us-ascii?Q?sQDz33bc8xw26jo7cS+YdU6bdfheHVrJ7LWjCzA6llMD6n5Sm9VJbbrvtIGI?=
 =?us-ascii?Q?rNZ4OyM76E8iQRLbm7Cqg6zbXnFeivza8JJ9aawG+dAI3SkdfCuyKGNOG+0G?=
 =?us-ascii?Q?/GLli4Ez8/zO6MNSrnkc2u5WVNwhYSOjL1AghZPXzCHBwOMkb77ca7qv5oOK?=
 =?us-ascii?Q?pvuGsKkAbG0wuJ7DJeX5rCWwBVn4sGZCAFVKD9YMdnK//pCXy3kIvjER8uXA?=
 =?us-ascii?Q?eIKnuDiknasEbuwYBpvsemYK2oDLfTlzRzwdf9qIZXy0rfYOyHdznGKPyDYB?=
 =?us-ascii?Q?oPygI+b/W6zU89xJ2xA01kN980xhoxMJa/40oCknmFzQeQvELSBY0iShI867?=
 =?us-ascii?Q?8tLhwHfgQ62Ba4KJxfQ7C2CFYD2zEahBx4Vp5Ix62HFJ3SMpPvIgQ5+uR3CR?=
 =?us-ascii?Q?TavMLLinRs9ayMeBbNuts3X1q4NJ2N+v5BUpCKb/L4E29IOL+D7ZJjM/Ba2z?=
 =?us-ascii?Q?IlTmVzbn80Oy7Tzn8wl5gIpbxzui9DsuM2ysGsNnNVyFC++CrKGrJrtlKI1o?=
 =?us-ascii?Q?PrqkaQNtanbbzVRxXGo1KghkUYpkIcoForBYQ6mln1hxHIclHfh6DOdpgGRF?=
 =?us-ascii?Q?4AN64S/uFWoZ5xCmFeI9GwvsU++PThJHEFLX1kv3P73X9khmqcV1IiJ4eVbY?=
 =?us-ascii?Q?H4U1ni7jv4s8dSZ5mCeAC9QWk1mOSDgnqutD0QCM0YQ6JeWDa7lsagdy+ugi?=
 =?us-ascii?Q?vwjnnMKxD07c/Ofiky32x/Vcg/nl9b1jFRU5cErJ0P39fGG5cc4Z5oYGkdJd?=
 =?us-ascii?Q?KTIUEITNPMfmfueJPnNtGAJGeE16XMzzpvHcDjWRYgTUw3opRZoH92vY1RB7?=
 =?us-ascii?Q?lI922EaQaPQ0yn4DoZjV13Ac6uAzYu97VmoLE5fGSGzz1tLm2cJsotEioRdT?=
 =?us-ascii?Q?agEOnhyhTyxyhNEx+DroWGRFOdlTTNFlL+VoYogRkDHO0X+GHMKoCOo7eFmg?=
 =?us-ascii?Q?Fux40TAu5LuvhErCXr6HlLG2tF3AZ6PuxBv8AHC6I5X4MDZIS7zgieSpUWEt?=
 =?us-ascii?Q?tL02tNiGPk9pwqYcngCvZco+igaqcAkvxw93EAcJC9/WmIF+3vJhIvEs8PVf?=
 =?us-ascii?Q?AgidColHltfBvGq16pis2Skcz88b1ZqpzcTllsbFfteMtzogqQtpMF+0fdGd?=
 =?us-ascii?Q?KMDf5izDvtXmPHVNEMi7+sahulsCrD+0+NutbwQplzuJEOy7z1I5HMhuS7Xc?=
 =?us-ascii?Q?6b1h3UXmMC4mIw3TVk48z9CTTXmphv5VqCcoe8byfoHtLLhQE6mX+Do5GXYG?=
 =?us-ascii?Q?vH0CUydCJldDyIavgQa10DG7yxuEx3/IBnJB6xUl0nqcutq49WYE20oT1nzO?=
 =?us-ascii?Q?2uF/Se5GhxhNCCUtBZ5lxDKC7pF40803LOy/J4HO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca698a56-d401-4c27-45cd-08db56b26689
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:40:43.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8T9lOOJspZkfguxrb+XoR9YF0olq99FkWrZhmpptksTMJKpRNw4bZlYP33I+lWW/ShOMXffRKSoNQMg+GLQ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

This patch moves the netns operations code from subtest function
test_base() to the main test function test_mptcp(), then this dedicated
test netns can be used for all the subtests. Other subtests will be
added later.

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
This patch should be merged before the commit "mptcp: refactor push_pending logic".
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..d989613c821d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,8 +7,6 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 
-#define NS_TEST "mptcp_ns"
-
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -140,20 +138,12 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 static void test_base(void)
 {
-	struct nstoken *nstoken = NULL;
 	int server_fd, cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
-		goto fail;
-
 	/* without MPTCP */
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
@@ -174,16 +164,28 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
-
 	close(cgroup_fd);
 }
 
 void test_mptcp(void)
 {
+	struct nstoken *nstoken = NULL;
+	char NS_TEST[32] = { 0 };
+
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
 	if (test__start_subtest("base"))
 		test_base();
+
+	if (nstoken)
+		close_netns(nstoken);
+fail:
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
 }
-- 
2.35.3

