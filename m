Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C735888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L5Tp4d2A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZlToa0Gt8Qlb/CxHckrGgcrFo67FnihxvY0KFw3NCUd9yk545NPmfTZZfvf5Uih3QVkYdAzrZlIXTkFDu5JJWKCwj0tnaHPfu7EGnXeJhXY3PrfqVeaAL8AHqCTsA6K2baPmJ+ODaAYrwCH463EhWA/oeEm/ToV1xJ8X8MpLKqxkkbIJaShFZXC8qjP+pg7Lau6cwZmkdkZIl4viqGAV8BeFgBxOh5FfdgEaFsnLQhYVRZh1hAfAmND0nTO/mhse+lt0X+G6ODrAOAQzugDL4lQHCjA3Pq2iauJ+UlJFp3UZGiqUnGU7Mb2Pygz2i1lHTXY1OvTzDCrHGcs+MRy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=Q4E7vYlkoIE/y5OjrQ0CtZfX3+JckrluwN3l7AzItwXwBiPWBgytZTVUhd+sQB8E7f7ydl7DpMr8anp86dGOoC3sQoWOu76LWD9Lw4U8tmOemoIjLzYSeEU/wO7xvXwjBJoX8Q+5+npWZGEdlEiV2cYB7isvs5OmiBhTVdV2AY2EGBi2eRqniMdTxu/X3JTqHwduoD2KrW2Pw5ou5hsqPU++QPTD1A6lLmxT1WHnZlujdRdnRWaGv3yiGCTyvhhtw4SU0ayTSbNjlnbqwlKKdyIEXlHwUGEfkGwqIiuakaLAvTCFWulcKGXbAON+7tlQbXhK93otll122nOoPZM+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=L5Tp4d2A8cOxZ7yCR57LGIZsbkOLlda5aVk+4ArHGLU3AZq53+ljRzCl8RQhm/s/IA1g7I2/b1s6ur6d8ENa61Ix4OIRkkYtnFMd1GEdEUUQeZqIznrHWISKTRJXn56lrrrAfR/Ls356ynVB7SQ4YeJuuK6uiSjvBWS092mPsy/DiQyIme051I21cIFov/V+PE/noHB+feRBu53sjNyNuaCbEQ8FmB3JZkZdJXjzF6qI24qjfKB3PhRhZGkGLojuQ/S+tTZWhZ0Cnx3yVOirMzGidPUtc79qQmHN5TxE1HRwvgbqx6oSLwdgLODwkeuW98jo6ms9NB4sW9kAuAyCQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 03/32] mptcp: use pernet id_bitmap in userspace pm
Date: Tue, 28 Nov 2023 22:21:56 +0800
Message-Id: <13dd8a9e51dbe243a462dd61200d1a4deb7bc6a3.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b0b1c0-ef84-4c8d-2cc5-08dbf01d6a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LY0kKPqQQI4K3Ix+b+8T9RMIyiUtK29AIFzEPOmKAdwAOM39YnmLEhe/3muKrJk7J1CU4MIw0NVzp1AZCUtHknymL7rZQsEsmlqv99OeHumAWo3X5cjBLd/rLSX7nrwRFUPGhQNBTruS41bWZV1JUzdtxfHiesTlJMAnTqk6FDMfiLrznjfOmU5nBHIeYix4zWyoQOA3XK9FqSTYFZjVrrXeIQuZPdu2GNx6u9KKhdZQRYJCc09XyFjqMDSgzWS13kkoD8AJF9iy2prqoSsc2d/PRcA2SsO8su6iuaN6MdWH4G7Pu1Fr0/tKt35i6J0QwWJk1u6II4tGMjB270vvw17SwxRpcpkP03V7GFcXjWmTWEhZ5P18tJq++fAWxH935g5IJ8d8cwdniAeR5bw9aMVmqK8KQx28NBMgOpimSmEZZ8ny0paqepQlnAX+Coh6ya1JpDbOv81FCr+GxmI4sQ59Sa1xlcgfmf7sDK7b2tJc2ub+5j4LoYxJg/UUbP1Nul5oZ4AOPMopY0gknzXVIwIO7v702l8KaFxW4ZsHpz+Dk9Qrw4Tn2uS23ZxbfFY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h18aaPaz73AkI+A+b49kxN6FFp+u4eISruv0EZs12AIoHykLUQdlFsdKmXvm?=
 =?us-ascii?Q?RUkootsxxGZ2ewTtv/mlmcmVb2+MzRXpUCd3NhmLZ41NFTRgu1bf+MG7Taab?=
 =?us-ascii?Q?wOk3kMMrOEiqIGuoADIuOCsW/6yL1E1S0rsb1BeduhCzRKR8C66djiKtCYdF?=
 =?us-ascii?Q?3YWdQNi6kJ/RrhurCPsVRon1MlOGD1llWj6BKHuSWPg6iQHhTMy7+bBvwWyT?=
 =?us-ascii?Q?CxkyJ5ZCij994117/Hxj/xdkMG1rYvLJOnVsH9khWraKfc3wp1+32Rm1KnPL?=
 =?us-ascii?Q?WvGEpQkSg6QxQnbce6vB3eOvvdCBt6i4ScxDBl55vSCA1E/EEoIlCJDI8xcI?=
 =?us-ascii?Q?M3WYP83n7lWog40o9hKBWTqojVAqsJrZ90gOAeHBeQsJkhjAnibD19z7CPjt?=
 =?us-ascii?Q?PFBzV2Q3YUnXyQPG9q1xQjFKdf/bsZFoFsT81HrIIjBqlPmbh67c5qjepj9p?=
 =?us-ascii?Q?VoqFtCIiH3uK+c+m+OMRfRsyaHPCl+h15Sd41S4YjmGQUnGa8xOlLUxgXR+m?=
 =?us-ascii?Q?i5afZIauYpQLnEErxPD2stVTG4Dt7pqyMJu0B3IgdRefw6oZiKhoqfZrFsFM?=
 =?us-ascii?Q?XX++HZw2VWExdr9RCcFtQdxp4hFWUDeLBZMuNnKFTS0tEvsnkr51LTUAhlLY?=
 =?us-ascii?Q?pK2fG+tEvEGcrT83aEz1XAKUpGyuJbCAvIkpXBg4UcK74amEZsMdclWJQr29?=
 =?us-ascii?Q?YovgSB0u6X3L9g1XeIfUaF2GvpVwm9Vr1cRlQKRClOTqM1xbgrsUReDP/atX?=
 =?us-ascii?Q?MnwqCmt/9zzkNVdQwYxMrTJDHChVCxi0QMNU8sFPdtjx7H2ABTjbjFCdNE3f?=
 =?us-ascii?Q?1Qh3o/PjZ4/Wh+JycIRi3l5AcAqCSlaIreD4CzmdKmKGH7D5YJDyE3QD97K3?=
 =?us-ascii?Q?fy7LRo/O9Hkw99N64mN9OVi9bkuqIOoYe36j/mUXb1ip8i/wPLWOS9RAbhps?=
 =?us-ascii?Q?imJE9Tw4Ve8kONgeUmhkgQtkD8Md7VfwgrSUqWgTp+aWpJcSkfr9AxYm2G8H?=
 =?us-ascii?Q?IUpJcQVlF8vi0dq4vN4KdKDfRHG96XCfiTGYYMPq6LEW3JSWPTswv3zA+0HV?=
 =?us-ascii?Q?GrDZpITl+E6nzYZuH2YRb8g7+cm3uEj+85KpKgtCvI5X+nfD/rsB9qqQBTEe?=
 =?us-ascii?Q?QDmJoAxGTilSidd51LQKYNpAP4fpqM/7VQnU2O6h1iWZsw0LukwiK7MsXlz8?=
 =?us-ascii?Q?JKjD04fU270efSA2Ipdgkx+CfW+HgeivHuAjzQSRnepmrzybqd8EfTAsVW8X?=
 =?us-ascii?Q?aFbMvhSfnyvo8vqEkS+Zz22t8icpImLxMwFYFjlOsMAighN/E1OltJz4KaDV?=
 =?us-ascii?Q?kSawD9W9somEnFGsVDibk3dGQoTAWlmrxNIj47QBMcbHKpegdP/ZLc4OMnfa?=
 =?us-ascii?Q?+4dz4FUnUxwIzE/MzgUCCIGayuTYRySho/11arIKSpfVnGtFonZxyYWuw8pp?=
 =?us-ascii?Q?APwduvnrSL5uDrCiP5zTCESEkFuj5ENVRlwl71kiWfFLWLNZPxW9s2gVTrHM?=
 =?us-ascii?Q?7U/rAHsjIv3alAId2WzCSAlpFUyUl4kZyKxl/WQr6mwX2p7nkRW3zBABJuYy?=
 =?us-ascii?Q?PdIcJDtN8J08A5x3a7B0X1YDHH/kZmkasRyunzUo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b0b1c0-ef84-4c8d-2cc5-08dbf01d6a4a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:13.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lX9++RciiX7PKGm9eXPp0tdseWxqHYQCe88RzYMJ0B9Ul6QFR8U2h7qHpjwm2OFj8uEW6lkICNg/p8HCNuOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..b3a606a5e182 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
@@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3

