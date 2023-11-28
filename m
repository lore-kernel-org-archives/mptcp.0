Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC435888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JARz7Bb5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQj8JUFXkOpxIpaBwkUYTq9vqgo6yvjG1ThaT1deFiWiK6fKBQDvUVamziLiWvvdGBdZ9n6pI/KL0WdAB/OE2bzHat+dj3CsmKDSPGYKn6sWWT6jbEl4IqGhbIarYvm4zrOjbrufma04XCWcs1YDfEpjFoXuJHZVKxobyA4bKxVi6R0LjVqpShPaGZn3psYu0ALA5g6XfrteKcLkTykto6h816hTTkUBjrukLN4LQYfFpFbpnFgi9jWY2VaTcZ1dadMTOGdtEkezLfA9b0KRaf7kKe4sHC57weRQH5RZr4m1nAkID2emVr2DB2brZ9OUX0nHIsBM5awLbSF4RSJ4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=dGEkdWrcgfr70hIiu80irjJdBg/8YFfhYpwoUoARkzarZudiVhOueGizqNqko3ZBVbUT9mYJb6lDlThnPT3IqrlTCdbRTDW474MOoZkybcFD0RzDo5yTV27VX00fJszAkbYfG9a785GIA7SAa4AHShfX+TIEyoOB9c187H8WPdKcmSNfesKGN9axz+fZhnfH/xrps/wuAgyKTlg0ExIcHu8FKUbn6L1Z79NFEQlxnbN0YbSeg3D1GBc/XZsS9uBEbkU/4UeUL7QWWY1UBieFP7dv3ZOj3JV/9SVKIIndu5tAAxdBsDs3iug0m7QJ4XzvdJqkQ5mSl+K5Nht5wi9czw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=JARz7Bb5FHc3QiKp8WCUWRyvHllDb9GzK79+2hCy57SnytePdSt5bFMu6BUhMH2wSLRpdKu+GeVclWQjOxWBNgZtDvJQGIP8ZCxqnpu92S72XMsaVGX6CicVmhIW5f+DI/j27w83s92Ge7bRZ9fE/ZK4zM8MiXODnvDxcAdDMnF/rg86x+hwnby1nwjmzWJVSuzURAe5Wv2TzYMcu2QsrLjzVY/fVuML8uMLmun11fioH/w0qmLwNfcvlalUmff9PG/GW+cLHERr8JHUXwQ3NcJgicX4fiC1Y3z+v3M0uRFhiscK0Eo1UUxQQNd+LRVxwaL2tblY9F4AxUxxLZqsAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 15/32] mptcp: use set_id flag when appending addr
Date: Tue, 28 Nov 2023 22:22:08 +0800
Message-Id: <baa3f3b38048e1db44e2755ba4b91329a8123193.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf1f41f-a5c5-4c57-ac0b-08dbf01d9d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VNVyWa+sHujyGdkHzEDJKQiPU5UQP6+p3T+kwT7Fa/PLwM+opbCKqKzAGKh9X5RyE7i+1a4/tK4Ovr5vxxR01wdoZkmgcNANtU7vSs2NwXyig4xNLYUIXh3uTBHkp3vEOq46GWbirUW0LiXOcSNIjRFiEadsOtLLMewK3w3mCeh9GBe6B8m/NjmEsfu+d1IX7K3p6ik6DLyLR9juyYw1UkFblzfx1gvQ893LVnibkbgZX2o14t/XZ4ioM381iilwXF92y5rKFKPKKxxopC7OAqfOT+fca9A6xsxb3GE170miHZZXC9DpWs5zlRXoDud+V89KKvP/7sxiNKEcUSkVXQRz5Gfs+oqwP0QCmjBl5bwWlwL4L/BSgq9r/8NHzC1H9bQmhNaHfVWmmN/Fs1HYIUVwtKoU9ryLI6qP7eKYDX6B1Rt8YaO8wHPHboPnMgBPd269pyI6TD/O7zfp4cOapDYt3gIV0przkByf8qAmMuoley7tGksTUzWYXRc3XZPwBWOcbyA2wYLrrvotUOVW/oVdtwvjpt57fsA8pA4GDNP7xNWy5jeiARozHmk6x/+O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lUVNj3kBAZoJ6VK6/2qgprjb1ec5hXI823kZkarfviNkpmgJZ2moWVCpxD3j?=
 =?us-ascii?Q?4Ou/si1lZTT9OmYxzu+Lcc71SZeztLmbnnx116Oke91WtPKaYOo25XaK+8A6?=
 =?us-ascii?Q?BVyArvWq9DQPVIUpuAEEAyt4MzO2z6TIfQ3kh+oOq6S0USBVeyhcW3a1OTBY?=
 =?us-ascii?Q?DqzQ5YzQTE6jdoMT/I83nHzRYwPenwyRrBgtH69qG3qy8UgScff3Yh5zfGIB?=
 =?us-ascii?Q?CjGXHmNX8YED1TLeLvaRilZKuFUTwvT9uXwxjg82F781oyZi9OR1DCSaIuPa?=
 =?us-ascii?Q?ulyS3naEnZG3yJ1XGHOf/AnsKOXwDpViUfXv1y0we4+xxtMvC6zRFwEAqOR7?=
 =?us-ascii?Q?3ZJ1VQ3WWMbIfLcNRduFygObCaf6Vnvzr2uVu5bsO6C+0x7sTLu/lksoT1Mo?=
 =?us-ascii?Q?o4cEQ7Lq8bpA+oDzdYfCbQ5k4nij8L9i+pyu01WUfWzMtIQQhUxMfDi1TRCX?=
 =?us-ascii?Q?C1hPytIDqYxPY6rMIVlvfRA3mO4Uh1h1X2IX/j2psi5ou1g03nTqnA/Jgy0T?=
 =?us-ascii?Q?PItzpcbi4FdeiLT1lbB43HNYb4nSCidxppni56YYfFdU1sm2pRZN7144f8qk?=
 =?us-ascii?Q?qWUxxJeb8dtv7oOToB4+oz3Uhk0zUycZoMdxZgcyAWxGpHoaSL1a2iAx7Qv5?=
 =?us-ascii?Q?LF1VUBRIQOhiW3x1BGKJP9rdVAbbDXuT+0eMrXQ+ZtDI8wORLKs2guoBJMpR?=
 =?us-ascii?Q?C7DPWwQvrRjfMas2Y5fNszzXMQjt0CROvLLBfuVOAWRNMLU9f8NoZEP/NpJf?=
 =?us-ascii?Q?5MHSq+qfIMnYg9R+yc1SOqrlN0EMQ1a6id1HGpqVp3eTG7TkIt14p1Cq0SKH?=
 =?us-ascii?Q?pHQlfGTlBtqTaIT0OJ6IP83XI1sWUhc50OkK7oVpG254QAEAqxb9loUI/mij?=
 =?us-ascii?Q?bSMe93lZekReZi2EWbIo7Lyoxy7cV5nJOo2L6frer4TuacYqcdVoTvvWx2nK?=
 =?us-ascii?Q?Rr7fwt+n/FDGdtg8BOu6nXbok7spOoKp5+FkqIgZ+y2eud3fK8PIJLhusIy2?=
 =?us-ascii?Q?f3YoznL64MoAC2neEfeRpp6LkLxLUR70/PqdjdHwuT4/f1FGj676vY6SH/kp?=
 =?us-ascii?Q?50U/PZWBsx/e3VCnQWBucznr8dHaQLEnwSSyANgau7F3lZYIARmC5rMv7qNa?=
 =?us-ascii?Q?2KXF5+O1nVmrsOEh/juXXJB6gS9GPFLCj8FOnp3MRG78BhqaaDe/EkSoPuBg?=
 =?us-ascii?Q?sE2aHyBdnzgRag2AewEkQKctRvN9m4DPHC5Rk9d3W4I2fZhS/n5mAc+GQPAe?=
 =?us-ascii?Q?DqYp3cvQ2lYJvh2mRScYleXDt4PpY/zKSskPyQLVpHC9KezUoqSSy8xMAEOG?=
 =?us-ascii?Q?2cjC/v8DOMcVFD+iuPjtRwTLJ68XD4I9VEc37WGZzreybJ5aWMESFP5m+CBS?=
 =?us-ascii?Q?QoXzAEd4MyxXZMvae3jidXxZ9UITx5TB1q36m2k/rRRroXNz4dVCxmdRCRXD?=
 =?us-ascii?Q?bAhm2Nre8+GDISu1S1+UKpmCenSW78KsG0+H1T4iYqteeCKq0Pe+RjH5TkWM?=
 =?us-ascii?Q?oXHyl3JzUostmSSunIo8gVEjkljSvM3nuwDjN72D/xhEtEmrnnCZ7WS1hg2W?=
 =?us-ascii?Q?ASHLMiI+ebcxfAZh8FsYEgPwoREYcMbZcdGXPD2s?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf1f41f-a5c5-4c57-ac0b-08dbf01d9d87
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:39.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJZf7T6ubo5cYYekt0u84a/vihQka4tPs2wUjUYrXI9uY2nfpEJj9q6yLAbTMi65eg6NDMyMZVztcOI3uIIx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

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

