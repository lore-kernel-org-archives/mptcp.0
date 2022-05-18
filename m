Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5746A0
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EmJNtlFFvvsXczkKTNsUViJhEijtwqJDSaZikOWfVZA=;
	b=a8M21OASGRSSm9AunpN3crJB854MB6/T8fg3OV76j/zitQ72dqa10OUMsJjK/sB91ter6H
	xkYUG/SJ9qx8iYosi2XQ3J1uXWyamQooqXypSjEJCce1NDnKMMyk2rczuAB2qR+Jf8/DxQ
	8YXrbibzLA6ND+hhV05Z5YG6ipaod6w=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-er3BJwWsNeuqT5oco8U41g-1; Wed, 18 May 2022 08:10:57 +0200
X-MC-Unique: er3BJwWsNeuqT5oco8U41g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdyM3Dy4qtca3oDIH+ohMboXn8iRnfKDjPaS8756E2qQ2UJoIRTMy1AkiE/gh7zAqjRW5bBGn3Ec0ZcuflV1PYKarZnEQq7y0A0WUSnEwgmOhX+OqGyYn6BhvUdWkxY3//WHcG2EhoXRFH7/Gub1KB8oEL7T6mHZ4Wd/xQmfmXCtuOvgGsVaSfsWN3jOiHwpg/iX13HccLOfr4t2fNeWTnk8568AIkOgp6LpXJI5R1BhZa4DjW0aJH/W9io2XPB+BDsO/JcKFQGNmPm2JnpAuSLlrIQCekRjJKMYyFV7JLeci9sTYO4luifuBsIlBFb3UyCm3J5q9JTC8OMh0rF+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZWf21RCrCiTzpk3MkBr21zy6zqHKFvEH+kVQ1PwzDM=;
 b=ltolMu74yu3Euw9L/YxvkvVYQI3iUEP0IiCcQ8S0XuBLVe0feXVEKuDUpxRgyLKfY+P+Jg3bFyWgqXCeWlIM53NWDVfStvOz/Kiiicj+KCgBwG8NQvJ+aMBGTLVqTlv8SnsFojB7FZepDgVOC8reyxAV0l8rvB4k5xg89HbLb5X3dVoJdEv8E8dFgZPRV+kxsbhSRtA6rDaWYukY9ipxt4wlXDGo5LoG/3+T2wmDS8VweLOjs4F8WUPIxnEECxa8cFkw14jV7KHaLvlyig/mK6fmEYny4GmFNdkA/S4VCLEUgFN91swTVGAqdVVXy0rYTf7uzs99vxZd+BzBW3hjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:10:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:10:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/17] for bpf-next
Date: Wed, 18 May 2022 14:10:38 +0800
Message-ID: <cover.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04862c39-c268-4bf9-2c72-08da38952b87
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8256A988A217841A31907E36F8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FZwiEaw5Wgsvjws3Ewub6Cia8raxZqvjpdY6PaAUS0P4adfjWWYZpbkgCWPi9rTUY2wfRdkThQfPB2dfsA1hHaM9xut5JwN+2K0fS+6OiWPr2eo+S7mDprwmkWZWK9VW5NGg2sBIJL8KAMByPBlXmVsAAVTir8pYmrpfKpEEj+EM4Cv2w4cq3zEYUhTtwCqZktXdqULHRHHh1rSQk5rYgdk2hwEFVzRA8Ui4Z371KoToy9A3B7ov1N2/2odNC/5oQ1lRp9jKXL4h9IVrH9B13pjnOUFmiq5wAqTH7gnBsbrN29SIjycaozm5qrOMYl2Tr/AXZe2K8oSdNC9oIteGKhtV8+QX8UQl7d58Qf46u/hEafUcgC0zm4IB8t5MNPr3ryLcoZKfaqpbFZHezGM48dTvsTaLtrJCuQ3Hp5pi+K+CC/ieu7YXP8reoOWE3cGtXmJXM8zZFffdCcZxEm/p94z+ssoDoMpTaQ9I+riU2rp6pwfhyiKO8trBdIjDxYBUitWiHX0koqRySgeQ7w8RYRu/VMFLeAw1sWYFKE9lprwNW63endNQYzIKAD3PvKmNaab4YRc3g0ahSzI9VJ7+Y9fHhY4smboexFO1mi1cmI7inAZxAkH35LOtR0JrK28wYhHNWhaWC8re4rLM38oZg+8hY56YJg14hTHpc5qmLC4FXLG9IqKevw1FBuQu60xKQNB41p71CyOiRyTj4DNZdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(6666004)(2906002)(66476007)(107886003)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(508600001)(8936002)(38100700002)(5660300002)(44832011)(86362001)(2616005)(83380400001)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdIGDg2+200cFTll4HBwIxdiEdZ1VOKiuWV8aJwJ3rK8rbeRFZHaTXi5vsPZ?=
 =?us-ascii?Q?s6aEaiwiQ2qDsBIIN338/h9zBZsKqHuiQ40v6ht+fqW9fLeolY9h2bOWMDR/?=
 =?us-ascii?Q?BGaqpgsxuPSK5J/k0++gPxU0abm37ApTvGv+lEYHfZ3o4jgRUo8oqzhjg10q?=
 =?us-ascii?Q?1/pOsjlPbITdCdR2JSFVvF5pOwSR95b1lEzCVcoiqZHJelpkDhcsmLlzZ+uM?=
 =?us-ascii?Q?36flsl3jQDoDwgOUzJSIVmkRSOFrnm0f0exjPgV987Ul/iQN+8jbLANaFbRp?=
 =?us-ascii?Q?4+T7aNvvZ1kKe5ghdl8babwml914tXsIqMXKYL/8rwYfuRWMb9/zPXPeKVu0?=
 =?us-ascii?Q?a+d1Gz8tjh42ooPiA3RrxCjpFBkOEJVjjXZ0f0TsT89y8ce5C6aEoPm6gZXn?=
 =?us-ascii?Q?RShpuRAjIy/EVBzvqwLLuxuDddJiB9EJDDEjWgpsdBFDOZnanQ4CXckLwPqY?=
 =?us-ascii?Q?Clw/ta+WUSuXvVJA8VHqIcetebJs2sQ/vr3DouZp2L0aPsT87x+kfNPoZTsK?=
 =?us-ascii?Q?q07uq7LIFFlhqXDA0m9yoUGg57SFgVN5PV5S0eAAPj72uvfITHwwAU3OzB9o?=
 =?us-ascii?Q?Bsh/25ez0xpazoKRSv7OuDArjzOCO8clzS/r1y9rvvOcDsGo+deSmEbuqeQZ?=
 =?us-ascii?Q?kMpXIiVeBJ3EmW33Yauah2h/xJWLxyf0MMRltd6kzxEautlzwzY6cPLbBU7A?=
 =?us-ascii?Q?uDeNEQinfMrd1RInLWFRU/iB/hXHScm27IK9Df/pI5gHSn2/tqbNzCc8bVPB?=
 =?us-ascii?Q?tpjN3qvH0dM5ogmGJCOlA0GSHVGwjRgyOUJwOvBgyQFOI+SqP32KFQApazDW?=
 =?us-ascii?Q?WqgCRksENRZ8N8Z86sWQ3QPdKD/bAK0H5DDhHJegDHZeujfcIilGA6viYrO0?=
 =?us-ascii?Q?0Sv5v53vvDuXPaClMqhVtxZelC5/NDextwotl+3lraHip2NMLUIeO1t9jOti?=
 =?us-ascii?Q?DPhKoVYzPY37yB6TM166vKS29Sxamxy0T7FGxbj+bjDA8i6781azgWC2Swjc?=
 =?us-ascii?Q?z8aDODGjmB/MWsa5AemO7hGmSgVxq9Wrwyon11NhDCyMHXHbA1jpAiRPZj1H?=
 =?us-ascii?Q?KE9CrrhqYPT8bBlJ5ltJobYC37En7maRiAX/O/hqDdHdWHQ31jutpKkygGN5?=
 =?us-ascii?Q?SdDYakP4hGcsGu6KMqUtneyXkCtyiP824rNuV8B/hOWpFL8NcOu4R2BceqUM?=
 =?us-ascii?Q?Y0/c716P1yOKR6bCGekmBsOGXRRHx52+txPbcDfwg+e64Ao4a9R+nBxsGCQn?=
 =?us-ascii?Q?LhKRPmBG0UwhzX4Wbwv3ER5Z9/dz87cN9I6YJBbkaGPMJ3DtCqvTVSPlbLMN?=
 =?us-ascii?Q?bKADkWwiCOkvZuFpL7/9txkFKdgABx/hQfx4/8yP5eIf6xWYE1qZrxYMksNX?=
 =?us-ascii?Q?oPafK28hGD+VXz1sA8LuH2p/N3/Ry8hl9y5D+x7LLYbCCQea96yHkowDn5TZ?=
 =?us-ascii?Q?ahETSvpZJt+x7XOmNDklkfhfivCPFCNJ5+sRmF0iT/9bpaVVL3vm5eTTdNAX?=
 =?us-ascii?Q?juWrGw4vZDDdOAUTJFYITV1eT0xLLO3meP8XxPOFuwGm6zzwvGeNh6YWCNHB?=
 =?us-ascii?Q?KFjZQigdDC+cpO2fAed0Z/bfVjKQmZDUp+CNeSGOAAfaidkX/Uww8MOKC5JC?=
 =?us-ascii?Q?B9ZAmMI75jwdKy9mPl8L9smO3merCj3MrnPmRg3+e2XX9n6KDX+8OBCp4R3V?=
 =?us-ascii?Q?ZE1C1y/N1kdQvMkYutUeh/Q43100oF2JKyrHPTlQNM+kOH6F1XRYn6fR+U7r?=
 =?us-ascii?Q?wLrQ/OoVIGhaLVO9T13uPbMoTwFGJnw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04862c39-c268-4bf9-2c72-08da38952b87
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:10:56.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY7zBb4/DA6KqNyFccHeYgBEqwL002KV7flpzwaDNVqSAqKbkbvWYHadosQrlnrBFIJDLzkIrCo7k0flPSPDlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

- The first 10 patches is for bpf-next v5.
- Rebased the "BPF packet scheduler" series on export branch.
- base-commit: df896c77f02a ("DO-NOT-MERGE: git markup: features
net-next-next"), export/20220517T155019

Geliang Tang (16):
  mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
  mptcp: move mptcp_subflow_context in net/mptcp.h
  bpf: add bpf_mptcp_sock_from_subflow helper
  bpf: add bpf_skc_to_mptcp_sock_proto
  selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
  selftests/bpf: test bpf_skc_to_mptcp_sock
  selftests/bpf: verify token of struct mptcp_sock
  selftests/bpf: verify ca_name of struct mptcp_sock
  selftests/bpf: verify first of struct mptcp_sock
  mptcp: add struct mptcp_sched_ops
  mptcp: add a new sysctl scheduler
  mptcp: add sched in mptcp_sock
  mptcp: add get_subflow wrappers
  mptcp: add bpf_mptcp_sched_ops
  selftests/bpf: add bpf_first scheduler
  selftests/bpf: add bpf_first test

Nicolas Rybowski (1):
  selftests/bpf: add MPTCP test base

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 MAINTAINERS                                   |   1 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf_ids.h                       |   3 +-
 include/net/mptcp.h                           | 131 +++++++-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/bpf_struct_ops_types.h             |   4 +
 kernel/bpf/verifier.c                         |   1 +
 kernel/trace/bpf_trace.c                      |   2 +
 net/core/filter.c                             |  18 ++
 net/mptcp/Makefile                            |   6 +-
 net/mptcp/bpf.c                               | 162 ++++++++++
 net/mptcp/ctrl.c                              |  14 +
 net/mptcp/protocol.c                          |  32 +-
 net/mptcp/protocol.h                          | 106 +------
 net/mptcp/sched.c                             | 141 +++++++++
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  32 ++
 tools/testing/selftests/bpf/config            |   3 +
 tools/testing/selftests/bpf/network_helpers.c |  40 ++-
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 288 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  89 ++++++
 25 files changed, 1007 insertions(+), 125 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 net/mptcp/sched.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

--=20
2.34.1

