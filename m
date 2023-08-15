Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1654566F
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 06:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htmrIrb9Pt6/smv71O3b8+zXZD1zBSMPLlfLe0KtWHsbRhjJAZgNfeWgY5qbSlpQTD9WMl/WhcaSTBYFrBzihIVtz96bGYtco6K7/79gA5hzh5GiyjWIbX78W6+XsHov+3c8JEO3TBaALDTo3ENHnwzqd0wxY0VdsFwidbbBY2t3RlplGo5vHjCPIO6fgVDPN+9hTr2C9yN1dT2+AXLuzuITs16GATT4StvhOsEvLcb4Oa0AckXreAVcoo5yrZbF3U6IeoGJZitIjnld2zuP5xLFze33TIwcjhZ6lMX7L2794YB9Tpi+HtiHZbXylcxA0XeFBiZZDFlzWi7dCgdc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHRF9cWq2R5khvk0dx3/6aW4+0m7gZgiywv5FfaeRyo=;
 b=jdhiZIPt6FgEus+jfptIDIdHD3TnbRV9ZG4GbC+crMOTZ4nqe0wXzzGYsAzOaaCEaE5x/lC89/R5A0NZPWQAY9ljSv45ol4dZyJViKRs/yh/+ldW89r2CBkI2f8w5D2MzItKYWFw0HwOqonyjlIxLZBphna7Gj8tDsd/uWE2aC4Y7rOx3GLV+6U2d4/5uHoZaRR4OWcxpkrhB4/i0MqGG3B2bNKNQD/gPnAz7sB2wtMSS8vvEuLwy6dC2RIBQet5NFR9Sces+k/DiCyGx7IXenBAN0deBMJPiJ9TCrfBpJFUWE+B+wjs4Q1wkrMwAjGJT8bI5JFTggN7pyF/DXNDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHRF9cWq2R5khvk0dx3/6aW4+0m7gZgiywv5FfaeRyo=;
 b=kzykQsOz8Nyy0e9ip/iZloSMe1mZHj2keP9dNBkD824mC0/tQ9xcCmo6aOeatUp4DnRTrdDgu+3w7QTqKcZJi2WY4WgMtvaJQAY1s5lmk4nMhRcnmE/JTYv9yvfuDjk8NuAvmbEZoQALDcgIm3DVT8fuF8ULfSMWSAwd61enS9uR7hTF04hueKEMRzhYnJPX9JyzxAy6e/4MQ4IBJ7YUsZzuLWc98/OBiiPjRJOyZs1b66O5Xfl1jYIxfSZgugfqc/pWC/4l23RSvtGTKiq5GZTJxrGQEiiXjKhPnLWJSPuqUBV+zITSO4BFnTwTPu5GIUrm+nY6+F1SVWBVZxO/7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:29:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:29:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/9] Update scheduler refactor commits
Date: Tue, 15 Aug 2023 14:29:20 +0800
Message-Id: <cover.1692080803.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: ac118065-e263-453e-bea1-08db9d58f4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0rFUrrzirQ2NJM9ry+/FPwGRa1OW5g1fgKWWxgTG8H/tmTOlhSNw7ubcQwkpUQgknMOBXILwzkh8MlGgwvCcQ9fKpdhQ/poXke9LxQ4Y1K06sE4XQYRZZM11vhCHi0jMVIVvIWnQzwy3Ek2iGUFLpAcUn0tfOjNHbP8zT1LSxancxuUg1STpUcSEIUnYlL44nrAmY0mypwZRXx/nwHNS7X933inVXEthPcSiZGP2l7bg81+MNIwChfEYVu2evwaZMOE1XUFHhmjRMk1r76vAKhKjxG2FOxinoqeACMzd5NDUrqnLZpAq5/TbqLxhgwo0wrHPiqKOQxvtY0JmTHc349nG/ftBfUW4FcwQwKOP9+TidB8+EglqGFdWsscCUwCyHXPFjv5UHXFocjnvQHV2APLkoujvz2BU5MLnJSAKmRyuX41cfYavD8OAC1nbfqgUFfvMWsvlyvjiHOp0Ba66S1mVWhQiNCP5WXWJCczK4AIx/f/iqdVJES6xxdcBuJUxgarSI2Xnpq+lkftHkUULvl6XSmVLsYQO95h0pluvdEBsZKCDXYTR8Rm3XkPp5Jx6gV3aJNmVhWGrEku5pPS1o3wbT9ne9oVEeKT5zay38WA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(186006)(1800799006)(26005)(107886003)(6512007)(2616005)(83380400001)(6506007)(41300700001)(15650500001)(66476007)(66556008)(66946007)(6916009)(2906002)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6666004)(6486002)(86362001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/St1XyDDwphAAaHwKICkRoHWblAzdEM9J4aaqR8dCXcK3MzNP1yAnRJwB1A?=
 =?us-ascii?Q?hLdhbAr+xSBFRWclD3NheH101y5zrxgEYvW8ZHdBmosEMS5rVe5lnr9hWVzN?=
 =?us-ascii?Q?OrReAS7y/bT4cWltXVOi90qGZhqnqyDcRZGBM5hxYgLczI9Ji7PJRjiz94qb?=
 =?us-ascii?Q?yh6dzWRSREeT2ng5Bxbzj4YGgQ07R1AhpKl3GRuyIVtmJE2HFH82Cc/fO062?=
 =?us-ascii?Q?bzGIpKIoYjMkXAX8iPMn122S5scBmvob0M6aVQ8AG7vlRsOZeH2iASRPJN2a?=
 =?us-ascii?Q?hBPfQNF3NXfIw/f1ctuXlnIUpVATSygSkYYbTUriRaQYiWznHbbxj206shoA?=
 =?us-ascii?Q?OeFkyRT2/rKtYP2/DRYmqjJloqMl1o5R+C6ECGf8hGbcU7Ah6TAncfOOjSNM?=
 =?us-ascii?Q?iSnOrJb1xytHIab3NNrZqpdleSmKF0NJA3qHA2AJ0s6Y9Wa0IxmPfvM9/yLy?=
 =?us-ascii?Q?qvyy4QUTDNQS28J5KgGsNLozVbsvCMi8+jjG0f7ALCkYEPEn5tUSSAohUuk7?=
 =?us-ascii?Q?hTYh+LZvPkYiBmFuIaMiaSYHueigKqlwxrCMXzrajcmSl9Z/ZbqyikQ5SWQS?=
 =?us-ascii?Q?sMUA8hwOl+hFDL3Wya+NQZv57yMCn/zubTuCwsfCB8oeja5PlNGdPkaKC4Gp?=
 =?us-ascii?Q?HvomKFauENeXPCeEvGIDpusI3TENBpRTvoCVpJdnMU8uLuyjw9SpfolDl5YA?=
 =?us-ascii?Q?dwonSZPcxXYUgy2wRDMKJpABQlsSw2kLgngwey6K4CwdKSTUXeuY07rv37sM?=
 =?us-ascii?Q?TANUgVXnmoX9VwIPLyRADSBueAcNSxCrevH95+qNdc+lNX74jb3ZtC9Xp09X?=
 =?us-ascii?Q?m9jzfHJ5VxxcaXmGlmcf9MxSmnumUUojVIRS/ETF2NX7DmT5OrvOJDnYFGL0?=
 =?us-ascii?Q?XEm4BGS6RVIa9CD3tPOHPFfAVLT7PEDLVwg6pMUDkQIzudEg524I0HLMcKxP?=
 =?us-ascii?Q?/F+k3vaQybg3LAh3lLbqkr/G3cJxi+VXYsPxdj8xAiHi/0yl8oDsP7gOY/wf?=
 =?us-ascii?Q?cHLQZUkdaZZ8AkOCGBPnRdW+1bhkvnNYiSnuag8zXtV+u1ZcIIKl/L81/vqB?=
 =?us-ascii?Q?kS5DjC5DSQlMita9bPcg9Cf4mXPTE82QcxPyJTNEFIa64i/75PthHcWmaDsw?=
 =?us-ascii?Q?X4WPB9pW1XPjx3sywwumfxNZDOP8grRMsyE6Sdk0KjeiaC9AoOVn8/OUheVj?=
 =?us-ascii?Q?pScU2waDjsvYVEFfd/vr5JqtxeJBEWrGVi4uxfC/PKBY3dsFvxxgmSKOf5vT?=
 =?us-ascii?Q?94ADXnEZ5neMROLZcDA16Q9kVk7Z61F+T5nnxM3t33exajJ6wjB02Y2ssy+O?=
 =?us-ascii?Q?7Saqb2v7t9IUTsSRQL72VqKjGcO0ZLiGH2jppl8Bl9AZgS/nS1sElPkPJX98?=
 =?us-ascii?Q?YojeK73tO9Z3qQq5vMk2j3obLF7Qe8efadonbB/qoIQOSn+hYhAq8zl+Y8jq?=
 =?us-ascii?Q?HyioXiuh3ueJtIY48J/cJTYJEz5S9P8ixcmIdrIlCLM31GYK/AIRoSoNTlFC?=
 =?us-ascii?Q?m4QtWG2Rh/77sKDQ1nPzDNMJrhBUJ3pvBcodwV1pna0a5ZzrFKRcRfmPmnRJ?=
 =?us-ascii?Q?wHOtOxMVS0uEYHNEp0+fUJqSjwSaxR1hH9S0lrf2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac118065-e263-453e-bea1-08db9d58f4b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:29:19.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGHhrYXGprwQXQbC6gQGB953SnKRq9HCC3/Uf6vsxdOwpzW3iApndoZndZRDSZ2jSPjNBJldg2hj1xWemMid5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

Update scheduler refactor commits:
 - drop data_init interface.
 - call mptcp_sched_default_get_subflow in get_send/retrans.
 - update commit logs.

Geliang Tang (9):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add scheduler wrappers"
  Squash to "mptcp: register default scheduler"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_red scheduler"
  Squash to "selftests/bpf: Add bpf_burst scheduler"

 include/net/mptcp.h                           |  4 +--
 net/mptcp/sched.c                             | 36 ++++---------------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  4 +--
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 11 ++----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 15 +++-----
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 ++----
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  9 ++---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 11 ++----
 8 files changed, 23 insertions(+), 77 deletions(-)

-- 
2.35.3

