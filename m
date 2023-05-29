Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4767C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0Xl+RzB7aCUxuUu4VVH27l9i7I78Kbqx5Z7YujtbmlgWSCXyzCd1KQPWM1muMaK0mU3La8RhEC8p9f9Rtil/hGdEKj03sX49LomJv8m36Md+oB+iNFptkT8OSyZsYrCK9o3qZZFmBKfgctS9/PQ1fEYGdgvqbzE0MdR3CI54Oo2tpyXVwDeoZsJPQwKQk+66rtWNWBKIERjFl6OfwSpioDHa/2uZyYuHywT3PkJPYjhchoqGioC7xJFL0isQQIS/xgBBZ2iSOAKajwDfNQdL56wvt1cj1cuCvx5ynppQxF9TZ+M8w6sOtlNyMtHCd09K3bOdT/EZ6ic7nbtnu5XIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=HAsVjSNiwnozd2vU9CVOuqIfW2ocILmhXVOIWvS+86P0mzZxDwuwvhILulzzXDWyR6mfUfaignvZWxxzjwSayHIcaD/zPTX/P/jARcLOpvugHA6OdEUDSeopFY5qXopxlM/QHDzZaHe2X+JSfyilxQbg+fUMCvFuOYJTubaY1/uVvYVlAdSEKU3lSqsxyo6WmvaUvQbNS/6UB4IqIclgx3Ycc0cqEwA6SuoExR9CJaWLWsKjU+AhdQ5pTV2vzM1juFdqrv4G84MlNwU8N5H1sNTKsw99DCg/cBYmL2myayT8oXichVyssAUTU6hivHVCkhpPLpu+MtyAIz6t4gyVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=RP1IWIvxRPWIenlTQ+dpfULw6k1bSggOKo4GbQIoRiWurNdpbN8jNw7tg0x1wmrcvG06HwiKrSqs0LxLAPDy+QBTblxntHwvdnhLJLZcIr5X+sMC3vLIkVR0j1BHWfRDxlEJ1hAis7G1HSb3vj1gfrpzSFRiFk40g4Jqbk6HAC9mfXObzYfdgrcSMwUvYEa3PuYDNNo6ivrbAugiRn+lKtiUTgIwXsmq64U1BDcR6cifQsEpPt+6biU3KKZfEts1+12WhLZdXOlaBcUo+p40PJqGeff1GkVm7RyaI3VpgTayIdCdnS2aIeT8/UMbqzGKEiwUzXopVKxB8H+wmgrgvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:17:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:17:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/12] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Mon, 29 May 2023 17:17:15 +0800
Message-Id: <c8b7a2ca10c1460694d04e2d3a691f96e22f227e.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ee00b3-c76a-4fde-e146-08db60258bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwUa7WbSD3nUlq7owDKSN20U1u0OPMO+RVS7y/6qCl8CKbNoVFjAUiRGwhTn30g8eq8Z1b9sld9RYc8MlhFYnCzhLNb7ioXvbWe+QwRHHGw04jC/9mgVCceIkda5k593cVU+tFtRjehg7D4EeO3Qm/MjXEjaUefO+MRygooFL1wV9mO+uAc4zQcCbziamRwJfreKy9iElOpXwRVCuu+vTiOMz+L+CneVVdUs0ctoQB7DoIhlkrl15V/x03vUUpcgUt6lLRxx8i4lsjLHYSwirGTkF+xQT8KQl+OVOYvVeIY20y4LSmkXC107zSXTxHTezsj4vDD42Kb7x3hKrIs+6YXc9EqQaJPq7425r/EO5rT/QCpYsGny3Rp5UbewayS1GJFPI7YGnxBJPoREqn1d3yl3sUAe/rZLhMwnTOeqDM1Kp2NXLXdobmK9RY3uxM6yjc4p7XeNwu0lOnbHUEH3/L6ENISwLiQRVdD74GbbihSRG5gJGASBBGqh8AsxjaWOjnp+squI24nHqNMRECjy4PANaSZplO8ypV80iY07OWkqDB4HyL7AHjA/gS32BYzX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(4744005)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNsWq2qTOKq0GGdHWikv2n7TM1jp8BwV+kEvgOh3R495rZzzq04dslHSKlRZ?=
 =?us-ascii?Q?fQs3AP2v495w4szJe2H1pKcCFxXMw6oSnkBX58V5mrtue7HI3miu4W6LlkXl?=
 =?us-ascii?Q?cazg7RHRjTg4exblQjFBhCC4lEbosUrVqaesnG/dLPMFRndQJn6XnSNO1PCI?=
 =?us-ascii?Q?E/RdDv0VcH8n1o+GrcMUuvuCqvlH5mEJDlFV/42F6XDuZOoCq/Vuar5EmQES?=
 =?us-ascii?Q?1xPWlkZnj/lH5tKkwcvBzL4d3p28EI7T55/1Uh1HkCahnBS32SDkVMo2zxpC?=
 =?us-ascii?Q?GbZOt4sKABUrrxw4bRjKry92mdptR2noPZGLXbWpsXbDpGk/vgstmNRZc+pk?=
 =?us-ascii?Q?Vz7vR3cST2zhWtprHBsZeNCdY/VxEinToKlwv+8D1p66cu6LknnLjzN/sphj?=
 =?us-ascii?Q?kGSxWqbveMyiyjKNmOhSgb5iu1UjpanmVgipydS6aCxIcJ6U5U8CqbzLF/KP?=
 =?us-ascii?Q?3mRwwc2ML0dL+cG3KuYVGkQ2YOV83pvyYKsPGII/qksNMhFtOljCb9KXtnVg?=
 =?us-ascii?Q?2tafkGOW4ukGBrAZ8/OBYM3WivkuC4x7o1zSU0NpzxYo9cMkMaKkChYQuzGv?=
 =?us-ascii?Q?nFrWIpFgKxbl9UcYnfDMSFK7aLj6+47SmmHgoI+cX1vzae5YGWUxUIT3vnEU?=
 =?us-ascii?Q?i/ECsfQDMNMe8DbR6Xda3JXl0pVYXTobMGo0f0XKlZdA9Sbz2XiEiU/W0zHY?=
 =?us-ascii?Q?3/GdejHeDSbT0TwC5GiyR+V0dmCs8G7HfGsPygY+UCXDFYWIW16nOLIAPxkv?=
 =?us-ascii?Q?bjyEjWium9TAHYi4mxDOClJfANAd0q132qiCyAply5XrX4x9KYlsIzTdhu7L?=
 =?us-ascii?Q?Lo+GpzLv8OrISlU594WMA7xb7mrCv+NpWH4xPhC23oFcdjT1WBSXw/Dunj9C?=
 =?us-ascii?Q?Tm4uwm7MhSIg3+pFkxoq24el1ryRMqfEeTM6gg0F8Vt5Ol71CNcUZAbVCrou?=
 =?us-ascii?Q?odpMoHlcSl7zK4OO87oxQlQgEHjmyzOtFvYpxhALwNrZZCDDmI0D1G4k9o5o?=
 =?us-ascii?Q?wg6+NPPJnYgiG2gdajnCqc8j3en8thewRqrPQULUsqGlhX7C6tFXh9/GXrxX?=
 =?us-ascii?Q?h2H/mAhr/4wejtfPFFvJCCqN8x983I0b+RfnBbxByonlmFr1p9B25vUqP0dN?=
 =?us-ascii?Q?oNiACc7+wDCmfx1+6EGvoQdEsnHJqNGNjbCzLjtR5cMgY+QIIqpIubBA4tfk?=
 =?us-ascii?Q?jzJK2U8dE7CGHN3ti6quLc6M+T2+//evwH6RUe4Toj5mS9nZKL1S9m8tPW6H?=
 =?us-ascii?Q?+jBvZhkzySD5HlG4Iv57dmLE3PmgBpqWpAfUsZ6X/XAo+3Ee+ulQsYmyO2wd?=
 =?us-ascii?Q?e0rDq5ot+82Mc76zYNcH8pmMoV9xe8Kvrt6pb8bDaE2IW17O+IKc/vw4oxT4?=
 =?us-ascii?Q?A3bd5Lu8Vsg2OujA3xY9kwVxVp7t6S2jJi+Mhe3gNXjKZEi1/OFT90+7HG0m?=
 =?us-ascii?Q?pzL+cCpDycmNnBi/tl9waRQU3DzEYqZFm4BBvQOoe3K4l0Hi0d8NSKlLxMbU?=
 =?us-ascii?Q?mu0YuPY/k4rywclHNxBqIlvBNu7JJWxdGrzGujkNSZLW235eoU6U6WF6oK71?=
 =?us-ascii?Q?LfTUv9HS4/HqNUQQZJn84uzcz9pwdV/LhEM1UMBA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ee00b3-c76a-4fde-e146-08db60258bd6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:17:38.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HS0BbaCNgvROd5mQZfG+ASe8UnuwL8tVdY5NR9R+tZYHQLYJMUYXRQlc/soEVuiiqAYz8tBa888/tHqf8q6HgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

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

