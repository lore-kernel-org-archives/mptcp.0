Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354D1DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4vLPs56p+pvSo9yf9GLK2u+bvpnmlcf2RtgW+ZJSVW5GBARogtY6r0C+RBuIhlIC7WcgpJ1Altcu/o8PNGPqiq+3pINT5el3RtjNlCR9ynCW2NGzV618jYU8zXAA2bpHdcM3goaoip9blK5RRWIozT6ol2ghPuZLA5IKQlaAPAZCZC/aOCBz6Hm2Th1VsKKmHf0P7/ItH3ByoLRu+beVq8Cgzd8QUbfUVIeSH7FmGFIqr5pX8W9XAQ07dC/8NITAH+OZI2uo0ayGCzeLjmHbiCXY8OfRadoku6ZaaG5fGFbssDQrIxg01vza12h7zSvvL5GET2ji1cq9nQTtnzIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLT/qyEp6l44aXB8MUcbvEgWhi5XfMZxiQxKssTdH0I=;
 b=IR0JvIi2IIs6CB3yfvKR+J97IUUYFflnyb1TfkN75d2Ev6BGhgwtDS4N8RC9kaQh42XtY6X3ZyDUiJ+hB7B+XlIbeumHtcsPfv8OxgV8zkFefoLBYPVupUGIRPGwM5Zo1kGezBlCxulFuOlM7LlrPveZkHfgxLXODMdfLbcby3vLWOhZ6np+34PG+iV90vWdqZyR1Kmt31y9m1EQEsURY7oaMG8Qv0KKpsfrAGeC2H1ZFUWGxIbwcl6kPTwughsyxVh1abPsWBn6+PL/Iurl4wV8qdzXkeUqpNWl0WhQgOAFKyVJYEB7XwzBUGV3tB7dEGGTsmrGukhI+XIWgt3HxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLT/qyEp6l44aXB8MUcbvEgWhi5XfMZxiQxKssTdH0I=;
 b=nzH2c3rRQ67anpgTGk/5l1GUisf+4IsBeFau2W1MicpIk02BFDXnzzZCV77HmRF1ii+GeiuP7dM8nvshA0gdq/cq4LialdSx3XClVui0I704VcAzJCKXtJM4J9I3gkYDgiHlCybIRUBMSAyte6Y38B7pvMolTILNK1AJ/yP7RuJFG3jNHpIHXmrNL6K5iKkpeLGhkMpZajyZgKpJhoD7XPRc2VeZSkrfG0++yu+sG15zktoNZ9mty1gMT2NtFbRcNVG0a+VrgBXwCZZH9Jrk1dCcatVS/ag1G+hWKoxVysBxOAKIrAEDZbpXfjOTMqpNaMT9VxFQYqTVBW3/KejbRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:15:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:15:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/15] save sched_data at mptcp_sock
Date: Tue, 30 May 2023 21:15:06 +0800
Message-Id: <cover.1685452367.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c717a13-5f4a-4837-f31d-08db610feded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gO39UM78Czct4RCblBhqbrysUXZu5PWyM+L0eE1dIarW6Ex04K4Dq3v8qhzRe1HVxdVAQTgIvAxSgbuR9uhGAzn0uUDUlINN+Awx1OiccMWhKNZqG+Xn8oo9Gx2DzZf0sOhhgSPJLHuKNNZCf5cjir0sOyvoTnYt4PgGyXDL8v11JnHwHOMVQFrRPl90P/lQMVACpfSj39QDO4ygGR7EpbMZ7aGiZmI5vprHstl8n20Cx1IrRomBkLsx/yEgrzWHz/VChu4sBlMS7DMfKcBqX8wO/BGulcDy2kxGljCDghYO3Qbe1CG5FsHrAWhcSptAGfyP0S+tIgcf7Oo/iSA3Tkh7Tx9X1jy76t1JmAz71TAOHf1gJNoqwKBC/WVn0IdgqJcLj6wsc/5kQZz7z7rWlLAmGHII9ZcfIusR6WCEzheJ3tr/lozkNt8z7eFzbEJCrY0DD0BIMr9MTp9O01/TQeie+j3+XY1d7aZLy4mSPTmcP6L8qI2QnT8ywo3dKusOEaqBVavaIwN9222RVnzd8K9w+Qn8Fe0kNB8571TxEpGN1V91A6ddl4If71buya8917mctDsAr+ccS0zf0t+ZjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(966005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3+Q6uaLWkj53slGFLSKw9/ZTCBvvHhA9Kkie3Qbvy9+mMRRnsIexgrGBC1E0?=
 =?us-ascii?Q?wm25A4NxlQO3ktWlFpHVwhHOJsf97wYo8IyUe7GJxUWx1vlZG0BQ08XVcwhQ?=
 =?us-ascii?Q?FQuL0bwWiyvuaSqumasGuTX0sYJD4/h/bjfcoI9dTQn2ev6/gG7u7itoBm8T?=
 =?us-ascii?Q?/jxt/G/Gp0n4QZs+3kQ/I5uBlON/p1xC49eV49dGjEDr240+5Gw3CAy45K2x?=
 =?us-ascii?Q?gFFbuLiJFRgou1ahQyqQ5qhpno7lK3sgHTOuElXWpJ/eMnKvomwTAHyYP3Db?=
 =?us-ascii?Q?3ZiYMt2tvCDN7E0dhzzgjdDGjunLWIhvDLida7Y1O7pTwbXD07DDEEt/vn4o?=
 =?us-ascii?Q?o20QQTxfTm5ZZjPX37r80E3xqFMIJ52sbP6FIXB5hI7/EbqdKXOb951bNBLq?=
 =?us-ascii?Q?Mlp55EevBMTBn+jmQfDfQMRAnecBFZhozWVfV0InjpYgWLK7xDb09zTCQODm?=
 =?us-ascii?Q?7+Z3upp11D5neI8smS6m1soLwpfVJ4B7/clhZUsAkQXypucjGpeTkUuBvDpl?=
 =?us-ascii?Q?vZUnDFo5ElXdlSTxOZelwIpwwzcy3uvGeYki+GjcTsiCQDY4I3YaGvBx3EbV?=
 =?us-ascii?Q?ABU7ao/z5Zdgx/3lCp8ZjiGbHXbuSS6UZ17KFBsbPq54xiG8md1X0jbpN56S?=
 =?us-ascii?Q?UXM12gtB80b7XAB828rfpdVHZAL/dVpPAVpoKkxVVyIYny7tLZ/xEiPtO4vm?=
 =?us-ascii?Q?VxTja+q4tD9Tn5avmVJjEFHRoPd3gQOEOTKve6ig+VHnQWOMkYCO777ju4pZ?=
 =?us-ascii?Q?Rhh90A3vHbVk0U8m1R5YLD4K8JWoUFAxxVHjNoZoTS5G4tzIn3oPULHNyrbb?=
 =?us-ascii?Q?6mndcKIuMGefVzFd7zYaWIeqp84m4gDp86DDQt/jSgRRn8c8sgzTpVx5bKjA?=
 =?us-ascii?Q?B0ORfE3rq6eO8oUfp+gg3MVEIyxOEsPazrU5s/RqKrjWBkwZdeZywOn/PYIU?=
 =?us-ascii?Q?z9yqkv9aL9yVW+ZyOr2tef8n6ROwPVxON1hcxa2gieZWAdVl1NafFU67Txd+?=
 =?us-ascii?Q?MFaFJD6yKWd/UTU3gpYk25f2G/vbQBlF+YMrRPm6fqX9GOn4mGe5q219VQU5?=
 =?us-ascii?Q?rv8JjjFsmAvqdYhf9YtnaP0zCPoJ7L+uQU1yOff3cBpyZ9TOM770dLRLd0Ot?=
 =?us-ascii?Q?F13RkwvYxXx5oZB5DDuCzJEHzIqRu6I2CZM3Eq+uXb0veOx538u0WkJTK8/6?=
 =?us-ascii?Q?yOC5UdqTHODTQKKuouqtGvY+HpFE5CbhkuzckJRNNihZWilugaQJrQxWljdQ?=
 =?us-ascii?Q?0sdSlgxbkyLVrJ3vqeL/r+XyXsUfDoEm1UuGQsI+15sZtaUdNlprKyWlF3Zw?=
 =?us-ascii?Q?cFnDj2s0YOCTdRJibS+l/S85FDsrkFVIBhExwf5TnRDjqDNZuThigzVP6oQ+?=
 =?us-ascii?Q?eBou71eV8aokc7MjmmdeY9urQGZMcheJl/wrRGUxn6OZrC1UWtKv/duWiAKb?=
 =?us-ascii?Q?et8uAkZ8plupJmQdl6JflOO8IdvwqrNr7FZKvmyujpO9Oxm7xZ3vfm1vQ3Rz?=
 =?us-ascii?Q?Ypky54FwJNLEDeh6+pwACujSRREzdeiMa8YR7yfNuH9TaY70EFKEIuCTnzR7?=
 =?us-ascii?Q?qyaQ1eqGL8gqGtWC7Ck2pv0q3+Fz0wfi3auNwDBr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c717a13-5f4a-4837-f31d-08db610feded
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:15:24.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxu1NP4jy5nyNGBFZk0ycATrNa3NlIAdRlRDCKDLkc9QROaTncstoKDTr+pdyaUYIF1p81658Un+VTROlcKBZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

v3:
 - address Florian's comments in v2.
 - split into three more patches.

v2:
 - fix this error reported by CI:
KASAN: slab-use-after-free in __mptcp_close_ssk (net/mptcp/protocol.c:2461)
 - add bpf burst scheduler.

This patchset adds sched_data pointer into mptcp_sock to to save some
data at MPTCP and subflows levels.

With these changes, the old patch "mptcp: register default scheduler" in
[1] now works.

https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342

Geliang Tang (15):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  mptcp: rename __mptcp_set_timeout for bpf_burst
  mptcp: add two wrappers for bpf_burst
  mptcp: add three helpers for bpf_burst
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  42 +++-
 net/mptcp/protocol.c                          |  73 +++++--
 net/mptcp/protocol.h                          |  12 +-
 net/mptcp/sched.c                             |  67 ++++--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   7 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 ++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 195 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   4 +-
 9 files changed, 392 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

-- 
2.35.3

