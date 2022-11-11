Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F4652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5JWPJ+nb42tBfhGtgJeMYT9Q+pYLeAc1y5TDf2S9uTi+UtVrjnSZajImk1xQ7MpJN6Jg3tzi3wLJqkE7+NVdPVY16QrNbhOzBIMcRDsIfefW2BGefDdvqMNYoZWfp04vz1k+m7nx7MPIPYlsC0eEYtIQMyiHt4r4KXekkTLNIXcuwqJQFhjA5fPzjLJ0wz0KugTClzI9VopL/Pi9yZX5HDN4rW666siZT/aZR4aU9y1U7LT/pSsRpamR5ceK/y+h+le64JCPRUM4B+okWohOlfemf1Z1BkBLKnNvZbKJMK+4w8FIKXSCyPEGwYnT8pcgtNmAI6AMTS3ZCLDPmf0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qywcLKzhZzQ/sV0wr6AaOg5rvneaIg5mQJJzL0la8oY=;
 b=g34dxVm4bu4QyaA7hNQN1yu0LTOnadCuVK8iQNCirrctyxWWm+BqiM0QYNSKhtvyQO+KJz0359dfJjzuPm85fbyRQQvKQk+OtBbOF/8pinmhHVzEfvV5x2gD5T0wADwQ5Wf91JFm/Hd5cnuPHhmCgzoUGti0eR5XzIdFSctRLtRwzk+tKEs4EPeBFRavEyXMLCml7vIOL7TNlmzaCVa42moRN1jh/uvdsuOYBw4ckH0FvlfcP8QSC3+USz+xZEJfEZWakVEIXpnfF8EO/EM7UNwLMVGNoRc6HoEX8/WRXld5IJaVQ3qhVFHPve5YjTDhAl3jMOr/PFjVHq20+f+PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qywcLKzhZzQ/sV0wr6AaOg5rvneaIg5mQJJzL0la8oY=;
 b=mQUnK+Z4HN7a5TXAnkd6lfEHzX5hWbkY8PREouM/cF2DVq5i8A3Si75PY3fNtWhYl+1jftFEBWb79aBHAQ07zVJSjhzXScGJvI8LY9txvZBoy1MnU782b2Zccaeg+1nfm4DHTpE4wyZ0Kr33PH0t3u5PVU4/wml3dl6JbQE9OTKVUaY7yzyZxD+Z4cicVtBBHTRjuktGU/WTVocdlDc8u+W4kfIYomR7bgOAVaSmJ6yblLSZ2HTRAVUSLC30SfyzgsYson9TIfk/PGn8rHy5XoXyWj6vWyMePX/3AZCJaOaG5Xs/YYuybXaIkai9wipfugem/YU5atJaCDyQEbWoHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8230.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 07:48:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 1/9] mptcp: refactor push_pending logic
Date: Fri, 11 Nov 2022 15:47:56 +0800
Message-Id: <7db537bce55dd84dbc3ddaf6928968d1da0b7d3c.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d05145-fd42-4698-6a02-08dac3b91734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W8QVNCorp0IGSCFSAqWl6fuFWs1yy+Z0ojqMirIWCClGmULBFw5cowOP+ioFPx/N1B+CwQSJNbvxQps7pnL2Qdk8Qgl1XMh/5uhEKQIgHWhye32hPkgocoaCndobM3Xrtgxp9nx1RBbysitHt5QYp0fK7fztUDFqBMXYrQM3RVCz2JxQQV5h6mnzgDB1Cl9mKTw6PJ6gEkJvCz4a2m3HGSQseTTT9oQewU/l4solY0CDHZYQ5B3eWvBq+NZFpMg+f0pM5CxdX8W5++y/IgldBKV7Ube8Ktaf9+Og0J+QhgE186oieo8N/cFgww8oY9B3clL4wDc8afASp6hY5EYckutc52mLdNw7OcFvo+gWefbG/iOb+bpo6N9d4dRZsyDTBEGG0f3yo60pumhZaHEELqbARy/DQf5czS+Luc+jMyXW0723QPnxnhr/Q3npz2LMHH+9+91UsjvW2C73/D7bT+9JJwQnu6Mue5QEXCwZHjgMBj7B1fUvlOPielspY+tP6nNVngUhaoW8A9ZeuOGFPK77wzQYL0kfJs1vexyQm48AyezyElZly5JKxTj980cOtIVZIRpKcsnuqZkvAASb5U+Ul42Z5YKAcOxtIIvTPbX4Ir702pg+JADlKyrGc1s2b9DdgWc27XTfcSYO6KuDwamutS7GEY2U3tQz95uffmHtI7Kr5ug9cjkMbq9uxp6SZFdaPYetLOrjPvY7g6Uldw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(6506007)(4326008)(26005)(44832011)(2906002)(38100700002)(6666004)(86362001)(107886003)(186003)(5660300002)(83380400001)(36756003)(6916009)(8936002)(66556008)(41300700001)(478600001)(6512007)(316002)(66476007)(66946007)(2616005)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ebzDp4cWbjcQkrgwQphaJWyqlbOouDdy3In1bzWbbFew1ZPzSdAlsaoxzQy?=
 =?us-ascii?Q?0hfe+QUHLD+jmcQ0py/aqA9fwgGZuplGAXnSiDpynotV4mMjQ94gOvGxtBgA?=
 =?us-ascii?Q?oVJF7PaAxXFzKhd8tVVPBQjLz02b6LGygAP/B2WfezFTUHl4Cmw5L506QywB?=
 =?us-ascii?Q?ccoTwPEbs8Z4Pi8XBdfhBhl21y8japUO5w7EzxtiTfAZT8inOa01G0l1CtY0?=
 =?us-ascii?Q?BdNzH4qE0upb1Z479Hz8GXzeAWmU7rIOXp1T6FwLMLd3RKGHOdKMNFuELWny?=
 =?us-ascii?Q?ucow+21mw7zRJ+ytlVFh2BkfIRje96RYcO3TKkhEykZ/lG2oY6QeX8vYtEkP?=
 =?us-ascii?Q?XUF2xe04eKJyTCYM1FIksyO0bVu/ekPvKEwBY0Z+l6g/M5234RCLYVTkiIuN?=
 =?us-ascii?Q?id9DOIf+gQovhMX+94ViydITnbIyWjEAT/wUvE5CJ/lou/UaYtaLGx6HBAXb?=
 =?us-ascii?Q?t5/ta4szCAdSUsWvLDX8xdxiWKqBAhoqxzPagqxV/IjO+kXCarAnSyRdIxNA?=
 =?us-ascii?Q?N/BP+9kp5W1bn/lwxEo+3+20pIJGrOzeKOOIrUJ/oo/VGijHDnd0kPl+KUU0?=
 =?us-ascii?Q?/dcATgO02C4hSbDe0lLXKW6paxmeVsQX1Ab4MwMbjTzTjoRigsBP1aYOUE0W?=
 =?us-ascii?Q?ePWyc0lD0KKdVnmQCT8I+PzZD5cpp1SxDysdhnCwrvthDJsdfYOISyswuCG5?=
 =?us-ascii?Q?XxsWdn0/O7tAas7xk0SJWQ/A73NVfXWAwVl1fwcDHBr3/g6KW361i4alxgVz?=
 =?us-ascii?Q?rBinkFToAIYKdhRepQ+PJX6Y17VnTzIzndyuS6LbmbWf7SqKsYPEDw9Kju79?=
 =?us-ascii?Q?q0VfeoUW0EwiPWK1PfcOXhI20pERwSKy5kYxGR2GG4krd1UNc0GGPGmZLWQQ?=
 =?us-ascii?Q?Vh61fCT6iXWObC2In3AclCNbGXwVrSTt9hGmV6CZwQIU6AYK5QafHskqVSOr?=
 =?us-ascii?Q?0nSoZ/amHrD8ssUlF/RwouxlW8H5Y9i4cmrgIKaFPkQW3NQ70yGoFBeToAfb?=
 =?us-ascii?Q?MW/9i9vDEkMPZsYUb1Ou7M9MbT0fJcX/eljXA4BpmvIt/lFYBsw8xcE+X8LZ?=
 =?us-ascii?Q?LCkLAhTw8NLMjoKdMKNksEwjrOW3roQl78CHoU2RZtqI/lyzj0MYGsZC6B0n?=
 =?us-ascii?Q?jQ43iVKGnSjeZcGKCG7rI9C3MTT2Qdh8rOh3Aqqz4y4vfWq2c5ZMw7/YrA73?=
 =?us-ascii?Q?GOVt1o53PDCvCMf39xhV1Dy2Gv+xrmvt4iLnZcraL/9JEOLA543DQauk9NJN?=
 =?us-ascii?Q?3qKoo0tdh/wztpPF0E91teiL5x5haw3gujPkIAJho5JgVqW/Vjzf/+Oxfrzx?=
 =?us-ascii?Q?r8MQNyaBV8Y5a3NfzUSyfkXH2o4oxzieE/lLMYrd9OQ5BezbzmNZjam6H+Mq?=
 =?us-ascii?Q?occUSdi+cCETIhBebs2wEeozO0PMWd31jEKX94GXnQjL11rKVXo0JjOmwfW0?=
 =?us-ascii?Q?6MY9xy4yXEHSPnRsB6zaFLi3sr8f9gY6JDOg0TdjvOl0I0dVqZ73JLhMZIpr?=
 =?us-ascii?Q?c7UcXSMo/N8MBAEm09eOBT68Jfsqnn2dS3diuT1piQbfo4DUPVBwOyGEO8d3?=
 =?us-ascii?Q?J4MZI4yMTN8DH7F50mhmolzveEmN+hyc/WJRue/E0BavG60AN706IJoclFeg?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d05145-fd42-4698-6a02-08dac3b91734
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:15.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYxBDEJCIsmRYvv5lbD3xTj86IKB799WuO8zEWDM9Dk4qFn/cQ8OgGN0qYVCh5o60uQ6dJobasSyOYCsl3wtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8230

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
 net/mptcp/protocol.c | 154 +++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 71 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1edb8a03d7fa..99faf7c1a548 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
@@ -1528,57 +1520,86 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
@@ -1599,42 +1620,33 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int copied = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	while (mptcp_send_head(sk)) {
+		int ret = 0;
 
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
+		copied += ret;
 	}
 
 out:
-- 
2.35.3

