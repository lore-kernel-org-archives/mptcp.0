Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20085.outbound.protection.outlook.com [40.107.2.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188372F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNAUMkCTdgGRCdm0Fy6GYBFIjQHi26cM6304LG71qnpqzyAXQhf9IT3ZakdCrz9HMZLK3+rLprj+zkbPqi2BCZKWs+jYjyUra76s9UbHUUT4iKLBwONfARI33EFTm3IMwFoTmy/EsBv2x+godWgDZJhi3N6OJ53IIEj1gGOlABCZ7P3OvxUj5qx3Lqh7hggqD18+Bd5fQd0sCT3IykuJlbB5gPpSa5udPsJqdJtKn/8DVk6ZrDcdCemeH6aJnGNg7P+GFYgDq2McufqNM/t4LcG++Veu2UdVx7MdMVcRQgogVvNmOlK+wFt1d96b94Km7Ckq7/8MEX0g+fauLDdJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDbMyeCK2ZQOKyR0tqRybhn+fDfbs6kIryQdQC9CumE=;
 b=dL1AdYNwgoyCjIeRYYpaz6GWvkAdIPAzgWKN9NsSWRRPDmzklN2jCTZlVG+iapxSVy7tpL9d+OH2oLHQITNCkq6yjCxzzRDaMZTcq14jQIFOMftVbn9LhbSAQMwRJSZ5ZHYATIItaaXYMCbVvPkP/gpcbTRNLyPVkUUGvKZ4l1gU3b2B0F6Ovc7yuVV/5ZPQ5IRWsQ95f0dcnuWAhAIBvJ3NEvm7LJrj3sc/o7uTfokAmRqmEvryeO53kzqOme/3OqtgggRIq4SgBwjpVU131E4IgF9qIGnqIucMwfA5Xjveyqo9RuOHAVUBgS5UTI7RQ7pRyV9RwE9ZmQ+SNbJ7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDbMyeCK2ZQOKyR0tqRybhn+fDfbs6kIryQdQC9CumE=;
 b=4J2ntWHBg6gX4dPdYZqejCIDnaSyILXBTnm+1DFSDo0NWeilCmT05igiW1BK7d+CB8OLR5QPTGr40ynjg+DPygmq1WfNNegfAYYsCPzdlGyZGe8iIXc4fOFou2Ahspja10zIy/2JI5MNV5TUJUh7Jxx8iQa/nHte9RjqiG/Ov/DX7GGbZcxD1mq0hZebpf8CcmeUrS4qAqVpoUUizBPxlXeSKU0lhefzhAEq8CljxUQM0GuqF68fvqjBBHiAN9KdA/dmR48mExHU/LLmOnkPWC7gHYSXxRdy4KhNyqZXQ647o7mNch7xnksDrYZ8yWEM/Ic3Sgmbp+9SxbvnWMj6sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:36:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:36:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 1/7] mptcp: refactor push_pending logic
Date: Wed, 19 Oct 2022 21:35:59 +0800
Message-Id: <1f31ba545d3585823aec4ea43686dd8d89237ebc.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a3a077-78a0-4e92-c09f-08dab1d6e890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j9hBnSfGtAhzLKe9pmvJz7HECzor8MBIVBmLfNpHkEA0SG7lwfPvrGFFHLjb+ULlqSzowK3Rmwih3JojTcfJz51trzVulJ5g8c03d+QDnKUoGtf306JkJ8SOqMF6iM+Q8Zvg/w602en0VBPZkEJ3MUft983BvPrJ6Y3amw9uzX1PLvl/eyaV7WYMbfpZm0WT+OzJRQlFoyT/H1zAwPt0H+RuQiDZZMk81q3wO0QYekmxphzIsAAzhewnxCkI1ydu4Iyhu7HEmmAF8ZZzJHB0HndxJZ7E1A9cM8PeWn/uMTtT+S9BvsRidhJEQKWjpv9SbdXanJpxfBuKziccQkAcjpsj+imG1+oCOyL41me1yTdWKBGJTJWxFYg6y5SNeZodm0NGaAajo0410f8XyCo6VsRnom/Xk/8jI1y/oTl51jDK6TZT7HfZYhNOUEsk8rwOPL8mAcCvzjiWTGwO8r2iORjx9LBrnzffXxHW5Mtu2c2s5IHh2V1e5fibKGOsaMR7ET0owzEpF8aBaNy+hchw2t1qtktCoaPiE/0ARooQpVLYnq8zHXcDdvUce9wKgPkX3iK8K3JPxwW34JEIVL7X5F4LY6phiISl3YcfcW6HvfcIEbZpPcrk90x74hrZihpr4+rVd7SDMFEB5EhdPM5aStIxOQueqsVAMrVp6V4JupK6Ll0+taVf44wjuur/HvCC/XsXuQA5A+b3erdCmNhtKbbSVKq87dRUW1NtoXD7VE0vMP29hojtug2HaxXZj0kr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(86362001)(36756003)(38100700002)(2906002)(83380400001)(5660300002)(44832011)(6506007)(26005)(107886003)(6666004)(6512007)(2616005)(186003)(6486002)(316002)(478600001)(6916009)(66476007)(66946007)(66556008)(8676002)(4326008)(41300700001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pabIASRNx6Vxs2Kco84A3jPCe+sucAIQ1qAaKljZf7V90noqZKHq9sbLf1uP?=
 =?us-ascii?Q?Z/yR3DpoL/vB40tVpQNeXhLzmfUbEGjsbx5Gc9BWWy2JP53kgnMlmB5+x9DY?=
 =?us-ascii?Q?huLlXs2T40KnJKycu3CiUM7vpnHLiJ0eXyVMc0DtfMgSSkW/Tuv5bmcq13Qh?=
 =?us-ascii?Q?2crCoLc6kw1CYoXbtw6f3CUEgRPUWyCYWZvhKmVaCj2at290KnvWPaM6wLR+?=
 =?us-ascii?Q?tVLnEx41tvYCVH22qXfdXgI/swOYmQdN7/GeHSLmyQzti1pxRGgs0ym5xMPs?=
 =?us-ascii?Q?zyNae6XejGvddL3rtHgMmYCtfvaL/up2LOCaUQfVRCR3iaflqMVDSlbgNiq+?=
 =?us-ascii?Q?/9BJek/d5Dp1kv58T5Y4PJgPU7EkrFJfY0fuWyID0nTxpkcZSRVWqC7J4jv7?=
 =?us-ascii?Q?CnFQHLJPT62oqlRO6x9hePf+kogTu9IxroM2Isl+sluhi1WrHkEzwm6wo/sa?=
 =?us-ascii?Q?vlW0BKdQldwBrcHTaOslaR3FsBtYTIlLI9oM5uSHr+9viY5BWIfOLXHOFyR2?=
 =?us-ascii?Q?x6TG4iyRlQNN1Lo+GBuoW2Dlm3GKxB6x2hE7Ec/zkADNyCS6V4Bt/V3AVZYv?=
 =?us-ascii?Q?ElxwPX6M+Z2kbEP+DdUa/PeQeKZLVpefIiObiM04IruPhayDdpMpeJ4/2YPG?=
 =?us-ascii?Q?y1VpveqOJZBli4F7pCVoB0f7G/qJ/xsezyIb0yIVSjv9DqkHUqk7qKZ+ZZor?=
 =?us-ascii?Q?3L6rKvDzPHQ2v+Ayp77piDxgn0GnumzpXGbOOd3m5DGzu83FnBHpUykZMBZv?=
 =?us-ascii?Q?3pRK8Kamc+FXG0DxUDDO3gVblbQmxSGXy2LqCZJ2S8yB/c7AG7ZOR8wnwv6S?=
 =?us-ascii?Q?151fnJTqAaeBUbr+6UBwBh2o42Lshc+z/RfktOHx1U6LoKrB3mQBEKOXTKcM?=
 =?us-ascii?Q?Gf1XI4wyhRrUz5BOsAqRgkGPwlEBzaciM1VoqhVBj7DHDdeFA4obV/OmQP4N?=
 =?us-ascii?Q?i32ikxbfB6et8S2yg4KsLDVyuVjiPK6XOLaH4xYl1oocobKouYMpnEiFz4kO?=
 =?us-ascii?Q?79Sax33GMtfxHYKo+TRHXSfQicp/QKgCveu9FbrfFCZAu1VaO9JuIL/7S2EB?=
 =?us-ascii?Q?gAqtBF1ubcD/+TH/XVYc2QqHAcgQZgKvNaV1RxNuwPVqtniUOyvPcpXk4Dxs?=
 =?us-ascii?Q?zBi5qhzHyBJf5JAlEJ/kjM6/YQ4kBrZVLDgiNxXwLqDOih5tKhK4vogqupXI?=
 =?us-ascii?Q?6MhpsUrZH9+Y/dDz+VGO30EEYM/L9xL6VUBJxuEPmGoHjJUhH/tslHS5278m?=
 =?us-ascii?Q?yQLW/tlg9RkZld2nQxAYCYLq+0tLtBiNmdNenvaQ1e3oF7m7QUNLqpekN5Ar?=
 =?us-ascii?Q?1oimcKrn+MrFGLsXLcPkjyZAHZDVaDidZMBg6jxNYB3VzdChjr1oNQuKb+8/?=
 =?us-ascii?Q?eQGwKkFimeuiqVBHgCxc0Fr6v1wtZRPlpFxjhU2k2oGWqPGeczERoSFD7KBu?=
 =?us-ascii?Q?WNQh+OaZtENRofNhNouUXqRJfUlhZa4RSivk8BzI6SaKemzQ+ERZ0PsY6nrV?=
 =?us-ascii?Q?3jPXuvfqr/aH4MhLLDxKz+fQKzO/omjPKg2ZjGBp1/JbQtHE60cRwgZcQcY/?=
 =?us-ascii?Q?AvVdwlw7J0EbIcaa8Xm3D4frPoR3PFoahC37am5WL/IVYdETH7PdZzpXYWx5?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a3a077-78a0-4e92-c09f-08dab1d6e890
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:36:21.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19eu2dH+N9ush3zBF/1I1p6tA7Cav70ezj/Mk7sbiyx4xBxJ7whp++b4f/9PQjEJwQpZQj9xCkZfIYfoefdkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251

To support redundant package schedulers more easily, this patch refactors
__mptcp_push_pending() logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Update subflow locks (push/release/acquire as needed)
		Send the dfrag data with mptcp_sendmsg_frag()
		Update already_sent, snd_nxt, snd_burst
	Update msk->first_pending
Push/release on final subflow

->

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Update subflow locks (push/release/acquire as needed)
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push/release on final subflow

Refactors __mptcp_subflow_push_pending logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Send the dfrag data with mptcp_subflow_delegate(), break
		Send the dfrag data with mptcp_sendmsg_frag()
		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
	Update msk->first_pending

->

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Send the dfrag data with mptcp_subflow_delegate(), break
	Send the dfrag data with mptcp_sendmsg_frag()
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc

Move the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). Simplify __mptcp_push_pending() and
__mptcp_subflow_push_pending() by invoking this helper.

Also move the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __subflow_push_pending() in
the inner "for each pending dfrag" loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 154 ++++++++++++++++++++++---------------------
 1 file changed, 80 insertions(+), 74 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddeb8b36a677..67450378cb97 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1528,57 +1520,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
-void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
-	int len;
+	int len, copied = 0, err = 0;
 
 	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
 			int ret = 0;
 
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
-
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
+				err = copied ? : ret;
 				goto out;
 			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
+			info->sent += ret;
+			copied += ret;
 			len -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
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
+	return err;
+}
+
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+{
+	struct sock *prev_ssk = NULL, *ssk = NULL;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sendmsg_info info = {
+		.flags = flags,
+	};
+	int ret = 0;
+
+	while (mptcp_send_head(sk)) {
+		prev_ssk = ssk;
+		ssk = mptcp_subflow_get_send(msk);
+
+		/* First check. If the ssk has changed since
+		 * the last round, release prev_ssk
+		 */
+		if (ssk != prev_ssk && prev_ssk)
+			mptcp_push_release(prev_ssk, &info);
+		if (!ssk)
+			goto out;
+
+		/* Need to lock the new subflow only if different
+		 * from the previous one, otherwise we are still
+		 * helding the relevant lock
+		 */
+		if (ssk != prev_ssk)
+			lock_sock(ssk);
+
+		ret = __subflow_push_pending(sk, ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				continue;
+			mptcp_push_release(ssk, &info);
+			goto out;
+		}
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1589,7 +1607,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
@@ -1599,49 +1617,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int ret = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			/* check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			first = false;
+	while (mptcp_send_head(sk)) {
+		/* check for a different subflow usage only after
+		 * spooling the first chunk of data
+		 */
+		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
+		if (!xmit_ssk)
+			goto out;
+		if (xmit_ssk != ssk) {
+			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+					       MPTCP_DELEGATE_SEND);
+			goto out;
+		}
 
-			mptcp_update_post_push(msk, dfrag, ret);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		first = false;
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				continue;
+			break;
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
 out:
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
+	if (ret > 0) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
-- 
2.35.3

