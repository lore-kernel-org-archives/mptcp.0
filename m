Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140084.outbound.protection.outlook.com [40.107.14.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B2323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8vnZqEjw6v1PPsMUNiNpJXFcZejOYgtXJOd7QMabzv94e15mz0clbWeqVEpBkoljGspF6Xaacz3+q3jChv25imIeJXd1dkEzP7Ehh37N0GrapL0WMiLbbahCcUW9XH/MzyRKwkhdJ4zzZXIJBO1A0oRn2QLVtIabZEwJlB97APdaPBnBmmzpLWp15iOzOHLXH4pEsUp/MvNXLXZrTHiDIDjztKDn8J17p+mLArzWZxmhKYUlkUukr2wDxlXqRFahS9IHdoKqX+2eDt4TLto4uZ5BIWY4ldenPn1uE1slBfeduK8OiN8pHH5HoeFPqcDcZFVGjobGOuFKaFNiCg3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IGxImuAmCDz0rJsvTJ/MkhcWPGyMZESZNzEz72LOag=;
 b=JZiUoZU0cf23YR7GRwo3nu3hy+OEtTekyoCJpsmVbLLgCKQVb+yLQnprfgl2ZjZnKn/ExxGA0wjo4atVq4rumvvxWCn1y+C05jtAM7bXM1TB6Pun9LUhOUpwgZtMkKmXh7ucQgL06bHvsBMwc6OXcWllfzZCnuKfa+X9aiS9IxRGks6qjJYV8FDw2wEVhz+V2dr/gmltAN5Ik0BTyC2SslK26nvQ5UyKoRwFPSOLX7hIcW9vS5YI7gNJHSj1emAuVLHfTREc6jNHP/R6Ci6QNKNpfLamCqyEsGcyIrcYJSa8EEFVBJavHP3e9LnQVIDZn6NpIbq25clWr1sr37e7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IGxImuAmCDz0rJsvTJ/MkhcWPGyMZESZNzEz72LOag=;
 b=1J6CMfdiq85RHXAtWgg8xY3/C0NCKy/JxYaQFIUaFu6oR1fF0DIfITp43Smomp1UlktiLSpN566bJmxL9gojKBQIaetFTil8jU5hir1uZLfuK1Lxsd8FzrcUPeFpG0FipapSX2hyVyw4NCtomfb3+3srWWJYxz7tzrB+ytZK9doeTdl4FkIyCQKBNRSjS4v4s6pOY7oaJe6nrcGt8NAtr8PJj0XwMm5IP6mjP8Q6st2hyZBVgzjc4C5qETHjJ650fjvG0RsEgiiM1vF7q2y7wtW53xSbuu/+x2JBdeJMzkGMbskcle74wR3kW2D89lMKQON7l1oTqyEVpeYwiGT7Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8924.eurprd04.prod.outlook.com (2603:10a6:20b:40b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 06:45:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 01/15] mptcp: refactor push_pending logic
Date: Tue,  8 Nov 2022 14:45:00 +0800
Message-Id: <1181aec1a188fffa83057b04a006687933bd5018.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dd3473-d3cb-4949-2ce7-08dac154c6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OEJ5R8+l0TjlNNLra5O3cWYCYwUWUAkMLKN8f7A/fsDxAQqPYcc8VRviMTQ3/6N1aJugZwnXLUExc70wCC1cg/XjAjBLu7ubC56PlyqnGe3guC4gu09GNfnFZLzbdCXptOzPeHngesnvVc1ZFeJaakpmZb/csCLZM37A7P/YtkQNjnqLUUDQoLraChMDixZHAwEyBKrU6871bNabxFfRcdoDL+XTClxjOGJP0H7KzN/PhSUZzedvQdD3TMDjBJ+YhQ2klMZ0fqLVEjQJ2euTH+oitpsnyb9KKM3KC0xfzfmQXFZ2tH0Kjzgk3UXLXQVZ2WEaylFdEai+CP/h56RjleBPW5WLnO/KYmLMcB0XbkitrnDdyAXTKxUEx/jVk1FTqMvdaFdZSO9RohFQNWaWtENn/5qtURQigR40klNCCtWlKZewnesGu850FSMdUREiG8PdcfA2vda4YUy3a3mPwZ/og0B+61dgLQTjNsnGxlF0XsdlUYfGXDLLcBM7ZmeHVrLplCjqhbmrnB8DrJgrruu1aL96ZcCTkWtVc3ZlodJESTyjsvvAmGwWCB/S0p3phTy9y4aAOpkk1vLf+O0Rmo/gUXDyV6VfE8ea3Xfk39WYG8ccTTzGg4pNRE596CnkRUyV+t/pxad3E3U65JhmTVx0DOFPSBNhOiUcFjWiT7UD1guT/6B1NqAOWo3vtlS74mygYyHeW0xwowvmY5J3tuL4BIbkF49+e4TgBun3Pb1b66U2NHDKfw543jqU/P5N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(2616005)(83380400001)(38100700002)(66476007)(186003)(2906002)(44832011)(8936002)(5660300002)(86362001)(107886003)(6666004)(478600001)(6486002)(26005)(6506007)(6512007)(66556008)(8676002)(4326008)(316002)(41300700001)(6916009)(66946007)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+PxUVAFabVHbyVFfE+B64cOc+afmy6Cr3OW+e7RMuuo/Cg6bB9THx7xZhIz?=
 =?us-ascii?Q?Ud92lE+reTI24qL6mKgNwRCdI/Lvf43qW6/H1WLMosj17DnxZbFpdxWNTwGt?=
 =?us-ascii?Q?VDwWLTqZw/DjkpQYxrliGbrzoij692tismdr1bBbdln9Oh5BdLVNnP2d51Ti?=
 =?us-ascii?Q?PegFe0vjzFCywDgZ98vONOikYGaLYuy9PpC2wGxdvtB3Is5+oDwlT21bwt0W?=
 =?us-ascii?Q?ACtSYIKl5fPlVFvBXGVsmAwvMzAmRxMniVfnLfsc3iFvlu7r9xcwOHJsg6Np?=
 =?us-ascii?Q?gSUgfNjC5FWwcmFEdyj7hkRoiIBqlBNYip+yT9bqZrOd0tWyo8OatpUTVgNV?=
 =?us-ascii?Q?MOXOs6U7mxIoq8pIueuVK/gp5YAInywS6pGU+v87z+suYbTJpxYkY4ysIw9w?=
 =?us-ascii?Q?S6z8CENlOpz3lKw6GMdP2kk0yqRNRl0htjVWW54DmzrvTFzQ1NkANH/AvcBW?=
 =?us-ascii?Q?2BXp+IjxVTlZ01UCYR3sj6FhFhjBGFGIVve5VajXl6yOGaBC7WNuPRXrtVZL?=
 =?us-ascii?Q?0ujkkwT66lCT9lDZ/VNH7LtLx+FuFTY3x+AO7xEhOpvTHcs1Wkz1KVoHlvUK?=
 =?us-ascii?Q?orSEB6xCRjcvA1akYmH26OZslLTs2aphVLqXWHF2Z89wQqF6sIdA5gEYU+Ud?=
 =?us-ascii?Q?OtfI3zpDsbFTO2g5RcgoaZe7YKBxoOYq131AsAPpjHJu3pnrz0JT3vm95gzl?=
 =?us-ascii?Q?Vfu1BAlhthVn4grkwGvWCpagcrsW6u6vkNKOEdcCFEw2Xpfnnv/4Uuxbopmt?=
 =?us-ascii?Q?99gM0yN2CuGALMutAYRepvdX9OxH2wsEQpavhDbLrl0V5rKN+Uk/EyKLEN7s?=
 =?us-ascii?Q?1RqeBmGBwRfNqqXJ9ToErIX674sSGJHi372hmReGlPoEwAsLiU+XBJLNN/A7?=
 =?us-ascii?Q?LFk2Wd8/NxtiT9mRSmN8auhE4EfDRnlC+5Shr+ErE2LW0AF4AnyRzrRNdW2H?=
 =?us-ascii?Q?be1nnEc1O5mtuORVaSCeE42nvuAb7/u4DBNOaNf5/IryY75ngJcnkj6nXzqs?=
 =?us-ascii?Q?V8HihR2PBQ+yio0D3mCxCHuvY8ghW1sQ3nrLGnXqESmCX7sBnU0sG6gyGhMd?=
 =?us-ascii?Q?/N899Ru1rXgp95Drqec8UhR+Iss/ClBzunSRSiUDvoDzPqgXoS3jIH4CfqEe?=
 =?us-ascii?Q?K0V7yHSXXYh/Ohp506v1ht0nQxEOuN5HvB6hixLsVM3UTZQJkyn7Ogygs+Yo?=
 =?us-ascii?Q?6xw7JgVqn9ur3j3r25pNzLxpGzL8ztoKAnNgYNpIC54iZyJsMsarVWDCKqMp?=
 =?us-ascii?Q?bizHi4i+iEYZYXVwagFpE4FPEo0XUp0Oa3dNPx5wygtocir4exoQTOUy3yNc?=
 =?us-ascii?Q?cnSdb0qoZk5vFPCo5q4h4PDXHjnA6wUVY8rKoLEL4pVBCMJr8BjW0L8M/EAq?=
 =?us-ascii?Q?29xbZYdkqt8hC+GN3v0IdxtlMufhaLBfeH8jn0mnyvDVn8Eno6FmAwzi8/Qz?=
 =?us-ascii?Q?b2RXxKYTd/gX0T8ZcNPCEqimSq7y9kHjY+RdSYRAIIpfDBi4vg6v8Oi0YaiH?=
 =?us-ascii?Q?CuxMEWswSX1b5JjowV82IoGfFX/Hfd99Gip5WKHy5A14m1isEuXt18/30/Z0?=
 =?us-ascii?Q?6vByq2XjgKlyx8AnwI09GQhtVyZmUNr6XT4K1v+A?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dd3473-d3cb-4949-2ce7-08dac154c6e2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:08.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJuy8qcCSZH1G+zhUdBa5nlampDOCbOeHi1yLZv9UNOCpJP0IYaeodE/iC19amhwlY8uu3wOJ03oeilO+C8lVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8924

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
 1 file changed, 81 insertions(+), 73 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ede644556b20..1ed23b1e6c51 100644
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
@@ -1537,57 +1529,85 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
+	int ret = 0;
+
+	while (mptcp_send_head(sk)) {
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
@@ -1608,49 +1628,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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

