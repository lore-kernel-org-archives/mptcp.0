Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B917CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHX4PRMCotSsKOgOn/525f/SUCZPP33/nfap4nrv1zLrzwjBrZozyIla/cDZhBDwFHKFpdsA3An1ENlzoGS4TwSd5Sl8S7XOPmvk7T9bt9Ck5MIpVT9KxFb9pPx7WM3Iv32EFS4yT961kX/i4V9J1EkyH0z8cjioCsu9c39SqUlAI4KqOP1W+reJdqZpD2H8nZ1MROasJRxI7LwaP4qI7GrYuVxANjOgWtuYEVTCSOb/3lSam8REf3Fvj6BhN1Y2vzMD3D3OXOM+XfEP2X6UktgEEROB80eHBoNjJurEeEtl7QkRfiUO8fQw2O+UFUiDfHU4tIKLBhPCyKn4Q5hUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=womHxEQqr+muOUDWWuHI57fTytEHfNTMM41UpogoXiQ=;
 b=N6FNDXRHHTLTQLIZRrGCFuFXOjninSgijEqLzNEltdJBdY+BzrI3GX1INBaeo/F2WNWzkuBtfCCmdVwkSJJd7uMs8TdwPLY7gFyF0H72za3EVKy5dJfKp0s9nEbu8cIjf2mqvZnQi5uJrIp3pDFpevmabfK8dGbrbZ3xRx+AAoYk5j4dJuuu/BJNqs50Zmw0fmPH/j+REbSWJswPG7zAN7aolXoTEjk5Irde/lhjvDPe1LLWMGclQn0suSZdvo4fp1HO7ZtZRQKLIvxkmBCfFvCH360Ue0OkNBoKhnwqKR0yY2E4ukl/4hwMuNO/WP1fthF8jIMuLxZl199ACO5wKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=womHxEQqr+muOUDWWuHI57fTytEHfNTMM41UpogoXiQ=;
 b=dZTcgxa4eZyeb9N84509xoYNNnYv59JVO/mJsfLm2HUQzPRkOnoDiWyrV3b0XBpfWGl3FkFMcEIbP2rIhDoyQdwzbbDnxRo3AhPAa1DwLq0eoYay+EhgQsyuVc/sIKBTupQlbDvxkl21ztOu1ZXw+P9zvSQqOm9gYy0OMHiAKSpggMOZ+y0+3GMbUe5UQGGgUIaDKl1SH4aH9ax15wZXBM1FzOPlLeZllPl3wWayLsvr74AO+ulBpG/tN50YKUuxVaTjAgdmMTTSy/ULAiPKmkZaURAANYqqpWS02CBPNOAyOkIXvXbKLsCNi8FZY1B5oj8kYSulg16oM65JtMl8UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 05/12] mptcp: simplify push_pending
Date: Wed, 12 Oct 2022 12:40:00 +0800
Message-Id: <3a974f4a2eeaaeb500048655d1d0af5cfe7e9aa8.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: d32673ab-366b-4d4b-5614-08daac0bee41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VGam6q9cwIdWWgNr2ZCBqyifvyvCLSFH9KLhd/g9Flz0oP27Tc0B17W3Um+aTOxI9pa/IVYTQBsIlo7HrVOVecTsF8bIcTEmwAdZow8Wy3UBZ1fkFJofrwSftQGH4J7/KZB0cKRUMgxC5RYY7uMdG9Nw68sB8eQGvMa0JfqY9iV8MsbaieikvGLMRNMUQya0CeJtnvQEUPhnGolwa32GMq+uUe5Pk+KkP7fLoFV5g2v3PvNXruJ0aGN9XRaljBJJHfR6VYg/abYSIqDbE8DaP46hh2FQrQUQyDP8pWxCBLuURpryekUOoTVPniFT44OrCekmqFWiKgxJLnzDMJ2Ykn0js/29pvcp+FQ8Z4q+TX5GC1jbKH0yHo8TSZm4zlN1POb+mB21p/kQkIYnRn2I9VCWtlsXvc24pxXN0d0WnahR5Ezs7YHk3zFo/HaKqEkQNaRmO0WSnmmdBrLdfAQ8SRfEcgpZ0lum3Eg0953RylvgklaEd3nKAq4rtdYB/r8LocoDBzxDHjQiGM/v0a+71FW3Jp3Z7C02zPoTXhRtDE3r6v4Bjw2o6FWZUVy3EyM6li1H3N97zLClbGbG8lqi1HPSrv8FHRlXWcjf7X6i2xtga9RKeZqNeWn9WdJIHf7zPw9hs1HCaJsE4P/vuu+rRfMGyjgGuox04B44mIyClS+yq9yho8FWefbP1dAWM/+O8Qoingos/tNSMrlm3EFHgVTp6q7BYBS+GIc+4L91vH08zhqQqmigt/G4W9GbAt7G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RuYoQwq5uC99GBDZhJ7RwFeZQ7ZyaofTJ9VXpiWzFx6h6/9ntNis50EFYvQV?=
 =?us-ascii?Q?Oyyv0+MowDwxJYaFs+trRMh63PNvRRgAvpkT7LFSUOxV6i3BuN9gACXLnRyJ?=
 =?us-ascii?Q?sCQC6rd33ArHaPt79tWbjWHjwBDFhTFcixHhWJ1a1j/mtXnjFWd5HQyacEAm?=
 =?us-ascii?Q?ABpXMkC1AI1X1bLiKlm+pkpcYLMxf5p0Mas23ic+Yn4nAYR+tOf5VF48Ts9W?=
 =?us-ascii?Q?HCnloXF9I1ceSgeuiSS4YUAOWjxAVfLUGP/zbflLDEcBxQjOAiuOQwjMaFwH?=
 =?us-ascii?Q?Ia23eztGNEdeY5inVG1lvpWYUu2maEy5VWSXSQxV3pVXIgwnpUVmbhfBf3M7?=
 =?us-ascii?Q?yLPVvSDnCFKML3wMpo84SM9JuxbO0bMaV0qz2rVOFMvmFDimp/561FombiZ5?=
 =?us-ascii?Q?apmUupR1KKkiUUoHdeXpS6jg2i9V8ad3DkznaB43klDa2LxeKnMFc6nsxueo?=
 =?us-ascii?Q?mFKA6hMXQD4RwxvpTdnoOw2AD3n2gCX0Nzl584ECpffX3oxF8AglSIzhD85y?=
 =?us-ascii?Q?l6sBSFXSMcxhyBIFVMyQ64re4gXz6rP1t47IsCigWkv6zu4aS4gMHgZKZrvs?=
 =?us-ascii?Q?C6NRjqMD8FywxLbcCY4ONOIaayR/cjkns6hhPKvpPE9yf43uODfXivWlofnE?=
 =?us-ascii?Q?cmPZpeRj/0dW3opmQutzTrW5+M2iOkeHOL4PRk02V7ufUuqHwI+0tAbgh/jt?=
 =?us-ascii?Q?uexyBMru76ZRu91qozmZm8eeN96656pUBw39JPlQg7jGfKnqbw5ArDFm59qp?=
 =?us-ascii?Q?1NWqrmvO7upDeeQpN6eQB7JsdIUFEYNt5Ql9h+CFVAwvMd1BSX7WIz5xPtBF?=
 =?us-ascii?Q?lM9C5EK/SqxHQMWuJQKQ+UEfeMbGR1AktPMpORHZ7VQDnyIuM2T+9kzsQR+6?=
 =?us-ascii?Q?lwjYWrvdtmiQTYvwhKm2bUzqD9+vOp7CtEWGP13VSMZfERvLGNkoOhd/o79g?=
 =?us-ascii?Q?Y5s7SC0T5FYHfVr7aVMM9KEQmYKxWs8ufRU4eb5RS1sxPDAVfek+zg1iThkE?=
 =?us-ascii?Q?GVvX1fbF3/ubpgL1NZySwU08wT+QMd6XJsr9d4vf2KRBGo00WUaf0iqaOspY?=
 =?us-ascii?Q?7aOU7XHfUamFKl1A54w4EbaT/k940vM4c2WK6EZgR1CYHkQL0w8hsqJXeLcZ?=
 =?us-ascii?Q?h30mqdH8k9yMGSgOtXrK+eU8/yeIDD+2ETFclB3qjsoBjATt+O1L7B/LnrFD?=
 =?us-ascii?Q?8XtAqylWSQbBKfkUEgHjfIq9avZzkdVvJgmM0Alr7ifool7ZkaHG92ZdqLmJ?=
 =?us-ascii?Q?8s+BJu7k6R80KGUNRgcr5Ud1pleo5omwojRgeigB+7uU8mU9I7DIZLxSyLSi?=
 =?us-ascii?Q?D84gS3Lw7KH83OiRsxrJKheBKbvPFqiRN7q1C0UtpHW4DLupek7fiimtG2Ce?=
 =?us-ascii?Q?SxEuNje2k9+7HQigBg/ElUZyNvtOxJ+Y3ImzOoUgcihiJqET+OW0/E0m0git?=
 =?us-ascii?Q?zyHUv2qATEgSJpEkvJTwL5Je8oFZ9zvt5Z8fpbY8pA2bRs4GpYRUycrgd0T9?=
 =?us-ascii?Q?rHNIznwsPBH7fqkZf2Z036sz44uukp4XyD1aOxmV1sRXFw6+R1PKG/OApUlc?=
 =?us-ascii?Q?b7wJNv8vOiP4e/k7c8iNt0gZAAmYFRtXcQch9pHZgBXQrQYHLcKUeGXy8z3G?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32673ab-366b-4d4b-5614-08daac0bee41
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:47.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPbT2G7paTcQ1LYbj2nZ7HiuhX4mEGcsgNpMkei9+nt4ZNZx/U7ZrXGwHdHw3/MCfoZLSdKwa4aXVX1XLtrDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). And simplify __mptcp_push_pending() by
invoking this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 95 +++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d5f89799c9a..817e539d1d12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1480,12 +1480,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1517,61 +1511,80 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+	int len, copied = 0, err = 0;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
+		len = dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret = 0;
+
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+			if (ret <= 0) {
+				err = copied ? : ret;
+				goto out;
+			}
+
+			info->sent += ret;
+			copied += ret;
+			len -= ret;
+
+			mptcp_update_post_push(msk, dfrag, ret);
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			err = copied ? : -EAGAIN;
+			goto out;
+		}
+		mptcp_set_timeout(sk);
+	}
+	err = copied;
+
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
+
+	return err;
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int len;
+	int ret = 0;
 
 again:
 	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
 		lock_sock(ssk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		release_sock(ssk);
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0) {
-					mptcp_push_release(ssk, &info);
-					if (ret == -EAGAIN)
-						goto again;
-					goto out;
-				}
-
-				do_check_data_fin = true;
-				info.sent += ret;
-				len -= ret;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				mptcp_push_release(ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
 				goto again;
-			}
-			mptcp_set_timeout(sk);
+			goto out;
 		}
-
-		mptcp_push_release(ssk, &info);
 	}
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
-- 
2.35.3

