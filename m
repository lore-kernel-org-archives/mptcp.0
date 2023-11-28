Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0655674E
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qJWMwwnx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgFoFYrF3hQV7BLL5Oyiapinv4jOVZ9lFdS8XRp1AQ2SoaH/FIXQ9Q0cGpVk7cNudCfbOd0Gp9BNEVppUTBfCH+addBIvWuNaqoB2zlZkho+ddiXvFo1B2VwvNGGPYDFtmNmzVRMochkyPBeuFi9kOUvTFPaMizxDj0betrTaUE/jotUj/1duv2AD3ZVmNU6mdfgosxG8QVeNUDDPgoa1178DsibRPeqwMcby+0akVCLaKqrT9xbqJk2Azgltxafk0QSGdTy9Ps6iC8KYvX2Sx5LaATvGgKukEzZV5LLcSTVGZc2WQUXXComf8oXr4avtlEvZrsCijUIMXx9K++Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETTaZDMPn8hsI404iQqYPKTi3rlDeB9A11y9pe2W5Wg=;
 b=ZNKVVBZd2qL5ZD4wwBQMg+cPixX2T170mW/YtUUWcKz8UDNRHTxbYf0iaeQv0JdN0of/U5mFhChjV5G2p2odcLgrB8TbksxqZRTR44/n5p1/Tyq6q1V7c02beP0EQrOE7D6DwTf4ahfjMj/TP8ttJkF9DnqsV6h+ZhTJOdQn45JBfKIKm87HkY0jVRkeHSofXGqs4KCB3qCzZl/bkQchTRLKksbzHDYXGeaI8Ke+jFrwThx9XBWT1ekPguDfnOQrDx4VrvJZbpyW/mExkLdYq8vnnRSFUiCnXXHrfKL0lRdsvj3c8D3VWNpEsS/PHoU+UwyajDm8m8r9BjisXGNFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETTaZDMPn8hsI404iQqYPKTi3rlDeB9A11y9pe2W5Wg=;
 b=qJWMwwnxWjPSk0Tu3PVdyNQqKKKH1LxOc04lgW9ZOXjQjM7ZLi35A8jXrQQtK+q5Yi3PJgXL0XkRjy/bwhuI5ChB4lUE0W+2RnKGa5n7QumZTGyi25GdjJqTleIXuuarnX2acemRpr3Fm3aqLuxy6SNhWxSPKxnY3Hr0C/i2vF7G+Zbyuqfx1nMI5j6smQEUtZLDVqod+BwLD8uTHa+9W/NKMAg+EYsJcg1MnzOxnVRSfT6nGXt940YGsRroQlv6tHnuZs++Vb7w+uXHmF5rIqZiOZqr1Kjstv4H0V0sZJkcfG78DSvK8WcXqDx6LW1cWTLAR6HEbh2CRNYZB4P1Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:25:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:25:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 29/32] mptcp: add userspace pm addr entry refcount
Date: Tue, 28 Nov 2023 22:22:22 +0800
Message-Id: <b43c181206bd467618043d68d1ff5d55c0b80be6.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: baec86f6-4bc4-43db-7104-08dbf01dd7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5cnRoflGFKYDoWxX305YCks00iWpHzDrdvhl6+grk9USwIgflHykOKBmLP4OrI8FeBax/IWzH5DNExLUR9XxYIs5DG9pkQ8r2AboFNDw6XyRiUjQLUz97Vdk2PW/zLp4B+dcK9sHgPvtcvHMJBzsAlN+hk4c8ttgGJ8An7dKEP44Se2jDB9y5OcXOsAVUL9wBQ880AP89pO5MQOTtwDNOg7i+GMQl2dXoqCg+cG+65zUpyC4PhWMnPFlibFF0CV3y1+JcTxkV/b7al3K2bMlHTJ4xjVaJW8JdgVjHbgkAS7iuTI0kmEifeGs9bYpMpSRSUnvCqFsVXsnKNZPFl5ue2zzWgmKf000zP1ACdvw4wNR2dIfu50sX9VI2XSsyepvCP1X6l3FHn2dvIQAdjgAwmq2s8X7PRStAMNcE2JcwkpfeLu1AIg1sLiHQqAl+KKmywzJ49jPcZVz33RtMzUkewS3al1u/s9XR8/JK3/zHW4d6TLaGpy0MjG4Lq7Q9nMSUtpRSSKtaxOExykgnD8gk1oQY4sh9QBAHykNww1GdtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(966005)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6q8mSMwfvFddaVLXuOmfOYrAE+C3dJf8CRJPVworwVTiVvrsKkw+mZSQ9l5?=
 =?us-ascii?Q?qAG9Og0zx6Hrl7xup8YGuV4d0fiKfxYMy4jqenr5MGNfERm3EHGjwwgbNbEt?=
 =?us-ascii?Q?NG7mGUJyiBvIsmxBCl9/1CuuY1RqwzX7rtaIoRx6HKdn9lgiQZVnOCpfmfA7?=
 =?us-ascii?Q?IUDIBidnAEBc2kOnc+GRt/SUiuNjLkgC+WWkUg2BmlFTIEmDAnYHOySXoXQn?=
 =?us-ascii?Q?Zw/IJtNiOAuZOhIWRBmZU9Jf8D1jhZzph3CkCnu6u+I9z0zFsRVWv48rX9XO?=
 =?us-ascii?Q?7nugzVFoD8R1ODsWPKMCLOLErFiKvkesJR6QxLgE1NvgswR9lEbGtJbSxqtI?=
 =?us-ascii?Q?GHHLLSJtN6sjPURuzWk/XoDeQDIP5F490N6vPt2ExQVRIQmg5gCt2kTMDbPz?=
 =?us-ascii?Q?NBr0wL3M69hIsTcFO0X/V0qs7xq8G6Wug9jR9rWOwUheXu1Ucct4WHdv/rI3?=
 =?us-ascii?Q?FRJHtec1HJISgB41z2B5qoW3f5Rnqu6DT1x751NUjFQcI3EKD0Yed1RCYXUD?=
 =?us-ascii?Q?xNpF533bAcH9PUfAqPDpt0WertaDtAejV+P4onFQuuBIkOaDQ/RsjFaoz4/6?=
 =?us-ascii?Q?lWZvl7tvu2aVjxDgcyvYgwuFXej0bPuRQPiLh94j31pLOYKAltDczKtfdpbo?=
 =?us-ascii?Q?lee/gRp3G+bPg2DqyYVOGv9tT18S2IFvZoLIft3OuvUSq3NP93KgK2eKgrK6?=
 =?us-ascii?Q?VjITzr1Qday0av+oHk+5JDPi7FeguJXZG71Hvz/26MQtzaB+wVSAQj9QWpbP?=
 =?us-ascii?Q?7vvpLaZBki/6Rnk4o3WX+bWtKhQm9zQDEQwfPFV9AwHhjBBHGWO2dr1HTscH?=
 =?us-ascii?Q?1iN2AcNtvHmjmbu7Elzv/pVZfTxP9qRrUkM/sCMTjZ5liNOR0g1dOp3Bz4bx?=
 =?us-ascii?Q?8gHiirWeeJ1G4Uz9/b5gap7sqiA2GMs0/kvNvZdGnerXJr46KaBY6bvdGewL?=
 =?us-ascii?Q?Khzv8jVExg9XO6mn/9PChqsEBDlIwH8t8XZQgR4F30hEINtoHjmqUiJIsBAB?=
 =?us-ascii?Q?nQFDCbPO85K4GhTb1/yQk15SB+ABrnloF6IRNzxBg4yj/AOsPeUEliYqqcKD?=
 =?us-ascii?Q?9Rlv+X9OyPy6fduj9lecRElaoVnOQsy5kHhN5d0diism/FUGCz3CiVdB7yoo?=
 =?us-ascii?Q?CgsxrDcFH1z+ccuG1sqm3/FIt96p70TuJvq5PHLKg9AjJjtndi2Rl0USoyRV?=
 =?us-ascii?Q?3TMXWlOD3ENLGPKFhBFO+DhyvRWnHJljhOh6oUUZI6WWRFNLWHXbd0Z84s7R?=
 =?us-ascii?Q?/ahv266gEGTOgebC9YwEzoCP193oxOwfToveOHSJxh93+KlVz7L3v9kgvUgT?=
 =?us-ascii?Q?GUiVTIwfiQYGV9RffLSakFuoMfOZy54MGNUsU9pBa4JB6M6UDE1zjCU5bStS?=
 =?us-ascii?Q?rXevlB4wwMRTigHzMuYs/QOcyWcpIKzL44LtS4AAEuWn/gecqVCZN7JbPN31?=
 =?us-ascii?Q?sNzFHiSnUtPhxWOqAv27ezB0mI7Lyk8N98RQg4bXVSVLUzPwzkxbVwif7Y+J?=
 =?us-ascii?Q?bbbORjTUVhhy2gZXMCRyet4tADqQox2thxdOEuZo9YeahUUIzsvyQEmypqMj?=
 =?us-ascii?Q?uZ5CXGfUmbH/qLj3RGyN16RlRhAbemOH/QZR/E/X?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baec86f6-4bc4-43db-7104-08dbf01dd7db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:25:17.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFnHfatqRDe+YP2FgPP8OwpLaVN9bkwn7WtHaPqrSZqOsyEuVvEPn9XPX06lqVfS9teIzTSgezzkd6i6xrPTww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch adds the refcount of addree entry in userspace PM. Add a new
counter 'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter when an address is announced or a subflow is created
in mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(). And
decrease it when an address is removed or a subflow is closed in
mptcp_pm_nl_remove_doit() and mptcp_userspace_pm_delete_local_addr(). If
the counter reaches to 1, free this entry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 99ade938eef5..43a1217503ea 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -85,6 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -110,12 +111,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -216,6 +216,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -321,8 +326,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -408,10 +415,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d40e29419c04..3fccee77b739 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

