Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF26ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5BEzwRDUdarCLLNt1jKG9Y0twzTWMaFmSzEfqkry+zHgy0gQNwd1YkKv9Sr5UzkMQ4Ymr0l6oK8EYiSdgxVLt8lfx2f8g8oae48ahSNOiJEMp04Br7/kK7rsglyu1EFbCMtIDLOkspYFppZZKgJBKHqu8FA4Fh3PN21ht8iHeVYgVCQHdLnU68f3MKTyw5mLdM9mXksRzJUT0fzRuR8e/vUnt9S1E7BiI/VN7RVtE5NDkYTGrCbAcPVzo+L7jsbOqi11UwX4Dv53KSmn+wVbgapsey/PHVjVmnqusmBBAY8IwfPNLm0ahSEp1IVNSxq6aV2/8AMbtpIUkpgiDPSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CxmNvKQrlHMfC3kjBCcJLMT277PKcoAB+XdGj/fYpU=;
 b=QAm6On9mpW6qC0bO2r4lSqMrxUdUnBnP8Pk8O6saz8zYTDeJ1n9ZXiItbs8cmeuryg76ut5MfXAQnqj9TB5Q/6OAcEscj2h63eD2Nh3YG8PIySLkqhQPIS9f0XtVsrBLlrUHaqFgm8MlX0djH8x3r8scVZkAgBzc0XC5ElIm0SfjmnKKZuWm/T2Kbhl6O9ymo1+ZYqIC750CCITQHBZt1WL9ivKy4X8oujfg7DLkci4Qr9DLS2MeB4ceD1kaVpSlmWF4mJw/+ydeJ36GbM3hW1p5SgNX1NclvkKp3MAlo4B2g+uoWqO/5pYUz0R2lUk1vxS4lkXe6mo5S9W8U7KIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CxmNvKQrlHMfC3kjBCcJLMT277PKcoAB+XdGj/fYpU=;
 b=M3LXYQpjabTzrMpdvzIrNbOJ/qQz090OBJPB4jrqBQN3l0H0mjs4kPnE+CJrz3jczF87XBz+8rKWXM1uhnuNikaWvzScNrDoIeXJvCnIjFocm/jERljSl5MnRtDCJFs7vKzcTiWprXr8PikTh63tt4fbgFXU1BwAdZRz5HoAZAis6JS34Zxe1YjpxkaOtuuyAxJScQc3rOBieFiDjdOfqrUp8T2zdSmsnHQCALDDClZKEytz//0e6HuNhJYDXXQVduL7erkPMq86At5uynZvlw5EjRVOr/TURpxv0tq/g1fxUlLnXcYyr4wyfSpiNPFxLLo/M6sA+hCIgc82Fyw61g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:08:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:08:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 01/15] mptcp: refactor push_pending logic
Date: Tue,  8 Nov 2022 17:08:23 +0800
Message-Id: <828f9d2e9fa1738463a443140eb8f071e41a6fb9.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f25a78-218e-4b2f-e151-08dac168d2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c4SMh+kTZdHolahq5+JSdyFJz4ZZDXyJ8nGPKistbvne+FUEHoNJqgH0hvgCVraSGvonzgDStAmjR9NJcX05dikU8bSYzcz+RlKRDaypw+g1KxwUJ8R1zlTjFAFS3gOSbzF+K+7DiLNaGRAmQiXtgD8jHcJX9wH2ChkIG4piJys49o6xHtakx5DCOikacWeedkkRE6Lj1oyR9wzAbeHB7wzDdHOZKuRdntaUH77QGuUaVUbni5AXDeLwMFnmL/Ip7neaoyjC9eCpiMORa9eMKxU1ei8tkj6Zd83WHJYXZfUdWeepPzq8xo5V8yu0CE4rP/8nyH4kxZjmVSnLCX3Dk6CccvD/YfX5sbPN2h2zarx8+mkQBpI2OkiMRv8FaIB0DUvtQfUzyxP9VmpmTfbIYAQBfIKhW78FHYRv1by/w7eQAa5UgGGgpM82/JkYaVH//Re4lL4VQMkjXFmZKWgMzhDA7LawYwbjptC4V4+v3sma5nePsdiYZ5o8oofZ2ZDh/T1UFgS+l+QRevFU5exYsQCCwO21vlSZ/7DwsUSClCetHz2tf4C1olcw41GOXtCnyvbd6Ghu/3/YEH4uLRrb+UFSRXrcHTgP1XhWUraqOkbrnB6EZjyudcM5wREHb1vti7Hos+9UhimdevXLS+xS/TwYko96s6JTOxLNpvjNBNrxJYRXJY/3xHh8iZBEmPJUIhcOqNwSb0wJsYKug90MIHRdMhAKuyhIFYDmIhiQ510ke1U7sM/d1NOknNt9Uz64
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(6916009)(2616005)(8936002)(186003)(86362001)(38100700002)(6486002)(5660300002)(41300700001)(6666004)(26005)(107886003)(6512007)(6506007)(2906002)(83380400001)(478600001)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCNRu3V4gtbsOk3BEXWsdqsDNCvN97SgXQvwpyrDF8QqqvZyu0KcBNOPiqK3?=
 =?us-ascii?Q?8fI+oElRunFjZq64sbSNgutmnqCKFoFjSpsG59Nk/16UiYCFf7iVtajCw1x9?=
 =?us-ascii?Q?owsc+Wn91G6mrWTY1u2ZlrxaeA3uZAYo5eikJXT4+8RzxsOIz7db/XH34EsD?=
 =?us-ascii?Q?wMWViqJjA/RKGZ0sLEWTKO7dnvnCZOJIgbSAdfvasry2hf2jh/urTqQ4AhEA?=
 =?us-ascii?Q?cl+O3ytXDmvmEcEhHszhLgUSvMhg7CEBBuQj04QuwLu8rxn7En6f6DhlAVp2?=
 =?us-ascii?Q?Fb5AOqC6D3EmvcfxGRfq8mPEwQUPQYKPNkTnaiUb1libdfDOtU4vZNcFx8v8?=
 =?us-ascii?Q?5z7sZ4FwWMeZKz+IAs8smXQDkCUv1T5GVcX4ZQoL+NNoXUOIuQ7lO5eNTbCa?=
 =?us-ascii?Q?qBjVJiCIweq59tQix06Ql9xp9+CuDh38LmG/EgG76aG9mV2brCK9n78g2p9d?=
 =?us-ascii?Q?vwC4o/qMeE4kkWxMjFIN5XGJIS7I2uqhzIRyAqipzbkSTaAmhjAcOk0+kuc/?=
 =?us-ascii?Q?f1j7MW3DbqmAvlklo7cUQzHgZ7bobyBbn83WNuoZ54Rlu0Tx0rtDyV92ggHV?=
 =?us-ascii?Q?oAsF0x2dCKK8oh2g6mmnXBstHS92NEZHHZwo9B6B3ZB/fPgBeLUY/yvcQDI3?=
 =?us-ascii?Q?dAftQwiUzpzvLLY/uJvoK0cX3ca/+lsGVsJJMOO2yrkxqiDmNIHFU2bmZeRt?=
 =?us-ascii?Q?Dp3Ouoyj5VKtOrCVpZz+EuRPUS1BD2q2PNvGHaewAbfGYO6cdbz76LQ090Xk?=
 =?us-ascii?Q?x4Wkg60jyH3wmH6JZB0kNauKM8Hf5BHyxWfiKzV2YVvE8yi8DWSsuqC0tZh0?=
 =?us-ascii?Q?PMbBHbw8vBiReLfA+vCPREyXxdaUjvwWcACxik4zOrYYm+zw/V6X1n2gQ5W0?=
 =?us-ascii?Q?AKiLo1sd64qdgma3sEuUnZQKInw9dmJs08IuPZWEiYMoUHVVXw/zLin18INJ?=
 =?us-ascii?Q?o1g8Pv4O1wtOwup0JGekCPIWjaHmY0qmuoC+Ndht6X5cPjaAaieJvS0tkL17?=
 =?us-ascii?Q?qJYwCd2xpcqqoph9JUzOw5T5ctp2WUgir/gOnnnMflAbN1U+muZ5Oy+RY6xY?=
 =?us-ascii?Q?QmJZJGvrNzFMx8AAICXA4lGOekkUuU96NHp/RZs1lxavCSGpiIi/pG38tUvn?=
 =?us-ascii?Q?pDwRnhc0zchouWPp3Ftav/YTs/JX2HnCqq/pCneEQJMspHDh75kVLEFCS6TH?=
 =?us-ascii?Q?+tSUfWvvNEx8B7/JvLbMR4ekiEK9ONYz2i+KyaK2EDGT+fuqYx3fyJ44NKqZ?=
 =?us-ascii?Q?WPLeXiSHuVq6PfL5xZ8ISDgMSiokUewnw0FxtlDj5kp9MHQpvdWbI2LUMGaW?=
 =?us-ascii?Q?+dfyclERkgyYtNo1f4nQfdPi6SwqpnSHoeRaZze67miG45xhRPEtOdLXtvBl?=
 =?us-ascii?Q?AIpV9G3/6V/VnLopl7PjWfvpqBLcAwMiWuyggoij53lDjpV+gkb8v11NGF7d?=
 =?us-ascii?Q?f3c348V1S1AC7tPLmAVX5YxqytucUo27VzM6Kivh915jux/dGBl4ExwSWuj6?=
 =?us-ascii?Q?sqgqWfjBUjbms5wOpepFi7l2msHFwKskJQFTwkLJaS+4iWin/d1b7+TmhhWI?=
 =?us-ascii?Q?e1WpVbDHKm0t1S7eoRqIighZOmWRsN6Q6y7AEGee?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f25a78-218e-4b2f-e151-08dac168d2f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:08:38.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8z3mkzWHSfG2R/bP8MZ0LiPbZCkSfobzlmWSFjsV1locc5+k102qM8Hwr9vYNY54Dk80mV6HdRnngra6iAvBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914

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
 net/mptcp/protocol.c | 155 +++++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 73 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ede644556b20..1fb3b46fa427 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1426,14 +1426,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 
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
@@ -1537,57 +1529,86 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
+				.flags = flags,
+	};
+	bool do_check_data_fin = false;
+
+	while (mptcp_send_head(sk)) {
+		int ret = 0;
+
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
+		do_check_data_fin = true;
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1608,49 +1629,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
+	if (ret) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
-- 
2.35.3

