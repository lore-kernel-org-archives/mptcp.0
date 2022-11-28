Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B9364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcODk8fSmWbJNk0r/5CdRCkIYBJ8JKdPzYYPJEAiT1wriqjjGyOS/MDCY1gpcQRy3c9UDytC0ZpRy3cSkn0rR6DA5hdMMDunb8ug/U1+iAM5FW8R2FQU9t66ilwVsNY8baIIZ+PaG/gjHSbK3hAeQtfMtYlt/zDyXVWcvt198p/KvmKh/+jmzFIYSa6IPGRpg9qAmPFm9YCv7btq7oPonq0/Uo3i8ayrQLl///jUCskbXN42VwwVrS+Yupy4TzKWjFn8NH+L+h2S/9Dhd+2JHsRjUg18DGDU+wK2OQxEyxwngC6aXBzdNHnfxXVDplgDCSMhQKrFMkUhsGMe5xXflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73YtohMz4ABoiX2sharJKiV89tryT91ERYBOOqocCvs=;
 b=VMSyvA+v8SUPZVoyZFL0CY2fqk/4BgByy+LtWxMMWf/aUrJrpcFjpXe0nMgSAyZtW+7NrZz43Y1EY+HtWVmD0CE2ACl3KMdVuFlwxHdH+4CnfD3vzVq2cEU3uCAqR+OJ6jM5fR9ZV0j0IZyp1F3eqE8Al+KfkULQZu8dkF8iqHZTbLgbZtog7alCIYPHejf0Ru72WWMFysyEsrS5NftzZXjnbNBSC9N8rF6+5g8rXHxMjLQqGPL1GlOaYNNr3Vyhz2oiMdLoMotpKIM8ca5StTrl9EgzxloJSWGelWX1Zm92Fbgimw8aaJF12F0P6ZoXEAv4bPveSpYhyB5KhzzmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73YtohMz4ABoiX2sharJKiV89tryT91ERYBOOqocCvs=;
 b=xWaZIUHdfyELb8uTvxK0vRWqJgJ8lY/G4+3b3KesxGg45M87vw7m4mmhqfCLuxve8LZSGuYEwxX43pkhnBGGIPpPYczsAN3I+MiH0pxjV5lsvCXMATF51u0EjbBeHbMiTnY7yItnSKLpRmlLJxC2hIkhtg3+NbK1GuqY2d3r6WR0SLk7PpsBuxBque1nf6Eba8A4RaPH+YFXPEmab/lJjjpWtFx9U4WmfI27v7d1zFoigA/j+uDo9VZNY77cyySxwiR2xkKi/HUMqzFbrufYZ/1kiTGNJegM5YXRVML9zaSv7rOYFRpe1e2OAEoJ5mf4OIiz+8TCIysivPH9cr/Nuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:23:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:23:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 0/7] BPF redundant scheduler
Date: Mon, 28 Nov 2022 11:23:56 +0800
Message-Id: <cover.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c62e8e-1a35-476e-629f-08dad0efed14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ms54if40j6Zs6GUR/lBepAgJd771ztjUciDY5mOOOlBWLcm65GqEuNeDYsB34+IiOUC6DFRAfWnS3ewi2pnMEDCcOAaaIFHpDCW93Tocd+sSu74PI0Mb4pWsJ44TCQfYipYZl5Ntmo8PCms3prnIXiT0hrGir55WXw11QEuui3ojbzs0h6Rr3GjsBa53on1VutQfhzzWN8MBovUQu4k7mMUxWobcC0+ylX+WgA3fUY5LEToW7l3hKFVcphtddYMnq8HPB9Af0Cii9GBgdvqiwdPQPZUjyyIOmbQ0xfXrWJ6tM1fVFbevwTTQOnrtZCy0bb5zEsXLSp3x0EpAeS/iYBqfxdAHIlqFbrKF6fSCJ0hMmEuZ8Hr4z7fWuahA+T8xzYdW5w3AvRmLaLMWKH7qXYb/XqW082fHXkNTLXZKV4k37weeuSRc+QmiOTgl2QaGcR2xrg2Ndl8dPTE1nUwaK5u70sBw6KfTtFLMl6As6B5WpOAGbSlyGiS9RxeX8uine1f/DgpOoDVomw0zl0l3W6q1YWKjs8dwh3uGJ5RKG6hyb4Z/ZCoGtNwxR2I2DNQ/U+oHrZ0aL7rkFDiDMANF3rnc8oyxp1bETphPRd+DLH3zTcQUbngxD9P+AvTHcrOrJVi65+dy3vAEJ2hHoJ9iEF8IbAhmFD/rGy2ZC3HAAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(66899015)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLKjgAkpDaFqFgh1vcCivPIYfwTi5lDS1TUYsUSUwKGGsVNj1HeAbnKPqWNb?=
 =?us-ascii?Q?K+N2obhG/qILsLV2jE8zt39zH9bQ0Yc1cgMF6lj5rrlPRIaIkLz1bT3MeOiI?=
 =?us-ascii?Q?gfBCQAGyW87Cm931H9k4FkN708zYSEklXO7cPrjkj97C5lMLZBIvQq/Rdwoe?=
 =?us-ascii?Q?sTZhMasj2CMozFBNsOGncQVlUeDL5Wcys3YAJ/iH2chw2pInnOjAXyvYlyoY?=
 =?us-ascii?Q?sjoYE8bIvzbUItgr2gTRVYu1h3N4isOWx4TVm/AKa2ed+oJKaqthbuTscaTR?=
 =?us-ascii?Q?Pb/S5criEroIHLvYhsGdIWrzeCtbNzgQvjK2mgFexBorJkrgWl/GrAjCUDeH?=
 =?us-ascii?Q?tOr/noHLbEWI2PWehMY0cIiWnVFH61ezZ/KSqVEpN9ix70O1o9e9TrMvZV/X?=
 =?us-ascii?Q?JpokNghHAWrnOCrIWbPg9JmKruD0c/F53RAoY3QApt6drQozO8RPE7JD2oCH?=
 =?us-ascii?Q?7BnGdhjFuHyc1l1pOEwmnm+zuH6fpP84FIr3OEbysFAdutf+WnRjRF17ffxi?=
 =?us-ascii?Q?eScdVuUeVdeAprKuBdM7z4wZiYuiV3TbYa32nR+CFcGeqdub1r80AbLSwYfn?=
 =?us-ascii?Q?4dDN1cxTAm14i/xFVyjpNf8AmXr414Wkylo+YhHTxDzjOyLAbcwL4WO13wZ+?=
 =?us-ascii?Q?D27fQA1U9xZwPFO90B9sT9pN6iwnqU5f5wAPyTWlME/uc7x0nV2pnyJB4XIq?=
 =?us-ascii?Q?PD/vcVnyfnDONwpiXn3zs98oAHOMFrUN0YdW3sVY81XlsEpIW/t4iVzQawDZ?=
 =?us-ascii?Q?l/uRZ7ZrdFWWjLYuOfSMJzdcDjRPfSLaaUh6wiQMsxCrPdqCVebXZl7Vy0sy?=
 =?us-ascii?Q?7WfzX4j06yuY65lF6tMNhUHbUzLBHiUaRC28hNOKQGDaAEp51mvNUwk+MUi+?=
 =?us-ascii?Q?3KT/9lhWzBRRvRJdBmd8Pb2KXAQEyCqHbGoBA40asRVBQMjJJxtkVikRYDft?=
 =?us-ascii?Q?t4Mr11b18y27TvViBUOQMxvc9fX/eRuqUmf3Ux6yzoQmBp75RCNJIVkH/ekr?=
 =?us-ascii?Q?d4roroaWtb798vdqC3Yx4e9bRXBVL3iBT9DClFKl9HrlNbVT0cuiliwapBYF?=
 =?us-ascii?Q?c6I/b3fGxzREqvBDR0u5g+1AWWDX4igONbq/tJfvqoF2VS0BZ0eo9DaKSEP6?=
 =?us-ascii?Q?TzAA2rYsoYHQhScG1eagyPHeLdohBaxI+rBTQsT6gVlvaQjZBSCsfw4Mx3kh?=
 =?us-ascii?Q?9p4BgUovDVwOGKkplSIjwkpcOTHjVJ4Jv+QHbRu9HoVT6F6f+h2SapAsAA34?=
 =?us-ascii?Q?NdsG2rJP11x5OUw5NfXSH0Xn02oP7trrWDUFTa7lEHLbLSL/qpWr+Hq9Q5vo?=
 =?us-ascii?Q?JmE89uSJwVOOGNmpYnBE7oXjoLOcn9WY9cDZTUV92uMNaS5G0+JrG65zhsJQ?=
 =?us-ascii?Q?qi1zyzSDZ9VIYEpsCjnpy+A7zfVwSMrT0yww6nbNl+y1fDNpSfzk0nFv1YKP?=
 =?us-ascii?Q?4upIsFTyLUlOMHHVFANb+vHPgMBF/DLoGv1VyPpqzqDGX28+gQsiWr8KlzUL?=
 =?us-ascii?Q?NNQB0FTu5+wrd85F3XgcmC3Fs7rBlFFPgwD+JT+xLDGkWZ/YiAjlT4Se7Igj?=
 =?us-ascii?Q?ed3xO5c+CxHwIkje3N52jeUjxJxRCLSymljF5PHXgLlwxZqzvFPY5s2fzu3R?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c62e8e-1a35-476e-629f-08dad0efed14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:23:32.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40mG23NVl92PIa2rSLERY5XjFQFlXqAi/Ja0inZvonTZW2mpYGGfIbwQx0PCZb+uDdix1b0oeQH53IR4CjpK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

v21:
- address Mat's comments in v20.
- redundant sends on retransmit code path.

v20:
- rebased on "Squash to "mptcp: refactor push_pending logic" v19"

v19:
- patch 1, use 'continue' instead of 'goto again'.

v18:
 - some cleanups
 - update commit logs.

v17:
 - address to Mat's comments in v16
 - rebase to export/20221108T055508.

v16:
- keep last_snd and snd_burst in struct mptcp_sock.
- drop "mptcp: register default scheduler".
- drop "mptcp: add scheduler wrappers", move it into "mptcp: use
get_send wrapper" and "mptcp: use get_retrans wrapper".
- depends on 'v2, Revert "mptcp: add get_subflow wrappers" - fix
divide error in mptcp_subflow_get_send'

v15:
 1: "refactor push pending" v10
 2-11: "register default scheduler" v3
  - move last_snd and snd_burst into struct mptcp_sched_ops
 12-19: "BPF redundant scheduler" v15
  - split "use get_send wrapper" into two patches
 - rebase to export/20221021T061837.

v14:
- add "mptcp: refactor push_pending logic" v10 as patch 1
- drop update_first_pending in patch 4
- drop update_already_sent in patch 5

v13:
- deponds on "refactor push pending" v9.
- Simply 'goto out' after invoking mptcp_subflow_delegate in patch 1.
- All selftests (mptcp_connect.sh, mptcp_join.sh and simult_flows.sh) passed.

v12:
 - fix WARN_ON_ONCE(reuse_skb) and WARN_ON_ONCE(!msk->recovery) errors
   in kernel logs.

v11:
 - address to Mat's comments in v10.
 - rebase to export/20220908T063452

v10:
 - send multiple dfrags in __mptcp_push_pending().

v9:
 - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
   suggested.

v8:
 - update __mptcp_push_pending(), send the same data on each subflow.
 - update __mptcp_retrans, track the max sent data.
 = add a new patch.

v7:
 - drop redundant flag in v6
 - drop __mptcp_subflows_push_pending in v6
 - update redundant subflows support in __mptcp_push_pending
 - update redundant subflows support in __mptcp_retrans

v6:
 - Add redundant flag for struct mptcp_sched_ops.
 - add a dedicated function __mptcp_subflows_push_pending() to deal with
   redundat subflows push pending.

v5:
 - address to Paolo's comment, keep the optimization to
mptcp_subflow_get_send() for the non eBPF case.
 - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
 - depends on "cleanups for bpf sched selftests".

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (7):
  mptcp: add scheduler wrappers
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: retrans for redundant sends
  mptcp: add mptcp_update_dfrags
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 237 ++++++++++++------
 net/mptcp/protocol.h                          |  17 +-
 net/mptcp/sched.c                             |  69 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
 5 files changed, 320 insertions(+), 82 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

