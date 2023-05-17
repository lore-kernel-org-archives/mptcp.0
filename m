Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6EB64C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyNhqwY4rE2Bvhrkb66GV0A56NH071IGdCbaFT41YsHvcV4aheWFiI4+jRpXiQfDqt2Ie8kydSxM4PIgMEpJXRxobou2GZQaTh2vq7zSu4EoA78FoQWp0Bgq7BDeIdA2XbZ5iMpNW2pRnnFtKdfYXr+RlGC3raLgdMtM+movrXXXNr5vyN+zjtu02FhHJkz1EDwZTfSheBMUqw+R6Lso2trUsTRDfLbJVPxtqVOMdhRX+0noXy2esRbnXKmRdYtY5pIIqjqoR6LLNpj+Dcua58aoR7fiCGBrcd+bHU2dJkXxav6iOXVD1q77nYGPmbhJpAMD4Tu+oK+kORtGC4nioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ4E6h6dLInzisrx0/n7AJt19RBG4dIAJI53rxGf4uI=;
 b=f6wQ4YNoSeO3pRLCFSXXn1CfnCSWPfR/dCNNpURX9oNWkEAMP/SlKiFvQkaRT+4pTY41dZXUYKjBOCdkiTyTIvvlMuNg0FhOo6l5W6hD/RYEfyyzNl14X5dGoQ7lRVmaQLc2cfgQEmx1gFpUrn6pGGuEof1nntFbj887gCstdJo/Dtce586ZmBw2WWEXYQ7m8wPie12qXuYdr8zUmJ1XDNjh0y44AuO1lmK018TgiTCzywgBq6SkfeVppf5v08VmzJggOEojErTvny4pYjSiJCI/hnpqpDSt/NAfi+gHpOgb48rKd3lBAmwwyy16zu/W6Hh0LRy0sTk5JJhbStxc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ4E6h6dLInzisrx0/n7AJt19RBG4dIAJI53rxGf4uI=;
 b=4C/kkBd0t1jVRX3XItMseLNZZOT8mGwxoHmjQdCzvBYgoNFECX4LhOZGYZqL1U92x1nh46iPLe7wPF1VTiGI8x9Er73S1Yi+moq0noP68TZtnp+CbDUSNWivPfTauqyP2eazQitexAE70IboVXz6spyz7aZispLCW2q7sa+d/HH63TzbjytiSr6ow7t5JUzwrRXo4bpwjD3as9PBpgAFdmtTIx+2JhDejC/MChLpWG1hzFeyquBWpQfH+kTmLqO0HRwuVnaLwDeHuFVfHT/1u5Ldwjbxm5sDJ3+M4DjZVZK5K2FmVF3srnCBt8I8CyaX8eL2vxCFjn6KNe91dS68Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 08:41:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 08:41:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Wed, 17 May 2023 16:40:24 +0800
Message-Id: <17d077dbb03f7ae4b1a823e38bc9bb20b2a5842c.1684312625.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
References: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 793fb81f-f827-4612-c9f5-08db56b2737f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PJDUyUmRZFs2J0pHH0OLHEAOf133c5GOVq988rHtgIY8nm4/GVn92VpW+ceDhcn91gYFpTSo+TvPVKhbGwgBUxZCCBJqCoPZIGc/0e2rd+pOCg8t6yhBCSkXd6uJNIyND9LfT7Rf0STMG9Jk14XcAddqGrVIZVghqLn+Ty8H2vbJKdUWvIRT/rqlTlw4+T+M0fVKFMW3n4QnQsUelrWx3LRflrFAVbT47C//d2GLqrqO52soxCbrX49KH6KrtvY38nVYnwD+ei5qpIcwZewbmgRtJPV4WIJa0qlKjYjTWi3/DYTKKTCuHSomvf/kg3czh15u+acs+UuyAnMTSwAbX8EADxdXlsMN4RGCAud1UPKxX2pm/MPyyi2+a3e6MpZtImXwdjWL7aIyOE2owHYufYX/w0EYduvxYBwHykwNCLu6DAu9bY9hGDwOExe5dejIxoG/Ym9XtqZ5dm7Am8xnkH4s0kiAgHnE6NJz3KWKVNhEhV63u7+8iTS3auk9nySivBLaCxbTsyiekpOpUHLgSQRP2X43ccgjNYmatytuzSm5/8uK+48CdDLCiHSi0JeH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(83380400001)(4326008)(36756003)(38100700002)(2906002)(44832011)(8936002)(316002)(5660300002)(8676002)(66946007)(6916009)(66476007)(41300700001)(66556008)(86362001)(478600001)(6512007)(6506007)(26005)(107886003)(186003)(6666004)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AoEatsfPKE+zBdO2ovuV7KBy02ych3GPaE9yXMSxhS0DfJMWpQMTuV7mZup?=
 =?us-ascii?Q?3oqr0eyp0ZXtMJ41/1f0tFvPi58yVaD0nyEnmlkn3iy6e32UtXOzDPiOfrky?=
 =?us-ascii?Q?Lx1hSUnBVlBe+dOVuUMxS9oRRfnVSOaWtvt/OHWyrdEFyRSspvUReZnG/13B?=
 =?us-ascii?Q?bj0RWIxppCBGUF+wM6MX8Zaf5TZFlZhVQFOzX9Huj89qCuWLGrwXIjmpFneR?=
 =?us-ascii?Q?aZmLgYOnw+fesqbeu0b6cpQvKnQiW6ANIsV5a4R/mizmtfsFJY2wiVuqrFEB?=
 =?us-ascii?Q?2koEW7J7URAghRAZySHDbnAqmivGbIDNCvYX0xCqBO/UStjmUmV+RSV63fL+?=
 =?us-ascii?Q?MdSerMbAtF3ogGdDw/2IsVJkc8LkiukuSk1Jt/F4UyB6MLp3bRQYiHZ8+tWI?=
 =?us-ascii?Q?revvzmm7va0oyPAsl+6LyrLq9el+yI3oU+hgEmMS3K9MtxbOLjaKx8Q1Fvyd?=
 =?us-ascii?Q?7Hbvu+WWFxJuFC3HXoLJdMJ/Fu6Vv8WyQAr82gAo5ibsldfe3bXMZPrbHuLU?=
 =?us-ascii?Q?VSGH3wUbo5NnPkNdBtwhgrBAE5e/WP4i6xzZeHyhkPfBE1SsUVYHQVQoHdj5?=
 =?us-ascii?Q?MdUt3nppUN1LMSDQjAt751pZ+Akc+PfL6FNJ9gfeJv3dRkWybQjn+to7wN+l?=
 =?us-ascii?Q?FJnz9YGnRuv4hRxtWE3Qg8ac8XZev4WFFHVdv/bWXCPdlgveDr7k1oKLXc9W?=
 =?us-ascii?Q?x8YXpQpXymTRosWVHsh1ASic8/7qac65j9kUnpDdrLs2wD0n7tHG5AgdOJsw?=
 =?us-ascii?Q?S25S1iyPN/hBcdDRF43aOhmSEj6Xm4QQ2EvGxGmC7eU8FwMPFRQCU3Xvv26d?=
 =?us-ascii?Q?dKLcFwYNZio1Z1uXSL3DrwRXBaFQokW6337abcxvdeFpFeVBl7RmPST+LjaM?=
 =?us-ascii?Q?WvoaK1NaqNbdJTzjBmYgxObrUBpWJg3BiVDIylXNZYegAhhmHui+D74rzlrS?=
 =?us-ascii?Q?K+gu5e5wIz48ej2zwfAhS7yOLm4JDjLImdlcZhtZ++RC3bgwYVd+tdAn13Jt?=
 =?us-ascii?Q?VSMdRTVRabGOzCxDzQABkZM4eKrOGVSrCBHTY9+xt/FYB631PIQVAydsjgjI?=
 =?us-ascii?Q?i1N/eCO+7RAWlkjzm5x/nFsBrFGgm1XEhudpf2QwmmWbNHAdJfwoTQgnnONb?=
 =?us-ascii?Q?wESXzmnI5lrDaxFKWtNycAdiRooBbIT56mOQPv0jxBxk0Iyad8pxoE/iQRPm?=
 =?us-ascii?Q?oBdwdYWvrjqgXFeHP9h/x34UO0WQ28HDJ1G0MxvorveFwmEgbXI0Hp16wyRt?=
 =?us-ascii?Q?h3NX0B4uPfkhVduXEugjwibNk+u8rSwgtEEZuavUk8RHmhfRFfkdOMSelqhB?=
 =?us-ascii?Q?ZRljymJ/d1FrTKJrpgVQwifBnIRzisrp0feRCFA2z9KM+crmNzfEabTNSnSN?=
 =?us-ascii?Q?TwA5CnMvUq1qtoROjRBnl5DxV2GmXOfbIIyuu5ti82nAYgDyQ1CMQX7nRFyC?=
 =?us-ascii?Q?Xj1TiGNQ1+9yyPDJgK9JchhQz/1ze0kE2tytKNoEdBf+nnEMTSTCiZSVEle4?=
 =?us-ascii?Q?+d6bpIkPkAkeCaazb8FHPuyf6BwvfialcKMB2fCL2ovuXtJ8fgzWWwnXcKJT?=
 =?us-ascii?Q?6aWFMdnRwsa/5QKuPgzsZ9vKO5qQ8uLUJ298nn+B?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793fb81f-f827-4612-c9f5-08db56b2737f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 08:41:04.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJC24a4WBiSUCbwxo0KxWKUmdqAHfdfR7uCx8pItAedkSPskfrOW4rSVJ4R6++K7lF+d+9PkvgJIpaQMvCtz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6f69abcadebb..f318aba9e410 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -312,7 +312,7 @@ static void test_first(char *ns)
 	mptcp_bpf_first__destroy(first_skel);
 }
 
-static void test_bkup(void)
+static void test_bkup(char *ns)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
 	int server_fd, client_fd;
@@ -328,17 +328,17 @@ static void test_bkup(void)
 		return;
 	}
 
-	sched_init("subflow backup", "bpf_bkup");
+	sched_init(ns, "subflow backup", "bpf_bkup");
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd);
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+	ASSERT_OK(has_bytes_sent(ns, ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ns, ADDR_2), 0, "has_bytes_sent addr_2");
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+	sched_cleanup(ns);
 	bpf_link__destroy(link);
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
@@ -362,7 +362,7 @@ void test_mptcp(void)
 	if (test__start_subtest("first"))
 		test_first(NS_TEST);
 	if (test__start_subtest("bkup"))
-		test_bkup();
+		test_bkup(NS_TEST);
 
 	if (nstoken)
 		close_netns(nstoken);
-- 
2.35.3

