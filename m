Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F946AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzZKu4ctXmBDecNLwVQfqx4YJjlQlJi+sX4dPHaCZWg5ol7zbTW+gcswb62/ORAO8/gHfJTQjoiWYrE2iXJpHpwkvBybpoT2IiNswDOH3zCfFjyGLUe6ZGwV7HVzzzxQ3cgQo3gwBGX9XRrhcwQZ5tJOMpTFs6QkWSJ+zUUYCuC52PBvYTffpIykuJC01qQEy/Iv8w6DFuzhQEyMJd/S6dy+g5xV/VXwALS6BmRYxwP9rMjqsT78JrsmuWyiKEt8iAMbtoCO2AMtGqRQ16/1EZb6jdFPTTE2+p7CymcfQyKxKdU0gJ+vOO/heYxZjcNk3947C9KJV0JxMM/2P4zcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYfDnIOy39GJ5SJIQnQa6CyXaxCeOTg/GOyYTZAiqRY=;
 b=HH79PZoNxP3UC3i2ipsk0Cq7iQrPd3e93G7bxFBITxlBkwBOAnhSxA1eO7Y8aXTI7uNV82O5+jTcPAipueEje8aJtkgHMxADLXCUx9e6j2pyOiIkKqYmMKlfloQk514eIQcz5JFaBcmcgusJoEzSnhsf8FeWIV3f6/PrhNgHvXzWsqa7qOzPIOvYKXV0ZP1DZ5SuqmfcNu/eNS1dgbiYQztwnB4lZCXJOV5jFcRN21FC9NGCQlX9h98/pDwvHoizZJC4XTH4nRUAOF37CiY8os4ulDYqrINcd6w7iGoMk2s9Cb1gv8EUvJzcEvVLVm/Rsm0Ml7qGRIxJtSQVW8U9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYfDnIOy39GJ5SJIQnQa6CyXaxCeOTg/GOyYTZAiqRY=;
 b=GsA3t9orQWLsiPveokPNeliGLB6pNK96bSdsgJLqW5SUyIDUC9AQBftf0tVzmxjWZ+KxFRPYHvb+SqpIS4qwd8f7FXXjjB9BJKJp3JHgtICpiiWRmBDKBdrM32B4kcL+pY3bcBxCbrISeIStVaKtaMUnyURI+zcv+fI+ieoPxHXwj9rDcS5mtjyLoWO0IjJRg5PeLWp3468n6s4Rdt3Ci3pL+SfsDaVrbypTTao+G7i7Po2qkCXh1jjRhflPGYtMjof43v8W/fAuMissl4rULNd+Q6rA/iUfyXs82Mga/kSq3eEUbtGh3mDZvnWmaJsC0K3qZ8fcd9h2DHqtL5/s5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 6 Dec
 2022 13:22:23 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:22:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v23 0/5] BPF redundant scheduler, part 2
Date: Tue,  6 Dec 2022 21:22:16 +0800
Message-Id: <cover.1670332660.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e97decd-1b46-4dc6-31d3-08dad78ce8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DF4fRQ9Pv4zM8Z20TmxgMvCiWGCv+Cv3ErK4tUk1LZp38LBMlkPN5fYJc5T0DaHY5Q/xxBLcSCskw7DKVbDK000lXqqoacLqpEtRKdCcCWzIGwqdkSpgHm1G8qwBtwrBdMiqzqpmhXkh/yvkQioXl+KkdMcDXC+DBBNz7voKuAnYCYzaoRJInIn0fEPOzd0m2RYgVYgfhurFUNWn5neYJYeu051C7tUCbL/NBwh0VICuj8gfp8S5Qvc7r4znKy01vKqpGgyOQlxifTO5l0HHcLHah6LIlbB6Zn8vSYMBvtZsZ9tvzPm+5NszFilmzibOmwZzP69UOgjagIkU6Xfr+rCXEDWV6KCJsmMN3rNiUhxm2PblK2zenm60qQNmAy29HDH9IIpLyrmLu9gr6D1L1OlH0GZU330knLdNDFcGunjfHDMSq1OjMB0hVBA/Z7HynYWuwrrhpBUdvNktsWC4BIUglXpVqg3KRYG/RJcE1e3ONet4gz2OaT7ivj/26b7428hY+TP7VpRsob4a0vo9ZaQ1Y83o9y6uivZ0Y8cqROu6LWha8mj/FChCm5cFGecX5wbHSUZlLnZ3Mw0qXpYXGWu1zCREVOnn/lppWzyKH8csbGR+ufvYpZXOYrPmyMhY3TQ5/7o5WqVIQVF9u5WUH+NW1b3UvOfVwl7nxsUseRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(66899015)(36756003)(38100700002)(86362001)(41300700001)(8936002)(2906002)(4326008)(5660300002)(44832011)(478600001)(83380400001)(6486002)(66476007)(316002)(66946007)(2616005)(66556008)(6916009)(8676002)(6666004)(107886003)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfwT68rQrQg//klOOS2xatTw6RO8cgLCDF7M4BCOsCw8veQh3r8aQMI+gVJx?=
 =?us-ascii?Q?J16iigkGfZglh9yYSTH7opAH9KJHNgI2xTkOYYMUw6YfEznPIaZzBukrQYhG?=
 =?us-ascii?Q?vTOkMcuSlf5RqCGP23c/bEvsr7pWpkdTxJKEXRXysdhnQhgP07iujlAkbdly?=
 =?us-ascii?Q?nRDm4OCLakMPee0TIBZvrNtT931+iI3OsDdc5lUVGHorfrMFAd20zPw4kOY3?=
 =?us-ascii?Q?8WrfJ2WMdSw9396IPlQkpMSlI3jQwkHMIh/EzjmJs0uNuoNSs84biVCxinci?=
 =?us-ascii?Q?ZXkXpDy2zyyhBqjgnaakRFjbPTweulq9NAlYORKKt6bp1eyBXwoDDRcIrT9L?=
 =?us-ascii?Q?UTwWWLmzbU2JW1IdncCQZkbAKUZ/Cps5ZoFeFVANNqSUy6ADG+twBy8KTk0E?=
 =?us-ascii?Q?Y6bnXcZ5X5MOy6TEE9KEmLrr1+Xgk9KQxthfqW7hsETnmx2VlMTxjPF8pWEO?=
 =?us-ascii?Q?MNryqlj/vhxTFjBb5tH8RDp4z56ZhLQQMjLAAk9/gLn66+3cRUfOZ75QgqDh?=
 =?us-ascii?Q?IhnrBfFQrKSHY4+QarEoXEeVFkEMZUxdfbVcSjELqSFbAHmZqTDQBo257z6f?=
 =?us-ascii?Q?CKnwL6+pYCpBkpIikBuqraA3DiLYLgisU8eU2Wzyb/QXy00AiYM0YTux/Xrq?=
 =?us-ascii?Q?Url+nx6eXM4uyP1zO+mmDSblwFmNrYUrQVUiz8SnSK5he4IJ0/UHpS7uPjDV?=
 =?us-ascii?Q?RWPXLh1Qd4amg7Jl88mxtaSvTKDfGZ799pNM71Srt/zU4BbAWTSjmXy6MCOZ?=
 =?us-ascii?Q?SRLo9JYnZLEKTO/pRs7YkPN/pQuYec2Kxy4LEOko2aZ9epqn6XfCm0iFPndO?=
 =?us-ascii?Q?ejWPvsHDwvR4qWWVTVP5tmOKAEKfQlOy9rQRCsLUqMK7yl6WApS80EFXEsHF?=
 =?us-ascii?Q?zB9/q6fjJpageU3cARe6gUyeb1mM4nFhyXTbIDG5TA4V1/wVXBY3LnDfW9My?=
 =?us-ascii?Q?YhaZmiXCT3WGc2mLgivMnEFKcdjaJEWr91zjeq325k6TV8uxwnog+O2a4OGn?=
 =?us-ascii?Q?8MwGgljyZp9P7kz9UQO8DMCLnbu8649Vj5OqDw8+Df7Ic4GLDlL31MxnNQ2e?=
 =?us-ascii?Q?bY3zrx9Wp1MYj/IFc3nyKX7G42QZQ30lLiADnR9otLW2sIqOLk48IcegvgrQ?=
 =?us-ascii?Q?pnG+CRbwIZ8BO0hWOup/CGL8vaycN3ZVkyePcr+Goz/4P7sZsMjgH92ZJ/BC?=
 =?us-ascii?Q?M8wAlqWF6EeQv9tYzktveaZe70BuImj9i9G90w12hqf3+UnPU24RPMusOtoU?=
 =?us-ascii?Q?ZlDXiR2jdvpAEgh+JTQjT387wfLX4prtgIC7dWyEhkDyDcTMtm2eSRRxx0vb?=
 =?us-ascii?Q?xemKeG0vEuslm1go4jf7r6rinUedvv+aJo9wx1+Vy4vF9AXl5KQxBQq57WOu?=
 =?us-ascii?Q?/hy4va6g1RS7/M4+jslXm4D0MDdEThomEwpJXCA6HR9n42WXtewLI8iCMaM7?=
 =?us-ascii?Q?2SxD1BkqDDFofG4Dv/+XZ1BO4rPPRbn6eekmfPObk7mgX7a2WxAckG3zH5NK?=
 =?us-ascii?Q?GhubFoZmL549H0nZbhXwKEAF5JcC9pO2r1vOxCdjNGqmDYdHp9TNsduwJq/1?=
 =?us-ascii?Q?pZFoY+QpkuE00/+TR7a2Ctmu/V/fJ9JbfkeSSdyWAf+l4awtcV3YfqaPPm0E?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e97decd-1b46-4dc6-31d3-08dad78ce8d9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:22:23.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l13HaR+IR1/0pZ5b8CXDA3uO/brlXw7h79jo0hFwu7C+5Sw3ZmVYNg0FfBHwveFrTQFSykO05TVcKAGw/CsVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

v23:
- patch 2 and 3: clear subflow->scheduled flag on the error paths.

v22:
- update patch 2 as Mat suggested.
- patch 4 and 5 in v21 will send later.

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

Geliang Tang (5):
  mptcp: add scheduler wrappers
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 196 +++++++++++-------
 net/mptcp/protocol.h                          |   4 +
 net/mptcp/sched.c                             |  69 ++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
 5 files changed, 272 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

