Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B120F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3kjscRkMCxSHJ1SlGfjRCjtSXtwwm9Ws0K4ZntzLm8PIOp5bhPEBZgYV0s6NkgeAJMB8EsxeHRyr6FT8GCtuji15izEKRAqRbQQt6/k8XUYQwAZ4P93ocNLPuegJVxf8cUPlolqgGjSbvZZT8kKWZllgsTa+T4FnSQcrwHUlwZFIvUJRLf47NdNuE9jup8uwPFJ9pBV7RM5G56IFTyQFA3jhYjWECc4qoLrF/7YWlx8YfePPcjZBngMpIg+y0x9OVDj2yfPohxPBcn1RiCIJbW9yrCsc4yoKefI6hu3Cqits5BBtWzw4WDtBe5xKov+Z8SHQ33GxFXKaUNc7JlBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6TPfxDlCKt8v1bk8W1HZ6hV4gASnmxn9XG6WTjIXUA=;
 b=QZui1bmVWGkGpTiaF9XtN30ktq+KQyacqn3VilFiVwjTdskz3Il4yG5iss1bzTBoOME1U+JFD8uZ1gBLudkLf5+cmHmSx2TBO2sIzTbw3a+ppK936TjgiiUEWeD5d/bi4mn9Zo62QAxG5PphskD4GWlx8h3fW+BHJIlQp0snPbUeYgpDdwGVFPnGiyOrGdl4Gk+Z5JefHKmvzd946s1JvNl8PT5Q+klsPtYjOxDZwKP9WiazZyo5I58AmRqrciTbWTjBBPfYe5FCgDrIps815IsDwDGgKXifhqwvlXWdWcXS+rpffNd0xN2BpYF4GDktZfqeS5JbJXa6nUBfM7LHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6TPfxDlCKt8v1bk8W1HZ6hV4gASnmxn9XG6WTjIXUA=;
 b=Vnf32k2Ue/QaCzFQjfNOfveKXVhgwrq+b5dJv3LGTdsL24HNCmGz3VI+W1JUPqBnil4RYiGAuU+mEUhoBEnUO4OvsVyOVs2Qahz3NzQdFT5rc6+jFu4UK8D42mNYZz0MsaojDPoGeY4KbVv2fYGxoemMIaZHK96Ny4/EVQjP78KnT3JBKjmMrm4hIEkzE0iMf7ZkgtZ2V4Td63T036B7IW7BjUMi7UZATU1mTzCuOehpbXxEKVPZlFBT90Ux22ZRXIqfILue+D9yNHkrAQV+53nUrlDeGEQt5QKmocRs2k8+IUGLmkrx7rDTezQ2S0A9Yu4DBmbvmyyIsRLJn6unSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 07/15] mptcp: drop last_snd in mptcp_sock
Date: Fri, 14 Oct 2022 21:32:14 +0800
Message-Id: <d9c0d49055aa8ca16f4311dc4a8506bf13f8be8c.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acbea95-dea1-436f-d138-08daade8b95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2JUGvNK5P1s7QHWv2iot7lWka3MQZAsfvy+AMTvOUCyYlXmWKz1hKgLLYdlSJxTmpXx+hZDTHlmlFy9JDP/01EKXYXAKdvPK1SMsQU2Jxr25hsX0OnErX5MHsvV2bXkZk4FlefeccheaPAIE/ytLeP0X9bRab89FWo93aEcEM4HyIuI38KaDBTzKzuJaxpHU9eNHef7R/6SXV2TUeNGJaMNyso8eN1PPsjabymLCE8C+N0XWw2p+1SswuAgu7eRuKvhfoRNEtAQDPxJn80AaFpOK9HUZL1WAYmafQDiGNmVoZ1lII+R0VBQ6G5YC4b+fGDRcgc2S17pWLsu3Ui+exxhVN0VqI4TwVarsd3nZcnqfpvOgpaUEWoQeIfQMl3NBtx542FBgDLYKClylX8V1dxTwMy4qkoPLQQBl50xfSH8h69Dotx1lHd/JKl9q5j2b7JTuEEj+6jrSGH1Up1dqZwBWhdFtKJ82rw/MezS76VOqmfD8ZNFlaax3AG1XGXyBZbKvGUZ00CfNvRwyl2yfbkcQGs/+5hB3vvMMiz205VWpmJLu+71jKD1YJBs10AqGWxQTEBA4LJV3onYo2nuPLvrPT2Sv3udP5MiNqlpMG0JhG6NAVpDnexdt6dSKYSZpN7qVjnTIhBGMqE6nOHi5QlfpbmrG7muLFUzI0Yj4qEwefO1YgL3y+ibs/IX4CKawqUsqB7cfWvWASBu0qETGe58NyJ1jLPeOEZVtEnRH3+HoXbkGnE01Bd33Z32Zyvqx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6lj6yO5MLI5FTWM1GL2UFJFstkmcn3VpVynA8HPcWmFdm/sam73jkEiAuEex?=
 =?us-ascii?Q?SVe92woBv32ie9fA8Nf4O/Gavin/TkppapJl0UxBcavYqna9vterno3KF47m?=
 =?us-ascii?Q?Nl42/nVf8YrpMkk/exgDoh265LhNvlJId6v9JiuT20OtAws/KQlBYaKRmZrJ?=
 =?us-ascii?Q?u73xQDsmnZgeOSNEAtQQ7RJDYpogtMs+6VmKQjZHoHW7AHwbJP6oI297OJEG?=
 =?us-ascii?Q?tOHZ7ZPzX6PFBk94K9SDf8bEtrnZjjLi74sdBMPfzGK5Ikde9dmyoKLfkasp?=
 =?us-ascii?Q?TgsVtGKO7cbXoTCKQ2nxOehDuu6lbfH5Cx/qqQBBnl98UGGdIxYFOulI8wHg?=
 =?us-ascii?Q?vE3Qz7CGNOMLD29krIK+9/T6QzDX2OtA94wNs7E7E10OPLBQddvyVGiFDuXP?=
 =?us-ascii?Q?UxDuVVT3ohI12c9hk3KElx3+ZSdpk1lr6D+ZwUfYDqSKyrhR3UhHNGBC05zi?=
 =?us-ascii?Q?JgXWdGBfq7YvfXjKmTQ2++/4XQ6MG6vPW7Cr6hAoOhYEAt+Df7E20btDXubF?=
 =?us-ascii?Q?rbhIC4t4OLrmaNDP7E12pYUG2s1xTraJHco3gOPl/PPJMyr3T38Pcc7O5TFj?=
 =?us-ascii?Q?kMSutjOanMmDzWxWzRIrKIfOnhh/lSM0Ng6eOuQH5C35jes1sqWxAP/gsw7r?=
 =?us-ascii?Q?cLOb1Qw9YNU/QiSx5MQC2fcpBKexrA3eP9RHVV1jKOBeyOLTCbp3rFSY35C1?=
 =?us-ascii?Q?7iIcKe2+x5SQaDCKMDpS4ac6UFA+QxK9NMCgMp6weDirHplQEB/Uouw7/hsf?=
 =?us-ascii?Q?IkWY02qx0TWW/7dSSYZj7OsMlHsqA9/YBrO3z1cKuhqopeIT7Asgxmf0J8E0?=
 =?us-ascii?Q?Yj/yOaj/QAKtqCIPb/5QK2/UsW71DC94WvOi8+YuXMWpj0JsqNR4j/KoFd4c?=
 =?us-ascii?Q?fFqdl2YnEyBPpsGM1ZiZFK7+rWTUh+UFRoFSFc9SJpQFRLC1ZBrXloUaX1v6?=
 =?us-ascii?Q?M0eA3OrECXOkROmQkIiggLmzOCZp4+Y0nMW1xIAi6FQDnAKmD2LNL7sEJBmk?=
 =?us-ascii?Q?oL5gF11DXVcTd44NkEDTzzE42awjWOHBpCnnl3JYaZc/DK46g43DR8VH/2uw?=
 =?us-ascii?Q?/sTNljZNkgbmYLvHrwddfBBeH1TlFtAtfYvvL6NUKTeziDBUEhB3iveub1le?=
 =?us-ascii?Q?RoK1aR69UwQ7K2DwXMFJRxq9nIP/Ka7iKvcZT1OhHVoxMKzUIF2JB4dUmNqX?=
 =?us-ascii?Q?L7h28HnTnOzGvmaw0ORHiUDw5/DY1z8qpklkDQKRrQdeD+19EyjxI6BkcXjG?=
 =?us-ascii?Q?OCYnVPddTWnEO8woEQcB2jjRj+DMKqfOq3jmWDVIGMJrO1uNcFZWi4p5f0jV?=
 =?us-ascii?Q?8qp7YhztSGglaSKctcWNnIaiOvbg/J8z4tQzysGZWsfvnHsDW8k7uoGrqbYF?=
 =?us-ascii?Q?lLNudD08I7A4z6qM32xc2I1m1A6Yt0B/9bp9YTsFglPiqn7i9DfkZJ5ccpB8?=
 =?us-ascii?Q?L7+4NvT5edAd3NkrKi0EG+vgIvlTeb0xhmpxy5fwJRMVdO32E1LSKMxu1v0U?=
 =?us-ascii?Q?eonABv+RoNDOMcua9XNMDAgxEX13f6iLEh21I7SVaYPHJ8NXPNiKVt0N/Dc1?=
 =?us-ascii?Q?DnyvRMrbtptcACWHu7MFhPd3d25iK8yWeG71HZIRfaRc+M+o7qH6rVBkKNET?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acbea95-dea1-436f-d138-08daade8b95b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:48.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0a0eoJIaDlarbg7csjhBGNA5cyEv5k85gPfGV/m1bpHwmQmEK7AUEgAbj4/nnHn06lnpSjLFS+sstPm5peamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

msk->last_snd is no longer used anymore, drop it as well as the macro
MPTCP_RESET_SCHEDULER.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  9 +--------
 net/mptcp/pm_netlink.c |  3 ---
 net/mptcp/protocol.c   | 11 +----------
 net/mptcp/protocol.h   |  2 --
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..1f2da4aedcb4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c3a4e0148c4a..106d22730954 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1479,16 +1479,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	data->snd_burst = burst;
 	return ssk;
 }
@@ -2353,9 +2350,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		msk->first = NULL;
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2988,7 +2982,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
@@ -3249,8 +3242,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b731e7b37f5a..e553fe70f9a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -258,7 +257,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
-- 
2.35.3

