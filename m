Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327417ED
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkav1VKy2eHMh/hCq0BKjYwbQH80i+bZ+Ch8DrRbSqOAvl4KKRLZvrHOWihJCOkxrRK0l3KC9/jigpqEdfTB+IWu3zn7ZdQDAY5ZfIabcsN+13KpGrdjfGGhbLTHu9ocMOURRMPD6l6/u1FaotgsES6aUIfsH9AUTPQAh51SKzfTTu9hIw/+rGprcbLQvLHtovBzPN7k95rt7WH3OAfogWaOb6zr9Dq4nPvXUQSYgkKHJm/ZYlzKP7LFupNMhggkjDS2SAIZT15+fAjv40c0J5c5eUo/whCSgG6L9v4BYOE24wPBMxl4YxoIxYEzst4y4Chng3FI5d2g7r4vsC8RUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X08b1gUihvo7AeYfCKBoUQtDsgeERO1iK/g9SyMxhW4=;
 b=YIWoIs1Y6cnkJlIEF3aQIIdpKQUHf4f+W86t58x/9rsl+UKWyFpT2/cUWJ2/pdDS63KJwbT/D2L/Or09uLQfeYmvGwaz6lVS7lFjC+hOAoQHc1jF2mG6EOMUDcoiS7SXA8ocMiOrqtX3Fo49OlGmY0QR86ZwhkKp9S5tNJojC6dkikpKkHUKRnIKy+ZmhUdGxN2wJ6ZsHyBu65wLfobQAn9eYhSgylDuXymhBBS/8GhOsP0eIdVOvU5o54IaJz7OS68x8tg2Jl4f5KQPo+qAqAo940SuhoOYofDR18aJ38ZQMJ1tMn5eyf/yePheSEGVuRsvVXJX5DeHQs+m9b3cfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X08b1gUihvo7AeYfCKBoUQtDsgeERO1iK/g9SyMxhW4=;
 b=Scpx39m4u+pendXgVjFlXuX167nJYSICxxeWhfGNb8cCxaogUgTs4axC98zUOdxbMvl8Cct5YYCxGQMsg8klf1h7Ocp2bmhG/Kw620EuhRuwH32RpmsbhL2YELw4fsPW3zsoEWJir1XafiTDB30KYw5i0QXv0MBq1giFzZfa+1nkzi79ggF4VQy9EtMqg7c7htEAK9xvvPYF80xW0vBn2l5a8GLWwFgybPoGDavVHVIk04R9vtwywIztH+vYEhMy9/jQdR/8UEwJhhZJT8SvagOP+FyvaMFOImuxsOyYjbrZkpXnNAJCd+BUsrbQpKhFR/JXb3/vnWyiC8FE4BGOng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 03:12:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 03:12:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/5] mptcp: add addr into pm anno_list
Date: Thu, 20 Apr 2023 11:11:38 +0800
Message-Id: <15a683ff3b3bd04870b0739854ffdd8c01067a76.1681960259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681960259.git.geliang.tang@suse.com>
References: <cover.1681960259.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b2d51f-d3d2-4559-efb9-08db414d01d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JvUEjxeBKeHpHjgil/TBQ5jySr2Cl7Vcol9tbayGUE72xuC17ZbXy9yEdUZCjpjfaCxdb94XyNzGPVVSn8mqdBmzKm9z0D5Ad6sH1EJB9bjz2MQSEOm2WYCnd9L9956jFqiksTw++J/W8E+hEhSjDbseXdmbIpVq+k84kUkbqUFzCP1B+ZZSd7Y5pPL95bvPXdWu4eY3VFzxcEFiPJ0uLpWI5z68oxcB9s2oBtl4i+WXtdaDwxJpu5WvvKzPqo7SgYqUX0TbFki12i0ftXCjMX4v7IhQGJosVx5XcoB5jDaMUrGxZuuYkyr/zLC+Sxx1rsjnGyOGzhHjIKhiYVNuL50qnqYWsNmRlvWCWPPWbilUYeW58OmUhKOKx6B8CCat/vH7qcfbJPLtfXbvYRJPTY3BbxLayjYRYTi9jlWctrxP0k1jZ4nXaox+t2mMc+sa9QRSRyqf2/ReqMQkJSMFM2xdCkpllYDQLCdwvoNRFzElHQQcJTndr9xoLODc4Y6ZBU0nm4fGRoE8LjuEOl1SjXftbA2dICqcnvskP2Z7GB24QUbHLYnF50mxkVr+R7Jo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(6506007)(186003)(6512007)(107886003)(26005)(38100700002)(2616005)(83380400001)(8676002)(8936002)(5660300002)(41300700001)(478600001)(6666004)(6486002)(86362001)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XzBxPWW5FJgvOhfYBp7q48xL6piceRYlEE15VmY3WR4jvzUznVP5qx36smy+?=
 =?us-ascii?Q?SvYX622TVb6X9InnNhynVFvZxvyaW4pvtKzuZ1PP4xlx3cqXHofJKBwqvIQH?=
 =?us-ascii?Q?HWA5trBLyd64Hle/g9+ZxS8q/1BEbasuRI9dS34kWX4lTGXgGjX+Jabxfxt+?=
 =?us-ascii?Q?SX6/OZxeoMOVjIoE7rLhuLP08+bQD7iZmS/uROkju/hEHvTNz/WZfyBXb7qR?=
 =?us-ascii?Q?PPtGjwedHA0gSX2RH5KV8fOpZVQU2DWVFN9tXuKXTXcvuXyTDDwaRaH10fxT?=
 =?us-ascii?Q?Ha5B4mzMM08TGReB4SXYSX6BWnJoL77ST15kwTpUdObo5cN6hgIKhlWzbbtJ?=
 =?us-ascii?Q?xwL7brDZvCmDtAIGle9/4hwi9siv+x9jWJz08lpGTNhivN8VCzALCuC5k0A+?=
 =?us-ascii?Q?7j14MJD/GZGFz8Rf4PRLqZSg5OSBq9XBcpXHDN0gjWAH5qicQGMDf2hocE8b?=
 =?us-ascii?Q?GFRyTfaDQoWeb6w43pk2OQu+WHSi6Kz6b0Vejb7Uca0hs/Grh9w7OpcRnntl?=
 =?us-ascii?Q?9BbNMEc25u8o/d2TMfA848FDk16TnPyxgIWsc4maS/rIAmSu0s36X2+W75lv?=
 =?us-ascii?Q?WudA4yd42mf5wD7idTbppL9YpX0lPvMvKHf/q937D5Euk/Vmu4BJOAtP5jry?=
 =?us-ascii?Q?OMyBLllqNiRbwF1hVFwOdgicaOmB98lojNqjnW7cggX1HGHr2U+nPfLxMyzz?=
 =?us-ascii?Q?Jzpq1IohOPq3Kic/sL+bPF8PaoBHV3b14qab5t70vO77hzqSq8JMutKyLLDl?=
 =?us-ascii?Q?90SHC6K/PEN661NKKq0Sv5ztQkyFMx06dmrrrH1bAG6sMLwTc7Hs9fI5GjpP?=
 =?us-ascii?Q?a8bKWoGRO1zaV5FgodIosKCSHjfUQyiA4am3SUcveItGNwcD4/MkzTUvKQFB?=
 =?us-ascii?Q?XJAOlUL0xgO6fXWPdZ5dvavq8mEb2Wbf5cVFW72LGB8Ytf9uSJTyt1OxJ7iV?=
 =?us-ascii?Q?ErjDQa584roC1gyYoOhYihWfjfgvPMzsngRfTux11ItKfv9P7MZX52MW+TDz?=
 =?us-ascii?Q?Rl51V6EAbPUQZvSa6cbgw/kDLOf9rAarfcI0TKyAoL/08SOAcA7ZoTOv5E7T?=
 =?us-ascii?Q?ASodP2Kxcv6KIXwa1FPcVBjeeP3PTWUv+5q/ybAVBu3aOVyLlODL5quXT7++?=
 =?us-ascii?Q?R+DOtUE+D/94S8Z7lcsynwSkmsplX633f8L3cxGjYUoB9lj1TRr+slEpOgsX?=
 =?us-ascii?Q?w0EVHfwG1/FqhP0+z02RdV+mCsF2PEkxxqJiGk96xNwGQAKhXvhPkqtdqzcU?=
 =?us-ascii?Q?NsY+cWk/lZtkbGObLkDf/4x/dU4iYxp/N1LgoqZVeWWfylHL7rjy98FB3hXH?=
 =?us-ascii?Q?aFCafhoKB0IvZ+xStSZYpRYt5n2hTOkQN0srQmU+3CqVUflrJ4Qy2AVQ3T1T?=
 =?us-ascii?Q?CWnf5j8JysRNBLT6L4E92Y3OYLoSWIjjRXNBp9D+Nu+z++UUYkBKwOIwOKO4?=
 =?us-ascii?Q?cBWJmv5XKtvTC+NTyRgsjnk47SY+KvcPyaw2QLvLPjBw0SUlJuwPNnkGBU5K?=
 =?us-ascii?Q?RguWXsQwtI9Yz8NNAJUQWw/GqXGr0D1YxSXPgMv+5cCbBJZ6YtAi3Je4eBZj?=
 =?us-ascii?Q?huWv9TxUrVxH2RqD3s+5TI+ruMPFYsZreYNB/vXS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b2d51f-d3d2-4559-efb9-08db414d01d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 03:12:00.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9trM58A+0zSW6B6a7WMxvs25sghfKhbP8oPCfgaUr6a49bsX7lVh/LNSMr2zwX4wRZVKWzwD80fOODOifc4C4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry.

Export remove_anno_list_by_saddr().

Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
it when connecting fails.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 12 ++++++------
 net/mptcp/pm_userspace.c | 15 ++++++++++++++-
 net/mptcp/protocol.h     |  4 +++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bb237abb99bb..d03c60f54085 100644
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
@@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return 0;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a1f8d2fab08d..8c050c118ba9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -169,7 +169,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
@@ -307,12 +307,25 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
+	if (!mptcp_pm_alloc_anno_list(msk, &addr_l)) {
+		spin_unlock_bh(&msk->pm.lock);
+		goto create_err;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
+		remove_anno_list_by_saddr(msk, &addr_l);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1a2772902e9d..b3942d15ade7 100644
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
@@ -837,6 +837,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
+bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr);
 int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 				 struct mptcp_pm_addr_entry *loc,
 				 struct mptcp_pm_addr_entry *rem, u8 bkup);
-- 
2.35.3

