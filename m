Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423A182A7
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yi0NkqVn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncYzzNFadSHOp66m70RvqoA8pyLTBwjhYYcwpQCnRMdAgBkuXxfqMVJcqYYFYYfvuYzefrjzCrd9ffkCoIcxBmfi1bWijXR0Yq+Q8RUQfkK4f//is2bQeTjaXciRJk4XH/I1hc5kgDMBSzjfBaIIeK9znRkGaXrAUIAIkBbg85EJT3GD0npCylOLXN7Vjy0oEB51PFC5YiGpRgZ29XlJ7vjV58a1qxIXwqUTdnmTtanmRrnwmda0IhLt1u40TeuQYqOROJ4oNjvlPOlXZ8A/DXopTqyvQOyZ/kdVKiUODG2UCt0wN3IMc8XpzF59SD/6B29JtJVqyy67mBl3ym81Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT4W3SywmaAhiUCnlCfCesro3xF7t1zss416Nix09Eo=;
 b=LJUhW3gxlPlbj2UyyowgxYYCT0Kaz9UyMkbuAgH810+l6voccdJvlv8xk/Rl1ppbDOtM/Ket1rZLvafJNGPScjsmgPbRj1u1fyuAHh3xVxWoY4o7+fk6xKoXhBTccplCngXR2sXl2KyXRNswR7PfCwbe5H2gfX+sUC7XBBPaDQuUBWuzNBB1nSBKkEeiRnSy9vbJujxM5VQ2Oj9gZAjrFc9izpctSybrhz7pFhJefIdj1yLyVx1lr7C8HQ5mfW0/oPAUJSGJPyf9NJAidYMbn6gNlvrKhKW0D7FWl0IxJwfiMaIrZsMz6zCjsddt8qBr5JTO66PEMmWNXGDapq4z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT4W3SywmaAhiUCnlCfCesro3xF7t1zss416Nix09Eo=;
 b=yi0NkqVnfGL6233kT3hUyHmZjxlwaeUTPqexVdUszRcIUUO/XluKkJ1kNlDzg67FlafFo1NPPUDuhajO6c9xq67Bqw898Gtmsox6snozKKZVuRQOKUlG/dq5vjuEYr8tmxi6Hw0G9xG9ZY8YSpVKi0WaKXeNwhuFY7lmOpHDvoK0lvbTr4uc82A+wq84QDdj0Eo9IjhFsx1AdU5LHtTadTD24I3l1gxQRwhYFSssMdsP/uFIZpw8KlxU5wCVQX8xyNtr26tyCMkjCWPtN8XJXlzLShZxV9q0bFMQP0GvBEKM1L7e8/jr2VtolGT4qcTRA6C3Vv5T/lbjzvH9pNEDfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 21/27] mptcp: add use_id parameter for addresses_equal
Date: Sat, 18 Nov 2023 22:28:36 +0800
Message-Id: <795fd2c88d6be960a08f24c0e44a61229a881af9.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: e2359ea0-e211-482d-50ec-08dbe843123f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	03dC6cM90u1wanH54r+EcBRrnMC/e96eam3kDjj5/tWhi0VFeN5YZeVm8lS1XkkZ/OcXmCKM1AQzsO/g+SxQsi+g3GPzFdPirtv48OsU5WSa/HLmeS0MoC4JIVD+KkTOVthYvn4ndSG2jZfTX2Z6hDWDRea7ffn/cTFxO66fxkFB0wKau/Lg9+qBkWUIZ+vyvfrqxpFL4M7MC1FLqqk/fkEQI7K1dP1QOuY9a/UhxO5kaz8XkrVWhOUGdIxsa5WNZsJCBDpYAptQnMERfiqVSWaDHm+5F95Xbvz2lMzR+vETRZ1n8Qm3LMztsalCeABSaKa7gBU13bNhyCqQCnbMfjLf99Im4bdRyzvXbG2ebmuVJwyBAD3sBU5UIjfUxaDX3lOjwKpkfSIruqSLXx0Yv4yQOe6Xv3WYKiMQ8H+sPhzJ5F7HoeBHu4axq29GmDrZ/HEVDPUm+6hxihlpPUO7EDdXQrxd1YYBDxO8wPBzP3n5Be3dDEe4UJR6TxzqbN1SvIoZKx+nfop3FxYa763bE1TvNSVWmFkfUjX5w/K4W6lmO9zseY0ryrl9IwJn11JXp7lxI0aMLPJFfP3ajIdzX6E+jjyr7IXdHnSLxeRYVrA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oe+Oa5yK/M+TArppMMB8sCaWSCXd/mSn2FaDlK+XnIdTuN9vDLUg8Y3KzDwc?=
 =?us-ascii?Q?ALC/1AR38yPWi1/PmWnj47KW5szDkmC4xGInfiSeHPOtx6bVzuWCrhXU74Ug?=
 =?us-ascii?Q?y94qBNbpMVUMyx2sLI4L1/RIDqbxnH5e91lCYEvH0HX3JNlcErj9xEhG5lD+?=
 =?us-ascii?Q?pncrbMQwBjBhqSZ2bgdIAFuc0sQk7HypShxxWuXAzLw04FNMAi28m/gnW8a3?=
 =?us-ascii?Q?Sr07MODJrwJOYhq6aV97yFDGvORhFISLtUMifF/s2wja3LmAnL5zg6u7yLto?=
 =?us-ascii?Q?XUwji/pkSLFJlbQtVN6ZY6xJOHTUg9WD2MPTG90cidQfrlvfTbw7aWnI8jT8?=
 =?us-ascii?Q?QhvFxn1Ewj+Fauuwye2A8h2c/nFT41eEIAL+SdjREXcp3avZK5CtU5BsF673?=
 =?us-ascii?Q?0T/mpEB7n1tFvPX+Mr2q9qIVDDpF2VLpQ6bpxHODz9XJmbB6SAuzyBjnXbjA?=
 =?us-ascii?Q?sqwYlgSN40EftZCJQOLgMH3w2vSvHpBI4jXDIsqAmOmUdLfKuRjTM1G27Y4x?=
 =?us-ascii?Q?phib+ka1MYgYUXGTLIUoEvpNeO89zsgjelc07Bcga6fcmWrI/KSWDuenYTKe?=
 =?us-ascii?Q?coXcf0uac/Br903r/bLFr4aAP+ebY6Bfj5s/IMhupO2tkSRRpToap+9r2S3T?=
 =?us-ascii?Q?zHrR6cSU7iGkIJwXbZBozkwWmO/qx+0oq9ihj7SYI6vJ1Wx+kGmPsjYr3k+i?=
 =?us-ascii?Q?FGtmIQOubSJeTBDUqPHcqXiEKosZ1Mqnw2H+HGDdoLcd9n9bSBr5wslaUid4?=
 =?us-ascii?Q?+Z2KKUMZTpft5K++XjAkKd6n5+5Ju+6krgu7Ex8zY/xcFcwgp/Jjsd+l1RJP?=
 =?us-ascii?Q?Wp6tQ17f7G1I1ZWGHUwZcovmNPVKv500sINt+EDgBeeI5koFlh6ss+98vNEb?=
 =?us-ascii?Q?kAcJAXGUL0G7WeNf3+KJ4PuJ+Uc60j8OdwI0EdkSYU1s5LONPWX2BbWTqy2q?=
 =?us-ascii?Q?EthMjfMUO2X4Ug3NKxpE9/mLJYhN6Xt4p2F2WvkKKDTRfBkyUK9PbSyLf47X?=
 =?us-ascii?Q?GwwTdkL3PfRr/qBpcAZm7lBrlEg3+q4bJylhPmWL+5FYNhxZUJgl5Vi/dyIx?=
 =?us-ascii?Q?FA1YNbWMpECV49fYMpEEm0Kzq4CsCkP/DEKKj6/8IRl8PlJbJrdU5cvWzRdj?=
 =?us-ascii?Q?HK9uiiorty4au6wdRnKC9Zp6dIQPF1GIvMWYuM+dzXf8WsM8+9xuZBuyoe9U?=
 =?us-ascii?Q?kT3DgEgy2JdOTVSUAmA+4SSOXMW/PXw4o5ofyBBk8miNIy9SQIR3GGx8mVd4?=
 =?us-ascii?Q?ktRVMH9WWPWmJaFe/0o+n31zZ+UF7ROoj61kBM6bliEQSNqBcGGOniqmN6Lv?=
 =?us-ascii?Q?icklv9Qm3ic6LqQjcMaqJSO3B4Bj7XpgJGbxv/vPBEOcsR7r3m0tPIbpc1sG?=
 =?us-ascii?Q?fxix6yNaj7/PpxDvJxenGBp6FBBw4JXq3/PfGeaw2JECq0xXjhITy3dDCNd7?=
 =?us-ascii?Q?yj93x0D2fPXchRb+hZm/MwH8DADQsQSvRUN46CUuJqG7UppcCHpZ1f3VVSGM?=
 =?us-ascii?Q?/rp511mmvx4vufJrqfER2EjYxHek0lQYHLAleIUww94DKA/D2PAuejqpiQBk?=
 =?us-ascii?Q?8xjIb0vl3veCEXrFDOrreO7RgkNAbP1yvJRr4d+WBWlc/0NHVPtpe33NnSa2?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2359ea0-e211-482d-50ec-08dbe843123f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:37.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrR+ZZsImA5wAHFfv+Vd4mFV/9Fa7m4S2J2ut4SZYh8LmVUyV3vQmZMs102vY1B5dTTCs2qCN2A0/zY4J/WmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch adds a new parameter use_id for mptcp_addresses_equal() to
test the address ids, as well as the address. This can be used to test
if the two given addresses are identically equal, they have both the
same address and the same address id.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 32 +++++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  6 +++---
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 25 insertions(+), 18 deletions(-)

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
index 60483ec9cb31..c7c49bf4daac 100644
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
 
@@ -884,7 +889,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1022,7 +1028,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1404,7 +1410,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index aef8cf3d208c..9eb6c447f18f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -53,7 +53,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -104,7 +104,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
@@ -144,7 +144,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
 			entry = e;
 			break;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 139332f48a66..4a004eea9c38 100644
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

