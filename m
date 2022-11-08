Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F1323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc4wrT/QaLCLFz+Y87szxJbgx4+pKfL2qbFFnaUrx8es9vnRyFtsT6xpZqpt4EaL8Q/kF7YbS+DjTRZujwQki/AVUHhOFqnqpQ9Ybtgdat4X/00RH+plVhg0s0CABsJ6HXASN2iNtuZmveEBFaNYgrG0C2K6Xq/UO4/JqqREkkOERrQzZdHCfAfJljRlj1nylIfhcmVGnPmh5qlQX56xJOwtOUIIo5ixNv1JtYKNOG8ttxsPDV/PlN9L3ROsDzceiLNLihJmW52qB7vyK1x+YpsHnAYvvbf6fmKFFbOWff1XB1fpH46cwj/+G2vzL78jAvIZFYiGRjHke5s/BOYgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHhCKonNF1t3CIFPr3o7+HMMEknuoxKzwfr7eU36fiE=;
 b=fgUveTlB1+KCz3/hDwxOIdBLBpdBZOV0iDQieLv8jyRUwleVuHTeoIC3NbbqT/vRZldmnFRCap00mQHeokKvqfw09Aw7TGCPtDcphHaHwe8ybMHDRokX7occcVIrYTfExo8X2DM3cFEuTElkXdbT5s/MI/angRTvK5g9uI3ziAN4pI/5h2gvACVK+i9U+QBCjf571e5EpzP5IE+mA/QKrNOZtjSFVbOX3pfvAO8iFw/avgUAAVGFdcv/mYjidvm8+SkhMLTPR7mTYPIK+k5Exdx3i52UduimdH4JSvTrwjf6wLHCE4lTINOt2slL82a91cnrztT19SaAZ/c8F+MPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHhCKonNF1t3CIFPr3o7+HMMEknuoxKzwfr7eU36fiE=;
 b=qWuqJ3t9gKCCUzYSsAtTiGOX+lmJAN211tZrPqUBtGWAla+qpi4CXLWgYMxOWrxBnA61ozfUIfPMQpwvLU7Ae/e1rvkQU4pgJapF6IFlVflwhMnJ8V2m8AGCkPQ1NLitVzizQiGcyqDdhIoLNcPiu0Br52kjrqE6eSoDG1tjbJulzX8HxxUqBYIVEzxeDZ4qun1i1ONjbXg4Le4/kH93mDgaeVz8DIfrMXXNsPN+kDpT9g6nEzMN6q7WyKgbChZUHH4B5KfkfCiISOI2jvxmQAiMKFv3ay0JhEIshnqc/e3OeMhefq/EWklO2FV2D/QkxiWNmF3V2UqbwVlgbnT3Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:46:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 11/15] mptcp: use get_retrans wrapper
Date: Tue,  8 Nov 2022 14:45:10 +0800
Message-Id: <72991344b28dfa00b337ac45d92cc16fb6855fc4.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a7f664-8868-44b6-14ff-08dac154ecaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eIIBMoEMDXhCNL/wDnoSnWb05Sq3jygs19ywjDIceW6bntFJ4BoLGXe7dZ9m8ozM+3vZcNE2VezYvR18Iep65nhP24Mh8KmYefrouagdF5Nbgb9r8WyfidkTlfjsHvV5QWsD/u/dW4we6bfalwV5T9kjYCaTY29Q50Cz8VYAhK32r8jq+/MtLHVBSRZphpoTucJFOYyiKmsk0QQlyFCt6EN9VXjfaZhAVTunIULiF7J7leWc6deqcxvIF7axZy4P6mOzNTxbYLlyNhjZI1K9gNqyVNaeGQk4wy7xld9PmRWBOiFUHDpP6yeMPOs8vYJMvh14OJNsqagEJ3OAQFvA5QSXoqf5pyICx+SS7SRMhVlq+hog51w3babMi1CRKoj+XAhLw/WlS1Osyr0wFFhAXycM5dOupMiar3FVjRVbcmZ7RmAzHdDQI41BQecdayDt+p7QVMKo7CQjRYtpOwi2gZ7RunhHOhJwn0X5QbqgcYY4ZLt16EJCLJfBtGBaHsrJ4v83Dn38uUbSA45decrORWyye1GgAUgcmBcUirR3TxTvdMQBlagzQjYDkVMGjDwLZZRv7XrE3kmX0LmOQPWw4XDgiydjpLCY0npfW3YoozHl/GI9KL44RJy8FPol2VcS/sMUy05tVDnBScTq30Sy/lbzcUcibCiZiF+daSZTuTUh/S7MrfKpTJyuxX0zhpAE7bS1JsQUh9Z8a/Qy/Nkh8u6hai13hT2fRYwJn1f28jMNw73CFQM53dhcqwNqwwsi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8IL4awQ8Dz6BtMlt46puZNxxZRqdu6pdVMx5HhSo1Gc7cHb+3YfodBdWGQz?=
 =?us-ascii?Q?fPkG4PMFdUqAfh9eJeWLLYKLlqZv1jsOyxUecXcuVAaVV57R0v71dMGJe1xA?=
 =?us-ascii?Q?8QyagjPnblH2261RXQHbzFhuPMT/cGjVzTa/0n55+34MZFZx3HlpDegu8stD?=
 =?us-ascii?Q?5dhvIxgzFpDvK5ovGNUsHviihvpU55zjUM2qymKV3FwvJrB50YT81YGtLMWk?=
 =?us-ascii?Q?4vOXG8SqeeuHloVvYImQpkRw+MJuIOMk4XAztLrxY0kSw/db5NP1PlCqtToh?=
 =?us-ascii?Q?+CbgjlyCVFHF/9anv69nqlpafe/NpzLLPTsmUMQtrELHd2kKvd1/X0lmY0XG?=
 =?us-ascii?Q?TJtYoqEJAY034NyxyZ9BhvnDc2qqlwkRThvLVnPUYgssNG6lmE6d0lVXkol+?=
 =?us-ascii?Q?qRAaOdq6IHiQC9/hGlKDEN6FCq0GZD8jGNkXOdU+p4B/al4JojA7wYgTz1nP?=
 =?us-ascii?Q?j9Isne8CzYDvi9m/oNtNbGAD0iiEdBTiLUAlxDoSCwWWx2m2BybqeSSYNjoe?=
 =?us-ascii?Q?DEpB+UviORXvqxIdPNoID0+mx6zFFzZAtJXkf24bYafhUPgsOamuZ60ZzK9N?=
 =?us-ascii?Q?OqDRmj0bfIzkb3a67ssBPv0Bs2mozkOvZoVU6H+ZId85dnG92vc0pP4WazOj?=
 =?us-ascii?Q?XEvMFV9SX/aLJNic/XLKbtohT5IbvVyCF7SAGC5u7qDI0bey/QnKTEvi2fh5?=
 =?us-ascii?Q?eFaJI8cAZF6Lfd1xeB7/OEJS3it9Hs4ySIrG/SXZpb27vWOMJJviwLbt/JNt?=
 =?us-ascii?Q?5HWghsrLiINjPah475joDhr3Ryz3im+cp4O1NdFAclJFwAl7W57R7uxkDSnT?=
 =?us-ascii?Q?W5Z+In3Sl/750uZ2Tja+M1qw+UlPVgy5b5gMcHuCjgdMGOxt0zhTHo/dM8wH?=
 =?us-ascii?Q?rhT7nUtjCj+RWxr3g5Pp0hsFb5/ukdtrL0J+aUY9TRlh7qy6N6gBoynpsnFJ?=
 =?us-ascii?Q?cVu6Fm63yQa/nhhXdxHTA34WzXHvqILsozT9yBErB3zuRY/4MEZs6i9Kcp4k?=
 =?us-ascii?Q?yWKAlVSo0zIcWeG87v6m2XS9wg/JW7mKXvuclpWgWxO785Xzk/uitztj2GtX?=
 =?us-ascii?Q?czSXXZQtZQ7MfJ/k4aG8K6DP9PxjOfMtW41C+tSNbjfdd//RQ8uzt0Hl2ICZ?=
 =?us-ascii?Q?WMsWJKGHytGRQpyZMIZjsLEQnzXVHcHsRtxHx7BZ94Qf1+UXVipPHZfHhDWM?=
 =?us-ascii?Q?+lT1TysACCBDqAOEoTxI7A9n1VGsSOY4/uBjqHFsyYuNxQqs2EDwyvyLqM5X?=
 =?us-ascii?Q?+wzPrpYC26sO1rOws/hjMhQS/i2sQcKkwjpc8QCP5xoQJEbBnUJmjyZz1vJ2?=
 =?us-ascii?Q?Zbp2i4E7Q8/gpZR1vQUyz4PDPUpVmOsb36gM2YN1/1zOJ+i7WqM4xHrOHbmJ?=
 =?us-ascii?Q?zBEz2Xnooq1L1RivW8T30m0stcv6V7/HRFj8/M2QimsG7OKA3PfRNhBwcRW8?=
 =?us-ascii?Q?HVHlGZ0maZZOIsSlnuFP4oG/+EgYGxkf1iSYrYID6uUI0QYIHAawujl8gnz5?=
 =?us-ascii?Q?wTYi8/dPy0RA0pz4Ch8h+0mWPkeSVvWRsChgmEmduuwL1G9hhYVPt/k96uqa?=
 =?us-ascii?Q?ISocacEKJkTXjGGJv/MOonhfoRXlLe0Xx5KGFEQC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a7f664-8868-44b6-14ff-08dac154ecaa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:12.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNvfKyZPVPTcpY0TL+WUIYOPMz/SorkLi9zoWErzIg+JgMqfb5MRaSa3sUo2/YBf2DoU2bkfCxyO8t9lXMyzTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

This patch defines the packet scheduler wrapper mptcp_sched_get_retrans(),
invoke data_init() and get_subflow() of msk->sched in it.

Set data->reinject to true in mptcp_sched_get_retrans(). If msk->sched is
NULL, use default functions mptcp_subflow_get_retrans() to retrans data.

Move sock_owned_by_me() check and fallback check into the wrapper from
mptcp_subflow_get_retrans().

Add the multiple subflows support for __mptcp_retrans(). Use get_retrans()
wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 69 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 30 +++++++++++++++++++
 3 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index efd87458f324..06c738961348 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2262,17 +2262,12 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2547,16 +2542,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2575,31 +2571,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
+
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
+
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
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			release_sock(ssk);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
 	}
-
-	release_sock(ssk);
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2bc0acf2d659..f8cc14064573 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,7 +641,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index bc5d82300863..edddd7cceada 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,3 +149,33 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

