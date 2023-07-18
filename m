Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3417CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6CSINB/kMhEbZxeMstoFXCbNxOV8j49fa3ycElxhxik1wdCFz5Hh0/STKVDBEGEW3QQKiw4302/9m/ayiNYXsN+9G7cv9MF5nCvQik6B0pmuMFqvOUi78OLarxBvj9bcm+fFBXew8oEKSpxd39BKv+SLv8PGTaA6u2JK8AUGThpfxpxHaBFtY6nw5wcjxpta9RXzulVwTUuTzhXDeTej/BOQJu4aH6FiPvsr0j6yGaNXBj131CRRR1qn36+EUH4+NnJfUnAgnwrvWj77OtRBXYXyy6oapBFGBa4QtO5CKjAdoLr9XHCg65aAJUFcTqLYr/y3RqwzKX+xhrd7IMUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaGKEe7sI4owPvk8ZcIQh0/+0JZiUjydSD3BqofAcXE=;
 b=PuiUPjgzbLEPvobFtQ/h1adbP2gLCxXi+aoS4lFNva2Q6/mX9QHZ9/2ujpj8zwEJGBd1rX/yjvJmRnNrMaVG16DkuSFyK9utrWAnvUT8r431fhUsdTqVnv8m99JX/hFCcn1ENDNBA4E+ZkUWYGFgRPNFTVGvy4VCa+qSrmmTqPbtYEnjEFB5QMVrTDlBnSo1b4znCHExIcSq+QCcho8obfO3ozzvGu0StXQExU0npRABsO2vwtQi7lRWI7dxJRUDqmwf23Ht1Z0VH98rsJWfCqLkkhxfhVOXaI5CFiE8DDpwos9ezsIIgu3pdlOIQH1Y46aYDI+coGb4Jz22zEw6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaGKEe7sI4owPvk8ZcIQh0/+0JZiUjydSD3BqofAcXE=;
 b=gp6xB5oMm+oy21FXAoBMlllpdAgqTtrk3vn+ycl68SHJGW5CSLG6aZJYzkW0XFSKp/XZkn7TckS/HjKguGH9sNjuGKT/AU2+PTaaF/9RskuL5/1mxcgWs7BnCpPAAwNPW5q2WPIEoPZaldrCp7Bfwr6DTb8bV9NEDadruuu9gXQtAvCGdkOPN61F5lOL7lRAk5N8Hj9/aVbOTJhW7lfVmEOtppXptJad0dC/7267FCVURmiuL1DpzARtTDv2IuL4b+HRAsxjtcsMao5dxKWlpoKWa203HmpjhUZ3NYpyxtnbD5UrNrSI/fmG+r90VDBLVl7VEHOna8zvnzrzkXs+BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/13] Squash to "selftests/bpf: Add bpf_first test"
Date: Tue, 18 Jul 2023 11:36:40 +0800
Message-Id: <9008280de471fb3dac1db9d8260b955b25d9e28c.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6bea5a-a39c-4102-70bd-08db87404ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JSpFqc4WVh0+pLDQ3LCygUwsm1+Q7OoppB6ZFjIFW/e4T0VND0GHXt+6dQBSiG293oThgY6lRc6a2DLe3olY5O3YqGiNk5TGFNrfeczy4hCmOLDzgkr54ZZCJqlWWD28G6f761+IVkFxVO/9sYuGAWufoQhZ8Yeg4yQHLeX0jhllkahIGs7jjsTr3Ujun+t9RnP1KouLaQMEgVa190oCbCcNTeOYyfTtzCW0FH3C0ihhGZshSFMvg05pYnkJ8e1vnDCUQArrMXVBSFid/9BIASqqGUUkyJyfGgl7jf1qt6SdcGMmIJTX2YdCB7cgFShrcQ6UFyiaQFNUuXSEaBos+YtyJ95SMKll1+tfCzW1PLVY5VYDWW9sxUMFQ35JH2X1OpO/BIMDfujw+l7xxuEeWAH2S0MDc+s/2Hi3zAlTL+mDKeuocg08xkkmtMd/X9byOorr1tadxklWnmyZBqSB0bdLgzvo35btCRYEO1CTpVR4kCXlpVD49XRhn8Pir2b71mjZ8vhFPDsH9OzLDtbiKPl66JR7nTl1ufMp68hh44VGmEr4CMNzlQ9Oa8KDywj0u+qYGMbj/XxdnmuehmaWhKy0XH23Vbp1hkgv07Sudfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(4744005)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AMvj5fj6YrOoZK6RmTmzth6aReaLqW3Lvpj7jz26hVNz55MXfCLWfrnZZOHb?=
 =?us-ascii?Q?yXE8K6+dog0PNchyjcHqdZAndTU04lkXTHA/lRidhPsVUn4mIgVGkFJwYv2Q?=
 =?us-ascii?Q?PA3DBz+OJyiexqZypLRsBbsjP6VzL7vsjJ6xMuzdN6LF0Q62xd95PsBFvucU?=
 =?us-ascii?Q?krSxNosTx0bL8vtcTPlXnzqGevKy2RSKt3tm56d8chkyuHomyzEE0xZuuVox?=
 =?us-ascii?Q?2F8oIf+G7PeqXmUFZDNvSobEPAQlaFxsOUjJxdPIqdSVzmElyA/8roEUGdfC?=
 =?us-ascii?Q?Pqalxs9oaBvisV65Jseej0Q92DYT8u2JhdgR4elw3GWTBlFqi+PgHDvcD0UU?=
 =?us-ascii?Q?lHx0BFZcI7flmtldDydrBl3aB/2Sm+N7syy37RkZx3K9n0cxglhSQrcvGSaG?=
 =?us-ascii?Q?yyxgfW0IM/WCXVUVPEzJn/mJuTveKLq2yXo3ah5QzuQ5VY/ojY8+4qfUHd/4?=
 =?us-ascii?Q?qooFOv2CZNh4Eb2Ux5+0sgglMx7iS3Fz/eV89+5kx30E/UWXum2eljJ53Dka?=
 =?us-ascii?Q?mC0YNcsJMO3J2GeO0JHZKTZVDf1fuN2hT1mNrF1439Vw83Hb4GLJQcjHsOeQ?=
 =?us-ascii?Q?5FUD36nYqsdPu90ozTD4AnPzyio0NyUgbUT9JQWOBwrxh0FLVEjX1X3rBepY?=
 =?us-ascii?Q?A6ZGXO6j7qM/WVrjY2FE8XhKYdTIhqVn0Pn4v0DOEJ0zRogQVqtpXliU+NGA?=
 =?us-ascii?Q?lE/HhIUF8bNCKLgp4MZ0BMo44CamFqY6FIKeUwKe7Du/YVnkLd6FK+lLGqTo?=
 =?us-ascii?Q?MGkWQNxechlqQ8OwWlU/L8xMd/tQh6zneSmoGCDU0gNf8l6LbIAmRm9tT0vC?=
 =?us-ascii?Q?xhhfzXin1RP1HfzqGvUY7u1qbU3HEA9umquLsWNY9Ui4MpMUaM313ZGGyYr6?=
 =?us-ascii?Q?kdwWj8fGoGwdmpLKVPLson/07Bbdol0V9HXjeQVoDHws7owxWlWFrzMFEM3b?=
 =?us-ascii?Q?I9S037s5jaQXoPy4JE3435SRezrknkyhbxNklleupveOUEA72gaxV3N0klKM?=
 =?us-ascii?Q?yPuFmQ5F9G+6XhtDaE0NMDA1bL0DsITx8GJsSLvwevzTqACaYpGJ3UEaFTG3?=
 =?us-ascii?Q?sBFsE5wXZBEk+XA/4Hy1xRQrnUQk2FSf5p0yU1GNCDCu0GRnO/mBjrFQh+QK?=
 =?us-ascii?Q?CaX9BbwH5+MJxeAA07dsw4GqMlGygsnM7IGfDMuqcjGYYfXCT4SK6pm/02yk?=
 =?us-ascii?Q?+rai/n9+WRBdLG6fDHu576zdrmTjoFbbrlGiqaw1FYpNzbHYzwUjzParJTu9?=
 =?us-ascii?Q?Gwq9kHoIa6GXg2zBjLFGSmjYtMNgZjGlBJO44o1FWN5lRQk+XKSXJ5CzKc1c?=
 =?us-ascii?Q?swVlovpCED3wuRI8oAUldlzml5PXr1agZGuUQxzhK1wGuIZL2pJISj4jYFdG?=
 =?us-ascii?Q?FaopaJ+H46OOndNMZzknA9UYT9Q3VZ1INkmBuHtBgUt/1fHNqmoSABXwo94N?=
 =?us-ascii?Q?Ux+zMHiUl6dp81yPUW/XG6lfDWrj++t5JdXOps8bqBbQRNTgwv0KnK+vbsQi?=
 =?us-ascii?Q?1T+uwLDr4++ZorsZcwxcR29S0zY7+hRHqYKlNBPmUawhD2FOtxvBlIMoksUQ?=
 =?us-ascii?Q?+yDb8BM4dclYJQNCjRZQKCRnMTK7JlTSkEB/dRVe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6bea5a-a39c-4102-70bd-08db87404ffe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:29.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dobKdpeQN0NlpHgXnZ6GOAFAl6JVxvA9Q4sg8RiJ8C5lLmPtAPpny4AC+7zNaHF8pIlxos1llwj8ShCegK5dQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Start server with PORT_1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f648e5d49f12..f09aafdff43c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -369,7 +369,7 @@ static void test_first(void)
 	nstoken = sched_init("subflow", "bpf_first");
 	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
 		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd, "bpf_first");
-- 
2.35.3

