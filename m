Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54C4407
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="xyakINfF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrgAYV3GdHzAnyVw0rXS6o+Qt9wFkvMJg9MOtc92dqQBW/lUa3RPhtZ8iXiY4Zu+gW/AWen4kw9IKNFquS4OiUFrjZgqxmbrg7prL009go/pNzjdG9sbh04/QlGv3b2rzueHpH5MykRlnXDs2VfGb0GA1XuodY+fcO8Nh2PY+gpWzjfaSYj728+KjbhLogjc+frUHsNlRpDQVci7gloe1SSIbltzUGUCn5d11EXMjA0iTobvRdqlNtnzW6YhlXAa0QV0IQsRwEVZBDxsTnrodux5zk+GznCLc0RDBSlrqJ622QgN9o5qTD8NtOywHOetU3It/Ok8qZDofS2y7N5xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmjyrUwU0t2Jn82AfKpT4DFP2bbwuHKypIf63Vpurlc=;
 b=np9QHQGs0H1ZYdJ4Q7EAE7yO59FpZnz4HDyXSlm7v2BQaUSb8UnRs9/aMktEIcr0oC8dTweGTd1LpzARyPMYjtqOtkTRFheNu47/+oWLFCrjcWQdnGoiIEm4usggzXA/IDCuntwcXB4mxA6wA/6VuhVSE3skwTGKGDNNldjxPVU9kE2607DmTEibBR3C3GJM0Is3GaiiCeWPXd0+Wqu9ZVQxUinUBcTmv0w6ocC9s2bu0aAu3cSBov7Vx4KPDgv5gxIZGIvETibJpEVFjW6pHeX746duQSz9frlzb26UYMtgjP1mPo8dLlnI60W/MXiqomvgRl8uy956OsivxqHIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmjyrUwU0t2Jn82AfKpT4DFP2bbwuHKypIf63Vpurlc=;
 b=xyakINfFOM0uwoNPR+5dQ7Foz8gLVbemyR49yAETnVeQz3nMopl7Rlw6micZ+HAuX2FPu77jhToyhhNhdKLqmMbio0bgs9lgp4caB2f9zLmOg3OejCkC5/Z0u9K9TyuWfBHt/OhHF4dGm1+hL29ux344N2fMuBgI2m3D8SQX24lCxgkZf2mHQDafM651dF6Ydoasy0jqZIqtcyUQOhb6JJCr9grTLnPGpSuNyFlvjRFJYsL1Bx6+FdSV52ABJA5EpLdydamR8O6f263N41kGenVrK0MbfjTDXRmh9aSuJPi9VhyhUjwprIVg65uuJz+IL54KtqNiMb9Fk/RnaN8rFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/32] add helpers and vars in mptcp_lib.sh
Date: Tue, 14 Nov 2023 14:35:19 +0800
Message-Id: <cover.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 883e0111-0ac4-474e-3bba-08dbe4dc3e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+zJn9p/5x96p34vKpijxb4Ry0dH9g0Wcnm3yNl3vtnYIao9vhV+FHbfserCDR6Ow71sZU2Pc2S31jxHH28dLRWq0OBr7bIV89zxQsc5aikF3fdQJlPYOs6jnsITShanLvjGF/PtHWA+MnYBo09jlvxI0XB8lNn1mRkaY3NPNjVJXERSseh1LpCqMlRCf4DjB24/ViyIF9oRgWNN2/LlCXFgSwEnU3ZL1UWqtaMOXZnBNvqFVZEWRW3EowCcn6GZlx1ZBRbURNuzaAnGSk3cWC8pzUdxWyTYwD//6TaeZKKsAWI+SdBevVaoQ6yvKLi2mb86GDf4ZSAv3HH37RrlbzbmMw1nz4u/Xadj/xmC3ry5YgX6qPcQPd2T5qdc0AiwArSr8bJ2nzm++ydfHQv5nayMggF5RaysfcbR/cGbP9Rday2OQgVVK4Xcyn9Ko0n+fGyEN8K/GprHCaoBg7ksM5yONJXe0C10UFP82uijxLrWntjW9LMWjbkjjRSAsNUWmm2rKmWMS6EnEsI71smuO2dlVZ6RjKv/xB2zF4YUX3MVLEwEdk28cQrfmKilCgkm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efwZ71TAoM0EzwuxUcxqdphC2s4tF8E91osNgr/lGUk2hsXCq4OmQovIKwky?=
 =?us-ascii?Q?IXgNTSlmBMaUgFMteU/O0PuSQ7Wc7a8MNTV9rX6xLL212cGiG3NLeXhDxoc6?=
 =?us-ascii?Q?lVUPXp/tr0HSkOAtBOcUUBamHyFRn3dzvfx5Idr1g9EXw8UCa2CXRCRPf45w?=
 =?us-ascii?Q?eSr3QhB4xSUScI6hkZmoJhrAquMnJ7LQnuNKmgTDO+o2S52o6uJbp55XQmPF?=
 =?us-ascii?Q?O5TD0lQKlp5aUgily/UXYufiNF14gg9PUiGkEVQgFamBcspkX3qXQPIJOMdX?=
 =?us-ascii?Q?IQ7FHqIM8tLTczfBgmMYRCXzHTlqzcH16RXMfJcRsDDY/pGB3aTxIlYF7j7y?=
 =?us-ascii?Q?JKvsiNQ1o6pIDe2T+Zs4KDZ3Pnf1TYUwljdLR+ZXrvDf8qYgROhlWDxPnWy9?=
 =?us-ascii?Q?YoU5vhtWL6l0WcYvyS6T8w3BBTjYsyRpDhlUbD9A9+E1r7KBxNBy4djOAkbJ?=
 =?us-ascii?Q?ZddjL8Aq4h4xzHEFTckWW1AZzaDWoP80PR6i9pM5GPi7GpXd2rMOTzkhnbzA?=
 =?us-ascii?Q?wRSWiSTREFqKsLukxO+91xvSnGSoWv6rtZnCp/gSgToCt5PjMNcrvu42rALC?=
 =?us-ascii?Q?VPcol9P7MODlutg450G3geuW0lEcAy4o+DictdxISgGRSJKgLv+wjpTY5N8q?=
 =?us-ascii?Q?QqUdovoQNyL1Z/rpVGiADPkbXNy+GAmNfm1C2JMOsI/jApLiWjAyDRygD5UB?=
 =?us-ascii?Q?2ckUZThOVRJbo8VGrWZva8Uut1JLQy6kclw+OC1UDnqm3yT8rlJ4IQjJwYuo?=
 =?us-ascii?Q?I74ewNuKrwKjyaEbFZHnRAU3JEF3kyWUk2RxnhK/pSXJdAyIL2c/gX2jfr/m?=
 =?us-ascii?Q?VaUftZAZ1ttFFbdtY2CVd8NdWR3598VoNp3wLa72jEhrZquEjY1d6NE2zpPD?=
 =?us-ascii?Q?n5eB9CkY69UJ9tpGwNe+AcgrRdg0ihgJfy/wTzSnVbWk4mac/eEXaDbExWG2?=
 =?us-ascii?Q?wMsm+5fhI+TZYEo5y/rXJIYHc4UXntfsIT7XYw1uIREjpw/1X/Maen2fZnty?=
 =?us-ascii?Q?EBFXu/daRmR/5q8Kjm8QVlwZYbrhhFEVHZjTPxAC1ZWo93CG9ePzZCX4p+pD?=
 =?us-ascii?Q?3opTUUkTz/jnwaOOyI6vXy3B/hJvR2Vc45uvZWyA6R+5DQ1a0qPYST64n0gv?=
 =?us-ascii?Q?1uQEAO2/eAgWKGGAcZLANKUjwBCK/LTX39b5oH7WshZtRDVo7R1i7Ciha6p0?=
 =?us-ascii?Q?dcPMH2zcTswR3v1E6tUKfKUDjLn7PCVP9f0UQdxLJZEt8y84ytr+Ms//Y+Bm?=
 =?us-ascii?Q?m9a9PHpnlMz9BxZOo7CT+4LlIyGMBT/c0mGx9eVF+TRu3KhxtVzyIY6cvtIU?=
 =?us-ascii?Q?r9U1vh3RItqeMqktx+g6u2+zuW74MRKERAtle+FhbQAdDOQGpj1TJrGqV9bp?=
 =?us-ascii?Q?GXe6XCqO7btR3PEhz1B+AFFr62aUYIcG1caPDMJ31kZK1kHE4LMR3TRAdQ6h?=
 =?us-ascii?Q?113/mPPdL9m8WUe6iWs281YmKdNVjGqdmNa/j3vO0u7PAJZsRqIt88vAz3m9?=
 =?us-ascii?Q?Nf5sgwrJBeOhUy2gNyhaoTYFaDyZyq4PbB+F8L9gDt0IDrkr2yf0A41bLpIb?=
 =?us-ascii?Q?d512PhcPnB7fxo3mViS+L53E3HKlj79sZUAPfFbXZTDwmuhfM+goxk7wcwSg?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883e0111-0ac4-474e-3bba-08dbe4dc3e77
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:59.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EskCAuM7lfTu9K1evRZiKKcRkK0mbhlbhBgD2EwTSrrfZztRbaiJvCqbwjFELgoouKxlgxiw6ZockVZZwjloog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

This series includes three parts:

Part 1: add more helpers in mptcp_lib.sh (patches 1-11)

  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: capitalize test_name
  selftests: mptcp: userspace: print colored output
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: export ret into mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: unify namespace names
  selftests: mptcp: add mptcp_lib_ns_* helpers

Part 2: print colored output and test counters (patches 12-24)

  selftests: mptcp: diag: print colored output
  selftests: mptcp: connect: print colored output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: sockopt: print colored output
  selftests: mptcp: simult_flows: print colored output
  selftests: mptcp: add PORT instead of TEST_COUNT
  selftests: mptcp: connect: print out test counter
  selftests: mptcp: rename test_cnt to TEST_COUNT
  selftests: mptcp: diag: print out test counter
  selftests: mptcp: simult_flows: print out test counter
  selftests: mptcp: sockopt: print out test counter
  selftests: mptcp: netlink: print out test counter
  selftests: mptcp: userspace: print out test counter

Part 3: add more vars in mptcp_lib.sh (patches 25-32)

  selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
  selftests: mptcp: export cin/cout/sin/sout vars
  selftests: mptcp: change capture/checksum as bool
  selftests: mptcp: export capture/checksum vars
  selftests: mptcp: change timeout_poll to 30 in diag
  selftests: mptcp: export timeout_test to mptcp_lib
  selftests: mptcp: use KSFT_SKIP instead ksft_skip
  selftests: mptcp: netlink: fix positions of newline

v2:
 - add more patches.

Geliang Tang (32):
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: capitalize test_name
  selftests: mptcp: userspace: print colored output
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: export ret into mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: unify namespace names
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: diag: print colored output
  selftests: mptcp: connect: print colored output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: sockopt: print colored output
  selftests: mptcp: simult_flows: print colored output
  selftests: mptcp: add PORT instead of TEST_COUNT
  selftests: mptcp: connect: print out test counter
  selftests: mptcp: rename test_cnt to TEST_COUNT
  selftests: mptcp: diag: print out test counter
  selftests: mptcp: simult_flows: print out test counter
  selftests: mptcp: sockopt: print out test counter
  selftests: mptcp: netlink: print out test counter
  selftests: mptcp: userspace: print out test counter
  selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
  selftests: mptcp: export cin/cout/sin/sout vars
  selftests: mptcp: change capture/checksum as bool
  selftests: mptcp: export capture/checksum vars
  selftests: mptcp: change timeout_poll to 30 in diag
  selftests: mptcp: export timeout_test to mptcp_lib
  selftests: mptcp: use KSFT_SKIP instead ksft_skip
  selftests: mptcp: netlink: fix positions of newline

 tools/testing/selftests/net/mptcp/diag.sh     |  81 ++++----
 .../selftests/net/mptcp/mptcp_connect.sh      |  82 +++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 172 +++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 188 +++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  64 +++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |  95 ++++-----
 .../selftests/net/mptcp/simult_flows.sh       |  41 +---
 .../selftests/net/mptcp/userspace_pm.sh       | 196 +++++-------------
 8 files changed, 438 insertions(+), 481 deletions(-)

-- 
2.35.3

