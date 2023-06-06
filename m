Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3A3D8A
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 08:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyRCXRijuyHGmCEqHF0x/BHZt4dALNq7Q3vc3kLR6/yMacsn96bX6JEXvZhFnhKB8gzQlTaU+RdCHHw7VDuHJsOqgPjIckaObDnzR1gdl8q5ccx5g7oGs3osFlFUOHZp/Omg23ZLAx0ScCRLk3aUznZWfFOCLX5LvuR9FGZGYxVyLoAxrc6c4MVSJaiFp74Y9JgNGXPIDZv8UjtQepP46HixmOCvOqVD0D3W1UklW8TWSbq0SFkFBDQRlL9cieBJfW1T0kaZVwgsCmAXf2kuQXKZGq5zv2/cd6aEhoTjQV/b55cqH3Rr0hYiL38yT5y2F2o5Pi5s1jE0AFEk1ZJr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V0SuIvRxE8+9qk8Xrx3aXMaXyyqmJnoXPZsaH3YNaE=;
 b=eUZy8EJsb6xc1NORk1wgPcLjnMVUf2aVfVIfrtROaFnegGQ6xfy4Hx8QlyeGghcWhD7CkAUJqWVlLjlhT6coO2v2BjYi7pgf+hfKL2ibY1udlB7bFcvVkSLANs6+Xhy3mtQNf73wqa9cqOPTXLWWX2dB30eyKoeh+P+J+am8jnxYTx+DpJztK0VXKaRrYqioxsrQHfwsZ+cD0BwvN12WaVIDCix/mX53MgAkyOxJuzdxvLEAkUTA/Lzdc5Bz/b+ujNIHSWW0qhMjNIq7Q3qD0XOlQie9mA4YBaYjUrP4ordZKuAy1eYZ2appSLLPAbcpUJRJ8on3/OCNTyFEPh+B+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V0SuIvRxE8+9qk8Xrx3aXMaXyyqmJnoXPZsaH3YNaE=;
 b=x2WmOnL7c/o4VbL6RNp3XMhm23MutKoeKVpPQ87BJTTEoT9WTY7ROvXE0UOm39b/sNuzgqwCSEYEoWtKq4iyVPnY8DLZ2RzZJVcdljDkEsLk25PoM3QVoQJs0xLQDxbHZ4ZYA6Xz7e7A1CJX+68gSJOZldJ/qTLiiXxIlizaBW4Q6mgwDSDSoWc1tr7iNVz5U8hRJrH4Ekpjua3oHO5ZLRXgUeq4+eP5m7rkUQXYRo8950DcPgZhOafLZcy0s6qBNcx1JFi9HQ++TlYWY0VtiDg9dT23gykj6jkrzOIrEdaM9du9YDmV2LV9cisLJfoGFOPgKrmKtLpAwBFozQolJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 08:59:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 08:59:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 00/18] BPF packet scheduler updates
Date: Tue,  6 Jun 2023 16:59:14 +0800
Message-Id: <cover.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: d95d8594-3d74-4918-1c3f-08db666c618b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+sGViHjDcdhea522TvabVzmMjwCWuNVlqk4rOEyu9JlTGGMTdtRkSsf3PmXZOD8fWmFGb5YHqKKZaMEvuMzVQS/vbBR/3gHhCcAgU3jUWQplrK+k9djzOmXmc+1jlIrwXz59gAlwAKQLx9R2URlh18b4sUWcxAaWOTKD3c66RDke2gusHyJtFOdhKQnmxGu4hN5fJKb7LGrk4tMkKpbGLjV3KV200y80FwpcqF/Nwgfz7m/7gsBEEfDa2ePwwuK2R63Dc7Fk/e8amgcGLW4Mf2dipLFvmWoQTmU2bX6nruyO6F4sH4fAtAwmn72g80yNubggCcicGE4d4h7siEnvgveB/nnjuRRqIROSYGjB4Ple7kiZ3PRDMPqqHEQt1sGVThwqdgcBs1w8KcUB7yLjYSmsGNGPS2rQPmn9t28Dj90+rTKBcvTRljOvgzCh1mv/zc97a6aXD5n7aLUh/ERWhe8oJ/m0Fn+NK2NxgLP2tWQ+DWnV+jGsgqhbtQ1aPF/aB6jDwEYGfvjoi1+dEHu2q8w5aThl6JZaRisK9iRma158Y21Y6XNNG88rXfzwhHilX3KDWwTaDQ/XrlfjrTRkTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(41300700001)(8936002)(8676002)(5660300002)(6916009)(44832011)(66946007)(66556008)(66476007)(316002)(4326008)(2906002)(15650500001)(478600001)(38100700002)(186003)(26005)(6512007)(6506007)(86362001)(107886003)(6486002)(36756003)(966005)(83380400001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Esqd5qnEnpvK3Vq8VoMucX+3Txwq4D8s+CnqPMT0RG2whuMrQxZf3KNC70ao?=
 =?us-ascii?Q?l+5qF3HbZMu2+zPNcvPKOysotIcsfs00e7qiCtwcGHZAXANZ8yQzxGkO/JK2?=
 =?us-ascii?Q?bW8X1pESyosDMLz52R3bloiMtG7zDwsStOGeMuhBxyCT87FqgPOXAmRZCncb?=
 =?us-ascii?Q?5b/DnubgwNJApcnDOpGVl3IZxPqll0W1xbndNPhuveXqS8OPTKtd2YRB8p8W?=
 =?us-ascii?Q?cMpD1M7tauUqe8BGeex3OO7frIUBcjfixHp5SVkQvxsjqtWlN76Go204yylN?=
 =?us-ascii?Q?fBIFf9yIihAMtQOLCk5s0rHEGGPK8mE++OIja/nWnTljWv3MVPQSpY49SeVS?=
 =?us-ascii?Q?x8a2uCySNmjmsT8fWGbqf18iHzQSqhr8HHS6ULdkUTUQhuqFeIMpg2bs/8sQ?=
 =?us-ascii?Q?HDsEA1mlRnO8HiDlackyGYI4Q3RNA4i0oXM8IrPWggTdJS1f/dAJn28CKZV+?=
 =?us-ascii?Q?mUHG22SwjTFL8NCnb/Pm3L5fwTOyg/WeaRCue37CsMG8Ph9qMRFoNjn2uNhH?=
 =?us-ascii?Q?dqzWoIE5pnyw225bwwU1kmw66GrBb7XlA94j7Ax+a4l268wWuV/zYDMHmYqk?=
 =?us-ascii?Q?49gt3EXDrW0S/wIRX89i15JB1TxAuGxGDaBcZwJmpo5wuJ+i8zbtmaR4frLh?=
 =?us-ascii?Q?cB9XO3fqoxBaPiv+4ZT5TF0VAxXFnIsqHPV/qeckP1XMsClSmGrZsZi3QT/f?=
 =?us-ascii?Q?Y4PRlWemL0izbYRQPiHM+Yom8V+PrTRxfpQR6KEJ220aI51b98pF6qlXiDie?=
 =?us-ascii?Q?fuchZcdVhc8aO/Gk8YksqFrHAADffGlf+h3SqRik9IqWLSZwlA8GSZXxANr5?=
 =?us-ascii?Q?z29NDYRacP9FUaUFV2syj773iKQHTi7YYyF38w6qK3ofrJudl1AxCO5xiDi1?=
 =?us-ascii?Q?S+3pqu/TGh84k/iKY0TnCPV7KxBGxUPkMJg5tUlQZhDCcKPLFMxdkbEhA5uj?=
 =?us-ascii?Q?AJqom0YnCsZYUVqn0hyDGQ/wS5tVIHsNTHSMDGX/jA25l+XyVoxK/6pyhacY?=
 =?us-ascii?Q?oiLlIPT9qUb010jMgrKQ7FjRY8TIgUj3HO0b/2HVvS9O7p4/8Ns7LIMQ/tFH?=
 =?us-ascii?Q?Ba8snyAoqG0JhJuYE+gppIh3ZTSHi4u6QnW6XxLIbJ2a+TzQ5e9UI5Xd/V9d?=
 =?us-ascii?Q?2CJX1AxMxdYinDVnTj4bLvA/tDs/tCGHz6abOenMDeSxHJL0FwKx+ywLU38Q?=
 =?us-ascii?Q?xGcmrHC2mlZDPorJiMpMgSwbP/KQHBGjWS9YTl0AgzPnKJd3AoK+U99ET17l?=
 =?us-ascii?Q?zTkdneNRn7kvIdp6Zxy/1+nk4H9N871WP8HARwA9gPGwgVT25exSCAoSV0wE?=
 =?us-ascii?Q?86aAjpS47dzUy9st3S83igeKH4UJBdZ3yEWI3tFH21V3gE0apxdBsXxwqZjC?=
 =?us-ascii?Q?rdOyeG75lBinKdQJR35jx4j8ZgaXderpl//QUmpLcI4ffkwyOwQBw1/OhaQg?=
 =?us-ascii?Q?x7ec7bxeXd/Dt0ntAMkXsnrpTK5XgsRgGFHl+uCEodpX99SgYsJdZXCJZo4A?=
 =?us-ascii?Q?qKjtvrsnM8nqJDEtFmrhKePgViJNfLhH98E8oiq7CA288TwsVETvkmq6DOd9?=
 =?us-ascii?Q?eeoqiNsgrbTCJ/hDsl16H1ciru8nXVvc7S4hPqjC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95d8594-3d74-4918-1c3f-08db666c618b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 08:59:48.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip0WEp9AiuL7c2BywY9C/CIcc1cYPeQWbtGeD4870KYvzM4m9tgsOY59+6g1VHlQ74anXzH33xACmZQlYA9c+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964

v6:
 - Only update patches 14, 15. Add a helper bpf_mptcp_subflow_ctx, fix
   bug in bpf_burst_get_retrans().

v5:
 - 1-9: save sched_data at mptcp_sock, for issues #342
 - 10-15: add bpf_burst scheduler
 - 16-18: add bpf_stale scheduler, for issues #349

v4:
 - drop "mptcp: add three helpers for bpf_burst", implement the helpers
   in the bpf context directly.

v3:
 - address Florian's comments in v2.
 - split into three more patches.

v2:
 - fix this error reported by CI:
KASAN: slab-use-after-free in __mptcp_close_ssk (net/mptcp/protocol.c:2461)
 - add bpf burst scheduler.

This patchset adds sched_data pointer into mptcp_sock to to save some
data at MPTCP and subflows levels.

With these changes, the old patch "mptcp: register default scheduler" in
[1] now works.

https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Geliang Tang (18):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: add last_snd in sched_data
  mptcp: add snd_burst in sched_data
  mptcp: register default scheduler
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  mptcp: rename __mptcp_set_timeout
  mptcp: add two wrappers needed by bpf_burst
  bpf: Add bpf_burst write accesses
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test
  bpf: Add subflow flags write access
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 include/net/mptcp.h                           |   4 +-
 net/mptcp/bpf.c                               |  55 ++++-
 net/mptcp/protocol.c                          |  43 ++--
 net/mptcp/protocol.h                          |  14 +-
 net/mptcp/sched.c                             |  67 +++++-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  76 ++++++
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 216 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   4 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  59 +++++
 10 files changed, 498 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

