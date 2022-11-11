Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C786ADF
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqds1IfoxFnpMaodeAhIY2YO2+eMvCu5c0A+WVhu2hYarwMi11+V3F/E5gP9X8AUyN60ODLLqPbxVfGYXz2hEtkQvVHJL2Yk1pI3qvXATsFSuwn85zBJxcgCPSNk8h8hBA9N47W0cANhETzoANJvtwnxW/vcgM90p5FR6fq2Xj/ORmkqRoRkB5yPkWnkSacW/op+iqSlj7T/gzo/jFebL5tBkkiYiUU139g2kZm1j6OtygrFWJyEeS7bkoCZeAtv8VoG9LlRhFFwGTkaj/xRAGKjn/MLLsz7DddHM55U11AJlZ57FzJaEXYw3ZZY5Cz/0xgTe4styy4jBO1WzQa1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Vb4/pQlZROyD8EDCZaKoCcAlZB5Z2ICo7N4V9pz+f0=;
 b=gZ6ZArqXh7CbLZJr5SFGS04wpPvO8xr79699R5MzBJRGcWVuQZk/d1Z/N5z7gBWgG2aIaWJ7IfEvTHCaQQ0MlMTfXC1sJXN9GU32eSftVJzn9IhGb0oR0/AZQ7BbUGQ2/TIK71eAMN/Xzarz3m/RwbSDyS1xPX3Gzqqd4cTzRClALyDSRtppUtzTeDlag8C6UqAY5Afun2Int6YaTrl9Kduf1XWoiUzxNTIi2dfGQgJ6n82qOsG4ZvzlnpJBOajn7mwlvTigy4GgVzPhA3u5vRahVrrSsq/t0Koj0IiBNfJ8170J3l06F1TkHb766hwpNhRLREe7No40C+sxF7B36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vb4/pQlZROyD8EDCZaKoCcAlZB5Z2ICo7N4V9pz+f0=;
 b=hxaiNP/ils0bqM5YaAEUMC0UDJrmEm2Ah31GytE3yFWIrC1TDoq5s80NvcrTPVT1qpCVDmmacZKxIrLmn0s8yjroROUUVdFqmAzdNOmHHT98eUnR32R2o4noemiZT5sijsN8RP5GF6fqgxm9AWB5S3tLlualnrdBZn5poBjz7UfajODeSAJfg91sX4DKoZXlicUb4id1kGI8GO6eEbidQWe2DxIjVQ42QGNMdJIFHueJr2j7YD18jTco/42hchdlaAhEgdtEbik2w4tHUHO4B2jaAtyJDMgYld2tU+YgWm3LqAA5EC1y+xWahh4jhurcnFrQc/N1n/4nzhgsIAshTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:32:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:32:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 0/6] BPF redundant scheduler, part 2
Date: Fri, 11 Nov 2022 21:32:43 +0800
Message-Id: <cover.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab97395-8e20-4416-327f-08dac3e934cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HV3EDcrNMe8zzasi6u5ilKmNhqeuKSnxzpXKi3A8c5mugX4DoytE6a4Q1gfDgnQ2/NY1EnzR8opehBv2lcvhHF+hegi0E0L8K3no+nskkPD6XIBS8UjJOGCYkEfsQjup/UekYHCBZgP/mTswgBjAw7gT81fk/bO7uIUuEmoP00j7sz7fxUFEFIFS5dtRs0MnlYJG9VIFTWNPSGSdp3+9dE4mK27K59Dmha+Imlf1YZ9sdum4akW/Adts+szpY17jwETK5yvDhBqRHsdhwE5Q/wsaorTcDT+UaqSvEUxmALkxDIhqC8/EQeCSocKsY635kqplI4Ya1rtyRLhHRDOHkhNprwqK4+MxaKBG8XpnZzPNXF0G1UdDm8jzsQPUNTVjoPbrOAU+UlaepsoejEeVoB5PeimqE1dEOP8ncJqpzh4Exd72Hvueq0jp0vyI565XYKJwV5OrIZY0e85GlBTQXsSrNWVCguW/mAsqPE4Tg4AgZtcKqP1XdbTqBlxmfz6GXH5bEENkHJb5L5m+yaTYekOXAe6rVVLbVHtwAnjZbcb1cDgkEv5yUZ1zdtI5wW6ehksFAKyR+s2Nn3BaTa1OlyfKO4wtZCjNJhcuFbgjcl3hGfoIWk2tH25tH0wO0Sqz6H47MGflHooHk7lMN24Uq4/WlbVasAOBPC7Mw+MDwF65Tis+CmoGLHxpVrGQETdnkSgYx6bIpMy/auJ/u41P8iy2suu2yRwgR/LwG37ybeo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(83380400001)(2616005)(26005)(66899015)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcUYEcGosh3Z4dYI04mHcIuLnRft7GyAE/MxztD4xloP2GWV1pJu8wwGVoIg?=
 =?us-ascii?Q?y676O9f6CkO/47ZEyZe6ph/zPw+tF0ioHnIixdI84mMXdnnuzns46vVL6TyA?=
 =?us-ascii?Q?Z4ZnkhhPklL8+rpEOKzBLGJjH4YoB82SLk3aSuY4pNtt/YGHjWzQtXsl67go?=
 =?us-ascii?Q?/EehNCsEYu4gT205DCCjPX+dKHpvz8ljMu/HaaRVACSOO9Se2i+QmQQNOxrG?=
 =?us-ascii?Q?k/GT/mCdKSEv88MLiTkAd8PwlNWF1Pe0V+cvmRV6EeaV8nIMlKZEo36uoy8K?=
 =?us-ascii?Q?jHaBj96LPFGPzsgJW2oq37cigTqDl2lsOGxAcJaemTJv1733XBdMMOWgzUik?=
 =?us-ascii?Q?o+TIBUbkJxHUO95RLmbQ9oxVPylQFJZdZddJNeQGrMA5+tDIbJbHnYjssajd?=
 =?us-ascii?Q?YBUcc+zPaQMtp0jJj7koQLBwhza2ruwDJBQe44qsyeAewk5pUvER1iqD6u7R?=
 =?us-ascii?Q?v5WqG0M+YdWPHffqBA1iLQ4i5FgFcl+2y2s5l3xg6/WD2993F5oU6vvzUU2X?=
 =?us-ascii?Q?ULOx6Bu+bN0QjWEaWrrz5bpVsGWbKyaGckPpMYHpQBJnltu38rnqN9BGn+LN?=
 =?us-ascii?Q?uNxNpxGgj3hKwSLwtOXjYMq70i5GqcNiN6kRdUTAJY1mkIRd7280UQMjCSIB?=
 =?us-ascii?Q?euLgX9TKcU0FQ6jB7lv+C2gUSpO0z1YZIQeO+8L4RqzoFOHFtVa5KmA8efoQ?=
 =?us-ascii?Q?zu+uHQTyr6fAjnTNq+/A552/Gemx2q3BXV2td93VBM2nwbfyBjZGD1Jp93pZ?=
 =?us-ascii?Q?bvNJCApb/lZD2+sEpLbbs6AwVBv7QTGb7R8f2FnZwPNdwkK7QJxpFIb5psHb?=
 =?us-ascii?Q?NIdXTWFBhDyL8L7gWre/8PEO2i7ysGEBe3caDxTLl0xo5QhlPUynrJyxRsmu?=
 =?us-ascii?Q?rKg6Etf75DGLJPbR0Xab75qSfwUtL8oVFC5NEfSzYNcHxqLIQcN7zV1FjyED?=
 =?us-ascii?Q?w6WTBXQgbhtTjsVTo/xCd+dM8ADIQdk8s5E2Xcae5ZCjTFW1N0DFSBIt5I2c?=
 =?us-ascii?Q?/4Kl1IenSglDWXraTUdsQu85V8pNl5qRJEpMTRvXqrwTBoC/C3BCL64tBMup?=
 =?us-ascii?Q?raTVf6AuY1GEpaCjWEcXbO+KmffOIRugNNpLh1yk7etV01XidsVSZ1TO+XlF?=
 =?us-ascii?Q?pZOlq/2EnJX9fWHU3F97k6RZzegtvU2ft0WFsnjWem1QR9bEhFy0tLPUBifz?=
 =?us-ascii?Q?k2lS8LgIA0rO+uoQCrsAbnhzi716LHLOGQnH13OGPf8DSbzwv8d9Lf77N4LU?=
 =?us-ascii?Q?GgIu9aXz7vrbDlIPIXyPKKx4aSQc0j0vqpkQkktQTNSSE+MhKN28BDsdyU+R?=
 =?us-ascii?Q?ch1s0J2n/Fl2ad1ncHF6FpEAqcj+Z+en2/ejRM25NTz3hiGi6t9yjG0ZFyOb?=
 =?us-ascii?Q?wjM8imFM8k/vxwPVeSObbEBNmzof0YkmeBHRITpTRStVROJiPYkHbyk8cidJ?=
 =?us-ascii?Q?jHNdQYoiTx1YtkfscLqLOahOI6eDI0gsuvl5ZSGsc6a5LjLqzQY37i5iVtDG?=
 =?us-ascii?Q?gjI8f0M5UyXWdxhRHqTIEOcKBlCLa9IoR/Ju9MDKJD/+seBN0MrOb+dz0ZH8?=
 =?us-ascii?Q?MRbuGjqULpzq105maTDkH120KgHWiLZbjBdw3uwJiLMafafJmfORp8HOLSep?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab97395-8e20-4416-327f-08dac3e934cf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:32:41.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W89cIZ7X9JqtNeRGJzoe0i51TRO4tDyq7OdQ+y2LVgzfIPcsRJDb/RIJO1j1NLYywpmG8J1PiWDCVR0+gU+Qig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

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

Geliang Tang (6):
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 246 ++++++++++++------
 net/mptcp/protocol.h                          |  18 +-
 net/mptcp/sched.c                             |  67 +++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
 5 files changed, 322 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

