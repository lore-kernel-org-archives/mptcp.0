Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D351FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648130947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5UxgG1/lOIlEhz7SHh216+MYH3LuRdsBFAtdqZqsNgg=;
	b=nAP2h3soa/PKF9feVvxk7cUklE1BkYcywyashBuDzWTd2/gCJDPDl4weO1xhDLBHiWnk4r
	NQFCZdnRMMnXnhCWG2Xz8mEGeCyZ3Ydn4xQZK7YeITStYlowR6w5hqcHYXquiwpYNDK2sX
	aRLEqFTz59rry+TW2cBg48EOZk2hXjQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-f83PmDi5PMm_pJEIMd5cQQ-1; Thu, 24 Mar 2022 15:09:06 +0100
X-MC-Unique: f83PmDi5PMm_pJEIMd5cQQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJrUmCZM3ILIgXEjJntY+CwdEnSuOxnUiTuv0ZxCz287+dOy6KNZFWVZcAxsXPXdxgR1omkSjRTaVGpBjGG7makYNoUbiCAeJpUcX3ta29dpMzn6FX6kudwvPo3cBudnkZhEz/WMoXDwOCsEQeRc57S7BNLE0rBQ3UsxNUOW7j5FGqtIxDGa/oVYmTBTmU7rcsqpieCTUBTo+OeEJgzqJp2M17yM5U6/y+NlOvtQTmsziN038ynFGtbHO7cNKbnYhn9MrIITRL2S5flNAQ4k6JmgQE3mHiexO3J2iAbeHpNR12vBha2hyiMv7GzdI0ib1PeEKeANTXzgtyTu0RZ2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKhIrectgoljeTkiY868IiPcTBROGSrbI6hx5DzOJXY=;
 b=R2fdQk7ix6zsZh5KxuahrzckmAizrTv1d+bEzLgl5tfZjeVHjrLR9z7rcNHNsUrlAN+FBNnAFPRFpim0cu9XUVFJEPV3omNVgKjmvLCCFnbb4qypVK6lg1LiY11QWkYdiAOjDaQUegpOPknaSP6EkHtJUSgQNjBugy1bx342mZ4ZnKkWb2J4uy5bKesvX7ntd3ZVHHwP3SBKBnxjplappFHfBHcC5Oiqx9P1GDqnMxsmQGtYNPM/NmlXdciOWcEexpzziCR7jnpL0h04V3BzPqAfD0ReOacWxPO5ARKtDd844T/Vl+8irZLOpdH0lX+XOfLh0SySGnMqKuNso004UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3616.eurprd04.prod.outlook.com (2603:10a6:803:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 14:09:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:09:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 0/8] BPF packet scheduler
Date: Thu, 24 Mar 2022 22:09:02 +0800
Message-ID: <cover.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5413ab6-b85c-4704-8324-08da0d9fdb05
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB36161EF60C607BFDAF1AC43EF8199@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LzWVlRx71y8ms3Z8LcpT+lOlpxaXsSGtVcqdGguN13FaTQ6PwfNN2K7H4q+6nNGEJjTD/fxO/nqJN9IYprmULZ6I04QDd7ja55Yetttjix4l94CV/WxLfJUC1pBIVNslwN92ZcdjsJCyOWdVYc92cQhXohFT4uX0t8fwl9bKTmX2JFPVXW675l3pfte1DoXj+3sZmJg+Z8tOh5KjUGOmryHhpri6B7VV6SRkTTAR15SfJnNf/nBqQvh5mAsFDTe6fQxxqwbpnlZrCrkgPxDK2LpogoBHOzxVceL5kb0W1jrLbFsLrUtsGk/u5CmFKUXtPSWaRQtwzEBIUJ0Ag/3ac2uSVPk7liY9qP9QDAqas0rOGukBARJ5Zis54PdunOP5CPS2jF8EkefqP5QoaQASJJRKfUIoJ8Et0cKIz8sVxUdbpfsZ/hR8wFbla4fDuGEDU28McXtnFrxoykix9m7fAfAwOr6ueTwKDq3vExZOm8xQqgsOm5Pjjmzgk8ZIWcdvij6YEZflTmw3804MwOnmt0570pVqfF0+vmqdUxS72+dif5/whvETpOVdWqpWPBwAx6FTicVFsM7oHw7OKE8M55RPwgyxT/YXXPGCf14CPQ8rM569AIeZqo4fee9+FYcfsjztjMxWTiPa+FIXpYtNY5Zxe3lDcp2kBmk8966k6IkygchoO7m/csvA9RQeG7cFaucUz+3cW2Z2YeM+M1GATEnyuhotupaPc5sDn8jYXCShsrb9k4ir9dUtc2WX+GNA9BZXNxm6HP7Vpl7fY1KG4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(966005)(6506007)(6512007)(2906002)(8936002)(6666004)(5660300002)(38100700002)(44832011)(186003)(107886003)(2616005)(86362001)(26005)(6916009)(66946007)(83380400001)(66556008)(6486002)(36756003)(8676002)(316002)(4326008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GI4HrcybMgec5QqRnsY5Li4SQew5AZ0+yJu9LFCSHShzMHDGTHOlnh/jAAbf?=
 =?us-ascii?Q?HeqyXMKHEPK/ecFCPO0FXX5/zBvhv1VSEWCkfQF84MgC5XIAg/Ca6h7vSIT+?=
 =?us-ascii?Q?WfB6CpHWBhNMN5eUfIK6OzbSP9NIajBMhkGlpr+nq9pgLXAopw5k19XpLvPS?=
 =?us-ascii?Q?M383bEH4ndYxHg/Oog2dsDpZNneGwP52xDFuhIIr3gJATeAv2pHN14qqbFDP?=
 =?us-ascii?Q?55bvgJSocbNEjqJHFCuMRro6ASl5JwEFrbcz5yq/TT/eIVIcFoE7r8FBSc9+?=
 =?us-ascii?Q?E/MAID3uJaU2ZP2EOrjID55/eCuK8id75i6R4nduAbzuLskOdYBtBh/8CTXI?=
 =?us-ascii?Q?dViVpzTIBKIHe46Zji07ZysVonta5NZszu2D0tVxixzYCNO3BuMrWxrRo9Ux?=
 =?us-ascii?Q?RtCYf7eY11pNhphrFcqE0TWxbD8nk9MZThStr3fkGM7mAzgYKTLWj35z2r6h?=
 =?us-ascii?Q?0TfO/jzH6g/fk9bXFQh7BrKtlynSLMmRXg7BvPvzKeHW0TJkRpEJ0jZK+jNc?=
 =?us-ascii?Q?9uol32TWQbrPtnnmqJ9io0LtV4LF8h5QKapTpnYVSiLVGQRSH7gaUhxQq0p6?=
 =?us-ascii?Q?U9QTKk5R2yKm+ZZ/lE7HZnmqyZdAG78QzkBI9L/2dLRTamRyPq6Yt5wH5+9S?=
 =?us-ascii?Q?6ElVfRYgMgNihAWBPlhVVojNr1u/Sa5CTHUBjjL0cm5wkaMdOCf4FX1iJzoC?=
 =?us-ascii?Q?17/8d8MGaXQSgMWYIC0JE5mJh3dbu49WxBLMo57/k/U9I2u9ng4j1rEPKIYQ?=
 =?us-ascii?Q?Op+C2+MZNNSZo3mTopcQDYAKnlL4W7pJwJxRikiP4RuSm1ym+zRWmp6U5+DT?=
 =?us-ascii?Q?Iayyt3ykOhhJGUKWX6sRSTIOC6QWyu38k/kPzpDixQp9tVb3lV9H3b16Yh1v?=
 =?us-ascii?Q?Y1qBxTXFht5oGxhWB+dOYi5DGYvekAdfEBwXZjhDXqsGpAcnFv49nuWhvjOB?=
 =?us-ascii?Q?nRGmnsd/khjgeGqNRTvoha8nuMmdFFrvCWSKgM+yl/4ALtOLUdJEA0B59TmT?=
 =?us-ascii?Q?nhcYVuJxVORB5phAZHzU4uYl5vHw5M71RtYdsXe22aEIUTCUnyJ/0PrhQh1F?=
 =?us-ascii?Q?LnhSsiU2JvnzAT3pz9jJ+EWSZZvgDZ7s95R9kU6kh5/1/lthxXlo+jDJmJxw?=
 =?us-ascii?Q?0SBvcXs/DZq5OYKUtzPeK8dxdUDW19VlWCLXlbLx1WTNm5NaAhC+6FibLIhF?=
 =?us-ascii?Q?v/nr+XCiQLrpFt1qZaj7NpoeO/WEU8aRil+4i7SPgajrl3RmeroexOnfpkiE?=
 =?us-ascii?Q?w8CEjB/+7/HXjoLTcEVF7DoOtcP0sz+0bDZizVN5AXnPWhh8KM6zzr8qj4mM?=
 =?us-ascii?Q?nK0K2pCNKHL1RrIVbD+wCHRkfmYpALf7uTv76nD0SYtJWCdiWVZxLtsczqgs?=
 =?us-ascii?Q?SKrfuqGKZfQYGhrOR/aUgw4NKj8g7G+MT7Np3ItsW791LfE3j83AHraBvNbq?=
 =?us-ascii?Q?1/gecUq591rHSdzvHgfkMEUeRpoVzZ+2ppVWNZ6pB9zBAVL0OBVp7w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5413ab6-b85c-4704-8324-08da0d9fdb05
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:09:05.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oT4eEbB3Xq0L04mLL5zYRU4TedOYIDhGbrrt2cIxQvR/Uix2oLcBwuD5xl6bqST7OnC8dPBlNUDp1Fv+jkOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616

RESEND:
 - rebased to export/20220324T054815.
 - depends on: "add skc_to_mptcp_sock" v12.

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

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |  13 ++
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/bpf.c                               | 102 ++++++++++++
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/protocol.c                          |  13 +-
 net/mptcp/protocol.h                          |  14 ++
 net/mptcp/sched.c                             | 152 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  42 +++++
 tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++
 12 files changed, 401 insertions(+), 5 deletions(-)
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

--=20
2.34.1

