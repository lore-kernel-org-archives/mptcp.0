Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40155813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY/BfNjqDCJyju1OBPPZy5HFvzMytEh/waV9p1TskRp9W5v4mS3xUH+VhOmQ0Yka047d+3NQEMu6Gzc2yMjcgnAvT9e1NLMaFbsLEoED8mZ0oYCOGyt8n2QziYPLqbcORJZ4R7rOg/NyM3nAfwEeFiM4PwFPwrrLVUUu8QjzoDKiIerQHtkAmR6sZK/N05wnF6mWKIhcUlGAIKrHJ75qNyjHzN17Ei1Mpz/p7CAGIQVb+G0UOMZquS1WdeeukK2VbC086o75FFKqukVG1A7FRp4uDRpf0zhZue7qL5+QDcIzTH1ZfRPKqvkZOSIXq8Zd0hZSAdv0v4LNPf9DaPYLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=blazRczc3NNDYTfbIq8Spgs29fwdqyhhSXTDg8RXqqc5UVDNmdl7oR4gZ3bk4JtCRhkPvxRKecPzB7614viO9On77OqsohuP7BvKS+OA7RXWq1LKwbjj5Ah5lspRVxsdWBOpJe8yn9myiReDASpp+N2XIri5gltoWA98qEqw64fNS59iKk8bTDPDAUaM6Zfiga6zxWxYIiEJOyKaFZfI0OT1War2vDX1KYE4uLCH+KP2E6Ofmayrq16unlNILNmqKtyThw1RLI+qFRmyq2A3n/mlpjgklSYuQf7i+hvlpVZw8S/OQrad3AETnlG/OYt4NBob5SgxplQk5Ru4XOq5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=r+EEH3kOP/0jtO0o23R/mvjWMJ4jE+uy3eXSXlsd80CUn+8YpJCFyjhaxpeGyIWrxWdakSmWloehdmd2gOxHAdxb3TYEQ8ZlnZzfF8OS2UohQ4zPfYdVQzClXVmhrfiNinkHUgA1gZcoteFuqA/rynAHxLXVh4n7KtO9CH6YDP8i2ybabDK2I/RkINUorLKAGFVRlIMcrqAXaYJmaf8b+QIwx+Ahnyt/VcSw3r83DQLY7jUXaoD47aIGs6ANRd0xeHe1cgTAR2QZt0yCrvzQ15nKr7Q289crCcU7m1tgOv+ahF02OLEpTPvxDtzzQ5SoyLl8ESQ3KcBK4RY8HXZ3wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8330.eurprd04.prod.outlook.com (2603:10a6:10:241::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:45:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:45:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 01/18] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue,  6 Jun 2023 14:45:00 +0800
Message-Id: <01027826b91ca75bfa53d91ac41ede0be3cef634.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d87f48-b5a9-41c3-e250-08db665996e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sh8y1Y6aFuU4YyYLGnb2vwchKAvT7s0LVU8/3M/bNFwr/+bREaS60UFs2Vp6N4ocJXedWtuYpAsquBe3kZbLLzD7E+TN5ZyMox1BQDcNP9Y7h61a7+NxcYPZ2dld1gGhDH7OpsVS1YhRhrp5RA3pqgp4egQQP7QGaK0fvqeiu46hSX+8kHashplFbYu/V9gNywxtCAsZDfXcg4gz46xgJr/MnHt4K2SHByCOvsseGfRpaLhYQ/TbLlnpj++MNw7C0B/rEfbXNJN81P6NwWXWa0xESrs/2ryvG0f6MPRiEI4kbaHN/sDLxmK9KPntWuTBiEzHIXasovyMVZ9FpM6Uspqzj+dQ+04hAAiCsEvZO0XYOm+OKnPcv6YPjXFtx2U2dIOO9AASxZjxOykYmmBzH0NkIIODCgS3QLSxwi0uX4KSYkdGd2rOKMlduxa/lPLAmILDpr/EDL/+PDbB3qjASW/6K4ONHD27byjN0zZZrkJe6SVIjRHGUCAJrCKnaoYMnlJ3wGutHAesLYIUPoju7RFTLQfz9zKCRCvw7jsEFkpLFWZwc3YOo6q00UGSJwWC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(478600001)(6916009)(38100700002)(66946007)(4326008)(36756003)(66476007)(66556008)(8936002)(8676002)(44832011)(5660300002)(86362001)(2906002)(41300700001)(4744005)(316002)(83380400001)(2616005)(26005)(6512007)(6506007)(107886003)(186003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7FZOQjhOXGnN05FC58jLul2gLXo+U4h1YnsYYs2c6GPwH5G3HxXUaVHHOop?=
 =?us-ascii?Q?PZAo2GapZlmMUFFcaxLtBUTudCEsVZjvHlh+tgJzmEYevtMmtovcpqPYqzgy?=
 =?us-ascii?Q?8qiMCEjCiZxDv85WiIosNPbHv41P698P2oDVWxgTHcQXjP7CseafCtkEWYKZ?=
 =?us-ascii?Q?+VTi2rzZ6imdNRaO64MUk6+ZBuOFmnvd5PIXQgU81ORD0gknax4ZQIOt5zXD?=
 =?us-ascii?Q?pFciCyw9D7uZxR7GBpix5COsDJ4yPK2lZQ9A7NZRhk6aUYc7eJvW9+eelxJX?=
 =?us-ascii?Q?TLBx4A4Pnki0o2Qhn5sXLrC1G+x4cDZvu1JEQtjmeCuajGC9+YZvPN4/EG4s?=
 =?us-ascii?Q?giQ1xIYJXgVTL9V20zcMhBrauMlYoViTFb3knFJC8JIrncks7iZaj3dqVidv?=
 =?us-ascii?Q?17nud4euIjGekXvSoYBlpjBVmg0IgY9LEBtNfqeD2sHK6xomXNPCAcQiRIgZ?=
 =?us-ascii?Q?gCjwow12+Ic6TAmjV6roG480wvFPTtv/OSaSsmgqDPfm857jJ6RaL/tPMweB?=
 =?us-ascii?Q?vVL0Tdw2IKGwfss8wJUenUcxLe/ayKzx/77u+vB/RTHHftNu2RO6/vaHeWmk?=
 =?us-ascii?Q?x1P9f+GeX2Mc89AIUvmTc/FrrmsnmQa6M7FgO80ZwPVQW0s326euruaQ2aM6?=
 =?us-ascii?Q?vAgGwcQWbVg28bOncISPUpS0S3vii7AzFPb7QNzH9suOCtMYGYcrAPB6jHLK?=
 =?us-ascii?Q?WB4UpwGsRwD1OzyB08zFdxP3Y5Mp/3kPdEEYJPPOTabgxmTIjIOdQjUGR/jS?=
 =?us-ascii?Q?ihHbcUfJY18L1uUt8yEh4DFn+ao9p1YrNXg8YkZnVZSjhxrc8vCjmO06mGSP?=
 =?us-ascii?Q?ibUlxOWUkBEIefdS2qK14MwZmYq+XfKxFCfIjS1YiR1Hfip3GpkbIDRaathk?=
 =?us-ascii?Q?woH5JBa9IIWbWPDAIctY31dnoPVBXCFAIuTJ2uVfI09y1WrtuO92rB3TRwZW?=
 =?us-ascii?Q?HvhxtSb2NDMZljsSQpb/9KRq/TDOvQvyvlNson8D5Rsrw0HYOe1ghcl52FNM?=
 =?us-ascii?Q?VtT/bxTrTZICB7XBOUJ/Buby200QPA/xARd6HZSCnyWKgsuHiycUFoFjkNm3?=
 =?us-ascii?Q?Mgk8iB+VeQ4YOEy/l8nX9yos0wCU+o5VXHcbLjNF874nDYBZ5Cdv52UCSyLw?=
 =?us-ascii?Q?dp+Hy2UHfkWU2cGlKLGDO2NqAyn9tzrXUtOhMOKN9c963unN0LZjRLgVnfmw?=
 =?us-ascii?Q?RxNgiIJc7pQiR8XoW1ECDo7pM2OuB0I8DL7U3BU60xHKXJ2iVpaGRVAPtQkc?=
 =?us-ascii?Q?gbmaz0P+Jq1WM98OFd2PvHWhsuiCGsY3dibRu3uukZLoyaQmkdRtRoYrmV+a?=
 =?us-ascii?Q?xB6icGq+p+YP/iKO8tESWWL5BQP+CN4DZEKGbq6b8wxPYcuDlZQQeQBq4MPE?=
 =?us-ascii?Q?H7FcEMItdRdrK31rfqX4b7wHYGB6gxREVZOlfcDBnRF13ZWsNWfBpAGk3xIW?=
 =?us-ascii?Q?xgOBGx+J9vwm3DwEHF8pi0cS0cfUeAjbDIrjlwcZC65WjOa0iSn2s+wVp5Mt?=
 =?us-ascii?Q?Fnjv2BazxK9pnK1Ew7fOLBsj22vN9VW76yChb1FMyOMWPGiht8DMkypIhvOr?=
 =?us-ascii?Q?igPihZYzI58nnCV/iRj/Lu+ISIXChHltyAtipGAU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d87f48-b5a9-41c3-e250-08db665996e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:17.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTFo7MVbFE1/eW00AylkiuZm6txNhg6m6tl9G4vsVFi4/UJ7itnTdK231St+tOlNLYbCPF4rBl5N9YEpXBk4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8330

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

