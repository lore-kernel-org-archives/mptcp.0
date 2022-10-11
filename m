Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E723207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmFq2UBLQ4vJQboJKH9L5Nq8fUxmvoM7pUUh7xg5NdTdxriC236XJoFHBhe7rX+I6zK2UIJXtmHlcgpOsHzQREa9S7h16pcJGax25MTQDFm9AQATAq85e7J4NhMI7nqd1L2zccvShHSV1jjg1UYDQSClqQoPAoND7M9D5+BBIn4vjxCUtGmmt0U3TeJN5hNEvjq0m1K63NRPHx538+9vnt4gAG7HJD5az/c11NQHCdQCnrRFQVff0AJa1UZuH7jWovNj31ZghvQDjp7kCqiMuXHEZeaXnK1D7wlNT41m0ojJ4EuECcBipX90/nap/B8mvACOgA/NYcUNP2LTkZggbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J1ugRQjnFj/22ve/ERiELUmvDgRKvH/YGYu/AKffDQ=;
 b=CXdRqp1bIex1R81dGr1SFPDfyj8S9m+M8b2YWdY8xEYsq+brfrTJTvougzv552DmFf7YHz9Pn+E8QZfzCtM+4g0xYRjdKayB88qZ52zp50Ft9fE3kCKIhU6eYODRb4l3cKtdymg/xDbtADUBj6V2FsCs7Pm3ZOXXeKg6cYp9nq9ZF6RDzZBYcfdrAkD7RoEJcHWBeXNnVRA4EiUJkN0ebUMIwvkBJ5CT7yCB+rEEZK3H2uLp4l/L1unecw6mjyxX3+X2Q68tlqP4tqoaSO/RU2WgAoh8vPCQAN8LkGlQoWu0AZNQzVuthZx/Lvqr/W69kDtnVcyHGG3qWa+sszVSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J1ugRQjnFj/22ve/ERiELUmvDgRKvH/YGYu/AKffDQ=;
 b=pbTr5cTLoJZYicRcyXWZrZPrQdwErHbrXDdYtLbghN+4cj/lk/mjnzQ/f206A1mry1+RyPSfVzCJ9vi5b90dFnuZlZvmf01V+AWBkHwxNlf/QU1O9lqEPKExre+MUHseB4bpWnWU+FJ4AW/gUFLO7kdVF1XXXU4JC7TSbYlt3jXNSLjEtXycfCeJIRYD/1A8C1eJeRfcxe7KdWPmkE8S1N07VKdKDwXbVCY+GagFbam9MkYjgl8oKBzVexN2qkpGjJb5Sc8c0pXWpNn8nd8O6N+9XL2DzALmVJkG1kCf08OH4cESpoBg9ua/J7AFOTUjO0CysmQE7RfY+2f0jvljCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:01:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 04/13] mptcp: drop last_snd of struct mptcp_sock
Date: Tue, 11 Oct 2022 20:01:28 +0800
Message-Id: <20221011120137.5475-5-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e93858-7a20-46da-d9de-08daab80592b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V5F7qGn2Rxk1pcSZY66ixOJ7yd3xY6lCkUuGi/dO4NMN+QBVBbdFpu3DLsggN1QoGp5cCLM1Dy4s4kjfydmKdQoazg8HpJLgBfijlwn4RLTkE0MkonIBWrjYRThRhDlSgBfEiXKPn3V6ukjcPNVEDk5p3xBixOpgt0T+4S11R999WU8bt0aTH9iWR42TOp2+Y6NcfwbPU8d13q1sWZpA+WIdswsfZY+if4CCaMloTlJjL8m+pRChO9/xW4hpW27/3Xz941neLX5rvUsEOemuLwgSWHMiX//yiqQouvx1an1ikT6WnBd5UnHQBBpOpvIAstoSJl4c0+2UEYeegaCNZeyiYVPqUdRawY/269vBRncBGq/BjnK77+CWhbBwDD/SMIzS86la51dCT/cuSgypnxX3RTzDX19NQTsEOFzjZksezZifhP6F3MFFJ5vddobz9zBOD8CDBm+hu56oAX0zZuO33E1ygYuIuXyqgITAJofanQyU2UC3XK5PTRVkcd9pNbuOIEbwMUtswU7gzUpmebX3GjyQp4ZZvkBVRZTeJvywDRWRlvCmPDXhZ5Ex+mRs0dehyEYvFE7QIGjQHgPoqOUAA35VadK/rqzR33t2Gy4tGVtLrClxbeA10t3meDRdbDL2ZaiTjHIOJRhW2qLtERqkiXipHXbmMq2UFAbU3xwLbh0GFqvuDZ65tou+XMS3HXwUY4EJBkFNZpD8qj1RcayYD7nbpTc2jiNGBHKsraJIwBoeQBHW59PIP6VJnVxo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0uelBUuWNtBNTQQ7RmfODYgYtVVnjk56HmDw+RRd+tCjglkCC38CadkJmro?=
 =?us-ascii?Q?f5LgXe3jDhvf7UtK/cbcNHbifRNpQX5fYhzfTMk9FSRKyXYmbCglSBWdniBw?=
 =?us-ascii?Q?fYMmVaxhuAR6OoC2aN6ma5g8nazB6EwOXJK582xvyVeVpjLiCKwbU/tWkbi1?=
 =?us-ascii?Q?zpz1V8YB2og5MJV0eX1BNfGiSrbbDiopshX1Vgx26SOiDgJ9XekFqZjlI2zI?=
 =?us-ascii?Q?9KnSh7G3nQ24ilKtetBg57Ncm50GqeaqfoIWdYchMbmiG6ZCZ0ScZjuh2hif?=
 =?us-ascii?Q?orftgG2M5RjyaMYUBnEwM3lBSqPd7t/4hG4LqN86VJjTxW4XJekm3b+JEusi?=
 =?us-ascii?Q?gsYCQfNcURlWYk+7ymtAvRYFbtG3E0A7s6kSuooOBlnV4rFI3jH5WhktI2mz?=
 =?us-ascii?Q?ccZCU+AUo3ZWXjyDVrd1cAtQZu8/zHJlOjAx0lfqsxrjxV/kRUPZxcv9VTuX?=
 =?us-ascii?Q?L2+YbK7SfFbYOW+lzo0rLxxPP1dH1463s9YG+v7xzdt7XUu99djW7qCKzv2x?=
 =?us-ascii?Q?gXEL8KYee9WLf80bW32t1MkW5rJRaFX2dskoG6xjmblrP9GOzIZ0Bbk/eeEJ?=
 =?us-ascii?Q?nu/r70OZpHvqgoQU5p5cytiYEn8TwwCwAogQelaW7NG6eUJbnH40BJK5u2+/?=
 =?us-ascii?Q?nZXq0eG0OeIarVuamLkqOEkukpnAD5HJzdCpa0VP2Gy2Fv2ImWXvNIyhBZz3?=
 =?us-ascii?Q?QixyGB0vDispOacjVCQJ8gUzcP6U+SbKTwI9UDbJd3AqS4J7DAweLWORLVbD?=
 =?us-ascii?Q?1efVtnex8xkIj+Q2aFdDXf/yUJxG7tSSB4KgSA8vagw0dVESWiD81HcdHfb6?=
 =?us-ascii?Q?v5rIlv0hYhH1RlkToRuCu3bMkTffxmmgP0rkPIolpMxAyWZUghgXBzIJCLmb?=
 =?us-ascii?Q?1WmlJchHqv93WfrjR8BSWOGgCPtHMKKbVkUfjUBQ4Fer26LVZUu3TNOn+dOo?=
 =?us-ascii?Q?Radudu/uFnTcRyXY+fnqyROvQO0EGs/47SbP10nhWjTSYJsqsFHlAKNPmeXN?=
 =?us-ascii?Q?1F1laXeRcnIztQUDIf+fUQg1XO8+JvNRo2sTg0sID/NLsWJt8dBnMfYHXA0O?=
 =?us-ascii?Q?CXAYw70S5cpGX6wVdLAn7wSmEILW2eq5GU/vLUKDEDJOwezyl28p6Wn3dzZ3?=
 =?us-ascii?Q?1f01jzz2srBVOTkfmaFO+qI++0G2yfsUSYJ/oD0nKnAlonjKfl7KHnuV/HXS?=
 =?us-ascii?Q?+hE1LGApVDK46hz7XrkGztNIs8iOaNmZYr62bzMvQUy3WREYjWOZ4HxUzuOL?=
 =?us-ascii?Q?1nPDXVqCbAF7YBJ/iUtnacezfSu6KCamGZcCFNjDA0UPibDdLigVu7Bohha0?=
 =?us-ascii?Q?DTgnhrWNF9zgKzAcJDqYca60SP4XF4VTjOdA5Ftqu0nozkx87TuW6geWOrS5?=
 =?us-ascii?Q?sXt69EZpz4vm2HWQkbBvo0UPSE8IATEFVX19YCm+xf7UeVeFPc/IDY2ZI8Sa?=
 =?us-ascii?Q?OiUd60mOkKS2B1xBKkRS7RILAk5gCexPeUJg60ABCFH1ghJu24dCgAggw+2R?=
 =?us-ascii?Q?K8FtelVYiz0cxEcouJ3wfBewhqz+amKG6Tm1O1yUTbRxjtXb7Zj7Es0gDH/5?=
 =?us-ascii?Q?/Nrz9fdayCduLLNAk3yiDdfN+hsSU/pfTx78/qubxLSddtdDc5r5NbFDpbfN?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e93858-7a20-46da-d9de-08daab80592b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:36.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JnNpD28cm7mWwfk0zcJGjJGkp25xegVHflxNS9Ts03nIbRzJqh9emcB7EcA0U3BKc5r+5Wppui0TZIV53HCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

msk->last_snd is no longer used anymore, drop it as well as the macro
MPTCP_RESET_SCHEDULER.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  9 +--------
 net/mptcp/pm_netlink.c |  3 ---
 net/mptcp/protocol.c   | 11 +----------
 net/mptcp/protocol.h   |  2 --
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..1f2da4aedcb4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 52ac57fd8c27..7d5f89799c9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -2346,9 +2343,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		msk->first = NULL;
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2981,7 +2975,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
@@ -3242,8 +3235,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d44c97bb41db..68a2b22a47eb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -258,7 +257,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

