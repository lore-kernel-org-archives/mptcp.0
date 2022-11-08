Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB206ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQeDwq3o1CKJncBnRFLF09/VzzNKqCHaLoiF4mG1Gf+TPGQmrirgzCx8iSK2rv+W3cWHhgRem01YV6Ty3YOaHnwsZ8EnA/hjBhoQfJgAdn4Fr/FrPFph3HsemaH5i+UAVanOf8owOw2gtI0SoqijBTI/zeGRXuqSs6CqOU7bodLXCM5w7H5+pGXSK+PLhNBBC+DNwNM4OpYC4lqyhAYAdsyPwj/B/H55hiMSWZy5Hq5eDQIeWxnl9wpHt6Ciee45iaMNmpssdgHQyKRUOnFgH0CLTS9VAw6aJ6jADbUB9gGI95oO59VMCE9EfWk5G71lPCU1m0H7evyRbD7c5sVfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52+oT8AIRSG3AzGv1XxuubPS7EHB4M/zLvKNCIw2bpk=;
 b=jhWfJciQ8CSDdKbHq2/LR2A0aVsINyDnpg1Ry6OcGkh4sPekk5m8gczj00bI58q45R1yZapXRlZO8/CKpdr2VBNAisovA4VbzKQ5VCWKC0V9hpmCehc+XyJjg5x7d4tTfhwA+YFcaC6S9BoXNcheU1epmKCjpBSNpez7wO9HuR1YKMYswrpWGRi51CPsASEBXt8vQ9a0vxp6TQeldYw4W/7qJ8kldHUkHUttjBEViSFF/c6lrs9Y92z9kaAybSrcGQ5atUE76WnO/q/29q0hsxFSd5jsYKqsHbPb/t4eMc7wnb0oMcd6tWAaMpEqmQEwvUnzSLh9g9oZzy5V1azsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52+oT8AIRSG3AzGv1XxuubPS7EHB4M/zLvKNCIw2bpk=;
 b=bkrdHJEAVLlRyPBgj9vCZ8m1NjarZLAJscKgO3FPYbzu6xhgXZMHPPHM6cn2iYwc55CvY3sDJ414Fi51hrHowfTAEHmqJbzaQnuEqog/uzeixm3ZUEBijgg29ULoLiRzA18bZHo6K+o4rep0bxoON1rO8yEYIeTbRa4o3rFqIxFUGhv1Z4gyXW5VGO+4jKc41iyrXSlP/kAeFOBfWIqaLsNZlmfQPSu3WfthCc9Fv25Cc/oBFSGUl6TE+CIADEFNrT4aLKr3PJ+d4Rl5wD7X3uJFlXDE5fLl7stQWCoYz4a6pgpvYyWXiizVbP2vteV675NUv6Y05Bm/LtudsAH5Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 10/15] mptcp: use get_send wrapper
Date: Tue,  8 Nov 2022 17:08:32 +0800
Message-Id: <262f6ec0dfa2ffba15899460df4676dc15d1bd62.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 5877b471-a63d-464a-c985-08dac168f989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZcA42caB4Enf5Uk4u4SqZb8v2DNHIP8lFOKVRH/XfVJIfWpRvJ6FrWuDOmZ5BJx6EEEFIqnRHDmoSKQ/mw1IWCxxJRl9RIcxssQ2owHVaH3RuMMf2dkAfo3suYrFdCgGhBBPzHcmRqbaPXYJjPc7gbaaqTDX7xu8f51TUMFBlwbAxbbd5UUOB9c3DX5MZp3LqhfzncCeU4SxSMPOpCrhVpZSCersBKUsAMpr5XZQ6/POIF/jVfE9yT8A/u4RlTyVd4gNT7xtMHJVNIoBghsN2UDEsUR/jX/2HkNoK2qbIfYgF3XAKaT7yGPFEFCPW5fJv1xmLrimdX+AxXmioIZPG/L8Aoa9ctVHTx2zO4A2LZPymMkmEmFX39CXJ5jNc6XZnN6S9bDTrRcDuaBJuMJtJ8PY4BC/X5VszqaYkTHbLgBIFpSXmY/1K2MTyNpNmyOq7+n1SDl73qtl94sTLAfMYlSR5a9HXqXohmrovudWE1WJxT0FairTFmAHKSjX7V9PmjAfyarQKNQmpNhHpiEng+iFZ8mO7C7FCmgXv9CDHSSxrC9p2zvGK0ZL4bsm4F0rOZTNCjf+eKqZq6oAaRN3+JFLu+4/UCK/HWDFbhS7xUKUEIVx8HNlddktGoEWxUQQuSvwuecW7ySjGzGMjBUAV9VOmZa20k1Zj4NpaRQ1zvT5A7xI5/VFCqVoYEuBHeF4MqaQ2UnET2P224frC4CeVlkEdoy8iNi2PbLB1ouCDibBgQy9SkDFcwFXwOhCQrn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(6916009)(316002)(8936002)(8676002)(2616005)(4326008)(186003)(41300700001)(36756003)(66946007)(66476007)(66556008)(86362001)(2906002)(5660300002)(83380400001)(38100700002)(44832011)(6486002)(6666004)(6506007)(6512007)(107886003)(478600001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTS+2CObTRa+kGmSzFiy0RaTMoK41DjDh5tTnN45u7cjcDb5I6EO4XX1gInx?=
 =?us-ascii?Q?0qcfG6tTbC2SJLkSXhiX924QQEkWMW3ESun0M+3oVTVrlhTF48umBHZUft9w?=
 =?us-ascii?Q?ReKIVa09HbStSW3PNk5u8HzDZ9DmVkQRxItiqDqMrjTqrukNACaj3M689ZKc?=
 =?us-ascii?Q?4IHGNkoMASh5uo97Os3lSE/9VoNNBUphX291dh/KdZ1eXsd096e6tmN6XCsW?=
 =?us-ascii?Q?Spa39h0Cd7IsHhmgMrtDIvSA9qQlIe6YJDnQ5o9quH/d0vUa+5xxjbM1l82o?=
 =?us-ascii?Q?Fe/SY3ubaefP5a+mFmNSaE9EIokDN/zvUiV06lhoeUuNPEmonCiWpD44ymKW?=
 =?us-ascii?Q?yjkHgfIyvo1GvQVqLXNSpXZKKgz4wYwR4T/re8isNbV1pRZ1NBLHrcqxEG2O?=
 =?us-ascii?Q?kvEnx+xFQfCam79UEtuEzq2NRqyef2pZzD5RdWAa67QYQiXjzmQgMVOO5H19?=
 =?us-ascii?Q?juZnXouFLDLn5nj1BaRrlWKJqYRyqjUVz1W7t5rHgARTMHC+3F3Jyrd3zR4U?=
 =?us-ascii?Q?gtW1uT9tqVf6W2cbXot7bBCHN2TMj30Y6sJwi4DllCHRRbWC7u53ZoAMK4Lw?=
 =?us-ascii?Q?ZwzC3uLY/QIB/OhOqt6aS1Rd2hTjmKwzMKLhIGQpsGes/FY2r+e3nj5RpSlX?=
 =?us-ascii?Q?fZB5ucBmcNmv+ZXOakmk5nm/l0U4OmftqHOSl1W0B2s5WmZTeFJDQkLj4bu4?=
 =?us-ascii?Q?g2QlVsGVlVXV+wgi5x7APneVsMxw6er1kSu0ojTsdHuGw1ArfF6KbaRkM99Z?=
 =?us-ascii?Q?RiwSvc9uCd/7XnO7Tiq7+JhtISx+KAJO6ldtfWsK34bkWK/cvcAbIHCaGfW4?=
 =?us-ascii?Q?4oBEnVG6gry2Tqt/QpArEp6qRSDmSAYQRfxqjmXdzLvHU5qMHmb7ZJ5OnHx3?=
 =?us-ascii?Q?zosl5BN4s3qA7YHfraiaR7S4fO5qv2ARZDRz3NcXdfIChsrmwevPRC43wa52?=
 =?us-ascii?Q?8arc88yk83wetkK7fsYIW9mqTOCgFhCYdgK/dFlUYJSPt0NjUddvcf6zWQcn?=
 =?us-ascii?Q?EV2mlSocHlYNbDufZe270oQGD2iUveD0lqaB2I3IPpO3ALN7f+hJYXO+Hbdb?=
 =?us-ascii?Q?yE5RksgNx1PY62t4ery/ja6i30lntFILmTRYrEp3qnA9FYgOBX1Yd9RpQYiE?=
 =?us-ascii?Q?B5FsRbhAkHkPQe5aBD6P7nVrvrfflzc+fNnbWv2c9e669KupX6M4T9U0G/+Y?=
 =?us-ascii?Q?n6xipnN2cNhsX5CMXrycrfxMXJhaj25PVrevRQBUkboZQZQI6GWbCY3Aj0q7?=
 =?us-ascii?Q?jf7sIOJmErC/JKR9xy2N8FKLa0MD7rSD3PT0Ob63b7STGmu6uhuci2Ng6Oxw?=
 =?us-ascii?Q?8bi+vf6u9+yznXd2BTlX4021UP44J5gjyIONv19lQRNyJDc1lfx7MomedKBT?=
 =?us-ascii?Q?Y7ZI1mSUBEwZ6dhI9gr1x5+0l1ynw6yq8d+5H4V45GZ52gioM33XZH8TpEkp?=
 =?us-ascii?Q?FX6vcIANfccBm8/uJtTEznlcTe+H66i2hNf84JAKXc8bivevg8cXk8Qe2j+k?=
 =?us-ascii?Q?pAzfOmAYJ2mqYrKBKh2RQf03Q7lkcg5Tting2XAgrvAvM+X9HTqzlsnn9+Zq?=
 =?us-ascii?Q?j3Z2C2c8WavK3T8fLzD5+DRnbXeeeuxRd0qjqRmD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5877b471-a63d-464a-c985-08dac168f989
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:43.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbVtOMC5kQwcFv+gtLqOrE1y+PpLdDD5+JXoxqTmb/cFoPG+uJP3q8u3tidN5DekWokKvfpkvEdwWknWHY9abA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

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

This commit allows the scheduler to set the subflow->scheduled bit in
multiple subflows, but it does not allow for sending redundant data.
Multiple scheduled subflows will send sequential data on each subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 131 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |   2 +
 net/mptcp/sched.c    |  37 ++++++++++++
 3 files changed, 124 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d7aaa49c64f4..5bcadb36b99b 100644
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
@@ -1577,42 +1568,58 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	};
 	bool do_check_data_fin = false;
 
+again:
 	while (mptcp_send_head(sk)) {
+		struct mptcp_subflow_context *subflow, *last = NULL;
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
+			if (READ_ONCE(subflow->scheduled))
+				last = subflow;
+		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
+
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
+					if (ret == -EAGAIN &&
+					    inet_sk_state_load(ssk) != TCP_CLOSE)
+						goto again;
+					if (last && subflow != last)
+						continue;
+					goto out;
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
@@ -1626,29 +1633,61 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 	info.flags = 0;
+again:
 	while (mptcp_send_head(sk)) {
+		struct mptcp_subflow_context *subflow, *last = NULL;
+
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

