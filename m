Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83346B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NkeBtF9H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h537fZKDzWLH1pp1AmHz8Nk7tyqAyg/RfGEvxtxDot9N796MAeYqtLekIKxfkgweWWYNX6kfSbOArSIs9e0uOxP7m1JEhPpJm93EpViLXJ9KbCjVVT4Wpv0dxN5DUvLXmRt/ckHEPzv45659ixq2TM/GKtYPblqF8xZIjVo75UTk7+n2/jx8nF8b+DPcf73Em1L4NOWn3KtJA3HQRiLIRSK7IpPL62xeB4G/Pnbgyk4MIL5AnAymXbWigFEn2wVY25PimfPlUDrJPf9VgJJlDjyg8KXTZye0LZDc48v28mveERHnrvlPeXg1cAgFTQgBNZ8bWSBypmO3z0TS8VpAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=n92tdKhwC5lPmhWLtB0GasnJuf6GR/9K7tNIpkxFCN8kr5uWsSgyA8kFVtnOUO4mCONsE5JI/0PKH1WXiYU/NH7Ld5/uHJ9NK7F37J1Roww9u6x1SOOR8ZwjCSsdrn2hOtPTiP8SPSe02PI3r9ZMIwlrZz7QZAZVzxDdoY5M088kn0NPtyI7gVrCtcab49H3pdsyrWI2Araxfaf0ICQdF+yako7Nx2ZRXS6zmLesOrejstPjdERa6QrJYknuAW6hEkrceQu65M17qWXMr9Yrx6PqaTbAw9CzK0bL59zAwqrptJnG9cvWvdTccyJUQjaaGE4OLEm8IZ13kRA8D/uAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=NkeBtF9HZl2oABJU7e/cSkqOpRMwcVtNre6CvJdCC9JblXThhqXmpa6Y4AKbDwNkaYtE8tMt3R8gk8DNM5bBSn0Z7RgEky/nBtpV8PIbk1F2XrTz+VJePZj09nGCBvZy6XPmCHR8BM4PUkGZijwbJkm6Frx+B3FamkKD+qacAL1okq39YMCtoZKVvELFY3V26Wx0guBqq2Bdg+T2OFQfeO/z4/F3iNaNS/cjBSf9Ovf2BxXMw99tcITAy8i5aVahXwjvkgUg8Qhq+z2r3lN2RVzY7BUH4LQz0DQvKnXTgSTNvsEUe1+eY4X3WDlCKT1BLnZ5OPGNQuJzaEY5Gf3F5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v10 13/26] mptcp: use set_id flag when appending addr
Date: Fri, 17 Nov 2023 16:56:06 +0800
Message-Id: <aac4b1d862678f863ca8a6643f8fbf97d01ee5a1.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: 2237856f-e36d-4955-6150-08dbe74b41b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ifk6Hg+II4X8r8sx6/X5JR0rRpr0TtTy/7Ikoi0egyHw/DIpkippSO2S331ivWtm3AkGM45J8MToz/5yHCfhH1QRIeBV7BMSwh686CNCXflfsCLlFusBF12o/4TXM+3B4Z6coG+MWNWeepmV/9JcER6mNfzmlI2IWsjTE+tdm/hOuQfiygYvbe50O6a8QdyoaWnu52iV2JpR27EGemsxsOLRWOjfT5ZlrQ3ZxJYBTdFQAEvHb7VO2k4WWlLjS6B/1gGTMH2s5+KgoTMCJggeMZkCmaGL14X9DLibfCnWHJSp+Wv9RQWNzYM14HIkMBri3UPVcAjTgl6HNcRRFKDh2Vam0v7kt7mVuU5qpFebIKJK/plpP8QsojKT6VGKo5aIrr6XnuY0c0ZJmlm4oJ7coPcNZlcXnzqtUKj7b8vK6J0vngoKc+1GMnDvlbeMLx6pqQ2MQfqhFdzDKBxRpw5PrZtgr1XPJYq/ZskjScrGQhkdWW3ENbsVNq7BQDQQPLaYdur0AmTiY3RMzSIMItAU0rz0voPGd3gyGb2EfsgRH7+05RRil/GpscD6TJ0nZD0v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wSOT7Mu/ppN+8YyjdAWYgSX/WdCsY54/J9QVTvID4XrtfDQsduUjbf+KxlOs?=
 =?us-ascii?Q?0UaIIVapnVjjW7v+vhvIkcGn5rbvwNfVuoL6QrnmbrmPWbjcLKPkbXoqiCF6?=
 =?us-ascii?Q?VTJ3aZEfr1FhIVN8qCzXlzmywIFWinvs75xBxJirY2MQ/es42x2JzNrCwHpR?=
 =?us-ascii?Q?m31pTPMrJwI9IpVeU5VJNTvMrqSK2Q6V6g3Jr5lRiNY4AsqLmPpozAjamtEO?=
 =?us-ascii?Q?/lu8MahAi5WqHLEm24hCPsDXpg3XUY5BCP2I/tHY/JuOV41fR9D2oHgZhaoy?=
 =?us-ascii?Q?8nOLaUMFtJREG8uiYnS0PSNgLMzNKr8Qd++cHXJCJ0RiL9igTCQ3+CPGIB88?=
 =?us-ascii?Q?R0o+VeSNuFLWHkyYVPdALoN0NDiFQ0cCdeGRwnZ3SDtvpHB965AAqVX8e50J?=
 =?us-ascii?Q?K5OdhsNolAao3sgfBnhRrlitmQ6tOVe2GpzqeBasHLRHhkKJt9p1S+eRB68B?=
 =?us-ascii?Q?bFGn+O6a6aI6XxgvbI08aFlqypdxfxAeIsNm6SF6sCPLuZtCNMboZnBG6yfo?=
 =?us-ascii?Q?6VVdS1OJzg/H3MinKjjhhg9fJIrCPtBLH+eRZUQJhT93tyAezoHPElFqyBrV?=
 =?us-ascii?Q?/ydYeeYAlZt9RQtY/9TE+rjuSeEQ1zn04vsusRM3jI4JrK3LeEgFtnMR+iwU?=
 =?us-ascii?Q?z2D6WXXlAIxwB3Ut5LDZYtSKWwzlw/lxTrA5hKUkmPr89Y5/QRAVxzro7T3I?=
 =?us-ascii?Q?TIujjl0fbrlDAh0+EXC7ZiwRjt1LcsQiVGt5vOp7OeZHDBArvOrQ9x0EZSal?=
 =?us-ascii?Q?j2cYjMN7LCeGPPBqlIoo47wo2u/oJtb44a4YNT3rfo7Vv373rAL+qdqp9KJs?=
 =?us-ascii?Q?Wm8RGNJVc9O+uM428vKrXEEcFDAI6o9n1OgytoH5EgJULKEjKHKY1EezKvYQ?=
 =?us-ascii?Q?xQl5ZnH00ZxnUtAQi16D1KRFZJnUYiL1HnioV5hFOe1+9fJIHrp4rM483f3K?=
 =?us-ascii?Q?vYERVZFGquOKVpBaKDEUFq/Q1TKubkRTLXIc5zvU9+xbbwkZXE+dPjAPadbY?=
 =?us-ascii?Q?L19NvNFB5z7h/HDjeKsu+8noxfowfw5VpspIe2clUMesXezqJkNUQlK1kieZ?=
 =?us-ascii?Q?BPSTfa3l9aUrIGdP+Uo0bQD7mDkjPKDo2/w5ohouBVaJKrDD12vl0JrRsjHQ?=
 =?us-ascii?Q?YwHdgNKn0rfZSc/965FR8MxrCQWfTCYxwaAVuWExinx7S69cEAr+4dj9wPPW?=
 =?us-ascii?Q?GdDiafDSqEqSA2BkidUreSjJflQP4yBtnkvbDPT6OHJc4Z9KiLreUYZxKcXa?=
 =?us-ascii?Q?36F7cQ7/OJ3gHMVev0ARcGC2AI3VOVwC+0sCJQIBrzeQ9HgnUbD6r4Oj6Jnd?=
 =?us-ascii?Q?Dfq2JlliVxbSEUClfn9suJb+WnaiZgv8qmOFFOV1OVE4+HeQNLyvImMVJnN5?=
 =?us-ascii?Q?XSLZFKPqIvT67dHEGZXw392nNI8xCIexC+fGbZayIcESSqjNbtDIZ0ODJkJl?=
 =?us-ascii?Q?Vm6VyoMpZk864x9YhDpZA4bZIYiOsgV6iBWantjn0IO5gmocF6eeEUJ13Vjv?=
 =?us-ascii?Q?IGJq0YRa+UN3OyNtK36VXDLQHDRwrENYu5Pn7MtFnBb+tRNvZF5lubZxjt7V?=
 =?us-ascii?Q?BrJyRcLtefXj6Q8+eFnTwcl3XtkwW/phfinx7UprDZ4eZg7rc340uPQdZVWz?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2237856f-e36d-4955-6150-08dbe74b41b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:41.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcdV4Z2h6Lgcv5YLxOfSa1WgGJA/sNNPQn7FDfttBi4bZUI2SFUZDFWiTXkfiqQ1T9UmqfU30Ake0I3kk67lcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

This patch uses 'set_id' flag when appending new addr, adds a new parameter
'set_id' for mptcp_pm_nl_append_new_local_addr() in pm_netlink and
mptcp_userspace_pm_append_new_local_addr() in pm_userspace. Pass the flag
'set_id', which was set when parsing the address, into these append new
local address functions. If this flag is set, do not alloc new address ID
from id_bitmap, just keep the userspace set address ID.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 11 ++++++-----
 net/mptcp/pm_userspace.c | 13 +++++++------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4db37baf74ed..cc4ac206f848 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -855,7 +855,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool set_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -903,7 +904,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && !set_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -914,7 +915,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && !set_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1041,7 +1042,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1281,7 +1282,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, set_id);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d4258d2e269..c9dc25fa8540 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -38,7 +38,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool set_id)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -51,7 +52,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -73,7 +74,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && !set_id)
 			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -147,7 +148,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, false);
 }
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
@@ -193,7 +194,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -374,7 +375,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
-- 
2.35.3

