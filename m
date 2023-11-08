Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FE199BC
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T++j4G4b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY2ddbd0uFEWw94cuSsOteQbwnmyeP1zedZ8F8HzNCOVrCK5hjG6nSsZVcf7fguMjLW+vw0gPtryEQBhKCpJ4TIOjmuMKlQ2Q9f4AjHSCkC9JlcNhXHGGRgmpsOZVPOwTBKOKjPpCAA4yLA/GSJIwCZDaYvvpQqpsCmMB/+R/YJs69EqhhdHwmRIxEzuka7vFgdVxDdk6MIKlJ3wqpqfDgk0QM27WvUrTEf10c5yDXtvq4+iHkwYVb6hJAgC/gARVYgpHfJ353xh2z7CGDbPJyJAEgMiBtdfR5Yz90p/qaTBkL1AS7OJpwWdTUSJha2P3g4KRd/37KvU4bZkgjCRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLm8bvlL/80xozWFygazYO+ufwcLyraUleD1BUAj+iI=;
 b=W1kfRiP1TnpjJr3vBhyksyRqtSVnTxyJP8IAjMcYdYkAbLq/21wabMkv0njnTHCG1iMtaUArEXMb9m1HACnxklbv2mHGPh7p+fNenr/w7PizVS8kgirKN7nnfmM4HqSOGCH8IFUgiPhyS/47lG0vxQ5uv8k8M732X4mlZVY+5n7jRVmpwsOs2CZAPPbaTqotGM9Ms3oimY+Mmq2LpHxIgbCt1mZvXVVLFtLqMYA4xA00Gq26rwob/EMl4decx5bT6fg/owsserXWSKx5cf8xOabkB6uuw18ZceLSQhx0tawNZ+JFx1U4AkKUUCE1FDR/altCDNM1CS9k6kOuHxdWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLm8bvlL/80xozWFygazYO+ufwcLyraUleD1BUAj+iI=;
 b=T++j4G4b39J04fRpovgo1X9cK15M6y5wtdeyMdPDjP7g8pRF+7Nc4pEjrCsEKgsh+lgUGbWzTd3eZPMX+M5pUuXiYaIJbco+xZqO7JqLE7kvs/3TS6tip2z0ZUSYfgSueM3kbmDLcscpnIkeS/ar08gWBztWml3Nlk5ZxEpaDbc4MKp0yTgz1ykCi12S9ze2EORpC7pxiwf8mttbpFXsP12yIBqfdM4T3bOXc2zGQFlagNlhmAz8x42TWQ8iu6SWzcx9cTo5qReETDdTOLMxDDehk/FeWV008hDTeF/VzK+O+rWtIRVwbucOCbsGDQK0UjEodKfjCwQP6bS7iHr3JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.15; Wed, 8 Nov
 2023 14:12:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/13] add helpers and vars in mptcp_lib.sh
Date: Wed,  8 Nov 2023 22:11:41 +0800
Message-Id: <cover.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 51936225-7524-4e0b-0645-08dbe064ac9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UVkqqzCsysazcNOQKriuS/MvKBzMmkmaG3AxaoavRHampE5OfNgP2D+B7f1NQysLVYFs1ohNL4juH0ip8VhB4Gr2gu2kzSC+0WsN12yASXlbMXk39OM5YdLYD0VoJkW+o1QOHaoVs5IEM7WUhnUK20owRJuFa/1PZG0dKI221g0eQS/R8ac5NofPUeE89/rpoxDWewR2XgOFvTvufnvxNy+0vC5vINS5hxuWN/CYgh3S19SqZKVyxh3rzIF7ESS7lv7Oj0mlvqIbRMOHPpp94GeDodGL2xNJVFi8l2t9DULNUZNa8Tt0u5x2rOZuogRxK0iJ3HxfeyyYeX9x35ObXYymFjZODDaEEY1ChMx1hQFrX/TMOBCZHvtmPDSLhkVzxuJhCJ/lOcPPrGTpIpRp5Fr6HMSIL3h3PSSkcfFIPkqJ9bY7ANH75gmuagHZtweC0u73YcwYnuEIbDJwn5r5ZBM9N1cVgmbc8hVhbxFqdvpOiOxdlzb3YUqOwIV8dd0Qf8qYISclYcuMuFkpZyG3vTCZnAW17Z2XwFaA5dmQts9oVrphpuN6uwMXnUBlvsNw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(36756003)(44832011)(6512007)(26005)(6506007)(5660300002)(6666004)(6486002)(6916009)(2906002)(66476007)(66556008)(66946007)(2616005)(478600001)(316002)(41300700001)(38100700002)(8676002)(4326008)(8936002)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aus55BrApDENBjQgYE5wexRySYFQJ94Oxhe0QYTY8QAO130nP0SkGD2+ereJ?=
 =?us-ascii?Q?b1hibUP4jYf4V5hSAM2c3rTkEMoTt6KiQSHEmSZSECXd0J3L6kAfAsmiv3Aa?=
 =?us-ascii?Q?eg2TodfvktQfi4pWciUkSsyTOMDsTm82KaM5cFQCTcVYaswsx9L34gBkZcMS?=
 =?us-ascii?Q?3BrMogBmBvvBSGCOO+wDpdyBVn9+8DYdDhG4ifV6Fm6BMipRbi3K7IHwN3PC?=
 =?us-ascii?Q?V5Sgsg2yZ8YUBZ+yuOeMbx2RYspVpFH//sHTXTK0L7f+bubsO5PA62uA8kRe?=
 =?us-ascii?Q?jG2YKuepqiXYAF9P4vMWdPrhtDBDOBvFMRZnM1DwmM58BuTsMPo7xTI2+hJF?=
 =?us-ascii?Q?ref/AfJBSUxV18nSIZvqOERN+taAi9Zb9qt18wMpJwqZ4muCxXgu6CoTDRPV?=
 =?us-ascii?Q?u2LqGetxcdX3dL9GHhlcEMu2Udhh9Qmy/c9SpS8Qw1YUJxO7lBxsrRpgfHG1?=
 =?us-ascii?Q?PSdY3zvrrKMY/zpQ7x4ucDPTucQOyCXajHCIEwt97uflVuI36vDnv2qF06i7?=
 =?us-ascii?Q?MbH5quKlvGTMsDtPXwRwQ9NA7rGEke6Fm6G/Kntn3NpaCW0YP/RXT6ZC5iXH?=
 =?us-ascii?Q?6XK2abik2GGeonfpoN3+Ez2mNBkZ2LOdeZMXzXvpFVQkvwc+xSx9267/DN93?=
 =?us-ascii?Q?N1Xw3iSQ2zE3ChBrajBCfBQU+9ZJZh/hKB+rQmgiy2T+g/kE5JiqNzP9ckyC?=
 =?us-ascii?Q?y8/rocmSLOv1+hih2tQZ5+8fX1vD2+WFAV0mAptKeTau75JJzfxAMVNc9N2S?=
 =?us-ascii?Q?tqgxIawQ8M+Xs3bqQdInp4wlWrb8w0akcSiOTs1WndDkj/eSp8QaI6rOsel1?=
 =?us-ascii?Q?9f8jqESlpuZ3eVlMr0Jw9Scte2R8Da79e1Ga+PGmmrwFyGMyJGiW1YRtKLUt?=
 =?us-ascii?Q?V4MdkmgdxaAQvoL2JeMZlfR82QFH1LiPlKxj0bzxsS1AAJIF7CagbE9nnkwF?=
 =?us-ascii?Q?GGEV6+STinkWtTDiAxrmn/i8Kz0ZmBzJCl9mfCeBAYna2qYFjFSkTYw3ijq6?=
 =?us-ascii?Q?jb581onn1lKGJBEj0RPX+uKoesTuPxHUWzKVaUKPS/i2usMrsw0WeIi7QKE5?=
 =?us-ascii?Q?R/lccjpQwChcKEBLmchPdlwPA/vOTZk9VOB6WFNqTYtktMvmHQEYEFz0UwjW?=
 =?us-ascii?Q?hp0V0d2Nlxb60dZo1mjb7um8WsR7b6p1PhIqrO39TJdNvxYewLreA3iZzHOR?=
 =?us-ascii?Q?w/W+EAetR6rwK1n9Bknx51JWuktG+HLnhuE1jo2LtpcH9z+u/BvxopG+xydc?=
 =?us-ascii?Q?stLa8q6MlhozdOrwAtXmbrE89uKyZ/NaKLHKf32qPa5DzG0Y4Jqecm0+0VT4?=
 =?us-ascii?Q?PcKyfUhle5oKvpRf/AHgXCdS6mc/yOf2Bzg52tkL78G6jb89gjsJH5Zpuq0w?=
 =?us-ascii?Q?dgxAIAAhDdN/aI5cWdJm36vcrA1O1J+fdXnw2i6KKyvvr3x80zjRSj4wjqhJ?=
 =?us-ascii?Q?eiRbvdj1pCB33m6cgLrPhL9ZckW9betjCD/q2xWadn/cs7nb5VNSZ++Eb2TD?=
 =?us-ascii?Q?AVyl73uYXomP4aBYzb4WgadJOoV0WfoqX4UUISsVUD16K6ejO1YnMGwKyd/E?=
 =?us-ascii?Q?D2XtbJb6Vd4cJJpF7vS9Z3hsTW8eW1VxIN8NK2hL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51936225-7524-4e0b-0645-08dbe064ac9b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:00.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBy7BnhnLYAQv0lswpfFd/YsG1hnpzlxujz+EUK1Xk1I9Y7HIhVkEZNgz/C/LP4JDV3vqDINWmr/9WZW3g4PQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991

This series adds more helpers and vars in mptcp_lib.sh.

To make sure this series can be applied with no conflicts, two patches
in "userspace pm enhancements" series are resent here as the first two
patches.

Geliang Tang (13):
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: do some cleanups
  selftests: mptcp: renames some variables
  selftests: mptcp: add mptcp_lib_echo_* helpers
  selftests: mptcp: print colored outputs
  selftests: mptcp: print TEST_COUNT in outputs
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: add mptcp_lib_init_ns helper
  selftests: mptcp: export cin/cout/sin/sout vars
  selftests: mptcp: export more vars into mptcp_lib
  selftests: mptcp: use KSFT_SKIP instead ksft_skip

 tools/testing/selftests/net/mptcp/diag.sh     |  83 ++++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  64 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 156 ++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 202 +++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  60 +++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |  21 +-
 .../selftests/net/mptcp/simult_flows.sh       |  30 +--
 .../selftests/net/mptcp/userspace_pm.sh       | 189 +++++-----------
 8 files changed, 405 insertions(+), 400 deletions(-)

-- 
2.35.3

