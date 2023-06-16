Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008823C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jssY8AQ6H02zjRpqwXQowOio7OXMOa627XHybM5aw8x4PeyPjH3nxIfAoErgZQlUnNWjLy7QOXjEdZ61IRGh7TtrZFdoMmDGiY11Rs0KIFx2GTfm4QdEniEHyKGvhQLLS6jGGTp7ku6v7+ysxMd+GbIksdiLhdX+7BWkIjyAKhZ8KjLkNRnW+BV8PthFLX8pd+ENunfgK5bMv/a+WG1z8QtX3wpg/t14kwFfZ1amznoJuzTzCXZ6kWZPj3oPC6YQ3pCOQRBKKBECIi+Ec0Vg5K9uFf/Vntz4CliaTQJLflJ1+4V4RvDzUXZQv4Ey6LpxLEjLv6gsGyYSBabRb+HbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q53bWut/J+P4Ln8vmGwZ0wd5ZiAhT1L/2Wc2jXf0u/8=;
 b=BLdy3Uk0z49UTY09zTPHnFmlG0xxOYjMRXw/MMK50aSibQfbutfMFCqgCk37kiMVw8b6vGeXQQvB4tburfZ1WenPjyij1UnmL4OMcfrTrXaatDLrrAiAG4iyTN3tj9h44czvO9CQ8vPeaaeXLwm0X23Jn75MCt0z8fbgqeh7E8AG26cN/46PAfxF3jkUja2r0fI0UyQbjH8pHGG9D+sdYWam1BLrKy53QFs3SgArBO0oJya+bKp3SLFp/nS19BIEnYLcsAljLO4pCuu0ALUHROZ7WG+GqEaO2M7nET19MbykSRApihO21JDpcXV4OheRAGmcsn5O18ef2T49rsynPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q53bWut/J+P4Ln8vmGwZ0wd5ZiAhT1L/2Wc2jXf0u/8=;
 b=DMPfFvId9Hutci0JTNKzf66T762xpBDYScWQlquQxhO3QN340kf3QOkuy/vYAXggl4xG1+d/MknZAETE0++fJisfg7ZaYFHcT9SIykAxDywqppKOhGDyGQB6zKSF5RpTrEMg3D2zEWlK3LMJfaRXqHkk0fKdlhesvlI+rucjgLga6+gFJwMJx+tuGhrlTbhncLeKNzrMLOYo2u3xo9pInrzAO1+GXiSaQqJ9l/z5PXKPz6eJSGHu86KLgF6A5P2rIX8KRPolJ2pvpNwtd1wRVpxbnjpWBuD+JnmyOhj24hVnTklUNjOufIPTsA9cQF8XYioemVVyzTYwvqIa7jPajQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:09 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 00/10] update userspace pm mptcp_info fields part 2
Date: Fri, 16 Jun 2023 15:30:52 +0800
Message-Id: <cover.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e9dd07-eb19-4367-aed1-08db6e3ba6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3PpCqylYqZQTB3vImROzUld1cQjraPCNxSie0T4cuqfzwQ/yeafz+QiXZ3Igk3hVvFg/SC0Dl8yFaftJknY9/tHXqU8jC0qSglG9WJ22PqqlpXtMumqs0j2hsoo1lc6XliomAJZ8Q1btKva4bKdPNtKDgzBfH26mCjvkBiUKDr/i9hCuAZdOcmU+YZHhnuWCynFYxy897bOOLTwrKYN/vKa2d1kf7SLnxDOhrUv/teEsPOsm2BrEiZdubGb1uyUmB2K/pz4Szf2nvkHOmh7ZVJuD9Lc2LQbEuafKPB1cPHuZlsLjjspMUn8rowVUExsAgSk3axZtfhFPeugYGUiDZo6z3KDG2Z6oKNrKRpEajHw/icpG5PPrBvlgYarqcvSpxJvijLOmHkm/PqxKT0uDY/bSXgZf4JkFemMGhWNtfbc4Kn0Vw4ejzlCSJLasv/UY7/iEQ9l0qJMHdc0HhIRXpFDYJnAsrxip2GT1BEdJIFCvalPgNRix6MZXricWL2YegytRASHIMwn6i2aH+RavEj05mBWybbLvPzIaymA/QGxlHYhh2yoXGM4T4onQGwe4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(6666004)(4326008)(8936002)(5660300002)(8676002)(6486002)(41300700001)(15650500001)(6512007)(6506007)(26005)(44832011)(107886003)(86362001)(66476007)(66946007)(6916009)(66556008)(316002)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwZ5CBoZwrtttZbOt+t4LQ0kughqe5kDImjJYv9IgcBAF1kwuih3qiJca4Lv?=
 =?us-ascii?Q?HakLimTesZR/0GdFKB9/I/niAaySOe5ReEwAiXfnqsLHq89wCMSwDFRwSVhg?=
 =?us-ascii?Q?Yy5YiQyaE7KH3Xw3R+dUa8m0mnbhuzSBIS6/Jy9ojINkUfyIF+4rhOV6SgYt?=
 =?us-ascii?Q?oVeg5aQ9rU81koteRUX93mtqUornY1hH8ly92aIg0s4KtXhKZi1mhpcJcPEO?=
 =?us-ascii?Q?PS+Ca2pfE6jcXTHyjMBzaZxg5BsymFdvFFVfWKVOHOxJcQa8UQy+mJf6sI3f?=
 =?us-ascii?Q?YfmlfRIlHp3iDJ5inDuFfy+S0+DuKwoPDSyuFLn8iBiDboBt06BQ/Q75g5e7?=
 =?us-ascii?Q?UQX1mDVyKmAZ2zW+CL78UHl16NuaecGGJQj+yY9FrcCBnseejieUhHfjnHfl?=
 =?us-ascii?Q?58wz6Nm9gKTOn1tzjtNucoF+GJ/QPFssIlP8nyu29WYgDF3vqDNKrOKJa7zU?=
 =?us-ascii?Q?1hsTGAS4kmP17rvlSlqr+r8lWdyH13/ID1ptrZUWeGHsJ4H0MVWslJ1VAb1P?=
 =?us-ascii?Q?OmliBeBKRx0GgduAfw/UXl3GC5FAClXDk8uKs+l4l4JdhdSol2boJHU4oRTY?=
 =?us-ascii?Q?3tNJq2WPrmLIljFanC7oGQLpV05qfrJJbEKdAJ6WKA3TGc+dGO1HYV3Qm3Tm?=
 =?us-ascii?Q?Lc0KMFdlFaDz1DOQDfGRjUjpvIIadse6CtbqZQSkt9yfPkhDwbJtDD3dzZqj?=
 =?us-ascii?Q?1Xdwl/yePeSe2aPC9ZbUU3TWyhLfkItlmUBCTPl+P/LnOL80TjvK12HTFc1k?=
 =?us-ascii?Q?iZX3Mw/ouTdMEM2t75x7qv2c6NcN8A8ddyh42U/WIYthAgKWRF/nQ7VIhyqg?=
 =?us-ascii?Q?c9ixikj5UsDYRSIzcrxr81sL6jn9s9SbyyyPELdX8GbUZCmIk1xhAYzdJM9/?=
 =?us-ascii?Q?fwD4fR2wThibEF9axi99qEAqo1SDNTsPiHpqOYdADcf36IpzHcoP71K2CzDT?=
 =?us-ascii?Q?Btc6mvzalmaxYDu7fOl14uuKSTxx0y3HPn+wVoMR6QsBQNaFmKX9JNTfWsFl?=
 =?us-ascii?Q?IvmAPsLPBtG4N+xvQ8zLsXb1cyWA4s3jxmBNM2TJ8rYZ6ldH/opDgovOej3B?=
 =?us-ascii?Q?+G9h45dkJxaS1T1KSQZeDMsv+bpaT6oni/XkZldTfCqnRGV61JMwKsUR+m5V?=
 =?us-ascii?Q?YblNs8jc0g7zIp5HnVDTEWCeAaaMCCc8B9yU7eGEp93nAP/v2NK/CyhEZv7I?=
 =?us-ascii?Q?OHfiWSoR1dNwvH5HbphETr3dKOWcMnvesXIfxSI60o7Oj4cYNnXpvzzgYvQB?=
 =?us-ascii?Q?yMq7Yqc2BPipOHZ/LFi0jEx3sJh5LBCFoHIBnMnjZjpo09GCCDYG3gdHEW4K?=
 =?us-ascii?Q?+p2T13zRuvhyd/hKZP713rYzElBEDSw2BR5015A2+GXcjgYVZQvOZS3VYYDw?=
 =?us-ascii?Q?CODncNg2Sz6DSOvYzrMe1ppXCmcRwz6kkSJNysfqcvq0J4iD8h4DpsOsZ23l?=
 =?us-ascii?Q?4uU2YbOFEjKli/EwNcp5oHkrrzJPyxleJA4p/X/JsHHbSr+8kpaByJ7a5lgX?=
 =?us-ascii?Q?GsJNV1JIy2k5r2Hp5fwXi8aRN5TMNeH+aJJEEUQpBm1R5vZfrOS0uATFM5sq?=
 =?us-ascii?Q?Tpi5KB6lSoDswtsQK2yUhiacCz6mMqWU/9cElmhA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e9dd07-eb19-4367-aed1-08db6e3ba6d5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:08.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/RjfzwYIEXI0ZXCs9yNBYBfvNRqElG5xG8mSecXn7e1s3D5gBnNJgNyZhdXMQNxWG9q7OQ6JbdXWQL2KMtfcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

v20:
 - #1-#8, only update the commit logs with warnings reported by checkpatch.
 - #10 don't update the tests which needs to be slower than before.

v19:
 - rename to userspace_pm_rm_sf_addr_ns1/2, and call wait_rm_addr and
   wait_rm_sf in them.
 - update chk_mptcp_info.
 - set FAILING_LINKS in run_tests
 - update commit logs.

v18:
 - address Matt's comments in v17
 - switch to key/value instead of positional parameters

v17:
 - rebased on export/20230607T094151

v16:
 - address Matt's comments in v15.
 - the last two patches in v15 is deponed on "selftests: mptcp: skip
 tests when features are not supported", split them into a new series.
 - this series have no conflect with "selftests: mptcp: skip tests when
 features are not supported" now.

v15:
 - fix the failures reported by CI in v14.

v14:
 - rebased to "selftests: mptcp: skip tests when features are not supported".
 - patch 1 "selftests: mptcp: skip tests when features are not
   supported, v2, patches 8-37"

v13:
 - fix all the failures the CI is complaining about with the debug kconfig.
 - rename endpoint_manipulation to pm_nl_set_endpoint.

Geliang Tang (10):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflow and addr infos
  selftests: mptcp: set FAILING_LINKS in run_tests
  selftests: mptcp: drop test_linkfail parameter
  selftests: mptcp: drop addr_nr_ns1/2 parameters
  selftests: mptcp: drop sflags parameter
  selftests: mptcp: add pm_nl_set_endpoint helper
  selftests: mptcp: pass fastclose to sflags
  selftests: mptcp: set endpoint out of transfer

 net/mptcp/pm_netlink.c                        |   8 +-
 net/mptcp/pm_userspace.c                      |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 645 +++++++++++-------
 4 files changed, 394 insertions(+), 263 deletions(-)

-- 
2.35.3

