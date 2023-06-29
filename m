Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D6215A8
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 02:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvSz04o9k+3BJYSinY8yzYoB9DzJ7Qc5594dPB8M2nVaH1u5JHIQ0+DAQVaGK9r66T5J4bvibqebLkDFr3DA+yDcEhN0eN+hfmxyRUqaZFHQ/TmW7yaquZddVfsNG7DOo8GxE48aVtBqe3aswn5JPsjlseSDVSsisrXAOcwRuxoLvy1TeHqG1gr9F0ngrFZy4GcpcHQBD2hM4lXLNQdgYod5Zbh4IQCpFwtxykDF+auV6Ca2KkWmKFmw90+fyzJDcxy2klHq5KkokQaVvFwIQiwAiBSAFjwu1CrzfvfMUgG5Fv2wXIOceeIKNIoHPrcpP9zguNZttsrQi2r/+78+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=EwYy/8wEIhnakHe94yP0rgFPidm9r78XDKd2P1vgnfhG7sa0u9W78+24wuBcTlC/joPrmvWveuicyFLwYq+gKq1DaqoxaRoZnILHnJF6ilXCfaUiHBpCoNX3M6L+8o8otL3Q+yZPAue9zxwJN/xmvG/7he6X42N2iZs4Qvvmg/UlHEPdUW8JyehFUlmVzBeXx5hGvP3Xf4P8U4p+fpM2LZKHbx+VNwk/3/ajUlGiv647H9S4q+mS2Y+tJVAnx8isfBsJF2n01F/cis+HZWqnsNw/KPa09uY5xhxLtusnF8Wi6vUbtq+rX1rr72m63q5jTKSRaN3E2/ByduI/y3cQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=enslWa1kBqHpVjG9nGGAyHo8ttTw7Nb6bVV0mn0v9/58SYRvRSHLysWzmaSgZno+gNhWeDrma2Kx0Ib5vMDJniEenDgYO2L6bG0NdiLsh46qFXLHO9e1vG97XEQKSZPpyRq+6uQd7uqoCemImFaH/DindSgkKd1Jqs+zac5UJ+4skdY0W+zOQqvk7qQBf4pK0pFLSSZAgoErx/WInOKRtkQ0MGrhhmvfqoDDoYDe8rziINUBuqr+K/5rCWFDewg9vX9fK5y91HB8mLUOFMkEgAbBNFv6KHPArHiZIJNbNuv3ubVTdHSXayibIlv+IHKjf3VHPy+tccKtrOq/MolCpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7763.eurprd04.prod.outlook.com (2603:10a6:20b:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:12:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:12:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/4] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Thu, 29 Jun 2023 10:12:14 +0800
Message-Id: <761e6b275589c5a9d34b60159b82799ba8fdfc99.1688004307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688004307.git.geliang.tang@suse.com>
References: <cover.1688004307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 235a2486-1650-4d8b-7e30-08db78464832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BExxgo/Qt3UKqncHAi0GYBWpMbNrpz/22tNCg2PfrV+HDJ0c7xEPgKG6Z+JxjcgtyjfL4l+jdt4FspSiCOIZ3mVl1X7Ym4KJCshu3DbvrfuIrgQE2CYwL4SspvkvMuk/ZTSn3lgZ9Jf1eztbMx9TYsGPfYT+ItuyHT8r0pK4d4bgM+suoTRkTnJhfVrS1e6KoleFuns2Xu7YPIH4ptOL1oXTABJMqh6OEM46JxSrqOw3VggUrJno7AKVuMPzZWH41A6RTIZiFBXlLF4HdtJ88NQha1O98jW2a5Yd70/omLN73qhigE8e5/Q3AUolvn1uzLHYeTNPhh9D8Z6NEyWYyP5Yt+xLjfERWxCBQsgyVKCblFahI9NJwbKmtRmSKwPimJwiYLqJ8NVOAFPH+j+PBSVw4oH3OYKEs1EucqvH5kXC1u9v2L0UV2VUNZ7qHsuKX/NNER/LWAO7cyfTmy8QQsoD7d2uWU0gyLMa9Nv8AEmuoBA2dI5LI5TCQxcgfUK66wZ3nvXeNipIFJcaltZumXXNsPRc2bvDsnwHwYpVDEyErvrl9WG1Yy2pgFOsgAn7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(6506007)(36756003)(66556008)(6486002)(107886003)(478600001)(26005)(2616005)(6666004)(83380400001)(2906002)(6512007)(186003)(44832011)(86362001)(316002)(5660300002)(66476007)(66946007)(8676002)(4326008)(6916009)(41300700001)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrqg0eMHiksDWJbksqX8AwwVA7gSa+mzj/MyUekBdY8SOHP2xylz71aWOMrS?=
 =?us-ascii?Q?fOsfZEtWJXBnsduG0FME/WTm744LVA2PCVs54lPIX2bqjFOqyavCpo1UdZUM?=
 =?us-ascii?Q?jo+2WHISqaAkYa4y8aCfZOXXSuI1S74cv0Z0G0engL6vBP6Ecr1W0ou8wPBl?=
 =?us-ascii?Q?Vqei1UxK8c60u6M74sYOUB/HljeGO24eBFn74/4Gyzj96zd0sa7+bdNXA7qQ?=
 =?us-ascii?Q?gaq3O1VfzufS5a3TpEDd9BH6jeiVK7edD89imKFCah4i7/dT8WzOhA27ncrr?=
 =?us-ascii?Q?lpvyQFbZwy6JvEeVNo3cdvPERgoeHusOe9AIIpwl+ubdaGJNc5sLHgvf9MXh?=
 =?us-ascii?Q?NgV633a7wnVWR+gqSbanBlUewZUVnniDAqDO2PvLpXkmDJUwYmfm2f9tPI2x?=
 =?us-ascii?Q?4063VS3Vf9SUJxuhirCZS1CZsEz1vmHmNsNQoSpXwO27ly/HkC5hH0DBcl3W?=
 =?us-ascii?Q?tbteLJdUQqtCjjrsgeKG+C7uB0CplmE17P/ubrhLh9fEIYJC1TkzOE775c30?=
 =?us-ascii?Q?d+7uO/W+uGghkCUZ2/B9f2kTnbzpsFMoRgI34NHyFSJmqLPNMAH07+4re6WG?=
 =?us-ascii?Q?uVvMUZs1hal2ktbECeZmM8VV1s2V6W29voRBnfyByPi2iMtjZpzziy1/AtWO?=
 =?us-ascii?Q?yOIxGSCDcbWe5+rfTSbXmnE73MKbJoktMuwWKmD9X62H0YRbrlPi/zwqHBih?=
 =?us-ascii?Q?zUzY+8nsRhhdyGyz+Ba3vcecLOwvayJZgD1Lyz9xcF2a9mmIggD26fJp1RPy?=
 =?us-ascii?Q?1mT6Ngle56SVTMLFzLlpu00kB0uLmeaRRSwfYmKWU6KxIpRHpk582SAI7YFo?=
 =?us-ascii?Q?hIrzZ5SoEIHiY9GjIoqYeKADF5HKL4iZKqKhWfVmo2WCkNicNrD43cmrHvUB?=
 =?us-ascii?Q?fAX+vfJlP4K3nVptMH0Y8rp6M5q+AD4o3P0WSW+h1ZGxQYmhj9HnzK4KK61y?=
 =?us-ascii?Q?WHBmBwe8Njxf8armJOkU9uMePwVKtIyDE9AHgsuqDbWys+JpKuv/KVw6HHYU?=
 =?us-ascii?Q?BQ2PGeGMOeg1scHnjq69vJqCtDTigv0ExuntxxtMfP48juvSUB8BHaJSCOIt?=
 =?us-ascii?Q?FqKgNOE44mlUlwUIeUYYhNn2PaWhwWHWqD+RgdTpz9X0jB7506Hk35FZVC78?=
 =?us-ascii?Q?qcXu7NIfO69rAE5apmyo9k77pQ0gd11RQixcnitPV/Ncq70zIVL/bX5/06Ms?=
 =?us-ascii?Q?4H9DW2sxiJXsAX7VLx9lIGvAc4bri9KLd+23FdLsv5QQrixqp9j3ml7hEchd?=
 =?us-ascii?Q?aXOyQbKnngLAMLLt+EvyBkKAP/6zaasMy1Wp5UAOkLB23RUzWhJSv+lY9VZs?=
 =?us-ascii?Q?Kb3J9eclpDKO81bBcoEJzT+8LrvlAOhA8DpJCMd7ehrv7ahdmOHeUMOR5Ef3?=
 =?us-ascii?Q?X3CoALLu4+cVsB6m66uJrxsJkPCbpknN+N08Oj5Bl6EXgeptu+xYAuz8fiBp?=
 =?us-ascii?Q?B6UcUpbDF/sodNH7gfOaaAsLc+3T3BHr9/TUsnxPTwvRoPTftHP1yRD68DR9?=
 =?us-ascii?Q?q27c8A2e5qF4klt/jkwKxLSI+p9HIhhaLz1cMs6fNg2acQI6M4d5G0IVUxQS?=
 =?us-ascii?Q?aY8Sz4Hag6Z+DQuTasPzEok8IhJul9ayBDT6DZVw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235a2486-1650-4d8b-7e30-08db78464832
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:12:25.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94CpKDIVSh4SCc+ObSracdwZ4lddRzOxYSsN1txh/P274rLVLkF3ivWsuNMlNnimAWAdmikJAX+OscHMbNZ8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7763

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

