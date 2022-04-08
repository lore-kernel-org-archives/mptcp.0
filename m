Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7B2564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E8m84gtbDSDGplpbnda/XnKImKdpkLdu/RiS2oyN2o4=;
	b=RE4js/PU2oSu6klr3beY56XanO6qZIS+v2G8ntAvEW1Ij65Tsa9bFRm3JwPTh4LIYtQ2xg
	FG4sNY/sq2PVhyKrE8TW5xe7zP5DWGesPQ5KReHBJdl5RRSwwxhg3jGsNKqfLVabEdpt6X
	AXo2kcO3Ne0OiZ8Pp15+pWqHiBiB28s=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-FBf8MdKYNzK8n7SIpmvXcA-1; Fri, 08 Apr 2022 17:38:04 +0200
X-MC-Unique: FBf8MdKYNzK8n7SIpmvXcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+IMPOlz/y4ohqVRjmlP/miyc2Kbefo/QAAqLLqdOZh93PhwmOJsh5KbPQQckwVJaQotKActCB5j1Wn3SaPRu+lZqzzkeNDkxtf5PYlG8TOgzAbkCjR6ZRbT74qunai3UA0dNSvg5bE+fpMKUXEENXMjsgYTt0UDA82sDawhiJYHS1Gl1u7mwwUuGlTu+5QdZ781JcF9ZYbNYxTAdQb3i1q2SKBTR0iXLeBLORYlbwtDBDx7/PM158WxnCItzhmRt/OK5gYTFSvQSQFFQtUv0OkOz5E7Fu3lTICtJxKH3UceMd/4eyl4h+p20q+yPthkF8Gt+bffN0cueudwVPYlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+8R7YY9HIXwa6TFETA9q8aeEvpAi4dMBBMLSzCffNU=;
 b=YYvABEkB6emgwIZWRZIHyXBSkbq56GuWkPibTJrJoOAZH61Jn2WwDx7F8rHBWKv+UixakPE8cL14xq/HQFWt0a0GJ5bDKAJVRqk2A62k3RndWSwduFfjdp/snAhcaKInO3cDZ8Ks/j4Hfna+O//FVdhKlVD+zLrcgqkSq4PoivMv9jH5BvWnKVO7qA43RZrfulLC7HANkLcKlY20N/HNjphVI5jvqkNjcNBs60C719uTDvVcedPjEbxvxcI+gvO9dmTIw5E+2+49lnAjvfS7UqUVengfChK48qFFzSam0bq+G58WQRp0/xei5hskuq+O2NeKU8qRPRYlODLvLuPvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2995.eurprd04.prod.outlook.com (2603:10a6:206:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 15:38:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:38:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 0/8] BPF packet scheduler
Date: Fri,  8 Apr 2022 23:37:57 +0800
Message-ID: <cover.1649432004.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4f8bf1-f89a-4d9b-18ba-08da1975c438
X-MS-TrafficTypeDiagnostic: AM5PR04MB2995:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2995F3FB26606771CFF37423F8E99@AM5PR04MB2995.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tmnAkunqw6gsrIFMB8ZYUqSKO5xcb6PKtekrLeOan/c0OtU+j3lzGyphuBUhGc8e/pFclN/SdDSMUbG0wa7kwJIzVVHjcqf3EQPBMDNs1njaNhivpueZCqYm3el3Ua6izoLTdZY+Nsm8rkMRaIhb6W8yit1bPvAmnJmO0HGw/VLd72TkSD3gvtZDS59/yO/2UntshTPG6cgrXOMLIdYstLtB1MYNE6NfZSc0gQ6Svc0XQMbrAKx9ga6x9B3pToBsKNCoUMARWAvvwWPUWA5dbxC/H4jnCxkkoXSyiAaA5VdbiPY8w1vH5AeJUuIdtN0voZ8FGmfF6O9lfhqBnURuf9dicaSTgCd6pSXJqHxbKeK4ZrinQm0+mGKobYgZuSE0M9sUYsH0XvJ30DQUMRTywOWLnFsDbESPSlFL6kA+tYW9lJJiLCrHV1aMGjp7BdiNfB9vQvGfcVwZHMZguMukEJlVAwYmbpDEtgHcAu9dDnITt/fGTTXXfPAfK3W46rnjVK3fHZU4k1+ks+do9dH6qyQsHCLIPWB+7F3bAEoq6Q/ndNUnU2J6+H9PB9//7q1Rm73Gsbpq/5cx7GWMuKa39GhyiLlbDuZqaMKK206/0cCcENAMdc6QCueXPcghqkAvgfPJql/dbO71bAcEgfH3FL3gqDTj3Quy0tiPFJwcV5AsS1XutPqkloPEQ5Gp9+iK6vrpyhAHLwoKL4n32HkUM2YmsNLKlcnDfbE8dSPpSoN8a2LibneoRfwt5AgeXQ1D40MnkztnDO5AmcJxR8yIGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(2906002)(4326008)(5660300002)(44832011)(316002)(186003)(86362001)(26005)(508600001)(8676002)(107886003)(6506007)(2616005)(66946007)(83380400001)(66476007)(6486002)(36756003)(6512007)(966005)(6666004)(6916009)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vz9x1q4cvhkdFHwr64hBx76hzJqLnJcBTrUVnP73cTdQvlZwN0ZeC68Vx+Cl?=
 =?us-ascii?Q?SNlaKm4dcBU4jeP3DhgLa4VKOMJKj09mekD8touqRMiZCIYTjr8xKN+rJMPt?=
 =?us-ascii?Q?k9mW6r0xH/lhGy4KOmPFXvu1hfWOTM6qTs3WXyDBWyd452+ChyGx8xlOemMX?=
 =?us-ascii?Q?N8kcAbiG/LMpgqLOCUYni+stgaPVXvIxy1wTOy3QgugxUrTkmCPwu+TNrd58?=
 =?us-ascii?Q?psx0Brje4Z0zWge3kBBwwhnK92s2bDFoKa2ByLZfBWz7irGfezfSx/UnXs0u?=
 =?us-ascii?Q?stGCVk67Qfbwr6eMPJyl/QSCY6z+Y+ChPYvDgSnol15uU+CemWTSubrdxRPD?=
 =?us-ascii?Q?Q4tPChKmh7Xtwjx2qo16DqstGCCD69apqopnIUyfeYCoQTOfCIln6j8iDM38?=
 =?us-ascii?Q?rOqUvzmx4i9p1s3KIW4Fg5rwiGS/6XZa+07tSgAEc4TJws18Rfm5O9pb8Xxt?=
 =?us-ascii?Q?iX16WdeyPm1vBveOo2imWyKSU+CLlZzbPmdUG17EI1ht/0X5yKmHNfgi8oBb?=
 =?us-ascii?Q?GI0KfKFjc3LwqVyMWnHoysK56tKxsiqu5wd6MVOIywpBqjduPF/MBhLe5C1g?=
 =?us-ascii?Q?aBEPQcjJJt+7t3vHEJsmPrCox13edMO0MPE7BEXZ9g6wGOmsch0JI7h+Eo42?=
 =?us-ascii?Q?Xdf2yIRyfzW7+kWjl0Exfm8TlkwCWt39v/0JcIqn+bRWEmzGLIolJ9Xm2IwS?=
 =?us-ascii?Q?bosl5u2fw6Wjnr+DBcR8QzrNGcktgm9DJ6epzqadPunjG76AawDfqRw77jAe?=
 =?us-ascii?Q?SNDbnqak/kYSd51vgNjVw6do4EK8dGzkGp7pyPPNoDMqoEgNJLhf9T9Ng1aC?=
 =?us-ascii?Q?MCGEKwhxAfO0BCjNJpn4KNykKfws6nyTbLiv/5dCWdcavyHN0okIJuMlgoBA?=
 =?us-ascii?Q?jmR9xW2AIsF2Wfpi8dPX2twbXMZ8S7HoI3vGQwFngx1JY7VPUwbkNq29wiTQ?=
 =?us-ascii?Q?Tdll6gzxlLkY69cJWwdMuq4XTWmMp/MoZgeuwjQ8oKE8KmWRI4jU+tgyQ3iM?=
 =?us-ascii?Q?6ILM8A6qt0bX5yV+JaWscTeoxb7ccDJi2+S4Jbm2Qfb3MGYWFpmX/WV7DqQZ?=
 =?us-ascii?Q?ciOMz60gmsOaxYwImBb65bVRyXMeIRcGsHN/rhmO3HmfO5LyWPOBKeF4NV8n?=
 =?us-ascii?Q?t5WiRgLTUhOF66nDrdmnYG1MgrNhoy27HiqO1M2TevqV4s1wDPiPs0gRzA74?=
 =?us-ascii?Q?e2RmifySq8QPW/4cgPXupc5aLlVI3eqUD5YQcpKyd5jeBTZNueNTu4IJ6EEg?=
 =?us-ascii?Q?Z9bXW/5f5RzPj6T6CjWu5hZXOUyJSC1T8fe/4nN82AZjcDrIJs/V10N8YGxj?=
 =?us-ascii?Q?qmqMy+ydWewYbYXjYKqtM4BZZqhOUzAOzFOefoSmbcPG2GFNaUwi9bol5hVv?=
 =?us-ascii?Q?QnOPKg/QVE3udyydMv8Y/YE7sO8TySifmgPuYsi358MdR2u6hEeFtpYZ6NLK?=
 =?us-ascii?Q?ERPTgdrYjYghcy+PGyKza5BGYYK9EQSgrv1fpbDsq5Ct8W4LLjgAdpYJsFHg?=
 =?us-ascii?Q?bqj6iJs81d32E0fq2NIBSVWz+jt89cEgnsC0Um4CL+YAMBT6VhzgyXfmXdqh?=
 =?us-ascii?Q?0IqYHn4WBd6oIgMRAZZCLaKmT0Kl8ZXTNIzdgvjPNaia/oGWLNK6kgapp36A?=
 =?us-ascii?Q?lwvfztp6LgxXGTo+TLtaR0ffMn1oI1FAQ3JevgwFh+5ohzIpcPO+i736yjRx?=
 =?us-ascii?Q?vZjtOKNOn7vccS8tQlhRZJ48/pMPYv1nNwMEX8chaqwlhzwMGBuUT4ueCF9A?=
 =?us-ascii?Q?wY3VpXlRpg/YzbMGud5Y4QpsV99HLf4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4f8bf1-f89a-4d9b-18ba-08da1975c438
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:38:02.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q05YRDI0l0ofoJQUOa4NtwjhV8mBnsqvUOOmXo+L5DWvW5NYt4sArEdE7cYMxVRIJNYjdNNgACOFWPgntCEoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2995

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
 net/mptcp/protocol.c                          |  24 +++-
 net/mptcp/protocol.h                          |  16 +++
 net/mptcp/sched.c                             | 104 ++++++++++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 +++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 ++++
 12 files changed, 464 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

--=20
2.34.1

