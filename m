Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5832A956
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 11:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwaS9OuG3xb4eBm+VD/sWrHSy4uFkIXDrNfxN2yk8eJfkzn3RMT0CY2lBLZaQwUAifgSehaW9b1d08+a/fg5bfeujKsVNPQ9Qfa/1SRLp7Lp/XEZhbVXr0O4JmGbDqrXSQu2EJXYZ9Cmx/6IsgeWXlhu3xkK3YOsP7EBI7cv90WnsdovT2Bt28Pbeaque1BShfXC/LuGYCLHNgdhPi+bvzMFBUzHN7iO8oH1oSu9Veax5z3/4GSISlgcXeg9huoO6BPxApjNCgKWjw2gjnPQmDF39hDpaC48iDl3GC8fszcMpyvSy1ib56qBUwALvuBUKkUgXxla50p31Fbwe2oJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3LemISjMUSjJXCBWMhy/NZYR+wltqF8Pxd9hJiTCGs=;
 b=IiHm1f+l/5JP3hw6lAwD3NP06aE2Sfmhkr14cmPSRm4lvnV/ZbEz5IKS+y1/vZ7fucA+qmH43TrdcHWNe8eeOw52Dnb2l8lFarSLfbVt8fRWJvKVM0fvYJI2p3xsMh9bPSYefe/hS/RVnkIzXstelLk0MXjTvfx+okhVfiXApwd0wXaFgkvQ9vOLCYDBoR7Dr5f94DFZzEOwm8872w3YEPuaWzM5wuiSFukBDrWYkR7HPMkm3w1tK7DYCDPcCBEZU5+M0cF6jymLLdrFTaBr5lkKm+5E5RAJKHjmYNBC+0SXQAAym4S8AyOrddOElj9hhC3zQDm56QUoxJwixXecAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3LemISjMUSjJXCBWMhy/NZYR+wltqF8Pxd9hJiTCGs=;
 b=0AfecNGGKvQPb0YEKAigwwsOG9R72SU/b453MW+NWrhJwK8uJawit87x0uN3deIftGzULn9PKuVMd46qKMxwOJnA8tRR1t92jsNR+DQ+ShCFnPsntTdFFgEhyJVwz3pIBM5BEzHMCzzN+sEu2OBSdMcUVCiovGw+pLKNMtH8lAbZfEDnO+jkDBgdNVaRuerWWWMrjZ5NZHILHD7jAseMDWNJ3+kiqvsJqXpoIJSvq2e5Db7Bu+taxHcHGGVYtvk7GJ8+rwpPdqMWTAPrYV8KR7WCE1Xq6lH84I/7OdetqmMe9BW+O7mZb3N4ktnuEHvA3PU0OKHvPpe6411dyH36Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7901.eurprd04.prod.outlook.com (2603:10a6:102:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 11:04:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 11:04:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 0/2] BPF packet scheduler updates part 4
Date: Wed, 23 Aug 2023 19:04:44 +0800
Message-Id: <cover.1692788531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 102b338a-b8e8-4419-32f0-08dba3c8b498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OvU14fGz/R7o2u11r7B6wf+OzI37zWeBfiupzNVN+0ckRGEHu1VYgUOeMr+4LrvK5FXQufnqwcQG7KshQidP6YfVNwwYjTDABYV70iL2FQwEwApzgqNmkHWJoghoovHK7B+NhdIy53OOzueCprBna3N3vpzYEIHvz1lK9vN9B+hfnuIKB68kfJ7e2SByNFk7dCA+ZMSDzwxXKRnNF/2HdQr+9mxLjLbmqcPjP6NvR1zVTypEHn6YsDq9LpcPdYP38olsP+zP401KW174jz4v2EujiKpxDp5m1I7ihQKHZv8QwPaVH2BJqDwGjm6S4199G9MUkkt8Gdwxwt5dWtnIwJV5UD40EUfum+PHzBkap8ap5VTVNMnbnGc6GlWBmF2aQluoB3rJThdsevdeLTDvZSiI83zge/K7paebssJcAMgMmf/8XMtk+6+otcdhCJ5Q5HiwJ3hiuaJnaPZn6eMp/uMu8nITpfeY0qSxqmntLh7Qzufs0h2XfBMx08k19sa4mMm9FbYpeed2ZiEY7QZqjHmp6sWIIW3R1KGaWd20oAUhlPwBQQo/tUytvrfx4gw59jN0Vp+qaWZbQM0bConiiF43n+qERg4BzTXcqrTx8jMGqBEMGUkYwH7QZFqMEvhBlZA3n5+NPxgrpQIiUtOqVIdcotD0BMGPA0eLAg+D8d0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199024)(186009)(1800799009)(83380400001)(4744005)(2906002)(6916009)(6486002)(316002)(66476007)(66556008)(6506007)(66946007)(6666004)(478600001)(86362001)(36756003)(44832011)(5660300002)(107886003)(26005)(2616005)(38100700002)(41300700001)(6512007)(8676002)(4326008)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8J70STHVOkZ8EwnniTQ/iqpvmadKxRIU1jP1KBkE3VAlFLps19sAgT0xJxKF?=
 =?us-ascii?Q?rfXYrqGeUhgTh90e2AwoGZbFcEKby4AsvHhs1cCBEMdAHsq0nIVcuuXh8InA?=
 =?us-ascii?Q?QGo/xVbI+XLYw0hHNQmm7cSwjjb4omlI/MbIrLpY1GfWLqfMhfieGubnasIh?=
 =?us-ascii?Q?3MXZXfsmKh8wolOmIk1CjUxGfUY9HLiHX8j5DmHB5OVUK1OWgbHCRcVSwNoN?=
 =?us-ascii?Q?wsd/trUBR+Hng64DFxJLzcujcdkovEA6cnj8/QSrk4XH/XYmdr23J+ZLtx7d?=
 =?us-ascii?Q?ymj07vV+kRdtDf2aL8x+mwUVT30Mj0qAi5MjheqnkF4syOkn8vaKM+YZv+Me?=
 =?us-ascii?Q?ZFcx9a4aRtln8O3yNOhnfC0aGuQTqLrBm0F2ELW7x5Z/k5DN3U2s0YctbfGr?=
 =?us-ascii?Q?k3O3OKsqWn2Kp8RWG5a+CDP2Ii+IJOPGoDwB20/ZRAmeO5kt0Sq1RQV/vGny?=
 =?us-ascii?Q?BPeLkIZBGbTyMf4nPRANdF+sjdIuGXQWvCWkG31ZUNr42rgL3TeXZlEG4tRO?=
 =?us-ascii?Q?2uJCnvofzh6jPHRGHhozcHmM2i1q0w6TQHjL5CIi8wem+CB5372mhJd/6IDr?=
 =?us-ascii?Q?B2qNniiymaWCjLXgMVbzEemcgTZ7mDJdsHNZzFmqXJvHoMn8FZ8fqQ4U93tX?=
 =?us-ascii?Q?KMI+jIr8FBJnJEvVf7nfKOuba6Q7UK8pNjsoJ07qxWduJa0Cy+afQzqpVWBa?=
 =?us-ascii?Q?x64o485mAdmILSaHMbRGWGG/D2pQmgbmxR1U4RNCOgs4MPVRZAh0O6hbyjDo?=
 =?us-ascii?Q?B58EYCV4yaaZUfSgRmWxb0s1Fi7VYRhDzEAE3JyVgZH9Fq6b5InElbmMmo/w?=
 =?us-ascii?Q?O4I/km1diiKaCoYoY1Dus4eGXy6rFAeneERC8LCOiSYQJDDQ2e+mLJBvlQA6?=
 =?us-ascii?Q?Jnxk13N39/XuSJM23J4uIwuxgpXphMODQVVtS8tFvA06DTbCIVicQxrkNM6E?=
 =?us-ascii?Q?gf9zSetYIgn6tVJN1RgvqdJBqlRuQcNhVa/qHP7C39FH8O55w4dqJZAA9rxR?=
 =?us-ascii?Q?A6MRY+RARRE9k0AC24BURl2paJ3O/NuSVxy2IQAYLXkYa0EW9Fb02I0vqzoE?=
 =?us-ascii?Q?U9w1tRojtR0kcBteOsXM9AS25VPvDvPJOqNPlwYEMYvDxRxA4ANyMWvy9CQc?=
 =?us-ascii?Q?MhyNu3rFf3b0UvYP1vZ0bT0MBQJk26UFfIfHiFoNFcTvCy+LmpzMXiJW4W+K?=
 =?us-ascii?Q?3MTmyg2k0fUI9lwOUFv4lrh3fClurdcKqE++VORVcIOgLjk2KJNCzvSiY7/q?=
 =?us-ascii?Q?f5HGVt4O/JZeBUhA57YaLaXlzZBmiJi5hDbfGFdinUWZ2N+OXpbLHDVdAu6u?=
 =?us-ascii?Q?qgMUqC7nv9V9X8n6/TFQyDCLFDvNlqIzA3jt/0kHoSP4luPLDJoUWGZGupLq?=
 =?us-ascii?Q?8ucN/ZFBD6q4xWCBYDJynnEhN7K3mMISd1sFZQ5BfYtVfgFPeh/Oh9bE+b/I?=
 =?us-ascii?Q?BprEOpqlZLXu2kVOEGfu9bQX+XH0/ILhJXtUPCtm/9Jx6O11M+BoEVZsBwXF?=
 =?us-ascii?Q?rnPlmgxCGdasSM+w2AkufbeqBpTNkhOwJ2yMSEJEO0cuDFraMfkNdVChzS+u?=
 =?us-ascii?Q?Dhe4bOkKIbiOo9wIv0jnj+UFrtWL+tnk87Z6W/It?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102b338a-b8e8-4419-32f0-08dba3c8b498
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:04:22.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFAtgPt2yL2PDOwZd5IahwxSTHCQgrWHuynYpOFR0ekiQs/1uLhd+D+JM/f1GQw07QlYQA6AvckmonGMf0ZFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

v2:
 - keep sched API unchanged.
 - use bpf_sk_storage_lookup to get snd_burst from BPF context.
 - applied after "add bpf_stale scheduler v3" serise.

v1:

There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
BPF context is not used. msk->snd_burst is still used in kernel space.
To fix this, add two new interfaces in mptcp_sched_ops to get and set
scheduler's paramters from BPF context to kernel space.

Geliang Tang (2):
  mptcp: add set/get params wrappers
  mptcp: add bpf_burst set/get params

 include/net/bpf_sk_storage.h |  7 +++++
 net/core/bpf_sk_storage.c    |  2 +-
 net/mptcp/protocol.c         |  8 ++---
 net/mptcp/protocol.h         |  2 ++
 net/mptcp/sched.c            | 57 ++++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 5 deletions(-)

-- 
2.35.3

