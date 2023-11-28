Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAB584FB
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kp2XscB0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kES8psbT3OLy6N/4wIka5jDRf0MNFuX22E7y5slKEUZw+vYSmgfT/2Ympw1htD3WhTpJsgX4IThsmX3UFS07fZayguHB+yu//GZhMV15mJm3izhYtRboDlGsGF5wZHZBPVmlTXhGX/fSumkqAmTK3Eq8OJiBJTIYoJQHYqqHEO/hLbxn0VlLMwvZnANHJwcP8tiO9EIyHhXj611aVcgHxQeXheORXnnpEjAZzdxbbgSzN0b1qYE9MKeKIfU66ua32hht1CY9qOfaPPMxAgAoSItj5je4QiPQMlxUfaOQOjDx5a1YXCX3Nk5XblneXcAfXctWS6/xgNPBKpQGDxLuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C+mGleUJvXIa3Wci6uvGa1nefJUd2Vo8WcldczX+lA=;
 b=MyteF5K9V6doOCH/VpknSY2fnSXwd+p1qCrZi9Kq83Xu0N/k2KiLes8TF3dINN/QvKpVrRAvpaz9YopHeycA0+VTzeozCUzMvJPKQb/AABFkgsNTsef+puZ2Xi2xoFe450flZO+FVwKouhM4e/zkPXFB2PY7lue65rDZNuHjdY1ww1K1q0lvhehuhydXP1Dc9k+r9M5ulWWIUOstPSCl49jaPPXcsmivqIT3atXhWWsoIw1JeDvDyigfrPUV6MkXHDurwRMxNl6XR6G1POuaItOtKdbQRMh+KBuIcoapuMM5UCG4ezJDRicGCQv2xmTwN44Th6+Ye+pFcDHuKob/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C+mGleUJvXIa3Wci6uvGa1nefJUd2Vo8WcldczX+lA=;
 b=kp2XscB0zTCQkJQJuGuB2yy845WtpcGzagGMAsIgx1K1mgB+my7jmSBzdU7pnFoUZKW2VlOlwy1GKt4ECuGwC+rUtXG7WDfypCTZygUwnp2I8f8HZutAVN2JIEK7LIn1qHesRFCqzPZ6IRjnx+rOEubv7glCSqqEQwTFAYgAzwQbMskJeoR7Qm1I/nJVs1hDy7weUu//6hJuD/D7wqPuFrDeVCWExbcr+AaN/fx8UpFoSzRmV+EUaLOvt4Ihhpj+zBgD7TZOHNq8dA/7NsZ8X0OkDyIdyb5LidaPvvIjWAzDHeYOf1wpHwjztcP8SH9ZwpY6y73Cx777ZBhOONaqLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 25/32] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Tue, 28 Nov 2023 22:22:18 +0800
Message-Id: <24d967e1dadcea8c2a51e4a19f9344a3c7a1ca37.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e069e6-39f7-4e83-0647-08dbf01dc95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Lx/1JPpBmHa4pAyPtduCiQ+Lt674zZ0amlVnQ7cphXo6yqWtutzQ3X+yA1e4E5jwJCVhsl1rxqpwt0iZZV0UlKNpZtJCVAu50Q3p2x9B/6lojOQPKXyydh0fynrqPYmA2p93sdLqzX1AHru9ZfKnjPTPHkkdrqJ2xZ6xEJuFQpUU9TmCRy2LLP0kWt1glpA1fgY0FydZXftEWbeIiUAXXnx73qUcSQnHUdOj1sv1GL2aCnM/9VggvKJ3pX/x1lbZ0EKEarOZg7qfPA8FRwo8oBLvrOjl2ij5xL4ojx4bGHd1IEWQtUSy493z9WByk4SpxsF6fZ+e4qHvTWSGbjUzUTHr9L0xYCfaMEGbDsT+R6FBU7zpDvIhtFZ0wIYjVKKiNOrL1P2yrI2w7On0UhohsIaZO/WU8tPcRoAYVVOulWcZSPNnJ9JAJNDzRGKSytGoJJENLsxNkE1wGv370hTiqREuHZRwd6dHtg1rPqJXRsiUM0HF6TzknXcU+Svv3bNP2BxRn9N3gQOFK+tX2Z+L7x5HW7WiwKGX+t+uGV3yNNdcSiE9VuvcagepGOrFWkc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m5B68DngTr8H/SSaF4cKM/fsY5qbfbLbqfcw6neA0pKavV6LrmVwSNEjplAO?=
 =?us-ascii?Q?h+SF0Hb/jjgBYahGQ58V3BfMySNZGj3bpM/CXloCsnSZAQ7G6gvJTHbY5don?=
 =?us-ascii?Q?vyyERu+rpflt3s/mwc2NxP3zv7kTF4OrvtBZGhh900RjqwZH8dJJDWlqI8ru?=
 =?us-ascii?Q?EIndThXpk6kQkEWqc2oT53JsXN9dzzBUNgF6MSFscbrYS+UzeDCPAyEWnXvc?=
 =?us-ascii?Q?hHBRmF7SKTCo4QptwELShqaxA+2RiXcOhVlbZfkhkFHikhwmd5iJHU4/josn?=
 =?us-ascii?Q?X0OM1pg0/Lf1kD5ydUOFU27tqNUhgdB1xeVwMVE8AVn9Y3oZEEB3QpfXytL+?=
 =?us-ascii?Q?yYDeKbCVNaUnirmJCnGZR/5qInSLd2l2q8YVdKkP+8FqEr3av4qUu3ojKbMf?=
 =?us-ascii?Q?NwkbG5I/p6/FtyQqRk0N10Rox50I6c1sj5r6h55khl7q537ZCFO3uQo04MwU?=
 =?us-ascii?Q?LwFaw1I7PmDjO1JKccqpkR6KpvYSR109vkOlIixLMstotv6wTb/+2yXAwYsi?=
 =?us-ascii?Q?CjsBMBhDx2PiHLwKd7/jnaF74dNdFlcGTIYp0l2HUJTyyAORG+gf6bK/WMjq?=
 =?us-ascii?Q?xfU7zCmlXeACFSRqfWHa3zAMhkbEkB8VJtZSo4L2SS6ZT/TV+z/fkcE3Hn5j?=
 =?us-ascii?Q?81cVqeVzEbN1En2lYkLfgvIjFtO1DGUgnb4fbeX+OQeden0GZ/wcYlx92yte?=
 =?us-ascii?Q?8I1d4dlNWSxqsQmN8oknGTHiUBnX8wU0vS76rSbVW1uucnFqpAIWnOji5Kzv?=
 =?us-ascii?Q?AJ6r5ul3dT3adFleo1Slrpnq+tIIBxdkQ/1t3ZigR6eg0KAiSt9IPkakvP7z?=
 =?us-ascii?Q?4GjC7QJg4uhYMZFHRAd18gkf3VbPc3AVQEGYUIaOgJPv7lV36AuI8Vbg9RTk?=
 =?us-ascii?Q?p5BwjrgUbOkP3ioYqfjyzlvQRZdVuOmAmKdxPdaHiIASrTVfA5l5A/0Fgfr6?=
 =?us-ascii?Q?fhAKDVQrcdA0JPRRE29wMO5ypq3joroSKE8EyzWxbuI/Wem3uytf50OFiZ5M?=
 =?us-ascii?Q?7G1MBi8qJOYUSpbWMAWBpMbsw/DT8YWyugLBJcQOPRzb1G0EZsmeB83vvW/L?=
 =?us-ascii?Q?+Hxnw/VcAEMMx21q99O3hY5C/XrZHCl8cshc3+ulvJaqKgCpusBE3gQnv1AQ?=
 =?us-ascii?Q?TJORosQeME1uko5sITbqiLZW0mzgdVEmW2N1GDrfxtLZUJwMCC7C6QxCTzNi?=
 =?us-ascii?Q?RlYlaFB//nF0Eh0MBrZW0ZTW2DjXx8BUADinGihKkV4isGX5tJlo9zxXhg2z?=
 =?us-ascii?Q?gaPoX3H1tI0vMWC3Y3Gl9b1o2zGRAX8MdeSPIeAlrN3jZJh63TfmmsDN3kXI?=
 =?us-ascii?Q?2M/1327lELmVwXVS0V2bua+vnikI8kMvXWw3hlBCt7eE8aTfD9Zc3x8JkOCb?=
 =?us-ascii?Q?ulgIlSdqWMuvu8tgCRZCccPe5QW7Nt8Dx5ol23zYePh8mcyz3SJ+90hFMsrV?=
 =?us-ascii?Q?1WAJwAevgj1bWPFD9BxT8SrJWiZEqSrScMVdpV6ohHxksybEWnwk+4UKPJy8?=
 =?us-ascii?Q?lN5TtMlUY1w9dmrDe/NWEOBx/bqF36RjcG9EZVOtnD9soJnCj9om1Lf++k+W?=
 =?us-ascii?Q?dQ5KfJygHWebKan6BqDlPbe01NGskosukUx0xPxK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e069e6-39f7-4e83-0647-08dbf01dc95a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:53.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQcZO8Wihw3gp3YdcPZLdxl0CnRxXDQlD9OX9bzQaCTziMTz2uWcPva/2seeNQpjIiX0wbdNJVtyVuUkeKI2Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 77a0e859076c..d5ae2e775059 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ad8bb2f32e9..c141ac8ba1ef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,14 +203,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -290,12 +291,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
@@ -310,7 +311,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d132a8d91d10..d40e29419c04 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -920,7 +920,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

