Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F737C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq/xwlQYC5hbXGfbRIDny3/6IR7ssnKu2oHmc1UH0Fwf1a5Q/QP6okyxZPH6/rKXoYBBDGi7vs86M0uTnKU+WzInawSBxGIIE+GVq7OjueMjBtfMCkNyWam8MjnZ9cBHhL31K/d31APuFjs1YrVTmCk52kcWtxDUFE8dydk8ABFapN1V4oiQ3AGkYvG0MMFcwZyOspY85fepWdapJZe5Lm61nlrc6HFSIzTl85iJYj9nKvojCHqeQCS3yvj3ITryzGuuq2CvzCyURAWLrVqgGjZwrJzfaYDMeAlBvnTX4/9mGa5KQd4KAXSdYPoe08MBQBepTZbUmLA9v0fxFSxmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+0hIltg0i9MkaN62TQd1SyQnnkH5rZkO/9gOrGZDjs=;
 b=IyLJFIYlkBlNIcouMS/f/7RtvdzRn6qhKqWVO/YDZ4VqpMZ5JYBP5BlBGYdP8UR7egjasBfwdzTJnMe8W9ayELShButttzMKiKZNhjn1EymRTqeeDWcBIcABXQ1m63XUCgHL/VvRyQsXLeyu7ROPZ0iZPlvT7suvzqmTF0LiPKVb5YVP0hz1IF0Aq1bxd9pUUMpdVkrQ9iTrSl3ALeC/wyx1/2AiFdw+xTUjuV3OUg1XyhhBBkii8LZi33dKD8978mldPrLeJl0XAK8wJ+foyO/8CMupn9IrXrKmhnLuvtN0gWQF1hydiA3Qv5os20HCO93P+kTIp8dYoPQ6/6+YyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+0hIltg0i9MkaN62TQd1SyQnnkH5rZkO/9gOrGZDjs=;
 b=W/UrE8f494fY1YrYZ5pY6C6niVaGa7CtBMEJIRuncbHqbPSF0Zq9/f1s4e3cid5nXuybjddCLkf1w3gpktXeUN/FdVHVACR2ISRGDN+ZTIv+YyKgTULKQ/GGy8A+RUV3DVX1iN1IVV4TbZ8ouFiqwFBQMnAgRf7iO4u+dpD/g2sI7AtQyISlskmsyjIsRxOu7HCw108FX59SrMiLvXeJR+8qI1vJUo2ds+PjeV21yHPL+Vs0b7OQh8TaShmxD1O6s2UQoIRItBUlRodTw3aAauR2H+BDFu4fvOhajo79AkyFW8DHvxclrkfC4xxTRs1xW2JSANMSTOM/REUe1py7Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:43:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 3/7] mptcp: use get_retrans wrapper
Date: Wed, 16 Nov 2022 19:43:04 +0800
Message-Id: <50e0da978b8ee4d3a6880eaf843c6697192d43f6.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0f9d0a-1c65-41e8-edee-08dac7c7bf6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	09ph6d1CMX8ax/jChddej60/NYT8LbJt2NPyU+PuBCCS6r93FyuIEljneIwdaizDN6Fin8Wmb+wx+y16cCJF07urnNZ4Mtkyqbm70KKLr+QsBOTO7rSIFD6exsvvrmLHMk8dDKdH0mxqb0qP04c8ZSbXMGcGGp+ZNd8DMsS72ZloVA97K015plfAHTDoDtDZbTT0N/ATbpcO8zM9tP/2NN/zKoiZ2EudtHgvI1wj8Xm3oF8pTl3+05+4lHhMJE5MxPbXPbKpXDminQi5Adgm4UZGWDYB1N5Xun0QDwAlCsEVv+O6aEms+7mUxoFsGkuewYIVXnvMwizFjPhmCmCWq40Mdo7WI/8OOQjMHf2GqX1fFvjkK3qUCDvJveB+No97p6tBQ3/OKgEOz8laJhCL/i8fgByN0wOLwhviLhhoJH8ghmqbn9T8wwSyAz2WnFPNBxS3xIDMagkKc4H8Mf4xV2LfFdefh1Xt+ixB1mAr6j7ecIEEph6GVb8fWmQrxoqy6QcboIlOY5kmHGp8q/sAjFV/EE4crN820DTwEodXO9hSRZ+/ISRycicFy5vs/J0cBNe7lz1AjNG+UEe7T0IQvI1T59h8A2SXF+MBMAddr6iq3NXgSZDpBu7GUBFQm/Hql2zYN56REyHYtlStbv5laoDR4QRnlKsSuhns9ql+8qgkF8t0Db5TDJGD3cpUGo+D9gfBit1TCDenaN8J/HbXgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(86362001)(83380400001)(38100700002)(478600001)(6486002)(6506007)(66556008)(107886003)(6666004)(8676002)(41300700001)(66946007)(4326008)(5660300002)(66476007)(316002)(6916009)(2616005)(186003)(6512007)(26005)(44832011)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bL5VRWmlrXqTBuQqxFWEKmPfW88+CNdN5LJ3k5AfKSY1BaI8H0ZZnhGfTmuR?=
 =?us-ascii?Q?ifLOMjITcU7oydDzVXntmNYtcgJE/DPZbcNpT4IFMaSebOhYgxRUw7X/90W/?=
 =?us-ascii?Q?8mnRqE7m2l/xXothgqU9wDUniA6BBzxjmCUI3nCAmsmT2Dsz4eWxSPE1iahJ?=
 =?us-ascii?Q?wyNSKSFqIqxS/KdUYdzNiZ/S9pVx8MJjVVdDp+sB0VpsUsdc3qmzx3baJ6Xe?=
 =?us-ascii?Q?izHZ51VFuvGP9GVLZ2DbLhb0Dl2tDI2PjZgoEuvi1zfVXeJeEcOR1guY3JHZ?=
 =?us-ascii?Q?1cx2CrtmqS3yc1HrTFdNQgi8UL93KHBMkMhPsBz3EAIO8f+o0itFPuvISjPc?=
 =?us-ascii?Q?LzGnKVpdP4zm3t6/W8CWr1l0bDuDsGaSmErpGvQkvzNf7UfL3779deDuFQqS?=
 =?us-ascii?Q?hMq7IPw83UT1VYB5jQ18y3KDVhHCeyU4ng3PRRqj/zFnRIFIzvRUeisqSKxJ?=
 =?us-ascii?Q?JGF3ZEsZ8M1iuchJaqC/XijrvdnLR0WiqFGs4gYCijQDGI8avAgMTB9k2E34?=
 =?us-ascii?Q?krnfpKhzgTunBmqRsj1GJ70mYMlyQ8jWDZl39K7Ki2by95yBlstjw5fG+whU?=
 =?us-ascii?Q?xioqGRJqHQZNIR64BzZYXslwWBILfVWIN7raKD4atWImbO3mWtPl3LI1YUpe?=
 =?us-ascii?Q?K8GqGewowSUiLZ16N2y00jT0GpqWz6ieRo1cPGJoIQoywAcaRHpfIotMa3OE?=
 =?us-ascii?Q?WFNgDhYb2GD1xWqU1154445d4glITMcmNcuu26ndpmaEgznXN53XB+ez6cXV?=
 =?us-ascii?Q?W+/pP5wrnQ/f16b/o66D2+EgJ+c7Dd7WxZ4gMszMvygkwEwcb0rUm8h67HGm?=
 =?us-ascii?Q?GzxSq7RxOaqYQlApshtYCZx/YKJLm6DoQVtNgqM24WSA7RNMXmc5px6NMilg?=
 =?us-ascii?Q?V9umEkUBo7b7VkrqOACcUti9jemuZhjTM7VkGb1Q3/Nd+LAeNRYnEqijjrgc?=
 =?us-ascii?Q?WE3T6MxUOSJEmrYWGBIk7IYMszVEzGd52ODkGwne14iIsRTZHFNYnalEvvgU?=
 =?us-ascii?Q?WGn3EvlSNo+YF5ASdjbQ0tOno1W/YA78yr4PPZUfsrIe8qAqt6pvw4qGmhdC?=
 =?us-ascii?Q?gCwvBpUSfKET5LmdD2zG4TIKBHir3MXkQDAEVUg++JW8bWwuihzKLUcmQ+oV?=
 =?us-ascii?Q?RTXCwDNiuYeRuzC3Gd476BBNUylYKOxcxrQJ4g+2sV9k8iBDRiLdysqLzm05?=
 =?us-ascii?Q?viqYbhfdZH/NUk9uC82SqrIPtFV8/Or5/LRcfm9eh49WmeWBXS38lIYoUe4C?=
 =?us-ascii?Q?zUG8hwKqXKloaRYzVlS8hUcZRFcPVsvo7B8L+KF9uJ0ZGmxgFyBkrtAlUKDz?=
 =?us-ascii?Q?1RY3IfcHadMrI3Ou9WkA+7xKHlih2cXoRhyXnVAl0mY+/vhhSIoxKe0kMn5Z?=
 =?us-ascii?Q?HxN57jB+VZWGcJGKhNgkod5Hs4D4M0FAnWaQlUbZisWJiO4ksDnWtppxgFHD?=
 =?us-ascii?Q?gYQumc8ucMdk9uuNtahJcNieRii8yfwB+JZkpqYoREKO01leSSzjyzncTyzI?=
 =?us-ascii?Q?ElEeeWxv/GOHpOfhs307gIwkAmAZB45p9AFb70ibgshECMvKKS1ULH0zsUF4?=
 =?us-ascii?Q?SYvQvXsIvgEtegj7GhI7DOHTTDexAiKFDHWnLcX7WSt+wLYJD1JdJVCBFZ6f?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f9d0a-1c65-41e8-edee-08dac7c7bf6a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:43:15.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8LmtrAR/QQU7sRu4PvD/hep02pBsnIdd9p8+jzrvtU4zSOYrdMn1a1XjK4O1CU/nWiiUE3cPt/9FYL4QY1tuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_retrans()
wrapper from mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++------------------
 net/mptcp/sched.c    |  6 ++++
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3720923b22d..b8265badbe29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2242,11 +2242,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2521,16 +2516,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2549,31 +2545,46 @@ static void __mptcp_retrans(struct sock *sk)
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
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
 
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
+			lock_sock(ssk);
 
-	release_sock(ssk);
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
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 923c07296ff3..edddd7cceada 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -156,11 +156,17 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
+	sock_owned_by_me((const struct sock *)msk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
 	}
 
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	if (!msk->sched) {
 		ssk = mptcp_subflow_get_retrans(msk);
 		if (!ssk)
-- 
2.35.3

