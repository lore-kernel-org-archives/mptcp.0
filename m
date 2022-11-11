Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC216D22
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfQkkAB69NV1le8qKmxP8Lw4XAB8ifRq0OBkI7vnBDIFoyDHHP4QahOj6cESU+ehHSfpOWdwHfogktsGWRkv6hEQ+qYseCi0y/gnhCbIkEF4QfONY6RP/WhKwLg7FLVTHZEuHC1jxOKEVi68fqEaUSBHXnGTTFo8HIs7T5WAC2gFhNiMIcY1bZWmvK/tyLD9fWNXWPyLefRDWuIISrkjG4kBco8SYCt/Uqvi4UTy2CxAOVyGnIt3pMbcX7r6lE89X0gKGNRLdzUooFUXwUce1Lv3iaDpv8uAfjzmeNlPq6oMOXo0wW1VKp08PZfVTVkR2bCQzNLZsUAAUli77GGTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6LN1knVWhEwrFaPNfpVegnkDTxjbwFPcdvK5j7njD8=;
 b=Z0LOjywRm9l9z6UZIlVnRKPzyMsDOT6dg+s+p5MqEcCjBC2NBj6NpgKifEepIrtqFUqFnwbbwpKNvza2Wa7XCYilg6DNZDhMCDdRL/uUFprjjv1Bp86EQFtAiiRCN2jdv0cnPR+g5SsOAah1yJv/kDcmKCbAFzYpqYn2yJqKykvu78MslF7yyTiQpiryern6G2df9J08wRXz8i2LeMgeI/fNz+TXCqcjYxQs6sJ+1Efm1vfYalaE/e3fMyA4lDDIiYuKDFrepHmBS6dx82XMz8U5yccdEGmtolylSPBl10DlmMEJG+e/P6TpOBMxI/B0/Zn8+O3CSo3CHy9nJ2uvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6LN1knVWhEwrFaPNfpVegnkDTxjbwFPcdvK5j7njD8=;
 b=NzGz3dzPcozqWaKzUpMF6NkVqRQQHMhCIYphJfXyGy0ZyUsGBCyaP0NfqBBVzGtNQAjvMl4dq4YPD3KHsoh1/zPnFKtDq+qnolMDpSYg1Xw9AwbuQrDU3jo4T6EOogQA3qLO7tQK/UksZHTT8b8ZbHeCgxCQP/qL1wYMX2Wts+UP09BVl0epdKl9gXXew4Eim+5Da7al160Khxon7j0yOCEIcjEPtUGTpL2TOJRtsgwN16a+k+PsomqanupREOplp2V5q/buBXeGAwoygqC8pDByF6JQ7ROgVzeIkqbjgzh3BjCQFDe9t5779im5kHwdP7+OVPlxlYUf4rUwZbm53Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:32:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:32:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 2/6] mptcp: use get_retrans wrapper
Date: Fri, 11 Nov 2022 21:32:45 +0800
Message-Id: <d3b086654e7964d9ee6a50eb4b0f47d13f3e38b5.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668173360.git.geliang.tang@suse.com>
References: <cover.1668173360.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed4a408-9d54-4ded-b4b2-08dac3e93d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EruwFDUIdglJr2RHDNU19XmxmQm9a5hVV0NkmkAtxBMbnRd1VC1UzR2qvjZKBAJadJRcya4rDb1tZORDvA/qbSZKVkMUBX0QNxrWXXOzPEpH8m55x2AdDRkS3ZRQgXLi9IBCgX6jFTcWoyTREDfe55kNll+wczZP6icWQTBI5AkFpNWyJrWhekKiE60ksNrsBbxUJ1XtVsQmsijh1bbuMypADPPC2o5gNMo+nq+E93MS7ZnCP1tcJRdjDamtpr1I1qUwgQjem38YDp3qDXZdUM0BzoaKan8OtI5IHhxkGW/5kAX1oBawVftvoAKolxInW5Dj336+WEkJ8sVGt0vs1onRl5Zc/5R0+XwXmOs64mtj3xsKo5dnonOvg3Xj/7SLKYz6ebU/l8S93bjx5nyyBTn6et0ZoMaqFVsJf+8OMHxjcbUNzleWQ5GzkUW4L+oBmqf9A4u3f+wSlR71eD7isf7T3qsWZpccxetfS8YgW0at6G5wiKGmWGcpPq1Gy9ANERWPN5SGr6bwUJDS2oJbuAOdIRDk6moUZGnf4XqfcdRHzU8KaGmUqL7LF22e8GsDjNeCXH9yjj7MyoWrBhVsxowsormqB1tmHm47/hRruTNS6fgnbMnamvj3cV/6KG7KjY+G69GPCPXigI5dqeC8PHnf+p8vH6b4lXtgGUGXQGEl0S/fULVOFHjTP4OvNH9/uZYxiVBKENP/2wBHgM7e9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(6666004)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(83380400001)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Yb/5SakzxaBo6mCY6eBUqVWhryI+huA/r3BHMXo7K9jBNgSBLCqU/bktEF3?=
 =?us-ascii?Q?YkVETAlP4m2E4D0wxz7kZQQ1BT25nVmfY5h1n+POytwwyM0Se/dUqPcLHRvC?=
 =?us-ascii?Q?e6NIksM4R8qaGKPYSG7bUPp5zLy/SomFNJYF90JFJEfAJukQLAIs4l6R5zYi?=
 =?us-ascii?Q?RjzgVDTOnwYVUkiN8nMhd7cEhADLLHzxuazmepl8ofK4Bcg575eeU/hpC0aF?=
 =?us-ascii?Q?6MhIcGa0Py2bND7S4d7vV5fMUMQgIZhmaA+HrgXytLABjX/z2uf6FJ8L1Tvb?=
 =?us-ascii?Q?5P5F4HRoy3fm54lvD/xfVplLqK/Ck4izsiEMG/FpiRy+JP0TQ+98/35PT+vA?=
 =?us-ascii?Q?Y2GqPf0vJmeuHftlGNKAfjWrO7hwIHj9hbPSLrpqyoIn3BRhM8v4LNF5TLQ2?=
 =?us-ascii?Q?VhzIqijdg3bu3pxkAtlIVY8hyyedv7zk7xmpv9PmyNkDDHufXAFJ0TiFBewH?=
 =?us-ascii?Q?gCIQMnccP+5A6gSJrBCEW7b2Oj6TH5aX2ncjo/0OnF9Swu6uEGQ8ranctgqN?=
 =?us-ascii?Q?+19j5FYFPnqoHXm59kXETdsd2/VMRSYWgVdOBp+UP/O6lS1niUyddALH4+Qb?=
 =?us-ascii?Q?eYC4/Lo9oTI+s2xK2ZaUtT6XMXguxIDoqJg4GICJUPGvwVEJd4Qg0vcB4344?=
 =?us-ascii?Q?uuoexfuXKQbEJb2NLYbhz2gJ1GeRNfuzSG15wXdeBPMZ0F4yKtk3XkUtM3OG?=
 =?us-ascii?Q?IwuBv2tfTMhd2X9/gzDSIEDS/EZm6MLvfHDt8n2x86UhU0QMbxUmRFjU1s+U?=
 =?us-ascii?Q?j8G0Zbnobw4JarY0O1hIG+qrv5SqLyG7x/9M8ZuBy+LlaMn9WIB6KzdnC2pN?=
 =?us-ascii?Q?ixn9nW+HxS1PXxvvL5EGwV6FFDgiafhGv3m81dSP4j7L/l6Rc8FG99kRn955?=
 =?us-ascii?Q?qa30SSJl+Fj98zaMd7uoYnuzJXhXoj95W7qoouzex7RwsqahnNT1WlS3Unpo?=
 =?us-ascii?Q?i4reL3qDhW9Jw56vOeXt/hnLAZewWVsxxRyirJmOslHLy56RKWPMfBzQ0LG+?=
 =?us-ascii?Q?ABI9tYVVgWvyhuexw3dxV38NIuciZFpV9ig0ulY7hxgqap2ZLBIntrAfsYuq?=
 =?us-ascii?Q?DXPHJ3MiLgwKexKMD+LpAGWakLxbiX5OtIfeAsbQqnI8OuQ20d46VWzGCXMf?=
 =?us-ascii?Q?piFyGSHZlSvAyfCCPq4RZEdqfv+CiFYrVww/+jv7I8y1BdtjIJGNf541TVcd?=
 =?us-ascii?Q?F66ru1KUzPTKbnNT7hRQeCS/q7gOQpvQHLU/rMryMauvzs4739f8RhbUBonI?=
 =?us-ascii?Q?jN+UkJvWonki9fgbBa1cuaB5XERE8ZBkQT0pNAf2aL5FwONs/VtgtDJ+/01Q?=
 =?us-ascii?Q?e3Hc2C+NEeazdNJ4by9B4pYm63tqG3cvq3dSkLTNIcZ4Yb/1aNApfZqiEOWq?=
 =?us-ascii?Q?FG4L3u5bAAiu9aTZsHW9tBCkbEzoGglm+dBMrMVTWyiAbOb8emGSeigsD1so?=
 =?us-ascii?Q?XMX9/nBax0Sob35aCjVk8mhl0PUojPaH8FcZ9PjzeQSogPlOEoiJ3HLa9CFd?=
 =?us-ascii?Q?rasSYJ09wGqvTTYCKjZDptzwU9dFu3iVvDCk466D94NS8dTr3gCQk8yQdxjV?=
 =?us-ascii?Q?Nc7K5ad5k1O5nIzf6VC9XoYrWce1c9Yk+CvLjXmj83uzFXfRQTGVgXlGrhov?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed4a408-9d54-4ded-b4b2-08dac3e93d5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:32:55.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY0QoQl6fMNgRiFu+oVo06UhkHu9tFigUaPxYNRmKllYWZDfAsvMSIVawL2F5g11Ch+grurfb/8sfmqgFzrG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

This patch defines the packet scheduler wrapper mptcp_sched_get_retrans(),
invoke data_init() and get_subflow() of msk->sched in it.

Set data->reinject to true in mptcp_sched_get_retrans(). If msk->sched is
NULL, use default functions mptcp_subflow_get_retrans() to retrans data.

Move sock_owned_by_me() check and fallback check into the wrapper from
mptcp_subflow_get_retrans().

Add the multiple subflows support for __mptcp_retrans(). Use get_retrans()
wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 69 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 30 +++++++++++++++++++
 3 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90ddbd82a805..659589a51bb0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2240,17 +2240,12 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2525,16 +2520,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2553,31 +2549,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			lock_sock(ssk);
 
-	release_sock(ssk);
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 77ca5f04b7d0..0694ce6a4e39 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -651,7 +651,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index bc5d82300863..edddd7cceada 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,3 +149,33 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
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
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

