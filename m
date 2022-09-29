Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E82579
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 15:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9l8wELVnFEQ6T6Kr0KpoLgxmL+RqFZp+f1xEYhTRurBw+jLXJHJL2Fz/Z+RP0BH6miFbR/ZigK+kZyvALexSM2dhMqppcGpK0Vgst6o441bxAzon/UCB1m51ZDlnMDtoNaWD0ln5bUhaDS8ioeqNYiPQfGNagzHNBSEhM7ZV+tyxZ5/Xjr9keaSrC16BbOkN7k/FIuVk+DfybutRJIWOuK3ZEVGiattPSdaEXL//o21ofJlUQy3o45VwbeC66/njF7aTI5Qtm/mAcRHxFfo14qBvuNZSKesB9TFBq4hN2DeqB0KdZ3OHDpiSje/eDqX20Cwi3ie1g1GYxfHbHHk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZyBh6hMF/tFTACf4HvquVxyA2bfbaIjuO2c4Kdn0dM=;
 b=RhpHd5hg3We+/LEJR3nD3K0mg+hyHK3kDZRKQ3gt+zlDldazXZzqERa2bgm0MlHHkFgJC8ETVkjpEmbqL9RZ7qmN/Uak1Zyg6oaiLEvHc6iARw0GtLgjfHfXGBVeqlA9PchFMqlVYkpeO4xYfsSz5Vy95ih/tL+ues9Xwe+cX0ojvheaWI2lzMTXhIWFFeNcsAvDbKKmeFTpLf3KiuHlkJCt8P2b/QwWrM/UsPnCrVEauqWdHz0QaRlcISdGmVYPzQdWKUX9Nc4UIEAsdaXbGBXaPvGBODzA7TuHRpfV3Uw3PQR+MUW+slhE7cFcqYwlx/VeNVo1sHVpoaGVEea7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZyBh6hMF/tFTACf4HvquVxyA2bfbaIjuO2c4Kdn0dM=;
 b=hfYfiNmond1t1HwOy4QYUX8uFGFKVRTHkc4ddpbUNU1V7Kjc1sYkwR+h90KqO+TwWr+VEP8/0/VixNXEDTuwwaT2L4qFTBrcAlO9OS4jiaiwfm4JPk4l/dCNyhukbEv+r0R0fiidXi9ubLOQdNzL4IoWSpSh2dlKb/mXGpID3+zM9IeVeBRHi8Xqt+MsPsUSBSXJd3dBv9tyq1YCRf6Uk5eOSfh07h9HwsCrx9TJ4ppToRSMzxwEXZINo6YERmlVMOp0/KlSGQboTydurMKC+1DvQNYjfDRW8wr/+0XFOY2n/TBeC5O6qjvfDsTr29dFaOpYTwYkgOJ4yNK3fBmcqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7822.eurprd04.prod.outlook.com (2603:10a6:102:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 15:03:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 15:03:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] mptcp: simplify __mptcp_subflow_push_pending
Date: Thu, 29 Sep 2022 23:03:18 +0800
Message-Id: <51380f56ea152f419218b8f58951b5f848d982e7.1664463491.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664463491.git.geliang.tang@suse.com>
References: <cover.1664463491.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: d63ed81b-f9a5-456d-afe1-08daa22bbb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M/BkGrcPDyrkaCjP/ML73lt04H0smTrQFTVh1StN5k5ztVwfMCxNyEpYmt4chM4re2kJZko3yPGg+rXZIIJW8dRHPIGhuHvzPb5wOzOb+xLNtJAC1jYCgwKU+uMcB/ePYQSZx2LMfiUT0wCGSLkh5JQZTP0BtqxCQWyypOJyzZXRbZFy3RD4d5vtmGN1Uf/2zwRbiOd9HcHbl6cj+2m4tJFytl44e6ET8cvI3Ysa+1RrPKS+0tBbt8k9MKvZFrGOHgdmsTTSpBpM/d/Ti0yJRj6GJcP8BcTIS5Lx+5ErD3Kxt3Omz7HStmlQLVaOWidWYmFijpZ2bg7OKMwLDctck+no3pU0vZgw+8OsGrXx3N2bNzPFFYku+VZMZ+4dXEl3gRPJoR5YfNfmyuVaUGU2D5X3TZvxoYdO66E1W6Nos6zFvqYybGRburwMwD5b1A5kJ5ElX/lfnnkLCw/OoqVDBlmKYg30epOLVEXWKBpaW6LHp8RX5biChmvz2jqFTZ/cZeto7HLEoAqau9XGS7L03gFtoi8GEjbKH4gC7w8z75WLhK4w8fu8V3W7+A3nbA1fST/moh8WFd8gepP8LN3BTSGtgpi0IvNVNYUu1uzpMIGiDldBi3SBsK1GfzMi1+fKJyysjdEEV0M/llTgiuAQk5x2htw6YxT5mHZfKNeiT9iIQoXWOnTJS3KBA35/VpHtOsbN6wRdHj2MUkbUt1/TjKg7ETbJBWmBJmfdvDKQaXb7Dl2m8bDNohsQhdJyzJW7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(83380400001)(186003)(2616005)(86362001)(38100700002)(8936002)(66476007)(66556008)(66946007)(5660300002)(4326008)(41300700001)(6486002)(2906002)(44832011)(107886003)(478600001)(6506007)(26005)(6512007)(316002)(6916009)(8676002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dRgL3Y7J7utUBXu0DnTJfV84dZSnTpuHuU1/kcUiCjUBPLC7gCWckUnDd4o3?=
 =?us-ascii?Q?dVNPnmkx0qek464y3yBvEruZ7zWrKa3RdyI/XU2nYXvTXF3WyNsPddhjLK+r?=
 =?us-ascii?Q?7nK9PlMR6MG3Kq97lbaWNGGJZuOYorAQwHMsX+NJvtga57cRn/HpWZmQoej0?=
 =?us-ascii?Q?E4eFMYoLnhfw8gzwy5QRTodhrN7WRUPs89WzdXHpLT17jJM10WNGdZ9DG0LL?=
 =?us-ascii?Q?uVAxaU4C3756LbTrcfn2EZaxrG1rayjJMCgLmuWF7E6XX9cmBh8lOO9sbjyN?=
 =?us-ascii?Q?LZYqaDAp8UO5Hdui3jo0eGZtgYDybGmQdJ1wBML9Say7tB17gOayUnRc/cb5?=
 =?us-ascii?Q?ClLqyXF+Ue+nAb5zdxFZomxXb270GH13AlP47kfobEbnTrtEcTJ68qSkDxYy?=
 =?us-ascii?Q?G6JCWwNN1ZX37lk7w3gWllez56gYaJsadFtfsiqbeWs3UaSgz22zySEMeBVk?=
 =?us-ascii?Q?xmqWlPzpxuRZuVsOHrCL+3nx4WIdEeht7M4N0DZq3OGixl5f0/mNyZUfMV8L?=
 =?us-ascii?Q?EDhEXdTjC1ZUrNf8PSDKq46jkBx9lq4a3cjNZSOt+1dgEkXG/Jxn/qG4Ab/O?=
 =?us-ascii?Q?DmcnhMYvPL12Lifi7WKFWbpAeN4y4FPy65oSg5QYzRRNAOGdLm4L2va+dZTU?=
 =?us-ascii?Q?jg4X+LxvWKOHiVswzSxZsbY5PxgSLIPLtxlD8biN0kkXc1nCkQf2jSFvIWVU?=
 =?us-ascii?Q?OLqpYvl4uZpq3uZqPUj+SqcXVRUkHuWNQpmvBskUeQQEa/B1YndgUqxl31JG?=
 =?us-ascii?Q?Keha5StcLdrKZdhuUWCIUsSpyCw04ayr2dwKwtPQ5y5vuuxU1ZV82GnKpO1d?=
 =?us-ascii?Q?qzVcgDY5CawsOH3x6GIts/VpAyGaY/Pi9jccTAEAD8DUVPGtzYhQbdUJ0JVx?=
 =?us-ascii?Q?tJ0J9GhBBkIBqUwL74UOIQEDDOMIIGd7vUw6KHmTpaCW529l1wodkITw2Cga?=
 =?us-ascii?Q?UjWWMVOinwFzkM4DMxz9zRAMPUmxVoAvOCDt2D9mUgxjJ5tELRArBJvbM5IN?=
 =?us-ascii?Q?W76BhyWvnMJi0K2QYPYlGgOs6fd3i4DbscBXWtPSl3ZZZuIB3TaRzPDuGxeh?=
 =?us-ascii?Q?/ZA3IVPlu45QZlp5TvlPpTRV6Qz6Yx483fjgW5+7w46DqSThrN2ZrgoS1QZb?=
 =?us-ascii?Q?lS98EP52mQ/ZyoCYE/M9JuoB5ExJbsH/Z8l/SBQ8kExvhcRxyINJ1aXUI9O6?=
 =?us-ascii?Q?GpGu0E1TQzUQmo7cOrhOaF4ZidJ09iwU94jW2dfRQIgr2biDw9i6QR+4z8K1?=
 =?us-ascii?Q?arEDMo3RvTV4lkH0WGlJpmBVd+Ojrz1YoHlUarQZlfKfoCJ7mmxL0nFPINUw?=
 =?us-ascii?Q?YSJyp8w1yLvgIMWFlDK/TVVLgwSHLID1g1OtAx2tGQHvv+mlffEfwr0IdRy6?=
 =?us-ascii?Q?njoPkPESOetGSKXxPBnkRf24KSmEHLgeFy8cCOtPDZQHlnGH/xwHzpgbdb8Q?=
 =?us-ascii?Q?4kxbG8Hjv3AlOsi+fqX77siaxmGAB3PZDEe8e+kEel1C8QejyHNswinQ1WnO?=
 =?us-ascii?Q?wsiYuW4HBoV8knipUJL5P0n0+T1vHyVoEruZGZnVkRTICsbDA36Q8yjZFgNg?=
 =?us-ascii?Q?xLftfaVBRklA3UEIK0eltzyEs4rwtbKbdKLqJoXo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ed81b-f9a5-456d-afe1-08daa22bbb73
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:03:14.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uVMNOZ2kiRh1nFEzNXWKlnMvFl5GIWuMf+7qTQktfzO1FdQAPSPLfsIz5CMapppb1N/P/3OhJuXbPVwYfG2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7822

This patch simplifies __mptcp_subflow_push_pending() by invoking
__do_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index af37b18aa5a5..8ab98cd89e87 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1595,9 +1595,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int copied = 0;
 
 	xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
 	if (!xmit_ssk)
@@ -1609,41 +1608,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
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

