Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099896ADF
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjwcwqwx61veJBc6eQlH7Lc/GeSTcJ/jrvjmkbpU6G5WlMx/zt2LkVSQZx99bzWoR6dBLbzPKn7jcCACdj7Ct4v/6PL6MRTIAbQHib6p4KKO12ZMhYR+xcVzVD8zXnkg9FGgo5czsharPUD12zaCM7v/MkmTNB2R5PJdqb83yqd6/B0D9fBNLuZcHeZaHegbvWa6ssvrXWDKHJaWLNqeIOlVZcgaukWZNQRr7e1FKumcKS3hnMjTLZiGyT0clF5fxQOnvPzwW0gd7+PcpDD4jN++qV2ui83HvT3gs+Cl4wB8YnikY/jzKSUB6q2vFVjxsrpwSZAynL5dXQslSFHVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIKufdN0npBNeViFnS93QP5nYUae/ybS20c6o/31bj0=;
 b=V9z63zAhNT5HzM6TWgwDdCLjjVXUt2BNEatZq6OR0W32eHMUd50cVt3+Bhy56/uTL9S+KmZMK7JdPmgqtqsdy1qcjYdUMQ+yYa/5RDfO/pAZNTm1jQ9Wlk+o7JHBffRxcT0avEbYdnNUGWtxdsdOvFAIhYFYJdpUtDMyuBJWEo0/oAm363/F2Jo1ZdfrcwyyayV9kenYGyXsho2B1dtOeCn2cNYj7ZhyInwBKVoLRMqL6KZNhpW4PgEISdc8MayJip0hH7xx4YYtKWwyTQE4RBo8WbJXrugkH0K/sMlEhik+8jenKPIM3yzEFtbZRFOha6K9fssHRwN0s6C1bbT+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIKufdN0npBNeViFnS93QP5nYUae/ybS20c6o/31bj0=;
 b=GW6A/a1eciXY7UjDrg36tVSyCGO9FHQ3Rcjo1s2iSlpNbtKUxcrl7n+i8TxLN3JNyKVk04yJUKugiTTCld3x56XWmL1CBxWOgTtEN2KFFM6Aw2EjhIPCTeZhF+nKxyO7wERnalC6Jf2YKD4yFP1shEE0OoBKzUWd4zkcdMgFehXJKuI429vmOmIq8A5FltMEQIG0qsXX3d0zz0JLNwySeiisd/Pevke3WoG5F02MCALnQXgSKzctmf4EjpL/d8W0ACxc6AGD5JJmnAZCtspftlbaPUTT3kBN98vUJRsxn7w0ULNZ4atTSujOF+vbY8RPtRauNwWXKuJnJOAOY+SuRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:32:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:32:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 1/6] mptcp: use get_send wrapper
Date: Fri, 11 Nov 2022 21:32:44 +0800
Message-Id: <d0d46e3add8e22fc30d9a79909bf00d58b837ccc.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668173360.git.geliang.tang@suse.com>
References: <cover.1668173360.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1ce219-b61d-44e1-21a8-08dac3e93945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n8p+CtBwNZu2x7ozJvGaL0PWAA6s9SAk765NR72NApQOEjNN/zOGEYlo76FwHFkt+cntIwNrTHja+PM2q2cCk3tA/1r2Lx+zZ4UfCNKLeyItgEWR7z5pGX2CsFSOXiRSOXBwbRoxZIV7AVR2XXvX1TmcWozcMeWzkX8E2za0ZW3h7E6LvdMKGq8i4s0zNVOt+CHFqOsyiiF9eQVjO8c+59EuhR9XdFq6B/stNb11BBII0JjLXSD5NBL7vuMEQzNth5qnSsPVvM2z+FvtiDm0q3ITJZVrgP8t43PwcNDBfADvjjco/Yg/pDBa1LGp4j44pOkBRZw9SLA9ePcs/ccyYfG9xzjonOLvlwqhR29Y/aiKiRWrqojPnvFm/WHgARC+IxbVA9XhsKRACbTg2jxHaQNH3LiWM6Nc86lij264fijW+mHuxKIkNj4ZV3TTi/VJ6EE3osNufu8vcUxECaB6iqHqerYzbtFtZq3vy++nLayvZl6csBVAK0E4CtpSQkMsYiwMj3y9G/lkG4bBPGPGvhj9PanCl1aLN5e8UM+H2l+uDV49sGar1gT0VRNktBniUi5CmtmbJFXd82yxQzvBd5x+U4iM4tkGkPRfWeydGbNUOqei4FFpWOi+Fyx2YpQ2DwZ9QmcdQSo1UwBln1XTvFuGVYwigg2SRFr7aS3n6C3QYpX3cTONcBXkcAQMUUQuJxW/zVMkrwqudz5jFbfjYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(6666004)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(83380400001)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tC0Q136QGsK8EY4Na1Y/AOa4lvJXFBeOINCswaiBZ8vry2iTYs+Qd1b6ijzd?=
 =?us-ascii?Q?z1WG27JeLFncxSALdKoIfgOdDLZGJ0QfItlJwX3lELTW3vRyWpoDFm7xKL3j?=
 =?us-ascii?Q?VgSHOarkqGboX27jZWZOSE6lzEsybW73GL5mIi5jCNpcHiZGjz0xu2wk35R8?=
 =?us-ascii?Q?Y4jQJlkZfoq9cdGy3YixDYjAvkpWQM6PRqRlDLvuhPD51ZY9OPPdzqXZ8f91?=
 =?us-ascii?Q?OKjq701/Y2YvEJ0P3+0FeboXZOxNxgxgv/VHdCDQ63EJX8iNSmD1C5ny4+Zn?=
 =?us-ascii?Q?ssrvDEc6s/PEs1hZUUShrT2d2GKx4s/n6ar2d9yv3ihTbqbgjpsnyiAfKb8Z?=
 =?us-ascii?Q?NJ78/GRJaDPxj9mquxAXAgrhgIx6xlpU4PRmQ4BElKojC7xB/KUNlmqwTQ8K?=
 =?us-ascii?Q?Tz9drbR5py/MTF2cZWLVbpkJvrdXao6I+VU05MfZiM9lfWKv42XbBd8MPQkJ?=
 =?us-ascii?Q?5tkqmmrb2BXg7luAzzA/GVmZPo3KenJFhaM3Kh+rpJP/9pNVYmlamChBo1N8?=
 =?us-ascii?Q?fWpUqrUvjz1Vkv7PpISqVqWcdoIrOrcYnGDB2ojGhwIYjym+YAqto+e4vY56?=
 =?us-ascii?Q?N6pKjiQqW245oT11ZAbpNBPv0eDNgRtHloywWcZlSueATUJWVhd29lzKhF0Z?=
 =?us-ascii?Q?UkCihJXbkdaGvf8pHRM//OL7uFjtV3H6eJNSxDkErHKqIstOTaELCodA6SIy?=
 =?us-ascii?Q?iMSq+L76JAnDQjh7U9XmFatFS26pmML3uY0CwaMwkNheEkIP+ql5YHP+HZki?=
 =?us-ascii?Q?ww9yWaphAficiggZoradRrv65wAti+bvD020/uOPBv8e2snDe4BzYSEKUk3I?=
 =?us-ascii?Q?ZXMLWaMhRGaoLHK6oY2n6KLrhmiL64/ugF834ZG0+jlMBBZH3RdF4NUODVgX?=
 =?us-ascii?Q?Zc70HmE40p1eo5iphWRKp/icpy0ye7FzH5UNJyqmG1PyL4PlxfBdrEQak7kG?=
 =?us-ascii?Q?q8AgR3eDj6+w+Ht3gzSBpQyM/HCZRDJnQWUzh268M9gnJYXKesy+zJEe11nW?=
 =?us-ascii?Q?iHrwyAC+nKbOq+t/KSaClG97quWblR3b7OBVTlM0EZXpRNtpd2od+l3lc2lB?=
 =?us-ascii?Q?MxRVicEwl6zixgJMkNS2Qz6CBah/5dxCaIlB9ZlPt4r3cIL2W4xKBuCEl5Su?=
 =?us-ascii?Q?zOyd2XqxaKZMN8xQxrR3xYB0sjaKsUQjx+Q2eF/b0u2apyIr+1sh/28fpxVT?=
 =?us-ascii?Q?g6ELXCg00dSxYwiH9swnnp8LMz9fPlrpItrwrfnKngU1FyQH2QNiQMHx1niM?=
 =?us-ascii?Q?/gcmtjo2v1rK86xuVvrC+crSIzyansBfX/GQK/1b2vYkMz9ltumxLVkGAbFJ?=
 =?us-ascii?Q?R6T9wLggunhBlCRkNcRFqWGM9j+RnSu8duI8eFwPZOQzdOGZoPX3zZ0ElPMj?=
 =?us-ascii?Q?uoaSLW06mDUwuXTktAAe+Eq0E2g+Wyx9aIf8Yj5v9ZMBylpKAFf8WxP1nwZC?=
 =?us-ascii?Q?beEkVWFznQIxlxM99MUXqFiVUfQxxGWIg5NFABeK2pkBc6WzZTTTA1cqw9lv?=
 =?us-ascii?Q?LDxZSR39qdlv5okLK8KrpXTdrIr6d4LKZOSQRDhT7h8rFMyxOiQoXw1LFvkj?=
 =?us-ascii?Q?pxSIx95/ScpZB8R+cXq8FhSUmMcgnJgNOcJduXDlVIdJC4qmOg+A44H5qgb0?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1ce219-b61d-44e1-21a8-08dac3e93945
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:32:48.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bl+aahcnVklHp23nHcacOCU98uplgnkoTflJmufbUibkLVgj2C0Hy1ea83hJdvsBMaMqDcQnuw1s3U/gXIMjog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

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
 net/mptcp/protocol.c | 126 +++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |   2 +
 net/mptcp/sched.c    |  37 +++++++++++++
 3 files changed, 114 insertions(+), 51 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a60961d0676d..90ddbd82a805 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1397,7 +1397,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1408,15 +1408,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
@@ -1563,47 +1554,56 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
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
@@ -1614,36 +1614,60 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
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
+			if (ret <= 0) {
+				if (ret != -EAGAIN ||
+				    inet_sk_state_load(ssk) == TCP_CLOSE)
+					err = 1;
+				continue;
+			}
+			copied += ret;
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			break;
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
+					if (ret != -EAGAIN ||
+					    inet_sk_state_load(ssk) == TCP_CLOSE)
+						err = 1;
+					continue;
+				}
+				copied += ret;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
-		copied += ret;
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5c9bb0d5f28a..77ca5f04b7d0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -650,6 +650,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
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

