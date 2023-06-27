Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C44A23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT/7tAAv4Uv/h6B2ZSEK5nseSiYb9zZKifG6B57P8XRfx8IFoAQe1sXKa89GEEep30TNh2bcrJT9pR3B2NxhEIlga515MlcA5J2yMKa9lJNz5PO0qXGCy2wuaa/OrOQGueI7uqEJPu59PqsrIVyww6z2Mtm7xFouvVLDnaVHa80vrznOmHNTTB+nqy7kDAI0UnGtbB8bkPN3qCHijGyYNDu0xMu9vr4bY6iVkFUwS+HkT4fuMYmRqFwx50QA4xYcBmqvivuVNrKgmVlWmS9j57W+WcS4Zolqf+VJzVgFAsL5aC69olrh73yqM/orx9cXx7jCmsxbTN6Wm6000Va59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41/KpC7fmcHsj3PoULzyBQNKMUIC34FasufRkyzRSiw=;
 b=ZCmLv8olQuf7J3h+O0Yg7htZny7Y/U2tKH8NmrwbrlWhGGE74chEgu2QprA0HRjpOlIDrB5NBbiTRjJsNlRDOFoUn2EXFs1WHSZ2UbiWyrE3b05+V0zNgZwzJG7NM52LjCkANgQkgXcB9Rtf1EgbxtJuwDbSlxSJSaFmLI463QoFGXr/DzRHyjBSV1TfjFmqSHwXVIg7II2aIbcc2Yrdwc82tqb68fvsAM9ACtAMdxNm7/Rd6aAHwlWWMICgfeE5QutdcgaeUwDXBY1bnoBBU9UeHlA4szs9XVUiCq6UJe6Q4B9tmFLuNOK8wBaR35RuxKW1HpWbv7VopL0XRZfioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41/KpC7fmcHsj3PoULzyBQNKMUIC34FasufRkyzRSiw=;
 b=KfaZPnMHPUd5/gIVN5nG5PISEsqrTgf5i2KTvcAIoQKa1ysMDr6Q8yJObjtFDmqeXXkppWclY15MYwO55U6qhe5OdUFKq9cSXZDkssJi7gBiPDFii/FywqYdu75Ay8E/jyQfLulCq3skr4KWR4R5IwAaVTGiphd4e1vEhkTbGLRQ9ivvou3o5RUwKljSpsbGmVvsyfcp4sY4iIf49NrtOtzTDDn+OCgOXR4iCcdTxhhJVpOOxlgw2DKfbXcDzMKW2fjUZllf+S7+DQ5k9gB84RqFrfRIXqXYUmpGVQ0G61980ieepaEc5x8uqUpQamqWCnHA16CjMACAPrIRtwH2Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/10] Squash to "selftests/bpf: Add bpf_red test"
Date: Tue, 27 Jun 2023 09:39:26 +0800
Message-Id: <3ced00edd7201cc9bc977660695c269eb8f57813.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 815afa44-55da-4461-f93f-08db76af7a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	13fIo3ePv7MGZingJiyMnjVGESQr6dg2bMYM8t/O4R7Gs2RTOg0bTMmdB6xihXywGLfSdhHkKbmsjMuqqO7t3Iz8oK9zrq1QjG6T8whapakqRugw1WRPIsdGY4JD8inD1OHdgck2oR+0Zt5Rv2ek3+CWZR7lOEgT5ZAzRR02vPEterZOpin6mqe9IEWiOawhT5QJfYMPXZZhUpfpgnn9u4N/dZPwUluqhpI5Nu9JSewke17sZgHqTqV2hVHI3utSMtLpzn0od95+WP/cmsEiuuGWrG+2Nc2y/7qqxLyOg/DSiVT/K4IrW16ncuGmBZ9CXZLi9/w+/cnS70SkZNhhXnXbt2CS71y/0qT18idizrvVklgz3Hk6AOUMnUfGKK42Gl1rEX049nyIfPVeixm9KpmCsHXU82PjDmy5CUuc6DErs6JcDQ0KdHKyiOWqVS3puCisTY9gZDUdOh4jawmkk982AMT4eEqc/XwY76+Gn6ml30WD0SbTZrQ03t+18ecxvTh/eq6zLosaLWR6gTOyKTLAyHpYK9o3bjfyF1Jc+hDhsMQ05bnsRvnQxB0tKeNa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(4744005)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hk+pVTtgVR2EkN7l3F9JXA6O+LSapd0ykma6NEBv9u8LuUQPd7BAkK4DWR02?=
 =?us-ascii?Q?V6iDZtHxO2IxmRQzEpMfO+tgM4WOdewLob97SeeC68kTwdivbaD7M0Sb4wME?=
 =?us-ascii?Q?+qTAksB8fW9v6pYpVfTU9W0qw6Z60XuBaOIJ4EJYaTgofmqbF3Ay9K2T7Nqc?=
 =?us-ascii?Q?EV3CoXlOZ/Fg28tr1rmfWxxKsOhA7q+qrF4YkscnZMMldHaWGAzgf50AFlk2?=
 =?us-ascii?Q?f5V8C6LCwWevFB1EKvpV0eHoQSozQU1CMRnYmXEb27W/vHA5cmM3486DLkCv?=
 =?us-ascii?Q?EO5GvloPOsYWCjagD8H+Xzd+bAD3wcD594uWorlauyMDayCPq9/E7rjn7inD?=
 =?us-ascii?Q?q2Ad8pwutV3C4wENaQlm4HQUsIKMlqqNrPwmf6oTiQASrJvwjTbTqhwf5UD+?=
 =?us-ascii?Q?aqQAZD0dcvcHndPQnZXJCV9aIGa6oPZZZEzap+r9urWpeLwZPWEgakjzmyFp?=
 =?us-ascii?Q?vRTZ8kr4iqukK/r1iUJo9RjGqmEoM5V3YbLvYZ4vEn7jNyU33WdGM6FnrS0L?=
 =?us-ascii?Q?p5t2RIcEUN9gWR3QOBIzL1cw4tiArgi9iHjq/zI7s3iCI7YdObA1qg12Nxz/?=
 =?us-ascii?Q?k8nBrI2ARJ27J1nugOLPEOyOXL28fa92TAJ9q6ciyxSAgDnu+WPNfmbn3Pgv?=
 =?us-ascii?Q?LGpnLjAvs0BPV1tK5MrotYy1CoOqZwnRGY+IFDY9dIrsWy8avE2rHUawcume?=
 =?us-ascii?Q?OKqVldz8iTSy/X4MhOgr6hbrdY7VGR+6ITHnfBHccDlatehDXvoby0WgFeKn?=
 =?us-ascii?Q?fQ3cqInEj27YI0h5lswS2+gbZi/8UmLPrPWUsg41GSNDOzZSr45ViZjmzya9?=
 =?us-ascii?Q?sBcTmAH6nBp4OXwb8sjQDcG0aokCEXNqJHYHnKMB7aQFA3172yuUj1h1aZrE?=
 =?us-ascii?Q?49e94ZUuxltwO/diyjKOrH0qDzXtKeSoCJ4rgJ/SOuJleSUUXooIcJGkMkkJ?=
 =?us-ascii?Q?O7ZXhBIsZShEzuLU2eeDg4Gxc4ZB/wWZKRJWj7hG2RgAoM23z74/2qPkXBGV?=
 =?us-ascii?Q?ksOWRKaI+OltQ+lR9D7WrsuHw4LG3oTXoPzKa1ZfJGHj/iMVhUa4ObzuNYp4?=
 =?us-ascii?Q?j97XDDN2FVgSU5aES8nY7KkU3GJuTa4RzyL4ITC9ekcgqKducDdl4jYX+Bae?=
 =?us-ascii?Q?ZpwsU14ciem7ey5J/zNTVuRxQZXJdzYFczD5bYFgjzK3pnQkdOnM9gfFxaAB?=
 =?us-ascii?Q?8d+RcdL+a4wX+Ljdi1BLlZRf+eneOw/y41qkEP7QtGbOj/da/5I1YGGDPNbO?=
 =?us-ascii?Q?kw5latn69oheOS0yqXZQYzQG+Cwu3GgvUA9wrPuao0fAZtfjzp2Mgk1Eg9Bo?=
 =?us-ascii?Q?fKLANc5vEgLpeA9lX2Xw0QzL4esG6CPCHnGV9hPcF1Z+5+JTwLyfJFT9YCQi?=
 =?us-ascii?Q?bb7XH2b4LulTeAXCaIciNopI82GnlOi5GFxrVlmB9DeU4cDVz3UlYfPU14KC?=
 =?us-ascii?Q?Ycb4y2PdrQQHI2CfQwz9O7EmsTQaxuCulKTqRDaz5I7C/c8GAxz9IJI+8PP5?=
 =?us-ascii?Q?06MewDeaAqICQUTQdf+CT7l69B823EvA9hdzlSKSaIrT0DrIVQLOLmeKelgw?=
 =?us-ascii?Q?L+b6pI5HjtGLyoJlD6J0z5EdOUDsliqQCxWoXgW1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815afa44-55da-4461-f93f-08db76af7a94
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:25.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdJF4tDGQbK3x4ZLg/CCzMIdFMlCuF38+MAdLmt8QduARndKQndol3WVGhviNdJace4Kb8KFHQbWs3VBEAhW4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

Update send_data().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 0da7f83fdaea..4b346eeaf8e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -476,7 +476,7 @@ static void test_red(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_red");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
 
-- 
2.35.3

