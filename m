Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6C6D22
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwDzLVkbdHx+aQmBG0+zzTmJgMQUjx60JSSDUcmZKlns31EhE1Ym0eMHwBb9slxa1OAS9AmjvTdZDjbsSTASIr4kvR2iPzElnh/D2wbYdgDNjtZKhmCAWfydruhePA2VbK+isE2Hi6NGJSCUYoXn9VTtI/o87rl8NCmEgpqmkILjoJ5Kf6jO4BesGVKDZuET9IsXnQFrXRJVVS2vGZU4sZlBBg5YzbXBFi3cUsKL1/lfwOC0Fnsp2p9jrO78zlTwi1Jd+lErdogXkdEcwgV8ftEFawmOp5slIbasFyEdhbFpNc82VSZZx6R/zMiLybA87NZw4DSXnJzCyqNbZCapvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hBo7sEQ662RDvUW1De2sKlgnkk765OkC/n3k6EqZN0=;
 b=JuITv1+ZBMh+4AH87KSy8Ri4GHzKYSSnGu+3s3pa/bu3niNoyQ5CitAALwFFlwgQ96PjdNLfE8hlnrZXRWv1O7X8vbULNH84+M2wBPSFjdLQtVH722uyTAHFd6lwBO/2oYi+Ap9SCrK3kj3yFAXgBNHdA4T2HhtkaXg+sskHiLg4waHhzRtRkarmQDFoEcSyeuEDo57kerDtCCm/Hg0VkN/0fApqpVoMymrGJnNQ82uCNZqDOA5tXCuv634fHsMOr9Le7qPK6lV13ANp5+lJ6Jfmf3Aq9B9SCHlG+4/ScXpJj9OgmiVS5f9acSdse2B5V1evLrwAxAFnLEABRsnTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hBo7sEQ662RDvUW1De2sKlgnkk765OkC/n3k6EqZN0=;
 b=zVhgyRQtEkdkNLU62VC/saQ+ZlxeL759EvxH0ZQBSU1gA/QcqqHMA4aOqojyZhDiF7cMgMmtI4ISWCAkzu4n7URLVGfGD5+uDUTDGcbHsfq5MrYaeaKp8B809kYnbNiBwTSLBzJLXV/zEXv2nAsXQVQS1CkyT1Fbf5NPnDWO/a/Ib1vhoWmQtlLiMyvJ0fWY+D1YLRpWD/Sju4Rg+F3qNBbtJaXDheo/7uiKUW149bWmuemIMZqKQRDgoXQOLKpM0nkICY0dQVNOCUYhr2GXYjInehT6gRK9y2HwQDu9IkitV0RmJkGjjJX3lLAsZuFuvbv6m5yGPgjdS3S5j2wUVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:33:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:33:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 3/6] mptcp: delay updating first_pending
Date: Fri, 11 Nov 2022 21:32:46 +0800
Message-Id: <fc8894d9b62dd3f047435469a76ca9d9eb5adc4b.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668173360.git.geliang.tang@suse.com>
References: <cover.1668173360.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: cd14bd91-7fed-4038-eb9f-08dac3e94112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UeIpyXDPSiqNyCu2Sa8scsCbJanOScrCH4OHHzLdAPUNl5M+5/g1sIunWTw6w0vnbVc/DSLN2QC6m6z/knG1joVAqqfvnAw1DOVG7rgoH130Tyl6wyfGZNMds36pj87+PgI+u6g5GMsTI3IT/+yJXDG8z7a//LubNbkkhaGfI4w+5y3VYMInL3GmlVs9346ocY8WdaU+PLSfCKUoDQ/pwJsZFs2XiJET0AeUGMqDRvhHTXMr2c847+DLBe1f4mHqriFHl/+nPCB57AulJkPlcUdmTra3KBIGftIh8psVHnODNaavoZ+CwBmyY4AP8zn48weDFuJabXkMRb3BjZH0K/nLzDGjuwPUstoLofK4M5E0Cu2aSAGRW9VXBv4L1+sEA9xaFS9BekHC7LYcNvUiVXIPBZPZvNRJdiCayATVB2HU/WS3/rVLDDuqd2mSJYvNQ0oxt7NQ6YOaLukjPScielGei0hDErM4+qtNzAi2GWJ1aZzx9LrYrED3HmCjtUd2mYo0EGetMobwRmbrb53/NWeG0usS3PIyhhlZzeLe6UIoWJhYVmkIwozNjbwyahllFErinhRw2Ya3UN42x7TT9fre8kcLoSXot0Spbe4DgF2HDoJ/2qvrCpvqgfK3aI05s3WyLhfPNJKavLwXW0d8qkDGnwqU9vl76wUD4o+wWFeR7Cpcv7DzocK0giaqLYa8IbnlW9043oUE3UuPF54kmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(6666004)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(83380400001)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dd+tTEdd4svQ4IrgAMBIq2uprDG1pzW6lKtvB+8byRZ1hE5Z6M6OkITr010?=
 =?us-ascii?Q?Jf7jblud/F0Q/bTm+lh//vRE91NOzi+Y4VYjQT5mrUW1J3+cqWHnZbW0uo9l?=
 =?us-ascii?Q?D9nRdbMznBZWX1Jr8Kv9XfcelyvvTEC4SxMB+vgARF7sm6kCnDgQdK8CKXsY?=
 =?us-ascii?Q?bVoUcsx7XwCOB64rV8n7L1DPKn1Gp2LTwR4omwgbB1E6UvoK86Dfx92LOjpz?=
 =?us-ascii?Q?UXSoSA5t7OxUjYQrr6UJdSfpMQBx/8AWC2Sf5B5dP1cBeZXYuD7JBY2CkfZb?=
 =?us-ascii?Q?vCIIvVe+t/vFoSvCLbSHXDKSeEY4lftM5HIRwq97L7RicuhdPscTJZADTbKQ?=
 =?us-ascii?Q?+7qA33QpNCN4JimNVnVIx1SkglL4yAeL50BE7+4hGcSfc1TtPhM7/pDJIIQS?=
 =?us-ascii?Q?N2vmHj1a3OLraCHgw5kSP0+z5XSX0zFTFgCH2uVPT0oLHxdIqvYMcBKZ7MU/?=
 =?us-ascii?Q?BEa3XBJXQFuhi+XH7n4pnINLpPBmjxCM0q6U7OMSYEfj0M95RMomZLlbpYYL?=
 =?us-ascii?Q?Dd9tueDtbK89IAChr/vfkUIRE9MgU+S/+4rWAny2XV2T6WJIWXyr/mQuTqXT?=
 =?us-ascii?Q?VOlg5qXgtFtKX+M/JbXL0uy7mBhm63FGd3WK82Us5GM/0Yuyep2caiTQv22Z?=
 =?us-ascii?Q?LJ1cggNXO3G1+YrIuj/ePFmjqNiPDE2wmhKH0W/GzeaslQ8PgkCgLng5W2uU?=
 =?us-ascii?Q?EXkh+YrEjg4mXTsXBj1bud9XCKKvEC9neS0I4eU0kNtExlkT4gJCGJyERyeF?=
 =?us-ascii?Q?nYMdYdeJWSYQVRfOB7yUX1MAsiQQIjHJfH3BRiOjdRBj1kgfH2mesui8Y+VX?=
 =?us-ascii?Q?qNvGxWZRtYniZj8H8AWIFiRZ5+M+7dj0VCsIXhVTD4n2kuBfR+e2wHmcFKXN?=
 =?us-ascii?Q?xAxX/rcU+0ahZdE6d8Ys4t8R/S/KgWm3HNxn3Oc/2oPi50S2cKa3/f4cWP6A?=
 =?us-ascii?Q?gkkYvau9jd+gnolZdCC1PzPdFfpeXhoja+l45CTOAwKjImAtC8emGfbDzQro?=
 =?us-ascii?Q?HprkfPWxH4fP6qjgX43+tE8emWsN+7yOZ6n0sdTrFFN70jGFbg4gEL4tezaD?=
 =?us-ascii?Q?Y53ELvcwwI+8qoDYOfZUX/uEv/lf+aQDcmyc9TqGvK1szjAqzRVgkNZnJuyh?=
 =?us-ascii?Q?kMLnVjlWlS9bhMEdJfaqFJUjUiGDTQ1Rfd4W8iBC/WJIgzt/QKM2C7iZ8F1d?=
 =?us-ascii?Q?UxKaf+L+e5v7Y3g3uI1ZRNK48Jlol9vBXLlktuReUZ/Qmy59JGNggKtHCjH0?=
 =?us-ascii?Q?vvOK+6xwyB4y/prnLZ8sbrN7H1lmaC0gQXfowhjXOYM0Xlvx+EY2CjevEWez?=
 =?us-ascii?Q?6e30kaISoy9k/RkZfXocGCfb1TEU71reOp24W9lQhcqHtAst73EvkOO8yVKk?=
 =?us-ascii?Q?IwhqC0OTtPLi3kWRrFc+NBo0vkIMcEJeV3kXUZxs1RxRAM/hnV/6R7+FMmNh?=
 =?us-ascii?Q?vzMbhljgQWEj1qZ3zRO+fduW4wu4znUpnE+5AmgQj1JFnqmNQyDLYzd4+Klj?=
 =?us-ascii?Q?a+oBhQe3XnJZBNlPSHEivP2t4EvV8hGUCeZRMPj76b4pAXNyTts9ld913s68?=
 =?us-ascii?Q?THIENhhuTanBVb3tn0Bjs8ycHZA+ic6yAal32wl6NsZ/XvtvCVgO05YuUbI2?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd14bd91-7fed-4038-eb9f-08dac3e94112
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:33:01.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: day00xEZ1n5TYuwUnWQZKJhooggLxYn5pGEcb+ddoJS2v/E9akzRFIVRu1cS4IrbZ0r811c/baKuym3zJ+k0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 659589a51bb0..fed825d0fd06 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1112,6 +1112,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last_frag;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1502,6 +1503,19 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (info->last_frag)
+		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
+}
+
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1515,7 +1529,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
+	info->last_frag = NULL;
+
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
+
+	do {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
@@ -1534,7 +1554,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		info->last_frag = dfrag;
+		dfrag = mptcp_next_frag(sk, dfrag);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1543,7 +1564,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1587,6 +1608,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret != -EAGAIN ||
 					    inet_sk_state_load(ssk) == TCP_CLOSE)
 						err = 1;
@@ -1597,6 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
@@ -1631,6 +1654,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
 			if (ret <= 0) {
+				mptcp_update_first_pending(sk, &info);
 				if (ret != -EAGAIN ||
 				    inet_sk_state_load(ssk) == TCP_CLOSE)
 					err = 1;
@@ -1638,6 +1662,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			}
 			copied += ret;
 			msk->last_snd = ssk;
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1658,6 +1683,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_first_pending(sk, &info);
 					if (ret != -EAGAIN ||
 					    inet_sk_state_load(ssk) == TCP_CLOSE)
 						err = 1;
@@ -1668,6 +1694,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0694ce6a4e39..eb3de51ae1a9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -359,16 +359,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return READ_ONCE(msk->first_pending);
 }
 
-static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
+						      struct mptcp_data_frag *cur)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_data_frag *cur;
 
-	cur = msk->first_pending;
+	if (!cur)
+		return NULL;
+
 	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_send_next(const struct sock *sk)
+{
+	return mptcp_next_frag(sk, mptcp_send_head(sk));
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

