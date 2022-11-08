Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140085.outbound.protection.outlook.com [40.107.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB1323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHNlzTs0WgM6jy/qqmRAiiBnDmmZAJ+RgJvaWVdX6PxhfcwN9TdTOc4k/1ikEiJPIcXXuGniQsSEtobCHK1kmmueHBNnkhxdA3n5iVkQTZ7ZW26W4qFLbJHmLljJ4oAK20mg9/FtDXC2c15Otjf57ZdMXgFNAe0NjrtI2h3pByaoH8BgW+ewG2dlQNuRO0FWbpVYKGTLXHV37RX6mtYcVTs4iSbPLTiTLBWyNYJvd8ETDBc8IA8SVg1lOs3c48MqyiQgzqT/ti18DsGj/r8yAHPTJnHDgsH1axwsobx5W2gokrXOuRGTeX2ajAnrYYqM6AvuslhOkK50BmhhQQLGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29dE4ory1jAnbogqef0RI1u7y3JOcG3Z2poRB/ffjP4=;
 b=hpP81tumdY423BUjJgAQWzxuub6PtRHCFDvnVlFI8ILVkFnr1DgpcU3iaoEUAb6EpylrTxCeiVRMNB7r6/e/NQnasyXqmMgc+6/z9HP48kt3J00DS+bXY0diZr0mtqsOdlW0TiabfIOWBaTmZCRVEEiSjWg36WSv1VN3AHjCb6C629ZfHmpPLXhOneCDPhh9+bTWxLMidXk+iEsbLmmux7aEfl++sSFSirNWNDqqG/Lv6kK+tOfS5mdU34agLH4B2Zc2SI+qPsGHil4AusDiTemUkJfOnr6iU3nZ6OkDLYvnvoMSQtgce4BxzBxBFKYtKkwlU0Yojkj0yaK+JtkBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29dE4ory1jAnbogqef0RI1u7y3JOcG3Z2poRB/ffjP4=;
 b=1DAX03LRfLadcujbVaBkYlhk9gBJ2mWITVGdiAlVrVpKp3dK9+egbkFTyhEFtEsGe5EwADJiCz8znn/vjD4Gyu8KP6Ki4vJCEWL/5YGVdybEWQvHoY8yp+HZvWNNgtudIiSP9445mVyIRnGXBW0qyEIk9zG5z5AZSdGXZb0Tjo9MwuxbgVIr5iDxz7+gszBcvMowIGHoH5vS3pjr1HUld6mT4u7cvQqTR8xz9rBG4S46kkto6lzqH7vAriz+QODSBgk63FCAhII+4QID2M4vPw0sW0rzfkzToSygDS1JryUkAu27yjz42O1yAka1ooP5MJGANLvk7Dqp81U8KQ7YWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8924.eurprd04.prod.outlook.com (2603:10a6:20b:40b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 06:45:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 00/15] BPF redundant scheduler
Date: Tue,  8 Nov 2022 14:44:59 +0800
Message-Id: <cover.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: e96f5eaf-7e48-4a4b-b7a0-08dac154c34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sucrOlcrvj0E8eiBO6iV8qTHJEQ3YCa3zsVMpx5hyoz607kWSBx5t+GnCe7LFCrg4xWSx6Gg8W56n80vBC96G/NOTePCcyIGExVgaO+i7FN5uQWh0DtVCJojqFaf7mKz46nrFSvzR/D+x4vKNVnVQxXeU54iMvhHiTWWBq4Axm3AHbFvfVWe7YhiO62dHZYNfXAqnJOexcqPgFUbocirXrIXsXg8214NfZyUBvONUaJzm6PGhR4D6S5wF/8she37KRgr4HL1WLqJTyZAs8X3d3AAAXNBNvWY+RLK+hZMW24Q5WRLfi/DvuZCLImwji4BOGB/VNBV3tJ3wCYxQE3gneOL2XxcA+0nJtt7ObxK/9OlUa4RtlqBuEUi/QIFTCkuquVVsTu+jacC+scuXxTsyVsrnEt9wFl/HDt0tJ9xJqGkloYXTp1lqNN5cIm+acuc0m/T08KZugQbIgOBS8pB0ZOekPqntkvFrJXRSkHNOvDFxOXGhNQV+1KNWPFA9B0zBoJsbWpLjB2JE/7ZdkhY4DMGPOZTXKrI4Y73l8/TERPM3+5uuH85F0GygeSkUCzW+GlRKOh3gyOYkDRRmXj9ZJI7AINjTuR8oYBSnbJGFE4g82cEwoZirWOrHPvOE0NMDdH1NmgClYi0RbpODkL7oE6ci1ciMN9WO3Lo3otOYCAwy9PkXu6yZWs7cSqvfClpw4ruN4rMdZPowAQ+vA2q1+a+76P4M9rawisXO2HOh06ILVcaAEYAm5aslJNF0ts9Epe1Z5nmx+DBA0q57vYF2WJkUHdSzkD6wVHAr9ojQ3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(2616005)(83380400001)(38100700002)(66476007)(186003)(2906002)(44832011)(8936002)(5660300002)(86362001)(107886003)(6666004)(478600001)(6486002)(26005)(6506007)(6512007)(66556008)(8676002)(4326008)(316002)(41300700001)(6916009)(66946007)(66899015)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBwx1EpIa7V/d/+vZmBlO7emBjOSbLY7lneiMeWXwNMrQPaU3hfxEYo5WEc+?=
 =?us-ascii?Q?ce1u3dznUETH8qprZri6ZvleqiocivdvoGCXcpVR7CtwF/BBXGpaJcKLoCaY?=
 =?us-ascii?Q?AV0OZivkh9KrOByRuSyR0RNBiJw3IDQXNmvblfrhOAb4QOpAwN7G4SVMOeXO?=
 =?us-ascii?Q?jpgWoG0nP3EEubtH67YQYoswqR3/y0ah53Ut1Cv+4q4tb7Q0yl+piLqa/mDl?=
 =?us-ascii?Q?Rj9X55wpH2Sbk4T+aYoqOEb+CL5uV+DeR9Zw3WonXAC1a60+W5rvFwn01WaQ?=
 =?us-ascii?Q?r7UhgE8PyzwahjxciFB4CvOh3hZI+RkJZleU57aOWu4iY66BuWcUvbX7gOjR?=
 =?us-ascii?Q?NXAp2qaxElM6UC/vUAamLjVfLkRkPPrgPUA1yzP6hi0QzLzehcOBf8uFoXDQ?=
 =?us-ascii?Q?xo0Wvqxxq3ik2cpw82DZAqAgkVjJWKAGkezoaW2E6ucXHlf8opkB4U5AW54m?=
 =?us-ascii?Q?gQpLyVN/ifrHoIySiG2EB9V+Fa2uwRSV2s3WTtQRmnsR+BM3MeHa/1BcaGLC?=
 =?us-ascii?Q?SFweb8+tns9Nnwn2aoSMyUsjaPlfOokKBNXXv9sSoelsQmkghVV9eSuYI0Ld?=
 =?us-ascii?Q?Fcz5OgX9NlY82ycXGv0VuK0wm3mDggIiuV2AypC7aSoc6BNDlyYC+P+5L1SL?=
 =?us-ascii?Q?mQztrlgS0IK366q64b5gjYcTdZLW8Y24NEqk3rbASd1VuAoBtjyUH9xsJJvZ?=
 =?us-ascii?Q?JhwnmA3HYSP83grckcqGyUL4WLI2AH1DPpg0ohF+OUz3SjKpcxFMIU5gHOEj?=
 =?us-ascii?Q?rB6T7PX08fLkA15V5AWQNQLGzCw7X37QJvG+qPHWEHO8T5D72qR8rRqQy9Mu?=
 =?us-ascii?Q?nNRHc0NSR9hWTZlErWi8cSnVmUJ8XNEAUD+xH/fOkJyZe+4bU8JTagAWLEC4?=
 =?us-ascii?Q?arYv8UtVA2Bwo+iDNW4XKTBrRLjpXkGAAjLOB7H14DVII1tfg7eQ2HagWJml?=
 =?us-ascii?Q?Yr13mDbi6GW98apwujYLwoYG/PHZ1oBDQxze2/2yy0tOFfWYyRhsQDEtoSMC?=
 =?us-ascii?Q?IcFj6MfxBjXNb90gQiJQ63Nc3bZ6bX4e+hHtMcgZQ7tCm/PiK7hfOe0j4wWi?=
 =?us-ascii?Q?xERGMIQMEuaK67PnmQZqCbzzOhZ7h9h7rBpD846t7lO/DqAi1OOahZ17MjKw?=
 =?us-ascii?Q?prrlR/H4HQa1Dj9SlQ8BnfK2EqXTQGOpjx+NdxX4Bjw3T88AqaQ1lAzmAHkv?=
 =?us-ascii?Q?cDBdaopdQsvomQe6AMzuAp1AZPAF/SrvgybWGtaArkbt3lFKTT6wtGW04mPP?=
 =?us-ascii?Q?VoYjF6WHy6Dkqg6stnGM/prozgzn9vFgtSKiSY8zQPRDGpxVEPEiNAzlO8G0?=
 =?us-ascii?Q?DoBWqtWABzkHoybHxiGuWRgNp9a0nTPSXPYS2BlCfhIIxlMMuM2uA7hovE8f?=
 =?us-ascii?Q?aQ07FVFTeeS4CszqepaF2+v78w55RbAEiMtMwrvtO7o2QWf9+tqlp4RqJCcz?=
 =?us-ascii?Q?Ot8x1/+5+vR0q0bWgyf+sCWGjotSNXCNLPf5CmGW0Qlo+nwAg+O222rNKVF5?=
 =?us-ascii?Q?JkVhH4AqO0kDEChwL7I9CusJRhLGn9D5B31FO3L4Fd8NeLuosxKjaas14YXO?=
 =?us-ascii?Q?kTJNdjqbBomB3OghjOOLgMSfpvnZk6dKFYjBXO5zSFN5XNaiANBWIF4ZTkZd?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96f5eaf-7e48-4a4b-b7a0-08dac154c34e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:02.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oava4ndIfBhQrtVxqY9Sk5G70apdEbNDDJKXTkom/Y1x6sk2UM+wu6XuN1pp5O8MPTayBUsdPbhWohy5fSdvQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8924

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

Geliang Tang (15):
  mptcp: refactor push_pending logic
  mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
  mptcp: add sched_data_set_contexts helper
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 include/net/mptcp.h                           |   6 +-
 net/mptcp/bpf.c                               |   1 +
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        |   3 -
 net/mptcp/protocol.c                          | 333 +++++++++++-------
 net/mptcp/protocol.h                          |  19 +-
 net/mptcp/sched.c                             |  88 ++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   8 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  10 +-
 13 files changed, 433 insertions(+), 143 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

