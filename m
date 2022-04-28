Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086B7B
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 05:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651123406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l3EI0SLyBoX1yZFOR03xMwdS+rWkv0mkUdgMS/g4wXE=;
	b=Pr93ns80+QdA/gjYwlyZPMZGz8aGC8W83Wz8TLo6lmzRsf3emiZrPv0p0HgsLhUZtM8w3L
	ld6qpRIBBhfV1MED9mK+UTm+TSPuDW9ZpLOEg6Ncd+dQFSmEe69dkvyxnXnrVXYh2YUrli
	QZofIhcYzawi1487v0aRSNZttLcQXuo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-0-3cLwvZMoOBkcSFKLwI5Q-1; Thu, 28 Apr 2022 07:23:25 +0200
X-MC-Unique: 0-3cLwvZMoOBkcSFKLwI5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyHyWyLeaiYCP4NjzZsUfqHefJ9rDMPwmHAAIDYAc0BtN5vNDw+eVg8dOWtuLX8T36ZrTxyMIi4gP8yG8DOuJy6N8TsiuzbLCVmxluUJmNwpBcEtjMzLFSUxIzln8oli3Ptm9HU6UR9a/w8AFpDW8dCRwXFeQ/zBih7gGq1unNbLve+GkITaqp9o+B/lSedtMyybJnSuTFHG9GxT+1MVyplJerqZ5K51Xuk1s0ph0U3z9D6my6damFDNsh7eyAQtYkn/+hS+iDWiTw2hI9YWaBRlK+N3adHdOL3jytrUpFt66OdXOJZwYW5OneCQ++jIMitZ11a4JhFw0vk5JBZlSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5QoJHCWEHZOTNMBhyvmTvvf98sII/SUzc2r5xKATQo=;
 b=lG+e9/1ntaUPAbZDz3TmSO5XGLO+G14gFecNulZMOC59rtYpma3RRTr/Jot//K4Kupri0SjYSkvFpP9sswa4wpv5F8vQNsrlWn0A9ast11O74bsN/yvZFW7LwT2a+NHsRgso2EydD9T5bMy0peMraATbmMYz6R2U+gJHQ74IE5AqyTLfmhZLBVyZz/Do/Qute5+pczfjugpda6GkRIEGbPHgFHgYVJHW5hkqmCtL4KmTakSNSi4q2QCFeXradkPAgbMkNblnRQccUETtvSFacQGh6SGI+PUReEF9hQBFgUoY5lfI3T5E0fd03sLFtvjZZj2R93LiZFyUfIb0QPO82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5653.eurprd04.prod.outlook.com (2603:10a6:20b:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 05:23:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:23:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 0/8] BPF packet scheduler
Date: Thu, 28 Apr 2022 13:23:27 +0800
Message-ID: <cover.1651123078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6474542-7507-422a-42b5-08da28d73507
X-MS-TrafficTypeDiagnostic: AM6PR04MB5653:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5653DEC262F5F42BEE812BB5F8FD9@AM6PR04MB5653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aRkd0z0OiLDv1jhWU5oaN65Q3gSTxPWZrc2JeJeesIQah1mshQaIx1Wq7iu4xK97EaUWtZq4SruXIdlnhUSjmUkLmNR2XkEmhUgaPGurIUm6I/nBS3C0yQh6jvIBJmx4+nAZMjvGM90DXu+0KDTDJNxJoAfeuY8A1Vx/tWBYp4ZUPloQIIlsOjZN4OZpIQt9v0uOE7hwmweCfZLRDSXkrAEot94xWzPz6rgR+ubl57XKyuwkel+jUWD63h5/aMWEA/yPv5DktSiKQjlgQzmIda2lmgxhp93BVbhp26/HGzB1QqynReeDa05hh9tLZhEzqQiRhKYCuqdtUyasxGg7mPsKX6iMHEYBJZalErN4GPpXm9G76RNHeciAx3Q/uaQIGjXt7D7caRz763BiPOsD88gamkWjMTt6N1+KUp6h/auKBsBx+7ZuX2s5KLDNoh7aOc6tYz9npROpaaPdR1h3CNgPk8dTzLi9N9bC1muUsEM9HWRfEx8vTeaiAlq5JIY9gyALgWe3TLa3CamaiNKOSToMxAcJHGQDun0t+RN55yTQgDVK7vCA+OpBtwOFND9rKGD1crAHqYcTzUzUhvbXLvC6/7H6RGQuHiSXJ/Uyb0eUHS6/K35k5c36reSCGXQtWKO7lee6c24Gz3aUfJB8ZxFwil4B9c7Kj8UvksS4iu5tt+fkiicnORu1ElUhdN/jcaoL5xaw348pv+3+VC9FEfTXloIgjBrdZyN2Hk4+3INpqyBB1M279LSXhnW0x55ltIZuzezF0p/rIJAmSgij4nDmh9U25hJBrmZEZXE6xzVdRlbgNfl7IymEIZXSBNTq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8676002)(66556008)(4326008)(66946007)(66476007)(6506007)(38100700002)(5660300002)(86362001)(44832011)(966005)(8936002)(508600001)(2616005)(83380400001)(26005)(6512007)(6486002)(6916009)(107886003)(316002)(36756003)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wPJ+t8tJFpSf6qzClcElD9wZVPujVi7A74bR0ZSkGlt3pMX8mHd6+FtN4tcI?=
 =?us-ascii?Q?K2yC1G3N9Qq8lUpuUjAKvlBE7De8M00Xr1SPr5u4yFj+YzV70Fk+QHBfbT5v?=
 =?us-ascii?Q?YxEbYWyslKOffa0iMKlIzR94g2npfQam5UG2UQCrYwqtPMGzDEz8yeAfABT4?=
 =?us-ascii?Q?REkqjZwgdt8oLBBulCdWr4ps9w+72hsVmmk5NmuRFDuFKGbsoSLv/vtgZo/M?=
 =?us-ascii?Q?7uQIO8XSUguiRAOzMMqpPKOLVpXzM4l/tZqHeqOwm6VZvouZMpBImoWMjAHU?=
 =?us-ascii?Q?k5aSSO+6jFDZ/8Pc6S8Hzn4lbiMPpb5nkZBBkq36KPCIC7bx8Fb2SAga9Vbs?=
 =?us-ascii?Q?/3DDJ6GXAx1gQAJaFLf5RMd5YGx3mobMKbX5dfYj23boQn38UNo19w8ZsxXa?=
 =?us-ascii?Q?lhpALieFpp9/n6IdqHWBvYXIUZBIMwfpDCd+wxzr97HKMIePrT+18alyXmfr?=
 =?us-ascii?Q?KQUUzCJKjjE0SVYS8n0N/CWTRDqfhOEjq1u+ERW1Zg4wBC6y22eFB9ph1zZn?=
 =?us-ascii?Q?CwCdQoUNG/Lre2FUxYtdMp2DqyAlRzj8DKJknoB/aNXxuR5zkshP/HoMiiYh?=
 =?us-ascii?Q?f0+1flQSPaXS1uHRstMmzdrNCf/NV3POmY7M2jjpuw1oTyAsMtjQsPDX0jIB?=
 =?us-ascii?Q?nKs5Ch0exnTjvFL7ePWuoM0VVraGQHufz7XLC9xh74Am1IEwRht3ZOJ2vw80?=
 =?us-ascii?Q?knsUviTYsakQgp17En4btKg10zV3iZP3J3SL6PRWQXUBrLy2iq1baHEA6PBr?=
 =?us-ascii?Q?fBM3huoMARIaOD7IFDApYsFsEn3WQt+FbsSt6L5QdC/qGc+8SB4H42mnKyAY?=
 =?us-ascii?Q?/V5KjmLoCloQd+I9PiHOl01dwtndtLmPzznkWTS5GRINGPupLmUo/W/fxK2X?=
 =?us-ascii?Q?dW+en7UtWyfvMic9bd/teqOHD+QTmK9NUIUNIKNcsJNB8rucGcB3s3C+ETP7?=
 =?us-ascii?Q?ygNjgTogGVY7gICbj3Z7kchdPEO3HyxZz6kiXymuwJNqkfHQIStyeQbJhmFg?=
 =?us-ascii?Q?ZhZCD0oWqAQ/rg5D3J02AoDuT4TOB/UOYP0Fway5LCAEHjWCKdox852vB6DL?=
 =?us-ascii?Q?ZX4LCqoyaAzY8kF2hqOHOQsFvRgRmZZsNX6LPaFMIs63e6J7F4bqn3lj19kU?=
 =?us-ascii?Q?qlsXrt3T8M2vNer7TA9848/PR1J8jkuhAFEbMI/6YRsLfqV0vG6QghhMuQCK?=
 =?us-ascii?Q?Jf5Z0OUSdlRFpRmc1mQn2UtzSj8iucY+1GuX4ePDOsKVwPj7wu5dxdMOsKls?=
 =?us-ascii?Q?On7ARsWPLbX5k3nEUQoldofKO3X4AFOtIgmg+cdc7yWF3Ld7+dMb5OsJS30D?=
 =?us-ascii?Q?18QEOfazHIljj8XZz0CFkOk4OqWskZygzPdd0pkvwHjN5yY7vpoGA416Mpfl?=
 =?us-ascii?Q?CmXO8xSG2YvtJAd7gLQHCtnYJ/uJH4VEfog1VbdL9qJVBSheHEC+hKJMkckt?=
 =?us-ascii?Q?gX8O5zGCcpQ3yJ/2YsglRLXasqRXP+NvVISOk2jLcvrKJHIiTEKmF+FnAVxk?=
 =?us-ascii?Q?JjhKsFXvkcomOGRIe1gC1LJyNsS1B598Z2gBmJErSHpD9WClbke1ctKMFhIT?=
 =?us-ascii?Q?4d++2gBrSuwnByneWeVqmfjzxHTllapo/pFlsv66F/t+wXl9gR/7gt+QZf+Q?=
 =?us-ascii?Q?Dgq1LZbcwJBzPihg9ZnYuOQjCv//yojtCCdR/8smnBgdqztIll+TgFyIZEZW?=
 =?us-ascii?Q?0NxRQwrR/L+/TOXSOe3YmbLbiPlLYWY+TvyZj76mr9NXY42SImqhiI3cs5Oe?=
 =?us-ascii?Q?UX2Xu1T6OTsEu1vTlR4sY66Jaan8edE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6474542-7507-422a-42b5-08da28d73507
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:23:20.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s87AeR9AMVZRELpKJPIfjtCtordZDHq2nBIpVCfmjGMa3OenojYIBtZrxlhE82++46KOZByY9HYWPhXOo+CR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5653

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

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrappers
  mptcp: add bpf_mptcp_sched_ops
  mptcp: add last_snd write access
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  19 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 163 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  32 ++--
 net/mptcp/protocol.h                          |  50 ++++++
 net/mptcp/sched.c                             |  89 ++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  20 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 ++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  35 ++++
 12 files changed, 528 insertions(+), 20 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

