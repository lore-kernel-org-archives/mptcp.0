Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A5194
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 12:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4MOIBnEXTtPQtYw7jY2adNLYhs8VYY931m2ZRx9UFtLGWGVgqkeW1cWEgUBSlnb1eHS2FYOxDSn1sOCFSvkahfw+ZYqxBbYwv+b3740gbym0eYAqMk6lN+J7OicSIxDJgT7MACGX+OHlZZ1Of8RRwyrs3b8NdyiyIdddJc7UK6i7x7R9/FyFmPUSdj1K//phbVay9BGPmOo/e88BdgQK6kCAEYk6zvwzkT66vOSuOxtJNSqQsMyTZ3Bk/Klns1MwN6ugxgLoJEjAszHSpkx50Ii4kNojcnSbQHDA05h1ZtTCK0iUhEsMBY9IPfmEdr3UW9kz1e//rHwc+CMqAQffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oWGJpQ1VnvISJpEbn8100eS7LD98L9UmA3+xS2nut8=;
 b=OhVzceolHKI2DABlFmyVaRGsAw9HctjV6lZo6aZIKCVhFB0cx/o1WcdvilI5jP0qyQz5MhKzEG8v4vjjl5x+luNbgAKU+NsQOZrzYmNvG4w2uuXPopuwMjrznVqzD/6XlsVVIxXKAeDrCiDKj1qn1b0qpdxTYYD+Jm9wqAyopF4UXdKtMFgAwIcEVgadcVvJmDqvhPPOJ54051gglijsteuZUydT2n2zsMcTAAiIkkzNqHkeHaLeyopTd98rS3mq0PrwwG9dzHY0D0mxF3TqaVpfdKAgONjXYfCD6MYbrjgay0MpxROZPbk95vGoY1ZtVq6SO8x51CiSk8ga66qcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oWGJpQ1VnvISJpEbn8100eS7LD98L9UmA3+xS2nut8=;
 b=XjaJALr3WRwNR1oBRDhfB/A7WCWepRa9UFpregd0nYAVnC2/zdA2VkWXzmf9U6hrgKtYB80ty7zy/2EB/EdlzOxZhVazaJp9KgSVFWGPZPpxwsRaVnScCEs60V8SQGCDrpc2lUelbS2erIt8n4uP6iM/zn+w5K0ydFMV2PrfFZdF17mjHeuM795PLoMEdMYWeeqsbADdHZyvFbSgjabclAv26M9sa+KkA/+duQVNqXPBGT6BseVJfpI3oNg463QUPVkeBE1SRCh915zMyFUMobDgHJS5W7ORdgVw04cOLLGfQGMqh2yq1I5dY3ZKj4V9+qYSljEsC1YYecammGWLWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 15 Dec
 2022 12:32:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 12:32:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v25 2/5] mptcp: use get_send wrapper
Date: Thu, 15 Dec 2022 20:32:40 +0800
Message-Id: <e11e982980cc6a19fdb59d7101403f3546c3fff9.1671107241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: dd86302b-a714-45f7-996f-08dade987c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3E8aQ1rb5FftE3wGjU77n40785Pk2frYtbv6MdPAKaG6txOSYMPOxrK3qQJQua/ciMYJpFe7efM7oP75nmqv06lT8MjE2Fc+w4TzAHYlOFPg3H2feypZnu93rxCsDi6V1xyu6jUvhCMbTmbcBmMFuKzyCso0XyQOiSs1ifv41k8bmAEnptZmUDtKGq2sFg0Vm8P6+mDWALYbl20J+RIHx78mqo48yWXy8tXoWxZDZa+O7oM0n3C0PT0krOiRhtOQfV7ghJtfvufu3YOg3oV3A4m4EvzpyZcFTLkWwEjb7okupLtHNGlbXmx0bF8x2Ijq8ZNFDP35r/RhYo4otKHfnaTlGEtAGC+DiOwK4ERJAtK0ek9fqUo78kYh+xS5xzTDgzjIFNLuOMHMy+ZWiuZiUBZwfD+bM0O3PIl1VPNkDHEepvzYWTRWd++8dcAOi8Z5yfPDqtVvFIi37mukSI57xHAUJ17FOUaser90tr2vL4crJmJ+yoP8VtgBwejVO+vjztQhqFbY5XdlNLNENlhZUAKfNeYVBnSWhpNJ89Q/eSgxSMFvHkGbkujBP3dPShqTZZqbdI8CCZewxwnLkC3qGwelW0paCEdEXYKWEcB88xI2tUEf1guso7Q5ArtTDLXSNgdPjtt+5x++WO++WDMTUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(26005)(478600001)(5660300002)(6486002)(6506007)(6666004)(107886003)(38100700002)(6512007)(66946007)(6916009)(83380400001)(316002)(66476007)(4326008)(8676002)(186003)(44832011)(2616005)(36756003)(2906002)(8936002)(66556008)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHCS11YEIIpQhmYzDy6/FDmGxS0hqZGCkp8UKC6UANH6fj66sluqzvLNDYMs?=
 =?us-ascii?Q?BSakCYc/Q5ZkEfxcR94MxklgQVlZk1Tehzu6zhl1ztsXF3hwJSGv28/MpvUC?=
 =?us-ascii?Q?g9bJ5n2f5fBVP1vCEBrVffrpLrclJoLaxBPF3RKlBUnpzDhQbtbpwwm7qTNn?=
 =?us-ascii?Q?kh7FSfMPeuW60yi5RqLCSYyqECXu1JlRcWtdULRmMuYygkrPlEqT85urZdnJ?=
 =?us-ascii?Q?8L00bfGuMkF3YmK+aPHy5qBrykpEByq8K9JDWpyNUWZXUbjlccM/N3PCMJxV?=
 =?us-ascii?Q?WFaINZC0CEWi4IPfNGhDMIkPHtzNkZ9eVrXYnaLGAEO4CObbKsNkETeqMnO9?=
 =?us-ascii?Q?eY8HrMlej9i3N7inowiCOUb0aVXJ9sTV+AhttAcfjMzILQEC6FJV60w3Mz88?=
 =?us-ascii?Q?cnfzdlhz5CoJfybBeEjRTx+bNrV9BxvFZD55qwOswQWp/RxEn8aDtwP3cUHD?=
 =?us-ascii?Q?CYPD7TH0Fjh5r1j7ZbiDYXogFseX/noQqckDVqn+7/8NNf5GZVe2ujvwkiNR?=
 =?us-ascii?Q?5xkwJD3Jo73I57BleN+EV7V6/vwBwof5U85RTUlfIjL3qoSeGh6Mh+MROL6k?=
 =?us-ascii?Q?kiwmca/ZNnfi2pJTma7snt7x0s6D2mAUPkMLsaFTTAGCfjoaAbwlbdsrcZXb?=
 =?us-ascii?Q?rCbpbm7dLcgtJkmi94SrEMeNo02cdDBbB12C/LHGR+X/V9GkGo1yD4VswvrO?=
 =?us-ascii?Q?0OCAyDy98EGh668oqhYZIjZGWHISH2yMTDUDNu2acQ/F8lCuTNC2MuW6YOhh?=
 =?us-ascii?Q?N1SJqXhonRC3zRnKl/kPFSSNVXpMnY3wLw0XPEFTlT7/orl5QixXu78+82T1?=
 =?us-ascii?Q?VbYTLxEICUv+BLc9aGy0z4/Iyr3Vn8BfvwAA7hOCIzXrGKseoH7juj70y5K3?=
 =?us-ascii?Q?/bFxYexO2BvkUrOQlg3db5pSIufT/YfG87fx/CKtYkcpywryuOo1YoDYOi9Y?=
 =?us-ascii?Q?YRIH8/7hPQEN8joEkDQaPxQcCVJXAd3wfzRCHW+ZKxQkBYFzST0w/giuwnWU?=
 =?us-ascii?Q?L5vlyCXE3qVYBDhCfB6qgSPEOqd8wiPtk0RmpaXsb9c5P1LdQbSHCSwK15aK?=
 =?us-ascii?Q?RwnKkiWbS4jgLFS9BMZfHgXO4cLOfBpCqIfsa8yynvbW3WSLvnzEGV3dphOD?=
 =?us-ascii?Q?ZininrXL4W6etUuiT9G28HLpR2K4WcMJtAGcSQfj2UCtZXLtid9mJ/+ksRwl?=
 =?us-ascii?Q?9hh6O74m35ujxmO6lQ1R3+xNvT2e5h2MDPcpo6KK1vy1hxwLklRPUm1IQcOe?=
 =?us-ascii?Q?xEgIsz+Doxi9koDnUmGeWcqLp9p/ZujdGoEwoJZbK2lZQmylmUB6p09LKt4V?=
 =?us-ascii?Q?JJrbhDap6ZfIJN8x5V6IHp7icDG0mdp4/Ya7XogTPl0cGXlRKksh4klTKL1X?=
 =?us-ascii?Q?ajgMsiX9PXM188ORDrYlQqSCJqLoz82MRN7CUVZRuuEQ/Hp/13/G4OwILiCz?=
 =?us-ascii?Q?FXJ2uD7Xd7BRmZ0qmoen05yLgnw6hUnySRPxHrjiDpQBFaQRvgJITHQSnH6P?=
 =?us-ascii?Q?Ws9/PzO6+LyjAnObR35+fiQkdtYNQbhO7SaxUPez0hOrYCOWUDR/lhTsmwKv?=
 =?us-ascii?Q?TDQRFwgl6WCyLv03XYU1AhZgJr9TaA0nrUsHST8MWdrg1m725+49E3cY3/Ma?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd86302b-a714-45f7-996f-08dade987c91
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:32:53.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3cByJ8FdkU2ir4usbqlhsVHlS23wMsYGI24BP4ZrtvrF/pQUJRKcGkK0S4hvAD5t/W0WDvTcL6fPYNSH7oXIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675

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
 net/mptcp/protocol.c | 117 ++++++++++++++++++++++++++-----------------
 net/mptcp/sched.c    |  13 +++++
 2 files changed, 85 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 14c69a519898..57967438e70f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1407,15 +1407,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	msk_owned_by_me(msk);
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
@@ -1566,43 +1557,57 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	int push_count = 1;
 
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && (push_count > 0)) {
+		struct mptcp_subflow_context *subflow;
 		int ret = 0;
 
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
+		if (mptcp_sched_get_send(msk))
+			break;
 
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+		push_count = 0;
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				mptcp_subflow_set_scheduled(subflow, false);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
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
+				push_count++;
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret != -EAGAIN ||
+					    (1 << ssk->sk_state) &
+					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
+						push_count--;
+					continue;
+				}
+				do_check_data_fin = true;
+				msk->last_snd = ssk;
+			}
 		}
-		do_check_data_fin = true;
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1616,30 +1621,52 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	bool keep_pushing = true;
 	struct sock *xmit_ssk;
 	int copied = 0;
 
 	info.flags = 0;
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && keep_pushing) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
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
+		if (first) {
+			mptcp_subflow_set_scheduled(subflow, false);
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0)
+				break;
+			copied += ret;
+			msk->last_snd = ssk;
+			continue;
+		}
+
+		if (mptcp_sched_get_send(msk))
 			goto out;
+
+		if (READ_ONCE(subflow->scheduled)) {
+			mptcp_subflow_set_scheduled(subflow, false);
+			ret = __subflow_push_pending(sk, ssk, &info);
+			if (ret <= 0)
+				keep_pushing = false;
+			copied += ret;
+			msk->last_snd = ssk;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0)
-			break;
-		copied += ret;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+				if (xmit_ssk != ssk) {
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					msk->last_snd = xmit_ssk;
+					keep_pushing = false;
+				}
+			}
+		}
 	}
 
 out:
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c4006f142f10..6428323d8c7f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -118,6 +118,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	msk_owned_by_me(msk);
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

