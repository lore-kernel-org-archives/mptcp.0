Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CAA1107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzvnxgT5Dv4grJb9zDQzuEqM/muBsyeeognqvqclzc6LNWvaXbhSio5/dE2++VUrtXY1WBbCuLIeBwsinJTSQoGhhlNDmBgHW/VrhC6+04mM6NxCxo5h13059kmMGJdkw0ShxO0VZqiiMXOB2mo6hP0RB+zfb/8VNtMqptd0GgrwEAbZO8nxxGpBpInwzmJzDMOi7UY/g2H3nBlr28eiRw//cvSe8ANjuxJNXQHNSBf8mwj7ZVKL8rt7bqM8DA8uf34QV02++HEhGm/xWjcHEAXTWWMqfdA+NitBclnPgzqqTRhd+42C2XTFEStaXuFpo5AdVTztK6kq6KXCmkqSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc/gPL1cFO2KN2cjntnDk1m/Vfm4dXxUgLhH44IWpic=;
 b=j57DVKJUUgMFJxW+n+jqlat67RRDQ03TpuTJoc4W9UFnIv5TA2Lf4uotQbC4x+kD8A1BayAf+veMtSfMPcUaaVVJ0zdw4YHzC9fxYmFl2bETXL/NVxpn8TsUX6Ch06swsQC4Qv2PctChNps5uygkHvKjxDRUcliRLnjlqrBwVylZ9Xw3CdC7TU+0Y/xkAkNGtDtUsEteVqoECCaWdTd/ATqBH1hNJ7cVbpISWCFiYzbqmA6WhaLbeRfCJj/xAbQDmYaGX3BwRemq8zxYvmHWpyZr6fglcq767a1HfTv/E+u2/0o0+q0g/GhCiEsQ3JJwotNSi++OGM6cDxRXjOkKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc/gPL1cFO2KN2cjntnDk1m/Vfm4dXxUgLhH44IWpic=;
 b=XZn4sRh/puAkIvq2/3Nu33QuPJO/UXO0y+6RVEo6IpcpX9sevHAYLhBLOr8dSEC8kcm0aGhCAatK7+qDs1wgBWbNjP7uGJ1CQP32jPWoMZAtfbKm8WCo83Gdci8wVoh1opz9ZmmrKsGtpf/mAfqySfvXA+NFn64tn1VOxQj3KN8VRAVOPSSkhFHsXEt9VnnHPI5qmoovAN5oQrBV9vTtT1RKLUGyfsybnAZ061a3CQbdk/nrGlvoJn2yfewBiDY7VWSTcklfAuNhvV/kOtGmcn+aNzea0xAOymScUhceYW3pwMEra2UJoAEGlJw4GCCyJDcAcZ3c/LG8Z2dfpsItjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:38:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:38:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/7] mptcp: use mptcp_check_fallback helper
Date: Sat, 16 Sep 2023 19:38:36 +0800
Message-Id: <fad9d03fb6cad6f20f71435f5cb03e0aaa3dc096.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694864093.git.geliang.tang@suse.com>
References: <cover.1694864093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cb9d71-de0d-43d3-52e0-08dbb6a96898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nOPIJydVwPwdSUDkkifsGmMr/6TL4uMiTl8XhX1BqkBGs5ohNrHUkRfTQGemOS9SwODdioq2+yGPFHIAAZJG++hHhVpRrBn4vhiParTHtAe19gqc8cR6lxRok39flYjCD/kGLQz4hj6cF3JHCuFA3m2VfJLppnvQXBU6VSuXnAymuxEzVKDU5B1kDGwgSLvUNFwOdYqr3qguIyk8CEUBy4rA+7A9yxrA50XY/4l9U7BN0O0QrWDdShAWRJlf9MPWxOurMMYrK9WA6KzDnHPNCaLjgzQlNef4SdeXir4gq2H4LZ3r8XcXOEcI2kgGxrS8mnugxgozOpic+eL8Xs5XEQA69B/a+Fisif9sJLEgV2XWG8rI71YpecPmZELXKd55kb1gnC+AKq4K7vFYE/PITLw1Q8saA6MyVsCcLfCFDpDyNqItP1f8sDWGLwC/UY/P6YS6X19Kt4n2Fbm7qoeoIbYuRt7KMS0CS4+WuM1KdSKUcyDOpqAJpKEkUkRLYrTotljLaoVu163aqhWMT9OVkMgtfG0z9opntUfBQx1cmoTTeMP1PUzPQ1wdH+4XvBYByITNINELdlbSgd1ElIzSJeYn4JQrSCv/hcBduUZb3W0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/Pa3hwQ3HfyuWSvb86ZJddiwtMYEEJphgFcJmP/SYpIqNKYmYWL/v+6sq3f?=
 =?us-ascii?Q?WQ3lawgNd4wJK0IpTHvjXDrX3NTmJC+vUd02eQ0toY5BrJkx5szZ+rnZJ3KY?=
 =?us-ascii?Q?u7Tv9QgvOhR6YypfONBkpycgidsoVgPKmKcehM77GZUJZ5HL6jCH+hKHmsao?=
 =?us-ascii?Q?S6yBuHWv2iCC76IgxI8fkfugpFMcLuCQ0bFJZPzdolADiqrWAMZrUmfKZeCh?=
 =?us-ascii?Q?Rb6G9zjbneP6L/XrDjY8BSk7j8aq/PqasMSLoW4pXHDEcW6sYFEyIJ89owiG?=
 =?us-ascii?Q?8Uokk8DV7iJwkGqnpV/kLq9T2ZsJT4f8ps75vhGn2bCVBGjWASpCtTYklOYL?=
 =?us-ascii?Q?3KXlFZ6Jt2LXW5x4VluKnhpARlwUJ+GVUP3UaoBX0m3Wvao9vY0OiF6a2vNJ?=
 =?us-ascii?Q?iKG1rUyA71OI4NREdrTO5li7Ovg5usT9hv1+m0OS9bwt4aadFGpr6U+9kp9e?=
 =?us-ascii?Q?Dqj6RydWOC1veSKQmvi96Gzt4mbskdSM6XP1wb5XcPbEdurmTThJQLPl1uxI?=
 =?us-ascii?Q?xqb7nmOCPpja/WieO9yccYJ92iOG9L03uQYHGNplKn79IoILTGm/ADLmapis?=
 =?us-ascii?Q?bvR4wh530wxFCWN9QLFQ/SL2YsixEnzZssGAW/Pux0m4u8OqJftO7/G3yceA?=
 =?us-ascii?Q?XtsGuuXzR7NyBQsQuy3JXoCqZD4b9+Ba9FILzRfEMKWbECGOX/+ikrf2kt0r?=
 =?us-ascii?Q?jPHveoL2UeOW2Ytgh23yTxEYeGyWtqFD43QWzwYUCkAvnhsGlbawedTgssZd?=
 =?us-ascii?Q?GqI6KNvgzbQX90DVd09Di+B6D+N9QAeTYCrmy7UxHAdS2oOBfQA23OkYRa9E?=
 =?us-ascii?Q?NmniuviQvgNfXacmu459CahZqJhOska+uxxHtLfM6FxpDqHK8ImclDeRR28u?=
 =?us-ascii?Q?qt//MkDgjVmbsz12Yar7WZ8EFaR0fPIZD5xU0yspRiPUbUxabSReuxLcbNMG?=
 =?us-ascii?Q?QWTHF80Z+iQ+UqpqbZ1a6BUYCn4LyPGVtz6g6v6Wso+Im6GpZ0/XqFiDow4k?=
 =?us-ascii?Q?yp8sXE+htOzeP1er1AQJEFBSY1UU3uIm6/i3yPWYuzviWZ4OVEB/nyqj4eFQ?=
 =?us-ascii?Q?BWtRe3L30afbmoDkpNrKgAhq2kpeeuxPxgCulZA/dqDMQYfq6Etl+zymIXmZ?=
 =?us-ascii?Q?gURTNQskFSciJsnDxnaq4gccVv1TRhhWFP7ZK/3AZmkmWIeLDmbYXn2oOCiA?=
 =?us-ascii?Q?1q4BrEtSwK0tU/aOOQmHIo+ZsG1UFgmgLe8fapGdVc9w66SMovyxb3o1329E?=
 =?us-ascii?Q?aq1rvBDHAiVMrSsfjy46Zz9ZLSaDKgrbg/+rV62MYPvYHqIw7IRiYBnA6a0R?=
 =?us-ascii?Q?sokIiJTRyweyehgEVWZKWvRaCRT6dzsAfYLCbqZrgOEfVDEA0NzVdNcVIJWT?=
 =?us-ascii?Q?WDL2Na4jO7PAskMqdNlo4k41sWO6DSForjQ7oHcXs8cdumvgrVgitNynyNQO?=
 =?us-ascii?Q?svp20RxH5nVtSONzYbxPogabiG687fy8sDXj02xcIK+IuBc42HJXvhb4R7/L?=
 =?us-ascii?Q?2BlUld6/o+td/26OXClukjROh4sh+JRpu1xnkRQl70yKEEvrF/+baPsXf1gX?=
 =?us-ascii?Q?Q9tTNJHNtjzYeeZRFGa6iyv1kOXC0CuhjYnCwIJV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cb9d71-de0d-43d3-52e0-08dbb6a96898
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:38:12.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6TjEAT3n7BUSiqWrDQYKjuWyIj9lh8gcmr0/byJKNLjBn+46HqHJfbbdKkOyKEnqBXhOnIgh4rNzI86Cckmsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Use __mptcp_check_fallback() helper defined in net/mptcp/protocol.h,
instead of open-coding it in both __mptcp_do_fallback() and
mptcp_diag_fill_info().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/sockopt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f67cb5596e41..fc041763dcb0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1024,7 +1024,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
+	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)", msk);
 		return;
 	}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c0066..1ae9fb6fabf1 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -915,7 +915,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_local_addr_max(msk);
 	}
 
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
+	if (__mptcp_check_fallback(msk))
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
-- 
2.35.3

