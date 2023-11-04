Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A8196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Seuql0BB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTZV7Z9fLDUBIjPvIVEEhrO4qnFDTmnHW9kuzLKz4j3z8ebul3jKJ5FWAGLsVcUSAwbXw2je/bc2/NbdzVDhTvhB86YmIJKijUy4Oi4OV4xC1sq1GhVGH0ucdp1TebKkLm4O2KLdipItcCMwg9IEeyu5sTp2tzD724Put4mU4S6Q/PhQLxQG78hLznu6/YxDpOEBh3Bc0jjpDbvLskQh5N1enBizk40215/n8pG5ZL6gOriaFGYiHArdC8uyYbCHfOmjh6/53LgJBGkwngxTjxJ4LVBMlMuB1N87RkY1HIdhnUGyYD7m/+7UWd4qofihO758c4vGXGZ6yaTf9qYKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sI9KZXdAWa2fbI5vHcI4Z/HLZ2N9d+c0aPDs4t4M+I=;
 b=lGJyCWebhzz/W9Zq9LpmVmVDCqcy0JfCKH5ppmEB7Azsk7CjfE3cQaP4vYPGuKzO1fODbyN+iWIC+DsuEvb+MTUr3XD0kaWyfyqY851wZrEf0TXRk2Yx8v/NF6I111+jzyc1CWaKP2jqoqVOje2FsHBbwGrBUYaKWVBrxJSuPdit6b13i27ErIfrH0pRQZ0daANKooMDM9mU/p9zyh90Z8YomEgDcOSM6UVjz5y+c1PHHfzoHX3d9qtb8uX1CACVm7fGdv7ccQWVS+Rat1fcr0HPBgexLnIxlBm5JfxCL93QRdDrcRaFvG4HeoQWB4FvrCeMkRYB1mOvDsC+A3/2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sI9KZXdAWa2fbI5vHcI4Z/HLZ2N9d+c0aPDs4t4M+I=;
 b=Seuql0BBHaAGUsFf1wCDkIhSCfgRUHIHF5qTsxQAIr933BY18EeSz6qoD4taaWIFQ7+QY49IK8+HtdpXH5l+WVCRt6AJUqIWrPMfFo5oaFafbHIiCyjAneCGitC2f18rT1Hnj9DHhiU8rGeuihpOwaK7vrgQxiByfHaB4tyMdu/EDcOUFXZWtZWa87ifnKFLCbnQkrTIRlICpXa81qkaaYGrtXlFQrnsXWNKebarSIQoOcMgyS1UJgqSBXTw6WEchp/TiUuYV4Riqdo5/YCththLKzB9d7Wlmm0wa21EoE/Dy0F5w0nVykV9SyKQIs6QmsIB5i85mDq1/15/ts6BYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 11/12] mptcp: add addresses_identically_equal helper
Date: Sat,  4 Nov 2023 08:26:22 +0800
Message-Id: <03c1e5cb879e2bc421e500d4f49988cbd0659acd.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 471d686d-2150-41e6-fc01-08dbdccce05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cf69wb8GR+NLfF5QTl9f92TptKRA74cdptfEXeAbi/wrMbn1v0Mbz0hsM6zZC4KwX4i4zakdAC5ryDYx3sBAZSS9THtEfPFQbBN/wPj6MvNtHIWnciNoyssv+QyYIQxu6bx3vL+mh22BU7AEAucqF3MgL8Ck+bB5aFUnR5Fwb4NYt1vOweyYQ1dLmW1lxheP6YsceZMwc4wN5i9AZBC7dQpfz8avGuNuZiqDZemEa94dfZbfHlp9jGjP/Za9bv8VPnZBAEi+RcGjWpzF+eBHixoniK6V7In8d6Dk/LWSvJKjYZpACBlgeiJFeT0L8Sc6mQKXy1DuhNTKhU6SGC04Mm4rBRM6gIyr78+ikia0pXp1aY48FHiT1Bin8QfCAzsux9ACvTKXnI8Ex6PSxnCEVyTRnNKmraXcKeB4Bq1CownAZ/uPrHctlYyBDrK4KgVYvMlaWP9QhCTDdvAlmzaoQnmAOp3lImVtGWe8g1BIvCgURxNTb1DH0gZ2ZA6rRXc8vpbvP+I0Y3ndAvn5nVwA+XnyUto4jUWKZqCvNueheDZZn5NPnveFeI7o0nlOjfbmvIDWYbikyF1HAZKE3LvHues78x4Pa4B+E6k/NXw82Lg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjOhjbPXzHipmIzvChz/k9S+26z549Rob8P4Aw+kcGDJEqCjUXI8PlkMQP0U?=
 =?us-ascii?Q?TH+LrjMG3SWIpKuwt2QEiuHUfUAIinAOoflGmVpxZ39kSu3KFQJup/rdcnak?=
 =?us-ascii?Q?73DfXAEYGekn9H8JzmokxPx/+Ym9llyDH6uj0iSzO0f9w8AVIhjT7snxHXPd?=
 =?us-ascii?Q?1VOzotqw4yEeY0aump+MLO5HWODyZpoQnPyBR00Mz13ibJ/0KypQxZFCoIZh?=
 =?us-ascii?Q?quEP/5IsZPJgOz3VtcX/pTWc6TBKxSzcR46ZCjSJ6sU7pbt/lod1JhjTGL2F?=
 =?us-ascii?Q?1qMlFo+B2MVFht5E/6Sk1EnWxjOOoOaS2Vb7pDGdUmAbwWM4Gj0qZ5lvCxrO?=
 =?us-ascii?Q?ox15tq9MRmiutb+N7Xbqfp9WCM1MrLflgy4gXfxlD8VItCpOh/4tsMjepMzf?=
 =?us-ascii?Q?QFfB8M6JLSW0kduxmlJwjJWmFEEljjiWGCdwgx/LDQyn3SwW4mKxVKCo2ks8?=
 =?us-ascii?Q?Pq9H8JDjh6DVkHOPQdsphPxjJiJbnjrsG5vRujQg555ejUYe4WA6p29gvhSW?=
 =?us-ascii?Q?tFFfiVsmrilmN+rpP2Upi+iH7huEVTZaBFTF17UBsA+qlQkczcRqXX5WQTVG?=
 =?us-ascii?Q?Y4lGCoroT1XmMzR5WiUDRDrlOcIBoWIpA9Z4XlQLhIak43oQvN+nmp7Ea1Rj?=
 =?us-ascii?Q?6W7+RO9nICSMCO2bXXqFbspvRNPDqSNETzsODE0ql0oOfNzXZtEqfIV02YVd?=
 =?us-ascii?Q?q2s6GvtoqZZOsXN/RLH86nvjNPr/16/JaS/GKUB7Kl8pF28abUt+HfseTn15?=
 =?us-ascii?Q?rLDqTsGNLBonzPp2eqDX1/P5Jvgxt8/hU0SSoCE+MvozKSesJYrtkRuvz4Kw?=
 =?us-ascii?Q?RzHstqFrdwleErxDFuJugupyrw+W6tTqYWLMyerAAtSNggXnFXCd70cKEuMI?=
 =?us-ascii?Q?1cyXQllWJi1cPLaCwBnluevnqraunD96sAavDW7RFC5O+g/ldLftt74KB6I3?=
 =?us-ascii?Q?oujrrmnugYyQ52i+Ok0Cpx5dnYg8vAAQKucXstqfPmg+b18LNGybtSNgf37X?=
 =?us-ascii?Q?JbBUi8Rg4zmftDKEm1mIIHX/B5wXcM1N2Ky1y64fD5LstKaPJKdegg5+Pcdj?=
 =?us-ascii?Q?HDFFzAfBrKxR3lQk+/+wqtJGCHD/g2bVTRjSLZJDhyzNpwrIIWKka14FTkpE?=
 =?us-ascii?Q?GMwp1sOi34yw8AfR2SMtbPb79V2aNRld9LZ56LZhRzMTBogUvok9MtF7GXJw?=
 =?us-ascii?Q?vt0+DlXYllA/0sPdPK/8bgBeC+pYUWIJZOeGsjFWt22ajk4wjD5Z+nz0Gn7B?=
 =?us-ascii?Q?KYhlrm/iIJBEjDAQ9apU35wgc4EG7RP//OwnPsRM0R6HzlQoOyHgj442RD18?=
 =?us-ascii?Q?1y78iNrNN597PkTWlMvN19MXnUk0LUc6bEf3a44N16cclYPBvAX9IVAQaD/X?=
 =?us-ascii?Q?YEqzm9pmPv85+48IHzrwmqxRlql5wDaOu4j/NaXR5Mq/8NUgN4pw5A9h3knw?=
 =?us-ascii?Q?KktKrY9MMAWcV1diYDPi+W5XczJS8t2DKjuYmLrnUVDH3K/Akkv6MuiJFjiB?=
 =?us-ascii?Q?wFCqIiuDp0kC/YtVx4NBADLXzPa8fmACICiF3m6giDz3vkgy+X5wjM0VkvKz?=
 =?us-ascii?Q?Y/zXdLgmnmq+EzL2pLkn2LOcViudHpIkKkP7mJtaN2qQqYlkwdL12acBSUNH?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471d686d-2150-41e6-fc01-08dbdccce05f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:50.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+CiKL7098ln8Tzvcb0LFAmaOvH3WD8cxOk8Qxj9XpDFD8Ezefvx4DGE87i5CW8aVSKeOGdsdnzimMywWo0mFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Similar to addresses_equal() helper, this patch adds a new helper
addresses_identically_equal() to test if the two given addresses
have both the same address and the same address id.

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(),
and use the newly added helper instead of mptcp_addresses_equal()
in it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 25 +++++++++++++++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..6da3dea5a9fe 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -258,7 +258,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a974e4e8ae81..3499442a9db6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -87,6 +87,18 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
+static bool addresses_identically_equal(const struct mptcp_addr_info *a,
+					const struct mptcp_addr_info *b,
+					bool use_port, bool check_id)
+{
+	if (!mptcp_addresses_equal(a, b, use_port))
+		return false;
+	if (!check_id)
+		return true;
+
+	return a->id == b->id;
+}
+
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
@@ -267,14 +279,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (addresses_identically_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -354,12 +367,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -374,7 +387,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8b4969ea43e..6e8ca3d453b3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -918,7 +918,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

