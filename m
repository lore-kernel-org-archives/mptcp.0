Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C1522B
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 13:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y87P3HwajOtxYsvKLOjfBekNjQ3SL1pfOqGU+DJ9IPN9E9tZgU30NPxBjFG8ZUFmX2vgFR+ApB4YYAC7Nd54o1OfGoB7vQX6VBxQ41geQKFmMOmGeC8jlRLTSSU5LBKwFgwu4uqtWoeUzQwQBopqws2ZmeZT6gr+ku202esMqPaNe1NVHD/jnDjhS5oXyKlLUi7tgtgl6SRoI+CzCLrD3K7xy+J5RHo0X72K6FWxfNc8a5V4ogJvdjvX3+sloDdId4wV0AaAZxpF6xB/iGYT/iC9XXDIGfwXPlrySpuC0egOQOe+8nw53EweWRH3nGb4ehPQjGP8IUhC5ksf3FIDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/hyq1wx5fglMNy55BiD+y2XrfLMCGieG3x7zMNJYbc=;
 b=FwmcCya/jDJ/I3Ea9q3Q4VNzp0dfqhn2LyClDMy8ZsoGM+TCfiE9IIX3prNu9l0A7/QRfraQ9RtP8Iy9Bpn0ZD83NnXjwG2Mevw/GpEHfhFuPYFBz0r8I3LdyXfeYsnRKPKLmFGmA7uXmRGMG7rfdkzQ4dtYebUI5mWiNvzKdXw1ZHqZBiGUDYbwrGNtjfYWA77/kPzX89Ou07FtE2ycuWXM2YdGOBvwH2N83LawYOZJBNaIdiD9nVKKjNRT2DL2Z9EMarnGD1AXJNJcdncOMyNGHU81LjOEfjF9LEZap4JBxyQn7uvfQDLShoVjReo9qhmowhb6MbasUSBCiQIECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/hyq1wx5fglMNy55BiD+y2XrfLMCGieG3x7zMNJYbc=;
 b=RwQWHfc/yieMCyvH/Jk6QbgGMYch45/twfwb+g6Gt44TezIcZqee7CbGzsfV6w2ymYaFpUCz2MuuPa2oaOKC5ILsrznw/KzPE53pL6NtnWRngJQXoD/vWgZTz7iy63NApk/YMZRe9f9ZzwoUGHmxZFpFbilOL6qq/LI5No7ecVs7rnFCdQDa09I3dGm/tjHLPOrSRCIEJlZs52lk7ViPssTx0vBycDM5Dr3OnY6KS91n2gOylG1jxcjkZRZ/ktNmjZERO8OyuM5i+srtpphTrOZcrNV0tfVik9EsYsRZvqAPJYDPWtrsyVyoqLHPiLlvkYh60G8QsoYt1IFpbzjSvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9985.eurprd04.prod.outlook.com (2603:10a6:102:385::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 13:53:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 13:53:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: make the contexts array of sched_data invisible in BPF
Date: Tue, 13 Jun 2023 21:53:14 +0800
Message-Id: <c2bd83d119631caf435a7498104f075781ce4969.1686664380.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9985:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7d9016-5521-4b3b-6559-08db6c158f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rAstxcSQXArJVliQ+YE5oHNlurzSRzHiQG2Oe1/Lce9xN9nLRyokdd11EA4PMqQnLEnGkPXXlaiP1pq5zCp8Lhj+muav76Y/GMEYCsdl5QRGI6EasL9xOsagNoHRrzh3xNSXfEUutV6yZiP6imTOP4gmXdTnU7BpniBS96wFZXgjq/l886nedO5NupzOmHL366wMn/Ltq9XsEeLcyz6sqCBNfj9aA0ltAvWvo96a4ysyx/u/V5uMVuwe9MkUtC9YAQWeZsivfWbRTI1oNrGhIosowIbaIYa9ud+IFGm1NVkCdNUu+wowkUySoJnkhxJIk27xzI1gtG+OsSUxGf1SWO0vP7u2Fp8G6F9HnbI3e/X6YRwPd+9J4tWdZwlJRebow9VipU/ajkbiIQ+qPna7wF+hpCJSGTupfhjlso49vqpRAKGUASGBJJqVNKM/ORrSPhktEghAP86LEnkBPxSt1DxLL6RgRvfBh0Ul3DKm68gy3W5Vb9Q+LXnJvIEJmU1zlNxLuUrUpR7rLSeVzZByQ+FvrHE7k77JnJxfY3UrvgXgG2XJH2zaaxK/Qi6Rtw1Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(66946007)(66476007)(66556008)(4326008)(6666004)(6916009)(478600001)(316002)(41300700001)(107886003)(8676002)(8936002)(26005)(44832011)(6512007)(38100700002)(2616005)(2906002)(5660300002)(36756003)(86362001)(6506007)(186003)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XgqfgZORYKFPWDpinD+VQJQgVmUScVkBgo+w71xknEfL+pwC4Q9LdMOmNxvf?=
 =?us-ascii?Q?DNrTt8CyNoQs2J8WGAhdwuRwoxxUHeNBii4bfz4dRIhbByYxWm0wDs3nPvQj?=
 =?us-ascii?Q?r2PRwfW39PpsUKRQRh4itZ1NZcudrDW0c+0igurbUOcxXT8Wt3ZRJps2fnUd?=
 =?us-ascii?Q?dvMUT4TiLPHYmYQQmwMrsPCyxzMTWKqZLcQumKf0qKsHTH23J3tsO0enz9QP?=
 =?us-ascii?Q?kgkQ3lb3zyG24Kh1FAv++tETabb8Ji1FuxgOXUisv+2Xei2FKRMTgy9RCpnX?=
 =?us-ascii?Q?8NgvUMIXtUI3gWNvpgf4vmS/JtM4cV3CRwISCU9Er+GstG0IXY4chlb/RXod?=
 =?us-ascii?Q?vYJEgy6q8b6xW7iYf1H01VXj+iPso4ad6K83KS/N5yt+DQvskJPbha/YQiuc?=
 =?us-ascii?Q?LOscWjQ5iCr6qD8cqY6xGIPWDB89WRztcR2tnIY5hrTEPjkGxuxyZovNu/ky?=
 =?us-ascii?Q?DP7aIJtAGICJ8fI0lRyADuqW8nYTg5BCHEVmR3Xz8swYvlgjNvGsx9x0nVaz?=
 =?us-ascii?Q?gHTfayhcYwo2xe3DxbaDrZDR4xqv/v9el0mBO7+0f/xaQBAjZWE2CZObc7hx?=
 =?us-ascii?Q?or4Mp/qylvhfAoCnaAadjK+qzOv9dh1EFcMhzhJcR3Z0k8jnyWQHYteZR92/?=
 =?us-ascii?Q?nlcqAOf7yidzBfyg0EJ+wswPj7O6/2qyhKMo04VOJ9e/Nu+4CaDV41zx4DPP?=
 =?us-ascii?Q?SvwB/kV7bRbrIIommj3Ae58f2BMycGL7lVe58bNeqMyhbLoKGjFgqBTp83T7?=
 =?us-ascii?Q?FECQypWIhA9/KD3CKQnTnxWiaZCcvVsMs/JOEBoderuevlkaX4nUtEcpHFMS?=
 =?us-ascii?Q?zAf0jiBTt2BDuaE+jb1AN0b4N0jftrhb1S90ZJUhqXC9r3vr8iVhCsxRgyRm?=
 =?us-ascii?Q?wf8FM99rr1qIw2aPpacpSiHkrBQKFP0jYje7p82rSjRvkAr7ZQ9k4i4uM5mq?=
 =?us-ascii?Q?jqlVqp/BN+PERC8XWo7OXSZWRZqKLK61zTgAOExSTnbGGZlocozFjFiVVMCD?=
 =?us-ascii?Q?rosg2BuRxYG3AvF3437ssr2MrFEjz5rmxMCJEGdIaTrMj2/QCLtlXxX6+BtG?=
 =?us-ascii?Q?6BsfmDTcUHCTuc5Dah0/f5DF+OjvhrAC5jsLiKM6chf8L5O1g6/mjhtc3mqO?=
 =?us-ascii?Q?1cAGGd1N9d3Xhr8CGGePXYe1b+q7eMLQlovWaEoJ48xeSxRhlgqXJnv59Ub6?=
 =?us-ascii?Q?M2thqhTBTNZdld4pkvVGWbsV4ZB2LYrM1Sd3/QQSJyvQrz9MMlPkHO2fInCZ?=
 =?us-ascii?Q?EiNBrRBFFKR9XtzQroqKmp4anNFbt0wtEKlvqmRlqwk6YH8Tl7UeurQYELAQ?=
 =?us-ascii?Q?g47xZkD5DfsUhoo2AfL0oDHj5sbJvwp1MXjxHpp+XmIsRUoi/mxMETW4nN8Y?=
 =?us-ascii?Q?HH33xleoXxwqQDDvi+XEQEwvcQqL6ypcPMCOmy/SDJgvRVVdAJZ7lF3zkehZ?=
 =?us-ascii?Q?w3hHrDHJP7uEDxNltuCU2g4QSFHF/gM0Cl+u28dJw46KCf7erHWDbxlzKipb?=
 =?us-ascii?Q?fmr+db+6Z/XGVJLHNm55Zj3wxt2EK9b5iF14RPpiK7vGYbV8l5UQ4t3TtBrx?=
 =?us-ascii?Q?MerIeJih+3bEb5eySfrZu1itJupwpdr11y4MxMEe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7d9016-5521-4b3b-6559-08db6c158f94
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 13:53:26.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l9+z1/yojdjZb8cHxDxjZvTBHUIt0PN9SGQoDKyVqT/lCKBdlEgBxewxsR5UBs4Fr4qW0+LE4/bnWw4T5gHVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9985

This patch adds a new member subflows in struct mptcp_sched_data to
store the numbers of subflows. And remove contexts[] array of
mptcp_sched_data in bpf_tcp_helpers.h.

Depends on:
 - BPF packet scheduler updates, v8
 - Squash to "BPF packet scheduler updates v8"

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                            |  1 +
 net/mptcp/sched.c                              |  1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c       | 11 +++++++----
 .../selftests/bpf/progs/mptcp_bpf_burst.c      | 12 ++++++------
 .../selftests/bpf/progs/mptcp_bpf_first.c      |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c        |  6 +++---
 .../testing/selftests/bpf/progs/mptcp_bpf_rr.c | 15 +++++++++------
 .../selftests/bpf/progs/mptcp_bpf_stale.c      | 18 ++++++++++++------
 9 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index fb4e6a59afc8..a6d5ede8877a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -103,6 +103,7 @@ struct mptcp_sched_data {
 	struct sock	*last_snd;
 	int		snd_burst;
 	bool		reinject;
+	int		subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 404be6cdb8a2..a6dc94d0f5b8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -144,6 +144,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 		mptcp_subflow_set_scheduled(subflow, false);
 		data->contexts[i++] = subflow;
 	}
+	data->subflows = i;
 
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 4ac51f74e872..76a1e246fdfd 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -246,7 +246,7 @@ struct mptcp_sched_data {
 	struct sock	*last_snd;
 	int		snd_burst;
 	bool		reinject;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	int		subflows;
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_ops {
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index b2724426676e..a8c53f93bf9f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -27,17 +27,20 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 {
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
 			nr = i;
 			break;
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, nr), true);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 4ff4728faef8..7ff27c528bcb 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -71,11 +71,11 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 		send_info[i].linger_time = -1;
 	}
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!subflow)
 			break;
 
-		subflow = data->contexts[i];
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
@@ -131,11 +131,11 @@ static int bpf_burst_get_retrans(const struct mptcp_sock *msk,
 	int min_stale_count = INT_MAX;
 	struct sock *ssk;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!subflow)
 			break;
 
-		subflow = data->contexts[i];
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index e4caa2dd8c6f..b9cc4a5a7125 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -25,7 +25,7 @@ void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, 0), true);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index 30dd6f521b7f..320d46d78b2e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -25,11 +25,11 @@ void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!mptcp_subflow_ctx_by_pos(msk, i))
 			break;
 
-		mptcp_subflow_set_scheduled(data->contexts[i], true);
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, i), true);
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index e3ade9346f17..7c4c5f3b1134 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -25,14 +25,16 @@ void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->last_snd || !data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!data->last_snd || !subflow)
 			break;
 
-		if (mptcp_subflow_tcp_sock(data->contexts[i]) == data->last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+		if (mptcp_subflow_tcp_sock(subflow) == data->last_snd) {
+			if (i + 1 == MPTCP_SUBFLOWS_MAX || !mptcp_subflow_ctx_by_pos(msk, i + 1))
 				break;
 
 			nr = i + 1;
@@ -40,8 +42,9 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
-	data->last_snd = mptcp_subflow_tcp_sock(data->contexts[nr]);
+	subflow = mptcp_subflow_ctx_by_pos(msk, nr);
+	mptcp_subflow_set_scheduled(subflow, true);
+	data->last_snd = mptcp_subflow_tcp_sock(subflow);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
index 125e84a1e49e..4f21211b3931 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -25,9 +25,12 @@ void BPF_PROG(mptcp_sched_stale_release, const struct mptcp_sock *msk)
 void BPF_STRUCT_OPS(bpf_stale_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+
 	mptcp_sched_data_set_contexts(msk, data);
-	if (data->contexts[1])
-		mptcp_subflow_set_stale(data->contexts[1], 1);
+	subflow = mptcp_subflow_ctx_by_pos(msk, 1);
+	if (subflow)
+		mptcp_subflow_set_stale(subflow, 1);
 }
 
 int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
@@ -35,17 +38,20 @@ int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
 {
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], stale))
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, stale))
 			break;
 
 		nr = i;
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, nr), true);
 	return 0;
 }
 
-- 
2.35.3

