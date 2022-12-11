Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C310E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiC59xE+ZNkc9vHY1+6wjmllvwWTxlagjG+aJxicypV9LY0g4d4QHlMg61MAWatef7bah9rPO+pvwvYqgcWITZW515l4R6LUnhSFng1BIa0qKgAHyLk96ZGw7JNqDhEfK7NSpbTHhUI1qthC8x17hhDEXdxKEQMAW2LQEkXZb6X8qtzdFRMK9RfcTMYMSXriwFI+xT8asHSUwz7+koGZnHXT8gjg/XeuPmTSfrkVYHP9R2OudJ+JnhKB/B7NXYXlOVeIYKYT4uTaLlkMXFarDmfi0bky0fpP1mQ7KLcrJtRtTxidu2fsoQhTeneIXgIbnKyxOI/ZYqVK81A9XhQwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYXxdlG8+j/tqGyVVCGqMFe/ZroC2TEaeEPOh5C/MWY=;
 b=mjQmKITaA8HveWogJFqgT8ULsZuJlwjcd+TmJJq26+K9/IvlFvgcuV48Bu+OmgZT+UDgFjflfQptlcvkFl79Xey4kWzxWO2y+M0V9WvhGQ9WHNg42PPCl9verRyeSn3spk/PtXjS5ke1SBM/bdOsNWXN8JzTGoB/VKmPIuPwnY4VWGbwo2pqI9GWMbknj9DwrKYhWRKu/twEmoyxiTd8LUZkV89A56bGVeFHm8N4ZwqiBCo+onUb2z+xixDIoT37Q3WX2JHRR+cWbVyiFmOP1qDPjzA5OEJVTbXcQVGc/M4HuWPDRi9xymDDykfqOKNZPVZ8A14I6Ic/SrdxnmWsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYXxdlG8+j/tqGyVVCGqMFe/ZroC2TEaeEPOh5C/MWY=;
 b=t1ywj96sr5nkYfx5z/wHRR/vPg46QcgsQKh386NTpO7ESM6AsXG9zaGRXiBZKy1t7HOyBEQZVfoikE0AAj+NZ26NQFhBiaPONOo3p8hpCT11ahqHiCf/Fg2INzOG8pYXn4pngSSyNLZStsGN5mKXtS/xIophIcADMIXYqxhc4ISEfYaAo/B9fsRZ34qMsaOEdHAU/6e062x3MpucyMkuqagHpouKVRelsuXLreq0VbYG1NF8OVcqo7fMlUuYxUdKDz1n4QjZ9fTcDi8maa3c0JuippwNkX9P2zJvItguWQQ7XXPW6S+ShEZg91Pa0vzsF1QfUWxdMR2MxZd9rKmaZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:01:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:01:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v24 2/5] mptcp: use get_send wrapper
Date: Sun, 11 Dec 2022 10:00:53 +0800
Message-Id: <514a6af8db312705865fcf9c33c817f264fbd495.1670723836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670723836.git.geliang.tang@suse.com>
References: <cover.1670723836.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: efc1e111-832c-4bb6-a01c-08dadb1b9187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1l7f82KeAV1I6k0rwa/4p3p1a20ZfpE+Sx3juu5CQ6l9QHrTYy24yUN6Q5aLUahX8R+YBUZs4chymSdgf6z6BDnZqc3y+mUFqLg8GianpFUwlRiGl1Ur9HuNdv9neoeIp0iDU24RyCVoKNSlR4Zq3jWrM5BZA/MUCVVOTNWGhu27UJj/GpxvtotjHCQhvKa9PCBJ8nIdqaDOnwyNM8W/awYWXxvjGhxbmefvIEQE3RGaCb6s+44ICaSZ50yW8etS6bqILhlYJBdbU0Iyc4IN1czVcyqafqhJRNqwIQYjyR1UT9lxzIXkrXy8bmIH/DwwT63u9UTTkechbsvPp47ESwcj/f0raBVGVzxmAa0nwfZi0cdrNowlKf9XE0Yt3heP0D4J/2A4qtByzDT3tvUH3w9Fa5HBimTFrQe34Xdy4S5eRKqH+MV9XGZKevVnDzK1vOa9jpVqQCgr4YsxJqzdQEvge2T+p1mZrMwGUC670I3ACX+3OQLx36DI9ramKJsdI1yg2KrG1PhbhD7gx76/PVvkGOnF8OqZwicLRpcY6Do3rwlBJypbLLuhCs6KitsELXOX/qAv/eWMFN7TXEo84BUqSnBtx/oCgu7bwGCYN73gh74ESR+7CjXpL0M1ioN76H3tDrLVtS9xmXplgD5mRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bInlJNFxvS3/tiXQUXcyUTRq/rTRk+p17Oxm9QNjWiH6tyuN0VC9WYeeTEU?=
 =?us-ascii?Q?bJiuHfRRFySwoB1xdSz9RjZBelsXvera2XrVBifmzPasiy2sbOZ4vHCoXrDT?=
 =?us-ascii?Q?zjXRAa3EY5bJpkZ3TLS7qSKKqQZZuD+rO+6Yp5PBmr5FF/jq8UQpLU6aXVrq?=
 =?us-ascii?Q?I8BBiITcCikUy/3frlFCM0+KT+AFv2MftkAfiE2kvd8x9kSkNK1DgOEni6r7?=
 =?us-ascii?Q?mTRF8rsZ9Xb8tmwD7PdKfyq+EVxOkHrRXeusmXWvuX3gHdNwys5ikdM6oykT?=
 =?us-ascii?Q?gStdpg0geY+Pagf46AvxNv3j0CxnpOZODoLMKOeBDQBpsplcwhvPrlj/pebQ?=
 =?us-ascii?Q?bNzm/SANcg5u327B4avTTtKZNYq2o4ctRc8RhChXeMBLvWwyUtVBOVEDfoG6?=
 =?us-ascii?Q?oy0YXfaaP4NOYJPPxDrsA0wb2ekZxif7Jm3UqIVZ2wf5QOFfi627XJ4/qteW?=
 =?us-ascii?Q?HuiytbJvs5a7U+7YbvhYGcCl23qcQcJw0UiTGz+8nytGHl+1J/AMkxU1TcNy?=
 =?us-ascii?Q?5EqMV6XG2iMgnp3AAIGzQrwpnoYbT+lH7I/jwTnZ2QrAVCmS+BEddgy4/FaI?=
 =?us-ascii?Q?hoRwBQ6+72zucinW9yxHG71JD1JJognF6dX2q8B7eKvrWN3UTTMPn/RQ7kBe?=
 =?us-ascii?Q?o+mSCjqBCP5YTBX6rIbvq4LDB6T6qTetZ9SCXA8gfwTzYYK/UTyNjq7cpcga?=
 =?us-ascii?Q?opmpv0LrdUMxw4En+zIpD7NpiNxcVI8apl13Wqd9DBW5VxYhj3QAwkTFI8+6?=
 =?us-ascii?Q?Wusw3ebfEtW/AVruaqLjghr3t7zB6ARKam3j7wvfAXh+VrwmpGNn9Z4ybyVV?=
 =?us-ascii?Q?MdbTQ51yvenfhEqLHknzEmXBrAV87kRtOJz4M10dXTTuSqa3gZDaYd404/bm?=
 =?us-ascii?Q?Lx6coZrrhh0UEankyrpH0Y7++zGp+UA+kx+Iby53FHi8A1+OaUPnY4IzFZxy?=
 =?us-ascii?Q?OYGIe++YEyMIEfKeE+n8w57WNwaWOa55Z7feh9TUqBdMFzaMUgvJfsVxzmqn?=
 =?us-ascii?Q?LBgqKk2/+8mCwaaHLdUfxeXNebj8FOPF+P4i+vgM18xcWoAOA2oAuaKlGRMA?=
 =?us-ascii?Q?knBq4oAsPt2NwaSS7Ro48psZ/PTdslyiSkUsOApS+eEkyJcZSLqK1A9+V674?=
 =?us-ascii?Q?qX4dgpyawmWky5RrnBPrkZv6G48dzmu7c1BS2WrrvF/KhnZfmrmPl1TAOwEg?=
 =?us-ascii?Q?9TPotRiWMmt5tzNBAqaiAA1D1cCvdFmWNcZcqocAIDmLmqeO0QJ32sMD1Gam?=
 =?us-ascii?Q?KC4njZ8gxrTupoWp00wAr9FffiNiE79n0ElIHcy6zmhHNCE/qMc3b3vLMin9?=
 =?us-ascii?Q?MDDlIC4zMJRyZn/VtMbfwe1kCvaDQ/1C2GBbW90J63+NWXzcN2M61x83sKGj?=
 =?us-ascii?Q?LQMxFlzQiNOI/0LKzyfKEH7ImORwRo1gMJJbZYmqStAj8AwqLeibB/M6JAYw?=
 =?us-ascii?Q?R62Tr2QiY8t7nVDxlBOOhk0qjaFmJF1CHqBGLtZtO/e+Okj7voAVApZOQspr?=
 =?us-ascii?Q?VaTyUnjby6Px8AiQ7/JP/AdLI4XBrWRja/GjcoEhzeF0dXitfbvku7v4/Nya?=
 =?us-ascii?Q?VFIIIUtxRqLubx9emB20g5lx/L2D+4/1Zv2QU6oNEiDawAx6ckl09FYnbbr2?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc1e111-832c-4bb6-a01c-08dadb1b9187
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:01:08.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTXpHspL94mvkyugVigI02/CtTX/LT3deniI/P2lJwgkt9nx82dV78kxVSwWzqdKpyAP6RgwsqvlY2ZuQ91Y2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

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
 net/mptcp/protocol.c | 120 +++++++++++++++++++++++++++----------------
 net/mptcp/sched.c    |  13 +++++
 2 files changed, 88 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 14c69a519898..1c095fa37b6b 100644
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
@@ -1562,47 +1553,61 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	int push_count = 1;
 
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && (push_count > 0)) {
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
@@ -1613,33 +1618,58 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	bool keep_pushing = true;
 	struct sock *xmit_ssk;
 	int copied = 0;
 
 	info.flags = 0;
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && keep_pushing) {
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
+		subflow = mptcp_subflow_ctx(ssk);
+		if (READ_ONCE(subflow->scheduled)) {
+			mptcp_subflow_set_scheduled(subflow, false);
+
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
+				mptcp_subflow_set_scheduled(subflow, false);
+
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

