Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D184A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiEgQae+uOQ59rI+3wFMMZ/xsbjsvO8EilpE2zfLBoowXnGWU/6RgWAtsLGh6ztX3HwS1Ing1cpDlsG43sG55fsnHVxgfR0ZAup7KiC0E7/V+rrxHWfmg1s5IFs0hMaK5PHQ91LHgd6odSE0hLnC+oxvTF8TSz+ueCapGDf3mpTa8PoJ0ahZ1YWf8MbCnNY11ZQS3v1TRAEt9qN+RbgqEzQoxHm131bbmlj+WnKdikvEHiaJerg3ryoRtOku39IB5WEys47r+7jMXqJqk3TN2Hl4ZQjtGt9mmog7H2ldfVQabEu2pjfUBK8xUFE4Pk9NkU+y+SVxju4P91RzOCZa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrWlmUEhJn0bKYM2GwAPAUd234RhNtig5HMwtn4ZLko=;
 b=CLXLEK8QnZfmQazKf3L5yZe0Q1iiP+4mhw1Rw100k0nUD4gViMZcIBNjNstwQ4XR1TesJGo4+16OIcPZ535ey9njs51gxjOe5BE4vE1/Qdmp+cHFMUyqfbb6fsKHZdhscqMQdbDPnwtJiQZCq8up0nXoMSu1vN9XW7TpNU+USOR9JZPZdC3A+eJEjL0bkSxex+UoBXIrxzpCB91cmoaAupiHnSJ+UTbzxAJM19BihyZntnh4wsN936+PdiX0M53gOEXcXbBuat0LilbA7F2gVaBx3XLexA7v1qDRn5SDqni5DkwBpTBgXyDZhRHNsXsvfHSyDX/RfdSAaMpdZ+yjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrWlmUEhJn0bKYM2GwAPAUd234RhNtig5HMwtn4ZLko=;
 b=ju6QJHqGlJa23bjZWEdP0ZMoz9Qk0LLTq6njr8ORdiXIoSvkKlpPukhFHlrJP/XXd5kjeOTme4U8p980ofR4W9sscIlrBeC3EQA3zmkD3k7cLUGA+pbjNndwioYS43paHhCcZn9BdgU/5NQM2dT38R09UJTXf9jIVMi29dWOp7h64RwIbawdja3PL955UfXDcm+35F0SJHeKO0uHJaBOMqVkcAcJHW3PBtepmbYf2Sao1jZqEB8i1fNgUJuT3OjYd0S6euRLZrFIIM1bvweI9G0BnvmDRUMZkCCMCDDuJDkyfnFYr1A5XIz+vlVA6TlrOohEzZTcLnA0RYk8cWj4yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:03:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:03:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 4/4] mptcp: refactor push_pending logic
Date: Tue, 18 Oct 2022 19:03:12 +0800
Message-Id: <20221018110312.22510-5-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018110312.22510-1-geliang.tang@suse.com>
References: <20221018110312.22510-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0187.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c631100-6c16-439b-e9f9-08dab0f87540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BWFT2H4X4QpLbm9uIs5fFgIUWxZmMo2c2SXb0fhBsk9aWff/UFTrtWP0gRQj1v819QTzfwsa/h0IfFRWlup3iQH53euQcenVGEBJR2H1OOFNenDqXeJcAMYdCHjhFyw5hiVa1aP9YsIivRPvPnHe4qCV9ukQhYNy9DBHeHCjhHVekVW5MeUGOycElRNhohZbzSJa9mVNJXw6W/qFlHx0RKFNgENa+lpEiH6fQ/3Gn2wNwkRl1xMKh5JeqZapVXM8JPfckKsQJu4YLMgMzm4sByCLPRNYSmTYambSYVldX2HnpCVH7JzUs9VuZelrkz2gTvZmJxQKNgKk6UBmDZW8W420t1V2FYkr/afhadcxHR7E1ykGiQVVHkmsuokkV6+rRMhe6+dayW5glYz6GZg/Rp4MLGF2ENIxV7nMsd2h09YHXRPA13HaJtNa7O21TR/PTE5qyUYARV9Vw8Rhs0AitKx3ltR7qpApqiPvhFLFwxfOCbFIkdI4Np/8/e9wyGtfuvxuxjSdCPmvZxNW/qGKbfsOK93l21HUJjLXnjaQebkWMuP3OnV9ilGxXqe7oeJ+AzIff2YTrY6lmDiy3WyMilWWsekiTMLDUfXGhoE68xghWfo0QAZqAlGztvQXQ4w9Zq557n7Ofbyd6Yy3XGYTZ5vAegcSlTlhEYKEwp1tGTkDcOTT0FbtFQw/HTNPcwn4sBLH4DvJb+sDNICed8mCEptLWbDfN50BXA1IoVKEx1VNSrJ5ykBCBMBfGrRac/wm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36756003)(86362001)(107886003)(6666004)(83380400001)(38100700002)(66946007)(66556008)(8676002)(5660300002)(316002)(8936002)(6916009)(44832011)(4326008)(6486002)(2906002)(186003)(1076003)(66476007)(2616005)(6506007)(478600001)(26005)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6x9lIUwzwuS0uqdDUdJqqS3LydDdnFXNYXNlxOqXwn4P4eem4IcGCHJGv9MF?=
 =?us-ascii?Q?oOk1GajODt5SLZfRnu4knZkS3Qc234D840hgd+VM7nTlRtFA1bvHmBAjHavt?=
 =?us-ascii?Q?3bfp/8GZ4cCHWwDQxEx5hrwbxTPE4RMfsmAEpIMOlo7u5H98zjVYZTmQoPLY?=
 =?us-ascii?Q?ppHpcwo2Z0xCVrzBgp9K+e+TY/VXdXTkAKRtKS2oeNJ3/gQsnkYQ4pUpUfRM?=
 =?us-ascii?Q?htW/y3WNBjAyAKiX/GjhxTRKZ42YA1skpvjux4THA8oVpXr/hNx6QQ4cUtC1?=
 =?us-ascii?Q?fnipaEnoX9EeJpsIbgPW+3n0kSGcvKZ6tIjU1uOZtFl0WpaR1CFrOdicjFxf?=
 =?us-ascii?Q?giRRRi6HwI/zUBQ3YiOD6i3B3axRUyWKCXwNsZIQQeJA1l+ldPJ7Ytg1pYTg?=
 =?us-ascii?Q?VB1H3dvVapdfWshcM+m93NmUNuhm8phQLVFSEYh9a5t/tyOTrUHTOHiBDjTk?=
 =?us-ascii?Q?vLZLaVaPEIL4WCWAcYoEvt9tjfyz5fydO35Xipl1ZL9FzhGdV32XJg79+Bf6?=
 =?us-ascii?Q?RGVDwwBrrJ0MKec4Uck2Np/PwOnlrPDD8ZM0cYsp/U8H1LUDXVLmBzi8d1g2?=
 =?us-ascii?Q?WAjxO7+GxlVI184dfNo/3G5qGNRlK1F/+puHkpdtPvEG8bNHX0kp/aSOvXLJ?=
 =?us-ascii?Q?W9yUp3WDD3CMkY8J6i7V3Rezr97nPjygnAku7qBLIReciaEE/7zO4UxAzHke?=
 =?us-ascii?Q?T91L5weD1oVCUe7t+p8bKzfHl000zBh8FY+yDQ442U5oNF07veKSkUWhkL5I?=
 =?us-ascii?Q?dnXG2D3nZzGHT+fFBjCIihHTklc5JON2K2a1wUpJwU6e6cxT+CwXipsCQSj4?=
 =?us-ascii?Q?Mt4Nbb73rmfk8JPxYfCZLl+rxQYG0Xht2S4tcBOjIvsQfRRqrLlK4iZELtxK?=
 =?us-ascii?Q?F5G6HoNe1kz1G2FdFs/GU0WswZq7Vx46brtVUW/tiFuGux+SY5/5pgYuWv+E?=
 =?us-ascii?Q?IMGeqqS7tkUD8GhQ1uKpkyLemFZnYUX1/FDXxh3eBnhe6ZERK005rI4Qx9PY?=
 =?us-ascii?Q?aow25QqKQKk3eO3dejgzzotvPCKrOmNNZSFyXok/YRoImywZ8+lPh9dnboDP?=
 =?us-ascii?Q?sDpEQpmT4J+dwFB3Pm17IGTaVOso/tsY4hz/fHJmrZeVLwrrFghOSi/0hAiV?=
 =?us-ascii?Q?/Q+KfWuoWTGc0ow/j1aQmMRr0UfAWqXU/9p0BqNcj+VmJyeHTtBaW8D4dPxY?=
 =?us-ascii?Q?XZf0iz2JcNhhl3BfnDm3SpG2lJkDuGSUtYYqGnd3TXnKCzZf0YalPa/8UWnj?=
 =?us-ascii?Q?exRdVUM6Pd36McWMw/LSryolG+SiDIyuGO17heMOeeunXv/64w4oTUXrP6cl?=
 =?us-ascii?Q?E++DQgWLaYEKxhVyu6BLKFIadqPTzqdewMC1HYJBIo5Dh+c628i7oUkq4Tmz?=
 =?us-ascii?Q?YiAs/K7C2VZUB6VRBX4i3CH+MDMLL/ygk/0ZouLqPgyC2EkKHKlSD6585S0V?=
 =?us-ascii?Q?TUkApmrLed0sGUW3lFxOVr+G7D4z3yfcGSVkPab8RnX2o91x5ikvFpkZCE+4?=
 =?us-ascii?Q?ElMG/4YTl1volTwZvWlQaZWE1KqFN2C4w48ObETDIDI1ltZYn9C3BX8eMO8p?=
 =?us-ascii?Q?WHgANyxsTuPeiQAgrubKHjOBriFvQZEmgfil+idDYq3o3e8R58cVbl67eJxd?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c631100-6c16-439b-e9f9-08dab0f87540
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:03:59.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrFJakwUwTYc1h/EoJOeGydIQlt6Jx6ovybc1GIJ7Ser/gRXO8lOobVi5m32bWWeJET/2KuwnIrlsWlGzpFz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

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

While the scheduler selects one subflow:
	Lock the subflow
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push and release the subflow

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
mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
__mptcp_subflow_push_pending() in the inner "for each pending dfrag"
loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 155 +++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 85 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddeb8b36a677..9b73297f6543 100644
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
@@ -1491,12 +1483,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
@@ -1528,68 +1514,80 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	return err;
+}
+
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sendmsg_info info = {
+				.flags = flags,
+	};
+	struct sock *ssk;
+	int ret = 0;
+
+again:
+	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
+		lock_sock(ssk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		release_sock(ssk);
+
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				goto again;
+			goto out;
+		}
+	}
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
@@ -1599,51 +1597,38 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
+again:
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
+				goto again;
+			break;
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
 out:
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
+	if (ret > 0) {
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

