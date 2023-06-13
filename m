Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA5361
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GV8w1q8iY67TXlDkz664jS3N2ivhUPCNkj6j/nExmdQ5U3nWoa/gzrlMdMkmxJEhYV08dHXMd4YgpAdk2o/SemA2Jh97WcNvcYB65ZII9lt7vxq4IFOW77YuUI22gdD9kjYoSSIkiyiX5Y3D3pOyZy+Nc90SOxq6gIJnyyLsCHOT5cjvd6y9oi/iwjpLnEeufvE+PZZ6qGZdsfBrID42RxsufLZVW5cDvCGPVgB8m5wFHJG1VOSql2PAtixWmEig76zBUg2a4AdDKi4mly7/WSuJYu4fJZXtDcqfOr3QJdd20zQLUwQhYVdsuxiiYgXV2TgYeMouXuS1pqd+l8sEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SALKmdexxyBycrDpoaPpSv8Ys+l4MvBnhi/v5BKkz2A=;
 b=bE7rHS5le++FfsDpQLa65Ht7uq43/z6+/5oGyOV8HK1yYhfHuH+V9Jxc1TOnSG0kWBzoTeT8dIGyE0KNMMxUMtm0cHDXjrvs+5lR5JeQqkNOnAy3scXHhhM0AgDaS9hJdTm5ECirllkyElgxrIuXHsTV4Q/bAOEjFRtYFuvqu7zIw7fWWuSWB2nnP/Q6lo8qi9tn+2kc/bNyZzLJKdii5+75+dUdxbKT9JK5VaWcNoHHOgjRA5leqmFEJpueVBW0f0OahJbVWwpzufea2+b5YTkOxTyGOrU1F880pUywFAz9hma84n7ej9H4zK1WWtVr/IfJt+XxWKX3MOHu3xEpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SALKmdexxyBycrDpoaPpSv8Ys+l4MvBnhi/v5BKkz2A=;
 b=bM/apMkkD52hIxdqCDXmKmm1b4rjttLprvCHDpEnrjRnP8McQACM16CfhoUCgYTjotqBnEpIZpKYQ32xG1TOYGaiRnCbLR1L69uAdmfmWtWmg5KyCGIxdasYL8F6XhcWqn64+f4VjErKeW/MC6ALsMlSdV9AnG71GWCOiKv1YPYsImJzkCnQcwvtp7einzeaQUraUrh97yfrpgsUOlLREl9AzqtqlWVqrW5QuHZhD33tMXTTg3JWYrMiONkaAwVyII4MjGGStNltPg+PCTci2S7jb+zM9sahDgxnZRtBqtbnkk/ElUpREi0qPKQ42l3cVRZ0ufO4T+H5WTXAlgxDAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:31:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:31:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 0/8] update userspace pm mptcp_info fields part 2
Date: Tue, 13 Jun 2023 13:31:07 +0800
Message-Id: <cover.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: b8593bda-27ac-4895-d3e6-08db6bcf71a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4HACZGcu5f+1+7PBJK49q45/nmD1H9lqmXmGWQHHMPDoCDDKaifL/8YUvwjLm5v54RF4JwsF7b5qYy6QHJ+TPsYq9CuwZDPFCMblOi3Yt5axfjhIEd2MfohB8r+FZiP5UbDq86b/vt5NsUMopIrtf7REIZJK57LnWT9hhatqzbjUyn84S45ayy1ZdrwXuAaRvxXSPBbo9xzbdhD6r8vDkZOE7yHpJITrTlLHE7KMWRa44yEUVKAX96BYiAJG1G3/QI9Bzf873+Xmv5RF0GQE7OgxalR3TfCMyeR2FZimS2qR/1xKLXiRdB/54+kW2O9u/nMFVVU1OUpwdq3xgPfDUSJohnWNAqzeRlNMqPfBUt7fVtzfO7IQ/u9RHOBlf1jFQyTG1YbVMgmYI9pX8oGOfqPlVnuvB15bV9YMr8nZi84EUn+cuBEi8FUTmjTjFME6C2qiFpGwJrl9aWsEj/whrIU7DDp2C1OTHPOEZBYEWD2nLpc8NubdeMPM19PzK/qV0sutWjSW5AFIfNXwdrDaR+rZ2baJHZsxIxkfG4X+Rp+UtGOJe6e2WRbEUltz1jvW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(2906002)(44832011)(86362001)(15650500001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJrihi/C4HUGSMaiBjarZEAeL8Az5O8obiVKyhxSWkCaEme52xgq3uBY/uif?=
 =?us-ascii?Q?ijTult+kpvaq4dJdtnxuG3i3DWjh6REmcCj9kCdhw6PH6oOmMcJ8d1cyp+GV?=
 =?us-ascii?Q?epRfmao71FNwCoQaZ3u2glbHDuhSaqZ6TbAZD1CnA6ErctZQzbgtVsxsuvMW?=
 =?us-ascii?Q?mLfUo/FmgUNEIEVKOv6bKRf0grVus4EycmOv+fgrtrNq4W1sZvDy4jt+dmp4?=
 =?us-ascii?Q?u4eCuwD/AgEReteX8m/7LS0pKo5wEyVp4J4xiZjRJm/9dtfOJvi94mc+xDYi?=
 =?us-ascii?Q?kC6Pvi8XADIcTdiq1FoXUWDcf0zvf1NceCIT4UfgnqXDWn7cDGpU/o9d2eOD?=
 =?us-ascii?Q?duOhO0o6yi9534e71M7XHF2vEKrQ9J93nJYJn9aei5V5wv75HD/T20Xk+uUp?=
 =?us-ascii?Q?jy099t4Z0IzzhklljkabxU4X1yajpst6mCKVX+x6pBd/vLTHWhsD5PiW43ZQ?=
 =?us-ascii?Q?EdghuYprQf6+hisOq1/tp4dVlb7cfeGSqZ6/bdfFDAj3RWy30cKxCDpAT6kQ?=
 =?us-ascii?Q?kreENtZ3f/qNjrxBkWpL6IMZatNtmVjbFEMSv9K9qQ3/L7ctR6sonD+tBkhF?=
 =?us-ascii?Q?sQOdz6p4ylUfl880EvsT6HcTt2wQB3js50CZ6WAFMRQ5M3lsHICFDi0DemBT?=
 =?us-ascii?Q?DwoJYLXwNieJHtlq4tlF8jgHXEzm3KV2+QALiwa7ftQwbiY7pe0g43WnkETT?=
 =?us-ascii?Q?JvKVUnlmge/A4wu55L3rU3xu3NqmOI2sk7hPslXUBOQUzGqOtnCmU7Kv1Ohb?=
 =?us-ascii?Q?GQVIqwcqrsv1hUOMX9GMll9jXD36/Vj66w8V+ze9bE2otnBaz/LuIG/w4eLF?=
 =?us-ascii?Q?Riop1VOcCtNmv51UoXHY/k2r0RZOcHfWHvevRGKOp7Auj5/kMVZRLlOniwTH?=
 =?us-ascii?Q?kx0LO7PsM7nR4wwciaKpRrcloEYWd1FqMe7K0OIPRL5Nuw9gvcAbZDsddUXX?=
 =?us-ascii?Q?Qs1DwXAFRruLt/BL4D4X7UMS3z/UsJVQHmANSS+GUZGLtYP7TQeiR91Wu7+z?=
 =?us-ascii?Q?WXmHe+6x0do7c4qh8udrxMKj65a/3vSChBKuE8KrjQij+qMVds9avP1YgCir?=
 =?us-ascii?Q?2ox5aVt0lCeTqLd9addJe8UyDtys66QRoefp9errY3widXMSTgl9WthRaUS+?=
 =?us-ascii?Q?GnXhSeW9M73eomnFktDwAUUdEHxvNazRvsPW4mWlSfmB33nFYv21QpmO4WNf?=
 =?us-ascii?Q?PGc36GRxCiJ5dnGi1Ye2Js3qf8Fjmhb9UYWlEDnYOmapYhl+tmA3BqvdtDCg?=
 =?us-ascii?Q?6dvfABEcWL7zSxp7PZBvR0x+/Pcl+CWVQbQbm4erQt9PYpkQ+2luEc+xMzsn?=
 =?us-ascii?Q?7MjcPnb5LDi3fhqLFyKrQK4pD2XsBpZcvTUOu5nLfyWnEeQDu74lSPBchngP?=
 =?us-ascii?Q?kX8NHxX7lH41+zgEi21EstPLabq9Bm13vtsxAH15rk4yS6lcXmE+d0SWRioo?=
 =?us-ascii?Q?G/kQ+YAJ3TGnke/p4JAqX0Tt+4ZwssLuFnbkExpUXH5mz+JwF1GKz4UphoMz?=
 =?us-ascii?Q?wba8wAyr8ft1WI/DmJQHPkgu41K8ulke5bkarPx2Wa8w0ntYsgObpCYKAhtC?=
 =?us-ascii?Q?RpAm4A+kUUMQyCwpHoJq0tYXIsn6KftxLqY6F9NB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8593bda-27ac-4895-d3e6-08db6bcf71a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:31:31.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHLdltbPjPNH2+ozb/3WURfczrfgMj7qOqsovQ5vGv5YODHLWa/pafZZbh+VmsPFgPlcBYbBcnG7+3PSrRx+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

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

Geliang Tang (8):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  selftests: mptcp: test userspace pm out of transfer
  selftests: mptcp: check subflow and addr infos
  selftests: mptcp: set FAILING_LINKS in run_tests
  selftests: mptcp: drop test_linkfail parameter
  selftests: mptcp: drop addr_nr_ns1/2 parameters
  selftests: mptcp: drop sflags parameter
  selftests: mptcp: add pm_nl_set_endpoint helper

 net/mptcp/pm_netlink.c                        |   8 +-
 net/mptcp/pm_userspace.c                      |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 635 ++++++++++--------
 4 files changed, 379 insertions(+), 268 deletions(-)

-- 
2.35.3

