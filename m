Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C44A03
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3xnl5O2ZlK+b1nk3MkaoI0Da9PNcvJBBsKJ+5RP/w0D7/joCo3K/5ywsAMB6VVnkbrIp24w4fvf3zRDaJZCe/KWYhqpMXJdw/yoktUPwl9ORq+DJ1fi328fkU6QNysOoy5Oal7ctE9JL4gpwC7L9PWZeAKtPiZv0HPFrLMc300yJexkuArRxlAm5YH/STxTKKy1Qv1QHk+9tSHu8iiddXsdB50EElO3Jlf0BRo7fmvf7/vLUl5AJ67uRx00goJjLmgCEwgSwFG19qb/nB3o0Zb0ITDs2p+yao8kV2v41bzGLmfG2GIxoHnO31udK4KjXexMXn2RrDd4bua6fi4V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgMv9RFxuy4Hbho4pDTni2onIF350gTQp0p/1aF4Aqs=;
 b=HW2u0CcuNTqsOQ3hvbCHN+sRGHcn3wjDgJl3jKGsu2hOatro0DsI0vNtN/eG9CuUkgiW+DqRTnNkkStoHX1jZa7P0wHU4eHVi2MKBLeqCkvvoYpesYIxpIRaIG6Vr70wROFsgeiBkLMJ5osTxtknrYG9K0+CRkiSGz2qMm8AFxRg1YmhcsukutTPTFN1ytQcXvuPk+dYS7eefQ6D6EXRVtTJiG5xQxkOMHvbWjXOQDDQPm+YkG2peoAUsfrDThx8Ja6krKKKQPPIw9cM0JB1UDjtsKKvTa2nCGco8k0XUNrukHvTkm+G3Yoh8lNdaoi+WhUcxNRF/Ip/B+zImCq6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgMv9RFxuy4Hbho4pDTni2onIF350gTQp0p/1aF4Aqs=;
 b=v+Qtl/OfznkWiXNxG9e9Ue+iapKTRSi4SrxOByySPqfHnMQYSqQ0iPHUC4HeicAJESX8gCyq8KlODrIU0eLb8tddpRKJQdptOhm+ssnE1twM/QfGKGhJ3HHcyqBLMi7BwbeUilCn2q8WHwd76gi/xOnrFRUVOk5wkUK4i8Ld6FndvS4s0EO39Bi7ADIXkEtugaW3zNYgTTdRJiaY4n7WLuqz4RDgG44tk0eH9JZp40Ryy+E82X7CuIk2mk0fYuQtbHk7WNTUAAEFj8alMNDKCcSubxowCca1Br8zA1pc31zekWe0ntyj/Onn5X2HDa1kS5E+1JVMxnNMwmIQmTu71g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 14:17:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:17:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/5] mptcp: simplify __mptcp_subflow_push_pending
Date: Fri, 30 Sep 2022 22:17:35 +0800
Message-Id: <87648dd3192ed4fff140ba9767f7afe7d77d9021.1664547250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664547250.git.geliang.tang@suse.com>
References: <cover.1664547250.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:405:4::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e0f36a-b755-40c1-d330-08daa2ee8393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vg+aBvcaZpmbG/lkPVCE/7zu2YmbMBn8BjJOKxn0Iv1at3GOGiEUg2TXDLZyCsE9Ed68mqk0TjN60c0rif+XaTmAOJIde6sMC8QVlFXc4CCqebrCLcPkdxjX/b/aODd27up+VILobk/v3aWTq7b6kUMS/1C7bN7Y2iVKlQsD6NvGAqMnzbjAZvb/9gZARnrcDdNN4fojDb71UkhiEq+U08FTL66jvwLJROr8mPXFkC7g5IPU0UXcBGfR0NhmdZ+hkStjqq8x7CWT/zC95Jm/rubmt4zYpVtMLxyT0fCjFJipSBYrm9V162SgYW4ALMZt7IZtYYwpuGaDI+Ciw+MgJdvZ+GClLWcR8oZLKDnXlZXAXIy6iH3JCrgn9jByg375FTr3OHTTBkIDtua8nNnl4xpnluNGONQcR/Wuo4O6X5lFtGpJVsOPthX0G6bYbPdBOWJfUfODTjB7Tv9JsSNpJaLQZ8srGnao7o1WR8nfZT0W0dg1DwGtcDX4CXbTolcB2lGdIKHX3I1tl2qTLoNr0Ip3QeUSb5n7FbdEZVsP4sdTKoRLNkk0U0oWw8UfrQ7wihCa7LfYL1rY9Vsjq44tPLqQNE1Hz6gE0jCqTaQ2f6hJ9w0Bpmv5FE675O1z5JTnK5tzcwrXDGQDmMGWqMTLD+rGJZ6MtdGjJOCKePiXy2hh6j5RkAtZyYECn4STkT6RgUoAZQWlyMN7nATtnNPGyQnkc4JN0M/g2DL+3iK6lYjPIsKasctDdBDRBeQimTal
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(4326008)(186003)(2616005)(316002)(66946007)(8676002)(5660300002)(2906002)(26005)(6916009)(6506007)(6512007)(107886003)(36756003)(8936002)(83380400001)(44832011)(41300700001)(66476007)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6IRtghONqsX1tdcCveiA5U25wKBP8atHyFpmIfGkVS4Z3WJoP3ogcJqcP+/w?=
 =?us-ascii?Q?4m07ZPN2GKJf+Kj4E8ob3EIDJWaUypWSEbBKMJ7LPXNwqrtiBWnbw+E7/IY8?=
 =?us-ascii?Q?KxQLBuqhaFYck4qsoLyy9sa5yZHetu8ixK9BHI+PO0Do18xcn7tfDscwQCm2?=
 =?us-ascii?Q?Z1tEHK6yKf5e6Eer++221L25j9dGkNxDRYFROi4ubxoiYSyonDqNUqwg8j/h?=
 =?us-ascii?Q?EqtyPg8/PX8qq1RxnkU62LgBUkFenUnCRS1lgCq9KYzhS/L9DKjx0I4sKbkm?=
 =?us-ascii?Q?Bemw+8Su5tGza0SG7ENzP+u4RXfKnhV14SRTfFCMDYV879/az7TGQ3qvhNat?=
 =?us-ascii?Q?p0StzgAHihahYXVcy6G5QSXAFaZ1SqkWiOwOR1GfLSZUGOLvLyKAa6Z8uit1?=
 =?us-ascii?Q?2koAvVkrbFP56mxlAbf6l3ZlNi62X52+Vc0iv7wgYMw7F3htfJbODJykRhDz?=
 =?us-ascii?Q?UH+ipK1NAoCv5DUxb1fN9s+oYzEv9XgWlkMjkQmW0QholPLhk3dIFDhqzfGf?=
 =?us-ascii?Q?TnxJb1+LpsEZ/WtyglwdvEB/nQYNL4DLlXLXbDBdfUnSHvUrhUX8FBBMc/Fx?=
 =?us-ascii?Q?YIr62lrGNIZAGQXBel8B24tRf4GLc7drwCA7bakdmEx8TGziss8qVGw+t2zw?=
 =?us-ascii?Q?lmUoR+UIIhE5sVkl1WB92cy+RyscUpcGxtzEwqq5K5F/ou9Gmx2vo/VYqOrY?=
 =?us-ascii?Q?+2VhQef+AQoDROWYSYV5XQWnTh/quwU4wJOTgw/I0Oy9zkpwI9foi7ZmSQGM?=
 =?us-ascii?Q?81Elk2tzQaCnN6xJS0lYNI+JCNz6m6qTvo3a2KdM508mglsxZnkNKL+18Bm3?=
 =?us-ascii?Q?hsL+NFbieO6LvDnpgmQ0UK15eKoPIwhoO8cHeHudaOgvlX2/xUOFXvt5J0n3?=
 =?us-ascii?Q?8AFX0NUdr+sFwf7KJnGviMyWLTuLZ49H99QJWksolhsLoGN2PiXcJKichfrP?=
 =?us-ascii?Q?qi3RrTROqsf5AgD7sxjnwnOqajOukWxdhdFRmj/W9gUJOOt6Lq2vQksHXdA3?=
 =?us-ascii?Q?Qaj4W0KrzGiiydNSlqdehnPuarSyVwi0/s7kCFnmQHwCSNxMo8F6hyYaoRhL?=
 =?us-ascii?Q?dXsebjkn6V5Dy58xKmRnm/XW5VddQ6QpDOJUKm8gfltgkn+54TcDlS2vWsun?=
 =?us-ascii?Q?jvf70Yaqx6/kg99cZJ2DbvhP7f1r0yGYAinKDEvdLJL73tGyOWY30kj8R45h?=
 =?us-ascii?Q?8o67QQ7xu5fQk1mEoX4zQK1phal+5ZyDiQP8P3UKodmK5jfQ7F1Hx5WqxoKs?=
 =?us-ascii?Q?HT9uRwy6KIEhV2P3AGFbZwsCihdjzYYfUxfaiYGcZL7WgqhK5wf5+IbvjCjy?=
 =?us-ascii?Q?pqpXAzDWVA+DuMe2OpyuNDL4+S6aaqLOH1hYCniygJOzlqML/5vj7f4uz8Xx?=
 =?us-ascii?Q?CZB1V4XH5OkatUiPuMm9++Ww6w39TostTM8GL89CuxP3d3nl5p+5GgD2jBHZ?=
 =?us-ascii?Q?H0YfFRhbx4EGJ1/EYyrraz+OeAJVQsfSstXeeYnTCfyZx/g1A0oZJYK3yuP7?=
 =?us-ascii?Q?7aiIkaJlQI62pZvwB2dSo1Er7fnFrCiV0hNXIEYu0bD4A3r7dyhPE1V3EusB?=
 =?us-ascii?Q?LuvOC8O0kXNX3Zsf2nmYXyxrJANgpaVpOYJnMaDxrthLAL3rRFgDJI7OenH0?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e0f36a-b755-40c1-d330-08daa2ee8393
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:17:32.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MxAlFBPyU3K2u0kqHd8yegNa4BWcGpU/n/YYWveU5R5UevrjxZHgZWCQB/0ArQPWdEZYkgytaDJjUqNJdWnZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

This patch simplifies __mptcp_subflow_push_pending() by invoking
__do_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8e67c149bbab..940384952015 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1586,9 +1586,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int copied = 0;
 
 	xmit_ssk = mptcp_sched_get_send(msk);
 	if (!xmit_ssk)
@@ -1600,41 +1599,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	}
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-		if (msk->snd_burst > 0 &&
-		    sk_stream_memory_free(ssk) &&
-		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			mptcp_set_timeout(sk);
-		} else {
-			break;
-		}
-	}
+	copied = __do_push_pending(sk, ssk, &info);
 
 out:
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
 	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

