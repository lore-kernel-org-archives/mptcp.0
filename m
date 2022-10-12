Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FC17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzJW1WIiVGvSyH3rhZrqXLQlF7lt/WZ4q+nykMRwcX42VCimL2O7F3uLL5iWpG6D2v/ZB87wAL+RVjpIDDXM7QaCstlqPQzcENCtruoBLvFz24JilVYobbaHYPJ2KRXGfyGsknMJ3CvwLc1hqAuPyWnU0YCdaSE+ao4v15Q+ozWN3FmqDmHLFUFWDnYsVT8FhkuMVNIae696YHgHKvqZ97xBcovsa3Nuop5DmRCd4yODFmzW2NLKbWDelDVGbM4rSULHnXKZ0N174OP6A/hhlzO8e5XIo7xRleSwlyONW1TKGNLBkx8PcnkgjVzi08j7Zu9CucbF2BK1mZzbFZ3U3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NAzwtDFbpIUwHwByLTGsCfexGOXk1N8mJzhLu2sZHQ=;
 b=EtAVzCEuJzmdPAdXSHBLaFvQqx+SVPkdEjedwRH6qRjEBPVOyVMyrvseTjkkAbxF3jMHLNE63ylpqwLnSzjlvfcvFss82b+fMk4fZIei9Abu1FYhLbCyVUtKzPqxIh5KmU+Azg+7LrzRsdiDsFJQPvmjn+/jPYpKggMqguOPPEcS9kfuWjLrxRjIgFGxzZD89PsDmq8uLDs6tApAyQOTuv1xW0UAnQJEllrdowVPbsI+LPc97O0lfirf22Vd6wPaAw2RpDpeM1/dfL05L+pc/61lWdP6HOSSvk4Uaf25iC9O8R6VRVncltc5zKisFOCUP9XZBFdSzT++L+FGIdElOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAzwtDFbpIUwHwByLTGsCfexGOXk1N8mJzhLu2sZHQ=;
 b=r4bPUHzq8GVqQBdJ8PuobGi4GA+gFkJpIekkXK6DPXATHVXmKPXIoUrSZ7BSeuIilQSqaCUOT1HiNEt22md8+dG8DxwUW5DuFcyr9PS3YGJ7FsXT0vQbR1bfLnxqZLL2gxZ9x7bT8HjQ2M+lLeR7M2AIAF/qGDRv8mS22EcQsIuzKPydjR4zhEp7w2N0DN3WOrpJvC13FPXy3MUreLDEQS0SXXzkuO6m/K4+tUcJtvJ6hl+CxnhlVmzkXK8l/4s724oLXFypZBzdtDuA39e5whV6oW4aXVRiai+UOF5VxeriHVJXebunrmOwfnwd18PE5FGKeuIAr0BMgCgjTnL3zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:41:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:41:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 12/12] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Wed, 12 Oct 2022 12:40:07 +0800
Message-Id: <811dd5cfe0553f4f1cbbad4d159f96f6cd826310.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: ee081ee6-c983-4c77-e215-08daac0c0bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rg8jyIlkZcpC6HASmF27SKxFNNi4W+g43brcxty//9v6iBbXG9kIffovMCfDiMJ95EHpluxMk5/OC3RlBwPu7a88UZbEMfVGaOdc/yBVZqQjEqHwyNGpRx1k8sUdZeB1fXZI/qc2c+9JDeug9Qe8Yn4+JN9dUMkv3nE5wUF875kMLXl9VMm6rzChFWn/y7rH6jHbqm+u9ICPtdGWccZ4c0DjnTt4xHFx38rwlz7X2sfan4GU0UurckCeN4jm22XTMTyitn+CqSPJPUIZZs9QTDdPrHoE9GMM2EhR3BjsRPoL1ptPe80c1d3y0hoMQy4Qhm6H1xAsirkwbT75qPtdFb6aQJSdbp1WfYiOk6ipSzrzd9OKeDtnkFFQLYvDJ0r1XN7mHXSt0f12YyBqAF2o5BLxfI1ExAyVmGtT6G1e2st0LfKG5qT18YCK7fxe6U3Wstdsj5n0squ0L1VBGbUuj2+At1XAmV4rN87vP3OEHdxPkG/eDEIBn7lztNbujZQ9eqIw5J6mMS3e5uaCAFwgy1FojBi93cLeB2oLPmnlYofK1urv6BSDVmiCZmEI5FfZq5CHMiwqTj385XjZz9mxMp7BQ5IHCBa2B46lAejVTp08X9t50/horWhnNZEzONXfK7oS5eDgpX+kzhD1Tp4fURA9IxXpg7S4WWrGZho/tiotYhHvKCJV5N8QWRH39vm6b3qk5PJ47eCIm/vig3cg7YGS4EQvYHaSDzy+GsPsi1KYSwJbuf/Uxj5vgi62V8LV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjAulsNTy1kDv1wUMFk8q/Cank6lCs/d5kod96qIeZ0qMO3gMNiKIfBnnqSS?=
 =?us-ascii?Q?64uk0l5DC2/vyrq2CEs2sN/+7UH104494C8fDYS7NjWX4XEDMGi44npcRpDw?=
 =?us-ascii?Q?kww8aBwTcl6wGtd7xiW5xFCU6HFbZZA5PFLmtMAgayDccXfQ95RfMk9cL3L7?=
 =?us-ascii?Q?EWyCxEduNdfziwvPe745Q5wxH1peAgaZTAsHMD+0pbkN0XAmGRG6ha96WJYb?=
 =?us-ascii?Q?iLAexyKA/thEAToqoDBffAJDT8Oqtd29eWuUkDLMC0MUQn4ZckPttGSQV0qq?=
 =?us-ascii?Q?ROl3ioC40+7eNbtupgRxE06v6h1lvwMgzIsqDqOb3GKxPNGPMj7X6Zg/Qpr6?=
 =?us-ascii?Q?bnTce0MFuSD3HSBkS3qS7RATMVQXd+4JeCTNHMFORfoHsTvohOSc6Xtb9pBs?=
 =?us-ascii?Q?cxC056fXkIWMob1P76HSpRClIyM/spvpNIXemu8C1m0x+24Cc500AUNHIFW2?=
 =?us-ascii?Q?5EGFOTVqN7IfNlAPlYS5XoykR8OTE59N8tB3YBXoM3dTxO2JV6vRCIdbdoWA?=
 =?us-ascii?Q?L2LQINl3gSzpy3B9XIUJ88VNJAMhPEGLmIhLJ0WXive7qoaCSgUhDcmVBc9y?=
 =?us-ascii?Q?3wOwJ0lG5uhTfe64+LrzkxqtsmghoNTxsMxbjdoeTReH8cFyYzu/NZE/2qrV?=
 =?us-ascii?Q?dbeNv59moHY9jCzE0xBI6G67RjLHBbuoO/HDVdG0Y7GWBaS4qEVsHGAhgcar?=
 =?us-ascii?Q?doj5VPkFbMbhda18SSphujAE5mzEosCDPi3b8+BVbUSxSvtPAJScZ7DCMc3Z?=
 =?us-ascii?Q?fYUtKxro5ntuMUwcbNxHt1UkFU3BOSb7WYnn7CfeR57DbSAXMvoVmeq6rsYp?=
 =?us-ascii?Q?eygwI+y5FLGhQ9D6hRcR/CFodaMUz/PhOrCEB8LjNZgFa2SGJ/q7iWJVaOR5?=
 =?us-ascii?Q?9AA9k6/W45867K9PmvgTLW42ziGu3g/5mvpoUwr8Y99xwTPHhCLAJDXM4k9H?=
 =?us-ascii?Q?GMHM8GF1jRVAWSLDy5v+Sn2Vim2/je8wamZ4buDqHolzushezfD0J13BpFA7?=
 =?us-ascii?Q?X2nKdwJR3v/SD8y2coHqJt4AV4CTprNMb4eprz8gh9wZuSASDrjXsot1L6gG?=
 =?us-ascii?Q?TbzCg9KJrYa21c7ZzZbFGAiPoA+5l1mv0/siF/qlMdqXXP0eZ4R2EKgf+CJe?=
 =?us-ascii?Q?b9/TVkQpyyFUP2+IhHkkSR/mGQSSzVaqvpfFqvcuXhozx4x3RcH79CPrTqte?=
 =?us-ascii?Q?4QaYNpxuu69n6zag9ZlzFWuF5nOUaHbpFR7XVw3hwQUXvk/7n0Geek3Bz9md?=
 =?us-ascii?Q?LZIRwghpO+H383Mbjf4YkxopZEFPnPmdWU/o0WavjvI0vfzRWpP0JbAz2p/i?=
 =?us-ascii?Q?CQmMqH97u+WxVvqqLCcksKA3SrMVLTHcrcX0iolABRY89YXLIJqm7g9JLuMP?=
 =?us-ascii?Q?+tRJnXRpDmsN5rB5uadcZq1xDp2NcMhONhQmQ7OhE3r71/3jSt8NC9OZeo10?=
 =?us-ascii?Q?lTvDTyUbDCCdTpwdLGJrhgdd77EbVPTxVu7gyHaXL8oyIW07Tfkj2/szpaRd?=
 =?us-ascii?Q?vY9yo3KzqJbzWUNKHi4V+Gc+iUW/lzHpJD+ZbBaWU7vkt59M6QtpMIVBL9p4?=
 =?us-ascii?Q?6Ehco1zJ71izdlSRQL2FZs/9mweBHiLYVObdE2s0ZZCQSPYHg4CjHIFoeH6U?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee081ee6-c983-4c77-e215-08daac0c0bf3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:41:37.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcfv7HCeyyoEIEp8rfl0oFipPkP5/cDZDO0evdoTL9qBqp76CDewWNINSabX2xpM0ctQJIjjBQTOPQcRraRBJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

Use last_snd instead of msk->last_snd, then last_snd of struct
mptcp_sock could be removed.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..c8792e6f125a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,7 +257,6 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..b7156f6aae8b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -5,6 +5,7 @@
 #include "bpf_tcp_helpers.h"
 
 char _license[] SEC("license") = "GPL";
+struct sock *last_snd = NULL;
 
 SEC("struct_ops/mptcp_sched_rr_init")
 void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
@@ -22,10 +23,10 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	int nr = 0;
 
 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!msk->last_snd || !data->contexts[i])
+		if (!last_snd || !data->contexts[i])
 			break;
 
-		if (data->contexts[i]->tcp_sock == msk->last_snd) {
+		if (data->contexts[i]->tcp_sock == last_snd) {
 			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
 				break;
 
@@ -35,6 +36,7 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	last_snd = data->contexts[nr]->tcp_sock;
 }
 
 SEC(".struct_ops")
-- 
2.35.3

