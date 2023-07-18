Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257A17CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D62uqrmYPpMZWImhFbQjH6iKKdj5GsnLSGLfbljys0PXq2gBL1wyVvs5MC+CjSID0jU3buGUdWrFFDxyr8kIoHPaUTrUnJ0Vym6TW1Yit5zecycmsyC/zZo991JcVqoTooAcr33LSiVAMI0qTJZsRNEZ4VvBLnJa28WxqmmO9ND+uFpSCWTb3yT07XPenIwIITv8QEcfEQKNXnQBuT3JFNzAuRuyBaByQVLkwU5jLMA5WtBYsV0iGeq2TUfqN70CZwHhrYK3vX58BGyP95oW3pP43ibL0p27lRwjqpUe4+NqK9mb9MI+QPV+a687DXvl2e749l7frlYbUxBKLxF9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSNHsXVvFQBbLI/QxQMzZPpGCSGwq5o7e+0nWydIUAc=;
 b=OP2F820QiMwF2XGmk00OxNn7EbxMYRoSpOVKFtvIq8RBBgju4yH0WejURZSFJbi0btPgbGh/tLNqOTFh2iJYF7BwgBOjYv9ToviTppUDpakUHWZ63rZWszk21CZSsjWJdwLlNP1/ZHHLHGAjlyegT+dN0++q3BI0UrxiYMtkW3/bjSXjhZyo9g0eLqeKr7H+8rEEvPIEZpIQFfUSMqXcMtDWV7ilw8G+3dbKcOxVY63yj3cilHj6t/3KSMT3e8hAy/YHzNitopFYR/Q2iZq+ewT3xoPCUaQ2s9dWoP3YIO3piDq4APAzxhhBd61EvAXN1CLpOobXvQMwagP/JNtJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSNHsXVvFQBbLI/QxQMzZPpGCSGwq5o7e+0nWydIUAc=;
 b=JLMvwMpc3yJN0vkY9e/c4zOTs3P2vyg08A7JSaNtPoppjg7fdrsxvrZjc3Vv1qcF/mJBcJ6Do0qR+rOk2EVbHY5y5x+/pqtoas3njbtVPj9HuubMpxb99IX9RyBHgLxKchpuzUzGoR012i871OZAEn3ZkjueZIPfX2thsb/GWDVenqvHkvuKchnzFgCU8OQkBKKtkQcvD5KbQF5zRJJCm63uGAxNunGRE4hh2/GKjm+YAB52how5OpNWlBUk8GdQNKIN376zmzHrpOPWW+YeDS296Yn5TSkz+UAjGpZQJDyE0sKeGFkNpoHYzwmhlutNZQP1kEiFUz70u50X1aPjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 00/13] BPF packet scheduler updates part 2
Date: Tue, 18 Jul 2023 11:36:37 +0800
Message-Id: <cover.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 98691f93-c574-4204-42b8-08db87404027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Z4iRI7yqEap9+JdkVy+vfjHgEpIYnir/V4Q3m4Ob6Y754DKGE6APGe4IQbgPUpX2Jd5lLz8CKPq1SEOAAHt0ie/Aiijkz7SCREzAGKLIbsHVEcpnN8rBQQzeC7OL716y3E5qqJIETMMzHE0UqEOSiMQHgWstxeMlLpywAYoP+8omFq423CFcL5HpnuqUL22SOuLJy2+poFvcxegXBX4DBZI83+BnEqOy68BfoJQgjs88lVP4dA+PDPGz4UBx9NZALiJj7Xjhx/SFhigRZ5EkmmDjGTOUAGLAHvCnR75c69a54ueQPuwkh2VoywUWEK7teKCfSYOecMX7GJ/Ghtx+lzt0wccsZ5DxPoM2AlNZJtGb/ccDwdq+TszsxAzkShu4x6NKBbOe5NMUnPq5rYrQQMBXKA+maaNRsrRCCS2qBoI4lnL68prXuhlqCw84Fw4m3Mb5n1bWEVli1iWJQEHaqoX3e6uAZIkGAV9VTO3XvQxZm1LDqpGwEmUCzE96BO10kEiNqJYKCBkKASccq2Kj3v96CCv32NCZPRP/NOAvqfWmsTH6CVgmu2jlXucOAPy/SaFbB+aNRs60yHQ5gf8OQ56Y3w1ANURUBJU8rRcfJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(15650500001)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lLTqYI0qTcoZyH+J2xQW0LhSVEzNQ9xp2ELAwBn0P6VwB6nJRMg7JKZKK8R?=
 =?us-ascii?Q?7g6TXiy1i/FCoCFueztNHdjoCPL0RXopOAp5DJbWpohbdArEFNZs/vweQc4Q?=
 =?us-ascii?Q?b67hUdbIP896rKQVhhx3d/vgG/3q0TEUVkUXnmvIsLGp1CpM4h1ef/txeeXr?=
 =?us-ascii?Q?+2aH+4W0BibTdcoLYXkX9dLPW69KrRPCtJxsAAooFwNeSSMeBqAoVRYQN2dy?=
 =?us-ascii?Q?ID4O9Pym48L7w3M8Tz2CS9Gd3JPc5x+pzE99AO8uuD9Waw2KnqHI2aHb2U2I?=
 =?us-ascii?Q?3OSMalYF6EPEdJB/U2j8THX6zAASJmNuRBSpgLlQstsE/LqKjbkO3mWvCdzT?=
 =?us-ascii?Q?qCnmSaQK2lr61AOqM01jTA9L0APXNAnc052GhtD1LSgrYRWWjMSmXUzfgp6n?=
 =?us-ascii?Q?Ugzxv/jb/W7s747yYvhIIDF+TSrFwsJRPaPqZBRucx8iR2jR+YlMfMqdFu4b?=
 =?us-ascii?Q?IdeJjacSeRvanDHAj/6avFOK6v+Py30bRRJ59tfyZMQTkGNb4fz5GwkPttzS?=
 =?us-ascii?Q?kh2hpjVi1lGvmFcjvCC4dcTi/U3Ar8py79Wz3+goL0tk1WxP5gsylABD3Mi0?=
 =?us-ascii?Q?2auq1DXTrOJirLl4Mvh08eVYfL1s55ZyxcWaCcqgeiZlPW+a+wa9JVjOZmSE?=
 =?us-ascii?Q?VValW8UxulgdZN+rAkeHIdwtS7iWBdu0YZj0OIIhoCSELBrie+rbbQ+qsPJ6?=
 =?us-ascii?Q?6kHb1AYNCZ52LYoCeWz3kFGgsv/i3SZDICOrg8nNki5e0w5FC3t7N2pCpGaG?=
 =?us-ascii?Q?sF8bZQshr6QwH2BOjaa05zUBzcZ9C1dp3/xjo/43FjlKBErMhRAL/JE50Sd7?=
 =?us-ascii?Q?GLhSlQGDUa1GSjgOvxoLaABUAtCcqiFYpaHCM/+fqPj+u+cExbA5OW8hogIb?=
 =?us-ascii?Q?bC2qWVfwVr10f1t+em76KpdPXiwkTPEdBH1cF371tQEzeKvbwmbAYNOhfsv8?=
 =?us-ascii?Q?WOceU3GOT/MgDX06s8dGdqdMF7UXkADQ65Oab/LORg88bluALv64uFgmpCqL?=
 =?us-ascii?Q?X8Aw4xnorJMNudfj8tShyi/UopV6Mo3QzisqIzW6DvQQUmTjr0OZkRPyJDbx?=
 =?us-ascii?Q?BaymT0xLqGWFA9H0CkM7jYyiir9PxNQmEt31apskmignpwarJaVYYV6U8rXR?=
 =?us-ascii?Q?QZVbRrwdObcq0vLLtorkZlW0PDoHiYctg0a3S2gS4edmeMXlD+O4osPMIOh5?=
 =?us-ascii?Q?k4phUjBgvYpMuGdGAQ8fxpp7MAUTNfiiAneqaYD9wx0TsOePykVSrih0dsWQ?=
 =?us-ascii?Q?E5jA86e1PBGdEt2e2+RZ51tvRgVEQDcayYg7nj7kLBoaAetuOkp4FHQZAMUR?=
 =?us-ascii?Q?jDZY/nWYdJZ8lm4X4EMnVXrzmtfHczHEAnHC1dHUlkX32AWfgvNI8D5MKRfP?=
 =?us-ascii?Q?yO8DzP9M1whai1G/SWxRFVsbF6EemYaBo9tqNYdJ6Tp/7fZ6v/LHbf6a6zLy?=
 =?us-ascii?Q?gciFi1TL0LKP2vbThH4+NrNArKG1F1hje/vtuSWUf/Qaxlbj0UhSUynZD0YK?=
 =?us-ascii?Q?M41i74S0/je8tOYJAkZ+D+Xl6fuL0akIAoHRypWon/cVh1/rU4+gh9vp6Fdh?=
 =?us-ascii?Q?oPipl1aQj/ZQNiTKP+OuNvhpdoLiXyhNeoaREoxX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98691f93-c574-4204-42b8-08db87404027
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:02.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZkS3gng2+NzA2eCqPL9G/boZpTpvR0KQeaeAXCdWOoTQB6gr5aVpuLV2CxztANsuqICKAk8/Wi19WpK5hT6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

v2:
- Init nr to -1 for bpf_bkup and bpf_stale.
- Update has_bytes_sent() to make sure only one item showed in 'ss -it',
  this needs to start server with PORT_1.
- Rename to bpf_mptcp_subflow_memory_free() and
  bpf_mptcp_subflow_queues_empty().
- Simplify div_u64().
- Move mptcp_subflow_set_stale() to kernel space. stale is a bit filed,
  I haven't found a way to set a bit filed in BPF context yet, so set it
  in kernel space.
- Sync with new bpf_tcp_ca.c.

Geliang Tang (13):
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"
  mptcp: add subflow_set_stale helper
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test

 net/mptcp/bpf.c                               |  44 ++--
 net/mptcp/protocol.c                          |   4 +-
 net/mptcp/protocol.h                          |   6 +
 net/mptcp/sched.c                             |   6 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   7 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  91 +++++++-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   5 +-
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 197 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  63 ++++++
 9 files changed, 384 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

