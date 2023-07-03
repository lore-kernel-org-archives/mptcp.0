Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D5636E
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=griLZIRKdoOqu3EUak6e5JYNTxxuCDbjbn+LkKbrtXqIlXH1gzbdV+lePGR6NjO8xLiq+UrQbQTDdNRq8bvMbVy8gluQaqGecqw7e9+NqyfaatkVdUEzY41xDqUxxJB6eNY9VjUgDsV73IFUBG2HRZt3yA0nFfbOGLaJxDXFYjJLVy2dbt/km08ddEW3I4JJhWzNP00FjrL8Kuzm311zz58z8bXLZGSHpAV9Mz9fYSwNSo8iBndK7VFj0ZNWXDbEWmaskHLAusdlaMvC1CLudGEB4TT6cMAEiym5NJq1RDIk9vjnlWaC5yKxmvcYafFbBfxGgUPKBX3+CAIGtB5k0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oMujQOTw4nlbz0w/7VqsGAztaUAurENYySPosrxZ+Y=;
 b=M69AJriWe0nWG2Nc32c6ZuvZTTdFun0cLZP9IauUn0nrXYAA4FnAXN4nI4zWCDcN4ph5rcFTq+2LJJ4IXC+uf7zyky06kbcHujHQAUsTgzrBniC0igIQU+La/dQ21zpCklUx3YcG6+2XK8uGgRgdHenymQgQD93QQUzfCkcg7sE08SuHd4DvKic9tTa1qYj9fSp4PMx9NaSaNtXP1KnlYHpriSynwHv+/uD7cVB9okNo4Cl2+s45SjxrylNnWJFx715sFJY2wcXGgyKfkVGcu4MJXU9YlLq0KLYoOgpmDy0x40lksAshflXvnfdfBh1SwHsbHXA3ng/Hjcy0SR+igQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oMujQOTw4nlbz0w/7VqsGAztaUAurENYySPosrxZ+Y=;
 b=2OxpBAXMx5vJhUjdaly5rrveAKoB0q9ruI+cI0mj+35m+ewlqYyOj6I9FGljefER5mtZto2efFOPTwWl1Zvb7g9TnlOZJNxrUrUEokMr5gRJ2U4J1g9kQAcX3NgQ/R8xwR/5NdFY+XA88jxU2I9plOHs92gMa0NY7f77iqSlX9vikjkt5cikCwDk9HbYDP0DFORbWewskVbaso3AhGut9Xw6w80yiw0HLKiB0ZXJXWQNErRfSyaNVeTSDKvjM95V4K9TIYplhG3oun1/J41u3e2juEWF7aotcn+QYPUcaD8Da/Sdt3ItoNegk7EqJT61QjJTn21PerSF3bRdPsF4fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:39:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:39:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/5] BPF 'force to MPTCP'
Date: Mon,  3 Jul 2023 14:39:55 +0800
Message-Id: <cover.1688366249.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0cafbc-fa10-4e46-664f-08db7b9051ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tqGX2IqEv5lN37B/JtZYi6IWULsXfB4iZpkIf8+jQb4JBIsMPwLk0u0cGWlUbPVpKTwhAyEH/TPXsku9XDwnFp9/CEV9VGkLxjWXKASoAC3PaxGxwOrITwV32XM50sVQn5MRzxO7oSWdtbPj36dn+hzs3xXk/shaHnbvSX7iUp7VYkmU6NBe6vsoFlFTxajZdE/6+AYa9wSoxI7jKvvdr/ySLbIMnlTvSyQC8yHLXQS8eqyyEc+8xoj46pF6Vq6hXheb9GYtS7yBExeMpBbweh1bfgyaCAnUOqqB/aCe6+cZJ2y26KJqzDTpO0cYWC5tU3ydLn8nFftf6hL1CnlZmdnwQqD4zs1pu71RqOK8180B1JbGHRGXEmMfl2MbpwuTJ2O7Eyhsh781zniiO+PPntS1lIwCPdCy2YxQldUb5ne+4XYGeW3iWakmb9LnkrL4N5WhcjifUF7sOhCJT29YecS3EghNpu88wFM3viQho511O0xinlmwkY+aCQDZ9KcOoZpIUDCDIp7IBwhMG0z3+vnqc9CsCgZjEPMFgJXaXdM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(4326008)(107886003)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001)(966005)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8ybYq1O/JDTQ5PanEVbJtQ4QSFi1w6sELBMk/2YBQcrSBAYw7LFrX63ogDP?=
 =?us-ascii?Q?b3BJSyWX1bHL8tajQDCcraNpF2bZoYn8JH/EUBJZ1xCG/vXAIfYtaWqeTv44?=
 =?us-ascii?Q?LF5UQUomScVrEhYXkdoKrAIs+I4eDO6l+oZAFO8H53OmQ7SvIjnsehYeRMc+?=
 =?us-ascii?Q?Nm0IdXrgr41rUJOW4tLc5qFeVO9s0m+bOBOF+C6A8/rDgixRPDn5erNOMAF/?=
 =?us-ascii?Q?/RuSTaE9NHKwJupiKOedjCtRjANBABSDNrklVzNo3ioK2TEuOkHAglgj1lmL?=
 =?us-ascii?Q?/xgQQ1UgplJd8ji6ICPoS/xveSuCanpcpssrHc7gMHVOW7+oXYVpnpWJisNg?=
 =?us-ascii?Q?Z8PwicM8HRTeLtq0pElPJt41UmqBdgoAb++oMgNYhIDRuc8u4I/H+bx0/9B5?=
 =?us-ascii?Q?bYXQvt7LQYPizLiY3GQs0INFrP57IyczY9Ccd6m2S4+jH5eMlcPaSxj5wQJ5?=
 =?us-ascii?Q?GyV5dL6Vvv/yjT9tv7c+n/vPkqOOAnzxKv5p5RNX0Zjwum+6ZzlslxXbXd5G?=
 =?us-ascii?Q?xw6XYvnpiwGG/aJhnPmzv1st8+xywkqueqdUea1VmYR+PO32IdqKkIaO8pPz?=
 =?us-ascii?Q?njCN5n+rXcu3BcQUhxIWyeo+z90920P4D9e0a30mPl3WVabD8uwcwViZiyuX?=
 =?us-ascii?Q?s1WcwbzsuqgDJDbFBRr+maFxrPXEHIgXJ2UWWXvfcVIFIZ+/lTej6J5mw3+r?=
 =?us-ascii?Q?n43d5TntdouqggbmKjK24y77pyjYL3Y0R0V8y/W22Wn3RZVBoDqMHZ6J4qm0?=
 =?us-ascii?Q?FgmEyJieVjrikVHsxhSGc/QnD+B0Rw9n26DLpQ3El5LHsnZ4rBwRtLi0X7HU?=
 =?us-ascii?Q?KavCjPDGDZnDSvl6UTMIufk/gZ/QFUeLr3k5vOumuEi6ta/y2VE/d4SQkZVk?=
 =?us-ascii?Q?DAVeQLLpZA6qaxU8dBGlBDpKARs1h/79oZtPm2ploeYWiTeAnnY5gqK5KNd3?=
 =?us-ascii?Q?IHrsaoIM9yDXnlZArBnVeqFrGQUijkfejvxBEE9xKeVkmo4DlWoQrbapNr3t?=
 =?us-ascii?Q?iXBssLA8Rh/7HDRH61jZjaEmpSxPWU3C1wxap8GoYzyPd+yVjmMOkq0PVtdS?=
 =?us-ascii?Q?OlHICYM9PLSpW9fpfZxC24UlPzTCmMaOwKcDGwZlwqrTt9kEhw0uN6IphBNp?=
 =?us-ascii?Q?bI/+aHA/j/MmZv17um6+SN8b39tZqiDJvID3z3YyQqxh7ofiVwkqjTZw30vP?=
 =?us-ascii?Q?fSOfSz8C/aWIrbq9K9dOKZsTNmTf7MfUoVy/OUT3sMcAP8bGo4vmrvOKKN1B?=
 =?us-ascii?Q?wMa2xDyimP8ATW4qZshM3e2ZO2ofItYTwd1RjeC+xoa0hss2dgLffhLdfGXt?=
 =?us-ascii?Q?LnR51xJTKxLW5UXnYwnk+j1u5i2izcQ0hBs/+3voEl2Q1Q/CDfPEOM9Ib2Eg?=
 =?us-ascii?Q?y+Y7AaENgqhRNhNK3+tvJB2Lv4amhIYc5RjoDVcEXOPIe1n2TRWUw9L/v4G6?=
 =?us-ascii?Q?sE09lLngEyncd0wvKLsixC097mNcIpl7sRXPN2hwk9DHbSUDhBf9M5pgO5Ad?=
 =?us-ascii?Q?tv5mDjTkEMNAkOwwcegJlzj6+EEGCgj6tJKQYdymfSjRTbaUTz6k4qgSPEQE?=
 =?us-ascii?Q?zHf5Qs2sjRXyr8FfSHG6MT5aTljHsY/EqDZWNY20?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0cafbc-fa10-4e46-664f-08db7b9051ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:39:58.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9y2LyRDm3GDXJKTOrhoxeamz9fx21AXqsKr86Rasu3ZYBLCZsWwUQlv7Z4w2eS9A5msLqvTpemFKNZqze8phA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

v3:
 - add a wrapper socket_create(), the bpf hooks will added in this
   wrapper.

v2:
 - Address issue #79 "allow 'force to MPTCP' mode: BPF".
 - Define the prog in patch 3 in SEC "cgroup/sock_create" instead of
  "sockops".
 - Update other patches correspondingly.

v1:

This series depends on the two netns patches, should be inserted before
the BPF scheduler series:
  selftests/bpf: use random netns name for mptcp
  selftests/bpf: add two mptcp netns helpers
  bpf: Add bpf_mptcpify helper
  selftests/bpf: Test bpf_mptcpify helper
  selftests/bpf: Add mptcpify selftest
  mptcp: refactor push_pending logic

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

Geliang Tang (5):
  Squash to "selftests/bpf: add two mptcp netns helpers"
  net: socket: add socket_create wrapper
  bpf: Add bpf_mptcpify helper
  selftests/bpf: Test bpf_mptcpify helper
  selftests/bpf: Add mptcpify selftest

 include/linux/net.h                           |   6 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/trace/bpf_trace.c                      |  23 ++++
 net/socket.c                                  |  12 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 127 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcpify.c  |  16 +++
 7 files changed, 177 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

-- 
2.35.3

