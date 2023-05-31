Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EEEA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2OhDaSCf5NsmM7KzDHaA3tZ7fXEzQfcexQRp66Dc1x7yaV++saonsiTuXKFLWe6C1/sLF/g7bp0Kkbdup7hvC6/L0gjy7lZrnqlnCNcJWhwToS8zbdIWVJ4F+VTJesbih8qKmj4hLOZnpERaBZ0Ip+WFJEVit78oSCd/dH6YhjCVx4nceHkFxHu/ICKAmGI8NVt1/8Vg68bfuDYZ555hdOK/7MhyNCVkBys4qez7eJeYFoQPrVGKvoZzwqVGKgZLB6B37p8jiJgSVlXoRN0VOKXASd2lQiRPTQeobaz3kLXtwDwaFAjLohTf0h8AsBGCffCXwBqnqZsIo4YtsByWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcpGihSfi2UugsOeU4DcaE4+7U5heCbfe3NJ4m5O/Gs=;
 b=JHAVnjxpC3mF/Zgn7OkRSUZh9F16JzZAl7Us2D+lXWQfuCVK84/Dh80ETs+AU9p2Kwb14NoWZo4DiXKXAsbtIra02iHvqTqp6uMVzzgBgtBcUdL0y9467XczpSmf5M2gMR7ujBWX5X40XID4xlVnkPRlCbHv50iSnzeMOOpRruBKBXGP1HDI2tnO9j1Gzc4LlmwbEX9fyGH+pB101qXIy6J5n19jOooohPKMXkOAYqVNKDWY1fOzZ7ifDZS/qXS8GenZ257iFa9xknCYciQOCyS9yCOpbsPzwUBJCzU+BEOUVVWvduJ9IQCaLvOmLuNukovtqu9fAeTRIKuWAbuR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcpGihSfi2UugsOeU4DcaE4+7U5heCbfe3NJ4m5O/Gs=;
 b=Bguxh4ES0Fayr7YGZFvy+ITi1F2KfC9PTUGID65Ut223khX7A2QTcaFUR+BEW8plbS4WBZ/pS9aj//i0AEnL//wyb0vncppKKEsD8V1JMfxGUn5xojzZxz3LD+cGBuLLGWOFEulfgwwGX1DBj4Wo6BbfVCacdaI27uF76NVZ2Ety+U7vXUgBwmp2CNkVYpYmX9ohrlGoP2IpJHvjD+kmf6WrjGTPsA5MVYcGqV0fX9vpQxu5Wkl9HWJB2k86Lp+krj8RQVVWjiHkmlIdbO9u0N8My0wfsec+txacRCVph/6GUqeZx34GulF3rorewkoPaktEv+wuR/VvgDdFYf5G1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:53:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:53:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 4/7] selftests: mptcp: check subflows infos
Date: Wed, 31 May 2023 08:53:01 +0800
Message-Id: <1b57366a8c88eb43b7a03ad93f1156891da55515.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685494054.git.geliang.tang@suse.com>
References: <cover.1685494054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7d104d-4fc2-4e93-0480-08db61717d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Za4NkgAbMb070w/D0Ec1Tdy1HKAy/umM2/k/OHq20w44drQ5ntTuQ4xm6NACf8Ayv4dGKBeMcn5nymwha4GfVecaTiA856UOI9pp7o1cUzlajLss7Qp/j8X+S4fSbjfKvou5uOasylLRNcnokC9f74oM+8VCWKXasPedOI2a8V3u3Nxaj/BZfLjr/67g5CR/ZyLLOR/GsTOEacuGt75gX06P5EkErQls+8RD29fV6L42pskOHzvCAHdPnuCaRt/gxORtehtCj27Tqrs8qOYrwLMY6RKz6Z28uICVogj3kijV5cspCiKiq6W/X+Os9/DJO0C75bSOqWT2LtZPot4jVWz/Ti57PUmT6xRPd/yLW+onhK1RCVHDnilC+L/eaJ8Ow+K16fJRyHCqIs1ZTNEx7DNSKWN+UWCTrBNuN2PcoTv97U+/sg83/VmGQRRcwD9rwJgOQog8zqV6geCedqbkjMmZ0GjrSg+ttEBWyOM+VIqyQ4i6/rVKO6NJMXzts3UncD6WaZCxjenqT09JVIY5vbDxdPVRS4DbbiozlP2IvdMjh3bvaUY9waRpswJzfJ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6486002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ghHlzKw5r01FZFcaws8D1pFoKZOYyWiOwl5WTtSElziOJU2jcTJP/ntGKMd6?=
 =?us-ascii?Q?clonswqLOdQdr7xJ9G7ojo+W+uC1J5Q7bDEWaAeQ6B5Zxy9hCBdaVch6eE5j?=
 =?us-ascii?Q?XE8h1X3SyE4HcXNM9DKPnSrIRC4gUfm3nRI0G4yYpLe1btmXlaW2AuYoSnsI?=
 =?us-ascii?Q?Bbjw/E4m/H8DUxb+nihrFq+eSSvSGhckO4yEnaMMIeHpUybFi41ZvnYAy4/E?=
 =?us-ascii?Q?r90LLh/I8T1RLQCAsq27BZ68HLlwnVTLJJMPYUfuB6vWSIfq/bOzhJBqZAQP?=
 =?us-ascii?Q?6yUQnMeXxhXzJKLVvzWziuRct0Gzzja/k8MHYhdfn9PIZLrxjQP7+seSfHvn?=
 =?us-ascii?Q?dLwBk9l1YqfpfVcLT/wqafpxCrmXQSE3iT3gOaYk/L62TWm4s63mCzqinH5F?=
 =?us-ascii?Q?V52ZMCgdtBk1Sjfr/4qOT9cCbHg5x6OikUmlxUVMl61EGyYmbvwhRNR52bZO?=
 =?us-ascii?Q?SGS9QMwwaU/uBCcw/cyGlfs0bipuOjr7HErjFcpJ+Y7bF8QCdruKx44ZDMEl?=
 =?us-ascii?Q?Janc5/g/3nrjQ9zD/B17stvHfGmaVospZbRj6xIkeSOD4uoYuAr4Npf9SWME?=
 =?us-ascii?Q?gM5QPn6eoLTK53VuBSFu2vum0g1HEx4qTEtz+rLOpa9QkClqukeLEZAX1A31?=
 =?us-ascii?Q?NIkMkACHQq/Z4CFbhBLkpNRjE+tnkju2v6W7aARn2O6AVUlz0fO4cXCBS7/U?=
 =?us-ascii?Q?pTjsxoRw3yG+742VBrUwP4MmvjnstYTC3FKUWQ7vvxPjukCUfFPzGXx09TYm?=
 =?us-ascii?Q?TRXhMfcXlaMz1/kwnzuVw0tHBKY+5uASFR3fjvL6He4GB2QsEbL6ksbEBVTb?=
 =?us-ascii?Q?HkJUftED01OsBBCxqxA1eO3g21xmHU16cpdZbk1cA/1AolHEIOoBlZpbFYw5?=
 =?us-ascii?Q?NFZagYjybZjhB0J4gt/Od0OMMXNi9WhJAR3hhCTfyxzCX0Qy4nw6Hu6qWYmb?=
 =?us-ascii?Q?xVQHmDBsY36Z0Rnn7PB9mBhnQtWqUdekvA4lxPgO/1VbQ0S0k8wLZ8CA43ay?=
 =?us-ascii?Q?9t57K/uzb5K0q/TdDXE/gwFBirEv8N/kC+us2SZvGzQf4VLbGZGEZ1KuWoym?=
 =?us-ascii?Q?y1CUe/blmGeyG6mnzaBLtGKggvjoFiDHDsFJSKg2SewnDlupWbqWMsqBl7PK?=
 =?us-ascii?Q?UdrIgsfhZAii/GkTovY+y1T9il7vcNkqU5PrQ5iRZmXLFuKKt03MA0Tp6cjP?=
 =?us-ascii?Q?4aJ5MtyanrPU429wl1H539IDIeb7fcgXHorlWUE/5ikLAjcmHkspU7l591xI?=
 =?us-ascii?Q?5vbQbdMty2urpa1COYwigFVkGIMPb6KuTj6enFbikjOBbIAyOfxS3kX+6eUz?=
 =?us-ascii?Q?7OWPFtQjJ3m48rOegTeEAesUepFzrAnfa7W7zS8MpDsm7TxR6ejKa7HVNJso?=
 =?us-ascii?Q?KwLkSlgCaX/KFuBkkFx1tx7aGiFyrzOhEczqL5Bh1hsMnPtmAh2DQOSdFpn4?=
 =?us-ascii?Q?sW4MkO7S/2e1+rj0NUFCK+SKdtKEadI4KmZ2BYWm0WxMt+72TGLMXXsYnRAh?=
 =?us-ascii?Q?/x7PcCftXXiw/OfOLInJMFKB2UcQ7K4cmW1Wd/ywipfIry2Lsaj3duXKEatL?=
 =?us-ascii?Q?FbkzyxnLAFO/FvR2YhNZuwlVdQfsYa/sIUGKsZgJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7d104d-4fc2-4e93-0480-08db61717d1b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:53:46.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc7MD/f121N2WCcSmiHbc4VXp9l8XrcPBBwtWyPwsVMhb7tPnvdTpoZIpDOKrfp3OxCuclWllxO2k/oXGbMg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

This patch invokes chk_mptcp_info() to check subflows infos of userspace
PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 04c15fa6f4a1..846d028f0b16 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3312,9 +3312,11 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3330,8 +3332,10 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows_1
 		userspace_pm_rm_sf 10.0.3.2 20
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows_0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3351,14 +3355,17 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows_1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+		chk_mptcp_info subflows_1
 		kill_tests_wait
 	fi
 
-- 
2.35.3

