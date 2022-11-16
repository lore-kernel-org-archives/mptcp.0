Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF507C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXWCYJOOGZ+7ULDYkxlW54501B70ykoi7176+RUyL+4cYB/pYsellfRhv+VKvf0zzFkf3Gq7S0w+D/kREJsc2gT/nnOCOUxjt0YnfbIqB1go5PnRCvz7C5dKti+iIf6KPu1bM5PPPdI6UXm9f5R49Jdm2k6/SaMco6VADxjCoPcBtUNg9T5cDnCg8YSIzdfLq11fkwhph4gf3S0RoIfsMZXllKSdFmKiPZiYQA4JxDlFMLrd4PMbbIRn8h+35E56hemirL+lYiQ5FeKuX+8BEwLJ9frXUwaWt/ZpEwLDKDVpXqSAT1A/RU92DOQM/7NgXqg5C5nPvJskvd+QM+ko8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBu1Y9mHKUmsHLjrGIO0VACl2swVy7OHQvA/aEpjtWk=;
 b=b8yOptPu+MK8aTOUkwsrmTgjrT+Rq3Tyk7vjpGfohQjUeddB4BARFN7BobjCxkPczg5Gu4iEpCKwLJTDB+0VUrJaxM2Q9yeYcCfuSOlNBhatkSTzIqQNK8OMEo5MEsd3gbDJoAZ8DUXF9IOcEBkWugRaDMPOv55gb0Y2oSle1SbbLZ0bEYT6ylOW9gFUiSd8I3wO+WC0Zawq7iQXOaOnRDwgQjBK3/qu365LHVT4N+IF9yiRZeUqNYnHACmhrHjIyKnmd9nY90VK9HLKSzuw30lIgWL72qafNNcJO7eROFQDiWzvuYlgZzd9oVWv5RSODAER62bigxIvRhHV5sBghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBu1Y9mHKUmsHLjrGIO0VACl2swVy7OHQvA/aEpjtWk=;
 b=hF2irtJomI0C+xNnjmAk4WfusW/aoFoA+PXFiyse3aVuoKYbMO4/ebZMET9VzMVqhdBUdtEydPRuXWwgwm9d1/X18AVyMLoEJKs0ZBBF4dNfTGBNhrbFPMfIxbut0Y17vJFdIOQdUGWhhe2kC232gnz0r7kloPXIY579ZD3qg1Lx2byL8sIg/Agei+ILN+FTFkRnfGEhD0lee4CK+tqRt9TvjvPltH5lEFkHfJh7lC3aTwDT4tLwXPiakLgq/klyhgjuq2pvSdWxnB+RU61N2Ea0b84/59YMPeqoA1gSY4NaMrHdZL/AgwCGWD3T2gbJAdBTCDlYYfLwrhj6DhuhoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 11:43:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 2/7] mptcp: use get_send wrapper
Date: Wed, 16 Nov 2022 19:43:03 +0800
Message-Id: <5ebe73a0638e916ffe03b9354bc0dfb1c6027224.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 169d7c09-be63-4e45-fec2-08dac7c7baf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6HH9WIm43IKBRQmEa96kkY/hngSgoEt6x8mfdYEHyPCX0z8kQfHJruWwAQH1Xf5of1nsWVQxxdgnjx5holnNIBoQPgAZInVNYjdx7kVZq1j+rBMGK09pHaH12YJwI4nCjfxlWwAP3iRkkjGYAkN/ttYiLiUwiMkuaXxuqj9Hsl3uHyrr2OPwzWRACiZ75iBHXTsQn3PoYKwkpa/FNn5OuhBlcktrLwBW6r/9muwpn0hVud6gFH1t6JU0b9mNrSJgMR6DWAKKVHCx5/hFoSqgGNh6jhK1/tGJeWuZ99hR+ELzrGKiVC2dZewWVxT47iJQs/XthS47Ctl60LVOXTCAJBDHdac08nzqTNq+64MTBt+xIRtu0qFDXKL+SkroE/3IHCh+b02Z72mo4Z0LZSOZ5gKFjGHlIKawiB5SwrymFAnX7QbO3G3nKePGVdJVXQc3P9oCFm5WzA19ZUHf9LL7jnjQ7SUCwPU5TQVY2wWttvZ6mSSQZ/tW+2BEsJoGSq9e9QWlL4q+dfC4TF5SfNXNDbcZw749R1oFfUm9bB5tOaIzsuch3PFc95sMpARBnkWJA+6Jtnr71/dT68NmA0TJ9ck1wxUZh6aTiDwflXO7yVmen1lgHeupRoGiTdPEP8lzF3wDQ3tUNM0VCUq/ivArcMgaZPeDHC/+k8YvbycUdbMwaKbHfOJT6QswfVnUuKU6S8btklvsf3n0MlOvT8222A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(186003)(6486002)(86362001)(478600001)(83380400001)(2906002)(8936002)(6512007)(6666004)(5660300002)(107886003)(44832011)(26005)(6506007)(36756003)(2616005)(316002)(66476007)(6916009)(4326008)(66946007)(66556008)(8676002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pju//BCP/Di429qlOnAvi2VEG0j7HdoP6XHgteYaG/PUpt/zuhrChyLTnnCE?=
 =?us-ascii?Q?HdkJl3Xu/nzjP01HT+sVzNDX3k2pJCkbUna9erPBQM0+rnoCHTl66qAS66ps?=
 =?us-ascii?Q?i/tmPX+8rfiwXF2lLbtCeGLQvM+qo+C10+AfdOzM09DJ104a/tXL7HpYFWbf?=
 =?us-ascii?Q?XlvCwBVjBpZHJriOGJHk5PNIcwu/YuM9qV5JnHd8yRINjr2loTsOxSjK35iF?=
 =?us-ascii?Q?YrUmCk6tqP4kmnAlcjqNvzmPezfFsu2U9gM/J8+5qMn6tnf4DAS5jLLcR87a?=
 =?us-ascii?Q?2csO3x96kPjDlJiXZHkvvnFjiItv1RLgQFwwZr1V8aWdvSPiuqbH7CEw3ZiB?=
 =?us-ascii?Q?Kq7PEUZsnyBeDVwtiV8a8vwKnmGA3x/KhXnEj3aHcmu+xjc1WSkTzzeV/iyq?=
 =?us-ascii?Q?IpgKplsYkk34nxqKwHL7qEd3Ewn3m9NiYBRAlWhPsmFfnN3KHB0LXS6l1bO6?=
 =?us-ascii?Q?h8fAPCoVNxcA5T9BAxMVUn+lKM8t4D8IN6bkl4vJKIj14+emOIuUKt1yFFL0?=
 =?us-ascii?Q?CTaBCNGS5LEV0vicKdJCPfNrDDJckX0WLVgDwRK42Qz2ZiSadlV/wNlEO7G6?=
 =?us-ascii?Q?yGbI6IhXmsv/3MYYHyr7k09v++bhAasv9OJNa/1yx1lLqzzIYslBf2UxG42e?=
 =?us-ascii?Q?hw+ZxB7QXi2M74xPK73JKHwIDzIDlvFb2Uqb3sTJ44nPKOc1ecTlKE0rl2hE?=
 =?us-ascii?Q?LCHf/MV3DO3pR0DUaNGuu8XjLGE6v/azh117nal2Y13aSt6gBxN2MwPrl5qG?=
 =?us-ascii?Q?f2NPX/vJk9kvGXGC116dsjZBW0cm8dJaiYcPCFzYeNNM7d3p71OrPmJVGYTE?=
 =?us-ascii?Q?NWwQbWQySxT5yjG69MrBFE62x50CUr79HWY9iyn5MOUExTRaBJ2UyyVL/dsY?=
 =?us-ascii?Q?ghJoUtUAfCRlrn2LxoIuQeeRaArG+JtuJQIthC6vmrHELPmCdKrcwX2q0tw1?=
 =?us-ascii?Q?YaOdwZIrfHDjxLFwTK9oZUPrRz/whrdDABISuttdG0XBKlRpPcnH3oelUnuP?=
 =?us-ascii?Q?NexPl1VEUtzgwE05BtcPB9ZZPiufjZI9NdmjIK3m/TS/ge6fQAgFgLmNoc5f?=
 =?us-ascii?Q?R3hRgG4Qv/imZudVNdrIzSedRA5kinCpX8/ZwpIPbIPZlTLImgxh1Xbowbla?=
 =?us-ascii?Q?+vA+YAnW3T/VNRTIIgMj5PnsDq//q8JYhq+UN4wmVDxO/8DOVPB5pZ7rYrlY?=
 =?us-ascii?Q?98J4KV7EVJCbPO/kZido2yduUPxjCXAR584dJ9TKIpoGqwObPf0mRUML1pf0?=
 =?us-ascii?Q?UEKBfCf0a5PvzcTqpJSdgA/p/G8HnDqQfFSfMS8abYeDwQeV0G9qqnsoMHO2?=
 =?us-ascii?Q?L/1ZDdQlczPHjKp8DuHti7k1V5xMAwHhqYJNntFdMG9YRxTGkhxBdbbIafpK?=
 =?us-ascii?Q?KSQq/kAzS7VUFWk3c/yrs1y0V4YuMUVvn5lBGHRMV5+UDokX8lRbK2YbQ4KF?=
 =?us-ascii?Q?XAPyIBOME8FkSwsrTu5vENUsZnUbrKeyHj5J6c+12qsD6ezltbySv2gK94Fa?=
 =?us-ascii?Q?TUOgJN/B1KacoYRsG1ZKpmMyFgL8iVv+1Lph7SGIhmMS/NOpwUHsSzOhIvEM?=
 =?us-ascii?Q?YOjnF4FGSZV0lC0k4YA9BdUOQhvcbHRmCOeGQ55Gj+UJuuaPREGI69FN0Cao?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d7c09-be63-4e45-fec2-08dac7c7baf4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:43:07.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg83CuwbQibS21AGFN/feP+74VUoTH7oKSmhCKf0xCOs4sIRgrHaGBEI+VcsbHYqbYPK+iHluACH/EQlOB/Vkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434

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
 net/mptcp/protocol.c | 119 ++++++++++++++++++++++++++-----------------
 net/mptcp/sched.c    |  13 +++++
 2 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6531df5ef4dc..f3720923b22d 100644
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
+	int err = 0;
 
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
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
+
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret != -EAGAIN ||
+					    inet_sk_state_load(ssk) == TCP_FIN_WAIT1 ||
+					    inet_sk_state_load(ssk) == TCP_FIN_WAIT2 ||
+					    inet_sk_state_load(ssk) == TCP_CLOSE)
+						err = 1;
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
@@ -1614,33 +1616,54 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
-	int copied = 0;
+	int copied = 0, err = 0;
 
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
+					err = 1;
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
index f51f9cf20b6e..923c07296ff3 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -119,11 +119,24 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
+	sock_owned_by_me((const struct sock *)msk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
 	}
 
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
 	if (!msk->sched) {
 		ssk = mptcp_subflow_get_send(msk);
 		if (!ssk)
-- 
2.35.3

