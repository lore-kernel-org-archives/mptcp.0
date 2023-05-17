Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC118B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZdXkmflVsuc0jUdISYm1Sm+YEMlJ/1LdFHFBAICw//LkD1K2IvISWp24aEp6AKZqzoJ9jvDzJp84kPkA2XKzCrM3lUU1lyJYnl2f3HdWDNzxYAPRog5DCkoJ5bTWsVlowQNZOvcDpOW5ux2lGCoZMT2VAan6kuy241320U7GBnt1DD9UdUv8BrePqec37vFGkAyjF4Cjtb+ISOCWusJFXCKySbpltkRrvbrc49nEYTtIoDO3VoCjhia+HVV/OcGZC9iEYQ9zFjkE07UtBPdz39joMAtTgqY+Tv4XBMaBDluqlGGDxg1GBcbkJfgPzD8t5/yhoFzNLPiEdPkBao0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpOLuTg40Qgp/4jbJeedg8AUc3r8oQeAagXTAmyS8GY=;
 b=Km0q6IGABBccMrQCF6DyXoQPaxgyubh74uGwY1NQ16vHK/1B33y6/OfawEQyr6gzkKS26fvAxiUm0+2gySEPAfVlOXFiS0potsO9PUEGwrbI2h5FrCEPH8iOk4KrHPhAR7lSnjsY8HIrQtAvDAxsC5hKXGcvyMHfC5zak4G4Xw/Cq2SwUlDW9fP/9IXs060bvIdpfuMxYsBcbaY3TDFHeXX4aOzV8pB0sTMVb2rwou7JPak7ZX4aYZ37LS4xJHNhIU3PGWLeQ8/Y7yC75lDeu+EfBq7dLPj+5xZSiMIgPFE0k1XC80dsEiD4Ucc2yFaP8UOsz71IvmDl9tv/vgX4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpOLuTg40Qgp/4jbJeedg8AUc3r8oQeAagXTAmyS8GY=;
 b=4Ll8eG4l+7V8hkhHJp5M2/HUCHQC5olfmdr/NL+IkRlJO/I0NcVdbzii7+BZEIbbOja82bQ6FU7q6E4ZG9W1T6KzFR6TbNEOVfUGUKofg161XSSIe63hvCEa5NNp3/73wdecp1pLTI3yCho63BPie95phH0ZnXfLFIizuiOOWhlBI/mDkb8ZwL5I9JS/RaUN4bvtMssEa+7MIBeODDfPV7vpl8D1Vjo0nyP3AXPv/AKMeqp7IUKUlpLwpg2uXZQCFpgI4QK9t5PgjQNnT3NetatnIgCWPxTwXsJGxnZ7gz0vxLJTRnWYcGn1gv0G0x5dz5HKnN1yq6Bm27YbiuN8lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:57:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:57:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/6] Squash to "selftests/bpf: Add bpf_first test"
Date: Wed, 17 May 2023 21:57:11 +0800
Message-Id: <72f004475c96f43fa3e194f1940e836a74eb1a32.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c66094-3f03-411c-2f74-08db56deb034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kFl0xUkgZdMk9GdVz/4+aEz9y7XcSlW4+Oa03KQxn4H/ZrRLMmGnrIQX/IUcL0iMHwOyzlyL9QYNHX/lKfIEG/Xj4zNm4HvzYi/ZNpi+eS08WlC1TgQpfeYgPvR8hH0OWx0wQ1oUAReiZBctd52JKQiah4fHudhy6eOe447LgumGv0CE+/kLAUqdAdhyzA2FAi3yJJYTsq0SCESSdVMzQ3xMvl2C8GTHBvcSyZUOrcKy00WHnlcpKUZ0TZuf39Psi272FZb6coO6vMgAUgaFTicwLTdLqgZnqVhhrX54QY+MZsLvnP10BxrUeFdGRfQByDd/U5jE5YGa3c7qWGTPvDkoZ/BVI903k7rfMeZWgZ+fxt8RvXPIrfy76BP68kiyGu/Xgu/IJWghVqCDDeEjVbkEj4KiTcRr7nJp57DRZNUlyLlUOZbQ4Iel/KxQPJrXAmRLoQ0yAWAITDtwc8xrepbvYbt9rj4HUFNl0872Ai8CUWCpb+AT08a5+Ucs6Wfhsk1QsupiYPTtfUEjGTi97s6H6fdidDCVw0gDbwGuJlVllfig+B8+WSsF25U9OkBt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0Ibg25CIehtvPPcnbX/zxH5qF5C4labeFMMbn4kx46s3xftn5uhlvJiaqGZ?=
 =?us-ascii?Q?MexiegiNlnhoUkfahqCOoUQjkzei88Wtb9D+Fx2MI/2Ycgt1ZlF6ReT6KBir?=
 =?us-ascii?Q?oIaNkgnTZ/G8xEJ7nh3ju0DBbZzJJ8VXwsT8TXkILFqva4l/LNrU7Me4OkJd?=
 =?us-ascii?Q?wAYi5dG7QWr+vWWvxpoOLJcgW1hfaIc4nif46MQUH0EXqGtx1M9vN5Oq2ERW?=
 =?us-ascii?Q?e//QUgRZBkQgW0f5yOEn0RlWiglpV0/WJRochQ9LY5CVotr+lrZ3kxLccWVS?=
 =?us-ascii?Q?7OreXEURb+33pG6CCO0QXo1Vgp7NQnua3vmNbWtAGEFOQZz4XF5o8ZRY5C8f?=
 =?us-ascii?Q?4bU//cBlQl99zt5C4NHt6Vq5l211liKN5ywR0tBy4Pq//eD/GJnzxb7GIyX/?=
 =?us-ascii?Q?pQnKGugEH6+cvnhFGB3iCAj4SbpbdYbBDszlby6HOCYrgteL7azNR5e2GYEp?=
 =?us-ascii?Q?d0bQqLh3KIGXdq48uwJE/FLgluvjCbBGIrwtSa3/TF+X1onqMTAhkQC7NOSW?=
 =?us-ascii?Q?/jSMZL+lJy1jKTrAcH8cto1yWCzJdp+F+LRC5AUT9g6B40nlDu039PpDPwtJ?=
 =?us-ascii?Q?gZtaMkwRhL9Unp/E9uznyOMAtjNWKo3VYsI5RDnl7egWGr27kYSSeZcw8/Ne?=
 =?us-ascii?Q?WwGAAUBcHuo3OAqVSxmfzDjMNg2PPoVNVj9v8W4I/jamXmc2V5/4X9JdhPHu?=
 =?us-ascii?Q?ij8ry83De2p5IFiy1U3PahBD90PoWcQcFq5ubAHPjt2OQJmeMgzRYuZk0G46?=
 =?us-ascii?Q?pZHP8aev8SLaLzvPiojcopPR0yaHnKi4xgBtj35YGAK8kkglGxxFk09zgZsS?=
 =?us-ascii?Q?K/Ih2Aj8XeeA17bOOjZc8DCzjEHFbjCcAVoyVs6fBbrq8Pt3AZuEgJJg/eCl?=
 =?us-ascii?Q?P/wrYVkip11vn2K8WVDNgR9oNdCre/qjlkqBi5RgwL8NzM6T5vbsKOsj3Ajj?=
 =?us-ascii?Q?HNZhXN1zFbm1o63YoJ26N7EcAQnNHAcqwvJg6AtpDCXQLXrFNSRETp+7ZR6i?=
 =?us-ascii?Q?mVQtZBfgLikj3kkapRW42ZEv618AATHVGiJXi/h5eEv9qvancOUGa2088B5T?=
 =?us-ascii?Q?LMbG/M49V6aq3MfY5tkVOJS79HpxopUQji6IOlUcihwkATeF4QNw1htT4iOM?=
 =?us-ascii?Q?fXWJrcYVqw9HRYmh7RrwqfEaVm/u1NX2uqJuo+1O/FyHg/BUgHIf0QrsTH6t?=
 =?us-ascii?Q?4xnzJLP8DXrJUDBDs/JpmnpJ3Bvq4zvoAv7GWwD0kCQgOwMBSfy0mRMzU/7+?=
 =?us-ascii?Q?VaDWpWNDFQ2WL5G96SB1oO/mHPzPvAGI7c4SneEsZSZVX0bqkASSIYW2Nz1t?=
 =?us-ascii?Q?E6MibHbm/x48Kz/RJBskKVj+COcVEmk89kD/00IbhnS3tW+QTb1guWqhM8uZ?=
 =?us-ascii?Q?ceIbxG5vnzsM61Uumkx5nWAXg1tW4lrumax1CXNNTObo4n0EfJQ+OG8TSXpg?=
 =?us-ascii?Q?UCV1SR2nIjjVD0enkdZ1XYcEESyokuKlr6tmJE0sag4+W2tn8y61XoYZRVZC?=
 =?us-ascii?Q?VLdHOK3pXuIsYFBpVrTx6KDXwDF6zOGtAUPGz1AFKr06yH2jjMYGhVX0D1KH?=
 =?us-ascii?Q?7VsXpJJPh41lDyfJThaXfiZl/F6+4vKB/iXuf3Qq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c66094-3f03-411c-2f74-08db56deb034
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:57:44.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cmp1j/M7+hPzUqrXpgtnL8z3pj9V8934ERvxd45VcwEH9/TcM5yUs7n0uZU3xnIXpoPKza2ohf+MQCmEzX+gIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ca348bab0afe..210ab5c30962 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -284,42 +284,39 @@ static void send_data(int lfd, int fd)
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 
-static void sched_init(char *flags, char *sched)
+static struct nstoken *sched_init(char *flags, char *sched)
 {
-	char cmd[64];
-
-	system("ip link add veth1 type veth peer name veth2");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
-	system(cmd);
-	system("ip link set veth1 up");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
-	system(cmd);
-	system("ip link set veth2 up");
-
-	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
-	system(cmd);
-	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=%s", sched);
-	system(cmd);
-}
+	struct nstoken *nstoken;
 
-static void sched_cleanup(void)
-{
-	system("sysctl -qw net.mptcp.scheduler=default");
-	system("ip mptcp endpoint flush");
-	system("ip link del veth1");
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
+
+fail:
+	return nstoken;
 }
 
 static int has_bytes_sent(char *addr)
 {
-	char cmd[64];
+	char cmd[128];
 
-	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr);
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
+		 NS_TEST, addr);
 	return system(cmd);
 }
 
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
+	struct nstoken *nstoken = NULL;
 	int server_fd, client_fd;
 	struct bpf_link *link;
 
@@ -333,7 +330,9 @@ static void test_first(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_first");
+	nstoken = sched_init("subflow", "bpf_first");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -343,7 +342,8 @@ static void test_first(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
-- 
2.35.3

