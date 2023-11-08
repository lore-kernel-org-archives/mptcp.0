Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966831FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="23zjQUpG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMNJrm/Y4hN5MJb65v8pwsCg+hdzxopzJtHUh9w33dMO5i7dIs3+ZkcLZzkBj3ZE0pZ6IjR8Rf+W9q/gzDr7e6qV4uC9hdsvs5A2dTjbB1KDioJmNWBDyeVMPqbc512ik2Wq8MfEmnEzQ0FFthT05BMR8MHeYDk4zwPF9fqQtcmiuV08UmdgpoHE88wtG72ziCjR1Rk9wXtk1ODnhfS5fAtCHEJHtPUwbuN8K8zFQOVuvQitwg2tJ3Bc8OCjrkLVmDj4rSs5RjsEDWID1f7QzqpQEgJIaavXyX3hMNi+iYtgKuU9OdtWnB/ZQWm/CVPji4PU2xV/GWKlkMGHvplwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8rB1qKVlNHnu1KwIAr47vv45kew+zLW66aYqLNMAjc=;
 b=KYr6hIm9A5FUkyol9PJvS00sqyEUhUY3nph0tWurGLe1Lz/ojjtfaOgKqINBUQnH2h2ESUdQuYymEY2y8aZJNThacWyC77JwZXFt2YSCoB8FX2ySHR2SHl3N2iYeyiT7xVhurHnmx8xjxY1eFgsJLY/iKiimDhPPp/PNQS24TXBhgHg0fbwOiN2QZcYW93Fh56J2BYMDez7bPYJPP5UIcq11ZP2v5QvySB6p3ZsJl5NPzt80V3u2aysekAAJ4SJRI7/o8VUw+EO5YC8MbVc6rHwnZRJBZijU2AZa97mSEbpJVbw+kEHX+QiXhMNG+rxT67Tvqf2sMLWdx1YRAeGQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8rB1qKVlNHnu1KwIAr47vv45kew+zLW66aYqLNMAjc=;
 b=23zjQUpG6396qEhIfxVMLklarw5uk0+k3IKfn4mTXcnUIaTPMUwAwxqPD6BzGsUw/SNulMa4IzcKV1muOxd1o6A4mTLVoWgFJXNsePEJEMqwvk7FTBMcumfeCH50I9zVS6oWVU7g8Klo1SpShKXTvwdlUrvuR6DM6rjUpF37+E+0qsj3emGO7nA2Hfotfnk80Kyxsfu0W7yLWfHDawi306zDCZoGYWF5WqbBZj21sjDBq3yZbvN2XFukZVHr48GPf+OG8g7R6EtBYUqn1DipAZ0J3CR8qpa7A8evDxdi+D1+JldVBUqqaChJYz5tbrvhjg3wKOiIpwEFfN/GuQxdkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 15/22] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Wed,  8 Nov 2023 14:49:45 +0800
Message-Id: <6a0f323d8676fd0728a62bc92f78934f0550c942.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a06b17-ec24-4ec3-d59a-08dbe0271f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MpgC3VxHGRSCoY8KmCPTgbyPGhrgZ8VNK20bEyVUHbk4+MfcKyQuEQNR/hkX42lwfq/R1tzHJHNi/rPRailbfsbdwUH0GVHPAekq1SAoPuG2qzJ/ceJb3RQW7d7NPlQo/UUveU1Wp5E8fEqL0CQejMq78WVaAyUFrYIk5iDrAQsYkvMdrHUsT/D+OJECvSqBA7qOyYXTadOttrPaOZ41daWVEdv9IOC2yKlXVR4dCoSZcp95/9sEWjIyVjo4e60EI5mIuwNufa3nqNS+LWxOShvQhoaWv9ti1bpsadn9vYnwwuJRY5R10Xzv+Ofio839OtI/MkSiW8D+f3vry+cwOEP5GBPfqjrqXG9R/Bs5uLnXtClfZQsuS2ItpzIt1L4ToBDM0kxTOyxQDM12VKkKJbUHsAwGgS4d3YzxkEA6QSPqtxqVDYne5ZH224kyNcG7484AV25kG8gDTxTme/WdbZG+Kodh4Mv4Mu8Iv5pL9UG1Riy1Msx8Q/uYPSgOCA5e4cajfLFhuNcvTVgwO9utVj4Ei/uS873Lo+T1VKW7cwGDPdkIWd91f+8jjJx0Wuv0stipwVXmv3/sjz8JE2ftm0apq8CVxOh6SzraGqMqVts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6666004)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHV5b2QyxRV6papyQ0xd7aPqYF0b6kuZTuWfjOwJNZvm1CaXuk58Dgt7nCwU?=
 =?us-ascii?Q?yM4k5yjh7V7kfAwIc5rUzFMUM6hJAIvA/toEG3DGJJyPVqUSZfeVhsO1diUA?=
 =?us-ascii?Q?B300WzLOjHowJuCiF3dgU13GNcRbyHjp5TGvSIR6jfIiMym7UQcwarynCmVy?=
 =?us-ascii?Q?maoUXMxmqDX4T7ACIEK99BHBUsGEQFa/DdZTrzT75b6ehivrFvQ+JoatH7Ft?=
 =?us-ascii?Q?O3G90tLqUZXO3q+EOA3pc8DRpiBeusKXBcLAtc/HHtzwixgPI9S9/WAxEq/6?=
 =?us-ascii?Q?fFQX8YYvaa11NzhI7VvT7Nqo9yN965srSnu2TKTSffJxvA41+55hYW6pXzPQ?=
 =?us-ascii?Q?onhf9BqN+jYay1w8fyMVnTZqjfbQFrSEeHWdyvcvBDjGdX8d44IiO0QpZ6gP?=
 =?us-ascii?Q?AdjA4dB07qmx1TuE9LE+rvJARJ6UoocMYns6cOYJwuVQwbwyYwjeLQeekIzf?=
 =?us-ascii?Q?DpZN6Fh7wNwVVMsO2qF02fvgXFA2/twDRhsnzP6Cl3Vs0q7DvNdJ+a/G4Fn5?=
 =?us-ascii?Q?i5AbKZe+chyDuf5qN1ROhabelPjWSBJfrcj9clPOBU+6w5FZf9U6T9fJ5urI?=
 =?us-ascii?Q?KFgUWJnO0C2G2ut4MwCH7BAQdylk9d0x5idWbQQ7Yr7KtweoRF8d+Mya1JGe?=
 =?us-ascii?Q?FWTnoYxVdlash7IRfAb/7BfAQGdg5hC7bz8M8nhuAhczQmcp+/Dff7wRNmB0?=
 =?us-ascii?Q?yk+H0YzOB4oEIBEBTfiJQg0jBTz7hvD6Tha5R9Bn6SoyEL5SKK9BSjkcAQkN?=
 =?us-ascii?Q?T7wwEvd/PD9bHNDPT4sh0o/713nl6NdxBQ66nRA6Vsvd1ZY9evE6pJpt96EB?=
 =?us-ascii?Q?rcu9o/3v89gs9PSUGpMHOxH8R+u5q9OQ53N3075DHuHcq4c0jCGOFh1/ittA?=
 =?us-ascii?Q?hPiPhOSQWXZ0pcHgDoesYHzxsY2V/sm8NMAqPpHb/N8YnrO+GIRrfw7yNwWG?=
 =?us-ascii?Q?eBTXRQODncsJvCc0vpFHlRDu6U7pA66H0cRO5uBgZ6YFOSEA1lF5t2hR4voW?=
 =?us-ascii?Q?tv2T8Geypqcuu4NxnVLB+jTR5LL+8oQafT94365yrN3m/0h1NMa+odrzwQ2J?=
 =?us-ascii?Q?WniM1Buf4o6Y1ZPx78DYds43rI9jUABUI8UmmOG3X5l5HCsm8QI5v/S/YTRF?=
 =?us-ascii?Q?fPNyvsX+U1/65U9vuQwabt7y8/SKh+QcrQw6tGLKXF7nCuvQiLDsrfHLmBjU?=
 =?us-ascii?Q?D9SB7ozY84IumwZ851PY3vs7UoKEbhu2YIEKKQe6n27i+0qJGS1ZRWaJuteA?=
 =?us-ascii?Q?sroPx0F2NQIaSz5VQGqlbQapapMkfl2/JH/VfKKqAztKBU9mxFyvmnjj0Ah9?=
 =?us-ascii?Q?tAsxMFact0Vn2xncYJmkDhClurMVpCazOTsknJcqHB4zWlommP3gaKr3qSjI?=
 =?us-ascii?Q?MuZS0J7HTJsD8qvrUBHT7EbTKDwpYNPjT3Dy0V7qYoswpuCm5+X4kpgawObo?=
 =?us-ascii?Q?HdWB0L7NZuN6qiqw11AOPhF5v+mDBYeIr2P1ipgIYccI7VPa1y+UlGccUpF2?=
 =?us-ascii?Q?f7YBJvJvf842LtoCCXCeFs3ZO+TxpLVwnqmU/DtjASNxb3SB2XHYxim7yU74?=
 =?us-ascii?Q?LuY+XzeD1PXuG5bq35WkFOzFA4AhLAr6KnNXl5NwXXIAmYJzHFxGqHsYp7b3?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a06b17-ec24-4ec3-d59a-08dbe0271f7d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:24.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4qWqQDEtxRMgY3LvLDYG/HRWl2Z9gI54AewZB7nUT3aYYXp32hi0fL4jqzsyunWgldwQOVFo164Ckzfh5wCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
use the newly added helper mptcp_addresses_identically_equal() instead
of mptcp_addresses_equal() in it.

In mptcp_pm_del_add_timer(), check_id can be passed as the new parameter
into mptcp_lookup_anno_list_by_saddr().

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

