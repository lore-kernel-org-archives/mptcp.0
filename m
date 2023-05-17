Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE264C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdC9XhTS59eNngqDutozfGoglQp5BrWWbk1/Q5fjeY12liI3I2+R6ybSRU8ODomDBG7GBmp2eNpio7C4Q5fENzTbYdhB4XDiZicYdpEA1MpZGo3U/GLIraWDsFurX30x43PELxwtm8zYBQpOhTU/jo0Y9OCiTrOxUrtmQFUpMpLMrJtduCya5LmgQZHd4HQPPr3rYD+p2i2Lj/IHDTamj/07WOAlaxCIWACFogNualm6MZU+dUnBlltoGO0zXMu2kgpGbpss33IlXAf32u+bReKEbgjO6gKcTk72qejIm/aMDj7jQ2NxIlVbE2qxhOq4gwc/QGAP142A5aIVWVTAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLXWpzS7WJpf6gze8DU9khg9iDXrISAdDcQOlCqHqs4=;
 b=ReNqzySvDP668itITGTM216am0LEnuAmv0cFN04YWc+Q2VW1JJHjF7UH0lZ6H51KQRff5wIfZsAHzjsbiuTga9vExvDnOI0lQ9qTe/iEV8GL/sP5XybSCPaVT8omnNh3V61EL2zprtz09PvCfOzVe0V1AIUHoiWIqBLfpPktGmfkjZ7IzM30XZzBzs5UAxJ9HDyNsWYQwoFWn60S07uT59LKDbIKsevOeSF3qNBF+tgyZAR6B96vgQ9uVU9Hd1ju652iPpdy1P9jQmwupGiiPD8Pa+0HF+5w7RwIDt1uQQu3K6+RggHGJ+ZW10pe8ODmNBFiqUc9fUofFTWqYxuhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLXWpzS7WJpf6gze8DU9khg9iDXrISAdDcQOlCqHqs4=;
 b=ApJDfMliTDNGaPmde8kqHDJrj4DRskrXlHTPzDGNlCXBoSG8/DJ/v0qHW3oxHMd56oX5Y7JGVpVZ4lYa1V5yxzbhNvmK6YCW8YxsicwnVX2CfAkfC3lHfL/KrPRu8uX8YvictVHIFoKKVx57Ywf/htfyCdepUPEhd4LxqMWr5qxYJ/8pBmOh3E6Lp9DQeJNRgmD3y4szBeKHJz1eQogbLyf9q5IraaoIbuDMiM/P0SG7gh3TwjPR1oc/r7A+F5YajycDwIGdwtvMb/XIihPLlQubSQQrHqmENDBErRCDbW/SZ9RjRGy9lPnMBrLryXfrj8EB1cvrjn6Nb/IAkz7Nyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:41:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 08:41:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_red test"
Date: Wed, 17 May 2023 16:40:26 +0800
Message-Id: <29ad15cb28f6a38244d401ed80bb17e289aaf5fc.1684312673.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
References: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6b8a31-8eab-430a-5095-08db56b27f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XIJLpZMuBFatRgUZfmMli8a0gA9V6a1Ppds3x1COhHbXfgw2WSE+Ls+gJbDAOloPCQ1hPVdMhxkft3jAHKqUgzIEurZ4SoPE3CjJxSHoxdqkVdwto3ghp3eb7hvj0Oz2J++dHlOcV9I8Wp/wsDPDUGqQzF3XTgxFFCjhnt6CGK3zlfHgFPFb2+nHnFkVrjFes6iwmW6krdTvVj6re7HNhn1h9uhgbxWS1iLzJ1W0P10HzWLToIX9BFpbXz4cNb7ZOXT257tkKmQrg6Xx1+NOOzFiOdJybAuAfKkLLZu2JnVySb6koI97TdM7LB1Ea85LaemyBufuND31sHekhwLg8l0gcEOuFuz2eF1eWXkmAkhcUydrg5KIk6m4SSaXpKN+/ziYyWDnj+36pVucNt4U+I+ClbJ3JC3ohRhZJIl94TBVeo2caQRuVrzEtVfMcfCwVR9UJw2Enz7G+fNK4GKotgOClsjg4C7igh8liU3J1E1XZI7bqX9eK5FAAjwDUKNPct2gKOx1fP/C4uYGCBEyXV6TM7mBcAKcwjeXuBfxYmUSUAUnfMCdww+CvNlAXEPg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(83380400001)(4326008)(36756003)(38100700002)(2906002)(44832011)(8936002)(316002)(5660300002)(8676002)(66946007)(6916009)(66476007)(41300700001)(66556008)(86362001)(478600001)(6512007)(6506007)(26005)(107886003)(186003)(54906003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FS3d0de6IdhTJrbptlIxLZ9tGdfoc6FYBKzPKSVzP09vGqPAfqj8lLYdxuWM?=
 =?us-ascii?Q?pxEUtDq/9RbhYj0WCj1Gh7hRtUgPOM+nkTHwOS0j2LjZ87xc8ZnfKfzYq+/A?=
 =?us-ascii?Q?YlGXl7ifSqCBfH+9JlUixjug8slb+3sYV0lyI7oKGfLQD7yPg5tJ49PRiQZR?=
 =?us-ascii?Q?uT320hsT3macrwBrgilxK+NF8JSJu1A5t3iw/9UmoYxGXfb8yG9XtXy2gCEc?=
 =?us-ascii?Q?5qIY8w/4O+LLd96mOAyzDYkOKNHS/fNYevzOeSLt2OV8I7roPXiQZZlFX0rH?=
 =?us-ascii?Q?9IgBZJ9gJFYc/xtdxQnawBFW3Y1L0cmKYpwQnc9cYBS8tew8LNDBiFnkMLFH?=
 =?us-ascii?Q?OUcuvnXdKVbYx+BWeK73r8WcYQMgQAlki5mJshjxwDG8UKl0J1C77E83/BlX?=
 =?us-ascii?Q?Aen1T9rH+VMm09MhKmUKcOdUWuPHGd5zvmtZDM+v8rfrG02G6w7UKmzkZ0B3?=
 =?us-ascii?Q?u7TjdMWFR8Idp4kpBeeXj6o7FoWNJEzTKBqa2L9WY394Mpl1P79aUSn92maB?=
 =?us-ascii?Q?aVoDPR+GCy5YGEz4NI1LUMSeYFUmEoZdTEqj1VVEJbiohibijj9ABtrRrffc?=
 =?us-ascii?Q?mgYxACCDA1pYNJpQwc0mjWwwvh2UTCeRBOfssTMMgfGTlFdnWlhN3gfhx/Ki?=
 =?us-ascii?Q?jQosxMdtbuGQ4wgO1IYyyvCuDxS56QgYJnBbbckmRYRK4VRbi+CdWZvc+A4N?=
 =?us-ascii?Q?8L2d222Izs7h2x4XnOFUWZTgoTm/wsEzDmUW1Ztbc3LTlSDfmwDldQs6q1zp?=
 =?us-ascii?Q?ONFklFCugTk7f8chv3s8K/9fR4NUbjELyknhYppROsFIXac2li04fjJqZISZ?=
 =?us-ascii?Q?UmTBIeAnfwJoWqr/y/Lw9kdM0/wbrYbSI78P6ytyjt2UpY+0zDC1k+90jfZG?=
 =?us-ascii?Q?Rm2uPtT17zjc0GtyVt7dja+yZ9wjJlocM3fI1Jx5G4vTjLTCga5qATf2vyq1?=
 =?us-ascii?Q?cnopTTlMxQiA4VSQIvNDH2u+O8puQucooQt4D6+QkgXlrVKV6hsD7IRpTFmV?=
 =?us-ascii?Q?1iqIXxM5UcXTlRebATpVQQgL+wS2O7/Z0wIaxePy7yEi3XUVXo+BwHsJf7gc?=
 =?us-ascii?Q?psaGJ9dvAc2svBs3Sww678asA9HjzYaX0O2TFS4V9+VAYhSP4r738EK2lq3U?=
 =?us-ascii?Q?lKo1J6nPGCya4WihQ+IlGgYcSmqPBwaGHZ5rmpdpLdJ07Az5BTIeA552/0Jk?=
 =?us-ascii?Q?wKNtBHPucm9eFBAwv2Az5662rNfq5h7vhAVG5sQJxCR2uh87xk0KjYZHTKJQ?=
 =?us-ascii?Q?EMS1M6DOJQwUNJOZ/qWGyYiRHR77oUYYDyXihNgJs3nGUnuH010Qt6WSCILw?=
 =?us-ascii?Q?NjCNiDR8IS5/Tm5ENksVtCtn5mSBM8xPMyZ54UEq6XNmnBzUitUO69amMQBb?=
 =?us-ascii?Q?KbmQQy0fPDz2SsW+tmZ3FSZGY8kxpzbuW/NRRzFe/u8rs+kmwPQe/Xgpx+0C?=
 =?us-ascii?Q?VOdfVxt9VqL7SfNngA5r+7xsAK+SpUK9ZzQTQ8QprN/rsc7JtvbkRPc/8rAE?=
 =?us-ascii?Q?3NvGcUdUoOGdME1HSRQ7vaHdPAWvBbFzELWhsCyNwi0jQspZBG+NBzoDXmf+?=
 =?us-ascii?Q?oL7O35Ms/X/arzplj2unVPJPxTO6DrzxFuuuWdSl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6b8a31-8eab-430a-5095-08db56b27f2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:41:24.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eGXVgBTvtZfTiTel3ZeFlRZqMNXeR1eDH/d+eCyU7F9nEknTHFK/WjMJwqsahx95QFhmoOa6aqNgGVe35djXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f0f9aa517ec1..83af690facef 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -376,7 +376,7 @@ static void test_rr(char *ns)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
-static void test_red(void)
+static void test_red(char *ns)
 {
 	struct mptcp_bpf_red *red_skel;
 	int server_fd, client_fd;
@@ -392,17 +392,17 @@ static void test_red(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_red");
+	sched_init(ns, "subflow", "bpf_red");
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd);
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+	ASSERT_OK(has_bytes_sent(ns, ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ns, ADDR_2), "has_bytes_sent addr 2");
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+	sched_cleanup(ns);
 	bpf_link__destroy(link);
 	mptcp_bpf_red__destroy(red_skel);
 }
@@ -430,7 +430,7 @@ void test_mptcp(void)
 	if (test__start_subtest("rr"))
 		test_rr(NS_TEST);
 	if (test__start_subtest("red"))
-		test_red();
+		test_red(NS_TEST);
 
 	if (nstoken)
 		close_netns(nstoken);
-- 
2.35.3

