Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED51105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1cvSMjT+Y1qV++rZlsPhsemD3SBFV1JplAUY3Ut58EwN9bnUkvMQBHIhVVFb65BzTsmINKzdOEGmUax55QbseJdQj38EW4nDRUcKyqkMmDVCiI4gq8CGf5jq6zlbsSwDc7Ak+gDCQAba6WjEWXI+Mui5ox22HyO/erdTqPndB/P4uQ/IWIEyqVSIOQcds0DYmcSEL7r+uS6meDVhu4o17hgLVjisEcVsFYacd9K8rUo0XztGW2kur7bt8+g6NE/DeytJAlTZnts5HB4UfnSDfR7y4/Igx4evNm0ZIcNPJBygaJZuPTlpvQYqExzy7R6zI+DAs4l51HZbDp56PzXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMilMt0cbCCV12gfgN8zJCdI5eDc0AjXhIzM2HWCaHg=;
 b=AsNNoxqjvspydsYcann3sYm9AbrWf2d2Gyt2KcBf7K0qge20134Lza1XW6pSmbDLJlWwX7z08akkDLaAoJ1pfx+yiFJ57swvy6DmmSSd2eAq0yXotIwZ2/BBW+fH5kHrhVE2v14TVx2dEU5srmCqN1h6K/wDnuJR5gJvuSVgdUQn6/vVlmCTwxqw5DoeEFoV1H3NZwEMb+5XCYxz1iaULQhKjC8UhMPq0NddlVsEOARltaKwiXWiKL/0I/dvuj6D3kEgU8ZmkaX/8+UI+5fqOfksMhvN0cq1oIjJdshdIwgWn/nPJI5q+hGkyFT6OOs86P2gYqjw5U4iZfJEyf8ovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMilMt0cbCCV12gfgN8zJCdI5eDc0AjXhIzM2HWCaHg=;
 b=EgrMWVoZWnsfhOqiC6YC6H0o0H98toUoalPJAyRkg2cHfQhF6CqSRLiAq61ByEmii2hFaL5NiSO0qZS3kLWuoueOguZz1c2YJJzq36o2+7ZCsjmfEpLwdknxrPFB0QCTh0Zm1G2t+WYByXbYzsvCHogQeVZuWILAwbtzD+NTeoK7C0Ak7QTfpBMuHbLrain9gj667J2G45fh2v6FzqwIoqzj1873zkEemntNmo8tm3Nt+6g3SaQZoqAx+gzm96MUSbXndBmjE6+M/i311kUJStol9MUD/Aq4TdA2ZZG7Brl+9CQk9/vk9yYxPdL90GRycCabtXWJZpTzrHTmA5sVZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:10:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:10:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 10/12] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Sat,  6 May 2023 13:08:58 +0800
Message-Id: <07016f2e87c5b611d87ca1761420187f87cdd803.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 30324a58-4bc0-4808-dad6-08db4df0271e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lGOFftB9Q93vUr3kSIOWA5wjy1UHMJsi/ktF/lPNtLqM5qEsZhuW2xoOuzcEkQczVwhgES1OnuG49+qoEw6fAfp6PEOFhgo0GeO1nNOdlvn78OAi//VkA1WlowzYxBp5R/vP4KxL9+hwx2nAgRA1E/9G7diyDYp0UMO9Dfbe2Ys2JUxDdWcHeOLOvKrctn5zNnNVaud4LjtJGOu+xCaiqA03fpKfNcJoDBocko9SfnNJeKs+At3EUSQziMGKCWG65KJN2Uact94zdG/FibX8a+SMt+Y7DpWc36IPFF8BdJx2E14dSz2dlDiS4nsx0SP0wc/NlTcIkxMKcS6yiuIJvPA3DJ9t6SF0dXcihyb0vrQgNu1L9WhrnEEW+HckzFdAOj5PpTt75NPWcHgaXi0p61ElqK/XUxWLAU+5/bS0qnRy7mDo3lKfVr6No5BSWcku6Ue6YoymActhKiN0fanWr1naAVfhj03DxDYYGbanOrfWtoe/BZ/Mp2ExvCBEpSJm4OobV85tkFtW/Cuq6DHBcb2l8dHouqJgfloa3OKdKxIBHc0wTP+OsVodKTE1Uo35
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGf9G+7g2A9yUD3iz6yfvlfiBcP383EkZjln6sprmmenSM16EhH6Rge/Og+N?=
 =?us-ascii?Q?Ix5v6a+kV2QosqDI8RehiFIV+nfdu+QVY9nFF+dRQVN9SZGo4zZ3z8znWNt/?=
 =?us-ascii?Q?pelhjz9RW2KwDaFfKVLwV7/xNyzkmJuy+DNgcPWEgozlo1G9rMsqmzZZRKz8?=
 =?us-ascii?Q?yK7HTCor1LJqzdE29X432nk0wysLBUwQqZv5B5X1J1Bwcz+lwj2GCoxbzpBn?=
 =?us-ascii?Q?f/lP2gFdjXAVZxv5DDKLOft/7GCF8lrwiU4+ijtNl2jyTxrrgkO+uXOwfvYS?=
 =?us-ascii?Q?V+qku/pXEH2gl4YzbTtT54Pygyyp6e+uqJWxZygHwx8gORrnaZKvC96xjL5n?=
 =?us-ascii?Q?eGN2UN4OLArRS4GA47M85AQikC3fjpnRIYNSwmrOQMRDrF7ncTaQ8gLnWJpe?=
 =?us-ascii?Q?2aEM7q7xfsWXIQehHYr6znjS0ajiJWNhWVal9oMqNei4nZfbBckYrAuIsaAJ?=
 =?us-ascii?Q?je03VTUaUgsOeDShbf9eF45GtOhDI5DXPKMFHSoij6mZ3HTB+reIX32KOC1z?=
 =?us-ascii?Q?n71IZ0meJCvEn6ZEyA1YxH8wge7Cp/ZnXO2Cf/+SPyqAFMRZLLVdaxe5FA1I?=
 =?us-ascii?Q?wBTD3I45wqgpKff6WCVGCGpbDwzeME0usFTr+BfZ9S2aqvSenEG4x5tYrTkK?=
 =?us-ascii?Q?IPOULfUFC0oqQ0rqDRtynUAf6aMOGUxLbH2XSjgyvIMwzTeL11fC03rbngZ9?=
 =?us-ascii?Q?lZIWOnPv+Ok2JTJI3Hry/r8VoDDaknKbVC9jdr2LxyaTGgeIveXaO9NSPQOn?=
 =?us-ascii?Q?tYxriqqjfBd8uR/NxPYn5VxO1DDnPajkAYS70D4AwohohxIIrknZHaa3zbE2?=
 =?us-ascii?Q?FcwtsGVGmMsKhxIq92y+QFid4gsol7s/J+3WpBLizp3CzGoWjuR1jPATP0Fa?=
 =?us-ascii?Q?X+1RPe6Hzuqh3CIMEhdJLZVa6AELNaifRCqlKIFUpVdLCOdDmkAUw4rDdXD+?=
 =?us-ascii?Q?lZlx6E47qahWsCV4pcovqppMsXZSoUJ+b0c4z5AjtqOI0kXMXSLrwRWbCp8U?=
 =?us-ascii?Q?HV9tbEwkm1JopVNQ8+td6pjAbSX1aDNU+qVyLcg51zd8Rfur5fm6ylHxDiH5?=
 =?us-ascii?Q?yY16gz5pk9550zyfxca4yXUoQhfdbFy9A5/g1zQSkyavqLkUHfZye3EW8gCz?=
 =?us-ascii?Q?aRnzywkAIQaM4Xp6hErxLGA1zQZQ9rb3NaVRKa2V8IaWkfHQMJLnj9kSLJFI?=
 =?us-ascii?Q?zidqI36gnqQfC2EPOtjgah0aRUOCLFdBcoa9+1j0FYeKbwVBuLZemXU/TMBF?=
 =?us-ascii?Q?x27/VYKu3e5WseKC82vNaBdV9Lk5qXobeVWGFQX5cyCgW0ib7Lvt7tgSEkJc?=
 =?us-ascii?Q?1g7SS7pYNVAGeU+qhfAP0sCLpLjrdXfUWJLcEctxgLraAJKw0hCBtOG6ZBnq?=
 =?us-ascii?Q?MYYZ3GiC+QjTmL//2dgTP7Uq6xRIwbT3C9AbNsCKQXsfinyzRItM54BnE94o?=
 =?us-ascii?Q?bw5HGkuKVseXU4HaqErlGFfNMkSNWqA5j1VZf4fDTSc4qtRAjkus0HxisKrU?=
 =?us-ascii?Q?o7Xwoq3peBiZqe9/typnXAXwyk+vq1P70Ct4ZmLvlEAmIHiyOH5rKHJhjuU2?=
 =?us-ascii?Q?AE/tghqrKW8tiEJwGlAVih21RAIArLOPBHf4OBOp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30324a58-4bc0-4808-dad6-08db4df0271e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:10:05.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPY77acDLLNGXAzIRaNFN2uabhYZklfOI/J3Ltvcerb0+LTdPu+qRNE4zGbsIE+9mZuir8W1iH0yYqorWERvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0b34b57fc8bc..ac68c8a5b8ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index df09ebcc7a35..c15cb751e25e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -191,7 +191,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -338,7 +338,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&msk->pm.lock);
-	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+	if (!mptcp_pm_alloc_anno_list(msk, &local.addr)) {
 		GENL_SET_ERR_MSG(info, "cannot alloc address list");
 		err = -EINVAL;
 		goto anno_list_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bfa7d93a1c1a..c08d05f48372 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

