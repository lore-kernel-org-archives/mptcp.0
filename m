Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0117CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjopaI+dzSofv78WvmI6yxd/QJhXlsLob1LDUnK3XfNDP68IcKXRflXGuZDUvO5rXI0b8PtKMYdo61o0WMOHvbB7ZkY6mQU6wThKLqsfHV+rRC5w90g4FGLr5DzexGDJxA21u0PCNgP+hIhTeJaBD73zPGoK4K2tPm7BmF/gQesemRjXFuQc8R8BOyGRTphQSgL13K0OI/laodvdg6nMZVJuK/NGv95p9MFaaHnJWab569coQ/EtiU1ccDl0hmzS1lu6kVa0YOf9WDGCOFGUSY5mhzJ+IfrwY6+K14WDtjaDZ9e4smlicgmjbNwaDPkEv8+zF/C3Gw2O9FbDCbpQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtSB2AOnwbfoLW2FuQhhbfPDVxG61dziHJglw82O/1Q=;
 b=YJCOQ2UREAnNns/6ma4hhlqyFUHNUNXObe6Yrw7GyIWc2T+jTFGPWAMbACgsgEWowuXuzgo3u8xiUhtIcJpM6404+A/Hv8olNnAboYGtLjq9fGP8QHZoVdJaEW2FOVeJxECT1onn0XVATKE9TMohtlF5qHaUOsX8w1afjxu214iI7fh2f8uyRf2V0t6N3BH0XXz8U0P/hiVwfOPgz4Z0THO5RtrMXJpJ8XFy62gBIKyoVmXyw7bRy7lhH8xz3xjfzfHcrWHzuIH4tKegCzpFcmBQrpd6TNjproNRSHPc1s0Gq6g6venmS3xUDiQj6Vs6jqzj9XaMMHVlS+0W494sMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtSB2AOnwbfoLW2FuQhhbfPDVxG61dziHJglw82O/1Q=;
 b=waTYJESuebyF9Vyijh7/eIZ1tYbJRKWARQSnd/1IWrQR9HUjh0hGNJPLL1WIfWvYMSQhG9AjiPoovm2uUiN9lAO8xGRYA67GFpR1ctI8Kz6N8kYuhRYVIJ9/iDH+cXWuxVUqImjyA+6srQxI8wf5DaNVeDCrwijEUP+lutiTGPg56Yq7MeKkxru0HY5/ByzfZfbfjCrS13KYOReL1yskBp8LrVyP9zU5T0cwhTPUI1H/wFbdFv/a8h09IHmVSK22dYhQ2zEmxTIMsWwUMxyiPciHllEjod3+vr12JHrWyMpUDcxmgPHrl7jJqAAJ4tYJfI1R4GG2b84GpCIFp+CI9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:40:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:40:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 03/12] mptcp: refactor push_pending logic
Date: Wed, 12 Oct 2022 12:39:58 +0800
Message-Id: <c86f85f57a04f86a12508b3f9dd882eb7c64d4eb.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 01642707-c9ef-448f-dd74-08daac0be662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yaon3ZhPi2Ly1dv78xIVxOExC5hJNIKWAhCMdDg0Wh0geLY+fpPddw/3kuu0YWXWYwU1QzybHiYkhYj3G0JooZyI215LYfqqyenprgqq2ZAwTjmsfRvoLcoF/vKKL4V+Ov4y259tuQM/cMheDttY+BoJqSCIb9nrGZJrniFjvNKGjr/n3rSA7FOtk/ugLGtaoL3klhtT1LXkeRcCnhZs5gadtDSVGqPzAfsanzScsnQNWrkujOoTq94YkPmQXrE3nlMqS5oY6CY94hkkdFm4gMt2Yi0WA6bXAZgGLrVOlGuPyoCUcG0jXTasxWEqyGUIzV1b+HdRLbtU4e/0pQ+18Sqx7yDS8Bd7TyM1GYspoOqdzcvsF+FYo/RXLnW8Ap/8x4WSLCX9SwdqMv6T90n7wWQk08oROsIMMnIFRi4vJIswncuekuH4Jo9iSnMuehJFOYKfbsIIfFDV0EPvZh7OiukmNjshMODSkLxdfKMm7eImB/Bd0+neOsv33CcsygvEyTMGsrBnmLNbP2iFn9YyUoAcKTBbz7xQFuHQzcgsDQNEpI/USlL6wvU4rEO4nO56vpKRGYozzvABkUQH61FCDoDf/JG7sUS0xGmf5C2cWRduYNxJT0D9e89mHU+KnutqioDG6CxTf/7lfHK8px1yjMJiKUWsspCiSNZSgzAxtBa0mRtd9oBq95gCAPUyoHAzslTfa1958cbpi6rTY+RLfxCSbHt14wOk6TPSdNdvyeJ3qpapjLWgj7+Vn9yjP3ZB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RjTxt5I0o4MyDyQF9IAL5ea/PWQ5Idt2s6ZPdIov0C3z4xvwJuAJ1lUExr8S?=
 =?us-ascii?Q?VD8+lSqFU416er5Byh/fBk0OLLHZoSPbEkexZXjjlXQVkZt2yjmYZgvdp4Kv?=
 =?us-ascii?Q?Fj39t25JAeJHlHtt33LTN96fF6KEezaouidAuPXj0pCSeojRO7NGDpHXYVQa?=
 =?us-ascii?Q?ZqawbHi7LuE/oD8pqpmmhe36MBr+r5TfH5sK12i6mpd7a3IDBq4OfC069o9w?=
 =?us-ascii?Q?1xN7iJGDRfi/h7INhtJD9gQmQM5R0A0JHO5m2SXBS4Qm5J1OAAOxlK4k3KFm?=
 =?us-ascii?Q?kJf4gCysodaL7QaPS2aga7FjI1haPeN/NVWpqHtGYn/PyPrQPY0IlLbuA0PK?=
 =?us-ascii?Q?2TSiRQP5em0QDhv0YDAAqifHjM7a2eZLX6TG37dhD/v8D15+HdEo7XwYQpEq?=
 =?us-ascii?Q?ZnkPBFXxAyJMFqq+Wgoi+kw8OtzOwExLPnmObJB+8HprIrkOOmqmxGx74Vup?=
 =?us-ascii?Q?bjAWLR3LZivh3dF05cgljbAbxVEX4rHABq6bP84YAGYvh+8vZOL4IuVIzCcZ?=
 =?us-ascii?Q?LNHZ8savrdPjSndx3Xb48W3lUHEOvXiAJ1JVFVFRIDOnV34kiWb4PHYmWnN/?=
 =?us-ascii?Q?fXcXYiNPTGCdeMd3APuQET6BcCaK7JzJWEUQeR5Q45qhE4b/Y/MLZOdM5fpp?=
 =?us-ascii?Q?EQ0GlOiM0hUQWhczala+fNeBGXrq9pMElbYUsDHXb8RjkoT9yv1SaD7MRzRF?=
 =?us-ascii?Q?TGf6G2MPCAopLX6p2fgzWkppE4aYbrPWdynzCkFi7dsxOC/n83lR5zLlB8Ro?=
 =?us-ascii?Q?NFTJH4Cg33XRPLNk3+pyKN85AnM/mmcvSCzUVOBE0O6QkRuUblvWYSw8QGyU?=
 =?us-ascii?Q?NFOY2mqh8S/8fUd+Cf8gMPPX3SSR5q2FqqcwBMhaQiNMaWXMvlRKzrmaRZ5u?=
 =?us-ascii?Q?+QNrBTpN0hnZQVYVRheyEUyed73fTTC6Q4MyZZW0I1bNXdqZmVhxp/JC1sH+?=
 =?us-ascii?Q?Sm5cA5MAP2H97Tcmiq0kALM+UkUvFAYIY35zlKY5ES/GFZj9milXbqlaV/Js?=
 =?us-ascii?Q?Yp/tMiJweI6pnkNpO6jnu87v81aTnW9dw78lm5f7kj5GuZMfwpPT/IWTU8WX?=
 =?us-ascii?Q?3R1RdM6il1YfVrkcm5QxPy97A3JTD5Y0fUnjkPM444sbPhNzPT6uyN5QK0yK?=
 =?us-ascii?Q?RSLN/432ofCHzVjuK8ycLLhfXSPzbguphRurSNm96/Ct9ict51FFaBDmMyXN?=
 =?us-ascii?Q?kJvvPhKUu02z4ChrlUQE4nDoQh7xXlNtrnij31rCiwVcdPV+8iEOL1D2hm43?=
 =?us-ascii?Q?1Rbh7ZPhyyYBbzRIJT96pXHQZIGkL0WrR9ZDQmLrim0JmOdakikWz9LJnY5C?=
 =?us-ascii?Q?EzTd9eVT81UAAqy2nBZpbi3bCkpvF8K1RhgSLwEgIMCzSr5tpYNy58rU9jm0?=
 =?us-ascii?Q?fqCFUEdpQWMhKxX6abGkg1ObtUPgV6ee+sZ8jd5NGkNNYmOPehFXUuc/lmYm?=
 =?us-ascii?Q?1/D7oao7S57mZRXY29BSoY3+TvJD8tfw9EM5jpQ2kcwJOJFcS4jMf3LQ+Z4r?=
 =?us-ascii?Q?oQ/nyP1jZMqbVi7YV/+DY2pvjQngGLQ4yDAcMkeymQP1LKAsrGwzpXsiyR06?=
 =?us-ascii?Q?f1lf+Ua6xwsN/7K/sKGZw8siDN+qgTBkvVZ0BzqkYRU09bB+ygJ3vlcYdutT?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01642707-c9ef-448f-dd74-08daac0be662
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:40:33.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U65KGX2Np97wvPq+iJ6f52PcTkKrB8K9XQxULO6YJCzC6gxPHcbc67NLrGCdXaY6zPEL1fW7OjKV5QGQxLKcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

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

While the scheduler selects one subflow:
	Lock the subflow
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push and release the subflow

This patch also moves the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
__mptcp_subflow_push_pending() in the inner "for each pending dfrag"
loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0285b21ff912..52ac57fd8c27 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
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
@@ -1530,60 +1522,53 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
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
+again:
+	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
+		lock_sock(ssk);
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					mptcp_push_release(ssk, &info);
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+
+				do_check_data_fin = true;
+				info.sent += ret;
+				len -= ret;
+
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 				mptcp_push_release(ssk, &info);
-				goto out;
+				goto again;
 			}
-
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
+			mptcp_set_timeout(sk);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
 		mptcp_push_release(ssk, &info);
+	}
 
 out:
 	/* ensure the rtx timer is running */
@@ -1636,6 +1621,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			goto out;
+		}
+		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

