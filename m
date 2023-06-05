Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0315684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMYXNPdgU9XTpIqfwzbDyxqKAgdZ9jzUh2ZyanOlLQHo3+hWOPo2EEmiZVZaGwkTFoxxfTvjLffpu8heL6fjNv1ZlFYLag/jK9RJM6U2ZW3g2QVA0xZCVvzC3RfDvpsU/xJsEjJywlKJnZV561ZSE0V4XKwdEbaqcqka3LuoxRxix/Cq1LCBHO3e0HjJZ3XwtlErdOCC6qI+mgsOzhgV0Uz2nGAgPClfG82Axyw/sqsNRUS3YpEwfR3sT3gGHYxBopu1K92WO0GEXhr6+g7e8bn3Y1wvIve48oOKWCkxqwEJbz5uIXqKI93nP/jbyIpvNu4J0GvTqa/d073CKwIXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=TF9Fav0VE8+JgWC+WjOdSQB9Xm6S2sO8PH8Y2B3JBkbNGgva+jip2F9NGhF51MXqDRhD1qqxMBEUMTmGv0SL5WaVobckn1YveVsy7hc3r0WHkirwMThTc3A9Kq6sVkvIFd8cZcnDBPNzQd9c9zBHsbHKmlGdBG0UADbzGUBzKD9i2qbU81bsNYMaJqBgBuwECNL+oGN5EpsBu3pJtSKHgaYyG98NDEZaurU3cGS8AVNliK0dhdSF7Yf5TTi2mRMvHbqrVm+l2PEGKQnlg4LABCyBeL+d05qSdlyrN7v9J7GcQx5s5baIh/IHoant/3lgqEMugfnPncs6oNjY8Cyk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=Tgr/awztNgPXmErqid8XIDaZWa6fgW5A4It+kyE/sfZWOgdS+Wh/ldOLqO3P7tKbh1iF9qHf8c3NojX9BLRoEVbemPLWvS/WCuBaGW1gm8ADY9X1dbh9oVjYdQfkS1IYwXthuK2yL0is84OW16qkUeO08sqQWdxFiAsCNzIf6AxUL7BPuvzjJxnL8kOvwrxgW5PZl2Fv35w/gWByIHEps8yM4tg3pEIVWsgEdO4fHMBI5Md/bxWz7ja0huIJ+VsAX399OSEltwZgdDRtCm2Ck0nFZhCCfkTeUMkr22c2Akkjqhe9YBoTe2G2rOwwK+UsUqJrXnINymHzl41xPr/Q9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:04:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:04:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 01/14] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Mon,  5 Jun 2023 18:03:56 +0800
Message-Id: <01027826b91ca75bfa53d91ac41ede0be3cef634.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 98625249-e4fa-43af-8160-08db65ac3e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F1kxZLTC20yOTeCEPNq0LpDHR1YMsQIutYJaHxn4jJfT5yLTOr+oWf2HHaUDCtDkVKMQ7twOL/ZD5ANxpkIDSkgyeVhTBbaxiqA0Q/6wH4R2dtwNgk94lhOQGY2IrBDX8tUqcm0w3iOOrRAWaW9rFuZmxPlT7yvdoe9qXmCSTlo3Gks7o/4ZllG6HOMvR0OHjLHWL7eB55xF9g5n+ByS7vXhQ0n+yAwR4WKMrOhUMnTjwnGV+OT7Uvmqpa3JKuPHT50ofmIQCopadm3hgBNPkGnaVcRmotlqvzEncWpP/zq3kbonB7Zi0/UtZf7BXNKPqX2Z/xKbjIfQdIWjfb5Qnw0q+PV6EGWKe0khHh9E7Xda8QBYuv2W78NKE0/Vh0kMpPTfX2UfA21hyQBd0rgUaEMh8k2HVZAVHzANjmc1w6Nb35YQKwHCz3+wdCVuqwZAQdBGVfus6RSX6aO4e9PynS7kdWX+pSQ5qpak/tCSbhPEv7PDM7XIxHqW5td/0wT4vlsJn5KR0UAfIfRM+oSutlqlHda3Df2kXXwDmZQ94U0EeKna6Dzf3QKVFcH7201j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(107886003)(6512007)(6506007)(26005)(36756003)(83380400001)(86362001)(38100700002)(186003)(2616005)(41300700001)(44832011)(2906002)(4744005)(478600001)(66946007)(66476007)(6916009)(4326008)(8936002)(8676002)(316002)(66556008)(5660300002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1i8RpEIUiPzM2R5RA31b7PICZ929M0zypqhRiD72q/rHFJTwHeVRzb8VPr6l?=
 =?us-ascii?Q?QOgCrCPkNpYEhkz3k3EwLY68TVe+QnLaOxiphnPgTJA2u/S/onKJdXLMG9MQ?=
 =?us-ascii?Q?NQYtyjOHQFcmH6cCKa0MTKfylX8YgBm0ug0Yr/V/DETdD3c45woT1tBunHhE?=
 =?us-ascii?Q?Kkd33yK0eBtjMcmBev+qG67Jh/RziP87NaqViwmk1QVbsU2gFxRQVXMfCzx+?=
 =?us-ascii?Q?VN8F0JcF2qtQifmJXe8uXL8R39+k/YKmXIw7h3QFoQeRnOG2lHT9fSe8O1PS?=
 =?us-ascii?Q?csH59mkKqop8c1Mgy+9kCHd5nBlzxhyPCWBYyecSaiqGaBiEx51T9xM8SWWK?=
 =?us-ascii?Q?lC/YIpjIh7aChVZ+ozsO4V7aVt/ujgFBpTO8qs61cV0AXub7BWY37cgiTSLF?=
 =?us-ascii?Q?tTN9hTZTZUAmo1m5pxsZ+DU4EbuJsUTf2jn1meSVqmP/Z6USpK2jbiQHhBDc?=
 =?us-ascii?Q?hjvEmIUA7+A2nciPaXKLkeWS5/WYxdcCOlTwy8f5MpR1EH6lJXC2hkRyDl+S?=
 =?us-ascii?Q?S/oYz3Yh/m7VdO5+a9BfPdB95qn8vcuaNPO1A582Tn8lRisxY241gnjmYUJx?=
 =?us-ascii?Q?AKBRNk+eNbx2a5CSlEV3ImIwuVfQDJwwpViRlxz23Zsnvtybb/BrrWMulFtX?=
 =?us-ascii?Q?WVLJe3Cms5XpbX0JGUFNVEG1iCm3t4T02BnzLTCa3b/OtA3MS1yy6VtasBa4?=
 =?us-ascii?Q?B3ao3mLlfHozVLULpr+b/9Z2/nNBls4ubyrMeajoBMd/Qpl2fbG0gzVN93ra?=
 =?us-ascii?Q?uubszh30f81nItJ5Y9Oe4gvAcpaJDJVygvsw+Jesr8A9zerdfukADrHD94OM?=
 =?us-ascii?Q?IWWx21H9Kc56yhiUxnk87oHMt947kH/MCAByWQtS5SZ6lP0O1UbyaVOvYwfJ?=
 =?us-ascii?Q?c+YhLn+lEoBjdomfp8UjvxkoVg/2GHnKXGO/UX1Uy2rnHUmkGbjqC5vYpWYw?=
 =?us-ascii?Q?ecxoz9QI2MW8f8p0CVrw9XmpxLDdd2CzrR9O5yUWmwkCxPAgP5BwLUpWYA6G?=
 =?us-ascii?Q?pELvBfo7OIZUSRvOacSAkQhURbQMBsykvATm0M3F/fEBXk/QdqVgDK6g6tA/?=
 =?us-ascii?Q?h+swt6My1bRXvFXgzcih8q4TKGvhnVvb5jCDSNx+ovilAyO5Kj+a7GkRTdnm?=
 =?us-ascii?Q?5W+8jqVJodjwgXCykolYHVUQETc86pg8S85lhZtE9V7SP8lHVBpVzRv176/7?=
 =?us-ascii?Q?nk4M+n7Cy9whNGreI+sTsZsLz8iHVZhNEDIIfBMsKRKDA2oX3Elf/9Hzt8yk?=
 =?us-ascii?Q?k4u5k2HgfwxM1Fj0YPWylfMFxSG7g8XEAY9sc1xxSo+y3gS0t1NIo7WtwEIK?=
 =?us-ascii?Q?q8FKCx/lcYRaP0BPRQYMCYn196KzTraFLP5jqCnl87pyzk35yerq21Ak6Fva?=
 =?us-ascii?Q?9BSIkkY3eFzpgXggLGFWIkD5+qs2sDNPBm7Svusqlp2zHYnMwocdiLIFCAfM?=
 =?us-ascii?Q?Zlxw6MN32pX5JgwLssd25sN8vnYnLiYI8bN3NhGvn1KvKEQl9fU2gvorMJOP?=
 =?us-ascii?Q?Nd6De7kPZTRbu92TDTEER7iwyQc37UvYPfnFIqMmEIkQXR0IDxedwqbdwEfP?=
 =?us-ascii?Q?iunxRudt2AfJR/uvygBlqTdsVichHlnsI1TalE+8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98625249-e4fa-43af-8160-08db65ac3e75
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:04:26.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqPCb6ImaGGEUrclrMNtRqwbSfvqG0JjtE8NCL1kR1KUQPUrLr2dGyArLRcZb48a1GqnKmVHJ1zqC7YfJVzbOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..4bba29c99172 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,7 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
-- 
2.35.3

