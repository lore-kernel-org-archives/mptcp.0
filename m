Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37258612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="sDS0S8q/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkzRFPCFnxy+xQT5vCXKE5isIbTEVbOqU1SNa+M1ziShn2BuN5REPALjNVreM5DzI5hg1J1FkVgtpleznntB2PSat5yIUEeu/jn2EqeyP8AGnQ/CVyC8aOBJMJ7uyTXuZ5bJAWfBa8UO5oTupfYZD4odW04iO04O1Lep/Ctm5eHtD70LMaGGjt6iGvYrKoq+Pa0WQX1AV/rPoDT7TAb01a/FMSm9XCr7aGtRBqsmBs8Lyt3fFzw1jdHzEDV1Wy73FF1eJNQAAyf189EH1VuiDynf53ZKNa+bkN9JxfjbYMIiCq6WDNVcGE+trI0y8Zj42TfEc6/rB5JFNolNyFc7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvCAMZ26ZOXMmzNNf5ow9S1lE4qLCgq2D/FrRdpHND0=;
 b=OH3kGk8bnZEDoTdPwoZ0tNm/W+SapcyvlYeNHOPZ3RiimXwkWyWSfyl9QMNaaeBAOsNdjedFSYSzru813K+WNL1ieFu84hVSCKwU1rD+EsrTjF6P+rEFv87HwNbS/iJSPqGJOsix1m2CGLYo5Fmn4ksGTQvrcUI1IpTdFYVSs/p4+GyClSCzekDArlA0AjHVANSZ97gdfKzUgB+wHKpD/kPG/lof3srxmy8lzOfKObss/VCTMB055o/GMiZZURHvbS9RZhnnkkom4ImxpWxCDUK4sFOc4gLK5ysqYtrWHhuxS1HzdcsUdOgZ2+0V3EuoVZAto/jmnA+XqGjJm4X1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvCAMZ26ZOXMmzNNf5ow9S1lE4qLCgq2D/FrRdpHND0=;
 b=sDS0S8q/7JnIq3G7ZMz3zuRHi1szkuNFVdye2ekF+PKSiuhRUOZ0Sql4M0nkf/Ite0dPlJ5t+wpuKO4mteE6Dwh9QvAo75sad43yqaZQcCUQT8VKvQZUblXBvDyUgI1UOvjn7yK0s8DmSDMxTaDd9Gr6yEo7pv31Zjs5xL7lU4eU6FeVoTh1BDJklLkJQl6tpjL3U1ikYwNMosAo6waiRgk2MdTacke8vz/rbxgcs8BIFyUe4aI/DrdInu30jerBIFpArtLgBqdBsiTTtVnL1MHOr5i+bEC1OpEQcKnZ8kEHybj5A5bIT5HGyL7DPDxHrMEEaUXMcO2wDekQGTAfvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 16/21] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Tue, 14 Nov 2023 14:35:13 +0800
Message-Id: <26304eaa912dbabf5bf0fa4519e3b9f833974030.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: f27cb361-26b4-43be-a99b-08dbe4dc27a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ErIfSaR1GoexhnTwjgckuoInszbFKD6Fi9JTy95ZT28NDgMIPJI+9NAX3oDrH2L6sVeUWUZo9LxgRRFMkwutGO/Mws55GjybSSmHfoFMcwhMzekvaYI8CYUOL7fVhmOQR+0yf/NMI1lvufnkXK0Kzq1YGOKeDNBZ77O6KHA+ZN4tu6+T/VGUQ8DCE26ELmlVitHArpOFDvtbPNKbbbInRzdKFhHoxIZ1Ipmt9ea8Mhs35u/+4eQ+vKC61Mdp13pWLzyL548b8BQegxQKrgZHb/lEuO01o8h8o1B4UoLpIbs0snsvmY0UqYQiCE6hZOMjwOAf/a+3M6Nv9bzqwT5OIU2uuF43Tsdqc1z7EB2dv3sfHLnatGC/k07bnHDXwGWT7wNVyM8LerXR+euydPivl9N54KC/hv8PGmqlB9SgEHL9I+VpKJEZ3eTYYw+ATD4pT05+TDV/3L2s9pI2lHlNOk/ekrqQ7aAt+JxrDUFhQcFIqiCpZWvdKzVBEvanKB+XeYFAxopPAAAezzXSSE9kRuCTAt+wk+ZE0Mf1jyr3HGGLuFKgttovhgQImKHffxo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAMmf5duaxxDIZi9QukQl3Zq0DTDQYmF19T5TKI5vbLymxG1sF8F5qAYWxHu?=
 =?us-ascii?Q?6PPF821961/UcANhYGD+cmxOzzXwZMNlGLBHxHEzuNyrlPLABjVWiTUDVTk3?=
 =?us-ascii?Q?doVQex8GVv+ekQ1JSfNOpgSETOVqN5gk0EDq0bXDNJMY+0IeTG0GRWfSet+8?=
 =?us-ascii?Q?pWmcvx1AIsZVRWC9tUhYyzvy+fY1TUDJcwoUZYrIi+gRGtefraHxcCk9SCgi?=
 =?us-ascii?Q?18mXTR5nwikeRte5svOa5VQJ3brAjEJPbnQqZ5xh8mmzVDK6fTNLJhPj2Tbl?=
 =?us-ascii?Q?k3gRFbw9hIsg+PciThTiqpzEENPUnH0pUrbHJfGRBShlJkIR4nK9in6NC7Js?=
 =?us-ascii?Q?SNdNoSfTcjPb/yx3nC2i3yAl8L3+xyHcKFTi/MJputXC+tzGJ0I7p8pPJwy9?=
 =?us-ascii?Q?xdeq1jJG7B5oyxCvcSO8n9twEocqjoNjWPtKOHKFXC8f+EfdhY4Nf59i6csx?=
 =?us-ascii?Q?hCkecdetahegnu1OMC8eaoxguMTTbAJDVOwIOH7BNkEkfDnASCJDTP28/1AV?=
 =?us-ascii?Q?JQAcLmVHkpdO/H+4AKdTngcw10AeI6d8ItALeHJlo9OyTZsGC0bdKF8OWvmu?=
 =?us-ascii?Q?i6y0w82XmUHMRdb+pbQ4Myp0p6EzdfdGrj4tly+piWFCprFPycSRgnAIDpS5?=
 =?us-ascii?Q?XtaTKzWkOUlKEY4CcGi6ZBIlCUNqy6xl/8zN4zydHdIKw91OT/MnPFajpN4k?=
 =?us-ascii?Q?MM0NjUnTldKL6W2tpE3fR/xY1z3RtTXyotjd/I7Xb6ARKV7sEVy1AU0J7KhL?=
 =?us-ascii?Q?qTBnIjjlTpWYnb0tbrWDDleJywsaYORR4Ax1UKfNYqZ+ZDbxtolvSM1huJQp?=
 =?us-ascii?Q?lGQd/IK5SUsnISYsNWU92GC/+/iN8DVRHebdPVGJvw3VRwTv2aO5hSsYqhNq?=
 =?us-ascii?Q?NLwndu8MoWPp9onAcNSp5m7uLjCUZ0p5vpNRSfZ4QJ5USPkvgDzz6P/Ys2QM?=
 =?us-ascii?Q?OXVPIH/qPp6yofANEK/Dd83TlwRt8cFhYN1rNgDtMMO5+14alaAPg4vp5G9s?=
 =?us-ascii?Q?+2Eu2Iwp/VIF+3bi24g+DAVHiICbDu7//3LesIMJYMnCLAAKSAdcjGX+njnU?=
 =?us-ascii?Q?arNX4HDi0ZK0cC0vyO5TD8A9nau4/8+Z9j3ZkHmgTnjVpD6KdoS5+/OomkUU?=
 =?us-ascii?Q?SXk5vVho/cOKtSQVzw0VerDKiV2lvs295Co23YgHxjU53aIaSbZWZUUuLmc+?=
 =?us-ascii?Q?byhYLejJBjcYfdhMa5/ryq10fujWiA76yBBznmWg7I+GsMyXflH+Bf1CNPip?=
 =?us-ascii?Q?1RMMnS5hTvSgzq86pVeNdYcwYUkOAYXE6UZJ0FFkeYjJXJ2OsTQkHA1geiu/?=
 =?us-ascii?Q?ytlnpU82vhze2oVrV7NVNBxybB6yPwkEbTDhuWhSvdCRkEv3thWCqiCVaQ+t?=
 =?us-ascii?Q?tUNZR8MNdN7/in7CvEbRTOZb+RYix10HkxW8j1wMh77o/OgiKZbC3OiF65JZ?=
 =?us-ascii?Q?QCS1W4OIM3c8CWU1v4rBe0cnOVkGH4Mlb+omTA3PQsYjEwyGb5S3Vi96bHWB?=
 =?us-ascii?Q?hxHlkHrcX4S5ldC3fxBqj0zjJskHbIOLGom+ancOKvWB5lBCiZZRMRGIl1l2?=
 =?us-ascii?Q?s8D4YwFQ8fgwC7JbTP7NNdcdusIDr4l1tQtmyvYrGMVEeOvfgzaksK2EvEvh?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27cb361-26b4-43be-a99b-08dbe4dc27a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:21.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5QOCkmartMcX0f0NcuYVd1FRJG0aEv4nxSWBaLIOds5OcLpSr7xhXmk6mnFvcRL3xLsw97TEPM6kzYQYoK6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

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
index 599137001148..af915ba3dff5 100644
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
index e66b1fb7b522..d0eb7b84a262 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -919,7 +919,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

