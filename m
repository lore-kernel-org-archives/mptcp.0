Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30A3D8A
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTKFyEteoiGS8JvHX0+1lK4GMGbP+EKDlqCXPHBBSHcrPQAoMeiG3aXtMemDIHbSCd9+5vOn7F6bwDB63Wnk6MVTJclV/Lh0b0sHI4H0qgWN98t+bn88TtuabK8VK/zW4EpM1afySd53PpEr5EKM0DiTqUi2Ua1Fw/o1LInO7p0cez42rhOqyqp7OJGHoUCrWwCnjdA4CpTcuwNIrRyFS/+YiADAAbKX5cgOGbmOMHy6h3rWDWz489orDkiboWHn6Y2uk2JMMbOk+spV989e7ZjmrltOjmq5XJUVjrTBpzKdVU79LsdYg/dA3MFprjouZBuY+z1KP5cZol0clBlLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=DxahDwiU7dgtQR4bIQvxKJNaTCfTfvzJ37fD+By1pua+gUI4FHr+akFFb2cjaRmGQahydOUgtC2iw34gC3Zj2/oVNChZ1RildoCPHCCZ89ffy0FwBV8GcMK8FA3VPHXAnrgn1l6ZIkwX69e5mKBEpLkvpEyJNHsxU7XeE0bLOodWyRPat30wmp3YzHMvUHbMMuSJfkDi1145+mI99//4eBt5PdCwH6R3F/mfx6ackh2JO5CSZD0dj+YdR024k1fW4/2r91i2Y1kLgYHcms2+K5ad9wCKf2F9Xf4OV1ENK9+i3Se8rEh5yGf+vgLTqrDokUqAa307ZlkbN9Lw+OfqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=FfyFKgOUl50W+EtaZXkVCZBi8lrxgWWGHUyHL9Bz6FOz5SEi047mYE/xTDlE1FuwxNUzfDd5OII2qAF987+Igxkaz1AaDDZQVcg/0Yd9xVUlv29zMTwCkSjgNw0bxXryDQsx/SXRnab244pTBD3MQz2W5LKFuL2+/sA/NvotVI1LjXnk0ahVzhZZ5S0vUHmRGe2CyXAGxZNpt2QThlGM2lYVWotlvvm0FrKTo1yQ9swyjK4KUC63caP2ZhpswqxaC9+tuIM4fvevXV7ownq/HbTcS3PIcwgft2CH108BqiBhoAmPS3CD7ogVp4MRCcFG88pvQsCFV8aPywTo+hp92g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:00:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:00:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 01/18] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue,  6 Jun 2023 16:59:15 +0800
Message-Id: <01027826b91ca75bfa53d91ac41ede0be3cef634.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e51f7b-6021-483e-efe6-08db666c6c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y7z9g5DGz5ydvxywJ1cPxwIWencZpCk/gxZddCqvchFSWjJgxcnFgaXw/WnfLqdt4IV83KABzgATUxIt3MXpCQlra4iLEcavu9BdgfMm7TtJ2ttpeLwCEVExUayd+IPYUrX1BkkflNe0iKEa6Opyo9P2FCOlA4dwVR8LAHRMllpVC0ybHhax4xnsYIv12RD+8epzoaleni/T4l/wLUXMOp1/CaB1uSoDkjgLZlSToRLY+kqkoYlTMbZ9VqgUZbPqWb7/8GHEbN9EItL6eAoXQSFH/aNW7ZYZ0bfZwdD2GzrbTya/3FXWIjN3EapvCVSs8IyzgXDr2sqV1bHzfTGkn8EisnBLl+NDiAI/45qlfHvRDEt3A4AVQra/ARkELVn/Vp5+lwJ44FoO56Bbm8RJkSR8PFY4Dk8DVAio5HFoZDqVxgtG80GDileEBftqxhrbOanz4rJDfYDqsW9P9KoD0qiQGb2Lor0Z6NDTkqIIdueh0JYeSX0z2DD+sNhvegkO0r3/06KQMol6q65D2SY6Wh3uxS6teYICksAHeFADBw73sXtGfyIavjOSQFRjLa8r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(4744005)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q9DYvMMSFtGAorO554g2l/X40JCWkttKt7Il/jfg90OHNn3x8tsXX0PtKL8f?=
 =?us-ascii?Q?6XuKK6ZR7eNHx/NFCAmFXKYm/1x0Wl1dfY78opdzbI8yb4XY+EcCNOW3lekU?=
 =?us-ascii?Q?dU9T3PwjK8Lf2c2hyvcB1fsjVrGOEzSQJBM9MlH6OA5XBidQWhmGbSkn+tDd?=
 =?us-ascii?Q?n5leP0WhrRLIQ+9i6cyte2Y5IKUSjQ0+RqPDcA9uE44lnxEB8SAau9f/w3/0?=
 =?us-ascii?Q?uxQIQ+FnCbU79Wr40gcdl/uhdut9bxqwgg29GwRiXxMgHonCMsNm/nB62+kn?=
 =?us-ascii?Q?xu041By6Lo9zWHzZeIb8GgI21GA4BsE0+0M/Tj+FzINeDWpYfBSiWJfrpEzF?=
 =?us-ascii?Q?6PU5wPmxQqp/GuUk5Q41MRLKeQpbx/PdImnQtcw/ba28oHo+9OJDSIvwllnV?=
 =?us-ascii?Q?wuub7cMcjj4+wYY3fXOtbBXacTnO/Cr4QWOKIBv4FOULVcTQFMS6Ns/yGqmw?=
 =?us-ascii?Q?d0Qro6WCTLYxQPIbaAxA5nj62XAsdfJoJEoni83bWNytjYlE2xtRALrlfd8w?=
 =?us-ascii?Q?+eZYspESN/fmacM5clqo0/vcmfL7SjZY8dJfZI49xPZnO3+KjbzLZZ9g41Lj?=
 =?us-ascii?Q?sbx9mqOsbCVDfjLYRIIwovYfpgTQ35PPB0R7wjKQ/rSSOmvns36+w5mJD3SO?=
 =?us-ascii?Q?9QliEACXKeCajhIO2UgAZKdvSByLN8wMZ/K9W8FWiNZp3iRQu+OCioG7vu84?=
 =?us-ascii?Q?RgS2XtDveDvAAM1+YhREOyy16dOSbBVWRqdeDQQsVqBqpFG0/XcVs35+ao5t?=
 =?us-ascii?Q?jIYxjGFI9oVuvBKxBlo+ybb62any1bTH8C9ioxqjQRl9hTPqw2lutk+1YyR1?=
 =?us-ascii?Q?5wldzaMkzaAwQ1NlPZZbznEh18BkaPAMveTohje2Dq580LjSNvhr5jiRPgto?=
 =?us-ascii?Q?qONxuK80m34vz9wt4blPm8qDhQFKpVx84Jw1Eh6Fwt8nHVpyKJXWqNY1nN/s?=
 =?us-ascii?Q?kUuVg7SJw1zNq8y9bwNYBneNs6U8f/snHbBW0sQk6qah8gQtxSawORAkcQtP?=
 =?us-ascii?Q?K+RvvT4b2GUE1GAX28cfTAQVSk0VRB2z8JrY/2mtF58aA1lSHZk+Sc9vnnL9?=
 =?us-ascii?Q?Cu33wtIDKBFa66dEQYgXqXefy4f5qbwUguxZZuhvMQurLUx6lDvyrKcjv4sl?=
 =?us-ascii?Q?X4BI4Z37yHjikPslpJjpJyquBvRIoKmywmy1JCM3ao5IOwWpRLh3LlrVW3z+?=
 =?us-ascii?Q?Nv+zGeSTSNv5pVPXPAnaG+QoWceN+XJVV26Ke/z/T0FkzQ1uZShco7rsbiL/?=
 =?us-ascii?Q?Q5E9SMnDMbfsXiurO5TDn2+YXECqmsf8ZIAGPZTaEykKFRt7/RH0dFL7DtFA?=
 =?us-ascii?Q?45BUCVSqAXFb0ptTtn5V7j572cfZYBZ17bfTxPmp+svfI2MlAE7vzzNTN3z+?=
 =?us-ascii?Q?WtAKqdQrIMSprUY7puAJFqhrPHe//1SwmYriF74mo887OqL+EX8LTPJ99BPF?=
 =?us-ascii?Q?+DDAVUvsphIXKvFMEcwOKzqmslxBzQARUv0ExNPGIoSb7toP7WNLzgHW6Fbv?=
 =?us-ascii?Q?4vlOurtQfHynrJSxztXrbRcxpDVm3144Cptx5RUPkmIg5QFJb7qw3QJZawtx?=
 =?us-ascii?Q?T9hfDTa6savb9Gd49NduzVINbQ7bh9DmkbPfVGKN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e51f7b-6021-483e-efe6-08db666c6c3b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:00:07.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wjxPa5MKn7nZTfJiOkk7w611CEJCBXPYnIsW2vbon3F0qctkX6uZE6z4zzftMUR54W+pgNXpmw9UPfWvgzsKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

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

