Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD29364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfLp+SlP6s/iNIQ4ca/L7JXbA2xihKXcAl8IAnH6C5v28ryaEbOht+Dj9HB2Nl0TadDVfVY7TLQ2nvWO0I/1xdQHDVkwyGUnbOTxqhf0TGkkbkJI6WgbweusCgEFxIbYNSSwhZ0bxLRd8auMIH+CVHol4DxNByBnJZgYh9NEQXMjXxoXXL9ga5fWmvufX+yB5D1+6uMsU/PFc0niXDdvLL/geCj7w/HVArkwYE+rpEC9nTv7zLpzkZHjwVqsMGG7KoRk+CRwu+x0TzzqrO1KEjVnhILEozIfmvxx5mkpv9/WMO+SxV8hcNyFrB+oYgmKcbkB7cmpME9rTwypkIMZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+64lbcMOrD1FBQVG65n73Z2Zr4RWok9+eftUGqB2/dA=;
 b=OlCSNSxCzH2y/mwlvVf7xQJNMj0KFy8Uk+Wo/Gx9czA5mNy0CrTayzM0wAuOzYXZfM/AOK9p7DHmDtSUL7jXri+A2ouV+PD5HqJhNEy38JDQ3pGeVYMoIC+434YZ7+80icFHMtSK1t9SqsRALm8HHRKqeEUroohgJ/beNEyIXu7wzbiXYbnlyXAAuqD2KvflRdFfZVNvBEfmm4Zu7ELHheqXUYP6otrkaRZoXP0yVljo+AsAquEnfy+AlunDB4ESbSUu6/5IJjau10m4NFlhtPJndVNWq/4dO2AMY8rF8qDhU0cOk+ZKbaay+7y1IfW9e/KE5DzLHr/S/MFVv5WSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+64lbcMOrD1FBQVG65n73Z2Zr4RWok9+eftUGqB2/dA=;
 b=No+UmIkshwu0T12K+qfzP6UuNpHz+za6iH2RGx9YguHu/Q85YPxpBU04F9mTQM/74EhyKhlDB1smnr1BkiflxgA2pQbnQWtN/qOwjkxDGvPURqK0iWhHliubaM5stBwkDCHgLKW0TETUe11kg/LxjlK+EkpniBs7on35bFew1lz/H4NS+zth4KjsL6aSL5lteqDdcGieeYWPXG3jmw0CKKKA40ng3WFO9cczVPdNzP6FvH3lj86Dc1BN8w4r06h/ohwq1pZjNc8j5Xrmat5SHX4veAepoEgXfNjdDJRK+HguAqm0CJ5DNcozrnZ7vVCPcIbiYNG7E/XRK8qHKajWyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:23:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:23:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 2/7] mptcp: use get_send wrapper
Date: Mon, 28 Nov 2022 11:23:58 +0800
Message-Id: <b09e23224b7b9a98e22d8db9660ab4761ef61f18.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f994c9-c947-4651-ad3c-08dad0eff567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2HE9EroG8yo7svqUA9VQA3esK/9jI7PiqF1adq4ihkBnHbVvfdntctC6x7TX9xhZSr50uxCOs9wSyhVbUjTPRGuweMvPVfKTqRG/bPsCdIjyQedFl7lV5bV1eKZev23vrz5t2a3KP01dE/n2IbdE/sZhugRX99rPD2gOL5XTM3DQfdb6BOEv4Ngg2cmgxGkrN4OcduSxsjiYKSlC5Zbty+nAh1If4DLjI+tuj0dhqQPTTjHfeKBIAELkTrCIII+wLjG5ndT+EfZhg3ygrjypsyLuXita+WWasQuqSlVO2DsEXk/iGBg3RzW0MDerzzJezYKeZLnnvvSnN9Bjq12KrFADVpedoP6ml3wcmxaUssVfWch7k/8tKTB0978Py6//BYjbmn9h5WTNbpciZIRoYOg40AR86BFYMk2+FOaiZabx/QXNoh2RuwjSocdysAWAoRmHNFY3diUMwas3LAtZSR4KK6eUwFRQl+3aZU2EwEPGC8n+casfFHNh7FgTtUEGShGJnIUOBW+fn4VhAN/Zj6p69rWPzIAjqmERHwwjqV4dlxM3w0hH8baFY+j+woBp7QvCbSbAP4m2NFVewUMDO84Q2uvrPrVuga6J+V5hbGEqoCSCw0sP7GbeHlbms3kO3KfLMCYni8wVVyhJlA10fA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?67yQXaTvYnd9zj2SCMdPUnd6cnfAiYBe7vTiOGw+yJLJ6rVcNkxW0D0sY1YL?=
 =?us-ascii?Q?FujIn2EcoMQ0sqJSdFKZq9VC7UvcNI8mTB6nOysQxlGpeW9VdWsp+G0ltu7b?=
 =?us-ascii?Q?mKnM4Tbqn+w3+sT+iGQi2YixmmrffU/pDvXqIbAvSGCZPwKFhIcI9/+m45bt?=
 =?us-ascii?Q?3poIFBe4H6PR1o7xtOty7n7dmmoYwa1pJTmbPl81MZZ2nCb65T34E1hi0PjZ?=
 =?us-ascii?Q?G8MrRvJSDQtgEbpmU+SamQecBlkml3nncSbeC2l59S0X6g3rEHloaZODgnmz?=
 =?us-ascii?Q?PnKsVvn72kKP6L7GF8fMG0n6fn8CJdnx/NlTPihoLUABk5JrTzLrQI6pBhVh?=
 =?us-ascii?Q?oXtv0RGnLmTLVW63iCzzfwUdikXJ4FIGaXQgm7PR1DOKoGRUVysfFo/9t5yX?=
 =?us-ascii?Q?bVym0gjpGRFb74y1kNVdFlTwiY88mcHFRgpEMMk1S6023hxfcnUsNVNvArOX?=
 =?us-ascii?Q?q4bl9x3D6+jEr+hl4WcV3huCEN0gJePEs6+ETq5xCzYA0UAPGPySFclIbUJO?=
 =?us-ascii?Q?RvA+5ai0cn5e1OzbPLA7DVphmU5goKqGaLpqjcSjnswEHkrlhblvpVqWyBBT?=
 =?us-ascii?Q?Op1r0qbXYnO5cu4f3t3LXvM/UwCH1zciDDI27r7JhUYDCAr52srijlwaHjQy?=
 =?us-ascii?Q?umbpDbQFZu+CUv+ck2FMJz9Lo7/kR/huXs2lr1kqsMMzTEINNFRwbnCmtKHr?=
 =?us-ascii?Q?BrMSMGzW7CjmNgS7gzTtrGqTeZr1DQjfpghaa6ymWTqSqinx0fPvMlRxG+Cn?=
 =?us-ascii?Q?CK15Mlf9Kklge/+PvUsLUSH1D49Rk2lfXTGlGDYt3702Qw3aqt0JHPaXJwZH?=
 =?us-ascii?Q?bvL/xItN4maIhRv+75o2GgK5Tjz39v+q4ys0+6qVw5MHI/ANixmcQOR3dfrG?=
 =?us-ascii?Q?KbA/YrhqoJz7UbJDbniQmvuy+pXnXG5EZ5ZlgpwG414hPfJhYwNW3XHrxruG?=
 =?us-ascii?Q?Mm6I0eGOFu4JwUQrwu3tHcDxH+1DiVEv6TN38Ss4XOs72fxQKzvtybEc56X5?=
 =?us-ascii?Q?miDbg3vZLvXyA6TXjw5wkKADHFzm01CIUR9FPMtkDaQkc6lixmkP2AjwMX2W?=
 =?us-ascii?Q?pqQ88exzO9N+g9Q8Ejw80wxoC66rTiVHsxn2WhJDYUS/0D4XANnmwNvpbkYT?=
 =?us-ascii?Q?1lhseI0Fg0iA+Y3sAC0nyuMRl7TKvmXb2vPcOSYjYUYVFO5oXRR2Kx1MaTT2?=
 =?us-ascii?Q?jehn+NU6DY5rIWoo4GP36ZpCGbdGHap/LY6sV4wziJT5SpLM0HGuFZ5a35fz?=
 =?us-ascii?Q?1Y8xQ+jq9C3Heod2YjqZC5aaZQdnX/8mlUcG/r5ri6boZtMpb24cUxDx/Gho?=
 =?us-ascii?Q?OtWd3MyCYtgSyCTPBKMXhh4v1QqWYSKJ0o7gRBMTQwGS1Lbdf6ANDDTMip7E?=
 =?us-ascii?Q?4ao2C3forroStQpq6DyBW0zi1qFpw/br6OWC+hT8YBeZhf4XDrLbJ+UKbTJZ?=
 =?us-ascii?Q?zM4bqMJkv2UcRjahqszV8JzopDVsbndb65xKPegehOma0183dWyXSATzj87Y?=
 =?us-ascii?Q?QfQmDRTZjFjHoDNHYHtS9PtfpJq5x5veuWW4qy60m5Prqxr782dv9bcQAM/x?=
 =?us-ascii?Q?l3Wfkyt65/KBCYwf+WLpTPsT2DGHEl85m4ECeCtci1di8eNagbeYwrerQSOt?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f994c9-c947-4651-ad3c-08dad0eff567
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:23:46.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxouFrlOboFIfeFCU/4V//nZyljxJUN6pg8jb6rSwHpC4NN4pSDirzYsJFblbZt8rvuOdfZ9mN6f65ZyiDKweg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

This patch adds the multiple subflows support for __mptcp_push_pending
and __mptcp_subflow_push_pending. Use get_send() wrapper instead of
mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_send() wrapper
from mptcp_subflow_get_send().

This commit allows the scheduler to set the subflow->scheduled bit in
multiple subflows, but it does not allow for sending redundant data.
Multiple scheduled subflows will send sequential data on each subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 118 ++++++++++++++++++++++++++-----------------
 net/mptcp/sched.c    |  13 +++++
 2 files changed, 84 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8ad68dd504a..65eaf59c9a6f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1408,15 +1408,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1563,47 +1554,58 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	bool err = false;
 
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && !err) {
 		int ret = 0;
 
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
-
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
+		if (mptcp_sched_get_send(msk))
 			goto out;
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				if (ssk != prev_ssk) {
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					lock_sock(ssk);
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret != -EAGAIN ||
+					    (1 << ssk->sk_state) &
+					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
+						err = true;
+					continue;
+				}
+				do_check_data_fin = true;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
-		do_check_data_fin = true;
 	}
 
+out:
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1614,33 +1616,55 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
+	bool err = false;
 	int copied = 0;
 
 	info.flags = 0;
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && !err) {
 		int ret = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0)
+				break;
+			copied += ret;
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0)
-			break;
-		copied += ret;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					msk->last_snd = ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+					goto out;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					err = true;
+					continue;
+				}
+				copied += ret;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 	}
 
 out:
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c4006f142f10..18518a81afb3 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -118,6 +118,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

