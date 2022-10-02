Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF133D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbB8IicRLiyrfwf33hZVlc+AhSZqu8/Mu0rpmw0zefxx/WT2JH9yA5sA6t/bHcCcpHgl4Qi/T2IremL0JVumO7EqCcGDNeZU/gL7I6emCEFBKugOhh/SpZjmnSuH1dQgaJQ+vIEUmIjpA+P1N0Ba4ewVLH/bDy2WWhonRalmBJI6A7y4E6yOuhNcRzm78OhVbXjjDOp8HBqFqN/hmSMh2D7MXuCkB1V5kMirUlEXuhnnIiz39nIJ9JnAo2fyjbQpfOYERXuGZjvG8lj+bgqrue/KNxD2MAodOJnKeauMj4841s/ygQ+6ieG8Xhv9eUYQbGqRlQ9/8mg51itgJt4MdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hebWbYBPjN753RtkY5tGxwSFNIrTnUNdndoflBJfo4U=;
 b=bjrrsYhaUIypdhL9ANnnXNjidKwdbIzQe130lr1SgVBhZevSKE/c4g2S1EKRZJZIAokTfxIeyPC/MjhTGOaHNkzLChEZWfUmvwMcq+vzWFwI3ixKmX8gpYvqPxlhvR8hbVYXf+GDLM94LzEn50ZBts3+aRPxY5lWFctbXeHkd6tH1txA8KV/c9fXVvrzdKI783iSBGH4qgGI66r71oCA2DQlFsZJc+KblSy2wOMh5OdwYrhMzR5y3zHje3jPePh5wfKlm+bnN82F39NSAo15jYu9vntPk8DNHeH31T0qNPB1YF1Z3eICj+jV6nRamFyNVdZJoJX4zRSOHCgXc/aaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hebWbYBPjN753RtkY5tGxwSFNIrTnUNdndoflBJfo4U=;
 b=3pcChPkrm6Z8SEd9DilQXtYSbeskvVp3WNUjFS9+UHQeXXo+T3n9DRrDAf4hhilMvMH1KcT4fkMU7qG3hJPHWwb5G0AKrcbwFsoLfbfrJEUb6uNAaRFpgSFVQ6ddgwichimZGcd0uVxXfr9/6IZPDY8v5ZCAHMb+BAokgKYjcG5mCK9qMGX+rway9ZCELUvTcKDDn8f+EwxL815ZQ5mM/4Cgqo0+/GgALkOpUx/39eDnY8iFyC64vBRNWS10Eadh1Bcl24DOZBc+Ee0Q9clpAQdPu3j1KbcoVdLI5aXg7hVPUBqXS7UEKnIZLGgP6j0GgV61hqqv4Z5MpdLXL0VT7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Sun, 2 Oct
 2022 14:24:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:24:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 01/11] Squash to "mptcp: add get_subflow wrappers"
Date: Sun,  2 Oct 2022 22:25:09 +0800
Message-Id: <564b5c387644eb2b83c7bb03e0fe638d16acf6bc.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b80c01-7b7a-40f8-850f-08daa481db42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wC7yTbTD2w22f/brkgbVSQC5nTTI4rkXMnYEVeA/K71BmbAsIxBYIY3ChRC9V63MUhk46CCsao9gqdF5nyNxvJwWRwuys44uwgtvvUdd0wPQJKSuDACwYLvbeJAnbP3eG7BRCx6LkWLN5UGBCstRGUxm4ShtMKtMApBfmpXM5D0JafbcZl+cklm5WRsLGcwZk/0AoKnIOVx6kSeJB3Leg0HPkz67zqgCi5flAvZuCVqqelHWBgmpvuWfBaJhurufbV10Rxy0GXPv/rSmpSDHgS6D6IID/v8LpBCbZ7nKsKNz7RxJibgaZs4LslY3uwu6vpwgk+Xl0mexJhDBDfidAnSxrlT510EJZgfuZC0exTHMe0IZzc7U9mh1EqbZVZzLCgW80Sd7lYMf5zG7Iv94v8T2rw7niQZEv5+mvI+sKOavC5YMoUL6qjYUi2wD14CVOM+fAjgll7EC3qcQQyrtlT2bw0Fty7o4ZiPcPfMplriSsedlEhtJBK07PuQV/o+vHcFWWxGYR5haLsKbpykCxFraza0ZuBoxEfvKUdi9amB/iRHSyUeCanYSnsZU5+fYbE6/XKxjYO4XGCB3w0He/ZYe53vJR9KnQrD6fGMS7LR+0f1pHQzgmVFJmLyffLktFETeo5ScnUI740fPr0dNDFy03dtFtI4yNN0KFQh+wpTDPuOdrsJ8ji9LpTUANn819dUTgNHRhNMMtIoR84t16w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39850400004)(451199015)(316002)(6666004)(6916009)(2906002)(8936002)(44832011)(36756003)(66556008)(66946007)(5660300002)(8676002)(4326008)(26005)(41300700001)(66476007)(6506007)(186003)(38100700002)(83380400001)(478600001)(2616005)(6486002)(6512007)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frhv82kVjVoUFmwzNsZuqmU86zie9HQG2UFLlA100nAIFcqKeJlLuhxKGom8?=
 =?us-ascii?Q?7dtpYw+/30VSsjh6lb+wxy1Y9a2FYe2k8WIt1AvbKS4vmhViWylSd8qK+j8X?=
 =?us-ascii?Q?KOtqNKCmppca1UQXfFzArXdqyjYKvDq8/0TKjYDLX+XlXVS49UU96s+SKu72?=
 =?us-ascii?Q?/4bp+GmSBSTZDVdL2Y0xa5YNIf0wBFE1EY+gCWh4FT3/M4VpkDjizYjTuGHQ?=
 =?us-ascii?Q?DIH8u4gab76Qee0/Ijf3nIxo0kVPzAJ16LIu0dHwhYgckhl4frdVMnlOSj14?=
 =?us-ascii?Q?BDHAxGSLmiJWIt1Ptu8KKKy/dFcVPoknb0wBS+1VSs2bqAVVuQ35fgiYlIt3?=
 =?us-ascii?Q?kNWwUPlpdzb1+dFY84E1xBiEvS5k+eTIsxLkiBYF3DlS9i9WDVGcnAZIgVxr?=
 =?us-ascii?Q?hQVIl6uJys5gFBr4/C7lX1MDU0eH+xJF1yqESHmO/qPsKqu+eJlVizuFpH5G?=
 =?us-ascii?Q?ddanh8OGdJSf2V7y3U9Po1BSELdcnJ6GYDJ6+2AGQx9v8MZrAjXVA+mTvMKS?=
 =?us-ascii?Q?u0v8+VhAd3mO2Y595I2tjaQTRNqp88SnMlE6PF57tJOUjcDZZkTLZ+mVzSSg?=
 =?us-ascii?Q?ey8lvpuvm1VCf2jhnogApHEDF6c9vBIg+gUXxbiQroZKp0Y1DmizA/8ZFqGA?=
 =?us-ascii?Q?kBEDeYo5izzv3oR7YVsCwwEpOOmIR1Mu2PfZcjSBCk10BG7PAIbCiH2KTPmG?=
 =?us-ascii?Q?RC4qKYqHB3DCgHfBJc2Ps2IqzopDA0jMnTei8mTk5sAik3P10mNHl9i5vLBo?=
 =?us-ascii?Q?E2uAjhxNHi/ZIYCyUVBxu4iXOkA2LotvMjd7QAnw2P36jfGCTp0vv5r3WQ5Y?=
 =?us-ascii?Q?PpwMlzcOqnXbFquUVix1XG4fTmBq+cfdfnnOQ36PNWEEh42JnMCG9xpRdi5d?=
 =?us-ascii?Q?mQpjjWD16gH458Y6knsaBbkDR8Xwbj+beVVRdlgRAwveIki4Svio+vSRPiyb?=
 =?us-ascii?Q?Ur4JORprIuM5KPfM3R/eJfFuVdWI6WLBV9LRaw5hzdANkr/mT+IfaowD2UV0?=
 =?us-ascii?Q?nRpMm/0KGx/dLr3S5isVs1+kDgCH21QGXOwsB8PiI9QMZJUGdTPeyfv2UqxB?=
 =?us-ascii?Q?mn6MJlSLAh4ECOskLfJhOV1H2Kz0oSR9wyUFDuzGMWhcOzWTUE0mRcpIjs4g?=
 =?us-ascii?Q?+5jIcLNOLiar6BOZ1GYvP229FjZA+V6gdEUhLNiUx2X+30JU9OglghfgHT5g?=
 =?us-ascii?Q?Jr7t54e9kAVh1MvMAPudb+6fQpliU7xJf3N8ETZzXgkfck4cNDVER4OJ4zxZ?=
 =?us-ascii?Q?rO03SP+WdWQGeYE6/VK90XULh3as1wB75BK5J/s8+D0BDXtU2V7DWKeAuYdJ?=
 =?us-ascii?Q?RpawiowB0ECOBITvfF0xTZA31D05XVcE7yU+O/KR7BGZfJhWBjOLZFMm+JFT?=
 =?us-ascii?Q?jx5lX6xX1Ac8EN44ZSJddxVii9omNqFeAmNt7dzmGfmaqTjAywP0NaEnm+WT?=
 =?us-ascii?Q?zLUf4OW67oYX3f5x3Jogbkcuiuj+e4avnJ3Fcj2jkY+Md2D1R0EsYNOM5Nw3?=
 =?us-ascii?Q?3FMztGnJw++q8wBIAaZPK5Pn+tkjIOnRzA4RBl5XVFpr9ON3vb0R6CnC8pBv?=
 =?us-ascii?Q?XK2a3FCWtl22KFHkbfDvTl9uzV8Zynp0vCZFBVc73kQG18cQ34eqOZvhvDAm?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b80c01-7b7a-40f8-850f-08daa481db42
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:24:46.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbWwQHkwjj1yGPQz0Lqv02cLNqswFYQn6QDTgtbs7KWR2hR+4G10q86ZT+LYF13lZKJKQL0do4dJrtlPlbupxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.
'''
---
 net/mptcp/protocol.c |  8 +++---
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 59 +++++++++++++++++++++-----------------------
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ca21915b3d1..cc8e67543e76 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1547,7 +1547,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1616,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2478,7 +2478,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3196,7 +3196,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93c535440a5c..e81399debff9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,8 +640,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..d1cad1eefb35 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,67 +114,64 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
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

