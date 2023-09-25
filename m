Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519AE125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlwWZ5XR2LMSYHTosX+IwExjcJIay6uVCqoIFOsidKL30Y0dPMI91+OCa3wAYyynPbn+X+fRtV64O/bV5us2Swm8945SL8Dt3qm6e03z8ugCVgk0Xip0GStQDyqwJMsBmwmKmSWpQV9WhXla4Y2n4EoxsEqlx+2vTy3OWG6B38dAkuXpo3paEFfpDoNjRE1XOoAX8RLc4Uyv2ytONY/B36RMHxXD6eD2Z/HlufSNkajpH3xiKzONwDqFBqFigFYE0CPy5XYGnRwFfe66mSKLd8+gQVRmzOEuVA8FGnwWxmfC+PKj8MldB/nQNDuDkUZqdKSIrCHQg/FUgcIYdcKxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swwYzwYXGyTpXR412EVjzkB+FQ8DTUfFiNtG5okBIXI=;
 b=Ax0Fo+NTGDgeycnO5WEqUITMQ2Ej5zQaRus7iOU+gWma4k+3pS9HUM0EWsWtBAvOpMkYBcD1T+wKpVpWxLZV2XSi/ozbE4T80Qd/sKo5SHGd2rLC/xCWx7/HqFpNIdZZe/M+C5LKV0RIe7DYlzyauL1olrySKMVuwwvOTqGNwN1HNkkj8RCO1iIg2+S97CwwmX02pZZHLTSEBT5b3iE4ciCCIiMY2jdTzyQ79OTXznl39FeGMsrAlgWh8wPlEK/t/xsp0NH5Bdir8qRZ4Gl+hkbwZzeL6wMPyAuRGihyQONRcuoPNWAl+OaswQNOHISqNP42OxMWmiyuW4BYg75k4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swwYzwYXGyTpXR412EVjzkB+FQ8DTUfFiNtG5okBIXI=;
 b=IiPUvHoEBsmsotBCzWjSqownMW1fxvJbb0pVis32wwMw+oo2SPHWPHwrWA9Oryz6jyDheDx31YZJnI8wG0TlTrYVzdKy6GfevvVuS5C7+0qGixcxbgjt+jGJOJYVYAZgajowzSCPQHjkJJzPHmmivUrem+A5D1L9skv6udWFr8PmQCh+gHXUKgfAkQLm6TvpLUcV8ujvpbV9uCztxU5rk8mz+rb79C8mGJSb8I9XJNGv520IHTBj6pjy48FSPOQRizujiX3l/sQL7UIkgU4ANUXZSxnrMb0IT8XvgDo+HtO6+306DsTDaKWaRAwpE8wfAMBwOEAEj43Z7kmHlJQdpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 17/29] mptcp: add userspace_pm_get_entry helper
Date: Mon, 25 Sep 2023 16:41:56 +0800
Message-Id: <120e561574e993cb50c610bab222fc0d76d1b147.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS1PR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:803:3d::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a4e8cc-a0ba-49ce-22ca-08dbbda37e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yF6q4IfNBAxne80QxxkxA3xp3y31M9+24WX0N6cObThvxZ3pRXu1RDcMAP2ZLtXm2P9IR3VobWsxqOIEBTYoAi4fefekvg3MGKZSgimhFfQsSwwKFOSOZlZlp3NcbLdSNhixZUET2Ylq7KT9gGSSbFy1Nv463kgmkhLBEbP3E1A3F3nncit5SDt3Qtb75uoCHWpClnuHdCHZAmKaWtjFg41rir5sOOTT3vBKbWsAwvKBhcEimgXU77MFTYFXOBxibNw8cM3GuGUEX2EKNVMFvfyg5pNHFhpMtGb9+32hBgLlm3WAFpmdARPgownlKmLgWcqcIL3VgoZhcUdWbtc3MPSEd+626hAXMYV8rOrO322clQpK0rzEwL2bnSil8OpjW6Zj6n2+Vr/lkvujms2td1hcDJbpGG8B3Qoh1PAmTZ6HGRoa9JbHGiUp/CXzRf1WHP9vQHaY2q7lT0BeX88ll+YMDGDNVrHsAUmL4f0geSXG+4f4/dLUDEAsoLbaGxu/sNzKt/Yipo4iahHPJwqPndZGwhHbVant+OB9BaZLKvVaC5EK5LVq17OKscQ4nm7Of5qSdukPKtEmoQCRc51bebKAj3wt5tvwJ2ce0QrlLIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkRkB9vEIQjY0bj3TcQrwcy3d7XnAkD7P1LTrDg5cyMICQQRtLLXdF2hUi0b?=
 =?us-ascii?Q?AHMByK88f+YlXkaDO49uXDo1VlzDfxrlGC3zOnWmSImsCRs3l6tFrbgqCE6a?=
 =?us-ascii?Q?YPvnwzLRrmrlgx2dL4o5kNfebxd8BhLDlVvDQNpRTKdgyTvdQAfwPNnB1IsR?=
 =?us-ascii?Q?jXHfQah/AmFephCqMIDoHMMTMtPTeha3COw3EmuZCZlw9coTKFt5cdF1o3Cn?=
 =?us-ascii?Q?dXs/F6i8b+Q49SxzFt2XWTgszBDvPAsmuqNwik3Ob23Hjj+T7oMcRnjWAD5W?=
 =?us-ascii?Q?s80yc22FFuNY4Sc01znMBfLupp+g6+vfYZaSif1ojvXWmnNCzhp/m7vZcUU2?=
 =?us-ascii?Q?o7B3ViLW866vA15xavJXh68s3UUhw1uwEwj0hHkSaJtV0PoC3P0WSNgJEro7?=
 =?us-ascii?Q?/zFNG4ZXutkJp02TzWyEtGw/pQHAn5/KKnQkbc4jTJVJ6T/yD86f55KXZTgZ?=
 =?us-ascii?Q?q77sNNa86K+T5pbY/4w811ZllK02fNdCPyt6c0bBaWzDjL6ptbZNQyjBEjrC?=
 =?us-ascii?Q?HcULtuGtNmuLnAqZCZZvwPiY+Zy974LRSMdikQF3DXRYOAn663LAYZKrnokD?=
 =?us-ascii?Q?d5+dyOcPeeA5jENMQ710YsrWABZxxMEsDScjLydpofNiifYYOaPnlJDE45OH?=
 =?us-ascii?Q?2rKHaZaNryVB9HQwnHngjcHI5NERuFWXBnEJBD5pg2f4T9tFA6lNAzQEdcDX?=
 =?us-ascii?Q?WP32qioQXcKyGqBwRVzfJOa+Dxo1vBugskEEW40wfxoOE3DXGgURHzg8pLdq?=
 =?us-ascii?Q?lccl2DPQ7uhD8E+qk+YrbwepgKLMvkHhaLZI6mgRmfuB0dKHs3UmQEjDSusp?=
 =?us-ascii?Q?ojh3U3BjDWWcHV3N1fIUWkw39uQy67K13UEUAgvA0JSo7jl5DvdbSYxk8sBH?=
 =?us-ascii?Q?XjsSIOC4wlq6mMNKfVVoPqGOdmlBxDjZj+XiND69FI6DiXqb/0EuwykCC4zN?=
 =?us-ascii?Q?az2rNAuR7gKjSyiEqGeQVW4UjqWXAq8sYWD2eCJPrgPgHYmVup6mlQdB+Vs7?=
 =?us-ascii?Q?GaURSEurxjSIXTVzUGP0CKExy/a7otDQHoLzYiDrfszxjCmwfiu4X7yc4A2X?=
 =?us-ascii?Q?1Ki1qIFMxUYHsKK4ZfOSXM+QHtdO58fJKULsA1UTthn8r5QhZ5S/QhijaKrB?=
 =?us-ascii?Q?7PrR96qQVbSAN+VCFCqsgMR5WbBC5tvroSIz3WESlVfo92t7vee187Ocf30M?=
 =?us-ascii?Q?2VIyLINGqpQb305tKByESq3XF6H2FP78int7xkfYHYYxyje+HJ2zrLFy160+?=
 =?us-ascii?Q?r2XVaFWaRdP4jznDqaERJ71TcOUXERbsfF2qixV++2kzr6NgW8CpC9Ch3GR9?=
 =?us-ascii?Q?vV1KXbRapmPyPKHoDwHyF3iJFD0giHtvKvOUMwdgvD5rPmL2JcKb1nzta3//?=
 =?us-ascii?Q?BW2PXxVxarzT29sWhiCSvhgLaQolVY/mGZpqK43oCSviBVKsqHKUb8etn6B5?=
 =?us-ascii?Q?xTbx75Ww6x88BQVTOLvBq9WiHCuCakt4InhFKsUMGUcClerWVsnNSR7RZ2Zv?=
 =?us-ascii?Q?uQpwjNmRFn8IQh788hNTysfWJl6yS0ozFJwza0aWc2slRQvJGGYVjI125gJL?=
 =?us-ascii?Q?4OqaKKxlTJF9fJ812Ux7kNOWYaTf7pAfCL+bSMgl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a4e8cc-a0ba-49ce-22ca-08dbbda37e1a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:29.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPRrYGCxSXhTEU6Q4Y41THaejLZN6Nzx/YNAd/WrVCsihtB8ybtLF+KHZGIcD7imFSuizl9s/fqYFZ0E3K/zjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8d97cf475cac..30f4dd074a70 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -80,6 +80,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+
+	return NULL;
+}
+
 /* If the subflow is closed from the other peer (not via a
  * subflow destroy command then), we want to keep the entry
  * not to assign the same ID to another address and to be
@@ -88,21 +101,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
-	}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
 
-	return -EINVAL;
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	kfree(entry);
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
@@ -495,10 +506,12 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
+		struct mptcp_pm_addr_entry *entry;
 
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
+		if (entry)
+			mptcp_userspace_pm_delete_local_addr(msk, entry);
 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.35.3

