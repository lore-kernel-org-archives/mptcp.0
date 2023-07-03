Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B3165A
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoeK7rumTYTWQnNO/zsQQ6TnO7+XMh1Vlb0GWlf4zF99C3IMolPSuC6MLeMtsDakYn/wOezMZkTDyM6XP0UOoWk8C769B2fFLpIlg4cdgUma2YPcnLNUEMGvn6gu05gfUteq0g5+fvmSeT9cTomsFvHi90I7LK4EWTbx/++MJQF882OOPPsxADeDMeAiRcL8wvDe9JHrpteq45BY/M6QlcuauB4B8s6V1yh0t7km6RmLKo0JtvWRIyc1XsKLV1p0qsdlHh8H0/xF4rc2tN+alc2ThTkw9AAa0H0GH/GdVQopKQNSBKZMb7uZrIS/hiCneAhYzmbr0Q4lbnhptv5xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=D9NxAExxvbovcCsa14VvYJJpmfYpJKXCsTQKgmdsU8wGsc+/TUzSJ115fPbB58Tij9jgMZbTrr5d/NEypJv5ybIfbNzRoBIWDEhF/Mot3wpaX1IIhOT7MFSZ1iQCq81KakJkVMno5gDdL9fxs0QjayjmxGf324G/4KBjhzShhdG+44RfP0erunUg3SrbEA/vtjA2K17J7dDtrY81a0QGMlItzvRXG0kzVLyWQWz7boq1ogwy3tbON23lFzp8C6De8fPyHIKw+cEpNejiPB7PKraBSDmbeSBKX8ZY1qj3ZC1gfeJPtLx3CkkzEJ/bRm9wvy037zJ3/P9FBpVxfFTbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=Kft9ohzy4vOwidiQ4QnqHVA+4V5hrjWirC0YKP6+DEwO/ou5hZZN1RHZHKRRQRX3Mumc29VtHMt8X4yUJeiCouTO1SpxjfYt5dD5sd4BhPFS/dFr7a/yAy34+Vv7vTeE2cyeQv+IjcqioFUFl2g7dYAQ/cJwACA+dYDIG21k50+0ahC6h/PbWkDmG0UxTf17KO83d/p9Hs+dUeTf8nyRxCrw+Bc+zSFetFYYf63h9k1/KWfJPR/amDMNIpdbXhhWUogs6uLEA7xOkWqOXvismTIv5F00ic1pfkl9krlbFIsSh6XQ4fgqcGThSDDe+6UFserIwoP+Jb4bQohlUyjHjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:40:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:40:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/5] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Mon,  3 Jul 2023 14:39:56 +0800
Message-Id: <1ce0da8fa8beb7277c15ea3aea4393d7413b66c3.1688366249.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688366249.git.geliang.tang@suse.com>
References: <cover.1688366249.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: ba488eee-8999-43d4-ce8a-08db7b905607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NUbLTmM9AIveeOgnZ70wHd2u0rnJrHSgz96MF4+JZYAbC0ShYL1NyumXHEIISxkFxECKY2zBH3zqhTZdnkrOLwC3tYY08VIxfu5U2XEuazDju7P8/CV2gAqB061lCO/03b4bR2fFoPoAPDUH4wdZN7Q+1LWg2i5q8UBXQGCgD3Q0cBq7w0TmDWevP6TTGKcxm44Vh0CKKrO5Kbb/ebWZBucR9s305cL+Jz8/WrTunm9jOzt/0Rhhf/AjhnP8aOzVQ36A+7La0ozxxKOJTOJ8SgIjVWmW7xMb7ldy8RGcELh+S+8bI6agHRdcY0jiW3cPjUAUICoLu0+CFLqafd6NxsJBMu/2oB8bnY8apfZKdBwiM2WIuNzRB84GULHZMYb8IL4xPhglGAQxP5bLTVlDdMcIraR5QfI8I968q4ai+YspPcRgpn+rSUd3lhy02i74q9kvwep+EsSKvLqXq0090EO6BiJzpwTD4osrMxC0Ubbn6PdvqnVAg3YhO1OoKORJNSmnNZj9HAq1VgGQgfusbFHWiackP9eWbB6FrFDQ7KE8sPksapXKeyS1/fieRFQh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(4326008)(107886003)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npWupCOEswoMv5DDTMvwVFkVLXL5EY6hKSH/BcbvsDdi0SIrlvqLEGRLsMM0?=
 =?us-ascii?Q?ZUS5Gqz2jNWcSFaVuNpzML7WV5U6/4W1Z6P1fTVxBK/25xl464SUqjnjB9t8?=
 =?us-ascii?Q?EtBGuJqtyAjH7Z0kSHvlLPjvdO0ZR6LmqtXlKwVh2fDtJmQuhLUz1N9wh6Sx?=
 =?us-ascii?Q?j12KfQJBXZcFQvrtcUlS7xafEpAGr3HHOVHyQn53HfHzLKmUa7PhfHIVz2+0?=
 =?us-ascii?Q?J7sOP/yNpjwiU7lVoQ0zvxrc36VAK+eEGsorQgkATiDleeVcS1Y8mILfC2Fx?=
 =?us-ascii?Q?4+otlBtw/P9Q1mlEurx/TF/i/EpO1H6Vvz/dc8atNSLlP3Iry/qwDAun/gyJ?=
 =?us-ascii?Q?sOlzso9kMti3HNYQx5HA8heQt0f8kxiG/93NmyK3Q5DLgY5IUWifCw8nw6qv?=
 =?us-ascii?Q?bZJSNP0ds3rtPng3U726W5VqDOFId+VNKKmxSBA1mtkRFEHMSEcUI30OJmmZ?=
 =?us-ascii?Q?NDfICO9luTy50EdKFup7JjX/VNe3KH24qV5dUaFA5aOK7iMYpMHa4UQ92XGU?=
 =?us-ascii?Q?yTEU8pNfGM+cmmfwpV9B5skxPaCsAUzJyLJz4gFOXhCQw75LXFw9v54grQph?=
 =?us-ascii?Q?rZtFqIDKf16CiU7UkJ2hZKAsDaIwAoFG2q93FYzbmkj71GwE54gVh4a6ONH7?=
 =?us-ascii?Q?xCA5Zg7U5qdggMgFqx+jCpx4msAX+SaPq/2u+5GJrVS+3ygwWmAcEMZg7Zah?=
 =?us-ascii?Q?KnsvV+wm6ZNSYg1CZ8egHXde0g4zxT7e5pCksKxBlvGow7UnzQ2Ni83epcE3?=
 =?us-ascii?Q?11CgYC6CKjUkH4ZKfq0cev7P3iVY6qk163qmP1yDibOBX/EHHdJLkAZAGH1S?=
 =?us-ascii?Q?gATK9Sr16VvZEURF/HvQ83jmBpNG4Sn7Yl6IBRFvyfUOUbzE0olzaqIruYCu?=
 =?us-ascii?Q?oO99yaGuK+Mi/A7JBFNGewoQ31vd9Oh4hGpuCheLmuuSjT3flh/2zVI4XzrS?=
 =?us-ascii?Q?CJxC0holeQYGB1c1Eo/FBEHLBIqC39bipEAou0RZgSDMkPNEhqZsN6IfN0kO?=
 =?us-ascii?Q?9I4SqJubu0M6v0yfZNHU0lo/LgfWTNUIRH1dLAK5Qmrf+NeyJcqaTFEmaN8y?=
 =?us-ascii?Q?qLJRvYsL94Pm5P5eVdQB6uVuF3gI+ygbp/VO6bkrxfdNw4U7sox0gqOTsNae?=
 =?us-ascii?Q?SEEDoes6oZLAbHR4YVx+7aRFAhLbPU7OUXE38YcsP22qL5monVzKYDwaQaP7?=
 =?us-ascii?Q?UtkX4U9Cytp4OZYy5uP4MYbzvlao5Ew+3lRD5D2YmBIldtz2rEHVFxyoO4A9?=
 =?us-ascii?Q?YAhPI7huBbXiL9tiD4iTch3qAQMucotkQMBfUClOJ0CiZ17OnwmF4JMMMciK?=
 =?us-ascii?Q?2PB8Fg9+CKCxZf/XvtRZKynQoouWfwNd07xMutS0Cx29AiN5TfrKVlpg7g9g?=
 =?us-ascii?Q?/bD+yaXsTDl5ngCfMwi53aL8Omgz1aJlRFnAUspXwoFOeggszhYchhi6GZiB?=
 =?us-ascii?Q?jaYMP+1aXWI5OLOSCPsdoiwxXsmq7ltINqdqTlrILdlHxNHqYKIuPTo3dbfQ?=
 =?us-ascii?Q?b7LARwhcPJ8csD8MWCJZRW5NI8mv18y3dthY+T2JOYq/0ND/JC8wsmzZDrtk?=
 =?us-ascii?Q?flfrIZbB3r9pfBvdRZAUU74JyyC7WfAGWtdYdSfb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba488eee-8999-43d4-ce8a-08db7b905607
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:40:05.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTtJ+ZoRIBU4o0kCPggWrBUfyq56znqDIiCWkfmViJURuf7Pafb0p4K71eJed+IY75jdGe+pCIr7bC2hyWDI4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

Move the helpers to the beginning.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..e430bebebcf0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -26,6 +26,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
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
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -142,26 +162,6 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	return err;
 }
 
-static struct nstoken *create_netns(void)
-{
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	return open_netns(NS_TEST);
-fail:
-	return NULL;
-}
-
-static void cleanup_netns(struct nstoken *nstoken)
-{
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
-}
-
 static void test_base(void)
 {
 	struct nstoken *nstoken = NULL;
-- 
2.35.3

