Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD58848A
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UqIdq68a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qurq4XW58+SA3QqTjJYK+rA1Z5x08RAbLyCKST7gHDTF60QwTyCx31E5PMsm/zd/4grdH9FN2cOjPRc4MmDhgvCnmd8GiQLsSsVCkBANdP5x+Eb5N/3ScbAsY3cqgs52caiqO9dv3kdld2yZ68Yf0nUpVjmSxFFAM2JSuNxFZtX1EoKlO/+lvheayv6EopKDABAEqcg3yRVkkgjtZYrENlcZRJLLfAIuW20Czs+oRDewDnCWurJ6wWx+UCKFxNh24fYvMHjTw0RFQAptBAuaHob0ysC+D2obEUBxI0cs043kWY1lnOJmBZY8CKsfOICkMu7qvqvAQ7FM3z0C/mSE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sry4ClfUQYAHqy70Fa5D4BueLaP1MOK9geOxGarhCVs=;
 b=Tuoy0iflMsNzqcXAg/if3i4LdVbmK9fyScJew1HRaAopJrf5UwndpmoAgkPNXtHYnFigsQ3T+yk/C8hnAr7BALM1FsRfcN9e8pCb1MMLiQ7oPPE2CxzwlxZh4dZo35+6Svy3xbcRx3NsT3chnuuXtj+yTKOSUeoLJE51a9Eg2nwHBUBfT/y3okQbVHSu8TPTTGGO+4naY3kCMWARgPKPgjQIHdV3xuswuVGJUTdjeNjBxvji4utW5DSlgekYL8fVft+WEbgAilubtGiddzvQrjHwH7ZPbqsd8l+2HD2VuHXfIgRtElkYnZiFhTZcTg5uZejrvvYT6TC8w1TWwcwKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sry4ClfUQYAHqy70Fa5D4BueLaP1MOK9geOxGarhCVs=;
 b=UqIdq68aZ8X+xawGYYz8kezDJ4VCNff7yWAeCD3U58a/PgB5180hRWsFo2+fjNegmxc7uuwppahlFl58TJqutSVHVkm1rtNo3pslHtC01YSk5zrQl27w1wsbSmBHVCqoLxwwsnABVJaPpCIuPoKacrLXY4ls5Z6Q9hEYepw+5ZnQxf5j89lxf/dGjYKidNMNP9rTFSd2G12QDVxYPl/SGcm6zKvLN2Y29RAFI7OAZQiXUMZzNlUNB6BlU7D4ebVG2fiELrv+zHULzhjSHAZMauWjbj/9rIReOGv27myvlZQGLNtVTxkwCYtahhBk34lK0TWh3+KbPzGG4kyb7pbu4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 16/22] mptcp: add use_id parameter for addresses_equal
Date: Mon, 13 Nov 2023 10:49:00 +0800
Message-Id: <05472700b7b82ad80e1c43229ae24c8e9841a474.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc67549-1077-4e4e-4436-08dbe3f34bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	13vGUbQ6wbBVn+r+cBSAkoZELSsTcOSgxH9fRgDXjJAZ+gTDdhQcATXBtNOxWAINGVc6tfy+Aoze015IeLT3lIOgGjozbimqOpSRqOfHO26U0zy0X5JIqyLRCWXrlcAtY7ELQg3x8smKpiJqjItHLt8wwL+smuFZfLhcd8hyqYcyCDiYZOeb6h+L8LqjMIJ0yooAb/XVDO07SrI6GxEMrgrmMq+q7HM4XfchdULdg6al1mzjhqAfCSX7pgohGVOum9jfn5WkCDcBIh7tYQy+UaIIPobVnXOB1TNDhVsbNqzQqRszr694EvVlMYssjU8LQIK8Yluud8xTKmkPLkmgyb3f1bpvzwjgXjzlT1vQg7ySBxW8VuM/65Xjy+VjpwxjHaFZ2yFjLI0fcbTICj0xyjiqqA71z529YBk91+/m5pOL2YabhINVgqls/t5gzn8izgwkYCxoOzBI+MSfut5abKP1y9nRV5A4Fc4L7j6DtE1PdzkLxNVW58A/l74IDUsYOeCG2D6c5I+QVNJbFOpVWUhhYfEDU9iZC4pzf2Jm1MJzuVjZC0jR+HiqT9UCHJyN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nt9/PO6Iv6jJ4xvHob0HncY2uyh0kIAEz5dTmsPNUH1Is5tlMTK1aahZHc8W?=
 =?us-ascii?Q?aqJEZNAHztadA0E9Hbb2GZWa4r893es/3Ojxzq9fi7tNAqdbIEcena4y1PSg?=
 =?us-ascii?Q?cGjdkk67S7G81G4E07s9XM546/k9eQE4sYHRykdqtxM3pAPK/LaCEn+fv2xC?=
 =?us-ascii?Q?/1336loJ7xcp7lTw2qass6KaDjwTCK72dDUTEw9cSPSREYm7v4vrnCkmE/rm?=
 =?us-ascii?Q?1B58QF2nBJbDLXsNbfspnSnQDz+h9xhB18dRXU93yoivceeIE/X5kVGlnXiJ?=
 =?us-ascii?Q?fz3BGA1WSIGga1zkGmOHAKmxuxrJUv5SSUpgUf6DU92hkCco2T9p95BwKBC/?=
 =?us-ascii?Q?pOT7uBeW7SmfdLqCHhsUDzRJjTa7jEVWPzacj9W7p4LoolM8ab4euHLF9L8E?=
 =?us-ascii?Q?8aXKCat2owNskspvwj/hmfxys7tCSInzoL6OexrXUfxYNCNP85nwBSCxipVK?=
 =?us-ascii?Q?25TVhUq05YQ/HYOm/lmMWUtkoA9HTzFx/AwdEh7u/bz+vWNvHJ6QfZ+Y3gGr?=
 =?us-ascii?Q?L3uP0CUjep59p0YoUTeaDvDMCDzuh2UZsfU3AKVLZYo7RVxpU3qeJvygU97a?=
 =?us-ascii?Q?v7Vuf7Gij6j8on6S+aiwjiYeMPALxynJyTKkRb2EJRwHGdao/kM7QMQOpBxS?=
 =?us-ascii?Q?tEIAGNmDPQQV11QXFQ7PN00lQ4K6KSRaoFPk8xOOG/w4UEMUET2IdnF+gPEO?=
 =?us-ascii?Q?5zVLnvngdogiNgWyvjsLmffICgzfTKLSDyXzP9W+rgpo9Dk7oOvSstcErOF3?=
 =?us-ascii?Q?x0MkNjGc0ZTSAmCKlAiRBUiE6ecpvZ2vmFZ4MepnCe/TqRy7a50TURvOIz9m?=
 =?us-ascii?Q?WqOgQbHL/BoflE+/6VnrM1Tp7/biyXoXHYnPHdjZArFdJRFgBmWNLSzpcht4?=
 =?us-ascii?Q?rPwpLUNaHpuoHh4xKwHG+umUj/adJqyhTiGWUHGzDoEMh36HVtknKCoOs2Rb?=
 =?us-ascii?Q?UuHKmq+FDacgGNROuIFjXPxxv7Xbx4yH7HY3jrVYysbv6Mc6PNb1wJHFxj4o?=
 =?us-ascii?Q?csoUFTbr9whYpPu4C0ZjKnqqUncG8RLkldvMgemZUTDBqm2VB/onAK//mBxG?=
 =?us-ascii?Q?uywjuQ+2dPLPoFcdfwG1Q9JPyFdscJxVKFBJsP7hyLfyhgDREnF1ymcPsQUi?=
 =?us-ascii?Q?9LAn4C6/A0D48kQF9A8sUIXxD+8tddL7MoVTioh89108P7TmoQkYOcshGy0Y?=
 =?us-ascii?Q?D6BWnT/1uH5dx0c+cUos8FzlwYDPkK93l3XJ5cxPiiXLkvdFZeFVglSHfgXG?=
 =?us-ascii?Q?qgANFUdSgfR+Un+RBndpiNWeunyb3f6n5FGIYxqXkkcOJbCxCISCJxzWB0lU?=
 =?us-ascii?Q?nFdvH8uOIx8Jh0lZpv7uT/dFO/zfj5UN2TB/dJzpS7AcCfePXLdHl5ONwAVR?=
 =?us-ascii?Q?hnGlvOMCBqDkSfjIKm5sPrV2WSfXHFE0Q79T4sn/7u0a/G6B3uAPb6HhV0N5?=
 =?us-ascii?Q?9hxXC8XoszRpY1GSqwUlwyD/GaLyZmLaWGnSVLjiXbflmpC5iozXdOqKZYUE?=
 =?us-ascii?Q?LArLXAlFwIWLUQardN+X5vP031Du0BGcbJWRVWEImzVxPgg1TmZtsVMsmcs4?=
 =?us-ascii?Q?5k8QyezNYa3lFuOPgYvhdY2OVLDGlzyuyi8bXw5j?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc67549-1077-4e4e-4436-08dbe3f34bb7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:29.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U63fAL1o22aP7h3u7tpvMZdNi3bbPXCFDPoPIsVHskK/fDV1u17uXY9Q0iGGimG0a0dXONH72jc7QwfniwmRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch adds a new parameter use_id for mptcp_addresses_equal() to
test the address ids, as well as the address. This can be used to test
if the two given addresses are identically equal, they have both the
same address and the same address id.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 32 +++++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 48ff7ce20890..77a0e859076c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -420,7 +420,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false, false))
 		return 0;
 
 	if (mptcp_pm_is_userspace(msk))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b7e4c8d21078..599137001148 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -47,7 +47,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port)
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id)
 {
 	bool addr_equals = false;
 
@@ -68,10 +69,14 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 
 	if (!addr_equals)
 		return false;
-	if (!use_port)
+	if (!use_port && !use_id)
 		return true;
 
-	return a->port == b->port;
+	if (use_port && use_id)
+		return (a->port == b->port) && (a->id == b->id);
+	if (use_port)
+		return a->port == b->port;
+	return a->id == b->id;
 }
 
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
@@ -110,7 +115,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port, false))
 			return true;
 	}
 
@@ -128,7 +133,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		remote_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port, false))
 			return true;
 	}
 
@@ -205,7 +210,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
 			return entry;
 	}
 
@@ -222,7 +227,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true, false)) {
 			ret = true;
 			goto out;
 		}
@@ -463,7 +468,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port, false))
 			return entry;
 	}
 	return NULL;
@@ -704,12 +709,12 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct mptcp_addr_info local, remote;
 
 		mptcp_local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
+		if (!mptcp_addresses_equal(&local, addr, addr->port, false))
 			continue;
 
 		if (rem && rem->family != AF_UNSPEC) {
 			remote_address((struct sock_common *)ssk, &remote);
-			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+			if (!mptcp_addresses_equal(&remote, rem, rem->port, false))
 				continue;
 		}
 
@@ -883,7 +888,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1021,7 +1027,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1397,7 +1403,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index abcdc95e7bde..58e9ba51ad36 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -52,7 +52,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -103,7 +103,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 089fbebd21d3..e66b1fb7b522 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -645,7 +645,8 @@ void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port);
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id);
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-- 
2.35.3

