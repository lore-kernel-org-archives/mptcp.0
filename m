Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CD11CA9
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvI0yjtRKRrjGKya4HkU1rf9oJAU3VqUrqvhOSqdR/rvTqMpn+rlXi7NgtTFLwVL2/CeKLgX7TEnZH9o/EIAIFKFiI4EpLRMcPeIRKqSrikKyvPcgmwOyUDfdbjr9OgXXamP40/RXtA892jYBmb6/HUYZWnBgWCA6cH/ijILWShHKCBkmUS2sgh29W1ws/KQYoyux4dEEQLBpUecU/ST1sT4PYon5ipuGjHwwNjKMQGrIaqyrDnEVk7yqWQrtOb/n1udTa5kMNisStFalhrILySqrG7FUwLwwTRdsDP8gMMfbMPj6iw+BrTk3jPlSg+hbUBd4Z8xbrGzrEZjSZ5z1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZKcilgEcNBgbnl8GAJYP5tGxcx/MUyWyXhDQzfCX7I=;
 b=SkUnKRjxKnw8qC5EJg8e1S2ABM8f4J8b+SIOeWGvd6lRE1vt+nFe0CAmQUlHnRqfSy27kliJJs1FaWHtWDJO2/FQUYX4q6f2yhUvIIjAgiS+ehDMy54+eGb4+0C2P53yw3YvYMEI2ZOqgaOMz3zQRGP7tGhRyGxiex7+7FNxk34X1T7QqXC0jZXSOkcFBNOp5hQsGNKBUIzt7Tt4p2aN++qgK99+50nKgK3tTDkj4TNAXm0bIYOCCieLYY64OCZQ0vpTjzZi6tgCd+Y5slS6QYZ5tGG/MoE/azZuOtKlnLX5OaD2gKw780Hgs0emxfgS2e6A2f5c1CpQlstztMT9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZKcilgEcNBgbnl8GAJYP5tGxcx/MUyWyXhDQzfCX7I=;
 b=2oUNmh0iK8TKMQd4m4umxVQY3Iwn9Jaf6lEGj3D2+WXQ/wRZ2wB88nftAe6DqDAM/6TCqXMBI3c8TDUhvJp0ZCkyJAXmnZ2zuiAo19ysxLiM8ZctJgMWRIHkNNI91YL3XAq7VuFKacWsSHmZm/GKkHrlsYeYIsAXeFmm9JA3iJWekqkKxpvFZkXRgAEqnQk/lHP6n7eSu84cDwNK+cbo9TeUugysIDoahF0D83XvTdKxTKrjLB6tv4ItFiW29Y5gxUpmsAxlZCHJd5kSSd0dAYU84BXd7SjzTEJifsRBh8C3+2HPEg87JMIFy0PzL9gUzD5bgVuqxRxPZ9S2PH3iCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:41:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:41:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 02/29] mptcp: use mptcp_check_fallback helper
Date: Mon, 25 Sep 2023 16:41:41 +0800
Message-Id: <89cf01cdc8c276f4f5c8101b672dc929fff98e9c.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 932dc622-0ebd-4c05-278a-08dbbda33861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tag1ZVjQw5PFM+X6LuX7no76mMZngexZtZgHETOzHncqX/1UyPIA225doORT1LZJHByNVZ1e/fsWF5cgdGjVLhbU/4XcXPwxPghF/uxLsq9qWSTyekjYmH+M+ZtqnNZ8Q0q7XjME+GiOoaIOWV+Oz6bVtRiuzpUR9IKHBKd0tPW+BZQcKKWeX2gEZZaUI70dIxdJGOmB5+cvRxBnI+mmGrzsXsKQHezEXrGFWTjna7WJWJIOgs5tqhq8bHLJG+bW8GpNdmmdz/HuKyx7j39Mdndlf4sv8XDcsf04QA1KiHNG3vyCj28bbm7OS3k61f6o74aUU2+BBbapa0OONbhI1hxqkaq5eI4PnpCtwp4GtYg89x83UjHbsqPJim+WWWNK/rlIHrbLe3xnbkx2zh+VmfSlK4pBk2iEt7ld5s99pVGShOSJAX8mHyGC8R1u1Txs9XtPJDLf+KfTpSIEoDQibjNgUsZCJAPs3A74NbMZTPeGgoVQcvTaAfNBFBdH2wknW9+w/Lwd6eM/Cxm+qwLWD4C+xIxlMsdTL581z4QgrYVAowYk7LGhuycCqWF8EoJ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JdMlszJVMs4YL0PcbgXh8qBoFAjOqB/qEQKy8Byleqj7dBxW++WGb9d54Gih?=
 =?us-ascii?Q?tgzIADn/visQWhuxIh3wF19rexLUu4LRCuSuXgYn88W2EKpSVVORvbW6neZD?=
 =?us-ascii?Q?HWfS/64fItjYUrLQcOwlMeGlYLcWklApGd1pi3KGPNnUyPjMt1A+2J78WNsU?=
 =?us-ascii?Q?mc0JXNclS3i0LmA8d9KfpQjojD0jRtKwg8Spb71HEqYz/WW42GijSf7+mwPf?=
 =?us-ascii?Q?l4idjyqi/+s7F8ADLxS0PLdKoznsGTgs0/AIoWiiWwZFz6lBRBmSr2Dzw3Y8?=
 =?us-ascii?Q?lB7KnSPcKsOrS+9Jax7xn8XVW/olOz1FDVn43F6sFODL9Od0Pl/71br54xTy?=
 =?us-ascii?Q?vQGNTWkXT8rrSlip0d37wuHGdMd6QWFsbDnMzraMJdibXgfxEFGfGZ76VDx/?=
 =?us-ascii?Q?0isxCB/iS0LNzLrtgv/t8K4NnLYX9sbg3v3u25jtjpJDKTozzpmWm1/7hzKB?=
 =?us-ascii?Q?vU2IggQzR5ve+LpZ/hvdYf+gGO1v7/z5At5IZPd2/4GOEqbUR+bRIeusSS5k?=
 =?us-ascii?Q?G0dDKdVVfxpdOtADfrn57/bvvKYXLM9JkQQQyIg1ohP82y6i0QjNVZrfotcI?=
 =?us-ascii?Q?AxHTx5RtcK26SDX09vII88di71MRcthA7AYDnvPhHh7efdrygDK/Znb74hax?=
 =?us-ascii?Q?mByMeaKdfyI5qK0nhiJQ8QvRLG9G5NwBP5pDb748y64PVaYQvtOMINo1AcJ3?=
 =?us-ascii?Q?P5hGvEsI/sF4XNXN5Z/pyUMIsiBiskuNJTmOHzvmlqbGXyj85AIR0lYFDKEo?=
 =?us-ascii?Q?CW9iRojpEz3fF9TQA4An607w1Yuzy1rSNLH/DsgZzDjXg9lInRMAiQSDl34p?=
 =?us-ascii?Q?25n0P/2JBzRUFtFLD0mL1oeSN0BzK3YrhWcIL0z1bboVdMzQrgcETDMjipZf?=
 =?us-ascii?Q?WmbVcH8C4yMHu/OFXv7l9qRn/ryVbNC+mQQ4q8dUFv/tsjlWClviIgYevlS5?=
 =?us-ascii?Q?vKztXQipR0V/CAt6ZsVgO9397VpeWc5pLFdb2gUxo4D+HgVVvEpGFEougFLA?=
 =?us-ascii?Q?31coPipNF+l2wt+huOrJe9/yLCanhuiZlhhMjWb3Rb4oanTCZm9qgJaImxeZ?=
 =?us-ascii?Q?OF/3npe1Cw3SOH7Ej4YLGgVNXMdx9F45OFWBfYcdndqAoBW7ANjoIj+NJBXW?=
 =?us-ascii?Q?D/ruwNAxJxE88u6VCPx2a6++CGKhYQUghZoOAR9EtiYSR71cU88W1xkK8W/+?=
 =?us-ascii?Q?JbRvo+jgHTFo46j/++TZBxljJNxU7xXTusEyctWjQAUwYVuGBI38Pwcai38O?=
 =?us-ascii?Q?nKfYucJGitoK9r7mrX5pMP4yg5UGYVi0gP1Ozfh7tQ00pSIa9izb7IwDVo23?=
 =?us-ascii?Q?ZnS563/XBajeZ5C5l/zZxaQvovtPYY5rG6e8zrCfeA2gWDYSVNDMUW1D53HS?=
 =?us-ascii?Q?wfy+8D7JOYGTx8dgO42zo6FD1gLjmw2AFUCvOetph3n2lJdUf6LEXM0XhKbM?=
 =?us-ascii?Q?ciz4ixXCL035minRSBEyl1mVwFUW9d4uy3x9i+5wB72PLnYoSh/uUgEev5E3?=
 =?us-ascii?Q?4Hlec58eEYjn82yG7F+O4LM7XRPV7TLMQy9k6zxfaR8p+vLfpS6fFeqJDQEd?=
 =?us-ascii?Q?zpODlMKenQDYMUiKJmwGxgu6vhIbyX4VRsAIuffn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932dc622-0ebd-4c05-278a-08dbbda33861
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:41:32.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGoCtt48n7OQLVXboVtluuHqzgPJ+8NKng01TDKJHCXsdDM2eIs973sZ/jT3l3zZ2SEr7Eugl4kWKLT7QBCDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

Use __mptcp_check_fallback() helper defined in net/mptcp/protocol.h,
instead of open-coding it in both __mptcp_do_fallback() and
mptcp_diag_fill_info().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/sockopt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 37e38fe23dc0..340fdf2a7473 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1070,7 +1070,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
+	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)", msk);
 		return;
 	}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 340e87195a27..a2845be0a4e0 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -916,7 +916,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_local_addr_max(msk);
 	}
 
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
+	if (__mptcp_check_fallback(msk))
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
-- 
2.35.3

