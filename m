Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9A5684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJu0m3Gsn6nvDVxLekNAgtNujiiclehRGX0P8J+C+yw+iT6JhMx1apRux1JUqoE0+AqYKX+4XEG4DZFPf/SRYWd9QD0gPt+f8YeBGeXhXzEZmcWtf56JsTnCkj2bbJ6lIx6RFEM7n/7bj43I1zK4x+jezwhEqwHvqToItLZ053B7ZFDgBlt7niTn6/eWJTmihODh2oPezDAf8l/ycJoGpAbJyYy3u2Q6sxwHm6pRQ2eHpurWL/J2Y66UVoT2hjpMcmQF+4oHs3IPXnHOYaLNM4kc8Ap+K+0hhoHNoXo/3/9Ro1yyUfRXOHmr0P6Rq0UIvoUXGdY8d89skAE/+2mFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkJ96ewrTrHvMuE+VoDjvAboodrZdI4ZZj2TxwPq1DY=;
 b=HNzLKXCc2amMFsikSd5RXygQZjQBYntCKDeE5ptMSUewc/Lm41bevF2WXIbDT4HKgsJ+1sh1MCQQ9Nss7xuQ4rJierKVAlESgTJSsc8U7gL4tP+DWKXDwWXODUMYC+xOfTbuzYu4Z4mzR+Y7wOfrdTuC+fDOE7RY77a/09h7W6en4gbMfAMlO4a3FY0TKa6ppuCXRZfiRj+vIkxhRlhEiPojT8zdYA0LZAFOCMeud7bc5Ddpqfu41G/oxIP9G4kb5AiXbNS/AdK2SMNtTcCVLryVSsNVaRyN3ZPBCK2Dsf2S7NAs7DwDjXYypNlQESlZ4kAtEF0am9zRStc6uZTKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkJ96ewrTrHvMuE+VoDjvAboodrZdI4ZZj2TxwPq1DY=;
 b=YhIlxjwcqKk5TIxa3OMzNLmukPC2+tCnxYJUiQgz8rkziGesmF2hSoooNGS1EXzVnX1Nk5xG2aDT+aM67SNPwCN89OU0lT8s4P1CThzSRbRRdPes3xZ32RNx8UTAny+nXP0QB1sxZY4K1j3wPORGJiSraZ+aqW4lnBIfrCM+90FnpZxdD4H5bemmIWvIHtiy/iu/VbU9h5CvhLNZLs8FtjGzjwpP3HzrUDwb3yPtlpwMTSuO0ZhFzgVz0uMH6B/2e9z+v/aKn28xQxzxa4kqkD4VVdqTdPz55IpJdMGfiUc0Rr8rK7YqB9JAymeDq3d9NypiYYb4ICofyMZ9RDRy6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:04:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:04:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 00/14] save sched_data at mptcp_sock
Date: Mon,  5 Jun 2023 18:03:55 +0800
Message-Id: <cover.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9a1ccf-c5a6-4079-f8a7-08db65ac39c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y5IxdmcN4qSScZe+/IRsNrOOru3j78JN+o4UOpaNzdXlmyx1Q0ebbJxJxQ12QVpLryLwOTqVcuRpnS7JOKCZzptNUrrXQMsmJN+zAoDf332EA7rWppdtXVVte2SLKcfsaAqH7yWaS9SsoWQd+406ggFhBkacVW7Jp9ZtJJbWyFF8ubZ+Y+ZcD3UspFDglC7d0+pQPrDpZeqgwKLQWc7oM4SSgm1M7BH9aA3n0LTl81jckHLFirh3asw52/g87+YGA10Sh9uuD7TK6kkaSpw3vYodJAvu7X8GgEdkjAXLwTa6wcc8V47Iaiz5aN7jhf152jYaPPqbivBoMP5r9/Pp+8rBMoaw7s7HlkzQs003fNYz/tUyjUwzL/ubEKfsfe5cU/j8TEBL3fMgr2H6wSVK0ustOx/+zKDadm6UNsv+L2taFw6eQQzOCSHsKrQ924CtIE5XaQRMby1cLI0rx6QYTnMzNKKdkxsJdlbzzYT4tw94XQm42qL3IeCBQFzv4gnT3s2inWh7MJCsqt53sCp4fFkch3w5Fcd4IIRmsLwsasY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(107886003)(6512007)(6506007)(26005)(966005)(36756003)(83380400001)(86362001)(38100700002)(186003)(2616005)(41300700001)(44832011)(2906002)(478600001)(66946007)(66476007)(6916009)(4326008)(8936002)(8676002)(316002)(66556008)(5660300002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYundC5I7omkL1iW3opYky3P8WhQCC6hlRhzEl9+Cemwms/HmY2tRjjn38hC?=
 =?us-ascii?Q?vUiIKBiF+hgrduzCzo3v3Z7Ufm6DfVPgYoI73MITgJUxO2cj/BZEMZIYzxtT?=
 =?us-ascii?Q?byLcLxYlhmLQivF0bA8SSFjFMz7TuUdDJbHCfP68VYv75adc5Hsn9tNIusbD?=
 =?us-ascii?Q?HgrKBQIeITCPFNo9VG4sI7OCKuB2m4/Ncdd3oL3oaL4STVGd1SeSr0QVP3mY?=
 =?us-ascii?Q?XXg0ryThalAaY0ETyCY5Suw6gfjFovIVJu5xJLDUqZK4k1cD3kFBqeQRxZip?=
 =?us-ascii?Q?V18t7XwIJ30kGH3bcBLqQBEc/I1tEo5F9hyiVZB0CRYf1wuUqk4X3W+eU9ev?=
 =?us-ascii?Q?cxqoXC8jXctUfdBmF+vfMTBZp/5hYfSJwA0HsaaG7pwBbEKJg2ILw32z7bEv?=
 =?us-ascii?Q?qL0yEUnlicNgshD35J89RNBH81tP9Ao2RoiIuG3WT0X3dN9+KMAy93LOkv1B?=
 =?us-ascii?Q?R6yVUENG3J5/h/gZFj/k9RBYMPMQU2q1ITvxtq1NJ/e7jjkH07cS/LTw92B2?=
 =?us-ascii?Q?muHCacveTw+aSzFjT+QVxfJFvBqSZh2epgHw1RgutqIXK00F0nb5TSa+hcwp?=
 =?us-ascii?Q?warJo2VSG9nY/Jo2lbYkk2LBhsADcYb0mub+KxuY/rZA5x3ZhmG+t0iGj/w/?=
 =?us-ascii?Q?20JrhkPBL/5duMpoGl31oJjXGqwEJ8sjtja/jXdQN+T0IDS9Ht4L+yg1Mpau?=
 =?us-ascii?Q?q/JevBQRdaP7tSMnrbLR+zpWwPHROSpjfHAjxsKCxtFCB04Yy/W8guPrRVfp?=
 =?us-ascii?Q?fnonKl6eQpnX3i0JO94lVN94ZVhomY7S5K3K7GQYEXYbHrvSVD0q5Nr+OvEE?=
 =?us-ascii?Q?TLMgB4R8GOdD+0N0wR5rvaK/EZAfANad/KERiIjmskEevNwEsAeGjsSpRJLb?=
 =?us-ascii?Q?PQj9ZPgo34/5eDZ2aWWwJERDJ2VJwOQHYW1HDOPDuqYKELrUJHA64CcVWpfq?=
 =?us-ascii?Q?hNXpyB+Ivbx8LNMFan3mt+02/K8OO1a40g+repkSstXI6TwXl4O4lUafA7PC?=
 =?us-ascii?Q?51ForOliiH+MmpTZ4btBO0ajDuy5SHmOi+/0pXk2qEJOWzrWjRdPiYwjDk2Q?=
 =?us-ascii?Q?0Q69YMmn3RJo0GK/zoeI+J/JcOyIJMcZzn52Qbs7EZDuyFDOL1MuRxFhD7Oe?=
 =?us-ascii?Q?Htf0wNhUKgEKPkzHd/F+3eM0Ktiq54r2clQ0Q3olsgwlyUDoeRoLe0ecZag6?=
 =?us-ascii?Q?TCJU6zBCfEof0N4UbF26Z9F9bwcEduCsU505DI4AUBKLk0x/ZqwWQxJsrLcr?=
 =?us-ascii?Q?0ep3yYDVWX64Y9d1FCRbUrCwdST2Z102xtg2/jiesQgCjw5TC9w5PYm+PJfB?=
 =?us-ascii?Q?IFrFDv5Rkl3HaDb+9bCyemxIk3ukhsK1NCseJ/aAUZ3eLoz0cEZXcJjEB1D7?=
 =?us-ascii?Q?WIFGfBxFAV+bVD+Vy+kuAvxQvam5dVhqtqxe7Y7WQnuzM7nFPrf/UwoziB/u?=
 =?us-ascii?Q?tRpRSzzfkCZ/kqA0Hqhc+AnnvaaXzq2vuLxnwV77rGhc24u7MoRkGZlJE61p?=
 =?us-ascii?Q?Ybb9NnSFweJDZMiAogKT62/EwjkXzyhBgsPJHUFyPTXIl53jf66XK4gLteyq?=
 =?us-ascii?Q?VZEh/yEEX01jvwQQW0afIx4BH0lkcYyh3J/0qMya?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9a1ccf-c5a6-4079-f8a7-08db65ac39c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:04:18.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzEvkBrr97Lzq9rv7XYxQemZES1IrwhBUdPx3gZPETfth2Ub/HiCKMe2Duz5EPyfGVh4L8p+nBbMu3AuWiedrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

v4:
 - drop "mptcp: add three helpers for bpf_burst", implement the helpers
   in the bpf context directly.

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

Geliang Tang (14):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  mptcp: rename __mptcp_set_timeout for bpf_burst
  mptcp: add two wrappers for bpf_burst
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  52 ++++-
 net/mptcp/protocol.c                          |  43 ++--
 net/mptcp/protocol.h                          |  12 +-
 net/mptcp/sched.c                             |  67 +++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   9 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 ++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 213 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   4 +-
 9 files changed, 391 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

-- 
2.35.3

