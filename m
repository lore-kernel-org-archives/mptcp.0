Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B451DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXFy06TFPgsTPvV3GuJW8s9MlBG+5xRb80FQuk4PxF+OXRaD+vKUVjI/JBhNllBPtz8WFdNeJRxjR/T9+qNl02mABTKErdIRn+95rbg4DiT1hIHzxnqT3veRx8zoAo1TsGb3r1BVXn5u4NMEaEWD0cCGGWYc0tMOVDCfkw0XWEIXwE/KENRXSLyCPyuxLcOI0TN/yzlLO2fXO3xmJspbaWfYmj8HUWwiwtpULHKW/dlT7IT4L2/pDBlFzGurtMQONPC3dcVg3tRGxX98rSAZwOjtMMA1h+6pERPTfwfvnnlpQB8f6wDIMKUy5amqM2+YpLM8nqkBcOYDCauRQIZfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=JLMqvR9QR1xBfbFTiwjoVnEBLvIpKmM9sTs4yP3U3Bm6IlhAoiGFB3ZLQ+Anroz7XZSBjMN8zgXNoTyTnEHYCazD0ZZzGtITx4rtqpv9nFAnRYAHa/6FAcVBBZOAPt2Bq7OlQrDjTGSHW3gY/RZOPo+733n28a2ZDMa9SX2J8MMwPEOvX5U4CJ4kDxSzQyAx8PGdY/7Y7C3J7/9DD2tYH6iBJjMEEdRQ5tm0Hun3bMtgJ3KzFhrmbDuSvvXZKm4kLBf6NZQDHOmHM9/8NrJEIi5/cXm00GqF/PuOZCWgokMEpt74gpXD76e+BiA4thGzzhy0iWao9PC5bbPlkNI0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=d3Z9IherJld+hWkXGb5jESJAfQlmnnISVWpkhg7stCWsHN6MzbFZVwSGxWp56t18zwzsotGlp7UzUMzt68FdvSDzk5Oh/E3IlhPzZOyZYc2TyBTCoLlF6tSXO1aPCYPRdHRF51N4IwszTLfJnFOLzVNCq1dnI+7aPFDmnpsMa2LP73Nr+tTA0pIs0oXKhjVhvAC4wK9HvOhwbtPB9+ONbjhigoiokQ2wGL48CS4xnWuMq94rFVKZzX8fuyIFYU8lr9h1RTHSqcI53pJEo6ZKMNV3tyIhdYg4XT/9qbCTngtMh/HvILVjOuAyJmsIO1+E2HS8ohD7wWybeokSsP+Pmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:17:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:17:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/15] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue, 30 May 2023 21:17:21 +0800
Message-Id: <c8b7a2ca10c1460694d04e2d3a691f96e22f227e.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e36db67-c4be-4ccd-5d7b-08db611042de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/I1GyOX4i2SNwUWx7dOr/7MqPgpqsA/Es9YhRvZQE9gnxzV+fd6m59c9FkS/T6joHLNCFBpZ7hoq8MIDLeqjUygxTXisXEjaf13ck07RBZkDaZk/AFnFiD5JG1xwhDyK4y8d/Ab3IL6OQeVyMFf4pw6tRHHLA4IlAAWqk5LHt+E7SVfbHGX0K/qV70gA8U019SvcwzWpaYCZZxPh92GURyymrDqI6IbXmuI+eklyOsv4JmYcCCI6ooDyUFhpIUrFoBbgeSARVzL21WbtbVdPtT7uHcTCVWZJn6VG+Hde1KOgUMchhtZQT9s7pKsH50hPdR3b7TtvmJiPt5PDjXBExGnXwDMw1PrWK7jlp6xItWKjDL5H89xLW6h2C0spwwNMG7naKRvXmlksbBvzGiO20Fg49/wBQZ7acgtvOx7Od9TIK6wiqcurxKC4X7Pg/P1swbXV+RvVhld9EyOII4x7rAFJ6vCkW9HcIBSXOAErxACzRgwFVI7RwFyssB7lzwQV2V4N2g/z3XsjsF44nyw6vh7jr+S/07kDaGMOq8pdyU/EOxu+bRwNsjSV5cxwIglI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(4744005)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHBDcUN2UY9YIHzsRgrPp9eNcvtxkTPo3WEI6lH79jppp1bUJOkdYoo/GFXG?=
 =?us-ascii?Q?Hb0g7UwgLxofezSAbeR4EWHrIH7fkRkNkaIdOh07cEU7xVMdOewm+aEL7J87?=
 =?us-ascii?Q?lKQH3LKT8FROC68NbyUwZR+PntxVHdHKiDSu24vXTfPhFroHOWvUkX2TcDxX?=
 =?us-ascii?Q?sI0+hUhbUP7oyN0VPbYLKR4KuBZTzxwUjZtVSnrYnGu9RkrblRtV+FFpxUkI?=
 =?us-ascii?Q?aAMUxaLheuTOZlgR5I4WLsJqq9SzlUR2PtlHFQyfMsBMgr85FTBNgm/9LF+0?=
 =?us-ascii?Q?FB1xa8pvHaf/LBLvAuJ4fyQ8J7SCXPJTZcM2ZSXFJ6JtJf/aSZKkHOxJbkj7?=
 =?us-ascii?Q?M2o6m0VE3XrOtLxYdbmeOajhBr1re9UHJrEI7LDKFhT4G5dBQXOsZDMKBseS?=
 =?us-ascii?Q?H/doDGb7rPQcvZxnb09v+fLYKmt2wNCDZZOI7in6Jl27dUnnpqBZdOJNcLi0?=
 =?us-ascii?Q?ebCdddCjai/z72kyy5mLNc+N+V0Area3mg3vTWMDsFmbkiZ7pSjmXLqOt+j4?=
 =?us-ascii?Q?jXAtuI7AuIbKPoDiTqzSkG7UPzc9lUVdA0tEYyuWYv1msW3GIU0LBbf+iP8y?=
 =?us-ascii?Q?GZFzhOMxiP4Okk3tkXt2SF0rA6qnjwwPZkli2B/X3ti6TmY4dS86QVCYYHWx?=
 =?us-ascii?Q?gv0qBTzVPyFZI8lfpm4arwRBTEm8rVN1WzR1/otWXZ7GpZ1IDIytSMrJzaJ+?=
 =?us-ascii?Q?JSbuo/fgf0dS2E4a1+thuhZCViueDYrdOhKtcGsS428+DSVLCyWOU9XgFANE?=
 =?us-ascii?Q?rUWH527qH7PSMU2Bq6HYgeDer2WK7Ta15gfIQ42D6hHh45RfceRguUqMGUg7?=
 =?us-ascii?Q?QmMfwc3UI5/6p8Ef/rd2h35Z5agT008fPY29BXQx/Cc92S3z0EwyJFa1LxnM?=
 =?us-ascii?Q?HHhgyGE3stKYl3/+M9n4KHwWh2+BXFNhENCiJ3XwLxN3mwlSf/ReQHKhLQHn?=
 =?us-ascii?Q?Q73pXprKw87p3HxIAvOzxw1Ou2DnDBhz0NUyWhGAXxLyLxujV5wAdAB2xJVN?=
 =?us-ascii?Q?UKxK+hRRPxXeHEU3ErfdFCwLSpl47EOTeUQ6saX/27j4cSmk44tekn/QeWUL?=
 =?us-ascii?Q?5xYLEr2IpGNahVGgsOlmkDR9rzmVF4DFA5Wg1UVwqNe5EICiS2C41aTbz3Oh?=
 =?us-ascii?Q?hniF9UmBZsv6wPQT4QON08ALzFl1aLWkonufO3djtRE9I0PtLtDY0hMqNW+J?=
 =?us-ascii?Q?pgeC8Ff8ywbjvIsd6vROu+YsSqYSlwyprpZQZPbCnpKjjKgV4+MvSAP81J7w?=
 =?us-ascii?Q?aq+MycjcmdCRpMtktQQqjyab9dRpdSgx3+3DCB3Rnac+Z71+N8ghFD1HfiyX?=
 =?us-ascii?Q?wFlNLBag6yLwSqzXWbbXYLbhjsNS+3bZ8BnsHF8uOheTSXF+9eZxoBMsU7Gs?=
 =?us-ascii?Q?OZcwaXGyiaZbLBU6LDZCY1bc1Lm5oOo7dV30E5f9KzXtS/77q9pHW58OQ2dw?=
 =?us-ascii?Q?FAIHwtFh35uT0VoWUp5Z/xShHbvuubd6dhS3GCw5OUMlHwOon3HEWDazzeaO?=
 =?us-ascii?Q?XNXoQ7RpVyVkHy9UsZ6KLiJvYcCUJtMKMedIEtMt8u58tGzH2jtFV/GTW9zL?=
 =?us-ascii?Q?cfmH5NyOCVSqeowaRY5Ljl8Ai7VVq/T29TXniMhU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e36db67-c4be-4ccd-5d7b-08db611042de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:17:47.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGb2Yk42n2Isvyx8U11IYqyVJR+5WBztWGVCJR3jGTGEgFkKjNo/bsWtM9jUF59GBC7JeAx5ni6njRv8HrKgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

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

