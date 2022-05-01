Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD028EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5p+8Fr53oBVzxexImvHhBE+oxFsmuUfylg9ALH6JiE=;
	b=f/ICU56KT+aa4NFdayeveDTycT29eXERRhjgA5K/TZ44nq6GDEupTX/85qCSZHsmGrFxho
	sKOIwrpxu8Hb1+EgvcWVpmajcXaMabIrIdm0P2bE2SrvxIbwQLTTAe4RjMA9kd6qVQPBbJ
	Pi7Hf/lt9Ue9S7s0BIV+cLLsjPyQ4vY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-mXv0f8sPPVufZpUgvyoIsw-1; Sun, 01 May 2022 15:49:04 +0200
X-MC-Unique: mXv0f8sPPVufZpUgvyoIsw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqIjFzFH3QcAJdI6um4MqRY8sW1imbJgpPsDZMTYOnoW3HYl6tciefeJGh+fHYncf6A0jAdH78oJB6WfB4CKxA7DrE8Jic2uEr8Y4XrkHPZ1Ciwc86B2++GQaxnLxrWhl5BECabG4pd2nHMg8ANFycG1gT6hQE52ND8ZJjIemRUwMKjDDIa7gKx8C9euWMt8aV9auh91WeSzBGCKqWOf6uldZbnLfQKzEsOsoPeonxA8s06rIyE1hI0mikUQkKuf9CfiyMxTSi83S1cUCvfLVsqdQLCj733OWSWoQBsw7jnE5+OLw39a3qp4Nl4pxXwz+MtQrB00YSiGAiBu+iYakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4kEhWIXFomhBT27gCn32P82tuNv9HunRkeXKm/rO+0=;
 b=hzeYJ7xRdjTxeu1vzba0SS0EHDUGtRH62R1YWWgswQrkjc5/tELfihTr9/lguHHqlA3DK6mjFVLJk3DmwxVBhIki19yIHfoYQWgulkvalVwCdbtBU/HzFBf+sjbaTEX0m2ORqBtJwO/ssA3zOf0OxcJI+QH5tED6tuviZkFP4KqusE0IcN4rFLWa34nhE0je9Ki1chDcLN+dZ0L8xPV2T/sCo3DsvHe14CsSoJKXi5SU1y6oKV3S3e9O2HkYdSXFkzUZsLqOyZQ+oUPuuetvhioPahdOXNe42jZA014F46nYOe6RlRUnxAVlic755TpPQV0/2LYCJ92tkJmPAMztEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 0/7] BPF packet scheduler
Date: Sun,  1 May 2022 21:48:43 +0800
Message-ID: <cover.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a883f7e9-1b8f-45b7-a2d7-08da2b79595d
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB62838E07CBAB91A2125AEE53F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/UoHqGCHEdj0n5Rbaq6MydDChSpaqBE+xsdKGOd6j8dmQd7y/C8GWRs7LnzWtKvHmdeu+i+91QPH+Y/jM8BN8yf+kn/YYSYJDVAyWaj890m6YIouruQq/STs56PqRESoTuTfSxdn06tdJb0iZA3W1C4oaHXqdE7NAm2HQK2hoTyKewIlSybVjckB6g7EqheVupGSDGw/1RpfHwrpvG4crIv4U8PlZTCuS1K1ecGEOG/mdtc6G51j7kdZTcSUQZch/wtEgzZSe7LpzXuk/JQr8PoGNubwzWzlhd/qtCX6TAFModm2ybMl598za3uhwwcxmliFeon4GW/sGnCWOBprozBmCAO3DuhRT4nFqLbftlxw+Y1jZnK27RUg4FJ4/WnkujlWxocGC2xIeqpXWhgba56u3Rx0YL1RiyxRbrLXYdH0js5V1YjmGmUADJCgY94f4tVwX2XoNiaKYJKba9XkifvIlBvq/Cu4WR0d+pKdR6oj9okTQcBaOE1K7WEwrItD3gKfeMm422YZO8Tvihv0ecRnZiXRBbeaAu+R0LuJ9T5G2Z6WB2Bxe1x+8iTll3HW6LY+QJIU1loYFosUrl1S2fOgSsISLCem7JwnOnST54+SDEEmUuaZ7DueUJkg2hJrH56kT8u7f7weuIDV6JdwdfIN84HQ5KRW9jz4w3Tt2eyJMgUL19j5Ijyr2J65i/hKYdtubEVqe1/rFMqFj6BDnpPrgV43WqE6OufCblMPz/eEFQZ0+H/QvbAxjpv72kUaUYxE6tOgPIQ/I7NTNqEFoZ+qQD9K0YYcSLLi/haKMkcHYGH+EXRNTsOUWCXFddwD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(966005)(36756003)(6486002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gnijQYsDFmevDOqh+62fdv0D9BLWO+ulTmrXcnUcHLXsIzeu+wCNSSkHTpmN?=
 =?us-ascii?Q?RU6xoGqspUOGWG2fbmrTWwaNijL+j/pMNCjs2xLrpmam4GHm5umMw/5yqXmU?=
 =?us-ascii?Q?2L8eMPt5XX/81XrhPzaIf+ukitNIeTZK+qlTRNdpqIOFIuvJmsWIyufjCUi8?=
 =?us-ascii?Q?/8i/jDe1tOLpcQj/OmXmIqCVlXXrFPged4FXiR8SJ0wmHQdU+4DF5HmFJoyU?=
 =?us-ascii?Q?8uz1dKF5S4GQ0TL9cQOnmWFm/k7T1nnsoHws1LJMeDshZu+zlrUL6upixgj3?=
 =?us-ascii?Q?B5JK1IlZxzfYIsqF60b2HyTKM2xJsjOf9nv+BUXlo8h3t7FGUL3b9my3/W8g?=
 =?us-ascii?Q?1PQRUYx62b+/Ak0qlxZkimBB45pG4hS5caqM0VHwytDsMvL+XgQa17xlehG2?=
 =?us-ascii?Q?wECEshdu1aiNZFx6oz3UE/KLLRdsulpHQp9Bz8IEbtaiU9bKSuCZWcDamZQt?=
 =?us-ascii?Q?z+UsJrGoSI0EjA1okpexa21F9HD9Ksv9NYNVOtQFjvbM0WunqislWV6qI1oJ?=
 =?us-ascii?Q?T7p/nFBoWR6Y5najtG6PcCJoKkzoD7IKtdUmiebleY16fak1aZA7WV5vdXpI?=
 =?us-ascii?Q?UHXu5IQSR2H/SLjEp4HgtKBbPKwWSX+AaPvPb+0aG+ASJU5MbyEofKKOMKRY?=
 =?us-ascii?Q?80BFuZOITLXFF7iCxrEz5XJJLwOJS8LfzoALyMtmPUUoi5i0ZBPwuba2lFN+?=
 =?us-ascii?Q?RKvS7MIVrjD9PwmiQeB4ivFuY6DBk04FU7Adb8GI6FXo1JGXcH8Bi6XEAOvT?=
 =?us-ascii?Q?xqzQFhU4l//qtzsYysgnviH0dqvHgQaoJzDSJwhE1SGPs1gfxTG2AM7cb4Uf?=
 =?us-ascii?Q?D1HJH+UdhWUGbZIfpj7ugPG3drftNdm3E0+pyh8ihnsKI/dYvsIViCIsprie?=
 =?us-ascii?Q?b3rBl1GQw76fKnYBaTAIcr/6PkEYpoh6xle7gQCzjtKxOYrlFcNTEH079QVN?=
 =?us-ascii?Q?5ReHmqVqIicRqYrtc/JSDvWf0fy2JjY30I4HEjM1h8WG/bTQ0pXNu3EQItO/?=
 =?us-ascii?Q?S8c0yG909fKo+goWpuNIevF46g8X/8hyNs+TIZHARuuO8AWVtyy9M9DqIMsN?=
 =?us-ascii?Q?lAIoW8cOpH01bqbmO2qzKkMfEGX+gtzSYucnBlwMQPXSIlWL4bwxi4P06Scn?=
 =?us-ascii?Q?rXMs8+szHJO4JgcZFjKr47FRnFO9tp9NRhvJFZbH0MULSxmJ6DBm1k21ooG0?=
 =?us-ascii?Q?z+BGuFH0W0qBrrFYocnaWjk45VKK9vMVhafUdzxLFQqk4qZj+SmKB1iC64RE?=
 =?us-ascii?Q?a0r6iaFvLhp8IGqWdTLU7HqyiLi3dxF1FKuAahzXXCYR5R+dzL08pG7NVQrv?=
 =?us-ascii?Q?qxiy5GQGNnJW4p+RlStxzA40pZmE417veaS68OEjC8bENvm54MoQu/evZNJX?=
 =?us-ascii?Q?mhlWgaUc6Au6rbrDWM1UCf+LIiIjojU3+Ut/N1xUWOyGr7+2lgkKz2CNZ6FV?=
 =?us-ascii?Q?+z8Cmup/gpU0MdayyUsIcXQpK8ek1OaB3nJDw6la4sqhbhP/aHJf2LQmVtX9?=
 =?us-ascii?Q?Ih1qgSAVZJ8/2hZKXNLA8jSdm5WtlGfdtCQgbXxrmfp2xqcPUzRHZNZzjgSW?=
 =?us-ascii?Q?LxlCpJft+lMntEOkhW34FKT38ATzOUzzt30uyh+kDY3gFpUQ6DvoCS9rQZob?=
 =?us-ascii?Q?vCtoyV7RvWqMtd12jPTl9bMgCjjzaBlDHjwFC/YACePxffjQdItMLnB/gIlu?=
 =?us-ascii?Q?rTjbapynNIx02VYxliBe8hfjd3l6/2vMamgH6PqzudQ8/AUtHhXNf/dc5ghw?=
 =?us-ascii?Q?fFQvqht6YXOWfegABBAlAqbIYbR81cg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a883f7e9-1b8f-45b7-a2d7-08da2b79595d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:01.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6lLVGfbKHYASkQ817CPK/zE+ocJhzZn90IlMbos3j7wulqpJbtaRwyF34LsMAec2+6MgmOCepaZnT0f+V0vcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

v18:
 - drop "mptcp: add last_snd write access".
 - add mptcp_sched_data_init helper.
 - move mptcp_sched_get_send() and mptcp_sched_get_retrans() into sched.c.

v17:
 - drop "mptcp: register default scheduler"
 - add back "mptcp: add last_snd write access"
 - update "mptcp: add get_subflow wrappers" as Paolo suggested.
 - fix the issue reported-by kernel test robot <lkp@intel.com> in [1].

[1]
https://patchwork.kernel.org/project/mptcp/patch/8ac278434203662add804d00e0=
07c2cb2b6f52e4.1651024344.git.geliang.tang@suse.com/

v16:
 - add CONFIG_BPF_JIT check around the scheduler code inside bpf.c
 - depends on export/20220426T102605 +
	      Squash to "bpf: add bpf_skc_to_mptcp_sock_proto" +
              Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
              Squash to "selftests: bpf: add MPTCP test base"

v15:
 - set mptcp_sched_id and mptcp_sched_type in bpf_mptcp_sched_init().
 - add CONFIG_BPF_JIT in patch 6.
 - drop '#include <sys/param.h>' in patch 8.
 - depends on export/20220426T102605 +
	      Squash to "bpf: add bpf_skc_to_mptcp_sock_proto" +
              Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"

v14:
 - add struct mptcp_sched_data.

base-commit: export/20220422T060337

v13:
 - rename retrans to reinject
 - drop "add last_snd write access" patch
 - change %lu to %zu to fix the build break on i386.

base-commit: export/20220420T152103

v12:
 - add call_me_again flag.

base-commit: export/20220419T055400

v11:
 - add retrans argment for get_subflow()

base-commit: export/20220408T100826

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

Geliang Tang (7):
  mptcp: add struct mptcp_sched_ops
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrappers
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  19 +++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 154 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  32 ++--
 net/mptcp/protocol.h                          |  10 ++
 net/mptcp/sched.c                             | 143 ++++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  19 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 +++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++++
 12 files changed, 529 insertions(+), 20 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

