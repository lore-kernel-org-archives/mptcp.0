Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AD7472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="sS2q2CK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq4jDUWEjt3S6G0ca3w+1frRERAfEHbUR9lb4Vi5Q4h1wuwVFZUpt7sg+iEUS7fgHJHOTxeXsX8FkmhTUtJ2uOtguqVtcYkAP3vR6qy+EjPO853+RPrRRLQ1RePHFgj7jHD3yXCEmlVj1U+DLuoweGze5buCg67V6Ez6+qC+tc+AiqTfidHz9xo0ggidtRJtgnx7YYwr1m/wc3iT+nPYL49TBQzB2lNlN55BuNXUPYz4evg6x0KI4Jr0zb1nQ8bZUnywVYxMwhA4zirwMz/M7sDsP2lcDYeDAl/agvEEJpZUeM4SB9sFDKIrZ5/rJ4vn3d3lsoU1TWK/oKd0Yr3I2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGv7Qlzpo3tOGq8WqZP9Y8ZEp065I/7HsrN1ouitems=;
 b=b6OuIg9Obk7DihE2+kcw8MTRvdxKbDxtiUF91h47dfcFKv/RFOWjL3a5JD68oOG9l/lynOE4U1e7H6xG2BjF40+qBE7Dp0cB8f9Qz9h0Fym+V405R9EDB9ErK0W3J8VFCyux0mz+C2Ja6bBhDm0DWl1Skdtx91VdUcfoovV0l6xZYO2lCuylr5c2FEm8jViJQxntYIVDPi16I4K19RIODNGQR7kuq0bZ8uwxARSAUnHjqk7UXRUIl5Eo+4E2PVsYtXbkX6aE0Zx8t0cSvQogcQJA5Qn+tIgUpKcFCY1sa4iaFBKucfqQ9N8z9aBDVKKgKe6Krj9AornKOeVeNhwm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGv7Qlzpo3tOGq8WqZP9Y8ZEp065I/7HsrN1ouitems=;
 b=sS2q2CK6MyROAY/GRwayRykXMEiEoZxqGGFKXzAJbjFe2DYpLAjSKNeGFEq13zxxjNJGxf1F3gx0C23Oc4mJnmI6Z3/K3Jnj0VgmrdzwLjV5ySqTlNOxh/p7aWgOLlBeSZtOxVUaILlTsUCh55xXCI50ZIgyI0cNGlH0N58RXJwu3do3W8GT/7jt/G6jJ8Ci2gdQk+H0x8N8kcKwCbSm4z+66znlUtPkG9PrZ54yoBE94U7gUg6MRXYCToNt+U2LFgH2tsqdJnm9ZhkIjA93hhfusi2obEiC1M06cXk18P/XTwQBi8flU3+gcj7Xfp55Qg8JUPztRanAV5d9DmOBxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 11/12] mptcp: add addresses_identically_equal helper
Date: Sat,  4 Nov 2023 16:35:46 +0800
Message-Id: <b3a210207ef2c3cac2cf15e7dd93dadf277760a1.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b39f73b-ce2c-46fe-61ed-08dbdd1132be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BFIaN7i+rJrmaFaRgc4IMhn0TNlIiKsnxbvBrnueGN6SKdrYlM9fnOhPzMF9HS3L+U6A7WJ2Z9ssBEwowsyqqx+jLisn1EATnHbEUvsnYkWGlj//+Vdrs1AILaELP9XQkysQJHzUgboBbjFU9n09654a+/doRMYZmTbXWCw8JnyHplqrC8UKUhSGwXgGp/fK5+gRU0wQQvK4MHnPaSYePQhxckL540c9SfVdNfEomwfeqh6IDMm2eCcbLqx6xdkuIQBqF+FGsXHAmuLHIOvGwzNrbKjzSoxvN0bl0T3IKcujoSEdU6qHFs4P1JBmP7VMl4u6zWM8WfSvlgekKV/11RARzMCD3Y3YNKDff8VtnS3o4VEqqntMavhlpdEtg0ULe+JEHALjC9Uc5Ckd4dI0QfDzzK7T3QTC6fHomUO2qrK+gm9Ayd1mIXaeRnlxP/kVDvO8Kgy+GtnZcVCyUJ3rch159HtsYcJQeBTHxPKk2+Yp9MWYjexn+rC8bjBWjSUBS59bfdL7b8BeAj0gARShu/UCuSEFTS0fAw2gstk6u75Nw/SRktY0R5IwdfeEiYoS+d8WLQGuIrNL/lbwZr5UqfA+z6cyVxBDLjrzzyIOZ7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3A8qlVFB4O985YjXQnQdk2rGVpoE0GuOIiq/XXhS7gsLMEPAcmLksoCb066?=
 =?us-ascii?Q?XsiElniVr55d4fX+1uBmFHNsyxep6y9/rk51gRm7LU2qoaE8tOFQAP7LMhEK?=
 =?us-ascii?Q?rWyeo8Z4pXV7t058kmP16poeDdB/4PSLPWYl5yVlJMqBrOr3HPCSvfyTcUUW?=
 =?us-ascii?Q?s/zGvbegDdetfbCaLBUyT1RtU2FWOogVfy1f0kExe8XNbfcqGpSOHn8OppeA?=
 =?us-ascii?Q?oq1n/v0m0FSMsw4jW6iB0hUlEJjxdIGzxyl/dhuS7BM+L8L0LC3J1gQgPWbS?=
 =?us-ascii?Q?+fGcD18E91ifJ/bthibceIAf+6bM5QLEiIkNSTLVaD4xVULPPh/nTqL1Rn18?=
 =?us-ascii?Q?Gu8Sn5G396jOQgbJHLeovOYuMvmmTWmnJRMhy3qSGRzabSOnhAlsgyLUeY5G?=
 =?us-ascii?Q?h0rQYG32z6U508Z9qFYaj6rj1XLPFY/cp05ijlGk75DiRDiKGQXBvhJ0OIsj?=
 =?us-ascii?Q?BlgH8DawQSueGE7sycNZPZ0yAYpu46JnKv5cIfykrb9UabgxcZh1+5FSSw9y?=
 =?us-ascii?Q?95lBNNYLuzqVuw7edMyagv4sVBdDSxcUgC4xirI5KESJdOz1m3uPsflO5aM5?=
 =?us-ascii?Q?6T7UZw8K/r3of6JDYdNHDAvxp3oz+L998ef6tQZG773f7rn//z4/T8jfZOZZ?=
 =?us-ascii?Q?Fg0fulHlzeyeZndnmHr6NbzM2+Ky9KCYhvCg4ITzHba9dJGDgCUFVkYY71GW?=
 =?us-ascii?Q?+XhcWARxZJYlWAOXVnbEYa/OXrFqKN8hic47HGEgHCHAH2GWDwAmuUWGyLF7?=
 =?us-ascii?Q?FqHcSwnDoksVitFhYCogtBNmhTeYOexGyhOTFKp4SyjDqmst8IR5RBSlm0RB?=
 =?us-ascii?Q?GK2WcMkToiWDfw+yOtO1KMRB9pMPuOfnaREusPpDTFDkjJSxvHQ1O4QkOitu?=
 =?us-ascii?Q?+Ofsm2HzCE6g3CH7a1cmEPAVRC6rrXLlkwehk5uhvMclXSI+Zx8cTuZ8B/7N?=
 =?us-ascii?Q?XleiSqouGBBOVc8G9QGWMdQDvmC7wvuy/9FP9rXyZQ7Uw4yEL8xu7dtmjr8L?=
 =?us-ascii?Q?32puLkdSxzR8ckmG25pmnFCXPoQtuIOzM0dy4Zsg4D/CdW1TQ/DwZSwa+EoI?=
 =?us-ascii?Q?w8POUiyXqDL8XTxZIBG86N1LlY/Gs4vjKQwRtxknbwINXbI1LbQNblgTdWOC?=
 =?us-ascii?Q?jdiwWLp5NKVg37sGuiMWzU8Y08yXYR9tglzny37D2/eFwsNY1oGfBdQLmeTU?=
 =?us-ascii?Q?bf+MN0MGgsQPNTXwiKOp2vChTUkAttyTWQNwPfmkV0KKELlWXUmuBRrPQBjL?=
 =?us-ascii?Q?eh/Knf8U7zaO6h8TBbhqYrojjlEgexKdP27IlyRtVXt/nf0cb+qQoWOfLmtE?=
 =?us-ascii?Q?yXxVuKa+S/C5lz0LnKVHQQf54LNcN5B/aaJoYZxbfhaiJ1rh8pQVAiBKu0LQ?=
 =?us-ascii?Q?2kXmyDzJfifJsrn6TtbJwvU0biXUjFl+Gt7YwMC8RqPa+sd2Rni9g2LYyEaK?=
 =?us-ascii?Q?g30Z90qhykWTxyDHNNiUnFjAXWMBf7sKqk24XWDzPuoTRABv9iiaZlu2n0vD?=
 =?us-ascii?Q?BpOFUHG2LFwXBqAvx3+IVKADvJj0NP7DSIGEaquSlyH3EOvFMtFZt+MQYhTg?=
 =?us-ascii?Q?gXu62U69k3ZcOnkquH/IlTDavnwEBFsuX0zQHLcBjMB411fO93aJ5Llm0Jcg?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b39f73b-ce2c-46fe-61ed-08dbdd1132be
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:54.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZ/Mn1PdZeBt+mDAXF96GSKkzclFTNG8P0CELB0O95eUN3v9pNnxMzLcigU5fChsVHf14hsqPLdR7hfH5SOX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

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
index 48ff7ce20890..475534e51317 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 52f54d57aca3..ae5489beb31e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -74,6 +74,18 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
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
@@ -198,14 +210,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
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
 
@@ -285,12 +298,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
@@ -305,7 +318,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 089fbebd21d3..5f2c52c82cf7 100644
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

