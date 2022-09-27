Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645C33EC
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxHq7EdtdAjt2VeVxrakK9+kizLszR9yNrUXMfDNd8Q0HZ4s/ExIyHApZVCKxLQK5PfZkQEkHhwHa6QTHTc7QFirfQBNiLYm3D46AeJ4Vpy0rLDXRTexzSgPXJjBQAQ6p4Fqm3qwfKxr2XsXMBEinRK2HBYTZAbfJS+fQL6Nn4DSSZHAdctHBRbHZvIVWRj5zDsTgB5vwdUdkG+QZYuZ96KXcUTTOxbKflGC8E/xnvIckHz08ZWblGyUFj80YnbMqDLc2nsdpsWEeZx08aa+onejXAaAURfFVdJ6PpH9o/6nLLOtgTN8H+NnvKH8CX+DywHOHCzjEPqKP38IaivGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGJcqf0QjgbPCRq4GzATpygf9Lg6JuyjyfwGpJrlM/c=;
 b=agHh4VcUCrPSS+Ckd2hU05sFhXLfOE1hhW1hAOFw1OC5lW2VO9rifD6V1BcTAp3g/a/0Flm2lak7MOjSHm/gP+qvqCNygLpcW/CdExO7djuFOulzSowlQD4k+fz2mteUvXt50mddicY3wH/KWXho/RLSv/WNpHynBaifDAa/am+6XQuEIodLhNV4mfhUOkmetSg9kuZQfXGIRZWE6q2SnExcZd3ROJpS+vEEXFikLWyYAM1JyDHVxB/srQnJfg0v/9xtNAHPgM/WAViWUPiHkX9mhsxcK3g23UAEQGBLzAn48zsoV4h2YafeFqvUtc3daI0epgxJlSahB3/y6ehcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGJcqf0QjgbPCRq4GzATpygf9Lg6JuyjyfwGpJrlM/c=;
 b=2EFLG3iFj9sIqLTwTSrM2S+NjmjKON16wcmpbwBrtPUvqH5qtRydW/QFOLUmFpdBSK9wOyz0uwyti66QesdPRjhi+Dmu8iki4o0+jObEzOlRPewroQe/3n42uA32MAw18UJ0AGbAB1MOsRq6p2wU8J2vz2lU4Lk07Lg4BWmbcT1dKiQD0Aim46ERbXyI+aTI0lFkYqZ7wIq+M2luZo66cLld0phAypfwWcIRQRR/Jwpym2zY89FUJGkeCfKL1GvvCBIaZMW474YMzQ9LG7lUodO7KOjEismDoGGoaZ/jfwAxWClf5gutC2MMMaJjNa+E8Q1NV57jms33+MrkTlRSYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:26:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Tue, 27 Sep 2022
 15:26:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 0/5] BPF redundant scheduler
Date: Tue, 27 Sep 2022 23:26:59 +0800
Message-Id: <cover.1664291273.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf72390-b1d0-40c3-117c-08daa09ca11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cZ36mg8UWteTEw78Fzg6nG/HOvk1BtlfqAJgFL/3OolpWZ2RZQsiEG223q4gdA37nalnh53wtdn4YTYA0qLfM6SZcdns9oL40kDxmQCMsmULDIMtxhw4zkDyruwRbfzb7owxK+/IJHzhtgHKL+NHWoTYvf3MgZYVRyVCH6ZIW5pSq+cGmPJpPEoTh0l1iGckdrxRqPDRxrm5ucpNu6AQCavTJcu2R4TotyQQC8TlQnX2UTfcKLxo7ihUImrVtUQcKbfiU+U1zlC8nbhpZ3h0Ok+o6TnRbnKYhqL4bza3DTYvEkKcHKAO/plmgXrRVJDnmBN47Fg3tBEpDevEBA2AOFXc/2O/G1xioLQ/XpxUgSi6YBHE0WNE1edTw4lkZ6/+bkRXNmImqKojZM1MS6OPS9WECmXHIczefDX1NUDrPLzbQDvm6wVFu1oZw83jRUuWNMFaiUIm6cGqWDSv72MheayItHbnG8t5WZh24ypM54fQLUJOh4LUvqSWwPFy9GrAw7F/KrHXu0UvLp9atUlH40N6FQiKghcpsDglHGibaZ5l9M2pooGSoQZHUHnliDGFoXOZYJagFxGs2QWbKAxXo1Mwm6kSuYTZfG+DoLjGEeg2egSD9w+JJWxA7fez0NodGdZ6ADzfzkbrT6jQ6SxLuVcsRrt1EQ5/nVv4TLLRlBLNsqBg13poH8zvmGI/6wlDYAcbaD/WVhkGMJCQFUVH3H066ZXqtBNQHTbF5tijjgWytnVySokZBRJBeP7qKfoZfvQYdcv0g1JDOCo4GFjLnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(66899015)(6486002)(6666004)(107886003)(6506007)(316002)(66946007)(66476007)(66556008)(83380400001)(4326008)(8676002)(86362001)(26005)(2906002)(6512007)(44832011)(478600001)(41300700001)(36756003)(186003)(6916009)(2616005)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wtssDEahRf7rSAGNqUVfBc4RoRNM1RNEQIBOAZ8bc1fgieaMrddZGAFnSn8L?=
 =?us-ascii?Q?bskEFgSaMjOpovjGQZZxsgUJamSpH+djw6gP5u2WyuMPHcnbVN4XXZz9lSa0?=
 =?us-ascii?Q?OAGJFgHPBG8FImlKsH3bKWYnphqiqPGJmQs8uLkAiwNs5iACFoTFZfV7k3Lf?=
 =?us-ascii?Q?+PBIMR3UjE+hgEtiP8FM+eTQPKYAxRtD0z8tkTtYw78wl64UPtRXTggowNSP?=
 =?us-ascii?Q?weOpfw5Bas3ZMdv6oDSDEJ/hEbZeNisbwCw0GTvoKhyOiAjZ3OVDChr4zcgb?=
 =?us-ascii?Q?2WibhXXRP8EcTcCblm1X9e+Val6TndJD+XC6lCv0ygsfat2Xxu2wdFFHs8m4?=
 =?us-ascii?Q?EfcOS60dIgoUoW2ofREYXLeqHd3+ajJrJvU3twBStRugomqVtmk57zaEmlyX?=
 =?us-ascii?Q?kr3Aq7EbiNxkDJ5cloUxfNdrwG/FwnVGHZrp5xjHn9wHloOWECNcst1Jta+y?=
 =?us-ascii?Q?GJra8Crlct946N84gvnidVfmignzF2dR8d9dviwK4CaAkQgLLfjbL00RjY8/?=
 =?us-ascii?Q?MrUKV4rllViCwVeWnwSeAuAzfBxoD/kpte/EqW9b3a1yLWsZ78iJhyAJKy+P?=
 =?us-ascii?Q?Rm/W3h5cbZKWgJqdMdbq/9+jATE8pKhBHtVqxbLzxjX+8OGxT+c6iatM0j1Q?=
 =?us-ascii?Q?4wN/5t8Bt7PqpzAXA31PFdZuVRQEzXmO8qf+wm7XXXVHLziHid9aAbQ9DAie?=
 =?us-ascii?Q?dxk+OHizU32ac+HKE8nYAxHxI61hGLTFJH8u9Bx1cK34rBQZ6PjCzX0RBca2?=
 =?us-ascii?Q?JdetdJjz4f8NYQOSt7bDEBdxSbjTcjeXbPx/11ycA/s35jktc/XeV+ulQsZb?=
 =?us-ascii?Q?JqCg++dzZ+l4TXBr5ZzhJQyLZVJbxFqCUJrql1Bon/oXTksFJMVozRf6kZ1x?=
 =?us-ascii?Q?FhtFh24zE+0jge3/sU4GTwqKNkMhmJjK4JkmtA400E7hR7k08JtMuXfvVg4e?=
 =?us-ascii?Q?jXFrbF/FpDnDULOUbe3jeaELVbqimLL3y1tW4dTPLLm0Ujj6FydKQFMEvYnK?=
 =?us-ascii?Q?gQKYtS+rJDmC012Yb54UWXjbigF8iFYGNtLakQlm4kCZoExUnIo/h5EYY7NX?=
 =?us-ascii?Q?AYC9a2Z6kSoZbargh89KUaSMb15fl5RfUVrhFud3pMkgZxt2gMFK/CuGn4QM?=
 =?us-ascii?Q?SXnNVqSdhrafxAY/2Tra0yk0Lp7LQH5X98Gd1Il0/rxzfOcmPuIHfTOfuB2m?=
 =?us-ascii?Q?a2Ekp8NWI0M026mk5RYqkxsnlYB1+D39bboovvnoWStL/KPTydTEvUJ4w3S3?=
 =?us-ascii?Q?3DvklRstvTL702J2m0qtsdV2ZyYR2TG2N/g9Pk/Ag8QH2Ve34yjCZnSTx4rB?=
 =?us-ascii?Q?zf5NGbe95BvU8QpjZDIhcIqGQ/Ahl5EdtJxO7kbkhUi/d4l2Nh9vBgoiSIkR?=
 =?us-ascii?Q?DlVAns8S9JE9Gy35k8Xq0+HthcVE2lc98SS/DFrdJjEkrfcqf24pIvPYJooY?=
 =?us-ascii?Q?DUc2wX7UNV4Jpfe9VnWWUa8H4ShxIAEcUWrrJLoNV5BX5LPn1W4TSxPLsSz+?=
 =?us-ascii?Q?F59ilenqfrxVsG1O93d61P3LWrWunDEx2u5tR1VFGH0JqpfzPsbcwPjBZzhL?=
 =?us-ascii?Q?Kj17g/Rg3wXxOolWhV/9dOLzLFPTFIi2LLC+xfyP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf72390-b1d0-40c3-117c-08daa09ca11b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:26:21.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYEw9t32JdFxZF8PO1kL6NUINOVf0xy9CWL7h7mXHkeRF9U3wA/x1KvuXGVsfLpijrR4WD9I93yw0dor5ImSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087

v12:
 - fix WARN_ON_ONCE(reuse_skb) and WARN_ON_ONCE(!msk->recovery) errors
   in kernel logs.

v11:
 - address to Mat's comments in v10.
 - rebase to export/20220908T063452

v10:
 - send multiple dfrags in __mptcp_push_pending().

v9:
 - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
   suggested.

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

Geliang Tang (5):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: redundant subflows push pending
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 190 +++++++++++-------
 net/mptcp/protocol.h                          |  13 +-
 net/mptcp/sched.c                             |  59 +++---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++
 5 files changed, 231 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

