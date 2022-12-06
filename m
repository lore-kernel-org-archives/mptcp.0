Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF16AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJjlsrN7vZgqo1pKy/cHOC0LGQHs/td5b1rFliXovAWI6xGDZyUFxD+aD5Eb4o8ZIvevalzqjIRt2qMo/B7kFAymPjcDEySnkJ1ERUBe6//F30Y2c+LqWyuLlgcnHWhB0pcrSeR3cJTG8Fz2lTphIJrQqXku+i1lS1+vQe2vwAe2mRt5/1zTw0bpH+qQv4YAciObPP56bOJitka6XVC7j8+duDiKnpzwUx4Ngcw+cM1qYdMmc8+kMNfAoT+FJ0TQWveC7pMySuXCQl5oOnTirKIFCJOVfKw0YiNzrCuMosZVsVj4AHH09X44X6WX+dqbHMfoJZ2rtNpq9hcWHNbGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RzRVIefIQkCIhGGLwoYe8+EPSPCi1n+L3CwbOLClVU=;
 b=GHJeBb70SlrspsEtzfwPvkPMEKhNv1X8zEvQPRkPdAK3gYk6bpaczQlS6aI77Fk369dZ0HJNxbyJgtCSQrJ29YpRmEiG0DSR0qXGGUyA6M0cuSabPkudolNnZR5I0nrxftj/pQETaTor8VC2pkXCcrvtP3ibAevArDYbEG9lw+JPPU+FyTDk1isuxzQOY3dC/1J0gNmq1Cro3hAUofKCGu0+OnFx5clgSAzw9C6oopOOLVrRdZRcq7ROm5WqvIqX72LWvJ4g+/hK8hI2E+Ww8Rn4uG7WJzEi0SeGzhAOR1iZtFWGOFvJTyNOyqNcEmpLEQh+K0fY6tuAJp9O3jRAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RzRVIefIQkCIhGGLwoYe8+EPSPCi1n+L3CwbOLClVU=;
 b=04L8lMmC26tbhH714WNZydETu4wXRKpUh7LMd2MZZBE5WwGmZPD0beOdsLRK0C2kusv+OZI7r1htZkIJkvDWCqKJRxdJIg8jtnaYFWunC62RsKEVM6M0lzHTMCR2NlXX6c+3aktqUp9GusSUYZZN9cvX7x4Ygwy1Ru2XQfgCqkpI9/PX9KMcOPy6crP4RmuPqiJw2Ajzzx1BZUqfuMuCj/9ryZ/khrU39c8gHFXpzh+A8CkbEIbq7voDoYyWsQnvY3uDVIjAiR5oBRHjhD8p5v8kV1rs7aeF0Ej0JtlCGM6gpeU3T/xUC3W0HQuntgJ8nvJBgnTnccdLGuoF6Lfstw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 6 Dec
 2022 13:23:46 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:23:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v23 3/5] mptcp: use get_retrans wrapper
Date: Tue,  6 Dec 2022 21:22:19 +0800
Message-Id: <b10d274c8be8cf5869d2304691ff63ce749aa3ea.1670332660.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670332660.git.geliang.tang@suse.com>
References: <cover.1670332660.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 598bac76-8465-465f-c9a0-08dad78d090a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CbNFeXNo06tH7+YDX/3GkPpMV5b76mty6C39XhyX0AL2iY1hNsRQRXSPrEdWSZTlPTn85giGYQY/Sh0phl3D8kAPTgrVtxkNogVSx/X8yxpssfD6u78UGRixeE4e80RPB6euDuPl27uAU77hGBb+2zUVbtGZJJDT9GUFcBBPqjSXD4WetzlFs4JXezyT2pBrwbM4uqsVX0BCvf4hVwDY6k7zNOMtjzD6d5kPDxnuaNNwBflO3bc8Dn+0PhyB7oaV6D7opKHY7D0alqlURwdRM8c2WyQFwUTnOHshUOb62atMCEfcWcjQHRFZrsIeeBGZFPb6cZBPUuHGeCzMHL6kFmiTNOX5+N87lFEVEQZBP4q9l09XQDg9KFeFUCdNCOhXgyPnrVDKJBg5fgrx0r/vZZ+tRAw2CSXk8/uopCyVX41S8PpCjLCbGa3jXMkXkW+4VM1IeyLzBQGhj2gWcw7Xoa224Ra3nruLYiD7GUYuToXFieaQKWJIdMTQLrylPWrOgJFQ9xq7/C7zA/7ffSP4HXUfxD0OBKnFmn9fqHS9YlZBpKpjIN8FOQsoTw2UGxAVQnHuASdsFtTgSlekTWMH0iRyoH+1L39zNY7vnftdYpF7HdziCfPt7hpfUB7uWbAZIT2F4KLqqX/sakGYtB7jGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(36756003)(38100700002)(86362001)(41300700001)(8936002)(2906002)(4326008)(5660300002)(44832011)(478600001)(83380400001)(6486002)(66476007)(316002)(66946007)(2616005)(66556008)(6916009)(8676002)(6666004)(107886003)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6YMRTTFtDbyqMKmV28aRAUuBYIzB2LDOAMtlNcOYTZbyAP3tNFpU5tHmmFfL?=
 =?us-ascii?Q?2KfxcXNza5VoU/VecrRAq4soWFFzTYY96sYFzpWIMKh2nTNAM0WzfaeR/p97?=
 =?us-ascii?Q?2nqbhLAkLmLRJZkvOXnXfxgCG9PPsKi9VjUvLvKvXybE9WE7I6da+5N/H9PH?=
 =?us-ascii?Q?eOBGtjXOelqNdz/4KGl9AlLQNszt3I1XkeFoEE56CrGepXUZZhcI4gyJR1qo?=
 =?us-ascii?Q?qejIsfYp8dPJBO2gzwDSuEZZHbC0OOT4F04D6fKgU8JagLd7GSQnqW2b5ld2?=
 =?us-ascii?Q?88zLRwOnXjWvts90x7Q25AWYmLYyRkeVIWOm1Yj0xTxNR1KIdB53fw4+efqF?=
 =?us-ascii?Q?4Y1sTxOiJzBgLgjwCayoUo5mODsuwdchBEbOUTaG3HpPMUGpodPN/9KtNbxa?=
 =?us-ascii?Q?J4RDoHJ9WrpZ3HggfaH4YRZbN0fz0lHg3a61VV9m3igaLt5/SOK6e09HVcb5?=
 =?us-ascii?Q?2whg9dQ4zUc1AicQ16I5KCa4KPFIENJBS6dW5J80+0u8VqZWtgGvbYf+iIAh?=
 =?us-ascii?Q?9SufwnTfAghlahsa2zmoeA7t/ZVnTSiIQ23e7zyfGE9AaV9aodq4eOVLr7lL?=
 =?us-ascii?Q?rN11gyAHb8/4F2rrOnNWN5bnMI2rVu3/DVBHbvImr/cbrfnb4Ug5qjGufs34?=
 =?us-ascii?Q?FKa9emT23TkO29tRzcr4wWlQW0zqwmqaHLL19j0zRjPVlCbH3aUI3INQuv8b?=
 =?us-ascii?Q?RKrgGlnteYbt93RK4NAYnsZ1rHWiPe1IhVGk71LO5ZC49TT6LoUpudQV2zjv?=
 =?us-ascii?Q?L/1aT4yNQfdjTILst0wYMQNkrS1VR/MihwBpwc0JA+IwppnPf6mekIGhKaoW?=
 =?us-ascii?Q?96bhxmWoyZEdBJQZo75MdTwoJwxIXFdbOhRsXjvRWEMfI+diE1/M/Ht4lpuK?=
 =?us-ascii?Q?WO5Ffa+HhCVbgqSgIUkWx9+wPXAFbfwGLib4PKMHZW7z4Eo5qWT2AyuLpOz3?=
 =?us-ascii?Q?tio++z+a9NruInBGG9OHH9kwjH/IqJfyJWNdnX5718f7zBpJLmnxmSHVi2MT?=
 =?us-ascii?Q?ZYWe0OacRLkh1xbGLN61twOE0max7uNibw39nUY5hWPEHmsXpbw5i6DbrRnL?=
 =?us-ascii?Q?wStX9pT5HgWfLBGeDEQb9z/xFmhHOgqVRLzMLo2Q7Mkpqzi82bt27uRHLD36?=
 =?us-ascii?Q?hMTATrzzuev6xLRd6Rg5fHFfzZATE1CzTx0ZkHtMRDbmCqJL27lT+67lrmlM?=
 =?us-ascii?Q?X9P7MmLw0QYxGFVLum9/QZYxxUlDGdFLkf+sgL1JhVnFX1DeF96V5MrIOylp?=
 =?us-ascii?Q?wKsZFKUTQxqIFYR3JZhAih2uHdDCURWjRY0zialbNilXJOzTvS4yOfPeiDPO?=
 =?us-ascii?Q?AZucRlZfMXKzRYWlUwz0AMNGjmOKcxiTH1v96e/txQrp4RHFDcpA9dp7Gc9j?=
 =?us-ascii?Q?7x1H1rOPUTKMpykA3n+2imFSQikd9enmOz7UD424JklYGKyusL/D0cw2yXPA?=
 =?us-ascii?Q?sFwghijG/s3MMGMez919Ti5SFhUaC/J8qrUpHQsmg5b9SYJEwixFwX9uH6KU?=
 =?us-ascii?Q?rMNYwCkdJw8nbnlNoNAC25jIVHORJkTXSL6X29KbMwtIVcoNwSfFjbcbdfTM?=
 =?us-ascii?Q?jnl47zRxtG4MksmEXUfXSod+l5Gz2rgeACaT019s/uBSPxhbKkMViJFJ562p?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598bac76-8465-465f-c9a0-08dad78d090a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:23:17.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Md+BYkbsWEDWGpNaO5akRx5Bqdj7jIeliseW+bHSCNUnlsr2EZsCk6MXCwaNZiyqzD7BFGtagzm3etTUGML3vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_retrans()
wrapper from mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++++-------------------
 net/mptcp/sched.c    |  6 ++++
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d5de01bae61c..5505c1439b3e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2257,11 +2257,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2531,16 +2526,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2559,31 +2555,45 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			mptcp_subflow_set_scheduled(subflow, false);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			ssk = mptcp_subflow_tcp_sock(subflow);
 
-	release_sock(ssk);
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+
+			msk->last_snd = ssk;
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 18518a81afb3..c55f2f1cb7ac 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -156,6 +156,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

