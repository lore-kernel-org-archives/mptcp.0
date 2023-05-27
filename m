Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B820EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVvUw9jdDcPp/FxGZGyKU3N/gjup2r2AFEtA3RHs0bpgW4g4XCRyLY78yzMSzv8FJnm/pNXuyoC5xwGZF91ZHtcMtbeG0wkAu+Mzl8776qh8ni7rQrFn59ua0Xr/b2fxys7Hj88BJLkHd5y3CJESIp/dmaTYtyfR7HomPfKfAfqUYbkuRAng8apMH4UIKg6BqJ2KrqAJ0UduLAhPk0Y1nQKufJXFeCZyRxQD1aBWeoqxciLZ7RZkxvh+JeuFYr3T9b3rPDEhyGhELdGySZWUSs3P1Ll3jnSS/Uj8Lt1Q3JSv7yGNZLSGwf14adzjskdVnwDWFDt4xVRPr3J9bH4zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=fvWjQLRmBLeZMUO1SAZqeqjVOv37RiaH4klYMfweq+AvXysHUrCUAAw9LT5q7JmygP7vwFo/TZ/qJyfUSwJEsrdJ6WKV9i/SJz2pNMM+jlNBZ2RSg5QsUiojo64Qd3fzOKGIuM4H4qxqXqkZXsNEpsu+YWqcluKrlriVuEuyez30Npik4f3H4KJRzv4k8D3Mru/tgTQ9KKJhVVJrV2aBunBBpeQfZPbimweMkX1LXrekOTc21i7UA33rQrWsnqXIuVkmxNtbBJeby5yfseWSloQfP1zA4cxdyeEjgL22DevIlDP4ltqnwkudsx819GcYIkCTIMeW0sYGxf1lAZQUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=YJ/O/NW71bdBdzgRRtIMh7FuVh0PzvXtYJRe6rTZlcM8Z4GyjyCkoNUsUB4EgbLKei3ts53AGrz2VO/yQIDHH84DO+ravFp6hPHpQ0AgJqxdKkU2+oiUiTN1XFTgiubjvU9HZgSGOKwyvYuYfKyIl78Rv9AxGA9gDHpqKq5juX3YLQuXiVzi5XoBMl3LzWrFkCtQCB3JARyj5fGSojEGj3pjA2NX9dwTepHUIFDSQSK+HUECI0KOvxJZcZVQfBtI3Wd4KTOw51nm3mK55/oP/QKTN/3+smqy6dNI2TVRH5zAEZ4Pb+kd+aYpfVtR21DhQSaGSSbYGGHfr97XWbay6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:55:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:55:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/8] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Sat, 27 May 2023 20:55:30 +0800
Message-Id: <c8b7a2ca10c1460694d04e2d3a691f96e22f227e.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: d92ba660-899d-434e-feea-08db5eb1b1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W0FblKBGlzEhSnd9rng1Iwvo4JkqYAFXjTwl2qjqVj0/TyaujJ7pdjljoDIcjYHsqNo1LBkmRCCztgHhh/mdLG2g6C/6m9sfz/dUnKMX7QXvaWOY1T4Cy5Chct/C2vSHtne+ucZlMJTNAjlE7K/RIPIMsP8blI75fZ3iJxBH4NSVnOtU0ZVmta/V4lfkh63UaRkYoMF6WPckJx1Yy8/Pzp/u/ZttibLRnuO9TX+oI8KbGqqY1VDefmQ5I5vHkuhcFELgRG3AYRfCs9HVASochbIBRDRbYNUTyJgZorF7NMbbmNmS+LDg4L0v90WaaJ2v/pm9qo1xVRPEGsw6hMeNkLwkXOt0nL7n/fyFHZKU5GVBztWc1BUauyoyW18ChXNnU+mVJMxxTvfx5DMgKjU485N9beUVEbW+rbO/ffjvcDT+yGkLlQnqncr8rQrcr6jmzv1bp3El+OeIB2925iMn2hO5OOGMlRINvRjuDNUM4QFCaM56H5YPCMbQ1/GVy4Eo0Ff+Uo97YE0NeY7KXD/6eGAbXIkRaNhN+ac9IdRz+qjk5kJDrsfF3wZMgAK1/ZQO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(4744005)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJPi6JC2yZiopT1Bo/Z4a0zWRy1JcrtazgpvLCAikKf3ygyNhbGtu4GM5BlE?=
 =?us-ascii?Q?fW0Ziw0X3Zss35hD1LZkWrz3aJMSJdXECLd+YOSWetAe1ZvhQIP/z2ATY0l9?=
 =?us-ascii?Q?8DEPkvU8OV3hTzmfB/JbdWaawSZsXnrtwGLecnQSZFJ6L7sQ0ZnWgskYYb+f?=
 =?us-ascii?Q?JxSBEFbStjnpvlQgcBy8xUoG6eHPUO6PC3v9r2WLuYOTQxw66zfyNVPrmHMT?=
 =?us-ascii?Q?gjl7u4w3Orv4G10FRjhnf1XuvzXBNL9+X0SYOSmCw3a4+yFWiUIycFB/WrHI?=
 =?us-ascii?Q?iS40RcEEAXRl0TXKBtCpYZPpgHTv64gsYJkbY5s4Ab5/+iaRvluhX3zxyRHx?=
 =?us-ascii?Q?D8cJtdf8dlbPamSHy5xQbNMZu7ofhiRRX1QFWvl1bMV8wvodQD9hwF/1GMLh?=
 =?us-ascii?Q?nv/m4SDzenAUL472ccmrsETGCLcqgnP23iqOG+xUeyNoSPeA5FUrGyYJ0jwQ?=
 =?us-ascii?Q?hy1FYIPSvrTQ9F4P9QmOzL7vLdq+tpslEQwpcxPH/RxPTSRXiFl/JV77WwlE?=
 =?us-ascii?Q?WxOfNgGAEjWYKSB4Pf0hSf4lz7ETOWJhautlGonFLzSMFk8PwS3wtt/5L35K?=
 =?us-ascii?Q?djHzgBtv8yknc1IEcGRK2UG5ufFPfWwv2CnsMFQ8rIb5zC/xhcpFLJX0aRYo?=
 =?us-ascii?Q?+kxOLTuKEChcYW00MKN7sF0EPC8dzP493FGIuvUg07qpyjrR5d6lznVu3fEy?=
 =?us-ascii?Q?ebARPCuRC+ny6RVsSoM68hVqd09lGa90e0qH1a6VRM5DdcpcJEHsUQgodpSL?=
 =?us-ascii?Q?ZDKlHqNORXGGlde5BXznPzFXdn4Evh8Ipg1csmxoYPjUW/kvJVg1ZvhF4JYQ?=
 =?us-ascii?Q?U2DOVmhI8iwDBVl/MpMn0I92tpc134wC1uN7f/WmGjbms/kJm3sfVDTIEWTN?=
 =?us-ascii?Q?/EC4mMYxC5Dn+jr6Mgo/A+0RnPbpi82ZZv7RvenwrSD2NLQHvSiTFGMmuFyx?=
 =?us-ascii?Q?q/OMG6jFqjkw5CQM+sYFVYnfRh91qVtAOwCj/ngPJFnkROnts+CY0zarbkdE?=
 =?us-ascii?Q?7KAnBq7dwRnAw4YMHl69AQ6Zw/upZlmhnDv/r+Iyj1H09P4mhmTqyKFJJYes?=
 =?us-ascii?Q?tHPAmzDXq8XOarm6PrQdxBlVCiF7R/T+g2dt5yinDjeQjDIlN9qFrs79iOny?=
 =?us-ascii?Q?Sfn3FLCq92BpPVrOvZZLFeKVWx6SGz0ew0nIuY+unpG4CDy+pKTzhPr9U5Id?=
 =?us-ascii?Q?EusaZunEFRpNm2qAakB8GF9fmBctLul+ejnKr3yvRGyYK2nbM/jtQE9/z91Q?=
 =?us-ascii?Q?vYkRIVtw0UgiJbAvQ/v8wdHsbxQQ3yOka30DgrQMtqfKw/n6uGW/Y1pbsyuM?=
 =?us-ascii?Q?eaivS1M2d5IKk7wlopBjSj1v8MFjho3UK3riy6zeEA/i0/NG2W462RvlSzvT?=
 =?us-ascii?Q?guJDhH4zqYdKmdAx4OkL2Sm1tyjL0k5VE9Fk3ZpY7ddQwiWrmOfLQtxsGK6u?=
 =?us-ascii?Q?EwybJPosJnkpBc4IPeuwlqhX5y4M0BLGfR3P7M8BVzobna3y5AtSx0bWIGB+?=
 =?us-ascii?Q?AdjkKMbxDARVjLZxUh6xAval1SR3j3QgLZ+ptEciu7/8eSZWVgNY5EoDozDC?=
 =?us-ascii?Q?3JyVcZksNQl0fYEa/RDXnrhMvhJ1JjYyd3f65/gy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92ba660-899d-434e-feea-08db5eb1b1a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:55:48.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmKmnwIvqSm5YYlTIQOeRzsB+bANU828v/iZS8ZPKAEwWZeD+tN/lrpxlqIgU5TtfaeOLEiOh2qgk/kSVsLGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

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

