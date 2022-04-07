Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152EE20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HPA/A5VMPzAIDfTeturXkhni7hAnvFhbSOhdky4shrk=;
	b=SckijmnwKUA/CfynF2TnJiwHu/kQFid5OLRutDechoiOevQbd3wDHvt12Q4QzDA6U88kpn
	DoFJ3CS3BrfEAZRSr/MyKlwMDblVgdcwFrAfaxXW39lBJxi0Uyymdk8tnQII101Cyb7jp+
	T6P4gfUSuvQnyQLmzQUF0Vb7T+ebZfQ=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-S668O7G_NzOjQuNSb86EUw-1; Thu, 07 Apr 2022 06:03:16 +0200
X-MC-Unique: S668O7G_NzOjQuNSb86EUw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atfBqB32UCR9/WxIHdBfNRmwaIiOv3V9m+0Caz302nWG6W117wap8vgRo8gT1amSsnBTFDBQd/l6S573kNOGicQRDdiGPxGWRXVSdwFfkkXFYDoEP9x1VulPYoSsdcBLREcKa5+yGr4A9CN83FYGHKoT9py9BYn0siHsJ0Z+cHF+W8U8V685t1zEU8CqTu7PvW+iZZqeEwUmNeTivspPRBTyb20gnrEDEN4UV/MjY8l9Sgk4QcLMzusoXCrS2w+XudfF1cuo89FAaokJ3dPB4GcUlw4W9iCXkbsGy8+1Pzfs/tPJTisRZE9DvF6tt/m1ziUag88bvhH8+SrhKBBSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbg10RkN9SVPSglMJJ/52oXXEQRuMVpsUW/AvAYDMaQ=;
 b=kIvj1eZB6G/nb2Zq/3Kzmxwp3gWl1luriTmV+HEoIYjinP5FaYza6JDt3BRSC9iFYup/ZYWdfhOQDcrUyQjgut/5nMPk83CiAXVWxx0MAUP77UOcF7JCRCU4rJJmj3573aF9MO7V8JjhAqOfstCh34NalljBfl/k4goevZO9I+Be03lyn7IandZQU6uyPHKNDHF80RB10iTFa/Mxd7qYNWrHeRnNkUr2xXUOg88icuNulXuAnijxbtpEpfwUaYHUrRkMSYxMVvb5dj9uwUwrg+pqr2q3QVrhSuLG6hbitriF02pDQSH33QB1i+ClThJRtHQbwuiapwLPk+BojH1oyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 04:03:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:03:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 0/8] BPF packet scheduler
Date: Thu,  7 Apr 2022 12:03:12 +0800
Message-ID: <cover.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:3::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab96611f-fd88-4c0a-2be3-08da184b8a06
X-MS-TrafficTypeDiagnostic: AS8PR04MB8818:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB881869FD1C5187716E56228EF8E69@AS8PR04MB8818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NgGf5bwUB+LUNr7a2Enk/0gEAjj6q6sAbt/2mI4cRISA2lbX/JOytQfqE5TXxMnjMdY9d8d9EAWKt5JKSLSOd7IS1xj9oh4iwa9xfcC+e8hmGa7ReqtkXXD0Lt0LeunQaF1gJr62X28D1oeLbjL49d2Eb6C6Hk34rDxRC55yrD2RHCepDQEqUl1PqqaumVk6yboNrKP68YM1wU9MgrPMKchVjgCXOtQa6DCnq9r5ZBcT/CDKZVENp3GNBIXzIWiYfuJAZfMk6XsZZuHNoLc53PfGFSHQXmMCeCcF1K7hb+i7EyexJ2saRW2VayPsXzI8VKmxqHyskXoWxuDjRTQKXzBKsKHR5s66eFV6cDxngW7/CSW1P4HVe4EmFvm0wRXQPyjhJMkBKUcW51aBRABUbZJpqu0YwhmhqTPeveRVTCr6Dce7zYnPZlI6L75V1m3/Lca2gpVGqJgn2Q9nhh4uQhYmcUNqmUdCts5pMha46OiV8j1DCJCI4nbHT+OAc/JLDiSCA/piMREzmDF+psXv/QMqFws+UIMevAp7yDkRJQ3V1pMGVGdLqzOJNsdjeA94zpERBF5DwJOBiU3SbRCiEFLhzEAS0vOcnvw5zGPsB36x/cVKHgMbB6qcpzlor9btIiMfmqTLT8wED2JzfRo2uC+KKDdrfRGybj7zGM4MR5SB4KK1LqvuomShZRRAYsDxLtlwKmItZ8WZxpBRBGXVcdywlPHcgh09W7G2Z9DGK6HtMQBlSr8tRl17BqYf4IUwFAjSprrUrSQGoMJPw18ieQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6506007)(508600001)(8936002)(6512007)(6916009)(2906002)(4326008)(316002)(36756003)(966005)(6486002)(8676002)(107886003)(66556008)(66476007)(26005)(66946007)(2616005)(83380400001)(44832011)(38100700002)(186003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+5eKrVvNhrjJ1/Xj9XgDpk4OTZ27NtMe9inth+8kA0TGIPNDUuxudaHAifX?=
 =?us-ascii?Q?hYghnfDYmz3Vt1t9i35X2VmA+cWE8AqwXf4kv6M15fXIIgsYnjG860bwaZXo?=
 =?us-ascii?Q?LlK7elhP6O3MYk0RPWHnOjeEmkhLORMaktV2odaz2OqmQ8XKicMaXZUnzgzY?=
 =?us-ascii?Q?VlBSZeGVcEGbl7D2UBGw8672CEFRodwS36pGMMsnaqSZJouIat3KxcxDpgra?=
 =?us-ascii?Q?80Ru3ximqdLEmBD5+MQtiRfziJfoTiuyzrtO+bFTDTXy5Q2Jh/CYM1ErGsdH?=
 =?us-ascii?Q?z8pMls4fMcssIkOgTwVkqYxX3kAJdzEr/1mWaeUB7p0txirpx5yaxvHOXoSa?=
 =?us-ascii?Q?WHwkEcTpwIkX7d/CliYAeeB0UmGu/NcZ9yndJgry4ocHja//PX2ukwXyA1ss?=
 =?us-ascii?Q?ilow2l0NC6DaF2m2P/aZsRyEULVL0vCAdp7VnszatvFw2CdUU/KAztoofksb?=
 =?us-ascii?Q?mQp+DkLEiCZHs5hShbW6skp6wW3CiM8yWAyADTYdrq4uECzk32lk5qwF0ZGe?=
 =?us-ascii?Q?t9Yp9FXshRi9tWM+7CnUBFFbE4dZwg6hfFMDiLM1EOGVAXPXJlt+iea/BdYP?=
 =?us-ascii?Q?rIkYpBhww1J+pyD++IRbXYPgHqmdPJGx8i6NZ29dazcGN+B5ryW92pCvouFi?=
 =?us-ascii?Q?7NFpq/bfwuMj58u2Qe8tMe067PuQcPB4782sU04lNe9NCvvzJzOdR9hkYhhy?=
 =?us-ascii?Q?X1gkeAq+BFwn61/4+ZwyJlLsfx/Eh2u+au0yiNanOLd44aI72XvYqBkqPZRz?=
 =?us-ascii?Q?m1Hv5pq0YJFCb4wETk8yDMrHQ9NwPQv1qoBjX6zRMPb39ASzMTOpa8knkWJt?=
 =?us-ascii?Q?LuyjDr65rVTgovMFuYn4YFzW+IcmXR1w23S2zNv3lb8w1GnmpxOaPaR71X0s?=
 =?us-ascii?Q?gsNOXGtWqRsY7Tu9Yh0iiX8lZYfD8Bh8bZVTkWJk2KDPos4FQC8mNDEf8a4Z?=
 =?us-ascii?Q?42oozHE4oZJgbRuGg/feH4o11aiCd+tVDtMUh80I/aXW/HZ6LFAzNMXxTAvL?=
 =?us-ascii?Q?2+++r6HhAvkBN1/0wgeLegkik7bopKfNVbYMxQLuD19pj8IJhSqwWLPAzqTk?=
 =?us-ascii?Q?hLMcLlgCYCH8q1N/oD9XjqESuCjs5/vMmrYKbJ/eF/YGYAYUXTsj0jB4o4Bm?=
 =?us-ascii?Q?HinBTir5XZGQV9TzVzOXDOsF5bvP3FfAypijL35j0jtUA8NMtYoFKGuKCB+J?=
 =?us-ascii?Q?Cc3P4RWjy3huYyf6UblGoN5iRXG/TMYAjAwe/FNJ7LZcW2T6y9Hs0pzjHE7w?=
 =?us-ascii?Q?+DNplxFdvjLfa2jzjRGRN/pWtGAoXb/IkWZi5rbuQJrCzb3lB4+crHhxVcY/?=
 =?us-ascii?Q?nL0pNaF+JiuJE4z0f34JXotSsk1aniApiyhexlj/wXYx6cMAhwqXA7++xaCc?=
 =?us-ascii?Q?3XeD0WBx6IG1aFezZ/DEX4nM/k3B0tEMaG/OOLOGVDSkcUFTxaBO6uiDI4HM?=
 =?us-ascii?Q?KRvcvRSZ7T7TBe7jEz3Y8EtxcInWDc1KnVBp52wfxTbZWK3bU2Ak2udAdfXt?=
 =?us-ascii?Q?Xk2nDNxbb9mpybo1f4HXrOgm5h8ZgBXIVFZclfIZWfvQf3ZFOxZATWtsXjNX?=
 =?us-ascii?Q?lapQupI7Cmb54gRbFt7cTd6zRz43a26hRSWfmA9yUqWiBdO/h0olhhobNetO?=
 =?us-ascii?Q?gbEWr85y047HqgIT3B8NUHj00OPf9a/fUekuPUsXZ3SGDrSfU8QOmPzQxHNW?=
 =?us-ascii?Q?QdIJ3kj2lEnCoNDAAVmJxGLGXTro/9NuM0luTYZ2jpXPwwOnOQsBriYmgl3S?=
 =?us-ascii?Q?0fNvK8Gh8Xn8zzI6ufKkh7e8trnf7mg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab96611f-fd88-4c0a-2be3-08da184b8a06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:03:14.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sTYQjg0M5L/B9STdfaiYgdElJVZu9A5CiauRT0ZT9fEgYgdxC47weod3sLoOW/5HbZ/EgR9kIzsnZ1pf/AiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

v10:
 - patch 5: keep msk->last_snd setting in get_subflow().
 - patch 6: add bpf_mptcp_sched_btf_struct_access().
 - patch 8: use MIN() in sys/param.h, instead of defining a new one.
 - update commit logs.

base-commit: export/20220406T054706

v9:
 - patch 2: add the missing mptcp_sched_init() invoking in
   mptcp_proto_init().
 - patch 5: set last_snd after invoking get_subflow().
 - patch 7: merge the squash-to patch.

v8:
 - use global sched_list instead of pernet sched_list.
 - drop synchronize_rcu() in mptcp_unregister_scheduler().
 - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
   suggested.
 - fix the build break in patch 8.
 - depends on: "add skc_to_mptcp_sock" v14.
 - export/20220325T055307

v7:
 - add bpf_try_module_get in mptcp_init_sched.
 - add bpf_module_put in mptcp_release_sched.
 - rename bpf_first to mptcp_bpf_first.
 - update commit logs.

v6:
 - still use pernet sched_list, use current->nsproxy->net_ns in BPF
   context instead of using init_net.
 - patch 1:
   - use rcu_read_lock instead of spin_lock in mptcp_sched_find as Florian =
suggested.
   - drop synchronize_rcu in sched_exit_net as Florian suggested.
   - keep synchronize_rcu in mptcp_unregister_scheduler, otherwise, got
     a workqueue lockup in my test.
   - update Makefile as Mat suggested.
 - patch 2:
   - add mptcp_sched_data_init to register default sched, instead of
     registering it in init_net.
 - patch 5:
   - move mptcp_sched_get_subflow to protocol.h as Mat suggested.
 - patch 6:
   - use current->nsproxy->net_ns instead of init_net.
 - patch 8:
   - add send_data to send more data, instead of send_byte.

v5:
 - patch 1: define per-namespace sched_list (but only used init_net
   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
   bpf_mptcp_sched_unreg. I need some suggestions here.)
 - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
 - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.

v4:
 - set msk->sched to &mptcp_sched_default when the sched argument is NULL
in mptcp_init_sched().

v3:
 - add mptcp_release_sched helper in patch 4.
 - rename mptcp_set_sched to mptcp_init_sched in patch 4.
 - add mptcp_sched_first_release in patch 7.
 - do some cleanups.

v2:
 - split into more small patches.
 - change all parameters of mptcp_sched_ops from sk to msk:
       void (*init)(struct mptcp_sock *msk);
       void (*release)(struct mptcp_sock *msk);
       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
 - add tests in bpf_tcp_ca.c, instead of adding a new one.

v1:
 - Addressed to the commends in the RFC version.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 129 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  16 ++-
 net/mptcp/protocol.h                          |  16 +++
 net/mptcp/sched.c                             | 104 ++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 ++++
 12 files changed, 456 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

