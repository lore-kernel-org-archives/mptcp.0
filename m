Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33E194
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 12:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXM8Tg5EncTlRe+vhMWDtP38IM3pZ3bXcoMRQZ7I0yI59DfolFOjoH8kIdAAdMXeICwbhoIdDHQC1tL8QIXgrWEB/+RudREua2qVb+AztX1+rdMs8I0qKrv++vo6k9lFxK5NseyvpiMHCnZF+FI6l1cE/2nRlIGBRVaPiDwIxpf8DtpGPAV0k1Cfng6Zs+9CPvYC9tPLYwXni6yRGvj3Au7sHCj7ZHlVsKaHXRZKn6NityGN1Tr34hxajaMVrnPo8jv9O+2H8p2wB4Z0LHypyMwS3vJfSxbpQk86LRgfe21cBQStyNkCRD4yfeoHm4A4d1ft1fwjU3k6JXwlLLYtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnReC0O6IO9exFFwZZdstsoWH4niaAVrIC01YYp3ZyQ=;
 b=ANFM//zjEeCzB92svJQ6LZMNCFj8szp56hrTkB/K8bOKME6YT/ePR+sehOQsSF6x6P6HG5vw/q+nP3R+1QV+L5eUOZcfnKG8VFfSi6CGeOsuBM04gKBJOT1dStKTpcAGiK0U6UHxgxxK28aZow8ckLTT+JgKeVc0H79QwioNGkFz4wCp4S7otnH6N1vUMWVTDNoUiEm0kvTeJFBB8pitoz+7Je/0Wr/+P3YW9wCVGrkMC4sQo8KpVL+J8gykfTi4AsbgemMzfFqmkPZXrLm33lBayoIz7pMUYNmxmb6VFNBXRdekl0z6TWvdThEN/5MippZnHWimGEJw5o0i3Ext/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnReC0O6IO9exFFwZZdstsoWH4niaAVrIC01YYp3ZyQ=;
 b=z4uIU4ZyrlRof0B18oCL1/Vg8WGZNhdBBfZeL6Oq+YFJM3cgvU/iz8FrEYAqy8yuXUEtVdp4sBkSGTAi96/6pqhPW/9IqLR4Fa7ojE/IMjoQ2uTdlSU1+aZu1mB6iX/kAGS7sh9ATaySDCaqzuDBBdtpMvNdflBOjOeya9YE5F5zWLKiD/rD+oB6dHG/lFUNftUhJPBQUkkSe+hegWWZ1jYrxRMfTInau3UoXP1QQvohBbjpIJHkX+8/ZdrQ2ILlFqoGlfakHDTpuG6+Sjmw1TY+8y0Z8TtF1mKlsxoQ/tqC6cxYZWXtIWNF5KZrSxqsuZYNz0tohk7KTyeEI2Zgdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 15 Dec
 2022 12:32:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 12:32:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v25 0/5] BPF redundant scheduler, part 2
Date: Thu, 15 Dec 2022 20:32:38 +0800
Message-Id: <cover.1671107241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 50860831-cebf-4803-c342-08dade987472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RVPG5lsf5EwkYgS4jjmwfmk58lLFjY6QoVZa1nHOW69qFST/gy3Yk7/Bplb0yzhf/F1urW0Rz3nRdJFcr4JQhaHV3QZqG3nfQvWDKa4xKRiYYtHJIggAtRiExAzz2ZRrDA2mhSnP9kkHwcWIU2vX3iIfAAj3/VpbgsuANkrAYkKtEdDuO+cHJnR0mjw6qM3STkVfvFDc1UO/1vOhRhL0Nrw34Vo6l36WwQl3qI+Q5Vo3J4JBxbWqp7HI2Czw/wmPCgyP5450zM45hYGs+LnGM0IInvT6CbPzWEpl8OKqXVk9JAs9fdhMgxuKMHbrRuRb3Kvcx/PVqgyMPwzHbEUufd22o17ffqraq9kmbihMPJzy1euoAlbZQOX5waLTY/MKTDZ8ngx0/sSACtWVQXlQzY9u5hvCzn3GkqQZZw8FazpAOjKbzOTLo6Hwr/oZfDSgiizTKaN21DIWWJJZnSkD50IsB+S9PZYZfna3pJsxAq1N+SOb5jUKfVu3N/bUqQSeRbnqKzipYw5MfnZHWfLpShAaSRXAl9DOYxhuvsWAPlmOcqVqqSj5Da3I58x3q9PELEo5upZTHYh3ZUutz2rvrzJNGT6CsJbfvabnD5rnvZAqUkAh2NiXAM9t/hDxRZLB85UFTbREjCr4Y0m2rZSWWFjaCek0LhPbEpcpARCrAx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(66899015)(26005)(478600001)(5660300002)(6486002)(6506007)(107886003)(38100700002)(6512007)(66946007)(6916009)(83380400001)(316002)(66476007)(4326008)(8676002)(186003)(44832011)(2616005)(36756003)(2906002)(8936002)(66556008)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCykAdP77DNWYMQdP6CnRoFe1BGKz0HWLWvxKbGUt0jnzpUOwoXyQNtGUqxN?=
 =?us-ascii?Q?9So610hkhOra/4K7CIooDsT8yLiqN+xLWZKQtmF8voLd8B/fdifGbwcEceD1?=
 =?us-ascii?Q?eJI08n1JM6Ya4Fy75DF2wvHuLj76dbk/eNwMRkXYed+P25Qs9eIkusLB7XBU?=
 =?us-ascii?Q?hMGLxibCvsanXQdQ0W6JPijadD2g31NuwtR/ZqlsMMmSjqm4C4E7HcHUYBIK?=
 =?us-ascii?Q?CuFLNJpC13BVk166n0Mps0+bAfDBXrZsrKwdbV12rMhyMRGELC9e+RCkK+Qj?=
 =?us-ascii?Q?X3L8Km7Gy6lXVS6AKaWXFyq0dQ2hZ8zECVf7JkvHz1Ai9288hYaq72L8Swl1?=
 =?us-ascii?Q?2XItILI+xZ/YHD3CTlD5o1xA1WWfwywHvFP94u1OEnsL4pru4WDvLEW2eDW8?=
 =?us-ascii?Q?7X12JOmUEc3M+M17Coxf6Gi6g64DTL+x650Ht3ezwtiuYuL/infVVHVRh7D5?=
 =?us-ascii?Q?XvM3ogPUQfFe/8QObI7/RfTk6Oe9AvyIHMrj8csggbXcAOpnkY86FqQzq7xz?=
 =?us-ascii?Q?+jelMBtcQLlMb6uGeqCKBOY2Vi/UUvxXGwwYpsksWGFGS4Bbfw8zwWB/N1Rv?=
 =?us-ascii?Q?HVAmo8r8jGEQTXYRwpGJDKtdJk+Q9Ltv3INK/Yoj4moqVl9P7oh9TWLmJMp0?=
 =?us-ascii?Q?CQuiFUiTEIeL73Sht9R62AsvNU3Q54ZLjY89/0qTLAdGNNMQoHLE8Ji4jpsj?=
 =?us-ascii?Q?AsVoV0JmAforKh8MI29Q6AEdnULfj1NkkAtgux3r4Y+GcbYJeATwcVSNaaB9?=
 =?us-ascii?Q?wS6/8jBltal6Fc/QuBoWa9u4GyjSrG3muinqgPGUJF/h79ktsEWyEVKPv09I?=
 =?us-ascii?Q?SF7rg+JoB6uHf9RJEJEcvNBhESvoSC6Cw66WUcKhj24O1BXm58SSQElMapG2?=
 =?us-ascii?Q?eHaCQCx6cYw42ObpWihw80VL6ehe0FZ1PerPF62TYqL5F4Ds5rDWl44neJTN?=
 =?us-ascii?Q?8Sk/JPpJCJrBDSbYC+Zqgujh01DwPIPwirflXO5B4elDChp9w1aogaV3bT7U?=
 =?us-ascii?Q?/ks4ZqDlypITPJyu784kwozmsP3n1F3MXdwZAGu3t05zR3IHZc+20IoeEDoC?=
 =?us-ascii?Q?/2T782r9/Mm1Kag/HtW0bbI6hU1tP7anbwZ4LbyLojeDuj/R1xELf+qAOTyG?=
 =?us-ascii?Q?wLUklMyDXdk8RqpgDGq5w0X/g1dU199cNUILAMX14TypOov9wY4dTmycLTi5?=
 =?us-ascii?Q?XckNdQn8tzdyc2T9kL9BZ2QQS7j7b9RGLAdwTvF7lIhoh1IMXdY23PpQVfIi?=
 =?us-ascii?Q?+lavY4av9562gq4pXQrPSfGNR5WhiENAaVNbSApne+EX1zbX3jW6BnPbNQVc?=
 =?us-ascii?Q?cnfCARaqzI71hVF3uW6qe7VgPSy5ypK7i4d+NrzRyy0zlW9cR2Gzv179bsiq?=
 =?us-ascii?Q?3YAul/DFAFIJy+MPnXZyB5UqUDpzna6hcv3AR4IP4hEyYJE/oUNzLZ3viY1L?=
 =?us-ascii?Q?a5ieBLsV7+qXlxzl9NEWsLxk9oyd8Kr02KQZqjYMWC7z9rLC1LQi9vBVRcCG?=
 =?us-ascii?Q?MGuyv0MxJ2YCueqvQMftPsDdsmFK5ySPEn/zTdilhFFBFn8YZsl2xmaEVwZX?=
 =?us-ascii?Q?XkbbQ1l/EKMUWkGTuHwRn8BJQI8KLorM99xhKqh5mZGY4EGgeK4CezjeUBUe?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50860831-cebf-4803-c342-08dade987472
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:32:40.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e/VnJHSbabNUiiJq6mIX9uGCPIlifzMdvvAIudEbdxEv6oxiXbGnFPqipT+ra8L5zLkWP6J56rXKgk7sOpJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675

v25:
- update calls to mptcp_subflow_set_scheduled(subflow, false) in
  __mptcp_subflow_push_pending().
- rebased on "tag: export/20221215T054923"

v24:
- rename push to keep_pushing
- check the scheduled bit on ssk first
- drop delegate flag 
- depends on "mptcp: use msk_owned_by_me helper"

v23:
- patch 2 and 3: clear subflow->scheduled flag on the error paths.

v22:
- update patch 2 as Mat suggested.
- patch 4 and 5 in v21 will send later.

v21:
- address Mat's comments in v20.
- redundant sends on retransmit code path.

v20:
- rebased on "Squash to "mptcp: refactor push_pending logic" v19"

v19:
- patch 1, use 'continue' instead of 'goto again'.

v18:
 - some cleanups
 - update commit logs.

v17:
 - address to Mat's comments in v16
 - rebase to export/20221108T055508.

v16:
- keep last_snd and snd_burst in struct mptcp_sock.
- drop "mptcp: register default scheduler".
- drop "mptcp: add scheduler wrappers", move it into "mptcp: use
get_send wrapper" and "mptcp: use get_retrans wrapper".
- depends on 'v2, Revert "mptcp: add get_subflow wrappers" - fix
divide error in mptcp_subflow_get_send'

v15:
 1: "refactor push pending" v10
 2-11: "register default scheduler" v3
  - move last_snd and snd_burst into struct mptcp_sched_ops
 12-19: "BPF redundant scheduler" v15
  - split "use get_send wrapper" into two patches
 - rebase to export/20221021T061837.

v14:
- add "mptcp: refactor push_pending logic" v10 as patch 1
- drop update_first_pending in patch 4
- drop update_already_sent in patch 5

v13:
- deponds on "refactor push pending" v9.
- Simply 'goto out' after invoking mptcp_subflow_delegate in patch 1.
- All selftests (mptcp_connect.sh, mptcp_join.sh and simult_flows.sh) passed.

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
  mptcp: add scheduler wrappers
  mptcp: use get_send wrapper
  mptcp: use get_retrans wrapper
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 187 +++++++++++-------
 net/mptcp/protocol.h                          |   4 +
 net/mptcp/sched.c                             |  69 +++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++++
 5 files changed, 264 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

-- 
2.35.3

