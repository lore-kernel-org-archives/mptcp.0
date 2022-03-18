Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592615AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WzgBM/GtsOTclHvMd+X834ReFpSG4QLreqn53rXKRdU=;
	b=Kf2NSn1tlwFUubMfCbolLEDSA3ZaV0KVLnLlORlgSQSXtKMRsfL9GWu5kdAgxrpMEVUkHk
	b4IKPUOGwU2QItUwAP4nVuLfuJo1oEiTg8FIDyc0UW+MTw8eCD3M2VJeWACk9tPuT9D7KO
	RqTCY0fVqBUL9EmdJNcyBq5Wfk/+cuY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-TDFrxqWtPj6Caxk__QLJWQ-1; Fri, 18 Mar 2022 03:58:16 +0100
X-MC-Unique: TDFrxqWtPj6Caxk__QLJWQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYEdOumHL3XYXMoTTJk6x/IYFH+cLW9y53Uf3VpyyQgCHq9Ps1cekRGJSooWPCV2B15zDuoBhh6X58D02sosDK8xz65TgAjzshk6mawRYtCefHU/6ppCXshljbDCX28zs+4IRidPCaDaB8DxrBCKQ+Ney3lSFrMBLq78T0kgx4dX0KXNF5IKjohPK25md8PDdFrDelp5L9+e/iPFONSeyO8GLb7b/mykwDF1NsO2/rH8Qd9ivsgvt7RHqgNfSibFO7U25+pjE7B1ofWLVOsl3hM63h2GCIwMXKeaRwsqyi3ozrDRGxXNgzfrLnF6yeeWp3jKiTyjVY1EpCqXuLT7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQmGEuOq8nH2STTOywRxgdwpvA8MAxGygubQm+XZA1A=;
 b=kmo/eugvKDcSjsWh5Fa8HaYiUBJRn9VM9DxiTSoEWXlnFfWqWUwlap3+sDYLo2PtmjqeJI2DMsHDqCfFUmnerGHXtQcXS9kVlpbPTYFhAdSvNXNBxd9FTAY4xymQQChGJgqm49YVhTYKZ107LezgHPct7eviY7FqCl0l+V3f7A/7rN66cpFGA3CfhC37HIiTR5xg6spGdWxBNxVKGcGJuFrRYAnKBMiCiQV0r/G07mJj34RwMG4BiPiuB/yukg+XKFJUx7LVhJzEr9BvcXQpE1K6atymkdIRNDGf4bPjn4cIzOoF/f1Bn2k29QDctMb0GjPqxOTEl4BrPQ3g+DsXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:58:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:58:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/8] BPF packet scheduler
Date: Fri, 18 Mar 2022 10:58:02 +0800
Message-ID: <cover.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d575fb01-a382-4530-b64a-08da088b2597
X-MS-TrafficTypeDiagnostic: AM9PR04MB8321:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB832113E3043354FD45A8C6EEF8139@AM9PR04MB8321.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Np70uxIxbYcRQ8h7uK/6WWu56esq8+cgFEowRhVTHhSBTQPPMTBx8SzqMxOXZjd12Oer9ndcxUyyPdpJW5h42Sr1w2BpZ5Nkgh9ko7X5MHFCu5XwcnmqcxSBH/ntPxm9JCq1J+CALRlVVsZp4mqTT975JykFXF2uSHOmMsU/4QTBb9LIpfmCKnPa6K0+yC4Is5TpGyeIDcw/902jxA3wbxKUAXQKAwJSW6rN9ha2n9vrtExOWqCwNartyNP44CGgprxNdgbXogaK8r6WUJR2x+iAy4MR6T5O/02E3i+yJAdnHFRfv4T5a4zSwsqGHGIo4WXWyoFTuCRwt++IU6XavMFikm/BmiD5fWUrwd/EIzXts3LzYyQI+3Ufz7dyMU88y3/sKyFik4Okswpt3SZfB5C34bC1W84XaWfPQKLeprnsVQTdXRR8O2JIngyQrNeT6PTJ4NGs6xQHj6JTxMAvebt6bdJc8BkihVkZIq8Lj8LWNxHwSBDozmJWJZgobNc8kqf33LXlIMWDT5cqZ0jsOiKwLbLZoFblIM7Fm1Weej8thWKhya06Zkub3QJZrz40jb7VW+QU2FQn9cKcEpEH6SoiFxizDIfGNJxHLawpWTDD8Yqrz46muiS6tFsahntnPhKWXYFYOyGxAwIRdUcRSm+v6mk9s34D/Jt6FL7zzo7zggqKSl5En05iZd62qUGP8YE3yDTqRayeUHa10URDK8QiAdc5iDdWvsVtzewb2qi+2+Eaq6GpbFB5i37DeJwzf5MQIlwlh4nxaQz25ziHCjY8cqlgRImm1AagQrM+XzPkK5+JKj0EfHkNZoNB9wK1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(86362001)(44832011)(6666004)(5660300002)(6512007)(6916009)(36756003)(316002)(2906002)(6506007)(66946007)(6486002)(966005)(4326008)(508600001)(8676002)(8936002)(66556008)(66476007)(186003)(26005)(2616005)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTm5N4z9Y73gyQnDfuxt92lCJOZCOl47ebC2gA9Jz/cF2pmiYRF4/5vkwFh4?=
 =?us-ascii?Q?/gCKuxTBBlGDI/YG71ENv/SqCa386Z3JltbZNQ9lJZoSm7zGeRIVaAOo2DJ7?=
 =?us-ascii?Q?MlN2rm+VJyEmFGoKrKyG9wdUE0Glb2L9uUjQWfgoy+RUbRMrIR7eHYda/rlV?=
 =?us-ascii?Q?IioxKpxA6vtcHqdDutIvox6Bjzl+v9i/nEWEGIi743AGtr2uNgAsA2bvneya?=
 =?us-ascii?Q?bw5STfjtTa3D+xzAOeToXhfPyjcDRNONVS7p5DptAkp6quIeN8JQwF2RqeOb?=
 =?us-ascii?Q?vy38PkxKXn2f7lFLcfDTPELLVpJDWRfUZ1xWhlp66QC/jU5uw6/PuIFJjgqx?=
 =?us-ascii?Q?AvUdcarGb5gSXrSWptMZU2ws2ojad6WyiBJA/aDY4Z7mHHTK6YkADHkAbyd2?=
 =?us-ascii?Q?Uq2FwhadlP5HvXThpKL9LTtbv/Bf2F0ZMblfiGyh+SnxM1Y2dDP2Jh9ZiLNv?=
 =?us-ascii?Q?6Qu1/VM2YDU+43abP3FGyHc+Xcoxt+ZgJ/cEWqQGCrKvsNID/ctza1XjFWXj?=
 =?us-ascii?Q?0uvGXneAviHGu8Q+bjoRxBSDtTHfaZHnC374IkJvFXfYC0o/tFUQlZFaV7e7?=
 =?us-ascii?Q?YOM2K4oZa9MeTFC1CuwEtc/Yrsp+ZWsVODHm0nvEbWjL1rUeducyg+1JXKne?=
 =?us-ascii?Q?exo5C0iQeVvIuIe+fBO4kvZZDR9MnnhxgfC9WJkzEWPj31GTePH4ntkCaomb?=
 =?us-ascii?Q?gprirccy6ptqbfkzN3kjKXUOPOus8ZVd1CxSbztIXCsvkQZJ5WyK9EVPLHI2?=
 =?us-ascii?Q?PHUP0ILZApr29+Nj7FJdN0OElTjwqtJQA7cX953QTzuA2SdSRUahImmY0gn/?=
 =?us-ascii?Q?ZWW2C+GLnUDCdiIHa0/f8zEJbwZUosvSj76/MyHVIAjNJkT5P1L+UuIfk4EG?=
 =?us-ascii?Q?Dl0xFCOauP5so/8HFErM11ha572StT7i3vyeMU8vaYlAHqJTUYSrKPU6YFU3?=
 =?us-ascii?Q?MCy9f1NVFhdtRBZguhorYbbhHTe89AjGbDBc3zevsjOpr7LZ2Zmqy4d1xRvj?=
 =?us-ascii?Q?A5g3PorYyKBrHwP5zB0Y2fKIJREzLNwUK7Ye9UiNtiaiGteqSD+voLN7KqIV?=
 =?us-ascii?Q?abTTOmN52fN13cq76kxckQtvcmUbyPiAT4LD+YMDlHYpqnSg7zJbKVQERTrK?=
 =?us-ascii?Q?L14THYAXoe25PUlKllJCKk8mubocVXq1BDjYQnU/sLFDCkrIxsM+kYjWrzjn?=
 =?us-ascii?Q?qozFchFMWmIWCON/g4nDJsAjwYQCkvR+0JjufdOT43vN2NFbk7TPk7bOpxc6?=
 =?us-ascii?Q?RauKkpX7K+xztQxUJvtbvihnL338TCL8Suixjj5n69GJhxO3QCFmCAtNHEVW?=
 =?us-ascii?Q?sAXDrsiDZbPCzCGeuvQxIIFg5sBQiAguT8vhJ8FjymiO43ZStSuPFie+tnyL?=
 =?us-ascii?Q?eWqILTfn82z6X+Z2BdvoaTo0oGu4ka4/rxfG9FYPT+U2AH6xgCZGnG4u1wkU?=
 =?us-ascii?Q?xQQxelFTn7NiKO1YL9rIS5wSEd5Ak9dCIY3kwJ/LwIFjlULuAvak4Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d575fb01-a382-4530-b64a-08da088b2597
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:58:15.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUW5ExyqYWqaQ1/wlk13w5C4zL8zIsgyCd6OrdMAC/PAlr2l4RrNPpeqwRPeJkqenXoN61hfsS9zxkoYmsD76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

v2:
 - split into more small patches.
 - change all parameters of mptcp_sched_ops from sk to msk:
       void (*init)(struct mptcp_sock *msk);
       void (*release)(struct mptcp_sock *msk);
       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
 - add tests in bpf_tcp_ca.c, instead of adding a new one.

Depends on the bpf patches queued in the patchwork:

c42b1c51caa4 selftests: bpf: add bpf_first test
49747d1d690e selftests: bpf: add bpf_first scheduler
857cc219d855 mptcp: add bpf_mptcp_sched_ops
287b994479ea mptcp: add mptcp_get_subflow wrapper
a626e160359a mptcp: add sched for struct mptcp_sock
7613acc6e70e mptcp: add a new sysctl scheduler
70ff4322bee0 mptcp: register default scheduler
50a302c839de mptcp: add struct mptcp_sched_ops
2b41b6b9a948 selftests: bpf: verify first subflow of mptcp_sock
91e52c32a832 selftests: bpf: verify ca_name of struct mptcp_sock
07a66e354126 Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
168ee1d1a118 selftests: bpf: test bpf_skc_to_mptcp_sock
7a773e6af914 Squash to "selftests: bpf: add MPTCP test base"
a1933407b912 bpf: add bpf_skc_to_mptcp_sock_proto
0095d8ca9a67 Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
2856d8c8020a Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
df0e2a4c394f (origin/export, origin/HEAD) DO-NOT-MERGE: mptcp: enabled by d=
efault

v1:

Addressed to the commends in the RFC version:
https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (8):
  mptcp: add struct mptcp_sched_ops
  mptcp: register default scheduler
  mptcp: add a new sysctl scheduler
  mptcp: add sched for struct mptcp_sock
  mptcp: add mptcp_get_subflow wrapper
  mptcp: add bpf_mptcp_sched_ops
  selftests: bpf: add bpf_first scheduler
  selftests: bpf: add bpf_first test

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/net/mptcp.h                           |  13 +++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 ++++++++++++++++++
 net/mptcp/ctrl.c                              |  14 +++
 net/mptcp/protocol.c                          |  12 ++-
 net/mptcp/protocol.h                          |   9 ++
 net/mptcp/sched.c                             |  89 +++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  42 +++++++-
 tools/testing/selftests/bpf/progs/bpf_first.c |  24 +++++
 12 files changed, 322 insertions(+), 9 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

