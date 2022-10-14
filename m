Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947C20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3QkEC9Jv6u5/Ug81tnhBXf4GVV7vSdK5kBRJny7FIWQA+SmptpXjcevcD9JBe4l8weFnsoOq4kt5CxqJP/vp5IkjanIG/sSgv/4QZtqBd12NjDl5M0L61RunccrSmXr81SVi6li1PHzx6+EEG+Kw42+E7MZ6FBGava1eWSQeeCyCfG5UgtDK9PNK/b24fv0/9ZD8o41+MeG7Q9uWhq8+0/jZMdAdnZoCreempH14SUE9g2WbfTr3HFF92L2LZM5gfrlpUarBm6kHMYvjxf+3BlbPYipKFZFVvLBP0pCM3+HwbO3PSMiOQiOi4kzvkdYRoFrFHILihKjrVFGJ6DgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDK/2go57nScxnQvN/asspRkLshK9MFb5x62ZMuJcvU=;
 b=NHW85CLZRTXC1jaGSZbyxtt2aHxXsM9bWDRS3yccMjlhddOX56Kf76UMFi3JAaV3/lwuZiwOSjqK98pe0gm4Le6i0IM/OwKTus+L+Ecc6uFSJw5oua/y0DFuYEcCqJvtk6PkwfS0LsHObold67p4H4cCNjvno+uRKBZnqdVfLf2xmCe0XMKDCR5iys+HOAtpbveFlQE4mHxdkVd7txB2y/LpUFMH8QYaAmcwQXQ+6Pibn055zeTKFC1DIIDUDD7qFIrRs1cudFbbpASzeeghJ0qQkCvjzSE/21wqxPzTlz2DTIvv1WzC8Tz0QTgvWMy4uq2UeEJjvxleZxRUNo7qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDK/2go57nScxnQvN/asspRkLshK9MFb5x62ZMuJcvU=;
 b=UoUEhNcsjHSszOze6ZcCIiT61LJsiCUGEZ0jm/wNawO/fFB5g8gBAiP8OMIDcIz9Di4eKp5EDd8zYB6OhsKqEhXqGqTa2uQtRWA/q6WDF0Q2x4gaCz3Q7bobxxzqLmOj4ZbVAgs0HEZTFpkDEwT1MBe/4bj0VhbyxlacLUJL6ilczUJzWIkcelUg83MCgN3bZgqLX4HmO+qpGgFprooJOngr5i3UZyUkcbDpUIs6TkOet4ztT42S9lHqT7/bJPlRaMzUKiAYmMuD/4hb0uieJdkkTMd033rfZYQz+3aDjpPKo0xSjMhS0UtA+OE2nP6x7L/KvP0veYGVONg9/F1tVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:32:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:32:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 01/15] Revert "mptcp: add get_subflow wrappers"
Date: Fri, 14 Oct 2022 21:32:08 +0800
Message-Id: <603d5313d1e6c41952db88b09d2bd24418a1a73b.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: a796b922-f2e8-407d-7507-08daade894a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XHZzjjd91eZGY9eXKMTcm6d61SxL8Yb2MlqD5JD8zZoxPs56aiOcUHBWG9ejP4z+poOdDIymswvvNV94svJr3kdmyKhlHPJtr/WplMbtoYf6u+znM7BW8joCIyvonbwsTKYzXv4JIeEd5zDtPHPbzYmDcuIesrI9xfj2NxYT4STkTMcpEvQr7drO2KRkj3eweKulQV6OCIpImwWKwSoZ/IENWNckJulKyUa9ws/bUmXxbdWOsoIAC3RQgAsz5b4lZdYRTyyJIttzTCgvrmBwqaerfIAsPDPXTujZOn063cGB1+WPmShYQ0uTTyyO3yEaQsZTKOAjZrt1LMr+fYc8QMLKBNMi/XhhdmbYaCp5vOfb8uHJdkImjlvxHQZiK2RGhE6v0iyYVk0/NfntOf+sOTNS2+xnbr0pg1xg/qJo/WebBwDhQpPeXjyt7GODmZ2DIegZd6kP6uBeyRAmjBG44IrZKVBsrUMny2dbSVvBb+KGZy/tWikbHQXI/0fVvIAL/lmXO0gVTVAaNF/CqIMBgirU6ycz5hxWNoRiUPwYEHd2EqI1YMIKOD4Qh3EipRNnOI/lhJ6ebqPS1geJAQiiPI1KjbyS/VkEcon6zhtUJ3smMeyCrwqhHQOJTcgJ6+AIMisl1GLtPJ9qSiSd+zI9bh0eenXY2gpFHdrOCzpKIcxWHB4z2lAr4/nJOJM+DFQNRWJATVA7DTwLB/N9Eijq/UMIorP/XRbd1+OZrYIhk3V8QtrrEUjtE+d/WczcKf4Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?guYlIPoavR6JRApzA8uwo8IV84GCgvaM+EHCxrjSSGCE/5/9IfAPiDdu2ye6?=
 =?us-ascii?Q?taCK/FuGT4IqbqfQ+imncu61Y61xXiUfNrwakLO3RRq8DvXsH30+1SEfQJpz?=
 =?us-ascii?Q?mIYaWSNSs7/FsNsChqrB0EG5XXLJbom8jOsSUUhaNMd4FXp7ELcXRYwkJIH/?=
 =?us-ascii?Q?oGqhCqWwz84PUzvdMFtRiU0BV7ZdVPAsGFI3xd4vObIhnDxmr0Y/CQqhuSeO?=
 =?us-ascii?Q?bASt2JLyljehAazM8lb7uhKacRVI7aFRqMf9SicidfGE7Om6e7B3edYZN6uX?=
 =?us-ascii?Q?d3CuC+Zsry4MBu967kXam+18vT0myURBKL/HYR8o1AKbUVb9bFmvBeVdrWmc?=
 =?us-ascii?Q?IAof3cteDsYG0LJk5k3mR5NEHSa+ZZvS3oYFtu+XtZj99A0U4hfvOsfB0D5W?=
 =?us-ascii?Q?2uFfhiAqwiTMHpK5QPOUWDdlC0iTNk00g80xyFpHnSCnzA94mWpoyoq7H1u7?=
 =?us-ascii?Q?EDFjsxJpMpL9LG6d0lejtmSi4QyaoZHyjtuyJy603KQlIReSdO7fjrewjO8M?=
 =?us-ascii?Q?6eKFcZrOlSCSBcpJg4seCRsGebLspw3CpyHSgqDU+P3PmMVqgEDor8OP8jt/?=
 =?us-ascii?Q?O7phuIrqH2t7yNuaEuuzOXNIa+J+sgfvcsoc9OgE/BGu79RqVCnGr1hG7ldO?=
 =?us-ascii?Q?mLdTureDGbvAHoNllIdrpogFId6yAQhMlKx/aZWsaVPub02t1fThUHsH9ky/?=
 =?us-ascii?Q?94w1HGHv/kwXrfkvPXpd0sco4SDPEkEg5Owwprn8l88WH9T+rcxBmipEocOt?=
 =?us-ascii?Q?iOI8BVw4SqVybNWwYLBCECTfQjaGICJ66E0u86oOMaSfcqTfKzZWcF9EfcaI?=
 =?us-ascii?Q?LysfPJagTQjF6jrvEyWeiYXh8tVp5BYBnAI92bLVvkZ9EZd/cOztDJj+iOuO?=
 =?us-ascii?Q?O89w0Aop730O98nW73bwpo7e0EaubNzEfzHv0MxDwWCpKUKwALj2+XwA7XaC?=
 =?us-ascii?Q?UqE8BPeMy5m6n0rT5wLr1UgT+yoQY/vGgHZoF+S8CnkrB2ahV3Y9JMTRh1sH?=
 =?us-ascii?Q?6ZAsbT3UvV3fg5XFXbvHCeTYuH/yrFFH/R0dgvUEufY/joT6cZT/PRIRofWd?=
 =?us-ascii?Q?Yd7p+CcPHQ+oP42Tw3kL2v3fubVN3Yjc6kIW91fOd5iQ8RB22LX3v8ZGqvbV?=
 =?us-ascii?Q?Gu78aY4MlMUCQkxbqC6rCW/nJukeN51EFVmKn8LRzE7vMnUGEvdd3SJpx7DS?=
 =?us-ascii?Q?jh8FxEq6mqINiIURXVgq3KazF+zuyIf0FyiHVPng8T84omN10clSa2VBonEn?=
 =?us-ascii?Q?tRD2L07sQxQstOa2q0c33rv16XKiomTQmWw6+zq9XAKzPXdzj0WBazs6hPfY?=
 =?us-ascii?Q?+5V0hh55XScOB90GotBQa8hMay8WsCMK4InjIiPoAZSmY4I1Bjgv+gOmbOhD?=
 =?us-ascii?Q?GDrfbeYNTLyKnbo37Fm+sQzS5JfDj2B1rcbbTa5zgeXoe6FG6goSkOffogkN?=
 =?us-ascii?Q?AdJnuugue4mCDU/aspou2Ws4+JjZcpgpQoEfdovSwGo494OIFcrRgSHp8oCL?=
 =?us-ascii?Q?C2pt4Sj18GOxqWvDa2BXG4NkOVvtH5pVhZTqRToS9rgMDIKzxFNtEzHsKnur?=
 =?us-ascii?Q?XnDzBz+oQ2exkJCBX6AB5bWfxGDYThRcCxyam61mUltQEjSsnBjBgugKbboJ?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a796b922-f2e8-407d-7507-08daade894a8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:32:47.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDnk/s3311Fps8EurdU1VKgVTIIs90gYVeiqw3DcO2c2dsYsKWfgO5rH4n8fB93gxbiA25YfbbdwWrCr1RGyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

This reverts commit 517ab13fd55a51e77c1dd39d6023fe568aa250a5.
---
 net/mptcp/protocol.c | 26 ++++++++++----
 net/mptcp/protocol.h |  4 ---
 net/mptcp/sched.c    | 85 --------------------------------------------
 3 files changed, 20 insertions(+), 95 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d34765db0700..8ad13569cb25 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1417,6 +1417,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
+	sock_owned_by_me(sk);
+
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
+			return NULL;
+		return __tcp_can_send(msk->first) &&
+		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
@@ -1547,7 +1556,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1616,7 +1625,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2193,12 +2202,17 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2481,7 +2495,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3199,7 +3213,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2358a4083eb3..270c187c9001 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,10 +641,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..d295b92a5789 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -93,88 +93,3 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
-
-static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
-				 struct mptcp_sched_data *data)
-{
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	data->reinject = reinject;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
-
-	return 0;
-}
-
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-	int i;
-
-	sock_owned_by_me((struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_send */
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
-
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
-}
-
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-	int i;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_retrans */
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
-
-	mptcp_sched_data_init(msk, true, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
-}
-- 
2.35.3

