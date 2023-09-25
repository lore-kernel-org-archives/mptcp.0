Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39E125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARwgUTahQVXmShH2RhE+sHLBB509IZjir/S+IkYlGjm1yJAXSDcBXL2dWqXfNgKx/SvIJj4oNC/G0r5vnZW++q6MFXVSOqaCVy342f83jnLGYPlyetGFbw/Vs78xl/YVgO15wtNhN6zVvuHxjm/sGRPQBie4BTihU8hi0BXYXMiRuAFcZ7/lnaWXj1wT48D0RmVWpdhgbwQcZEI+cFfUWqdcIAUhSaMOsk3re51PnE0+uDrQLqYi74iRVDu88Ir7EHjfGUTI4ZBXtXvn0mHE6mQGzKk4gnj63QenwS2YMU/ZbSsdJi63PFe3yHVRmySRRenKWZuHj69rs4ZhzWO/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dInZIUajdHuxJUDgJG14Kc+DE02JYSEOr7Mb77Eg9HQ=;
 b=O3yJu46aAjWFXTtvpqqjJT0wMmUjMsiUe61zL6pdOALOWIhrXH7yyGBVBWGVMISev6yZG3Rrp2AERHzasP3RfaPwMQNlZ3cggrDndv0dpXC4OkQ40etixGO8qGxNQtLCqGNz4cswx1UD/YgMmkJhDp2yT5QWsWRqHCq3jCH09mpXCrmmSPlP7FGBXGvSK8nnu7PR2Hb0uAaRb5rniDD/fD5yEAaH6FkQ70FOMtlnWw+A8J4M3qrPLmCRqJB2YtfGbgvQJciTid2Hdqxa99riT6EC1iuQGpLaz+pMRs8n+ow/kxzO7BV61RuhsmAxHdgGBU5foFHmTLCC3F5eUH/7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dInZIUajdHuxJUDgJG14Kc+DE02JYSEOr7Mb77Eg9HQ=;
 b=w7RT3psDB7PkRArr598aB7zmoB/gOfJkyvRaMcL85p7ebA0XW7B5q00V0fq3SDDoW1iVRNlaNriOAoef9pHxWAXxsGnO+O9tO23mYJwkb3l1oOuzkvBoGYzTgDbR7ylEl76v04Zr0A3GjlzBS+6lW0CvM5z5/A/xTsXITbYv7XgrcRAEsYGVT+abTJ17QRQNOETbqpWLhLvRnmA3JMqcxTCFODdzNaUg2OTQhhVcTkdU4sXGss0Hr9KlIlf0Wp6I+OZOVfc/hcPjMJ3CbPlMXI68jH9HEZ6VjTD6q8F4ln3gV9cBXXTxYadm0vi0xV1/aCYWrjXcneHXYkS80UWHwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:42:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 06/29] selftests: mptcp: sockopt: drop mptcp_connect var
Date: Mon, 25 Sep 2023 16:41:45 +0800
Message-Id: <9fcf7696ff5889d55224872f16f6fa5998fec8fe.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a4ba09-48f0-4835-b0d5-08dbbda34aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZsMUu13/3gp9ouS3HCNWnBBMUqfI8D2GHCdynPBOroYsQjsPWCVEU7FI9nL9rAR4+bCtYBneLhoy42Dnt8tIdXBXfmKmMC7HCRVYBDSwdW2mBfANmFs3cGI9qRsfgUKjICDftnXBUltKf0FtG9xq4lZIdUmGWsG2jDOkhg9jGPRFNApKU7QqtAtXnBE8/PQeJeOoz6Zt2KnpEa4DQz4hZ3IsEB0daogsB7ZxibO9ofhDuwWwqzEALfLv7z42KtqcP0VmDPNu2zu3g/XBrPMB9CELKK60J5k7tYU3A948WG1qDsIQ2Nq6f3LMPKO4DSCkzNaBZ1PDmc4XkwcEWcpPs0n4Ulm5+52/tjlz9HXNQKxAYW8XMU0MJZrxZyNbk8teBsQo5zGDDiOSfFlpua3nKnzf75mUaMzoYoGdLgrc5BvfjVGvDzBs8CxsppfVEpIVwOnfce5mTGzYmmxhS6BicqAitMMllPLS2MY2JAFWkS8wVF4PvjdqNh7k+4n5ZrNObPHZc2FdWG3u3v+o7leIsfm7WQWjWfTZKmIicV+eiqbWUu/8Ybfs/Fme/jqM4B80
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(4744005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mv5FPGxz2RU4orsiOodYE5T85OthDe/lZ+vE6yf1xJeHQHWCpLAbCXTw2+8o?=
 =?us-ascii?Q?Z6LikrsEbFv59+ijVVl3ED6+60Qj7GQfzvhGRW9oD6D9tFOTpihJ1S6mrNbU?=
 =?us-ascii?Q?/HfyIi/C8o3rOnJV7aMNovUYgGkmNiSL7wcSMxduEVoCgnwJ+ZN0z8G4d+rN?=
 =?us-ascii?Q?selUSAVRNC9Osu6aGv01vXWROH02m/r5B6k2FT/Qia2aQXOkN7g38IdbTkQ7?=
 =?us-ascii?Q?aetTJqmz8/4VPvObvB8mFXHFGnm1gzWuXukKn7W5FuiA7T1pmwnwEOqJUxsY?=
 =?us-ascii?Q?AKh6BNxr+/5xEUrywtDkewUuawxXIAPaotElWDs0iXZvacVF5lyryW86QYV5?=
 =?us-ascii?Q?Q73s9xoGBfmDwADLZ6W99FhGnSvUxsrVIawK7epQjOY1a6jlTD9SrnL++kQQ?=
 =?us-ascii?Q?hq2OitR6TEZze6wmbRISxRfvz+NFoMUpko2fZ+3G2VpCoi6cYcZOJHa3Ykq/?=
 =?us-ascii?Q?KGeYDcuBdineRjYYeg8Hu8xpor69LubDsdUFjaEDRj324REKzsOUMzorPWGP?=
 =?us-ascii?Q?ludbbiMCmHfG1FV2NvIqqwSzICi96A7YsmFoctmNxU1zVAmBkdcTFMqV4MPm?=
 =?us-ascii?Q?q1Xjt6wN/lrOwIESild08fDPrM77T8H4NYpPeoVONEGfZBXkPGJ1J5Pthgbe?=
 =?us-ascii?Q?JWz454XiPvLd+68x4RjSxmCWKZtvb8Rpj6MZGdDbGyDluT25ySrXwNZK9DnA?=
 =?us-ascii?Q?BAmdX0pk7nb9rTSX/B/bxvQvwfYjNdonsXvOQDanE9aZyGB+cqBv/hv0eMuK?=
 =?us-ascii?Q?km9wAEZmb9buLJxOxSVlVWx9/eu/Pz9F1YQZBAmFAM9SOgLEOs87h2HwzoKg?=
 =?us-ascii?Q?7rO03oadVS6s+pPQRvwus1f0W0yaiTgJWN6MZunaIaCzSz6FSEjVy6L7rR0B?=
 =?us-ascii?Q?tvvnlDuXv5C33Zondc96AgDWyHyCPqkEhyNfIo4SeYGElst2bCL3XnPA/00z?=
 =?us-ascii?Q?Cai6C3BzRtpn61gXiVwjl9oru1hs3uGNrLypHx+lyGiE9ZZbQTUFq1/gzoUR?=
 =?us-ascii?Q?/SXW43LfBgSE+1WhI76WqTCfVItTETeJGBUMsVGIHQ6r26I2jBkRwpXokJfD?=
 =?us-ascii?Q?TAiZ4RhP9Ek66cMXScNyQwogjdAiN2jX3fb+nNqNcXhxPzcurt5N+72sd6A+?=
 =?us-ascii?Q?tCIrQMcWnP5ej6MqTyqzdWqFZJmrluyjNDQOxPp/Vpc3cnA54yMEtmCsFdWL?=
 =?us-ascii?Q?AbnfRUpakw/9LNp5SrkyvD0jy6nRRI5FTuoxwfg71BZOXnfz2bnBn3E6aom4?=
 =?us-ascii?Q?cILD3hh8+cr+2TzlIgtro6wnQnD/5bo1okzcUC5xa/e0grSEv50IO53u3lhe?=
 =?us-ascii?Q?A1tzCQPfAPpZWt/GMsIRw41JQFdFG6FPSh5nN5Ie+yH6KF4zq35GHSnij2ta?=
 =?us-ascii?Q?s8O/fejJ05D6uyWriRBl7+G0fzvQZCsdFZIYLeMw8+rMYSrOq7zYMEu/tq21?=
 =?us-ascii?Q?XvDOR38k2nqSvQ7rI+uLOKm3VZVVeWF8qXLa1Uqa9mdnQorc4ZPh96fx+s6z?=
 =?us-ascii?Q?epnV2Utp/N54wA4czmMPsEcZ3aLhQaKAMW2mV5M+plz7FLx/2T9sTaNDE+is?=
 =?us-ascii?Q?yYcvBPvSo3IDG7IXc8bVH05cp1osx4yk9EOM+heO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4ba09-48f0-4835-b0d5-08dbbda34aeb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:03.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsZ92z9VLELeRy2i6KIRfqQ10/XC6oElj6Ik8A+RY5ofe3Oh+CnRamXluXEusN+XbwAaKtbgGiCHqdLyfmC6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

Global var mptcp_connect defined at the front of mptcp_sockopt.sh is
duplicate with local var mptcp_connect defined in do_transfer(), drop
this useless global one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8c8694f21e7d..a817af6616ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -11,7 +11,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-mptcp_connect=""
 iptables="iptables"
 ip6tables="ip6tables"
 
-- 
2.35.3

