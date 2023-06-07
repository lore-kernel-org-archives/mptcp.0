Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5C653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWwXAQ2Z9RS2sXY6+SX5amVDQ/pU/MJSbutG5cS/8SFfupkU8YEOOl5WaUuCgXuRMSB4nhl+dz8TDIUyROCfsRDpLZV7GKuOYaS8yDCuur/NXEAE3sdqEDZ5prQGtl6shHIVcF/bHt6X0T7gnsZhee8V+Alp8RiYvNF8Ijru4wQQ5tPYtEpMV4qxoQYIHOxZa6wb7/qk3ybQfgGAaYveUijV7FqErKPuNQxQaXqiF+vn0duZBG9HJLi1yhDFBOvkoj+poh4FN/F64EchsqxI4MrMfEAgDTAc+UkkzeML/NW1kxzxTBbYve4zEPQw7+ujtS1h/a7qGoznnusgE3ergQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIkng+AIIrRANLyc4/7JNVvPRXupgH+XlgV5np0pdlY=;
 b=ljOGRZ0t11W2PVIpMzHuSJgkL+nbDg8v0iMkMSvyOHfnI9Dsdk4LdP0W/XqO2MCPH8bS57V7enXqs+p1VOVmJMpWhXuvMmXqqAQffeeSSyhoNL4FW220ON4Wlx6ORdcfItoen8msLNfi/j34PMWsgc9SZcULJ7Mg+6V0VK5oxAWMPQwdmFOVLtlMUtFIPnNLP9kcRQRktDIoSJOimjdHNuDw7XvoaYfx5VLvcryipiSzLdWXbgjQflboOPNJaz+W3gSoL6y8sSm6Iqno6L8RNLKtMlecK/lMeYr+9spaTgKDvY169GskXxWBNOhSfFGRFCUO62jZFYBsomIIDezrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIkng+AIIrRANLyc4/7JNVvPRXupgH+XlgV5np0pdlY=;
 b=rxwlh+r/Bbq3Rsy09hjKruQFoEajve09cazwHAKuNdOV/f5YFf2r9WDT6wPERmShz0CDjKQHIyHJ8QjqpS/XX3YBrA7sTjphSpZNv21YAV5S5K6SM4/YyzbSdRxNfTzPRfqTG5gXMqHdF2iEisGvfY0c/Zp7AFaWh1tdZ4CMIoVAPS2IUF78OTKcNwTBE/KpA02TXT+nV3rryN6XCxFlBo+CIgOeegRUVtk0nq4D6riYOX8Y+fdAJUXIAy4+wptlunWKHAOFPmWWFy0WGHEz+IGrRKqBfG+or8qqO4YWPc+xO9g0Ub73uFJyRlaCClGo89e9NTvqXLVa4hge9Cdlvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:39:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 00/19] BPF packet scheduler updates
Date: Wed,  7 Jun 2023 16:38:15 +0800
Message-Id: <cover.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: dafca18c-e7ec-4441-2afc-08db6732a746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kUF/QiM9WQ1rUuGJrJSnfm2YNywWtWpM1q6CVTpvIuThUZMKpyr/6IK5HFdZ+5ZRtFA0wq8b4q3Ugyh5iSULLaNnATS245KNWlb6kNjFvNWuMnBXkRubfiNLJtYMTKMrHJ59u+D3TePqC5OzwIbRq0b3FIZZEVLEm1z6ea0Jxjlv4lLVXWfIY7tZeO8PuybxUKVrP8zT/Syb3F7swZhF0cjufeMauUvHoMNrLiY9jVW5eTjhWiASWpP4bFkYlulQGdRolmx4IsrZd89vf1HRupiwg7ZmkE1GUSqvWVirXJRRoGx74vIQmGCQB/7Surll2IsoQGgZzflHdIW0hVMBdeklkkxPBpezlnTUMAC6j9pT3HCEys3XiLhxgEaPu7J5PSEwFzEonEMRIgE7Ja9I9cAwWAiqpsm6Ref73971K8jfDrWKP2aXvw6grOSr+q7UUDLME3IdQgO4PTuXbw36ji8p/f27xCOdVZ72JClMsJsyPMH2h7dy4S0kpId8yMpB9J2ax94At34hmTrNycFeoHUDsHQ2KWre4LGreVgTxmwR9BplS43aeZhVTyhtlM0gpnFJuveybyx3PYw7JuqfEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(966005)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(15650500001)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zpRWizimxq3gfboH5raZjr0UnCD2J3Jwi6rDXLyBEvDOJ240Qw2DgzKe2zL6?=
 =?us-ascii?Q?CiBx536WqpAQRhQOUXXcYY+8u4zncYzT6hu+UplFith6HpB9y+8bzcd8Ecc+?=
 =?us-ascii?Q?E6m9p1BsSvn85DnFhrjQ0Hzm3D2F8voh8cW3u5UeLtDdocWqQV7cr2I8fB+E?=
 =?us-ascii?Q?HCdWdoHdHS1WONFmAN4pIZfvODtoHDhTPicoJfg2I6T8GzHF3n8AaKwODU3j?=
 =?us-ascii?Q?PNoqSFIvgIO73cUVxBXvE+ih4NmumTFzFFBTJoxGnQDZfnaWQhX40yjAGiYQ?=
 =?us-ascii?Q?qxIARrv590r8KO+EP/T64FxbAGLLzOUSSUSoVOQaKx4moyopultEcRHN+XZ2?=
 =?us-ascii?Q?4x31ZKQFsn96oI7WUCihBYMMbnZUoPKDfKbM/RFT73XkRv1BoKKgFXNnr6by?=
 =?us-ascii?Q?z9w2kJpYRmdrIZJQci6nWSIDXACb7dwCA7wINTwPHHWsx7FQZ4GBXG0gMiE9?=
 =?us-ascii?Q?UaVBF52cIFYzgazQ2IvniH7mkKngbCkk3H5/EkHQfSkBhsnPb3P8gkVSalEo?=
 =?us-ascii?Q?UZdkgBCiBEGpGsGalOognXjNG4RbeY+yW0T2yRuXaGMJlQyHD2EoQE9fEHVX?=
 =?us-ascii?Q?sByWHXpRBsBR3qFJ0dP62EZkDJ3kisKNZtm+Brhr51DZStr2PAx/3ebRfeDq?=
 =?us-ascii?Q?tGqIJ6lxtpJDBXz1HUq1OlyNPfmCh7MvGiL7qraYO9KD9VHbN5FpNPkBSFGV?=
 =?us-ascii?Q?sEumDgbtVZsef0SPOsjdPF/riEzAZKfK7y3+SpHUlybQNx146B0tudRWXA4f?=
 =?us-ascii?Q?6UGpkHgD1PFTcy6reUwbKg2PgWLeDihAHSfKXxKGc+plzdiM0FFg3veJmWiA?=
 =?us-ascii?Q?FlonFHocN3JdNlmNG6phGmwqmvSmVOGhXEBDIgl3vzu3P9xaBlg2GypkI9Vu?=
 =?us-ascii?Q?uC6NAePRFOwWr53Ucxi38pjOpXG2IAbPaKA6Vv28dpnmHrdaUdp7xVn154JJ?=
 =?us-ascii?Q?QIf62EgCXVMI6fRbBvstAjBUfpIw/vIt3q+suD6EEZhwLfvEM7FFN3heskor?=
 =?us-ascii?Q?JHIiY7eE3TTk/5XKV8jc+oFtkmvht+ZA7bhiKGWlJ60aocaXG6+i0pfVikvX?=
 =?us-ascii?Q?YT8Wz+mD93QR18Ks16LDK1M1gpFNkUoZTVdT8AljlnvbyBBTzwhLDEMUdF9P?=
 =?us-ascii?Q?J1Ns+mEAP10Def9z1a0ohQzJb4iAvjhk1skero59vxS7buk07oeONLt2od6o?=
 =?us-ascii?Q?6G8riJduaUyVLiXB8VHj3f/2N9H+w/mcXxBqtTqKJQd1bP3H1l5OK5Gq3XdH?=
 =?us-ascii?Q?d8bE9p48PvIkA0p1hWz4lEt71IRMJOYRWuzEljmnxbiTf3kxRbPEnhQdOM+Z?=
 =?us-ascii?Q?3+AJlFdnwJwn0ciMRehi56gd8vhpz4LGCEFjhnfiiAaczODb4ixic82D/muT?=
 =?us-ascii?Q?H/phsDwvVvTnpWfYY3TDMdgnRnOgPiLsreibzlJibymwKLq4iuvtWpRXZC8v?=
 =?us-ascii?Q?lJ7vOACo66VXYLx3K4mdlYHuUyEXyEt7qpC71M0J43pthCFkQyaiGzp0X/ot?=
 =?us-ascii?Q?bnkWYOvpyYComjiwbTDiyvGob9hEzPZusdQ8XmcutijExzgG16YimrqSJQ4H?=
 =?us-ascii?Q?ZDcUfYMP6EsjOZ0QDSydYxQd0pchG9K0hKia5lBC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafca18c-e7ec-4441-2afc-08db6732a746
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:05.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLA9lUWdMAFZqRcv/nCO6vYJLRLGdY2/KR1OjKugnLqgxrSFpeCAhlB7LbJ49aEsE4ISgqfWSU1xmHkfS+2jbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

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

Geliang Tang (19):
  Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: rename __mptcp_set_timeout
  mptcp: add two wrappers needed by bpf_burst
  bpf: Add bpf_burst write accesses
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test
  bpf: Add subflow bit flags write accesses
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  58 ++++-
 net/mptcp/protocol.c                          |  38 ++-
 net/mptcp/protocol.h                          |  14 +-
 net/mptcp/sched.c                             |  69 +++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  76 ++++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 216 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   5 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  59 +++++
 10 files changed, 497 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

