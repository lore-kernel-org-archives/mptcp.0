Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130073.outbound.protection.outlook.com [40.107.13.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E457A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnBskC4CuTcTZ9jYkqW30nD/ACofva2P/GanVUuy6mIHIaldxqoobBQNZom6wyOs3atsu/y45tlMcezJWV5BC55EeYJ0YQrbcR2cKgLW2GCzqxqya/rjePRjZVl6XNrS8fG9qPfcXLIzZ3IuwDGYBYxwtSBj/tfbm693VoogXC9uNiv65IzklfX7IeihTEjRX2V0GK7gV56G0sWaUjRzrFfH9vDhl6mxdMT92kW6vB7JftrLzECrA9MFhQO6pak7kcOQh1pcxmeJB6Comg3gBCANL1nX1nzXR1qblTIelZUMoRkXab95rx5wMgYAc2jyQZxgC6NRLRgcCK3SaCZyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5zKHV/d28E6chzi1AqmTYba/gapC7Iiav1oKUSRYPI=;
 b=fOfjn+1MeOM9eHIq7dzQmi+XXsWgCwUXmziavHXVJonjXxvi2ZrgVYEySgZVc/teOEQlPHi+za/iQGVAJvyIA4H/WMfn8ovoPrR3eHawbfLfMRqcwZnA+PCvlEfVLWNijF+PKIqbkcK4EeJ9Awknl/Xw30K9yrfFrDHF/0UE69aoWQGckfBDT7hZhB0HSSOegcXUrO3XLw21LiRI9NKpZqan/ffC8KWHROZR29LPDiRL4gNnz+QhOXzWCnlu4t6xQTVFBHveBdvgvSgawzelN7m+S85GA9bpxdoqnHz4wjiaZk2sqhIv8Y89oiI6UOdyyq9xJvPjRm4f5IH7oMOcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5zKHV/d28E6chzi1AqmTYba/gapC7Iiav1oKUSRYPI=;
 b=4pjKSxGB0KS10Lu4C0wLblhPqibsY+77JYEWJZnZXmAUluRI9/TnVOuBMQecCeJ5yrGOwZElFS8mHjrXRJwDmE0iIVnRdVaXtLoz0cJCWJVnWD/BFEKuLU7xB1Dv/foBY3lTd0W8W+LI4QetHCWbuid3XG6rVUyCP4kjfzP5yIvC4beN2IxP4VL938TWqHeCs8MJpJZmiR+CSSJvjwBDQEHf7n1AIAfEaPmdGccmvOG0pNR1GZk3eulpa6XqXomU15OhESXaA3xHJeXpYUpqRqcKYSocnzhIFhmV5TbOA+XtQSKk8Bn0xj1EQ1nA1O90pWfieLQaXN4wvQIUFZbRXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 13:05:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:05:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/9] BPF redundant scheduler
Date: Fri, 10 Jun 2022 21:05:25 +0800
Message-Id: <cover.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d4a5d8-2c33-4a27-5786-08da4ae1efa2
X-MS-TrafficTypeDiagnostic: GV1PR04MB9150:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB915013A67120E2072B173711F8A69@GV1PR04MB9150.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMIRxOLdzXf6UNi5s6i9riyK1DfBit/y/qkwhjZsBprH4foQ80ewz6gzdtTG3hiv0IYjgPpT2Pu752UoWdYjUoCeSYCX7hQ3691WVOoa0Yz1wy8tqH7/xvyaE5YTM5cXpYEO8PKQmgf3zWK4Fs4vHNhzmVXhAE7nVrEO2xAJTGB6ufAOZG9P4yg99XBM39gre8e7zXuUrpXVyATUDIr/PV1JywAk3TPMsfLaCFRETBu+I+As4gMbgqAnbUlT+xfzgTUW1GTfPdPkrWsMym5ngtht5gTU4mjzhwnwdENqi46vpPYMgC9u231zAm2dmyMpf4J0JmEss2gyLebksSLtm0lYFky7YDNYP69Vmz5jBAdEbBdjz/J3yl9pDg6cdwvan2iHfRA2If5rIoWmnroBIMkdYy1etfH1QXv4/YG5+XlPLMMEttrcrMXj1AG31j/mGk3sSj4vjfbeU0N0vI4W+ltZyku0g1lT+SECF1i4LXGEDSEe63vE2nR7TM0nHUf731YkZzKfDeatxzf8mT7GX1lgb4HQOpmPeKNR31It0U1fW6WjnO23S12iFHS+DVgmeJ2hkbMONDyYMv7A8bIx/9ANG7mbwvUJIa0zcmWfua74j6290pSK48uJUNuws7eXzguRhQOEomUTSoidoqYc7voqMs5fzVLhLht/FYswGXlW40vnsEJSuXFswdiDoFhoHh0Gva2C7t33BrONCme7TSY3yap1rbCCqVM81Rgl1lMsYxQtkz42I+GjrwqXu0UcgHoz+8CgVheVYhdqbJ17yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(508600001)(44832011)(5660300002)(316002)(66556008)(2906002)(6666004)(66476007)(8676002)(66946007)(4326008)(6512007)(26005)(8936002)(36756003)(2616005)(86362001)(38100700002)(6486002)(186003)(6506007)(107886003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pthhjbbIHQOELV/Wxp3BopgJ7dHG2BVMmxdq+nitPhzbGDcTo6ue3AqMweYK?=
 =?us-ascii?Q?jgPbawNnyEF2QMq5Pa4X3tOTTEXfbWRat2I0cAKhim8XiWWLVmXcR7KXf2Nw?=
 =?us-ascii?Q?vEs40u/YQW+1cFurbT2XAg2iThmzBhLo6naGdrWiNBQ/v6SwFXAwxZBgGrST?=
 =?us-ascii?Q?rPxwLd9HU8l54fxkToi9meanBT+dKYtNkZCTdlx/E0tyj/jAsZE25AVNzdSE?=
 =?us-ascii?Q?Hpxmypyay4SJb7To4Jz7QyjrB+tNA9SryLE9cvge1HZ8wru6Ef4CAjXUM4i/?=
 =?us-ascii?Q?GTWRqFUQfXHQOdIJZQo0VgqAFNVfKCImv3mjO0GFln2+jwej2vI/DO4D6UQW?=
 =?us-ascii?Q?3hv35qkzG2P2vlC4M+jnVkHy+i6FKGV8oWhB8vykGJYfY3yXXdP6lkf+h5+K?=
 =?us-ascii?Q?3YM5KPKliqHk0eKwKpq9gwNDjtbbGq6c+sOxXFVirgxTRe/fSSyemTaGBjdc?=
 =?us-ascii?Q?nnfyvtztQrFKOO9ztasNG7Z4umjOGpVM1JTzir/ZHE2+crqghoZPpqy/kJBc?=
 =?us-ascii?Q?BsBYkWW44rFPaRdimFzOw0ytnH+J46cNpjxHBOdadEQkMhwwqrdNaMeHxnWD?=
 =?us-ascii?Q?hJ78VNz6pp0yG6tEHAPg1Q3SXdk9KNnA8eN195XI2zlWGOFFRSUjlh/Akkth?=
 =?us-ascii?Q?+pYJmju2oST1QIpUQ6rkcRPo4zrC43yJMXdjnVjoyp58XXI2GIbrCHXviYYn?=
 =?us-ascii?Q?QsKqXaUtdBVAMKm4rr0beI2A8I7pL0kKC8tmjXLwigxTm3Y6Y89pFQbzLoIl?=
 =?us-ascii?Q?N5K0fVV6BCHQrTXX8Sg5PplBgXIpk3Eq3wGulwXT4JE9bfWDl/q553K7cdxI?=
 =?us-ascii?Q?aDWsMCegkmdTwPkNbVE7psyehHQYPwbQRn+NeDn6bg1QoWLFsbS9Y8N8KYLP?=
 =?us-ascii?Q?PLb3AffQghPGEyt2t0HSfMA0xpng49mm0jc/Y4SA7gZwv+SzGOG5oyFF0ry+?=
 =?us-ascii?Q?FZHGqpmKm9Qw16+pgTX7nG+B7g8TdvrMicxuIoQee9fhIx7O5JE8Vbcomr3E?=
 =?us-ascii?Q?ygrqHaSq2TiiP8KGs04Nb3xchKPYKV/xH/27l619IS59GrIbunFVg/lzAQQ1?=
 =?us-ascii?Q?UqolMxmIV0LwAcHPM/HtA2KeItbhChZczGYbd+QJY2xMHZ2vtjeq4v0F6EeC?=
 =?us-ascii?Q?TtVo6stnvIA3lfixBxIsqB/o7HCtuKiNtE1uVMEb7zrqn50uR8FKYq0BG/5L?=
 =?us-ascii?Q?5hbXJeDM3XPiA7GvFPtJspmn6Cb+idlIIlTSdwNmby5CoeLq5qEC0W1Z37jj?=
 =?us-ascii?Q?cYGQSHWeYHcRdygKWM2n2NjLj3FGqliiALLFqbmaPy8lr1vCnoJCkxbPBwLl?=
 =?us-ascii?Q?RKw4+sZSRLZnTMbhFrGErAIJ4OC9lTv3B5YvN2/TI2wtlSfcQOOBFL0Yb9GG?=
 =?us-ascii?Q?unLthiESMMbr9ukekR4cIzQ7r4Winy0TFLKnHAgXZH/2asoBi2cXasSeIN9F?=
 =?us-ascii?Q?o4RvS/uuZ7W8N6Lt2F4WXM3E1ptaR5aFTxJ5u/9PCHOMyF5r03kBZOYWvCV8?=
 =?us-ascii?Q?r5PBWnQsGhgGvDJbRAJ2QbARUFXNUltiZwo4e2gP/61cJuBn7uzyFJ/PLqsD?=
 =?us-ascii?Q?kfiIQ8vAFWpUoV2sgGbt2/AFggomWbvLBipjAbKMkW87/zJENU62dVq9n8KZ?=
 =?us-ascii?Q?VLCAJRky+zGA4vzjQret9fXGmomFdURV4qmDKq8mpFcF7a/6nNhsT3jdKaU0?=
 =?us-ascii?Q?Y0TO9WFMUonAoX4K5xSVxNpq9TuhVAnJRPb0SroeWRKE7fTgg72suKZOc5ss?=
 =?us-ascii?Q?6arucvXJh27RvZUSmxCn5E/ThZJz71U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d4a5d8-2c33-4a27-5786-08da4ae1efa2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:05:47.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4IxtKJ5N9/8nsFw6DfoyiXosD/MS8S5cyyhSlfLL4vMQ7HzvGWN5BuQuzr6oRuV8yEP9XUpUhY5yMaR9SQPtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150

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

Geliang Tang (9):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: redundant subflows push pending
  mptcp: add sched_get_retrans wrapper
  mptcp: redundant subflows retrans support
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 include/net/mptcp.h                           |   1 +
 net/mptcp/bpf.c                               |   3 +
 net/mptcp/protocol.c                          | 122 ++++++++++++++----
 net/mptcp/protocol.h                          |   4 +-
 net/mptcp/sched.c                             |  62 +++++----
 net/mptcp/subflow.c                           |   1 -
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  37 ++++++
 9 files changed, 215 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

