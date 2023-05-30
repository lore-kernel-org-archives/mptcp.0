Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19511DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPfpdXaR3s2Sb+8x5cFL4eeg3yJZ5tCXsuPU/5DfOP5C9Guau19sgYnOlQuVwDoeDK9S8XQDv/ukFcweGxl+9HQfE1+uro+kQfUA6hYcPQ9T+FSL/F8prRAJq+6S9SaSVcuzfL39lVXq7e5D+ruDjIPL3Sf8474OVjHWaG0XTsTXyW0P89vxq0CEsKqcGAo4NOusnsJZNLHV0rnuNL1eNSl7XNv2fbDUVIWsuiKuygmwlSlDgw9EcIw7szrc+rHVOJclz7vPQIcUf2DGeYfrfreQw1fZrVgTKads24MFT+ms+SbI1ilAxgEQqKVZ3AyqHWY3RuKO1uI1wVGHAPmwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLT/qyEp6l44aXB8MUcbvEgWhi5XfMZxiQxKssTdH0I=;
 b=DRtjHNSbNc2+PbHtYoyAszHVwKEjacOn2wLZ6/TuYZL2HE2eRgYRi1dR6HR47GiCXkXsWL9U0rlR/rkZk4lMv889mwmuX1XElMdhJrdiX4anMADOQH6XD068BirbOedn3cu4ZUtwztOoctXnHpJpBB+Djiazm192OwjZ2ePyVrPl3gZGbS+1tL2wx5l5IKNXn0+khTuSSjVXbrT9pqypOpm9e2khRldbCUl5VDvxZo0DuksxYRhrh70lpmhJM5wFc0VTZVA/v6+joVcbbs4CgLdStEEJwm/tGrpndXC7Objo1cqbYlLOyuATOeuUiaFnYvXexw4hgjCcqCltIBnzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLT/qyEp6l44aXB8MUcbvEgWhi5XfMZxiQxKssTdH0I=;
 b=HAAsdoeM1Pcc8laxwd5bF+kWkhaPsnQ6G9TzryWJIlFGMh/XvP+jse912mzOMdTS0kxjONRKUJiR8UsTDd4KS2PWAnxvmv2LqJz+RC2h0WOxEQqMrlEEQoQe6HgWDMMZTplORwNmXpDw5jE98Gs5phHBL42HUlHE2l/o+KmXpjydNm7dj+c77e1YhaLaLjQnB9iTuuuCyB1XPCIRr56Up2bfeFK74YTVnuMwxX6+3xWCdPlRwbkU+f3MXzL/Z/l6XaybdWK6TjbFiCXIj9UbzJpEVJaynS3lWtpZRedbyi7LRq7BkaAQkf2WgEpvKatVTW1OA8qOwiGncORA3qltZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:17:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:17:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/15] save sched_data at mptcp_sock
Date: Tue, 30 May 2023 21:17:20 +0800
Message-Id: <cover.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: ce340f14-4fd6-4c35-ef13-08db61103de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vTMBR9VvMfMAnnwEpeG7aGalRyo0/d76xKdGr+/W7GX54jwEhw/8vSL88O+n5G9IdPMmnn6iKfQrM1e9hZDtlvzo2UP3kB5makU+zKvEjypcwRDz3Wtv6hVsEX/jjPxXje2ijgk/TvNpo5NDWURktu3TwkAYV9tSMUmmc1yACW0fveG1EZq5uPnjYfIbHsYoyUsA9zxj3Jz1IUhAdteYpMIfj1mR50iVeBJbCscsLzf+aoTm1VPebQHko2OMJ9sRUsawZ9kItX2VlZu3WAhYPzXhEMRaccTMrlO00cFoVvfcHeXGodDx5O6eG6xiSVxhfi3ABWYWHAID60BWKjIhJs1qt6/uxAF429hdip1rpwijWPxvO+g3QqCtFc+cWK2UbQgVGK5/kJYg96PLlcd/DsTMpFwQMt4iU8cmlZm1a79ymAKBovb9iVmVT7nkZrq1KcifJJ2ZwC7w4hbLKsUrvzc7uuZOwg3gViLQdS1g9UiRcLa6yZQobVnoS9Bj5ImWUj81tJfxyIcWOkwc53hYJBzZEItY+i7feoT1fskSBbmOy+KHd1ea1R6sJsh8pVePbqkTA6SX/lYGWd8267zZ/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(966005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3MQKo9IzkdRJPxkJxgFCVWMs8BILEQQtsarSPD3hwbOO6LTXn+KEabMjysdZ?=
 =?us-ascii?Q?sXbqXwigf2JAcgczhrr2lNxvXdQQjBXCZqmTBqvJH+216k/3Wf2ZQlofVzUQ?=
 =?us-ascii?Q?K83ifYfmAjr9yCOOzFryTzEMf8Agaqsg7RlWG1i3U+deTfx40dGzfVEx6Aj2?=
 =?us-ascii?Q?a6L3OPERBKhGwNhABAYX8JsKu4xkWkpuRY5GTaBnAuEQGN0kWoe4fQNzDBW5?=
 =?us-ascii?Q?0mTGZwMoVW8CI20KAmdByYSMOyV4NPCXOeIEHCpn4IYgaQFA0QJ++JErr396?=
 =?us-ascii?Q?EWI50dES1U79Zd9pPtvCT0p6218w8wUyzXwXO/K0rtpIni7Bi8j4FpqATVbs?=
 =?us-ascii?Q?x42v8YXYysCvvj46/xe13BlIWbrIkGNylEuT1nJrN9U/QRKGrDG1KWtWgDWJ?=
 =?us-ascii?Q?qzc9y9bxNeX9pp8Bhab+3sRcPrXsARgy6BCpLDIRHiRiL1XGsYRfwRy8fRc5?=
 =?us-ascii?Q?1ufBftO+pJMo+g9w5JM3Wn6YaVstacil6V9xa275LLsz2thecDmduZbQ8vus?=
 =?us-ascii?Q?Pnv01mNcWT8gALXxR/uy4Px4jQxSmTOFsJca57dYlTAcdeW3bSaAxdb8Suh7?=
 =?us-ascii?Q?0VYN4pSfFYPyajW9GnNxx5fSH9zEW3AXvBV0OlhAooThzcOo+t7CS8p2pJt1?=
 =?us-ascii?Q?AlMypUBaf6+mBdalJmkh91ynD2y/of7CsqIkF6Jer2SfygLVjgNlviYKbtyA?=
 =?us-ascii?Q?GDIT+F7Bq2oia6tEbC3fHUzVxTof7/Q0wfVMbC3p2JMxLwZC4pPWtYzLbnM4?=
 =?us-ascii?Q?54C+L5ScibEDGaSWDIYajku7O+EuRgFBCpjWfpaqgI+ERCW/h+CgOHFcWA4k?=
 =?us-ascii?Q?rnugBOBkJR0aiMPh3+bFV7v0EdUxi2hBMuZ5OP1XfcH1AU/4rcre4M2P583f?=
 =?us-ascii?Q?8miPdvyAejzI1JLYFI3r6zbQZ6nq1EQBZsggRcgtSpQqmogtGKdJ4cN79a4G?=
 =?us-ascii?Q?KErkgVzrv1QCKJj5mQEO/H6NT1udZgQXbjlnI8MINg+5ouUujQcpyoIuVp4m?=
 =?us-ascii?Q?xms0D+efFJVsVVTWY5/DLOrpukxhDOrmL7hGItcRz2PyEyBpHaAFTZwmnbCt?=
 =?us-ascii?Q?nuSa7ewC9rOzM9d9vMSp9uzckOzvYZBKZ/SNNjvxuKqmxm+N2njIXTcGUcTH?=
 =?us-ascii?Q?mbNQz6imyxujZQfhMxZZk8wEPRtMUesRKWys3rMLZ64mnuQJJG8iLiTjmqOv?=
 =?us-ascii?Q?S9fjI1D582GFdrBlPxvItMqvYzkoMdz6TgiOMDH3NGZUMvx3ExikGVWzY0y2?=
 =?us-ascii?Q?88OBEd7mXpG+/8YEss6S/jZ4J66MUpijkA22xcSSbFUk5BDZboS0kXqeQROQ?=
 =?us-ascii?Q?dCfh9XXe90B6VQoOfQrrZsHofGPbtAeTkCjDc05/dsaEdRJ0XDlIMj3XApKA?=
 =?us-ascii?Q?qBJ0qiB7We5riJo539LkY3ivmwyhrAzCkB31y9ykkEZg37W9tsIKBMQe1039?=
 =?us-ascii?Q?Cdha5rE/S2onwD+orieOguBvZmEl/dbhJ0L6rJGMUZm/a8P468fXEidBBGJo?=
 =?us-ascii?Q?gdVRc3Ax/xoQND6dnc224Es7ZvS8sKiXu3s4y1lVs4PGjiuWelAo4O6HywPe?=
 =?us-ascii?Q?wNnSLqNQ7XS/3F8sNXYo6J4Rfok0bTdBw3+V4Ka3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce340f14-4fd6-4c35-ef13-08db61103de2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:17:39.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLwAMXzyBPKH9IJahuuJMpn/LBzAUo0rRBBu7EU5sCnuY5qg+AsAfTUNV8F2U0R3iNx84apHCkpCxBUsANMpzA==
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

