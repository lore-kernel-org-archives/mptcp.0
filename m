Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590413AC4
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1Qj8nzFUg8lnsJxZTKl3t07Pyu31heQ5ChxpfozSnq63dM3GK9sShg0Y5R4cL+R9hZm+qYhUa4BmQ4Xd+XSb9z+4KFWED0TL8WRlV72qP9n+cYHg8p9ksufs7b36KMe+K3WdOsAnEtU0FOA2NLhp1ypqYKT57Y/90lUWspnRGBV9X9/+F0CzV4RBSb9IpsW8l6Hr2BMa7uzTSvKI6ZQQVd4wwXbUxsoJ5ToKDVcXoh36MWCjxtbeKYEsH0S6D2oe/Tq/UJWQtv6caKeg7dqmh5aw0nRf9t2AGfjmoVLjzSI+k4W+wMyRSsgAEs3+yHnS1YLcvT+7KVin0RiOb2oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T55dUs4++eh2ppsBm+zIdGBFkAtOHJYdVFghqs1j8bc=;
 b=I8VR29By8lFdKbtR1llvWegwxCpsEnMf1J6Yr0Eh7sZXkIXatKXiy4eEhX1tuKOP1twotx4RYqDgyjPWKeZ7qLWBK+NqYm8v4sRvXktDq7Y4tGYeO0xOjtDMGtOClDk5264/fLdLJwejD96hJM0/lHvVY/Lg9idc0HKiyB3LqTvwGBZLkJQYnkHyHNhussEQOg6mU8rbkwV0qBKfUyqzM7F1dj/XUiSvkuzQMNq9sICQ2ehkq7TBbxzmyixbS2+NKuqITI0guQZZvJRUs4+L3V4VYO1z/LOh5pxwDXgqLfh3uxHnb231MSngvOvvN5Z6lJcil4X7+pfQAp+Ld7lwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T55dUs4++eh2ppsBm+zIdGBFkAtOHJYdVFghqs1j8bc=;
 b=qMN/ancxWaxpuvFXbCRlxJhgb6bE7jwhYmleH3irNVK6UtlN9lXvRLqIxpwsco5TN2kO383zwthX+tWUEcO6DyGDnlWB/6079WioONy1eGbpnbSSKCbUbMla37ONjKz46KGo8JUvSjD6vaK1FiYEnyJQRgHyA9pFzwXYt3GgzqcgSx/MGzQqkdpc5ZGocV2nhkCu1PC8REqHur1R2j5uoQIKYdzSF2xlQa4yI/Fl+biDC2PGwYS6hmKvtqo4Ej6pHIoHpmpneW4qmF2sHvsPusT5XHBUpiDmEMSlVBn4udzvOLbmevlvZhYZH0r3QucOdXiAqOtu5vtMEMpJFj/oNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:12:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6411.019; Mon, 22 May 2023
 13:12:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 3/5] mptcp: export remove_anno_list_by_saddr
Date: Mon, 22 May 2023 21:12:00 +0800
Message-Id: <7e457963498bbbd31e80dcce81eeb30ecedd2274.1684760588.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684760588.git.geliang.tang@suse.com>
References: <cover.1684760588.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f595f35-6593-41bc-74d5-08db5ac63d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLCLl8Ofz4+Oq6+CkGOMaOJXRDQunIO40nG/blscXrg8pFixm4wsktqMSR82HBqXqRoNmbtNyinAinqvhX6sAh1h9GAoozPto5/Kl8KIkcNoghED87Hbugxty6M09oxP+VKrA1EEry/opOTzqI+EkzowLl/3QmpWV6tYC7xnuzTr7hTRCUzktFl+cQr30siVzKpydJnYw+uE3NG/OEjXE2DnXuWqWcSlAtZCFwnZZUUkdHsO2Dzy8PWyuYjrXTTaaMTZZmSDIe61UPBxThscnJQbwp+gQIdOlbVgI1AZcjHLhi3Te1nUBdtXmqgyiC7sDrib4z1IsuEqiWUGrOeYiYTtXCgEv3BqPyana4a4OS5pqA6gN//3dhttNqWxx3P5QVxJOTiKeuXtKLnaLgzmOyoJNDsAyLHq/zHMXH7JuFw0RvSTDc7HRlPzv7j9vE79OHdOiZIhp0P0uhnyJfmMhWbDlNqdRK9/314UMsM+6lnYPPLPSR5+skQIOTJYf+38zkIk4KjvElLcmEZofyWwjOrRLrjb5h9urHXMfs3jMgYS1NoeJPfrJFUmLQgS+5u8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2906002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(41300700001)(66946007)(66476007)(4326008)(66556008)(6916009)(316002)(36756003)(6666004)(6486002)(478600001)(2616005)(6512007)(6506007)(26005)(86362001)(186003)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P4IeSJ4CTnCTTwAmNKkOpE81cnwERG4n/o1O2I53Ci1V/raVGyYiR4kqMwbs?=
 =?us-ascii?Q?in4GYPjoFxg0sMD97yLfCv68BlNFCPZiYghsADnDW1/M6YBBnbE5aMfqaYjd?=
 =?us-ascii?Q?ea9dtSrihfIOAL/lcSQayPlgxKQ8o8KynVzV0lHkf82eEMKxSP7f+3JWcC6y?=
 =?us-ascii?Q?Y6NuLjOPtgKvt/4JNOGl+pZhRU8vw9P9AUtepvHE8kZPEIKKhEjb44PBOgrh?=
 =?us-ascii?Q?zbDW0aYVZKKngvERJZmniA1/ILoyXOtMSQt8mSKAIZUjklT1595wkOkO0f4y?=
 =?us-ascii?Q?umDgiT1uDrFwEQ1NJcq12uCMZs9vp5QTYUW5I0vhb6nJkuKU5YaK7BXjjlDl?=
 =?us-ascii?Q?smanIQiYdtYWlCRpYzJar2DBKiZIzUHU8XVBpBq6sooeBCViU0kyWEEg0L7y?=
 =?us-ascii?Q?UUDlXJovW5Nic0kujpmGRAqXo7yTfS7uf8e0JMiuvsGBnSeAPCdiaAEzkJeS?=
 =?us-ascii?Q?XLINrvMog0W2StwFvWzI6x5wNaiuHmKgpwNPtTckPUytrWybJdHKjFdlxCKX?=
 =?us-ascii?Q?MC6atdM8H0mOKejk3b6l5yeSQelxjsqzLKlRBG2uisa8drAzL1s2bi2fz4RK?=
 =?us-ascii?Q?1nt/wpmYC/tZa9FhPE7bQQBdx6fEE4ZoOuq2dlVOybD/wHe3c52XK+zyIu+q?=
 =?us-ascii?Q?j2p0wPx4NMO+RbVuPvgDXyJ40r+goxyQSFhk+POm10yu8wEQEl9bH0Zx0qjS?=
 =?us-ascii?Q?98P7cqonDzW0iAr7KH/RLUrXuxTND9S7lhxorljCOidaQ8uHU0tE4FfoK8RI?=
 =?us-ascii?Q?HG4f4NtmHX7zGJ+pTh14Xmtp0pqJiGsnzhB/HA7WFjETnFwd2bPtpTW6raj4?=
 =?us-ascii?Q?u2Zzfk1pN5SUyLZFMk4qdaAWlJf5jvq27MyjAr5qri1WmN2x3UJbvIsazZKF?=
 =?us-ascii?Q?MrlUDNsNm+UZ+yR8Gta73folbIbknMdLwYbHVkuEcZR2ZZ1yO/A885lbqKon?=
 =?us-ascii?Q?dTXvmD596r5x0AH2eGKBbCtIzau3K2TbRD1urj87s/V6lrgLO/Dbhw1uAl8F?=
 =?us-ascii?Q?y5PMiMBy22tReyUwDw9NVapz2NfTJEdhMAHwTwiOia2gzTNT8PM3TPJOmKCM?=
 =?us-ascii?Q?XJZn0dxIde7yhWv2Kp2WQrN+rr8oWAyRkTEHPO4jMmiwDiT88oXAXfzYvnjo?=
 =?us-ascii?Q?PHlM3HqTu6hTPxrJ1EYviM1nvyjwBVqUSjaH76TXmVprHlfimYRaN/76k+7S?=
 =?us-ascii?Q?k2/Gt21i2nq1AlfThKqa2mKaQUfHb1YpYl98PhGnA8zo3Ggp1bUOcoJsFxy2?=
 =?us-ascii?Q?UvBpcRWnhLRamVQblGH9dsxl2tORyb6gCNdApsKZ3YW48V3dSF7N1UOESAWa?=
 =?us-ascii?Q?ww6m2rzz+P6coYFBSkpJbLeHKRWKmyEOwM3h16KI0RZN1LDFYZq6jsGsvz52?=
 =?us-ascii?Q?0G2SRnjFfZuU8YK2UCvy14tr5iEc2Al5kEGF8Uwhb9Df+8AmC0b/ZDCJQFmy?=
 =?us-ascii?Q?JzFxLgIUDPyZE0hQbaqL8OyTXAt3T7OV02DrDQD8oID4IOb+HaYCg2ar8kc8?=
 =?us-ascii?Q?dAVE22NEFg4w8FxcBJV/ifiVEybhMDa+ZcKUJk12fonO37QJeTPYcIAkzJBr?=
 =?us-ascii?Q?jl397GPChiKwu9zzzkiKwo13vV8dZhiK0e+ru/zk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f595f35-6593-41bc-74d5-08db5ac63d5f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:12:48.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8faoJKXU0D3V9qlOJKIdulVXuJI1Gy3YvTLgP4nY5G6NDmpcKsCb1BJe8Y1ubHlamlAhTfl44eugwZxJIE4PdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845

Rename remove_anno_list_by_saddr() with "mptcp_pm_" prefix and export it
in protocol.h.

This function will be re-used in the userspace PM code in the following
commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/protocol.h   | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..6daa0ed59ec8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return 0;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1423,7 +1423,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
@@ -1566,7 +1566,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1e8effe395d8..d4c13b488955 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -830,6 +830,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

