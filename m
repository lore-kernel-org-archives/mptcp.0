Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F71FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kblmRzJ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxsVXp+wcn4vs8Jyo1iZUk6lpNEPjuSDL70/OX8BCKfi+6xmdBTKRSlqDHlw0NlpRuu6M9V7I7cuGrKj/sjh3MCI0QwzeJhisTady+R/2jIZlK6XHpwZEQDevSIAjNQIdxIapCO+nKS8P0KzvFqBCOTz+2CHTCIX/hn1ebNBmekHwitTGufkxS8C1A8AV0/MXmVhDGvU/blw1pzH2CLbiKbZ8PeINTAiONXR6V995v3DkQhTPCWFDC3zPhfm4KoUtnjhzOS5i7AmzQ/0/HQ+FeVvMnKf2jRExSQ4n/XD80f84RdDEmHgCpPjDIVQF6Wxu+fdoBRMUBAsc8Yr+88buQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=498iDJROq6xiw1hcV4dV0i/TuAPng2bf0YJz9XaBf5Q=;
 b=eVrBhRIoMUUVlxbV8BT4qYnmc0zHvLxhwBLVogbaAhtU2+mMY60r64sZCrPVdIYNDQzoHR1yJ0KNQxt8rEihXiGW8R+h+fdY+HSyvq6oGUV3bXPfwzGAKrtmjioOvrnwLEfo1FZeu0ctKTtuwyhdd/AAw9fXNnSu+OS4BbP6yiBtIZN4BrIAaSLZ5woK4ocYfob5Hz5yP4fshUrEzF+oY8JhCU2UZmghO0p2NJjrF439oBzDIYj73X2uo/xm6/35jTiqEalhVQGy7M2Nr0EHmcaSA3tw4kJt5lMHSJf2oiLwtRKaK9T2zoFRJ8g1ACE7nfZx9bRY9OsFffrxoMnPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=498iDJROq6xiw1hcV4dV0i/TuAPng2bf0YJz9XaBf5Q=;
 b=kblmRzJ+ZMJPbh6Q4r6LDcfxVGPzqd1Dzk4VJuY7pxc656G0lb0P5ae2oUVd2sLjGQVuMBKNVWhUg7RGoDzQvGuEQOVzP7pJtXq+UJiXOAQYaSohw7XhzgDvyLs30RVjH4mmyG3zIESZpwyMBYwpuG0WcWSu7Hsxh03pVoiQk09z/qFMGZzT6VpViNutg/TuHghb/KTO5dDhFDWyFestDqDwtLbt6CUcP258Q1DRd76PNoYNINuP3mD48u3VkecJCIyHsH6IcM6McPxXE4pvNMTMi8iHFWXjTTJzDL0iyFX8iP6HAsGZYp7btVhJRDGd/tup8GCOavao/EsEJogPqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:03:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 14/21] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Tue,  7 Nov 2023 14:01:58 +0800
Message-Id: <8cc9072595c165e55e3d3314c14c3f020f97b7a1.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7156602d-2130-4f90-d987-08dbdf57478c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N6EqNYfE8mAP8e3ARrgrJ47phzPKVjB6NL2Fuftfz3/u/GaYOJb3sK54IdifGJwLZF4x80ArAjjsYK6pzoWv/fFRi9bvmWTxpKWfaSxHqyo/9xvPR7vR1PpbebsWbiSzDpm5iise6+7a9sKJJgtLiwbwYlDo663bXjRuwtj8aGOgLMC6zLcBT6jIBYICx/lzLXxWg88oXDK4t9CueT9XAa8dVqVvxgyLT/2ogHMvv4b6wFuf60mfwYvlvhanCQAazQoOiMWMzsB3fKAReul49OoyJbZNId1HWLPsivs7nhmn99Kb2hkNcOODP9kx2ziXb3/8KKuf5Mi3SIdzW0wUs5on2M7+hFxIzNLIo+AtMHhmEUwEEYS4aXtbr4kNAfDKk52p6Rn3OlKP4LQ8Vkoar5tk5C7RlyFAiINSurbTWTZZZ3oj5KzEoq7YhQt830M3Cr0coADbVPD2aGtPwEqvLqcYf+v5QOZrrvw3GpxrCp9+Le4LrGlIpJdh9shFR0PsvakPXbiaZMHWp5Vh7WdKppZ1VhXQHc80lipVlEnz6xPZKINaYvbkLUzTLJP0mATf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4ik8pryXPezz5wihfN35q3ffxmF3VaT7uEAF5UcUwQNe2+DBBZYdqOJkF9z?=
 =?us-ascii?Q?3knrDUVdfSHd7mwl0XC9Drapqkv8d/JI1pdEj584IxxkGPTbIClxm0mu2bs9?=
 =?us-ascii?Q?LxcksX8VmLaot0rVrvyWJJ10XLs/tzeko7czAhzgF9IhaHPJo0J3PSnNyfO7?=
 =?us-ascii?Q?+9wCXqX2u5HWLtZXt31xbq6MyUCj9psdSpC62CVsyxjnWHa8Eu8EzgnCi/sl?=
 =?us-ascii?Q?FlA7H69khMJUG+SrfbZQuqJaS1YUdgUON8Se6VlGRs0zpQ1SSXxIvYhfbC5l?=
 =?us-ascii?Q?F430uJXFY0UXPQwLsG3EBr1j75Nmo89VIL1+zd3zfbCoxafylCYCUlRaO4ml?=
 =?us-ascii?Q?AC6YdicsA5F/uEYMwT5BdhEfc/O1zSEfMiwD1NyjhjB15SI+uRYX8nHl97sS?=
 =?us-ascii?Q?D7MgQ4O3dpinmy3tLsmYt0y1qhjOruNA11gZ92MhM9k6JL9vJPJzByb+OKBM?=
 =?us-ascii?Q?THBo8lhnij3Xc8uayeBBA9LZP+ZewhJR1HyOEM8Nr3k6/tSk+JirReX+NV9n?=
 =?us-ascii?Q?nGQIspXfIXqJRh6G3jKGckyf2fpDKaI+da6lDsKbT849L+YN6WVW+uTKaUox?=
 =?us-ascii?Q?ufNuVXIUH4OihC8WpUnI6DcAEvenTYaMmePfMZUAHSKJBm9L5inHsA/gES7l?=
 =?us-ascii?Q?JfYZ5RL3fs4G7r9HYWbWj3ZQ18EiYN3LVQQKNSizvbRnaGKYNI/wsizVpz+w?=
 =?us-ascii?Q?XMMu+rmR1qY7nwtr4lLH97sann8PRvboDOkEbHG5c/bN7dmCr9fnAIqt1eiE?=
 =?us-ascii?Q?tNy6zeXUut4dRV1PpfHaqApuDuav4fEoOaLYbTAcDZmr48cW1XKqY6LeQef6?=
 =?us-ascii?Q?OZxiwJXar2DQU/RVN5Ugr1WwJY1eZFpN3v8tq8BEI6G54jHwG8dxSzQudpsK?=
 =?us-ascii?Q?fwp91Tqjq+i2WGjDsp+4R90Ly90bHVPlgGydeUEXbLuMNhCw4RQmECH/j76y?=
 =?us-ascii?Q?1HFJDsYdNb+ulZjS2rfTjrr74qrSDbXrATHFj6Gla4Gtuuvadb8mQLzMaNNc?=
 =?us-ascii?Q?JF7nRn3UAf7W3kYMa8yDuecJgTwzXlsyABL1GcsT0tl90DB6fOIfoJsLUVPh?=
 =?us-ascii?Q?IwZFYFB/CNgqm76b75hvzCN3llHKLbklMH6FQKALkl48EcC2mGWbz+99FSef?=
 =?us-ascii?Q?HHkJ1uOzj+viW0blChwNWdGpWBYuk/AgoKtthWFk2ZNXLC/GDwp3OEFB/Xru?=
 =?us-ascii?Q?mb2dRrlc0g/Uy3+nIEDjAgW6QA/pRcdhqUcIS0OHVKJlowJj3QJUsvDtG6M1?=
 =?us-ascii?Q?SVTTfYZYqV2u7VZHan7rsZmCTo97mBg1CaINxLTKODJd45ulddMlACY8WI8H?=
 =?us-ascii?Q?zlLofXo+oL7h6EUXXnxoGh2+bE5NB9UloC6uaWGQt301JXpqZ0IcZInGBErr?=
 =?us-ascii?Q?0MpKK7zHymvCD9Id06icE4pEJVNA/i2i0cUnyDxfRkJK+Tzai3nCgTQ7E1W6?=
 =?us-ascii?Q?fQv7SKSMseJdpIVZFMYJ7ImLEJN84AVtolyAdT63RT8wrF+Ym2c6I8Aj/xSS?=
 =?us-ascii?Q?0BZkPXCDxdp1uiK+l4J2QuMY/39j94wAoYa+tRcjVor9SI6i8LX9x7JlELqO?=
 =?us-ascii?Q?/i2ZOeBL85eOmU5ekypcor+cpbW64OtrAQz3phTd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7156602d-2130-4f90-d987-08dbdf57478c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:36.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GEEMjXHAQSsrQv8QUeh9EObi2z20TNNsxnZ1T5dmSW6i1Q1ggBgsZBq7XmObo/1Yogh1G0klMl8cvY3U8JAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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
index cd16535d444f..7955b86c6b8d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -201,14 +201,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
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
 
@@ -288,12 +289,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
@@ -308,7 +309,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
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

