Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6BE43ED
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzP2pwf7TeMcL4v1Cuo+5T8SBJOaz6qlKyXCD6nDIkiqGrgpwLcm+2M22dnlk8M5eeSfsv7JBIMxNj9HNUqEexGvDApO8MrGW9rbgI5TJddiGjQOPKpiaXw0cwBoj5ISyOCa64Yr8vZgkEl6oeSNhxep0yHUYIUmGdDqn+N0ZhyuChGmjxF0qmD/4BA7RcsvZNihdmdQoiaGtSJJkJs1tYFt33kGqxbZDwUzA2AF0XI8OfBGalPNhQgmDeRJ20OGMgA434P4f8pYs6wtivMdjzMSMgYM9zSOjEZorZ8dVB0wC23amVR3GAR37CrMe6fYb98fw3jt0oGAYl/mjA4xbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmdm8YSwzp8BdbNUA1nqfxgfY/XwHsJAGpbQGne7VsU=;
 b=fJIm3EV2k+2qy77nzT83mazFrfqEKj+qTzEqcD74DWCSJt7hTLohxqG7XTMXH+ayKMv6omvBz/vABDmUEddHohAH1Qx6m8CCAxGyOW4jds1nenulAuErlqFJDt8W9DVZxJ6Jx9sdreOgPTbKoB3pu8NmDv4aD6w8IdnaK4ouFLd1nTzO8+hxYWFdehTixhKl8ZBD/IRUy4Ro8HmmRVyxjgJrIVIw/6vrI6HHTvS66CCH7OGEZEIbL36lOq5UgeX8twJ2Je/yFB366UOa1tBVt0TCtx9fs/0W2Kt4lMA/dPOr4VYg/cyfpo4Bq2kqxdxlMUF0+IvvTpmhrIqPjOk/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmdm8YSwzp8BdbNUA1nqfxgfY/XwHsJAGpbQGne7VsU=;
 b=YIJDKrybaVeHW2Bmx9s09tjFvm3TGfG4tmrJZb1fkfyafnUV8ivR43gi0liJP0ASLxsZatRXLG+kifZgyN0lPGI7XahWjN8o3XYSANLb7KfggsJdTAGczNIeeHZ7VNEc+Np3E4vo6Od4DCWan64CqjRovVuJTp766A/XF/5v82tYjXLtWBHmbZA6SafJYGhOSgYptV1hkt7xHKrP/l0OKTPVQmFlL4D81n3RYGcsmxkB/DMo/XxxWFAXCgYw0K0lLA2r1zWbsTwZ9JzMVfqMYZBknh7WDz/r1KQUkp24XelCWccHj1pQ419/LenJj08Reo3zidvATbbG0J4GHtGo5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9587.eurprd04.prod.outlook.com (2603:10a6:10:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 10:50:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:50:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/6] BPF redundant scheduler
Date: Thu, 23 Jun 2022 18:50:22 +0800
Message-Id: <cover.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 495a687a-476d-460e-27f5-08da55062c85
X-MS-TrafficTypeDiagnostic: DU0PR04MB9587:EE_
X-Microsoft-Antispam-PRVS:
	<DU0PR04MB958794866C6F61DFBBD2EBBFF8B59@DU0PR04MB9587.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rxt7U9Z4giRP/TIQ1Vu4/o99PFT+aIBPeNgoQcyd8QhQnzHY9kyZfaYE0xD8dmIkGqcTDaTb6CPklIp9SL73EGOpNtsR60nQukZWSzrOA1qRs1Ecdo8n3tyUTbYxjEjAfg+nQ53qqcFMkVseu1qa8RPXY5jHPQszO+UVsl17z6uWpj3X3YUueTUCht/ZHmm1NETR5xWtGr/PBcuneZouqYP1q5VguPO6d+VngrixVKk3u34w1fJOaSnKdXFdJwMTtp2yGPHJGdtosOJIE6W/qPw0TtK4bg+2jfWnhUJOfgn6PAP7iomPaFvPC+EURtlZrMmbsI+iDft4Gxb4+rmnUCOyG6xHaGJ8SRYQJJ4xvY0VzqYzaYnGalmMfoBxwMjpDEcEa+dn2KwOhVPtjUHE8B0AunnCdhEdh2WgkcxV8ZSWwrxvW+r8zrz9mUCIhioUIwoIgI5dUyX9rqFzRuWCC3JTpkHlI7UIJ1/fUdcJdZmXf0V9sMmAstH2XiZRZiVgqp+n54q4FCqtnywAhlvesQ8Rwp8/qk1uJnyI5pwXpsMSSD9/xRjk4pJYjoIp8m58/Kn1qBv/aImbfbkIpkre54exjPsAvnmvdw8a0JniEjipmod8N3cECLpKcvvC1Y2yLDA3F4WZID3eHojuWeF9wrQmsjSkmeBXOjVxp3fcTEI6qtJvVsTl3voZYXDSNJF7q0Vxw2yYVBIuftMnk466Dd6ftPsRsXO2oFTxXQAaFlbvE7skFVDznaP3zVpalnEq3GyHdvykaLoT4q/G6wCXzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(376002)(136003)(366004)(66556008)(316002)(83380400001)(66476007)(38100700002)(66946007)(6916009)(5660300002)(186003)(4326008)(36756003)(6506007)(8676002)(107886003)(26005)(2616005)(6512007)(41300700001)(86362001)(8936002)(6486002)(478600001)(2906002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJEEOl0DGcrycIyWwnGaD5+Zi+KoX6cjjCowx7y7MgvrAVdKB4h7tdOs0aEm?=
 =?us-ascii?Q?ulGp0BNIL3D8762i0q1qxyle/7YwC0VMeRE8KGzwdU6QyxBZsvSBI38PqbVQ?=
 =?us-ascii?Q?WPmXJiii8GV7w2hkJEzSzhPzPxPTbsWJ3+FaOC31YHESuxhtRHvHFUXPsg51?=
 =?us-ascii?Q?4zrU1LDta9XQOBfs4wfigBV9zdmI3huhSqtOh8IcCek57vZR0HsRYGKLM6l7?=
 =?us-ascii?Q?kxSeYL6fX6atvEkGR8ITvFTZ3AIRNxJrCiY0IPVO4FhiQf1wUcyPAJQq/s0K?=
 =?us-ascii?Q?T/4sQdVqvI+Aofo24HvMPCJZd3Vo1nInJyTGpMli143PuG+I0WO3MwVsZ0yn?=
 =?us-ascii?Q?U+aMQz0Xx3k3uoOseCbsBaKjQcpM3QCg8p8PtB1Co5htCV/Lki/TklZ1+VIx?=
 =?us-ascii?Q?Q8GmW0x8pSMeCBYeOOVXsGfPwt7+yj09vKmE2NGfrDUYEkdtNr2GYlJ1GykY?=
 =?us-ascii?Q?t6HcC+RhoeakKaUUmkpx2CkljpNoclZQvbVq1WVpuGrUe4aHR9X36v9IjVFe?=
 =?us-ascii?Q?8iwR9pkNnRKAQV+agd4B6cARrlRj/O/WVTUakOwuzuZSvgbOfTQNtxiVbv5C?=
 =?us-ascii?Q?1MRimMNspvTRSjDHwEC66fMHQQBtEa8IgU5DFd1jY99GdcyZ6ou2On7s+47L?=
 =?us-ascii?Q?bwpttVbfgOL/tZ3Pa+zO9nHw541XxJ2mpHBMYcKsyfKLiBgl9kAP8PHpIonr?=
 =?us-ascii?Q?8Lsk5GoDp9i7qKOKfam3YC06AzzbcOEsPWm358jvPxMr0lnd0n7QIX1iuWkh?=
 =?us-ascii?Q?KLkqgq3/xQR/wCtzdj8AsaZN6pskc2DFUfRFIkAV22QrKKECbBavnfayvdyi?=
 =?us-ascii?Q?ZLFJtHs6oL4cJ39Dh5StKtyD23kW3UUGrDbWMAv2OhhS6wvHz++2Q3WaqMYr?=
 =?us-ascii?Q?O0Hrt2v4pFj0eNpNJfthN9UtoPLzTEmJPfA5mjlVN//vfrrxyJWtIx5LmoxH?=
 =?us-ascii?Q?z6Bo4EnHpvhnr1Qg/HuEOgslwrzMYC2QDj+MM2eAA5GPaWD4VNzuK7mNyFI4?=
 =?us-ascii?Q?jRKw7YiQLjBShsnizWLBn0t+3q6LFfQkqoRvlgs9kCA26lrnm0ZGlhQ1mU9s?=
 =?us-ascii?Q?pW7FRibn/4VysYJeCJk+BOb3Y3+eAd3yKSgxDmRfwFRze3H4rAP5q+jIPxiG?=
 =?us-ascii?Q?bL767ouXk/UZeh5p93zDckvnz2WSTZe3+Rh9DkH69Ud3jQMHM5LH3dSPN/Ke?=
 =?us-ascii?Q?CX4kfRYYPnX34PvsoAPuduWDbxKDLIOoOpUQD9Ep0XjGNTDNVJspOGNlrzQl?=
 =?us-ascii?Q?Auhw1yIODOqJwnUiu2ZjFfxO2Wk/3BoC+oMJT4u34Uk2Z3+txVOWBnoO5vxK?=
 =?us-ascii?Q?rkc+yDAquQ0tT8+gULxSdCytKPNDHFlYhiGXhvAQV25AmVdSS3VvpQ1D8Kgh?=
 =?us-ascii?Q?rm8s8Smep9QBHgLpuhp9ae2O8kUuAOcEus5VcS3T8tPtfCy9Za2NJCHfQdhF?=
 =?us-ascii?Q?q3SUT5LcOVYmrznybwKr+wgQbUyxA7zrN184InlgYwEjwjocjDztlcU/0Nct?=
 =?us-ascii?Q?rBGN8YdWSTkkSqjADYZ2qSlYhPQ/ImGpDqnMCa7aFsmoWozFkzLg9f7XUp0y?=
 =?us-ascii?Q?IQlTf2r91QiOkhIkqfElWMGVZG2MikupBwPwylepzEJTM4TyIaNU0L0Iehg9?=
 =?us-ascii?Q?jZiuLO9qkE4r+94fVxNKE/A8iO6E4y/UGKuOiScOWILOpVJVwN0GQs6vkhq7?=
 =?us-ascii?Q?uKZ5LAtkYWx4PyuxnZj3zC5t8tJEAX/ZvvRGAHVKQ33Gex5Y0GpWBro+rQAK?=
 =?us-ascii?Q?eNXPvEu14KZID2Fmgt0TO1qmjR98tZw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495a687a-476d-460e-27f5-08da55062c85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:50:23.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9IZ/1alc3Y1xMW7PnHPYYR6zNyu4FEeIiK6n3lteg1IhXljFp5wFXfQhkhgr3mA7UJqneRYHtSKSKHxx5uT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9587

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

Geliang Tang (6):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: accept right edge of mapping validating
  mptcp: redundant subflows push pending
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 169 +++++++++++-------
 net/mptcp/protocol.h                          |   4 +-
 net/mptcp/sched.c                             |  63 ++++---
 net/mptcp/subflow.c                           |   4 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
 6 files changed, 214 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

