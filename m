Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C622F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irmae5/OPFW++L757qzVbE/6PBEMxvK2hBIW6sTbmAAKRua+XPMOhrSCxRUjcSzKHQa0lWkIY7O3+b1a7KfSf+N5TIScpBVpUEKPxzp5v6wJuaXy4zg9KXll1QK/KPTJJj8zuRImfvdm8vy84F1bPeFPPGqWrzWSVRDHnn8LKWgPi2h8bG0FS9aPjL3rSZ6/RM2IN+uGnMfPnwdm0ioChMePNP9/RjUJ4SOLQI51Eld//HhCljRoYFf6yPOvNFUS7XtzMvc6tiioGXr9NiVHsJyCJaj9fcaz7nEP4wHWy7lq29+eUYF3jmTY1ze7kGUc6Xj5U0R8vgKVM1r6lOv2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChInhbGJhefzOcniKokiK4VRNMzgYd4KtUXbwniIhSY=;
 b=j8OFpY79cLIfkDMxcTr3LV6q71oje/Aw8k3y/JR0CFOTN8neRQkSTipJers8fV0Vt73d6BAa27TLRKNUr/SpSJFWbd0pV68fmC86fTIAG9mTy8quX691H3uuxp5VUjmg8Z5T2dUyDWRHy7wNHsmi8jBtnOdCIKxHL+LBUUAOcxVAPQaJTlw8ZhpPScBMVZI114dOe8WaOSXL+ruK/FGvqSPSzzCcPDboRDAIUP0VboYGXjFBTpOGuExYMmhV7WBNTWgydp+rA0tsWv4HqlUswkSqkWVGYQiAL+9ZyX9q1VPrjgor2X6TD66Shf4dnRIz0SlPK7OR1z0lBf2dVsUtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChInhbGJhefzOcniKokiK4VRNMzgYd4KtUXbwniIhSY=;
 b=0JWkvz94+7RI073z1liftSinBMM+35g8mNrIWcxE32tbIL7bRphyXqcRkgLGWO6OusaRk7EqoB+I6Ywdz4Pyg8G1tbcAtFk6XcqqpH7L4NhudZ0PaY+wRbUourA0FRUu5HVRKHwRwuf0sBCb5Hcd/YIzApBs9yZJIDrYXESwWIHiujieYcXwetJ62g8Z5iDeUXrZICbhk4iDaYmjdEbFDvIytMJ57Yam7zuoxWTns5pWwklqLQBoxl676p4sp8uerVXIb+/KycUkDG46xIHCWkm7OkKNJUpkrryQNgNz7JoHJPfvGocSbfTqk8P3/Anj6s146HldNlkmGLmcB8K0GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:36:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:36:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 0/7] BPF redundant scheduler
Date: Wed, 19 Oct 2022 21:35:58 +0800
Message-Id: <cover.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2839ed44-a284-42a6-62f1-08dab1d6e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BwEeCwaKTZzqnZa+cxV6xqNzG0IpfCynfUpZ5R8QLxNgk2AJghaKPZM176urWPU5LCk3qBEbH8s6duf9t8C5qTWszYvNs4EhmZPuVsxPoJqgoj3CS3c4SapKkLN4929UtIWWoBi2t5xzcVyYSuDRzOZ6Kw+fJA3MsISt0GKb7GCSJvjdKKPX61raT3xA1JvM49g8n/brdeVodLGf4ckUKHU22BBE9Vk1B+POHWymae4ZUd6pb3YupCpLq8jCpJiqkXyS4V0fl42fNtQO/fr54vC9paILnRoAP76NbnQQoEc7MlQKXZmX+ZPcEgMcHQ8PR47JX/vmLLdU6htOxnK5NaPeA8v0bUO4e5cbLzMFkDoZIej3Sp23NBtRODeOdHRRA0bspfqWDpKKq56Rnww3+5aBTXVDnlvPEUfah+y/eqKirOn+/FVSjsRQMHWjdyMCacxgwfHEXoVGuv/i49mLoHPQUgZ9aKXko37L/VJ1NJg96dnywDyuu19wCLkRVyaD0XU/1pE+m/xnOMLVwaD9QFUkIp+AYIDX8x6SPxH0UC8fjNPF0Hc2PKtYfLh+Vm6M0jF3B7+1gAee15uE/k4UE9HjaXFQ4z/5yu99Pt1wbNL5i0s5VIfKLZRYthIKg7R99BTWPD40gW3IQy5B6Lb7y8oKgqTMFZEf8Zg61cqnsPl8jxBKFxIQz8UVDLmcUxubtrYEfbCkdG26JZr9xNBP0UWDAtw7TUmwyZpUPcxcqjNN/StVTHpEsA/pdhIDS7s1ns/C9ZaJqKVCcd+AyHaJ8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(36756003)(86362001)(38100700002)(6666004)(107886003)(66556008)(66899015)(316002)(6916009)(5660300002)(44832011)(8936002)(186003)(66476007)(2906002)(6506007)(2616005)(478600001)(66946007)(6512007)(26005)(41300700001)(6486002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUs3xr0tCkFvYsCImt5J9ZHSzzvFGR4OVWvt01dZX3EVyFZgKWGpj/B49oFO?=
 =?us-ascii?Q?OzHvnTUAm5fvfa6RSFUgxpL1fq9cFJGa/DICnXL4NI8fvbtta5n/53Fbah4V?=
 =?us-ascii?Q?cqejPQukk6Nxkti5nnvxzyN+yZxQ2CFOqIv7A1C6Nrw41sZsHP/KXKwofNw5?=
 =?us-ascii?Q?NFjXepmx7pt62Cy7rqVuFOkeAkFXZdOaKpzIXecY7UbYUSATscYTAyYDgkHx?=
 =?us-ascii?Q?0Zmu5l/8COAJ5P3uROS8AVMP6BlI7RFPq4MNs39Dfq8smqpg/Gga3eS4KFL4?=
 =?us-ascii?Q?CkfCamIgybjHiMAdQ6ea6sUKu9VnztDnnoqvyMUV2A2xyUCU5tFsCoKBpZw7?=
 =?us-ascii?Q?BdjkRpA43/wJjBr6bsPW+UWH4XVFZJm52dOQF+qf7QhTAzYV251T6SQVE6bC?=
 =?us-ascii?Q?zZDO6Bh0WqTChdfKkgXfpgq3jFFrMdJjQ1PZAcwF2jSgXXiYFyGk05Pyxus7?=
 =?us-ascii?Q?mA3LTDEyMaYvCXgsta8la8KOOZFXtc+oOr9kwEH96/spLUAa41pDflBif23K?=
 =?us-ascii?Q?faGywP1ADv0/4IqcyByF2M7fZEmLQYqrZ0lo5Oh/CU8mkw3++QCGY1cXgI0B?=
 =?us-ascii?Q?hRBzqTdbiu8nhU+eem7/KdbpCDwkyhntxQCjRnXyK3+7XMkw+3iXf/KQoBET?=
 =?us-ascii?Q?Hl/OqEcqR8WaH62DIvGTJgWZYNG5HaNUckOML7HWunEcTMc8gyQNK5yzNuFo?=
 =?us-ascii?Q?7jr+hdA7ZKJ6kb6XqZgb8Of/h7ejvOmKJD//ru7Hn9/rac5mPTIKaKD4FfM3?=
 =?us-ascii?Q?NJvPkCZ4BE5nXtktwIItEOOmq5MTWmIFXK6R6lbzx6NueHxZAfzNvGNSHVMk?=
 =?us-ascii?Q?0MehvfthKglQPdjgo0PiN+RBmw2Kiv0ed+pETvsB8A8zp9+o2Navz0flTfIv?=
 =?us-ascii?Q?V5YSYyYT+XfZw2IQsLJydEa4o+UKS72ARESahX3XNTgj0pzxuuqa2kItkDUU?=
 =?us-ascii?Q?gDfYaojdye1jSrJ1rNKDt+dQ3M5di3kIsjFla2v8kmVPZ6s7gX6jESuo5cRk?=
 =?us-ascii?Q?ezk3+SzwoeqVVYXGIp2tpl55dUeF0miNnA+BiUlrSgovMfdBS/xtnw15DvIv?=
 =?us-ascii?Q?5amksPX134RuQYSbqoEc0DssNHN3h86GVYgOn/h5sVos3oldfhgAVOWaRu5t?=
 =?us-ascii?Q?GO5Rq/tMlv3itCvfIRZNJ2zP7CiNkEILEFzg+wm6NrdERxRVAG3WxwXVFa7r?=
 =?us-ascii?Q?WiEm+9VCnMZRfNmVthIWZTBHtpwIAW83wijDAdWAhBuIsoTtOptd4HhSLDL/?=
 =?us-ascii?Q?tqu2wIf7fZIZ3149itTB5yUlNBlp2j3vE4j/9MJ/HtP04ihWokoBRpBpaIxC?=
 =?us-ascii?Q?Br4xQocqcRWF44OKmaMqXlJRY0gyqh0COxnS8y7+4g9lym3EjyiuxN4Nw879?=
 =?us-ascii?Q?472lwwIWKWwDeSIZmSrR23vQdA42LMrgIU81LvJ15lhOu/NUP/rt1X9YaPte?=
 =?us-ascii?Q?zaapLVRT3mk1PbTsi1IIoyHA4egVDzg9Dh5JpsYkraCJz+jfxvCTSYwAjBQu?=
 =?us-ascii?Q?hTsMi52Xmz+ETjf0Qv9N6hCDjMR9z9cqw7Y1v0Wblyo3W1iXPVBbL+4YXGFP?=
 =?us-ascii?Q?Dj/I1pqTELaaa2g2JtwhzKOAWqS5je8EdYztr7lr16NawRxyhZ4xM12vhil+?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2839ed44-a284-42a6-62f1-08dab1d6e3a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:36:13.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl9gM50gbO7MqnxmJdNdpD2FYKbC3jXqwskKqQZiAUDdnovq4vxrDB4YbjhXp7OJ7iBFySq33QkNA2OQm5SYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

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
  mptcp: refactor push_pending logic
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  mptcp: delay updating first_pending
  mptcp: delay updating already_sent
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 291 ++++++++++++------
 net/mptcp/protocol.h                          |  16 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  37 +++
 4 files changed, 271 insertions(+), 107 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

