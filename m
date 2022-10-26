Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20047.outbound.protection.outlook.com [40.107.2.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3A7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In0NsDkrqiV4a99x9I3mTS+hFUg6RGnVjZ8hPWaaruS66IshpoczAyF8D+ojmiftUd1yjki/3fOmXjgWfY+POgeyoYmEkkTS0qKr1oexC6T8JSCSpqiC6lC1+Iy/PvVJAKeXnXPxOAGCVxTBUTGsQ87OLgk1G1KijRuo0wtNKs9pTV4Ux32O5KK+KLZ8vfdEGIl0TVx8Bg0z0XQe3yiz+MUgPcQLp0VbYqgE0maiFv4cFplP/Zf2+1lJmWnwc62bL9ME/TKSge4S+vU0vXroGH8MhwdRcY7UWgI88oIbIGnJz+0XKdqRIZLEyOzI9BlvayXpJEWLb4qkE84/5dfkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GZ4OchVv5/sBEzWQthVsm/V4ZmdvWev3ePyuFN6SOc=;
 b=dkqT3e2/TcQSaOxsXZTqe+1oevaZS74Fz27IoZtqa9oW28bOmGvHxnkjjiq60Ximhckg1WEYGrhz8aiYvd1F/AxKzvKGg5zSP2iqbnQwo9QbVjhrSIYaSl2Sw4AT45ZmTXeD6n2GoJ4R6+UpfFof0R/PBK1pFAaVCwejHXQXSjgiY6wqt7ZAiHLmxPtOgZfRnkFR1ZrZ6+gqhAQDzNpzvUCRI+jM1Awnx4ODqcs96Z3d1UHdum8O77Lmnh367wB7jRPjFJsf0JIAYugis0zJFnkCFzAliESggt2qp0Fa7HHNDxLs85ssyppueH6dLa1iCGIoISECB++glyDcJayY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GZ4OchVv5/sBEzWQthVsm/V4ZmdvWev3ePyuFN6SOc=;
 b=XcIPhJMxKA4CKlW+K0jY0f+StHkrBFu8UA103yK67Jq+0k/akiZ4NDDxMRVGjmSszwNBbaqhLQAAxzvEyXbDSePkbXftaHU4cMBbRsC0dVDzj7XzNjZvPgwIzSFMEoEnxakyAK11dH34tUgRFKNXe9iGEq5enU6KQn8b3/gmSogvcfmSJJqS0IkB6/smOsSzeApJ/kOfYawlOw/LOqpevl0pwn1+sjFCujW3FiQMcEp6JAufXQz2MDCwufO7E4HVtDbxi+WuZr6rBrS9/u6e2ywxEgERIbwPu2szZKeAtJ90hD5SbzTniJ3VUZovG+eAir5uLI+fsJtqDvdco6+vvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:04:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:04:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 00/15] BPF redundant scheduler
Date: Wed, 26 Oct 2022 16:04:09 +0800
Message-Id: <cover.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:3::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceddafe-8224-49a1-b72e-08dab728b7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oyy91yq4JaDgu+XQmGAGx6x78uva77Bc75dOQWMC8PgQxUW14vdM/0SH6f1oSwW/2qczJ8uMciFZ9IuZNa3Mv2HEJpbL6rNpasODcTQXhZfHHHioFebXfbSwAQfQ6kqCfq9Ii4b7VhMRYmzvhFHv5SYbqbbfmT+AhTodNkdyGwpS8cETuG8brcw71yvNUuYkqsVDN/2UOLQ1xuA2Cilr9F32myCxrKk5mnxi1yOVajZjAn/qXRBk8iWu0EBeAFjB7Ohc2XTuZ3XkRzq69UsaIHfzmyOgXhUBg2TIG/qcXRxaS7MNfP3rWYFe+yqIJoDQK4UsurKyCYb+TOb3psXpSo1H50oLcxO3I6o4TykjSqDqJtKnO2th9WsKRExXsHVpgYHnWMfvzzGchf8gNld6I0ENm9lQ3w+17L0lrTeSxu+19RIdQ8p34DNM6D5GmUK3yj0Im5lgR4EB7qUHGUGQQMN59F4CsgcyvEcVCN0DsQ+uytHIvLwQyXBoTmuFlAT08PPtMkOH63r4CGl7a5tjJV/sposrG5POYWF7pvboikg/OoJX5ZKIz97IHjOqwi0ub2p+/YjPQ9b6DOvHKKdrTdZp1f2uudxZBYwqAaTACbOjFzgeEB4UfRKyuJ41IYQvYZ1rBVu43kfqP/zR82fK1mWnNaG3KMlA5g9rguucQg3fZszU0HxRzch8xusf3l0cXsMZxKGfaTFP+vl9lZTa9AjYkH993FAQjhOMglOTocux5FhhVna88zeQqfvQUqT71i77ee3AkjfZEGgmnFH87A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(2616005)(6512007)(107886003)(186003)(26005)(2906002)(6506007)(83380400001)(6666004)(478600001)(8936002)(6916009)(6486002)(44832011)(41300700001)(5660300002)(8676002)(66556008)(66946007)(316002)(66476007)(4326008)(66899015)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQJh6Ido/0qBirFBjkJBpSu4H36+oAhSRh+FMBLIevB/E1nN6pt30Ygzyx8N?=
 =?us-ascii?Q?OCMw3Gf2qlVROw48a5mlYxR1f7Fg3sYiBXC4JFCwdrnpRqsk9sQxNT3eEjvX?=
 =?us-ascii?Q?QBS3Z1soFHM6LIyqjGJspl2CrfEHvT0luhamUtW/QTpPbi4pgkvU/XFY9pw5?=
 =?us-ascii?Q?q39ifeJBGpglfy6/uN4Syde1Ns5NQZmOyKlk+He2w0FMdjwHeRXFVh9vWBL6?=
 =?us-ascii?Q?ncfqvhvjl3Bt/pSwtGdcqeD+bxCW8NZnEg3mo8jpPOQesAZ/KjSQPRH5bOfq?=
 =?us-ascii?Q?bTy5T38RWq89lzfB54r385mEI8ij9a7nWS672ME9Ou2yconRTwwfhc0ZC0FH?=
 =?us-ascii?Q?6M+UR0Xyxaj+YVvHMRZOTiS41efxGEEUw7Ob7QgnBxd+LMyGYXSO/assk0QY?=
 =?us-ascii?Q?1sAsrnxHgs5zyLyAencdUROq+zqz552/Q5pSn+PviMm5xmicl6KL5ErgP96h?=
 =?us-ascii?Q?m5orwWe6agT+QUO3abwkSah23CYGVjNGFGz+IG9PsWR+9faI4C4OL5M2itk7?=
 =?us-ascii?Q?CakKO7xU4kzwKEAqhURatZbfrPglXsXLsM9/t4QPRjAowXK8HNXrLLYhvOY4?=
 =?us-ascii?Q?93osJvJOU7V7x9KnFqb1pJGFiVSom0bgzqyAqS3amSqdvsMmJd/reevmN0D4?=
 =?us-ascii?Q?j6MmAajjGJ5vaGcPBKXBf2ffXun72uwpGELM/s7zXREyAwFqAHbp3Gt7f13w?=
 =?us-ascii?Q?PVTFtfDLp6X0dmc8E9YHKDW9IiKL9sZ10UK5W+a8hP7WjbB9qWCbYEQHRol8?=
 =?us-ascii?Q?j+yuzdoHL+SQ/BzHZ9rjKtpFWgGtlTjKlI9D9AJRHTNv1nMrjKALplVgsZBi?=
 =?us-ascii?Q?12R2fj1ui1BX8nkBh3UVfqP7Jc/f9qlfPiu2WiPibsHM01glYkP8CrPKEdzR?=
 =?us-ascii?Q?liatJqWuk4G9E0noX5CRWUSWH7kSX49rUg/72XdiXYXIgF825pyq+bgwDDBn?=
 =?us-ascii?Q?A2h0h6iJOO1sEa7mr8ySRWKLZ9glNah9s9JIKsNY+2shKtotAgjbUUyC3+te?=
 =?us-ascii?Q?0ofC+eNVczVwIrgHDxV98W7OQsJAsQrDi5HyUCzu4mcuJ3nVc/HOIp1bItf0?=
 =?us-ascii?Q?tHfG/SvJVyaupxItdWcjypoQpmLFFJfB+Bims8jmkHoEaOu6tgx5X2G7PJb6?=
 =?us-ascii?Q?PULFHdaKPV8FINR8hZitzA7V8m1KogNjyVBadfwmHHr2bKO8EFXAKxZV88W8?=
 =?us-ascii?Q?zAKlIXhmKiM0bmnhvKb/uv5nMgJ9OldXO5baLrz6ejgFy2o96TL/a0Tukhrw?=
 =?us-ascii?Q?pmjHmqJn8L/kAZwzIVFTLthR76QeW8UKeXvyO7eq3X/BQ/yx/dcs3mV0iyVH?=
 =?us-ascii?Q?tzGnS7yZOdVyYke3K66RmJMyfR/uWIvwqZUAkKkZo9JSnrKtVYM+7mibwB3D?=
 =?us-ascii?Q?Mej6KQ+E3P45YquBwK/qKvl/p8V4Bfe+XjElnKqoBgj6Rncl+eK9eI6ZvJrq?=
 =?us-ascii?Q?I02Plgg3VJqF9hmcQr4zoJ5dCl7YmvdDIV+rGhom/iVndHTSPb2kaM83u0u5?=
 =?us-ascii?Q?gFM7iTCp6p2ZHuwAq28oOyL/HD2BUK9r6eaEIQZREY5p3IfG72aR47tT8uqa?=
 =?us-ascii?Q?4xxHO3wdX+sEchXCIHe7fX4+vvAX0Pw1P9sS+CEw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceddafe-8224-49a1-b72e-08dab728b7ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:04:34.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzxGYez9QISv1oO6NvoAY5BMNxt1Iig6ws3NbG1Zp5ad9ja4KzBMh6GPdQcXQXLs9aMDwOkkXCXAJPAJWsG1wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

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
 net/mptcp/protocol.c                          | 316 +++++++++++-------
 net/mptcp/protocol.h                          |  19 +-
 net/mptcp/sched.c                             |  76 ++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   8 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  10 +-
 13 files changed, 402 insertions(+), 145 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

