Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9F7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5AO9JNTQ18HX/is6XYeiMufOy5UJ/ry56neNzS1wQYrH4NZlsqpdnghT6uNVb+88G8pLToo4OZEB1GB5M8Nf0JbWnzqXzg9hUfG2zyFTSoHlCgOYfV3ifNGgApgC2Qhpx1ks3JlzSMVG+DDhtN8C94xDtkDko7NPTbLF9ivLsxXkrshNfLueAEabnTmaOYnJslurWJDTxbQsBLbLquH+wg+0c32U4v8AHqyecBdCE/suvGkYqxv9V3Yu6JC4f16imcO4OOZhAWQTkL9ZMT5ZXQ+3mg95c8nADDUmpH0VEPPD1pQzCIb1e4//My13bB/TUkkUJCBI/IPXbTaRcUgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwWh19PWx1kLdKRMug2RAO56cMjXnKqZP64nML2Lw10=;
 b=cFKSCDP60+1Cr2KCWMYBhHw7isI+z66MDnkzsBza/CiDzoasWpQ/MiwG8QWAqSqoH3A97JIS5+TaLh173AyUopiHujDDVg5XhH42xnIUpmzdV3YSBvPrVLjcEZj/DAW2FtgNhAw8zOXy4vbM0CnNC5xg5wfrLSGM6FnKCANgb+n4FANcYj7jKmSxSZHV+uiWoDJW7clIOlDGVlxSllbkhqtpH7iKEqp0rtwN+ECNk/6U+WcnKNE0tNBlTPef0hMp53hEXpPn9QldF17TrIoubYX3xCYALp7ECkwjxqXzpUMSrudsly0Qmgrfpgu3x1ikbiqEbFib6x6Yd94FmpNW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwWh19PWx1kLdKRMug2RAO56cMjXnKqZP64nML2Lw10=;
 b=IRRyz11Q155ts9ywiqbS+pw94LqPFKdoxgcDPOmvgwNFAcrPVLTO7W4uI9vtwAFI7U3J0XLVb6lTchP8EgHwqZW33E6gPEYXEltd0NrcXBamPUrmMHwalE4dEj9vQhUjJ1eTill9LnwJehdBKgPbO44KiNluuFhv8YHEka5IzgQUcXeo3wIDBbiSzIQ2Fv/aq6eerk3855iwiquUZanuKcnKW4Wszag1p9DESb1E7giwl7k1aW0HZbS07becQXXTgMtfY9eeTzbeYjjm11+2NhsFqrV5A75Wn3J/xKIeYl7MiAvOTnkKTXo9NMd8FrtZ9B8RbjcL7QfwX3UkRvvhFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:04:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:04:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 01/15] mptcp: refactor push_pending logic
Date: Wed, 26 Oct 2022 16:04:10 +0800
Message-Id: <894aeffed6f89d1f9bd6e1fe459226aaacc0c5ca.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:3::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d9e927-1bee-4f53-33ee-08dab728be85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xPRuElRN6Mk7Iu92rs9yOBesyO8iH2vXtz+r0QxscEBZxGdQ7uIj7nzx88d/CgjSb9bKRDTVyS9VxWhMput4+bpFQK7igZTR73G2M4aFTBHMgipUNDzYEnx4Siq8qiAXfFl/FM/4r93ReKp0/WEaMGfp5kxIp8b0grrvjPjGDhPKIPxA9H3pRlQBWLj1VZlubOu4jPfkqJD6RPucnuA08YV7hwjFGfgZeELg5N/WTr+JRHWKrHmb/q3E4XNQe4bscWTyC8nvAbiTfbv1f36RMUfEkA0NhFGj/SDc1DQUubcxzzezjYccJ+IkEyZ8V4TnTShLDI8t/NkqZB27HMdBzKKc8AMmgYKUeMyzAL1PiFMPddIWi3zMufPSxlH6tX+KiBbjpdCfUPCA9lIH9pZapRwcqzNERHKS6W/2bpiO8N5vpE8bg3Fvx3bLfoej+SMRKO/s8r6S0AIA1eoKvnZKNLP7bHOcmCMvt9cF9FCMu1OCY/GHXB4LpscvyNB77mZp2r7UkeiTgT0ucr40o09cZydGapSjyD/pQyYSEodlF6Fuc1bMviIsE0spodfjqp1KgKkMJUp0UsgpRqYcbOz0UvfFC91LdwM+jSTyeXEeKvDs0t8P+MHK2OBjZPn4sALmZkFFmCgPdSX8D27ygnGAxKOplMZl80vO4SkUWpdRnxkArqOb/6bV0fN6hBRegdMkQAqtiZEW7dt6HhL7MhyKdYp3DquK18Hk07PoudDjrv20vFXtmtWNQJhJq6aGzf07
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(36756003)(6512007)(86362001)(44832011)(2906002)(2616005)(5660300002)(186003)(83380400001)(4326008)(6666004)(316002)(107886003)(6506007)(26005)(66946007)(66476007)(6486002)(38100700002)(66556008)(478600001)(6916009)(8676002)(8936002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RToTPMFT7NjAQtf/5hq49CL829WRlOonA1DwXDrHYXbpXOPInvqZE5i2zJmh?=
 =?us-ascii?Q?oSE4XnPVcqagiyRyDafGXJ7N+Qr72XojgWdNsHYG7QTBrq0Oy/UmrCDjEJxK?=
 =?us-ascii?Q?3TwIoI5ky2vxf5Wlw5czBit6XOrH6Xzdhj5t0tUeK7lQrpWdai5YmYWzV2SS?=
 =?us-ascii?Q?e2ZQ+eBIJODZBwbZeRqrUAU4l6Teh/ott9MpdSvstRGwRKwD3TQuZgnZd00t?=
 =?us-ascii?Q?ADDg3Fc4zcoK7mWrFUliqwaExDftUaceioXZyTzfl9UhS3ydhSPnPeoEWs6q?=
 =?us-ascii?Q?lp0AkzmajzohM+2+Nt9M56PZDiUgtXP/jZGCkMMh0WXtF0/rXtI65CoO2Qmg?=
 =?us-ascii?Q?vWeOhOuQTnDIo3wJFJLbDlXZR5mYR90ANkWAw+wdef59M5HwXu6cymeJk9t7?=
 =?us-ascii?Q?dS910sKl/VA/G6jBITZ66b6IHbRcxM8ITTYjNUK8PNFe9mI944cnQJJNLkiC?=
 =?us-ascii?Q?Gw+pG0arJa6WU/7GoRUC2+CSnpIZ9IouczOpBZSKZELmcHx7/sT5EqELliRX?=
 =?us-ascii?Q?h4v1vOBJ4mIBU2m9Wq5bDDQ+SlwCKOkcTgATAMwRxb30yv/3qZZn1tbxvXxW?=
 =?us-ascii?Q?vKtgc5JkiR0zCvidsO2gyLVf1+itpK+7fectwg5/7BoCmLp1nGmwvYg4wBvM?=
 =?us-ascii?Q?UdLlA4WU1RyT1lU2vGbQwKiRqVDnuBSidZcyp41ntopGzEyvxUHaWYGXN9ot?=
 =?us-ascii?Q?ppG4uLYWn6XwBhHFepTriIotxpQfs8doolS2fDl70gwSBjKYVHCulUk3VQJV?=
 =?us-ascii?Q?RnmUKFDBph/noJUJ80QLrAoNPz8/1K03WSg0FV8z052MWNgg70++PCaV6Hpb?=
 =?us-ascii?Q?C8a71UhTrmPZ0Jy1sCZXwcDhooB75PndLgae90T47jfpmgeygR6yNaOTFR6I?=
 =?us-ascii?Q?YuiMr67qGjz5sL6rSGMjsPskKJLDpMKDMfLq86F0IY+AHrWch5M9Dyc1RfzA?=
 =?us-ascii?Q?RVF1feztwPZB5XTfZFg3dAYXb/6x+uSOocWA63PPNyljHqT58Y1sS044q5MI?=
 =?us-ascii?Q?0Adz04ZAqdwogks8QhLOEmStdmDXU9gaeHKvjHiwyEgeZJg/UTuzfaNI419D?=
 =?us-ascii?Q?HFgmvG1evudqdHwdwbgzdk+za500GRxad9R8/RCUSU8Sk0iYdhIyXjNdxKRD?=
 =?us-ascii?Q?8W9IEcEnCgBjjWnPMhGOdvMWi3aT/468M+Y8DJigIU9Q4mE9f6duBq5yGeZG?=
 =?us-ascii?Q?WJr8DYLugJYyxh153zpEPTKXV8wPZJy38jFdOZK86FTmLa1W35op/44hu9mx?=
 =?us-ascii?Q?4nuGdjMW6UowwsNJvh5yJMlQbmFAIiEH6j7hoPs9y7X1L96yYI7jN1GG/pYy?=
 =?us-ascii?Q?+0RjQNkRrqSx/QM1XxV8hgovjRnNE+lczNAd1mPZbDB2U0NDSHYNX5SgW8mR?=
 =?us-ascii?Q?QhHuwnD2n/PYOtK3iiR1v4GC0waBeX2jWFQEFDlXTydetY82yzm6lEXKq0zV?=
 =?us-ascii?Q?pU5n1X2n1fkTqCQuGPu3wtx2q1o0tZ4TESOgyevWys1u+ovqj5zRfHM+dc60?=
 =?us-ascii?Q?+u2GKJBX3N3yBwz25H9K3yGK8Z0JdZPMw5neYsEJfl8xGzynp5C+Qa0R3LHG?=
 =?us-ascii?Q?ixtxU31HOThH+5A/f+405Fq3zTEDWWjhcsw66tGq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d9e927-1bee-4f53-33ee-08dab728be85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:04:45.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY2XbUbknfCRiVJ0u1HlE+TZnMEkPUtZGctHCfeKDxmKRtuDzRWDnd80Q66zeGTVtzsY6oV/HABPXAv7SSJbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219

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
 net/mptcp/protocol.c | 154 ++++++++++++++++++++++---------------------
 1 file changed, 80 insertions(+), 74 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cf44b5ef937..71a6f08cc87b 100644
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
@@ -1537,57 +1529,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
+		.flags = flags,
+	};
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
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1598,7 +1616,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
@@ -1608,49 +1626,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
+	if (ret > 0) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
-- 
2.35.3

