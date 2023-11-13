Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C51847E
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FUvdGEN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp/CCrrAtG0CscJy4kfEaMMvD43hoNJt83Ok8+iCW4KeTBB719pwsVeL+5fwUI9kyPfU1weLwZgOUoyBhH2ihYlC+ot+zAavYdsL6A6Wo196LAoSo4hyu1INAwKa8YcE/llunZVtVn6zIoMd2QZKGfGE1uZvrRtrIJJr7yrTNdOEJ8VxJioU4PuUFMPFYgTorl8HPWylpAYbna+4lTjgQHp8+PiukTMuCzsQRzVMv9KR0ztOMJhzr1/x5UZTh+M4U4cLRo5L7ePY4xcRwKSfBrQd3lyoqrJHmzuqiqBAapmIIkVtx3zmNarfVYagX5/w1BSde3qt+cBvMxtm3ubNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=PuUrWPljSREaDV0L2KqYBE5su1mGdcSMAqxmCNs9/vueT1YUwY3J8Wt9u1YNQYMyWTNV+g0LXmSsAgGNZr258nvbVpEOKuuPaMhEohsDgLeFdrXDtNsmoMfSk/BUwhIHD57RoLY08qdjTzb8bVuwK4rF2yDKb55O7c4FyCu6wTw3grcHZSes4Z+glVFwUvhPJxj6c6tQGuDtGwVcOfAmYGuScNHdbjxzZxlEYvyUKCvG9IzeruxcrY9MPcHqK8R+zue80uvwaN+Nyp+8z/TWbagSdpZ2lGBf1JIH8OfSoGeboWesyZ0ZoLrCXuBQV5vVKp9k4hKOg6BCzVZuM1jbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=FUvdGEN0JjRb4uAXjurW0OjEBzgljuiU7MqWrlcR5PPaFSlfLBucBvDybWVA2/2wu2i2511WtjQ3R00jFsgcgbikN/Kg+pUxAWollPQ2q9B7GklCJvEvPXclLHK9lQUpVEAeHtu4Xbv1PTrd/Z3l8Izr1dxPyFtT6rnufuDXSJL33sVOlUKQJGaCdUWdK0ZHZ4r4qD67Xz3JTdAIWGoNHESJI7wUwdOCndkpUMwzeIBfPOTxbzykjp+v1b+Z6aJrb2I4lusw1PvWGHgpTEJKRpVs/QXRGqQ86mgx79qUrlanN5LxaLJ+Jl6myMEdlfm59aFc3VR9+FQwCkOdS8EI4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 03/22] mptcp: use pernet id_bitmap in userspace pm
Date: Mon, 13 Nov 2023 10:48:47 +0800
Message-Id: <491a36380357282f996cd02e1c37381010823aa9.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c372dd-45fe-4e0c-2fb5-08dbe3f3216f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4c3lYsHROGj3JlYrAay26UXyXQoDk1ItsVR6RW31hz/f53hp0MvRRukyl9Ui7itzT0VGG/3Q0MN3EsqQTLTYeqFilR1Q6u14tIjgVOnkgDjrfX/RX97KXM/4XAaPsGMk/Sq1wdSbRExyA6AYzlUgdvCeYzai/Olh/wxdG1a0ecAPVUS1jXY3b62O3QT95amR2zXu+msTdgwZxesf0Gm8lsTVNL9BWQ8QJLBYAModLKzOM/uIOf3afSr6X61waRN6WNacjSZ/lq5a1oUPeX8Z5hIvsAFwdAVIuoTa4mzQ462VcDgmrl2SzZ160XxePAXMWigpvsRvtbQSvyHdJgyxcUPGDfiAOgjK2pUGuhZZWvdX/8qzTD8gJkNSJMx5Qv0ZSK842CIn4ZziwuS4iEArE3e3HfUnLKajaKd2t3SIvnoTQOmfOtDfeE0vt0lPyVmMzDSPVFsmhkaeiyTdqRpLu5AGxz9IU/DaMPvMCOI4j4W804j4dP7Y9gsq2Fzbg/t4isNrSBUuwjWsJLHok/7HsI5mq7q+NEYSIfeCygJvfeSaZbsAL+S1LPKD5sBVClok
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1t1tJ8+8fTd1IyM3qTE60kyqWJRFh5GdDeg8TB5GOD3xqXfgfjgmbXXhF1VA?=
 =?us-ascii?Q?KFAwtvcJcd0VM0k4ereHZnh6pJ51Xo96h7F79ygvsMgYYQVPXegpW3VDzdn+?=
 =?us-ascii?Q?ZjQLboDyetak7efFQ9hwmIowwuIccXvBqXq8Ha2of7IPOZ5tZA+3foeb/EFF?=
 =?us-ascii?Q?mDylJz76GY+m1JSrXQaDvo1asNnM6uENs0raHL+A0kw5GzPfyrIOL3HPq7qs?=
 =?us-ascii?Q?bYf67p/Yd8jd2JxuMg+21/IVf7bxopoxX1u6Zk0E5A+2fB85HzVUq0cnKG7G?=
 =?us-ascii?Q?Ei91Sa8FvWW2qkf8vYtOeEeeP5/5k5fZ+hFL+cqKj2FkXN85QfgQyTOZpM0V?=
 =?us-ascii?Q?sVS26XQrtaOBm86q4Ej0F+uNTc5azsfWHIghJaurO2VTd1LZgkak9P7URveM?=
 =?us-ascii?Q?n0dnnWrFGrbl7pERAK1d665bp3nKLMd/aqM50qctqHWZuf5HtSbRc8X1JVvt?=
 =?us-ascii?Q?2m+ytBc14QE3EpmBjMwUj6qrK1YHaBbP1MPusQVCW8vNgcxlkKdlDAuoz+sk?=
 =?us-ascii?Q?NA62bBFTMbNDY/vRwlsKPK0+Or+wXLSmuuh+9GKBNkP267zQDo9id9t3b7iU?=
 =?us-ascii?Q?5uuogfZgyvYQquBJHkyLTAFqdknFyLc+LGeCQMIOOApCRwmfBTZpWBRDGH4c?=
 =?us-ascii?Q?8IePqVypl3mkpDPKRPjWtoFe2SzvK784XLkhBVuehOaXeMmxWpgZ221/fKTj?=
 =?us-ascii?Q?PZJ/s7w5+CwR/lrSCHzaFPGtzPHwoZwr1WSSeae259IlZueIyUhKUQmRAp9U?=
 =?us-ascii?Q?zTmXI+1GzRHICpCxMxI5LWBot+HYrsR50DGXETtMyK2sdG5Wb+XvAT5gPDmo?=
 =?us-ascii?Q?AcgCrsB3oQXMl8hUpxra54tEntcXz0ka4OVQWVKMQRwzGyZ0wlM67y6Sj0Gh?=
 =?us-ascii?Q?7PvUvKPHL76OOkLINbT2vS/mPfq5wbIDYTPpGju24VPy94l6fZ0Uf3gftuOm?=
 =?us-ascii?Q?pFB5lpIger27c/5ZuM/dEGmPJ5lZmsku9hum26ANH/CB/CtDkfg2aXksAjr3?=
 =?us-ascii?Q?349R4LRDHWuADE+KoQ7Has8Yt4iYV3NkRDRcS+qMcJSqwSxHbVtcDE3KJGio?=
 =?us-ascii?Q?47RBsIDGpeV5VgAvQ57rqz8EdMRWei8aO3QHLuUmrzkzvadv5lZKxfUAmiBS?=
 =?us-ascii?Q?KVcQfgWkFRy2GPIT+HbX78diCtKyl3H13VZNsmGCC4EHkToNlrmD3iMLVvPZ?=
 =?us-ascii?Q?+5u0U255MuzfrcP73Gug4iXcRpCm98rUltJsPG+LhqaZCv2XxLxzNfwWgXcz?=
 =?us-ascii?Q?e09bruNUVm0Zc46p21caoUtsBF3y7qj3uE6tsjxRChjJvjA+LwpsVi0VRZ8n?=
 =?us-ascii?Q?zUTcxk/VMG9nQHqhkVpyy4vd9Pf3e5zx7erj0zhu72r4SD9K42H+/y6ixoxd?=
 =?us-ascii?Q?JuRCbkcF3ZrEW58IRD6hHKQfp5P5DWPwxSC5+E+vBkxBenYq5NtD6XB852xE?=
 =?us-ascii?Q?MkcojqpLCDzOScZKXfWhzMAk08/JIzgfxMLyJIKwdizmY4GuDCnNoS+tytQT?=
 =?us-ascii?Q?VY2FQi2OrJmPh9qVEkQs+CkvxjB6aMYm1ieL+zkdAyUWDtB/P1nKnPRNjkUs?=
 =?us-ascii?Q?W2PnIQQV25oUWe+2iPkptpgHHRH4wHj2ThetQKzA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c372dd-45fe-4e0c-2fb5-08dbe3f3216f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:18.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAoMobs7/H5SXZiFqeav9I1djZBkvDi/T1Tir5y/+wo7UDHBmDZPJk5VUsK9vUT42z66MDwlWGzyuYnOTOHA3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

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

