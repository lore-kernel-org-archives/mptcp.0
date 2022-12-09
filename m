Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA5A3F
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 08:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkXuv1F6ZYBlC71EJQVchSrh0+3aN1OLISrgyvT5HXV2I6/iMyk0zBsIha+22f/qUVtgwspzg92QYhOHf5EqXmoqbNrhXjvfKkleZSovryscU9vCNakMEJ5xxfqvERQH1C07KFKLzqBetsMwr4rLiscQ7tCgfCDIX8yOI0Q5AKP8EAtMuQcPhtPwgJ3QcBqukgo+j/W+FOMG/q9oMcnJLTsWMcn8iZR+2XEQCwUpb8F0po6+L7zybIKTQPQEaHbAAQDd9PA02V+J4a9lE6Q7SzicVgSwUHkf+YNniEGyV11nbPR/tO6gFWFj6Z4WETCNnQF7UX1M7hpOyfJgIMsrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GZEE/pc40g2HvV9hb0dOuG+Q2EU+rNbBp1bKDlOpQM=;
 b=Civt+DVGOjNqzCzoIZHpbGAjW/6OOlRcQ8X7ExeTnULjCFzw8TndIfT8fDnlZkyPevzX0OCCjc9pKwmJjM2fDoacmWMakkhUmGvBdzUnOvo13cn+sHPIoYQ9koCj4RfeudFVU5UkLv4eLDrTNUPVFrhouycaF6f69uD4kPv2ZU6+hrCZ8Wqfcv8YFJySxVOLArXNxlXHna9PDPucP/V7djleIXXj5dzTH+OkBP4Sg13KaRjx3mA2HhD0L49997BvFSBnSAnoaKo+40/4uzH46om3PPLmnh6BkgVkhDnh+tNclN/Y6lbh9XAKJ2w5//9ylvJhRM+uLlzA0knaFCMIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GZEE/pc40g2HvV9hb0dOuG+Q2EU+rNbBp1bKDlOpQM=;
 b=icUDowjQ3VgwfihP4YjydutrKUZW/PzrTRa5xp2WCjFB1AYwKUraLbKdZ9U52I23emyUwrT64h68uSM221MPgR4zPnnTKstaUE0aVSD6RrLT4PvpOef0Dzru2Vuoy/LO0tae6dZ4KVdmm4UsORoVBoxUJPZGqDhBptcTfOGStVkmAJDqTCR2N/O/sKxyaYILF7DxumWWSxSMWRIrgT0/Kblix9kBm8xUdie3AsK2sV4TG15S2iNYsdFqY0dHV0AB4Jxdfr/XNZg3i1q/FfCTVACSisnSmPM6lEhMw0jfBlka+HPRBYS/61gJ407ZC9VFo3lWjt0osh1is1M8RmfV+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 08:57:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 08:57:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] two small cleanups
Date: Fri,  9 Dec 2022 16:57:41 +0800
Message-Id: <cover.1670575887.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 73daf35b-1118-4393-542e-08dad9c3723c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q9U0YQwNbgIQbAsOmvbDz+wW9iFCKNh3cOG/H3/XktbLAQK/YJFo6EJdI6t6Kst4S5YII7EyVn3ORAOlljgZNcFb6GmqHHgIR33UQhLQHPOuVCipfwfgYrY7yOepTB2TSErvPk0qXHaHoeX2kNQinapQ6YFSyCELef/eymnq/UCG2NgADEYZwJ0F7L5Itbd85VvnIqqk5zV1WfuNegQW2vtsz22wYyjK4qW88nb3UXD3fzLtKBF/9Iwo7H/t9Z8MfFTWa8Gad1hH2vQbhIJqID0JulZ5YA0/cbm7r8rAXRElsb/tTifRnJLxHb2JDOMfJ1p9/yLzxXK1iSQ67SIyj7P/m+N16cWI+MTjGTFcQEKgi9E6+560NEh+s/q9yGG7zeQdARW2cc2X5kC3mcTb6LC1t8yWjMcsDYQRyqoYNEyesiXswjXRFJIQObtGis7RmarNP8tylAOIkTYX+6XTnzfVos4yVQ6XpIKlWK6wyHLrft3M9BY/3UUvc7wihM4Kz0JM8DqMU2PSoojCT3ZZgOlHHxKw3Q/vaEvlg1QUDm8fOXUXN5xLp3lNy/I2F9bAzXrPEZcm9xj3dasV776iZR1K/crcSP6nXXmX5xCAPGHqYT7cu9WCmPGV06UJFHx38ekvF8atEySaOWi242O8fw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(83380400001)(558084003)(6486002)(44832011)(86362001)(8936002)(5660300002)(41300700001)(4326008)(2906002)(6666004)(186003)(478600001)(6506007)(6512007)(26005)(2616005)(38100700002)(6916009)(107886003)(8676002)(316002)(66556008)(66946007)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ws5spdmRw7LNXCzss788M5X88vtYpJdtBMK0Tas4rWNiWqLe6YKx3j7rANGH?=
 =?us-ascii?Q?VxZHH8dyEZ0pLPqUI9Zwc2VkMXVGXfRGW+QPlW+fny0PShZyooNMuMsdWofE?=
 =?us-ascii?Q?7IjvPZ0doQMiR95i7iICKoP2Fi0qm7z4nhEbxXDf2O7N92KdL8AIDHOQa3hI?=
 =?us-ascii?Q?WSZ9bTtcEYyIv/yZ8nIxOntG+vXNGi94lGN8+/pMjv8lXcsFgwlnJKzDvZHQ?=
 =?us-ascii?Q?tUVfXK0mqbd2f7SW3cfuYIkrhi0ChnYc6kPrt/qeXm0pkpiF9+nEKnZ3hRJJ?=
 =?us-ascii?Q?aFyEOCBuu3Jvs7NWdYwLSaJRZrEqVhj0DpiPaC1RO765/XzUDofnStuX5MQy?=
 =?us-ascii?Q?j6Njl3Q59BgdxoYtaROW2dGWpnpFTpM6m9SRSBbsjTV0ZPtSY20HBs1AqYdL?=
 =?us-ascii?Q?pf1T5DMcOE+UrLCyosAVVdx2ELRsXRadn/TlDKIAfHM2kGs6e3hIeqAZkt7X?=
 =?us-ascii?Q?WShCnGFQ1k1sPXYHk19Zz70epAZd1wvtkaqiqiS0kLQ4kskzQQROGGB2CfeB?=
 =?us-ascii?Q?9MkHGVxwUlBUic9TOkOuw8v6KxOhso+YvxTJaMg/k1SRcuNGAiVpKiHewmVA?=
 =?us-ascii?Q?HBqrPh4OLthPPXPo3hrnKKfpx+Y0rJzaEv9mMqOLyXNvouNl4dVejquUlg9X?=
 =?us-ascii?Q?GgMDm3BoEcFjJKWb+QCGzEzez5m1anBzBBLF0Awo3WEAclH+8Wmwp5t5cyQp?=
 =?us-ascii?Q?QcF0beaur6B8wC/p2OPFYxoOwu31WHOQmuWpY4eFnFDeIckemqtvkXXyS6ZS?=
 =?us-ascii?Q?q1f9X18VSpm7+kueglQBPy8COeeEr6prRGHxsjWtYXv/kabjjb/L2xiXKzOi?=
 =?us-ascii?Q?xTVYAORvunUCZ39LzvOzM4+cFSxLN/zLVLQWnW+/kVlmIvzNwhC7d42u5vzU?=
 =?us-ascii?Q?wjKRWSyg+2n+JGzC5VIw2JMH7NE+MFj8eoNUShh2ZlPCLzrJPycCFceocJ+8?=
 =?us-ascii?Q?qYC5rdALARroHqKRRa/ysfOUQ6wZNLsp3nbagqwaGS0bGvGYPtilGtTl9Ngk?=
 =?us-ascii?Q?VwNY37uNj4lcFTZhBo+tSfwHJ8kUyVud+yNdDInn7oGvDje6VZUYFa9e5A1s?=
 =?us-ascii?Q?z0OLSJABiFBE4baaGU+EzD0lnYHs49aHiNDwwMPSC4upkbdn7s2Qx/a+dga0?=
 =?us-ascii?Q?ZnuzlbiPbwRU8QgyEK1b6k9MdtGml8TqAKMPhawCQeZTtEIjn08OIfqrCMLb?=
 =?us-ascii?Q?qWxuVhQ59VEo5BQorbJqsJ7bSpEeaSDWqUlO96+XrShSM93t/EWLXzE4PwjW?=
 =?us-ascii?Q?YMTkiDrOLLkGiW8fHgUVSzNNg+Nt39/ZVx0tBO1B7SMEXYlKizG4E7NJ4R8H?=
 =?us-ascii?Q?Wnmc141EjEOqiNzqfkbMnaI7x3Fvaw8IbcA7IDsrUrdMl7LCgSAB9Wmm6Akb?=
 =?us-ascii?Q?4XvJlZvqlVj21VWxPImZQ6XsHVgnhuKV0q+YnYVazF+j27U8UgIH1tKpmqtE?=
 =?us-ascii?Q?SiBYCZKaHq0X+R1FMAV+sF4EUNZ+b8bQdataL1odCZFKwsmjxAe0qvPyD2sK?=
 =?us-ascii?Q?5RmrNnld/aDIXhkwcyNco1BeImBVpoy7C6Xm/CbJuCG+0DSe2d4aFjxTogZF?=
 =?us-ascii?Q?cV9NQHBJbo3dHd06sBPdiKTVjp8+2o5fiogt4Yyuue+961tJT4fibdoMenzz?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73daf35b-1118-4393-542e-08dad9c3723c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 08:57:48.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 460q0rfGCLhy1Pui1uZ/YzJRcymu4MYgujnV2rH/gW5/IrSLxDau9Zx5TFnVbX7GZaOsh0eTlSFAiSkls2I0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257

Two small cleanups.

Geliang Tang (2):
  mptcp: use net instead of sock_net
  mptcp: use local variable ssk in write_options

 net/mptcp/options.c    | 3 +--
 net/mptcp/pm_netlink.c | 5 ++---
 net/mptcp/protocol.c   | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.35.3

