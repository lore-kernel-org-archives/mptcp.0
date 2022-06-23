Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150058.outbound.protection.outlook.com [40.107.15.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792771FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoCLN9F+wmybiPnKFu3LsQ5w3urLPTw6iFbVhwXLaTWLwuTf6dKzRXq25jN9elWwo4SbGQpfnZmd7iVplkfywFhvLItlFTDD0ZVMOGJbcVJwvLMdzpgiQQSp/8MqEIRQVM+uvUM4DiocKtXhmF0e+U87sLORj8jn7/ZSLLFSpwekkJBGoIugRTbBS2GEzY79Ss1pR0K2xxHsqIDWH4skY9nL9jQYFX3HkfTdUPCReo5ycSyvopRDTpNShfP1IE1HYcjoSQNrJYgk3OJbudaDSz/++kMlnphcxMYsWZkv8LAPnhkzUAEqtKMp9z7steY0OTyLxMbQymCM9FipoUgzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZB4xMH76SkwxyNpUeggaReNexgplLy3BOZmanOZBwA=;
 b=T41JRHlzxKsblb4GTwgqw7l9P8I/j03BDev9CwiCGLE/0q40hX1uF7sVuiepFEkkNySXm1s5ZnP8Q1a31HV1r/XdiyOs70rMLtTxInWIswrq2w/IFxFLKZ1RJb2bzEE5C5nDmMRDV3lctHDMytVisWI9PXRhyMp00crvsRP73tWEWPLX1NdSxyrX7iRPp2TqPDV9RO8n+6QhM/aH8XD70j52O8iJMBDB5FaIMdxcZf9Of3reCSttYcPI4FivGL3F0STc25fB+fooim1OLSXNnWSfyOwJqf65Tb/u0MZEdyfDglf08JWRpu6JY+aiReZ26FoPxs/8I/7vbN6tdy2fpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZB4xMH76SkwxyNpUeggaReNexgplLy3BOZmanOZBwA=;
 b=ULmpsJUNYX7KXLvRdz3J2BqLKswlUdzGa8K/7KwevIRR/FoGc5BXT0pfatZQDxGGsJnUays5+/ZAhGHFRiQXu+FiT2F7zbpINMWs4vPVl4FHO4RMkCy4YPY3VDH+7VUnH7CDyfBSpq9socUbTjpqNILcj4KIlHmnWSE49q/ivyVps1dDUmWLBFkna9tvGi51FZVyuuIoBAjKU80TdpmbjmGGd+hj+orhzXhyPtj3PcPjezXHMvxQb2NHzzcgLZYws7G1QUSIoLf8i18tU4BJDyNm+mufql3NDQMu8Mc2GopYu5No/I4tMM9VNFGM7qvlMs7U027HqHto/7TBhffg2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:54:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:54:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 1/6] Squash to "mptcp: add get_subflow wrappers"
Date: Thu, 23 Jun 2022 22:54:17 +0800
Message-Id: <2ea43145e988162d2a778644796c1b8d7d91697c.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc2cb6a-2fbe-4ab2-1dce-08da5528469b
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8299E5C8AAB22159168FDB40F8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KkqBSVyry8L8hDwNuyIPe5n2hORi/qWA/Ai93NS4oKRX0BLzNXamemsft014mDkIIaZ8ULQ3n/qxUUB0X9XCGhPsISYGyn+8mtYzoVv1roor+39xPJJOPZvisKPmHFgQbSDt8lPdiai9nyIBQyy8YrVUeau7DCcdvtgWYHevhuMQap6RLuAYLwkL7umGWlLeP9pZyWTMOSWFtBEkZ9pZc/Hrn/ufecHFdPvRjEDM0iUPqiydboT7Q6JPVhNee6NFLlnF7RS4yDBQSVniJAHgMHnbvv0kk0OFgsR/92f0KsmkVQwBXmjvXsOFU+3bWRWZUXwTxFzkulrIOx4ooJFReHnPTXNWEO9bU1G9+DyBxZfmEF7U1b9f5+XZGHnGSCaTVW8mVwuRktIWrhoheR8YuqH9JXLhLxS6BxrlxSHRs0qvv1P/nFIVgiUCL2wHaEltiYV3l5lJ+RbS0ZXm36w/p9qQObrwVWNIPZhwaPkq82i/A6QwFnU63Z1g2HPOJniTS41WYXtxK7gEbt+givnOTeewgyfzIT+gPynhVL/3JYbQF97/CHDeU1sO7Ne0QmUWdq5wT6K6h5XHP0T1p0ysoRhbOpEGhE7D33NvHdCy8iBkcvJ9/7vptWQ2nj2m5zKTctr5pvovUl4LNVF8dsS8AZ4NfnUxbizpA2vndCHhfSC2cuj6w2L45MUUOLo7tnwlgbU+9HAA11RFMU4A+OG0f0+0G88CWYR+2lbo4ZnlDxyRhmxFWFJYWNEWhy65NibH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTWs/4lk6790D/YRx8aVfI5PV986a0xavzLhVoWJ06v0u1gX4qJR+jKObmPb?=
 =?us-ascii?Q?UDI2km8ixCqcMC6LFeynuHepE+QlICHFwKb5XGDPh4uFmaJj25DHiiN5Wrv7?=
 =?us-ascii?Q?jfHpNbvCW39tADgqMkHUWvbra1wCgwGwjbjtrx1I4IER+mbJ/6DjeIG4vF85?=
 =?us-ascii?Q?mWpFXgItLNJV4CpVrYlzs8r8xcDMx7LF8JkHpg5nbECsG2tL2Fzc5k58j48V?=
 =?us-ascii?Q?tyoenzdjQYUXJTrxBbIYj51gfdwcr+kSN6eF5+ifPxCwpEiRxr1HlTJjm7BQ?=
 =?us-ascii?Q?llFxgrDwFSGryH4cDFzObZHcKvYirUMLK8zHwSe3HVAmPFPy4x3FQTo2y8a/?=
 =?us-ascii?Q?znQBQXVkl5c3q7b5pUWaT2niaQWep2HI+6JKlyiRJ5ItQ7WYyJDgwf+DIgZP?=
 =?us-ascii?Q?GfR6CDvhX0RaT+Y+y23SIb7iPlDxyLDzt39yzBZlELZKAeUi1fdrhRUTMGqX?=
 =?us-ascii?Q?Op9lTcG/qSvmKfMorGvkCYdFyBpHEPLrdozjc9bb4mQBcx2kL0S6Uq13LPJO?=
 =?us-ascii?Q?8bR6A70JrHO+8DzXcBRbNGLgZNW7avqhVkmTzBOrDnoNQyo1w3/GjwWFiisR?=
 =?us-ascii?Q?hiY9HB3g+qOT6MJTZHnT5Abx5Gx9gKVr5eqk4YtrQ1WVvdQpdudEZK54MjNb?=
 =?us-ascii?Q?Iw9l6Zr0jbANtv/fI08yABRcud5MgLCsSQueT3bhZLQ6kmhjXk2NESH2Yer4?=
 =?us-ascii?Q?+fkQMNDJrOC8rlFVbfxXbNWsE42fO/9mfRoFB/XI3+G/hiBAwXvGeykUVvzv?=
 =?us-ascii?Q?4N1ketqfIySTevCydNPc0uW3sQjQDZr7lgm7XK9kRcB43lNKl5oMuNyp1X5p?=
 =?us-ascii?Q?rD3RhFiernwkh8UzVpre+f/L2EpDeI5pscNFFub0i3HK1rJmsjlteMmakhfX?=
 =?us-ascii?Q?4fBMnZW83BJxuOtzN3TBXUdkZX+pRNCU8Xshxz7tROgpDIHkYS+Mse0Av01k?=
 =?us-ascii?Q?2dZXoe7vK8EDU1k9Rtq7tGCXS+GQXmF3J0YkgGA1uqEWt8TBvg/KBLcm08in?=
 =?us-ascii?Q?JzxaVI4viIu5T3wkW/nZMZNszHuCkRIt0BNpuuIfzr1eJzVG8X77ABBwUCAb?=
 =?us-ascii?Q?siqnMaty4eYQ6LiMBYk/imNjNg2wurIYJ6boIbpaXbgNzjPXCdrVfmsAsPSB?=
 =?us-ascii?Q?g9DBBtXiHpneGKjUmvi2TWO9PwlLGh+ClOUg3UqFGswY0Zlep/1iz3d7TF3j?=
 =?us-ascii?Q?nDzMZQ99aMK6T/93OGHKKveg+uAzrEDUs6W4btwy4A7dKeL794aXIRCd4wJn?=
 =?us-ascii?Q?W5xc9lFc2znMLZevkd0UIJzEG1x+HZcY0bA5UY+Ytfj6GRvSZ77xzV+Qi8QE?=
 =?us-ascii?Q?0uaXf1zGxLv39bAY3X1y16d5MLR0j9Ukmj6S5IvAMa6OdbU33RhxzDK6zJCr?=
 =?us-ascii?Q?GuirCnYAFaBBoK/x3hsFCU4pWlQ0wv7NNmdM+yjPeI5gmqlqDwDZ6FqV0Z8p?=
 =?us-ascii?Q?iKLbrAcRpX9ew9plA3csu0DXM7L09MNH4cJ65zJH7P7YKs0YLiQiIeqMM88a?=
 =?us-ascii?Q?XOFqQCxDfLbpnhDbrr8UEta1JQzkKhPq9vJHnCtfqAQNNZuVaiFe6EJgj+E4?=
 =?us-ascii?Q?dSOk5GAzKXn+Nh4DncZVXvenw0yWORaD3PUTsD7CTDmWmcfGBWxfTOkBKKQm?=
 =?us-ascii?Q?DIuxKM5jUc7RCl2tqVo1dVXkr5l5kWFgFDRhNot/Oy4JJ1bUQUcX7NnuLc93?=
 =?us-ascii?Q?Uw2r9WN7/38U4ttkLvJCG3Tsd7YRoDXM1LUK0YlffH+zUZMsrnRGSJDZNlmq?=
 =?us-ascii?Q?W7aSOFuRqtxzzo+3/6TdIBdOmlwNACA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc2cb6a-2fbe-4ab2-1dce-08da5528469b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:54:30.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNqW/at1R8MWaqR6Drn10tJFdomQ3meZKUtuU0BAuLJitM+0uh5nRbIt9Yj4NoMp/z/7jtJXfmzt0+7ShH7oWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  2 +-
 net/mptcp/sched.c    | 56 +++++++++++++++++++++++++-------------------
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1fae2f747c9..6e44786e01fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1532,7 +1532,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -2408,7 +2408,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95c9ace1437b..af414cd8b7cd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -636,7 +636,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..85c1fe85399d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,34 +114,46 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return msk->first;
+		}
+		return NULL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (ssk)
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return ssk;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/* TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk = subflow->tcp_sock;
 			break;
 		}
 	}
@@ -149,31 +161,27 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

