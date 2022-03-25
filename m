Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3ED46B9
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kElHZs0JKOa9Xdrw0gchF2iUeLFzJ9GDfhsQOWgdpo=;
	b=Bx+IhegayydPRojlkyvXCLwuTDKxDQoVMjC7ZNrFCA/ynfVAfaJF2tQITDaP6HJkZf7mgv
	+/JggFbCUctPrVv+/3kWl3bZMBB5QPtbfBbE13A5j0tlR4bPCCxbCyIP5Uzy6fes7IUYRk
	tM/5wpd2uTYm3Rbsl1kZRaNsIOxa3lY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-_GycmpEpMvyxD_jCgjDE_w-1; Fri, 25 Mar 2022 11:11:00 +0100
X-MC-Unique: _GycmpEpMvyxD_jCgjDE_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2ZjlYdKzENujtP3F/y11xsf5vzHam9YbxKfA188UMwrkmJsPgtK3aMxCot5X+n1LkoDCFXZk4Hd37169uNaH8O3DrgQMQj90mv5rKlRwsBx203enKkOl2sVWX6G843PvC7qjgG60pIjO4CtzvJKOiNi1fNSqgby8cesK+hGgelyNNbSO210SRAnlJsACGwy3clfTKNz0SMymtN5LSx8WawV7dwGU6IftoMb0jhAmPHvrYv1SMj10S0BcE23jW+jFQZLfFRfdwDaNMNi3CxZSuX3fwAuL8RxpklvEFg6a0p9FPtwTuCFHHkTyjSlAbDcyqi714RwbK6llyHYIKdJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ye39YbYH1UrMExbtxf7+WEdJLUVY1caLL1gpLXU7Fc4=;
 b=SOrl30FRMwAnzOHVqwp7XMs6kb0hLqWBFainLPY+z581N+Vvu0xyCnfLgiVLU7l3E3q8FIdxZzWdlq5i6zw+yOvQVpMXOGpfgab4pCY5IHI/+CMzV8G9lN0W9ZDZJoEbeimR5T6LJtyY6UckfAwTAc6j0+lakYPSGCoOCZyc1/LI1S0bV2mDeKxIJj4ecqsB3REddAwnQaizu9d6Z1lsgCA65kGFMrkXO0NCbYfSIp96CyEP+jCXRPYToQerKog2Fmc0ysdwnZJEGACUn5xZj4IsOk7CoRKoWhkek9wo7L5Y+sOkPKy9tdkRbq+coWPpQFqp3IWpOELKZntJ3AgZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5353.eurprd04.prod.outlook.com (2603:10a6:10:84::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:10:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:10:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 0/5] add skc_to_mptcp_sock
Date: Fri, 25 Mar 2022 18:10:51 +0800
Message-ID: <cover.1648202310.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d6a49d-6248-4bff-fdf3-08da0e47c186
X-MS-TrafficTypeDiagnostic: DB7PR04MB5353:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB53539206A0F12F952AF84333F81A9@DB7PR04MB5353.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2mC36erXzgfO+kPd7ZXcXuJ0d7xYHDSQX/55MVhXhD7OXxxL33MJwz0CsINOwRjmseAxlYMB0TCAwaQTnGq8Sga8UEkTgEs66GOFt1I06xBhhCBvj7c+7kZEqKE8wxJqk9PKR17dyFE4VbCZyVsJcDFb3z+OiZgJ1xX78uHq2BCmE2bo0Pol0MbxqRCNL1FrkrtZs1vZkomKa8vpEgLJQzeSZcuNxIcmv+lJPERYu+MO2NEPZrkN9GeErTw/JxZUzY7ZzCUKg6HN3t/COo3Evz20RlCP3XI43T4sYm5jMUZCyCEv3zhQTSEJIEQ0Pl6rHuaxE59DL7erYvVLejIL4GheAAGTpj8wjeTSmYpPR7Sm0SwS+9W9g+9RNBxDstML9qPa4WbQBvzGQs/BA1rMkMHV/HHuZCUsQ3MOncnj2SO95ttxEBqPpaU71e3ewDMHF2Ce70Ugwwnp3x95dAQQzFhEktjzRRzaRL2GZa2EueiIHqjmGE6afg97O9FywhIe/M1+/+tcU8cszWZHZgHbtxSsjpkfFYmLzH/MhBxTNlgw31VEwsoBcPfYjpGr7Y2nZXU68krY2DHdI1ef9tzTKG2x4H/VHNwOXJ/JF+MHwNnNKvliIRqSmmqHWSsxKFmz8PgQGADbSptr+0it+ZU9paSuR9d51k7HIptaPMaQrzddnwF35nuKPODxBTxt9W22
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(6916009)(66946007)(8676002)(6666004)(44832011)(26005)(6506007)(66476007)(83380400001)(36756003)(2906002)(8936002)(38100700002)(86362001)(66556008)(316002)(6512007)(107886003)(2616005)(186003)(508600001)(6486002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ympb6LaeW8lWGF8EvZmIT5aAOSDikZQa7M7Tz50E4AKpM7lC91Ww9srYXg30?=
 =?us-ascii?Q?OigRdYJNEA0dwUFhXjeV8ijV1EkOt5blCGXXxk8JmJ6kTvtrjuw0c1+gPUOs?=
 =?us-ascii?Q?PToOUgu++/vq3EKK6xLcNsxzPJVWjF+/P8B9fd2kyOsq1y9MkZkIKS7Dkur/?=
 =?us-ascii?Q?Q10g+1kgUxiFSx9kd7ULOJHkn4vH0+gfqdcRsA82JB/UozgO+D6CjmZ0MVpN?=
 =?us-ascii?Q?EJFGmXp2SANvFtLFcqgFU0NmTBypkZfkL2LYgYMDkOuevnvHYOMVbGD6yNLV?=
 =?us-ascii?Q?pYCzuWZeoXKY+0KtV6vDbo+LUl0ZLkSewZ/bUxvLzKRhR7sPtHt6fsPpPGlM?=
 =?us-ascii?Q?xhUeQwG5tSNcqfIZN+/W5pEJtoyUULE3CBgWpUPdrjT0yfZ4IQrhP5W8EQRz?=
 =?us-ascii?Q?NYTfjhggfNw1bNvF5qHD8SFXM1JLvZQpu2+6ogk6C5hQbnlx0vyhVpZi2RMF?=
 =?us-ascii?Q?Hova44YXFq07ya6f5ZrjFaE06T275dAO9wpP25B8+r+QgIljkxPYeqNEhuye?=
 =?us-ascii?Q?cuO0l5cM50gdhrB4ZGJZPo6cmdmnKWT35JkTP12fj4VN9QFWqJT09dOCUUvl?=
 =?us-ascii?Q?KR0Mnx7hVi8/1PA8L34GGhRBYp1HarkLpbd1PMbpixDqYauNU95seW214xkM?=
 =?us-ascii?Q?Ug+qUWH3025wAXfaK2QHS0GrguLYxWIsD4i/ZdzRWi5ECpBqDVgcqUU34gJn?=
 =?us-ascii?Q?Jja9+F/iQOTl1Cz8QLrAtVyXELTxzYoQTrVCjypiiKpzdLSYBjJAOfUPXXlW?=
 =?us-ascii?Q?7PmuXLwUGjZtc8d2zpLWdZfAnQpcdGNrZuYfJO0jMBTxIDMNE6esNRoQJI29?=
 =?us-ascii?Q?8EF8Fevf6NOFCML32ARP/7opiBGKkVpDtrQ3LzWsDraosL0VkDT+ZqYpH/+v?=
 =?us-ascii?Q?tNpc2SL5u+nzV/teUhs6b0JMVFb/2EtnTRARbCbwGtOHQWslkhG2bxdA1xei?=
 =?us-ascii?Q?eK+rA8wVakjXvCFmdjGjTe0Hu7RlBhmdbuMMgfnprP9kWXgX0LM469zDLBzv?=
 =?us-ascii?Q?xMjkgRI+j8ngt91fY87QaJKrALM6co2HzZYoYDxz+/xZBBgDUoa6bMrQLvpQ?=
 =?us-ascii?Q?fv+cp/pw1FhsGsYOnAa54GQRxvfJxVVIdUAHUuvenyocaQ2CRKKP8A+6PlYl?=
 =?us-ascii?Q?v+r4vJ5mVGh5+id0TzSGtTTrdg3GKdIdqlOSIIapAI2ZEVGaOPdAsX/aty+e?=
 =?us-ascii?Q?l9xU3jHip6LRBe8gLsCYixThc4LigpWJfjuFxOt6RzrntyHCNMViabNSB/6g?=
 =?us-ascii?Q?2Kx/Xxz1fIQC7fNucMzrUAI62qRbdmidJCzDL/YWUmoJi3kkzM/MjYXICEuy?=
 =?us-ascii?Q?ntgtxVEZma0/8/osa0icqwhC0CediGSKGfoxFuKiXtI1by5XPS25I34n/sRA?=
 =?us-ascii?Q?DgKiFWvMWyUdxZZSiFsFQ5rea5xJEektdgeiJVWi3V2NNLNeNlxni/HWHMz8?=
 =?us-ascii?Q?9UnS4D1O8E7B+kjqJzXIxNw0RBVIIOq0d9DqWYQLB/XMohKkxIgl6mmxkHJN?=
 =?us-ascii?Q?IU4Dfrk7LupP7ROU88eO1fouyvXjjNLYKZomTkx9h4Dopn/yJ1rH3+Jw9J76?=
 =?us-ascii?Q?e6FwkYo2d4sL7hZpkSIEKUlMKE1uP7P9L7LEF31aFS52Wc/BsWRHjNdadvPq?=
 =?us-ascii?Q?DtY+Wm1/QJag+uNA3L/+zAs3tm22u5PzCKYGZ+HQfBVcDni/G8d5IKyM0hyf?=
 =?us-ascii?Q?tsO7KAx570ronUYtsjEepe7iEYTlsPl7bKvUOKNXCxhcGRNAWAVzFbvkBeKC?=
 =?us-ascii?Q?X4WPTjpvz9WrbOaWdJHeUK2NksYqxRc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d6a49d-6248-4bff-fdf3-08da0e47c186
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:10:58.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8roo4amo5zmJYZfRTDbNaytkweD2hF/+eeSYiRbr6PWWVKmURfxAXKndTs+6SE9XGGGhSA+Qin6JfLk9ZAjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5353

v13:
 patch 1:
  As Mat mentioned in the "BPF packet scheduler" series, BPF packet
scheduler depends on CONFIG_BPF_SYSCALL. In fact, the series depends on
CONFIG_BPF_SYSCALL too.
  - change "CONFIG_BPF" to "CONFIG_BPF_SYSCALL" in Makefile
  - change "ifdef CONFIG_MPTCP" in include/linux/bpf.h to:
    "#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)"
  - drop "#ifdef CONFIG_MPTCP" in net/core/filter.c
 patch 2:
  Address to Matt's comments in v12:
  - use bpf_object__find_program_by_name, bpf_object__find_map_by_name
  - use -EIO
  - drop close_client_fd label
  - add more CHECK_FAIL

v12:
 patch 1:
  - merged the squash-to patch for v11.
  - rebased to export/20220324T054815.
 patch 2:
  - fix the libbpf 0.8 build error.
 patch 4:
  - use fgets instead of fread to get null terminated string.

v11:
 - merge "check more values from mptcp_sock" series into this series.
 - patch 2:
   - rebased.
 - patch 3:
   - rebased.
   - add 'Copyright' entry as Matt suggested in v9.
 - patch 4:
   - add test__start_subtest.
   - add some 'Copyright' entries.
 - patch 5:
   - change monitor_log_path to static
   - drop bpf_trace_printk()
 - patch 6:
   - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
   - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.

v10:
 - merge the squash-to patch.
 - update patch 3 as Matt suggested.
 - add sync() in get_msk_token() before read().
 - add a comment for get_msk_token().
 - update subjects and commit logs.

v9:
 - update progs/mptcp.c in patch 4 and 5

v8:
 - update as Matt suggested.

v7:
 - parse msk token from the output of 'ip mptcp monitor'.
 - add Nicolas and Matt's SoB tags.

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (5):
  bpf: add bpf_skc_to_mptcp_sock_proto
  Squash to "selftests: bpf: add MPTCP test base"
  selftests: bpf: test bpf_skc_to_mptcp_sock
  selftests: bpf: verify ca_name of struct mptcp_sock
  selftests: bpf: verify first subflow of mptcp_sock

 include/linux/bpf.h                           |   9 +
 include/linux/btf_ids.h                       |   3 +-
 include/uapi/linux/bpf.h                      |   7 +
 net/core/filter.c                             |  16 ++
 net/mptcp/Makefile                            |   2 +
 net/mptcp/bpf.c                               |  22 ++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 209 +++++++++++++++---
 tools/testing/selftests/bpf/progs/mptcp.c     |  44 +++-
 11 files changed, 289 insertions(+), 44 deletions(-)
 create mode 100644 net/mptcp/bpf.c

--=20
2.34.1

