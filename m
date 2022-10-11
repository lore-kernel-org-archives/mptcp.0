Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765972F3D
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuxeQo+k8fAw5rN59BEIpZY3wQTTUMlQHpX7iWPISqhBhIQ2HYRAnqMSnTCgyNxrARtSQ1E1jbCBUzje5j8vJ/s14TvZRh9h9LTGNKR54b6fPTPTVlrLYiK91vbPDzKHEIRDWKyWo3QcoccL0LhsJ3Z7Vugkj2Z03NSn+dr1MFVsUG/oFeAMXud7KHUb1qWrXnQhjnC6047Vk4vA352o9878Pr0e7Yu4dLz0IHNPOGjYNZgtk/kAV76sJfZmxIBzA1JCp7kTzHiZ6yNkXmrmn94KkB0BKVdx9VfME3+8mzYdYTCjrbsoSIBOtOp9y7ptjUszy+kPh+WA1tinPn6Y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJRPiUSwiDUyy7o32I1+pjAS+ihcUfoYi3PCTV5XKA4=;
 b=WUqH5GSZ+g9QVXl/MtxiJ/a3y8Eiz54PijJLPJ3dAMBvUD0ILtCKFukzl9+RCfcaE+QDetQ9p1xZpyai1igAV6hvs3QST0YEZLKqSWA9XTOMMzLqL5uljP2UmgGDcNdRY/e7EWPrgVAOJuYRcy2FPuQG0xq3qhmVM8vNRnuaP7UAT9+6ejvaREEAOVnvfFMCMYpvPFJrE6r/iCWsV8nwzF1h1zll/hvTSmkmutXoYofcsFvljT5CeKrO7Jg1X4T/2yiXueTJ3n3VEL8678S4A/u7rEp5P5kODuYH7yjqEM+4Q50CffFNKWe3whQa3JwJYkpXIjOETFJd1ZqZ//HZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJRPiUSwiDUyy7o32I1+pjAS+ihcUfoYi3PCTV5XKA4=;
 b=av6Of1VqHYYAF+NReASWZBR0A45uAfmDW+UKY7RIadIiMSQ8XanO/kU9ctIubw5QiXTLSqaOgClQRjmhKDLs54cxXzbsaXIF6L+6+7iM95IsnunSMCUq8E2Evu3okUKpn9cRZezVjyMFJIDB0IdMEYl0n95cTOaUhIJy/ADWBPHP6mi927uVpVtJuOpzfOo1VH0b3epW21WMZWAnnY3TPJOchg9nhd5lePnM0XobCabq8jgDdZMrmzE9eTHpiHFkf75wjvd7Q2x2E1W6UuDRVLSYDZBau9UvKK4wXczQwruEvMRNAiOEZazBnAf7azZBMqjDW7wieD/AVaO9UF71hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 12:01:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 00/13] refactor push pending
Date: Tue, 11 Oct 2022 20:01:24 +0800
Message-Id: <20221011120137.5475-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fab4f3-dee5-4181-a83d-08daab804973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rK4lBysfIQs974AO8S+NHb1Jmxwbz4z/Fl9AcRF2KpaSTw4J6fPnhJyUSOjOVxQBOG1Rt3HW61FfEvHUTXRIiN6tfHtzil1tFdg/KOyfCn2IK4Zur4w/M6xINd9+K8o1ma5izAHoxm3RV6TAIXgLA4kPiMnQUMAnEfK+I5XNNIxzYE04WdYOsF8er5LAFqYP4ceKV90asb6QCH+KdhBDHz6Crzzph+sBZwBurJyvKKZQf5Dmt7xsHV7D+d7E5aGaMz4ZwDRSw3kBe1t4xDQ4zzGPnKULZiSdYXey8Pn9pToJr2C+Na5tagEOx6PpAlE13kM0cu9q9e7+aX5m4qEezMKl7c4WuI1ExnhTwE6l70SdnvIGT82pSBzLjR3lPn99KjBJLCO5fspa6eIjPiHsw+kLI4UrzfoIh0x/69ToMY2AtGSboxus4Ee70t7FZhWqTI3eyKioyQXbCk+oY3lnEa+NgCyr2eeMJg+q3F81WT3ManhrO5vtExB+YiCn0mQmLfHBmhPw6W0xTAVcBx5eT1yOnofhevV1NeXi6J8AztFxi2N9XqfuGx6LB3Yu813CdS1qkRCho+nLQfip0scSLkTaNCIvZj/tj0NCjqYgAfKvybzWb0Jmm/gReaHrGYFoEghmCPMe2iCc+653n1b0hQJ9YY86IvcWCkUbgVwhs+5zcj1arrxlp4xh/LbrO961TGp4WQiwey97Q83pz9NFzuxWCwnl1wSXk7cIXqrO0H7jSHfJ3bxJFeVqCk5DEq93
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39850400004)(376002)(346002)(451199015)(5660300002)(41300700001)(8936002)(2906002)(86362001)(44832011)(6666004)(6506007)(107886003)(2616005)(186003)(1076003)(26005)(83380400001)(6512007)(6916009)(66946007)(4326008)(8676002)(66476007)(66556008)(316002)(6486002)(38100700002)(478600001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ws55EVnAEbg7b4pbTDCX8DchvUU8NF/ZhgljcPh87sScE3CrcZClyIRW1oKf?=
 =?us-ascii?Q?RN9I5T0s9TPkHngFo8F0UnmXqFxLh2DQ1bC0Y2cx6OsnhrHa3B7/I0Z62lZY?=
 =?us-ascii?Q?/cd+skC+Bd2sZMnFPnIegLqFgbhY+JpLCnUu7nitVT2l4qVC1fnD+ILCpEFT?=
 =?us-ascii?Q?Brr4jcWAacAj/E4EgX47AK8+YMYhppfpmobSD8vTKWtjfVk1d3iSr8P/jdhw?=
 =?us-ascii?Q?xSih3A5iYw6hpxTBJ6eC4FKbcLKUzpd5/rbOMVJiNtezmMppioN9ix6kbJID?=
 =?us-ascii?Q?9G+auz44SSHpi+d1V/Xvgx49TEHJn078Ua9oMfJSQCZjxS6GtUA0l/NUN0eI?=
 =?us-ascii?Q?vOL06ukxYkDOYBpjVrlheBwBoW6+TcQFP0zD39IyrSen3C0aqYZFje4tIXXe?=
 =?us-ascii?Q?OLHH1DNqV6o7hJiQLrdz+fsy++ROQb+2jBpjxraGeqRb9vfyedepwJCHjGJ/?=
 =?us-ascii?Q?SGNeCtHenheuItBg/nVj0g6M3Lv+QMiUcDwhq0o6Dy5vIzZhKIyeiMDSIFts?=
 =?us-ascii?Q?ESUvGJXYxTyEHk/hjlBFNvElGADr2RBvuufv9qwMi8iOneVe+boC7SRPncRy?=
 =?us-ascii?Q?llhQjTEMmqtjxAnGi+5mRCa8P8LRYwddO9J1EndPCo1q1HlE4U5+KlxPRxdD?=
 =?us-ascii?Q?cYJ74h9FnggeXcrz6Sgvd3KA5YOmSweeT/2j+szANJY5ePfr48WjK0FiEJn3?=
 =?us-ascii?Q?ZuX5we1w9cGEm4z+W1va81yPoKOE3uohQ5qPJUCiKpvRvqHvswq7x9L2NYLi?=
 =?us-ascii?Q?hjuncMFocMvWin1NQIrJd009bcbYDXnnKPp8gw2Ytic0o64axGm6hQ1oFmpq?=
 =?us-ascii?Q?QFhB3ici+JxuAt7v1LCwckfL+brBvfRr2O3b/IQUwRbbC9YXBS3LPBUwoxgn?=
 =?us-ascii?Q?68z4QlJhBA+LSELrNZmzEU2Ldg589YjkVSkxXhR+MJ0pUfqkqMlGPTWF9C+G?=
 =?us-ascii?Q?ZciL+a8vz7K5EazkqZfhRXtKwgnABZo7bEOLquopFV8V1waMI5Q/4pr9lj3+?=
 =?us-ascii?Q?YKX7VZAx4kHuFSvmjaUCrUdULF5VLr6cbNEwOrU5bFSM5bwLawIreu5WiwwZ?=
 =?us-ascii?Q?bgq/loVUDzIlbJLcFu8UU2xCZbNMaIME++uofIn89+Q9faDNZjCMbxY0yIUv?=
 =?us-ascii?Q?RYsU0EM20X6mz9dDQ4583PTM9PQNcgnsHxSkBFmvqao14Af6J0gkvAZUQBzT?=
 =?us-ascii?Q?dLPaALhDeuK/XLg6MxFrM6PUrvJURSq6pJT1WY8KDc/2yVNqPxqTr9r8EIyy?=
 =?us-ascii?Q?6FkTb5OUzUUAc4mOPlnyHmHT2hMkeUhkHgeu7ZfxjqHCCLpvOkjHFZ9MP1p8?=
 =?us-ascii?Q?lFTvs3RN03AfAJSdzD00ARrThL5Qb25LMwp8AznnU1nN2HGR/9/9cyrzrww1?=
 =?us-ascii?Q?dNSDtITVDBXpGdYjCalRqBR9wFknBHGlnFYA5AmH2J5AZG5vCdrV8yHVulf2?=
 =?us-ascii?Q?3oHLsrKeA6z3C8jzKqg5sfcyglPoH0HZAkbcaFBUqkX7D6kKcD56TnVuZQBT?=
 =?us-ascii?Q?VzBOhhLHkEU4KwOnAzFHsVGnBfn7ArVa2R6YRmTfzP4gL48pU5Mhrr7z+gDN?=
 =?us-ascii?Q?AOFxXVRMRD7vCBXBorf7Nt5t5uncZyHviArGX89G4LWgKNlJPcfpsL6/bxz/?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fab4f3-dee5-4181-a83d-08daab804973
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:10.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJRWqkawopNiGG0sSY8DoXjbiZX42fM5VqbF6cfZWLgqyde2KrE1b5lX2GdwjcX0BaXD6vjvr+rX9iOoR6J14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

v6:
- drop all msk->last_snd, add last_snd variable instead in patch 13
- fix lock_sock issue in patch 3
- merge squash-to patches
- This series should be merged between the commit "mptcp: add get_subflow
wrappers" and "bpf: Add bpf_mptcp_sched_ops", except the last squash-to
patch.

v5:
- address Mat's comments in v4.

v4:
- update __mptcp_subflow_push_pending as Mat suggested.
- add more patches from "BPF redundant scheduler" series.

v3:
- add a cleanup patch.
- remove msk->last_snd in mptcp_subflow_get_send().
- add the loop that calls the scheduler again in __mptcp_push_pending().

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (13):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: change 'first' as a parameter
  mptcp: refactor push_pending logic
  mptcp: drop last_snd of struct mptcp_sock
  mptcp: simplify push_pending
  mptcp: multi subflows push_pending
  mptcp: don't delegate sending repeatedly
  mptcp: use msk instead of mptcp_sk
  mptcp: refactor subflow_push_pending logic
  mptcp: simplify subflow_push_pending
  mptcp: multi subflows subflow_push_pending
  mptcp: multi subflows retrans support
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 280 +++++++++---------
 net/mptcp/protocol.h                          |   6 +-
 net/mptcp/sched.c                             |  61 ++--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 -
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   6 +-
 7 files changed, 182 insertions(+), 184 deletions(-)

-- 
2.35.3

