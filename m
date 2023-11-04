Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF4196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZE2mrfG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp0WTuk4rgTF9oyM2I0Adbv9A8NyveRsv6BI7650HbSTvjDMoK+aNm0F/emamTkypdHaF+/f88tPQOj5sDUm3PkNwn+WX8WhwLiH+DrNrfsioBXbZqGlt+DEQskDAKvh5Gbic0sip26p1tCJyfCGpOBYwa9aJ3n6sXzQg3vOa4NrhFagp1aEHbiV4dmBvOS19QhDWID4jOUBZux/HyZhW/0zxQlxIUWxeBuOzVUWBoeCV4mzIHz7ERFl8YdXqRFkgBWHiHKMXgtnmCfhSZnwrfe73AAUM96osBPOofzJeA7V6QPnDbkXmS5lMh0hFhN/7zJyVGc16fFwBYmJrVfwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M5FinEGfSq14lJIJACyytPQQd8wrgeus94ZGGb4+dY=;
 b=m59HciKTnhmWAfoxWwbEV8dSCaz6iaNwzoa69I5QCjAZOV1cpA2Y7Bci0ZX2GnYM4UnimIWvWmv3FnOlT6lPgCq1DieHtIrAFk1+SBFi2HrGtAFVw83V7iOE91oMCDTOKL0kFwHdMxPldZ5+EoPFCbAt3gEud1OtDpkIcw1rLRBr6QhrTRWXnAdNrBviLBBN0pJeX+koQeKtCHhFS5yOG8vmWOb2xWbm1UFiBJKT6fL1SPGQbPvMcwNwF92BLLaVb92TCnB8vg5bPaAK2ByMZ0aFMKoZThdBOa3W6/hEFA1URKPxFhTE37NjrJuvccEbpN/5kF0dcwMtpdk33AyZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M5FinEGfSq14lJIJACyytPQQd8wrgeus94ZGGb4+dY=;
 b=RZE2mrfGOmVI4yqyHBbnv/aEZyYSlNA80abxM25C8+uJg/S6VN9vAoav/5tPnWGeZ3oWHoE/fEuW8LJGV/A8nGCct6og6t9OYGxFeU3Y3Xc3uAFvEvIUbSf3K4kY14l4nMcXFWTc/WHbo9tkUS4ZcYRPN7Cs4QtYOIN1K5Slpa6sNRqKhgDvbUKWPJ6REPtlx/kT7xIlLBa+CtvQILA53QhYdXm/dh7KPaMhRIElFkPLizDXhSMjZcYHFnQU3JZvTdJQAmw32lQ8JV7BRMH4exzvrabXCZV5bVBSc+UwxYAj9gByRe2TPrYhCyTFisJbWCE/KtY4H8QgUe+2w/q+Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 12/12] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Sat,  4 Nov 2023 08:26:23 +0800
Message-Id: <7492afacaedb042947485e17c1797558634ba60e.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 453c8799-9ed2-4ef5-636e-08dbdccce4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VPRZweeauGxmvAruKfTML/h7DYfPq1IXZLdEEcl8eVbmd7iSBa42ILoHtFItYlZ9nC2pi+aaidqwbXAlHdX5R5tuv7MiNPabmJZhcHzQFoHkjtXUdbkSAMt0AqGDl2k7m5KMNqeYY6MF6MRzze5YSCiXZuc4aSIZIukfzP8N1LhdyLDGOPlcz8RZEN+pJUbmYjnFmx31/6aP3gf1Na3kjvaSzbdwD6JGkmcinyfHXCGzC4m6DMR/JuFqXZ/cES+TD24/6s+MCf0I+4qT4cRiveyrB7ueKbXE8VeYKS39YN3HgZJ9VhAN2JdOQ6GjhxNCyl5V9pGPs2SXwdaLcjWiqp4WQM8LxTYcYBJ1dhm0C/vxxTzDi5rWwp7b25Iw/Kv3Cu3TFxTSqFeh8KoTaJrKHNHSpi1F3aJM82YkDcQyBccYlVz96ez//nuqxhdcgcPliv3nDQoDG9IahOvrOqngdQXAQzDrMdaqiujE4ikfMnuh7M0fP6s4m4PuZfkK4Y/KkdQM/jituAZNi77EEDQ6sQeXwDGG8VA3aOifUU1wW6ZAo1rFdd1Sn3pPfFXkzritpR/mixYy5OQP6W7J4xN6KKAU04XifIbsz2B1KeOJ0iI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8b5RCTJW5ebOPptOnHZI0ncK7hzv+tyBxz5Btqay5cjYKd6YjMVsPds3dG4f?=
 =?us-ascii?Q?PaK6MAFYF1xIaJsqr0J8rP0iSwR6/lFVMce2Whf5pX1ri4y2OgO//qKrhZGV?=
 =?us-ascii?Q?7K8SlvsUcEkt5gSOsc0NbRLdTYYi8AfwBoE6NXkKWOuQAokt6PpuRZ8xNBK0?=
 =?us-ascii?Q?/B4BTdk9b9TNCUf6SiqYfS0vWrSii8g85VQ5Th+l+si+FmjUTgWvC6HWrUUc?=
 =?us-ascii?Q?ioXDPEZ5umuLYJ1FYEmQn5NwA/5TsePz2DLZgePx3cwSEYZUV2ph6KHMA/4B?=
 =?us-ascii?Q?QeIbrLmKGMqYAMmCMiZn4kqGV7zbvZIXG7eP/UNHGDWbFM4+Z5wSKgdw1gHH?=
 =?us-ascii?Q?qpZChjPeM1jaSLkEJnrnMR+3jmUiQzNlW+mDTMUv4ZhRj0NY+xcP0cRPupSt?=
 =?us-ascii?Q?iR+fBRth2y48iFJ7qQIStqzA1Y7+wIkl1qC37unYWZGyrY5E0UB9IA9cfJ6R?=
 =?us-ascii?Q?Yk0RveZTfuQVxJSzMBvHgwpI2cPmzoppToKqLWuxVVEAnuUZH7zjkfs7eMt+?=
 =?us-ascii?Q?BgtE/SQuwmvUp941SHsOW4i7oHQ5P2U98/4WxiOsx5M6xxIIYQG75V98yelJ?=
 =?us-ascii?Q?RHY8K3U9LeCEPWMsIIsmfHrgWN4Y4D3i8mb6m7LDB8xkUUgQH/xrYg0kFd3C?=
 =?us-ascii?Q?n59j85dAQY6Qf5m7vkCjXZDUsUrrezeVXbWalaweMR++XKDt6ZP2iUyTYMD0?=
 =?us-ascii?Q?vj98KY87djGvCVDRF0q7hlLqmXWSSbByQmVIwRVCWiK9Ghj1JtzSqXVOgXOj?=
 =?us-ascii?Q?KtXTs5NYUw3dVg4lcMbQXgb+nuNEPZDbbzJ6FAXVcXrS+xCI/TcuBTPcQcny?=
 =?us-ascii?Q?IlCenNWgoAq5NHPYAtfy9coOLf5E4iGCrZWvA5a5D5+EkRAZ3i2Pi+Loa77n?=
 =?us-ascii?Q?jL6tvUproQwM/3Cr9+vy8LPXxzdudBZgs0UDpj9ypq4paYhHfSBONWMxfEjB?=
 =?us-ascii?Q?IBFkW45jzhyO6SAMh5BYgcOSKGhQa2wfcsNfalva15PjRLZreOcLM7q/eKmQ?=
 =?us-ascii?Q?u31Kg/dNgIxNMy1YkX7y9gWiJqps1DnyydgihZ9/a5dgSh9FQRTTDjspgZ7V?=
 =?us-ascii?Q?2gXyWw1yTpxZ0WZWmMP7t5WeIJAEJNbVqr94t9+J00Sh9SlM2X008/E6SivN?=
 =?us-ascii?Q?FA0D1kHStkPWZOOCEXOZNWv58F1+ljIhqDUFPeIS1u2Zy3IGTFCvwhIuOXNI?=
 =?us-ascii?Q?p6QjaRYOTf8777Tw6ooksJ+RZORjRgydtYmDOq8FPP7tbUCK3LEb9Fj5drAv?=
 =?us-ascii?Q?ldKYs4b3C2ksFVdaHbXz9a7V2OafDmeX8ffBQXLyDKFjgg7KDd18G2boa/4I?=
 =?us-ascii?Q?LqpyHe5oMAVhKqBKatk0zM0gy+E1PMBe6VXbxZfQ07Duwryoy3TTzYEp8GhF?=
 =?us-ascii?Q?WLddbXnbYenoYi1QRKgvH+GAEbeDpmPDj2tlxBv1x4julvrVPyjuJ/SrRE8x?=
 =?us-ascii?Q?zKTBC13uSvBLrZxtms4j4dG7Pv1ZKGoJEPs9LnRVhY4l7XHEm6JSxcCRziYo?=
 =?us-ascii?Q?OIGR7vjuqWzZtgzViOjjpAJat4oKFlKKOm5hw/RVx3lkXiUTuoa8+DiCKmOG?=
 =?us-ascii?Q?0WqbjE7MTE+emDeNfHnqGc+eQomA/NLhm7V5YIzNaK5cF3mWBkNr7ZBrGpDD?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c8799-9ed2-4ef5-636e-08dbdccce4b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:57.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRL6QB0iJVMMLEPyCrvU/0nTQg/yLU1Di6crP9jXTFyTfgAJ6wqIe3/ic4eNFJg2fvZIaqXmXkK8Qavn/6vOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3499442a9db6..1a66de9127e2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -539,15 +539,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -577,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1917,7 +1914,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3

