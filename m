Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692F20EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN6PPUQECPNm1NV92LbKcfqgn2kRHym8EQlcPwpNp1mxRLXS9o6tgQNV9hWemf1HaFlBvbG8tBs+FAJPbBbbG30GFloFHipaEKv02//RAOiWPNDDuVtTQu5NAB7WMYJ4en7/DHCyoYayRQ5I6OesEpF5pESRN2DHGXBzJAScInqCf1NGsulKJTN0hNDgtrmyh7eK3MFmkvob/l+JzNWlHnJppr4oJLLiGkpQQ8vHgipL5yexyh1mez5DiQxMyQOWngkmv/FPxaluVmBsiZsI6HPbDrc9+FYKpWbDUioq7MAciMgB3NVkkaVH6sX8wdLCS2ycsmKayS4s8nbEglh7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oEAv43xUtgrI0IXJWu0gwbRMLUx5/+YNCTqGj4vquM=;
 b=TUYP0SZH9Bvn7ENwnvd1TBrRcoz8fvDpENPfVNZ8Wge/zVoD/C0Ws+8ObWsw6QosUjvBx78wHwu+ok/VPeX/aA9DoI/2YFEI1Z7dyP2vggEXjHt6Gm5YGKdUD6NeJRgW68EmufhXWp2UJD9SadefgCeIwDRnVlOAWECv8TMmtkQaUuF1lg0t4A1LKmSUVLqZX94umuLwxgW+aufYnefnMRp6dQ7sG7Pi72XYJnGR+bk3IPaBGwO4gT/PTuoVc+S7BrkWdaQFhUyhKZFaWMX6xv8MswUOvREsa5ccgOrNGPD6RphMNPTYeYS1KhlgjuwBAomIto6+abzlAW0E9a9Udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oEAv43xUtgrI0IXJWu0gwbRMLUx5/+YNCTqGj4vquM=;
 b=QIZe3iLgHX2hrNP89s0/mUBbZb0t472AMEYIlE1l0L8nhw80i8KnXMgvvMHuWidjz9o4TlRtBZHaH76XFgLsOl5f3m9sTLZovyGVr18SAsYhp2yu+k2zfDxVl3UH+zg6uD8sNo17ZEi2LIt6nT+B1GGionpSJivY0NPCq1cQTcnpUoio8RZMSda2rNwhoNADD3XEz5LeBYd16Q0Q9nQTjOkPWVDtPR00PG2f6qpGorVtVkZJbMdJP7NaewU12nKI1jRdDQBCMaVded8kezWtdWovVy0/rWwEUVyyGwc5itlwhCys+kHuVAlU+mJZSQF1l2vpStNR5TQjmCtq7UY3ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:55:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:55:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/8] save sched_data at mptcp_sock
Date: Sat, 27 May 2023 20:55:29 +0800
Message-Id: <cover.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bc96f9-f11c-4f71-b7c1-08db5eb1adbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A6Zwft+xSABTjR+/tb9qpEYbP4VGFP1M/8GhfyAVvpHFAj3a2s0CFNJEZmP8sppvgkPBkGdIbevo17qo0qVJZHRA951toZG4zyLA94LDinuHv2x5rQAdPXKyCzMZyhs1pn5pknVGKTK5abrxql0BpagBJSs3mxcQkj9D7NDoXFfUnGZY+snTTQnZx7RAYs2W6+cnXUTWT56Hpz8qXn19oYjoPTFYiyckHjycWNxYgQNFbKtplLvpEpjZsio51ZMXZC2sSaIeEQTcK7oV1hyNLRxzGGAXEFMkQtNXPXGqC5XbPuaznLiqG3bRmO447N6qGcwFwtQEJYjqQ9migTZcKWyXTFjtwfOOLaB0YwESDHXz/p7wvz1cnUP5PwiDiU3upTqGfKlEv55Le+PnHxh01hcZ9ubMDMzqMybIbIoNcpNivGaLM7BTrGYHQjDZSo9vBBZbWgTKrkG4tEQ7KmxKCGC4i4c9nMj6eMH7yqEtZxOLRutA0onxJ9O4AHULepwkK+KWEk/LYE0BrgMblSTZ4qj35oKdCntDcfH7WeYt05epp/iYdqM1JFXlqxjYlYI2vyoSfhekmtKs3Yv/TdCXvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(966005)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9JPUrxcLD/FF5Z/bt3p9PM8mLI3eUyVO2Zly1U02sf+VquGMy7x6tqgE028?=
 =?us-ascii?Q?d0vEemTWiLx9yU0Bq2s376OwMmpjDClLLHX7fg/pc0LMNJqWKY/nJXPl/ZxT?=
 =?us-ascii?Q?iuZV19Tce9C6VDs+TnRJGNTpdidabfJ1uAZnIroXUloIZyK7bqeVSNTOB7bU?=
 =?us-ascii?Q?87Oaleq44vT1/G+zSexMPk7K2uf1XJilWeJuXVPMNsb+OQB72H7ZsY91RNs0?=
 =?us-ascii?Q?Z0eIPVpNcXIGAM9//tqzL25sCQ9JJpknRDO/9micEBfkqGYW/OqMAH32VFEh?=
 =?us-ascii?Q?nWmjzYB7XVQdWExrSTgrbWBnEiABZfk6S0TtnPwUYXehnqZkR9lyyLuOT6GW?=
 =?us-ascii?Q?JnmZ/Q4cYCsapNrn042gkNak2NR05Cuukpigtq2zrWTUOAJtWyD3eubXwm2Q?=
 =?us-ascii?Q?QuGVUaK/iONgVs1FOuHyg68DOv8v5cTbixour45dinCTeNOFjeSH3IpBaZbD?=
 =?us-ascii?Q?HHxE623OX+q0mij0no4Qh947IXydEuFfIqTPBd7Dye3IGG3vTQ+jrC5r25kG?=
 =?us-ascii?Q?oaao6nSy7zMUGITDEqzJjrwpVjK7GgckkwOASCuocbeYKTTGbaOBAnF82pjQ?=
 =?us-ascii?Q?U9rLgYV9V0KpWfDexm+ycetyPkFu4bd4Ex0WM7JIjE9bF8xWrajtiOrBbDmp?=
 =?us-ascii?Q?vAdcu5a+UB5mJwWSyogNlbRolmJH22Lk2P19iFOQWjBeE293CfDTrRHXr+X+?=
 =?us-ascii?Q?lcZZbM5hZriNtP4pMLmZZ5Tss/J2lUvgOvDwHDbG9LnldFn6k4kLWBLsNrfF?=
 =?us-ascii?Q?I3Q6JR+HdM9IqQ7SBa8XiXXxENXqN1hjivFYOI3i4+CdOFH1QXxLyoc+f6X1?=
 =?us-ascii?Q?Kzr93iPvXMHXaAW9gp2yvkAgSMc0VDNtJL3WiUsZLL/NXm6an9tcj0RjwLW8?=
 =?us-ascii?Q?MZeQGA0gFReeQ6BuDLi29yf2dgOGe/0hv+EAG61CP7lxcYdOtV2ZsKn/vJ2M?=
 =?us-ascii?Q?hElbvQifDfa+3KnZ6Zw74mRnoFIl8LzB/7JZcwfAg27RzFXFwWw3CDlwFZdy?=
 =?us-ascii?Q?fhlSpgzINw27IGQwW/69lYCSqddivM2Fin7FE6eSMp9r0EK44nzPxOKdfPw9?=
 =?us-ascii?Q?E8qjnfhVQxYtJFV6IOj2Hq1XYXnThLKQrxlJRgPEBp/RcbJKSkVHOUc7YI3D?=
 =?us-ascii?Q?Ag6vooJOjAxCCJkg84mtUld3/0fr3kzvruazXehqq1cAmFQStaGMW5ShVkAO?=
 =?us-ascii?Q?sStEBqcreCKeT2+FvfVakmNJ9rK+MjEO0vkVkjm08PIQZvYyK2M4SnX8Vvvc?=
 =?us-ascii?Q?Fh7E1X40m1hqQx7UAI/FI9E8VW5QWX68zp9A9BtW7ztIVVHQib46px7VzAY/?=
 =?us-ascii?Q?VhiPpzYLJ/yBhkUVvzTe64/DoScPTAHyP7pNbpIggWZLHbfYvw/tygCy2QNd?=
 =?us-ascii?Q?OF12pfueoD+2NLcvdoVSqFxAW5oNSc0oXvp+i/4qA0zEk3REZqsDN8Lj0N/b?=
 =?us-ascii?Q?o3Bf4J3hYWjOhrAx2I1GaCGAONWTRMcgGgIZTgm+RY1oztmIJHd5hOmH3qhq?=
 =?us-ascii?Q?LzB4/EM9+b/i6VaYHLe6O+tYOBr/JMxJI4+GMqMfy4HaKNQ8JpdEBiszeuo6?=
 =?us-ascii?Q?rxTi9jIlfi25HvEFFtjHYEFCblOL6cX1w5gb8Cix?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bc96f9-f11c-4f71-b7c1-08db5eb1adbc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:55:42.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSOXxFk/BMitQy50lXrLJe+/v1gn1lrC5BlrkbgFhLY6I+uMtHK/fRP97Wd6wrQRMDWLtLOSebUg4+Dz+uYg+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

This patchset adds sched_data pointer into mptcp_sock to to save some
data at MPTCP and subflows levels.

With these changes, the old patch "mptcp: register default scheduler" in
[1] now works.

https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342

Geliang Tang (8):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"

 include/net/mptcp.h                           |  4 +-
 net/mptcp/protocol.c                          | 28 +++++----
 net/mptcp/protocol.h                          |  9 +--
 net/mptcp/sched.c                             | 60 +++++++++++++++----
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  4 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  4 +-
 6 files changed, 76 insertions(+), 33 deletions(-)

-- 
2.35.3

