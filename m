Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1D7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVeuGmA4KyVT8yHU1uoMVxtqm8xkHbbNc+E7fOmL3fV31cmR/IpjkfP4BAAH8MEqXUCnQFDZG8ghp8NVrO5WjEMZCdBOz7/LCtdjgakO4vTIEf92mI5BkM9O0Zjj3jUs+wCha4F8AVsgWxR2ebaEuH/Jw2jdQaehx1WjAw15K1MgOy4dmX7hPRJbjfvOKQHuBaHmNJn7Ol0hkGiLONvCeEupXkWeWlXzuOjf+8+7WWurBbZ3asXOK0xvrzjYjhb4lgexx2FS7xDIGPNHG+LGYfSvFVUNDJ+hE8i9180OYb+8uCzL1gDCbbw6rdN6PSz/0PX8J5HT+VP7EBpLrP+JVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8fex+wsVEkvqNO+pzxTTgzkP9nODSKX/feBbmGMpRg=;
 b=WMSgr2UQT5TfWM1uxuQfS54LsKO9TPGvjrAAbiz3yxgvbAw7rq84i9V090n94ex+qiOgXglE8gSf+K5k8rzkd3XdHK8hrK6y1rbTiqdl9gf/TyjhO2qaKqoMlZNYook77XbFJssYAk80tb5hIqIWibz8B2/KmtKwQNGgBEcXxcWocSIc18y6NSqQq3GCmXfjd7K3nKclY532sTeBDy2QTe0SHFrvJTSlvfDRoz7qvizcMzsyJBP/ZRBhqKY6e7pkWYVFjQsdZocxPgwInNP1dHvd3m4a07YT3zTyCQc+hr8iSoCJwa2hdKYMlXV1ZtLWI0VFGDVaG+6BVusYW7DyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8fex+wsVEkvqNO+pzxTTgzkP9nODSKX/feBbmGMpRg=;
 b=zYA5/1pnRBAS3Eulbv2PSlpXzBAmgpAU3vr1phq5Uz0NDQkqOf4nJ/0uvziBJMs0Bu9iISFoM9R+l3iTV2h1fRQCTRKyQcvefSHvgvL1fsV8tgWpZhZnpugWNyEPV25kKyQxaM71ZlcUTjGvR6DURiiFtwPIr2GZa07xuzgpb0+jb0+G09O/C44pb08T8OJZN9tfAK1Jwk9q/Ln8/Hs0G5uoQ6Y9o5OQ79w8QT+AGarDpJ7uJnXqQFSMFL7Mj5kpS3wkf8wvASqscjPD8+47vzfN0gj/mgOKQnf0g9+Bovo8Nyghz6MZ1E+7DfAd3PcEmkOS8sT21j3bh2/8i3hCiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:00:40 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:00:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 00/19] BPF redundant scheduler
Date: Fri, 21 Oct 2022 18:59:52 +0800
Message-Id: <cover.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:404:14::26) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM8PR04MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: cf25daef-6456-4cd3-85ec-08dab3537da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FT6D2oiYX7KC2Hkp56i6M+lLU1Kme93K3ziUSgzOf/+pmj7UxW8OzKnYzXoL+QvWygOhD8EpTIHUqB/tW5LzftZk+qf75CrQeN60Kn+apatd+0EJ8d0wPnx42kIPzhhqFy+tpyG3Qctsmh7xkuCbeHlr2osRSqe4fULUnCRQM6pnqNdjJx+iuFN1VO8BoZVEDfdRSokwzxX6BRoX0U4bApEpZ67P83kMuNkTtfxB5JBgYFMOFAy6ZePwa8zkLuxDhETcWNGZ9J80oZjr6CxqiBd06HzX1pgp8U3QqPgqadTCbnVvDPSPLXQfmnJSroLIR0sfjhDH7QOlBy/jS5/GFMnjZ3AzF/aMkG9sb3896jc3VRyc6PmGTTYMaMCV1b8DMaT6QH/e5oZ3ZIRWw1l9VfS0b3+P8EApVb26sMqLCO1nCgsvOFCrgfwkCWgW05GI9skADJSiKkkJfpFf4+Mg7g6CYr3iAFsqgIIQu/9oxX7KmtTAOxzzMI3N69SAoxEK6ZXf0TSrIbWUfsJ+VN9MknDwMNMRHpiHf/a1K4ODKgE1bp3ua94ePH94Ep1wi6+hUFOt2wv3tMRDc4IIHNAgq4vH2cQXnf0Z2oWN8lrlS+Kn6oyeh9sxAGTAoDnyqMvEC+ew2j1l2eL1G84oSCuzWs8Npkje812DrBDFVRmEeH7WjOkILpMzZ8EfhP8ha3o2eoGOioLtx/66Byz4nmkWI+OnFfIds4O1VI7AWJVbha21fXu4HNoGVCo9Q5WLciEJsQur6GZOpBTwjNvKSXluCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(2906002)(186003)(2616005)(6486002)(66899015)(26005)(478600001)(8676002)(66476007)(66556008)(66946007)(4326008)(6666004)(44832011)(83380400001)(6916009)(38100700002)(8936002)(107886003)(86362001)(36756003)(6506007)(6512007)(41300700001)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCsdEauZsTbzema69G7pFBRDxCYNdLxnrmV6BgmY9cC8BTWXB5ZcqJ/NwYNV?=
 =?us-ascii?Q?ufmeVQS6Z5fBz/f4AH5Suw9B2+d8grZKVErctZ+tQlcZcGC7ib3jXvnFPqsz?=
 =?us-ascii?Q?glmbYyND/hJJ5o+O2l/fb77wqbhqBH/DJVbhX7/Zi/kdidPbaehE6WKrLxj/?=
 =?us-ascii?Q?jjsnw6fK1lOjKeUEaL0ZhNmYsBQOtNnFRiJZ/zWrKyRvRPJLcSQIpnklHklR?=
 =?us-ascii?Q?dy7IqgSgLvOg7Wl3wPEe2/J0gHmIT+K0oeVNGqwT/gxLo2P0E0OylYOkmNA9?=
 =?us-ascii?Q?4WTTpntQEnL4BGvdZKRPRb2P84ihZl72dPina2C9Xmcj0rPj8uGWadGH44jl?=
 =?us-ascii?Q?SZK1UJTd3zLECi7mz+FXvIX3PoZE3CjROPwb73KWkDCzQYJDNaVYs/gludf6?=
 =?us-ascii?Q?SF2RoySuwD5BBgymeyZV1ErB/zv48PIBqEgMouqk18Mc0T/Ll8B3eeCKjtZt?=
 =?us-ascii?Q?WM+ceekyNMctHN3Xl61Wb1xjdajIL2J/3EcgeFNQxPxIfmcp8ooqVbA5KuGu?=
 =?us-ascii?Q?uc7APPNYRM3n+u3V/+RHi/azAuIH+7DHvWbvZQPfKLNiVELEOo09IMtl2Nb7?=
 =?us-ascii?Q?b7V4VVaOD8cihNG+He/myrssA+znHiExTr0LnD2bJWubKOy6gZXdOS7tNML8?=
 =?us-ascii?Q?seVReiYblIj4pEe1sZEHOg5AGw5F9smWplp10O5sBV2A0UeAtsG8mUOMhxZD?=
 =?us-ascii?Q?DbMbzcACb9sAck8J461FTrcMP2JU3x38UFMKCw7TDR0yGuz1bMs1vDOP+7xc?=
 =?us-ascii?Q?La45cUj7B0KCwX9HLJ4C5N23YT66x982tJlvmegEgjCSaMBg7ujgHBgCRbiZ?=
 =?us-ascii?Q?JKbP1zJ7+6P53F5P+YN3ktD5Xwe82rEXJyjU/1pWo8gtzd6xHay6MnEFS0Vy?=
 =?us-ascii?Q?Z756obYSEhZLT75MK5gKnulj4BL4/Swd8tXP/u5CxyApkRIKOEXwbs09PMJj?=
 =?us-ascii?Q?/Aw71kcosqdhqOJUx2msXn2gVY2iwABDvEiea+HRYdxnnfAbhfKeGibSHgX4?=
 =?us-ascii?Q?PYkHziK62iIBladbS+NutzRcTBu/ECNgOyMc+t127OpksiFAhT9F54p+LyxG?=
 =?us-ascii?Q?kEbmbPIgGbIyPh+NN+KZOj5yy/txV06BE6q05h91Zg7/hCgic9ZAHN1zNI2d?=
 =?us-ascii?Q?IGUGsipxW1Cx+yaogukNIbh6Cb8J0Iu1IdmSt4WEk5/A9zboJXILe87mAwj6?=
 =?us-ascii?Q?DOsussmrh8JxPemMNeTM3hlLhGCUk6P/EOdUzGQ0Hts/kuZpbUtGu1QKOg+k?=
 =?us-ascii?Q?9+LRMEsB4a8f8ajqiyn6wZczYjYW9DfeGCZTyAY78N1iPbbqTJubvPnyJ0mA?=
 =?us-ascii?Q?ty/Z9rjbfY6heE/BTIQhxj6UlL4aIcEadNsXT70lgnp2uCBRC9h99rIEHAZB?=
 =?us-ascii?Q?82FcCrA9DftxcFIsjYIX561PQc/eAKTvDkgP8zLEf0iSCnaBZ5YHlFlMRmUj?=
 =?us-ascii?Q?cwHpYOVPU7ZE52K2sfay3xXaUXrarQVItxj3kW2YHoMr7uACgz7ZfNn9/hQm?=
 =?us-ascii?Q?IbCrGId0nlZLkWmOlAeHFKhPkizMEb1Lp0kOWui2pph8M3wiC5Us1WlIHeCM?=
 =?us-ascii?Q?fN75nRZ9uZNTw4agrmX/vX74dekp7wW3tzMxymjOLbDljFFdT7rrKTGBJhAR?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf25daef-6456-4cd3-85ec-08dab3537da5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:00:40.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsP8AerPu7WNAenoUIcM2n8TdWv5+IQ4bqUlny3L+gpj7s5w5tKE8hdK/lOlD81p/lsvlsE8NyaOYXVuY4OSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281

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

Geliang Tang (19):
  mptcp: refactor push_pending logic
  Squash to "mptcp: add struct mptcp_sched_ops"
  mptcp: move last_snd into mptcp_sched_ops
  mptcp: move snd_burst into mptcp_sched_ops
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: add sched_data_set_contexts helper
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: add scheduler wrappers
  mptcp: use get_send wrapper in mptcp_push_pending
  mptcp: use get_send in mptcp_subflow_push_pending
  mptcp: use get_retrans wrapper in mptcp_retrans
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 include/net/mptcp.h                           |  11 +-
 net/mptcp/bpf.c                               |   1 +
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 345 ++++++++++++------
 net/mptcp/protocol.h                          |  20 +-
 net/mptcp/sched.c                             |  62 ++--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  15 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  14 +-
 13 files changed, 399 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

