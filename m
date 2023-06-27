Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2A623
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltpv65iGRrn8ViqgrgdpCK4pIRSMhNgmEa9El+hSZvNjwAPf8v2Ujmf5hxgNgmBtZsI2tr8/eGjjz4F8SxlDYKMzSXe9UsB7mhz9D4eGbX/IJWNBERVtMaiX9MfsZ9QP/lRCaSI7gJVPXHKDBNhOBkcxt98LBKLNJKLLnuB4xo25pL/zDAmd7DihVZD8BiVfGTipwbHeoElxWgdYLIgZ4uEse1bBCN+FDEJ4p90mPlQO61YPftxvwbBHTEbTJ4RGT6Fk2mvPCxGgFVsaQfJ1603Jz7j15cV1xA7Hw2GEFpnIpj8OB2jB8OhZ3NMKmzLyh4EKBMljScLk4Tb0+uiAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv429cf30059RM1KtBkzaGYQh63ca3hyCLan7OFPEyU=;
 b=MwmJ5I6V2urmNJsSSG+30hKILt3ouO4KLvRmh0IWon+KTqnJMq338Rw7r9cjOpXHfhe3j1tfXSBP6eXMELPOwzswBClWac4i2WGdkRuYnN1Qv8rbokY4+FcwikAW8rUJbBOgOd8XRLnacvUrEXabCdfKI4HFeEP9p1DdKrJO6JVsOVJoWjEU5CbDN1Cy+8kOkg6HdHbbvDXMmN/SbToci7vNjtDO9V/7CAhmbUptPLfXesITi1zntGN0EB3f3ceCOgvOAjb1AoktfRwwPa4768Ped9TTfpYV6xZnL0ICQTNelOsvjoUIyQQ7EDpRg6nfXcfIEld5KwScoMEDjC6mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv429cf30059RM1KtBkzaGYQh63ca3hyCLan7OFPEyU=;
 b=LkA963hgIoHDkMYw+SE2aQBdroP0pgNBsvhSeaMTE9x7Dd093lQMWJQH/UG49EOWioutYbUEOMxygfhlykd9DzgCDOnlGKfXUKmL5FMVnCGlvD49lwj+qJmUzvKGZ7uBXYE+e7wdMKjekmDKvMQj+3+pGMv5mTvZVPu6JogbPqpWtK6AKYspAwXw6Wnt55YOnhVRFtLXLm8ccp8+AIeDXHMrZ4izcvucatZH8uZg5sDFeTE8CiSpsgaN9zqEIlZ5mppg1cFMcSHAmn2FrerOvUC3db5VQxPhCdd9OsORXGwq5MGK4WTZGJCELFffFU+UbaKZaOxd0wWyKJpD/oo+0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:06:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:06:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 00/11] BPF packet scheduler updates part 1
Date: Tue, 27 Jun 2023 09:06:43 +0800
Message-Id: <cover.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd11616-c6f8-4b5b-ab79-08db76aacd60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OOP4BiLysryviLQLQw9Tk5fEzaBTqN5wGWCHwVqOxngZdUbQu7NPxIatNaK9Eamutxzd3ItvjYh9QquLjhUcxyneRlcOH6N68jhdLat2TpMR43x0m5/OOZloB1yr2n7HZHNLTb7AehW4desMu8l2C6H7gKlgjMZ25yzmUP15GrutDX4rvvSj73WxC9syXsFtNvBOs6bBo3ebJSTyQEV4BC8BzV/kY2voLKuWQfFWVdvTg3tgu7p6ROXxnnvMQ0QAylkb97LLh+2lBrYbMFdYjGv5ur+YwuHtTqhmW0vsAYec8IQ2H6plGJrR3IyvmiK1iqg0fKwdAQBTczfMs9DPYu/3fvmKY4u3J7rlCl/0od8pLOZAV3Bv7Mujg+ySTRz2fQ7L0ov3d2bOFO1Cj5G+D7rx7qOpqD40X9tdIEvyzN24M26CwrHX0KUm8KV4chiBIrzSLFaePluHVZ3pFQ2BzXNOApPl4ulQF+KDGaMqsZkOAGfpTsF0yD/O6wzrfio3IvPyURkhADube5OWkTBRGq/4WdFyovQ+arLQ5kjQM7KFnDNYIZfaU+nKwNORaW7wFcettVOBAU6O/fxPeEXkIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(966005)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(15650500001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OAItOmS0Ps3+4TqN5xXvxmLk4oX2h1Ag80C/+gpe+oyetGcY1br3g+/ystQ/?=
 =?us-ascii?Q?7eUi033ykTuAB4xqc6AoKGmXmolxmdOQMYGg5as3i+/JIYwVh7x6hMmwAQJf?=
 =?us-ascii?Q?MbP2JgazsNJHphNFxA2nWYtqZfJ+GrfekKyxL/q7eFEhi6xD1mgkqqRSVMsS?=
 =?us-ascii?Q?o2c2QKUIuv3yWrjELlw//KAvlVbtK3HDH0m4OUbH0jlnjn4tlqArP7+iT0hq?=
 =?us-ascii?Q?VSAOh81fSyv/LC/C2kC8Tmrx59GXjMfQ50Tl+v/UJI9rkePQQPoW0g9dVf8H?=
 =?us-ascii?Q?/whVbJtrNRjmoW1xYChMRZIpgf4HOGEdPMIehA7PKEqzSW2Z/bkIUcTlOElq?=
 =?us-ascii?Q?DwHT+MOUyi2wVif8gm5osvKdvyGnp0X11IFe6OFOqm+iP4LgQlkmrLht08BR?=
 =?us-ascii?Q?57NOLGfr/TWe6V1mWw1vwNqtT3ffNU65tQFw35gmy90+5v9N1Nm+ewuwJ5eP?=
 =?us-ascii?Q?0DpCn3fiF3gY/c2wD0t3E+QEvs9muky6mPIDyvetgAz597PeETTfiHvPJpXB?=
 =?us-ascii?Q?zy322nh3bcTjkJ3g06Uh8FfwBWaUanZrgXlolwsvd9KelLQ25SpcW2GBmhKj?=
 =?us-ascii?Q?xh6WFNaMZKFakyz8cvTUuyVa80ld2NhkNbyjlIQdw4ivOWmaYuoEE84PO17L?=
 =?us-ascii?Q?GKCNvatckwLJIoGno59QXdxWJlaaYQN5XBmARmRxlj2LtlUipQvbfVVrN0II?=
 =?us-ascii?Q?R0oC9llMV9R3/lq3KcBZDvjRRZXhjNpkNc4TesQ3K7kw08sD6BH126wFrBEZ?=
 =?us-ascii?Q?DZwCotjXGBzat4YV/CtJu3U0jNDcVCsKFxPHZbjNVOOfd47P45CRdm5Qkg4f?=
 =?us-ascii?Q?qKgjdACc8pTN1BHX0iPdnvxjdrqv8IF3fgD3vRfpcFV3D+hvfere1q5Bo38Y?=
 =?us-ascii?Q?jLf0PM6K+1MeLnvtvn4BpZkXoaO+tfSpGtJOJmQ/c9YesGKoXowoqE7UD9Fp?=
 =?us-ascii?Q?2wRrg2g5IXUCD+sbz7o4KlPeZSOrBjXLeEP6Urns5f55cE4DEC6KxNi7Sysj?=
 =?us-ascii?Q?nxgYrqAZXXYqrLHX2cAwApm/H/Gx8wsCy66xyWWeGdJoYIeJglfI7qbfkqwg?=
 =?us-ascii?Q?5NPQ3SKdKfYI6gm7vpw34Wflh9HhZrDf54xMDUGNoDZSak6ORuJ1eqHvqssu?=
 =?us-ascii?Q?JmnCwl8hi7Hd2LFHrZShQbkpl5GFBZh4p7caqzjhTFB/0U0LEGbSLoU5fJGs?=
 =?us-ascii?Q?YYrztfmIPLouqaR7GXjwpjtl+2iWqb5E8NRpuaU372NITfzzXl41nMymwdzx?=
 =?us-ascii?Q?Q5CJpnuI8hfIgD6LsfVMsxPDIZxwAhvaQgFCSGAd8dTckt6kmpL4XqrBpnwG?=
 =?us-ascii?Q?f1oHtxuhQvQYus0jJcDvC6+rcerCedTOlDpo+fzDap8Gr/7sLY2VX/wGhido?=
 =?us-ascii?Q?cdxjVZ/4YM3emDaKpavFwSLHsl0GnUS7tErPtE7Y53vEa19HEY/VPAjJOjRL?=
 =?us-ascii?Q?uNU07EVFUps/yn7rdH+BAPtUK0qal1jWaUafKSNk/5gDYtlS56R3oxXkf0Sr?=
 =?us-ascii?Q?vLLjVlOyFCKRvzSizInWkqn3zm0X0OAg3J/x26p/pcJVGrZSQx4pXlPB0Hb0?=
 =?us-ascii?Q?ZYAfjrQAYpYSjBeIaSIOhUXWd7mT54sJq370N5VA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd11616-c6f8-4b5b-ab79-08db76aacd60
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:06:57.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRpD8lt1VAYPWDATgcCWKeCzfOegrt40X+pTtGt/ewI54Pm7UfShKXpN5JRIofUD3UrHyZkl9EBqV9nqgXOlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

v11:
 - use sk_storage instead of mptcp_storage.
 - drop mptcp_storage.

v10:
 - add mptcp_storage map type.
 - update scheduler API.

v9:
 - merge 'Squash to "BPF packet scheduler updates v8"' and 'mptcp:
 make the contexts array of sched_data invisible in BPF'

v8:
 address Paolo's comments in v7:
 - add sched_data into mptcp_sock as new field, not an pointer.
 - drop rename __mptcp_set_timeout, export mptcp_set_timeout into BPF
   context instead.
 - add a comment in bpf_burst to explan why not use
   "ssk = send_info[SSK_MODE_ACTIVE].ssk;" directly.
 - move mptcp_subflow_tcp_sock into bpf_tcp_helpers.h.

v7:
 - drop more last_snd, only set it in bpf_rr.
 - 1-10: save sched_data at mptcp_sock, for issues #342
 - 11-16: add bpf_burst scheduler
 - 17-19: add bpf_stale scheduler, for issues #349

v6:
 - Only update patches 14, 15. Add a helper bpf_mptcp_subflow_ctx, fix
   bug in bpf_burst_get_retrans().

v5:
 - 1-9: save sched_data at mptcp_sock, for issues #342
 - 10-15: add bpf_burst scheduler
 - 16-18: add bpf_stale scheduler, for issues #349

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
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Geliang Tang (11):
  Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched_data_set_contexts helper"
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_red scheduler"

 include/net/mptcp.h                           | 11 +++--
 net/mptcp/bpf.c                               | 17 ++++++-
 net/mptcp/protocol.c                          | 10 +---
 net/mptcp/protocol.h                          |  4 +-
 net/mptcp/sched.c                             | 46 ++++++++++++++++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 20 +++++---
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 21 +++++----
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 12 ++---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 16 +++----
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 44 ++++++++++++++----
 10 files changed, 143 insertions(+), 58 deletions(-)

-- 
2.35.3

