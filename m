Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130072.outbound.protection.outlook.com [40.107.13.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D21323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpbaQLibSZwMHuEfgaAc5I7UB1KKuJ8ZYYOjTVbVByuYE/mL2BZj2RvyRW7OGoxof/1BVEuuvsDtYiX+b3Df+wZA6DKozMmqmvND6NXdOiEbF6eKtkbMpt1VRbA66EXEKf9ktUpBZQaHnEiVhJE9Re5eM0cdPCLkn3lQh8J9AHGdbKmsxPilEBXWhwnK2Sy0WdMnX3YVJ9w4NRHYc+PGxZ/PnOx1pyBGVzHvN4o1LoAt2QutaHzq7j3lNvucOdb5aSNBZacCezZIuGuq66/UC9fBOy886dlBejyIlxBfIgLs8Q+OjaF29jeMUWexJabBiru6OWRZE75ok7tr8NnuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a7Csr2ucxUJU8T52RAkSTKJJxB0xqgoe7yvEoerHnM=;
 b=KUAb5Yif6TKcqt7RAwZs3/gyhpc+piTRP4X0xZKJO5mkfJrN/BeF+pyAo63PHg8AbT+xbEoQEnCHLtbL4cll9f7vh6ZRbzujTa80DtT7TvMXmOLc6sByhlQziOfTx/9ykyGPbpdjI3w4KWBwRZd1C3VvtKvPG7RK+eebOigeIQ13yj3j5E283HisWeVtBRd67kAFV8HVrE2gIjHCHlyJmNxtKPzOh38BwloTuhol5M1ZxC6qREi9PRWkng957UBxJ9i3nx6aM1vHGVNFZihY36EB3IRuzMT3C8Isc70A+Nv5lBg3BJid8h7uNhntoLn0J4YdIKFSoecNz9Z8mTHaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a7Csr2ucxUJU8T52RAkSTKJJxB0xqgoe7yvEoerHnM=;
 b=DOYGgzb8vAwSZlmIZK6N461wS1qjyA2ufjhCmqtlHskaO9jEG3DfqyGOrrWV1GT9Us+ivSJds8lE8zx+zJ0bJIU2ofEYYVqb+MrN6ql4ijSQHPK632jg3T+wm7Gf6JvAWhkTt9yB+nQ5PjooZhNe0S3yF9whfOTlR4jiwEQkCbfPl7NeD+wXn6Iy2AlOw0Kymz/bjsVJHcm75IfflBdZciG2/9twL8+MQKXiIivGI1IPQK9Id/Nuwblmize+iBo2chKbuO0a9bjEXXdYJqVhDb0fIx6a3CRERI1aUZtn2bPY2hrGc2vngOj/lPXFcR7WAqRn33pZOFZAxnE6t47tiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7948.eurprd04.prod.outlook.com (2603:10a6:10:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 06:46:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 10/15] mptcp: use get_send wrapper
Date: Tue,  8 Nov 2022 14:45:09 +0800
Message-Id: <1fd54289137d2fe466c13ae43686101853cc3881.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 336f0ac8-7aaa-4bdf-0224-08dac154e919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HEGKe0xMT3YlbIGJ7RGt5gYCXS8mlIY/jkFN3IDEhRAIHtEN3a8bBJjSSpnpdUGLa15ykHI4SriKhPi4HFvpif7fJAbWwxeVXtVSy5o4cC8gX/FWXgeHNRjsHbKam3z8Ea0cR/PSfN1OiBV/Oe2K7bFM29cIR/hvEuH4PnBLT6/qehv2ol5e5cKdKNlmmPPRN0TwTDhkURGZkPyW40FIwLk1bZQq2yKqFoJe2Nn1XP/AsxAt7aPjm5XUpzf/vHDY7d9p0vmO3BwkFQILPwMiIFEtMmripiivkSH45NsxBOHZ5W1nPtb1MC9feYm3movUEq+rzP5p/p+L3Z/UHMA8jMibekzD9h2dg26uc47mt0QQjDveAwew69pTLUpI0PJ9u4zS/YL1cvOEcsBxUrtFlIJokkjaw+15mEjxYruWzBV90rifikdqA91Zp3z1dEce32381FfdWZYE6ql+OK8bIb+cao+a23OZkpSrp+0wgaF3cQc3Oti4Luctlv2Fp4QXBl8k4Q5eE0QbrI5ul4ze9s8I/hFNvuukd8g8OJ005xUTEGIdXMg+VBMYP2iC9CEAPRrWOXm/Q6DuI/dhs+Sw/3tVsJt+KrHvSScxJJs6+N9T74K6LAPZTtAiCEFDiY9twz25+PrIff2uiB1wKpnnyHSlDf/YCMwanneAKeUpBiNCZsT8iEMLmlUXun3kTalOZbO9dyKesVN8J0PIyahdce+DrJjNeuXhRjtadvk+6Wslu+PrwsZ3DsktYteZ+qqk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(186003)(107886003)(6512007)(6506007)(2616005)(83380400001)(44832011)(26005)(2906002)(316002)(478600001)(6916009)(8676002)(4326008)(6486002)(8936002)(41300700001)(5660300002)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCFLtdwtLPH8PRhH4XFGCsIwZmTxAWR3cH47Tqs+IE3laOgrWv5M4qxxpQnz?=
 =?us-ascii?Q?WlSS5kPfEh6ARb2FScYm5sK0vg8R7Q6tXbzIHp37CPXT4TOoPr1riZBRocvb?=
 =?us-ascii?Q?cgzuNhZiOSwi2IdRrqdnT5iIfaT1Sft2V4PVdnNjuRH/9niFXqfTZRVgs61d?=
 =?us-ascii?Q?SpdxhdEvCP8GnTUR07tYUlcLrRIuvVR+6TRgFDIp1Y7DtUYk2zZDELYk3jMN?=
 =?us-ascii?Q?C2c2Tf2qjrCGaeCMNqwEshykjVeUmsj+brmYhxJypsSVzdv6KJnpE9BwvtZx?=
 =?us-ascii?Q?kZLPSY/d7SrhOc501U72w/b0Bhc5H1k27X+a/d16pF4fhbbELzB8iAi+7SqZ?=
 =?us-ascii?Q?nm7aKQX5M+WNNkbGFY6RPU74pHs13li2Qfnrx+zIGVpwO94DXRhFSBMnJW1G?=
 =?us-ascii?Q?4HCA/hxV7U7DS8JlfLlFFkR3Zb9C7k0sI9nw1yCaBWRX128DHsl4Vp4DIiAT?=
 =?us-ascii?Q?ZfQo5iQSvs+1e2BTQB5gpFOQxLAOUdsqRj2bpe5mY1sMFdKvuHDlwKUBVlKL?=
 =?us-ascii?Q?D3d/9HRFXzbw6NuyUbpcYXhOhFq5iEgxqhmTNEAcyDmR98qIYkbyT25f6BcS?=
 =?us-ascii?Q?puUOk3kcrk2yM4VNAXqLjN1U666L1eY//vWUpiZsrar1GVZmm4uubyK3eqaH?=
 =?us-ascii?Q?05gJhUAIjVkJO9jyNkrFCHPS8KmJ65u/HaLLt4H6uOgb0Psza/usLpzRnUya?=
 =?us-ascii?Q?RSfHCCV3kaSS9+H7GvVHlngreDeI58Tbi1FQDAJPFCgqPFJ6vkReKl/AdRpW?=
 =?us-ascii?Q?rf3raYyiC7Zsq9pxzjIOElOTZFIPyAATCMteUZTTTyv3Tf13g3teuxipmwle?=
 =?us-ascii?Q?5MtSlv5js/7ckhIn+tS52/gYqoYyYXqYAzmmTfa1YobHawmJVSdKtusUVaKs?=
 =?us-ascii?Q?wDXgSVwSObEvUynVGwH4oONjmmmEaUia9a/sh/WOYY0jx97WrlO85AKPsiTC?=
 =?us-ascii?Q?yWdWo2h4vmRTZk+8ANxi8kBXr2ip2gysTwVVmxPJIweSwU0CxC63jQr61ayB?=
 =?us-ascii?Q?mHDnba00MrTsPkjil65jZgT2hjvNqmMc3s0Na9Ogw0Zi6icVO3/7o9urDAgR?=
 =?us-ascii?Q?FMBFGyke0wlUjaMiCxc/3nx420jlNcZcS4vDoq91KPZC9/lvUg9Zhfak3Pml?=
 =?us-ascii?Q?JKxzWPzTiGkQozsQ1Yt5bmdPt841WWxVPHnBeCwKJbmZlJs+ejgyDIDTw82e?=
 =?us-ascii?Q?4bhBjgd7WT1ajjkSpEbqNib86juumLyMG2duJe8OhturUiwnt99Vrlsmx5Y4?=
 =?us-ascii?Q?gA36Z0iLxxftQc2dZorKcb/S7p414HfLmCFcm2lV0h8TcKO2Nx2ZAFM6X/My?=
 =?us-ascii?Q?Pj2jJCaZfLwNUmsf5VYXGbQDODGJNhJL+/eQH/CKvLRNeXKcnwtWDg0P1Dss?=
 =?us-ascii?Q?c1oTgWeQ5J+yopKOy8u933YU6kj67JCmgyoJoNqA3xZg5V/oxxePwtbDnXvc?=
 =?us-ascii?Q?7R9ClxHVDo13mQRgAla5Ipn5hjl+CiHyKlTdZDyKV183OIPCO441s2ypZL6u?=
 =?us-ascii?Q?AlUVThYbatlK1CRHRUXv0rbYkT1avIYInenlutA/zmgTgZrOyAO+gjDtwUO/?=
 =?us-ascii?Q?pR2lvn8h9fg1+ubpUpXOVEM4wIXh+sMIL2Zu68SD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336f0ac8-7aaa-4bdf-0224-08dac154e919
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:06.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqxOnLsM9Vt7TpT2zS713/9qup0pX7CbN+k2rh/t/062RKjRCHtNSlhkowY4Zb9JSKCAEBMb8f0MGV9NQ0WQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7948

This patch defines the packet scheduler wrapper mptcp_sched_get_send(),
invoke data_init() and get_subflow() of msk->sched in it.

Set data->reinject to false in mptcp_sched_get_send(). If msk->sched is
NULL, use default functions mptcp_subflow_get_send() to send data.

Move sock_owned_by_me() check and fallback check into the wrapper from
mptcp_subflow_get_send().

Add the multiple subflows support for __mptcp_push_pending() and
__mptcp_subflow_push_pending(). Use get_send() wrapper instead of
mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 130 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |   2 +
 net/mptcp/sched.c    |  37 ++++++++++++
 3 files changed, 123 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c38ad7279e6..efd87458f324 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1417,15 +1417,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
@@ -1570,6 +1561,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
+	struct mptcp_subflow_context *subflow, *last;
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1578,33 +1570,47 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	bool do_check_data_fin = false;
 	int ret = 0;
 
-	while (mptcp_send_head(sk)) {
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
+again:
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		last = NULL;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled))
+				last = subflow;
+		}
 
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN &&
+					    inet_sk_state_load(ssk) != TCP_CLOSE)
+						goto again;
+					if (last && subflow != last)
+						continue;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+				do_check_data_fin = true;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
-		do_check_data_fin = true;
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1621,33 +1627,65 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
+	struct mptcp_subflow_context *subflow, *last;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
+again:
 	while (mptcp_send_head(sk)) {
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0) {
+				if (ret == -EAGAIN &&
+				    inet_sk_state_load(ssk) != TCP_CLOSE)
+					goto again;
+				break;
+			}
+			msk->last_snd = ssk;
+			continue;
+		}
+
+		if (mptcp_sched_get_send(msk))
 			goto out;
+
+		last = NULL;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled))
+				last = subflow;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			break;
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
+					if (ret == -EAGAIN &&
+					    inet_sk_state_load(ssk) != TCP_CLOSE)
+						goto again;
+					if (last && subflow != last)
+						continue;
+					goto out;
+				}
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e93d64217896..2bc0acf2d659 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,6 +640,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..bc5d82300863 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,40 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
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
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

