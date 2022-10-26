Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041A7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUxBhKLrLqq7EkqwjGTi1fVLVhn7UIUYorY2OsJOhsZCUIsIFJbwehGnUVyuI8v8JMxeWEr53BZK3FRZ8HBVW9icKlVvRdkYbaIF5/D2a4yUD4eFHnaE9Q51UR9pGodZn2BLLQ+6j3ExdGjuXzh/+Mv9ZSWehaizQatGg8u1HdW1rR1nJmbPRByot3D25zmI2bI6d+QdkDynsiyUfDbQNndNAw8I/OgprwBleoBWXHIo579QpaDR2olebFqdHToMDSGtq5HsU6/rQl7OvTgSGu+UMuUcKhh0UlBdz/IvjAXlq/Kfjnyf4FA6SaqKGoDqQSnncPiorrDAPHGNTPLneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOIy3en7egdZ5xrfgva5DV9Yn0XOUAM2kAIbbDZNX+Y=;
 b=muMZ4p+VoonxQX51A8Kn1cyE9O+RxJWKGrsZLjn0ujfvHCWNI9IKM/Ng8Fen0PpjhNL959OdmevJDE6lat/g5hTnFtD9aBvjC/XFF8wEVt7WIe4E7d4CJknTSBbJrq9E72DYjTPhhpbOQqklbmMtadV/3mW4vjqN4cAk1jy7HXudQLAHgUYCaAP/GVZZP29dbfHFvyxGVEWAEtOtNjWUfoMdFCpf3DRiA05ILkIlNv7I8mtXWjDIprP4I/bGe59vOxFipbft+XtopSgIkEI3QK9HbLCUV0qY9TuJKrQzgN4bKZUjXx5/RhjO2/iAwY4PpXh9jkQ+TN+Ns2iqpovCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOIy3en7egdZ5xrfgva5DV9Yn0XOUAM2kAIbbDZNX+Y=;
 b=0jvAVa3Tu3KJEhlcXtvoVVeAW1wsv9F64D66JtoJukniRLcMeRo/On2tCSazqTLQKII45LyUuO8WdrHkj/uOSeG+/V6ZXvijQhLd59cqR8SUG3ISX5N7bBiaWUdN6m3Gnt/I/mepzi64mJdbBZWY2LpjgYFidjg7zwSz7r8V8swcBJ3b6bFwqDOk1lbOvYBOhbydX2WDScPRFaXDAQOvn5lnekcfDM4lt8RFjvUm0ktFLU1VKUw6pKfF0eG3x9sZhcYug3o/h1MdGqxklGe57Ec/sf4TRb9yt2Kx64/hXo8lTvz03SCehdTbKhz3tEuGTUJpC0LDKt/CwIb4vyhThg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 13/15] mptcp: delay updating already_sent
Date: Wed, 26 Oct 2022 16:04:22 +0800
Message-Id: <e6ea8e7b1ea275259def41f457455d0112911f4e.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2023bd14-4bf2-4ba2-ff3e-08dab7290067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ib8DA3bbIrijh7X519FpmDm9yUOFMcPsRsHxxvhkzFVNvM0aIPNtdQ7nRbSur2UWgtb38f6gYTnB6DldKf6a7X5K1aNb4lp/5GqSJLQCGf44+2Iky372CJGChnIM2x7GXzt+eApFDn9mDucKgVe9m/L9bkZMmcCl6uuQdEnKiRYzvz18k0jCy/vM6wy4x1oYdx71TUHQDxuvgs8xXlHW1O5slNb3ArfBPT3vQcdfw9+uDF2Wo4dyxSBQ2BjzbnBlNWbB1BiRSGUO9VxAY3MlFRqn6fNL0T6SRJw/Nvxb8yCgju8WbJntFpZkVxG5NB3LENkm+HhHzYT2hZWmCxU2kB238c9eQnWuJrQH27qQ7co0uNUllGlWlX+u4mr2lxcl5DQRBzYqaQEnULss+bS1AbgTBUPjAmGmZkKw6fm4WE6irrCywuYoOaV99EC5ysgXftEw8S9qRiv5O+dEK7pL7qb+uS1TwAs3K+JSVIXd32cW+4ydqdp7bhhfo9a54jUGTEyUC7ZW29fRgyQyQJllPcQL4LOUCcrdwJI0HSC+tnRUHPaq7WJ5S5Pq8a3qIk6HP2CXPcvZiNNXGixyB+qr8KS2zIBOujFxm4UpIgRRFt5NZhLiDO17Vviqs9P+DzU+H1l9yI0ubegDqxzfr25hslDGZSPStK4l26Wxu+zf/qwNSRi5jR5AgLRD5yjMTeUno0LXenm9NoZMggkUvLiI9khn8gqiwpOa3QaMEYDPOnt33G2dDyPHFO1Kp9VRXw9k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36756003)(186003)(83380400001)(2616005)(86362001)(38100700002)(5660300002)(41300700001)(2906002)(66946007)(66556008)(8936002)(66476007)(44832011)(4326008)(107886003)(8676002)(478600001)(6666004)(316002)(26005)(6512007)(6916009)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3NMIp/uWKg0A+HeQe33Z0vDx458L3x+/vwE+6aeid8Mo2cpCbUMT/RPfK0R?=
 =?us-ascii?Q?9NN0r2gy9zvUFVKFuwj0NugHC+djchtBhJG4GsCWaZQBtTRmkJZoLbEQiC+w?=
 =?us-ascii?Q?cqa6pLPzwnvdujSl+MWSlVs0IMouKHW+VScba90ZqBxtSj6v65jowVOHlBTL?=
 =?us-ascii?Q?ol/XPi8xMgqYPVxSYc+gx1c8FxAgEKNCTF8pJEhksF4NMQS65kI277qlJsJw?=
 =?us-ascii?Q?2LyxiXnTXq03JFebFo+7byDeIvap5fE+bX6wIpO5n2SMC6fhEi6RxH94Xi6R?=
 =?us-ascii?Q?nbCb32oqxZ6vqhZxbCTjr1e/UAcBXNoH04GxYcjkmLG7s5AcpVpyR4RNN0YP?=
 =?us-ascii?Q?fCjSZR+ZWpGuE7jlgG9xP0jhLxvRyfbWW2qpKHE7MQr4lh8YykWc3nmIQ0R9?=
 =?us-ascii?Q?h5papXN/19D97AnCyXmDKX7meCl61kWcPJrZAJyJDThnRSGdYg89wf0DkCMS?=
 =?us-ascii?Q?clP66RFqk4arab+NP/cfgAmIYPWjj1PEczsL1ay3/YKPhZIyceeGeW09JsEk?=
 =?us-ascii?Q?KLBSYGaZFtN/Grsl2UCVdDbeQkH4Rseu65TpMDd5q7/bFdotnPTX6B8ABXpT?=
 =?us-ascii?Q?W+3Iq+XvXcKszsKn+uZiPCzUDmVq5S+R7dXpar4FyjwDDugNqCiMy+EJ/88M?=
 =?us-ascii?Q?Mjw3l9QejrDiIuikaMz3X96V40b8T7Az5VgR+juBr/+awR+Hpn5iMHfHm/ZJ?=
 =?us-ascii?Q?iTbGqQ1l0hD0GOPck1omoXP9PcfpOoXSx3TpFi6aOofJtnZcpqz+pKDa3Oi2?=
 =?us-ascii?Q?tE4K34ZzcXHzDid4+cPu9HfRhES0//ycCmAQmra1MAz42aptYxMNXtjDIma2?=
 =?us-ascii?Q?A3F4gUCmUCWzmfjbPQWjSfK2vcpfRM1r3Z4zVmlPzx7R5mkg57jYwtg+VKa8?=
 =?us-ascii?Q?z+XdNYwsFxIYrr64t5zC7zpDcR05Fg0G3Vo7+nOxiQZwp9kadzLTqmVWqKQz?=
 =?us-ascii?Q?KZjTanf8gaUVrgkbH4W1M9MR4a+l7KFyfKuCztL9CoA9z/ijnTftX4yopqyQ?=
 =?us-ascii?Q?pWow0X8IoTonMXTbpN6fZScYjKjPhW6GQLIcvuv7L2It+7GOE0/wAKPnD6MJ?=
 =?us-ascii?Q?XnOFoUAZ3ZD2kLqJ2DbmgyXWRktab37OjPBIL0bpLXL24ylMLTyULWeS2Bok?=
 =?us-ascii?Q?t/ASPkNFvQrsNE5N8kPUv+qzy9qJso/zPSK0Epft/QYqnjXPHTLipKb6qVLL?=
 =?us-ascii?Q?X6zEuyyvdOI3t8THAQ7e5yliduBHZmcPjPpmRbyLHs37iQWQ6mIYBOafnDFD?=
 =?us-ascii?Q?goSNjwcmiQUas2c2gc03I4QqsxMtzrUso5ne37ElnUn4MAylAxkLXN5fZ4gx?=
 =?us-ascii?Q?DdgURi82aRHYCySEi3Znuu4VNrObXjuKi9xMa/wbkgEuRcAkFscsSWkOA2RU?=
 =?us-ascii?Q?Ky63hVND5zUaJZMe+QhsJTo9WeqK7o6H/y+mRQoXG88XTaI+POy8i17uj8fN?=
 =?us-ascii?Q?7KIPWLHLLJmjnPHT1IbmqI6ijfYMqiYCuAqZSlYKiQaU/KLl7KHGnCllZ98e?=
 =?us-ascii?Q?U32hwKt4gkFZlSTxNEAFZvWw4sBDW2c2q+EC1lX87176l7Eswgjv7Gbv2m3O?=
 =?us-ascii?Q?TSbg6PM5BjDnFYZTSzQ3UZSKqUM1km0HYaABNHkQg32mCYz7Amg7RrqbDSHm?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2023bd14-4bf2-4ba2-ff3e-08dab7290067
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:35.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5O8TksFLyi0DOupTYpROtvDUp0hn5SktLWAgWB3bXJy2M4Vk58vJ2jZ0FSoPdKVf3C7Du7dSXqWXiFIOL0f4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

This patch adds a new member info_sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag until
all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  1 +
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 262853d51e40..54863644e3ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1108,6 +1108,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1493,11 +1494,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1520,6 +1521,23 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 		WRITE_ONCE(msk->first_pending, mptcp_next_frag(sk, info->last_frag));
 }
 
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+	mptcp_update_first_pending(sk, info);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1543,6 +1561,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1617,7 +1636,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-		mptcp_update_first_pending(sk, &info);
+		mptcp_update_dfrags(sk, &info);
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
@@ -1657,7 +1676,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				break;
 			}
 			msk->last_snd = ssk;
-			mptcp_update_first_pending(sk, &info);
+			mptcp_update_dfrags(sk, &info);
 			continue;
 		}
 
@@ -1687,7 +1706,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-		mptcp_update_first_pending(sk, &info);
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b2b5110a2aba..93932488f70b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -241,6 +241,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

