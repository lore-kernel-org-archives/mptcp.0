Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BE11CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hKgCcwj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjaZJaWYeiLv+4Y5iWiWn1jwJ3mJRSDsP7FCYeMm2AzcGFYfRslTMqXXSJcl6LlpFvO0hhbJi+zKm3hBDsgMmJXaKKJazMVwG84wO1EmWeqd5nzllWr1uERluv6rLuk6vumpQ+dy8lXBLJEyCmcTljGaNg7YP/2NCOHtrcJAahIpCu9RDDsCqvLtPtTFM4Dqlh7NOjv2zqx870VWs9TvBvsvmy97FeaEbd3At3gaA9KdIcrrfPRs5a5zv+A2VI0QnK9sK9Lvlpp5wS7v4hFBY6dp4tRjW5XVC544LrrV8WYT1cBR/YdHup69i87PQec7YkB/Gx5fsa4MryBj8fcFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33yZVtHg0JDBpg03M4Lwqd6ewC1U1TK7umO7PRVyL+g=;
 b=Xiz370+xOhXjxiI19tbNVg4U+5ZH2fawf0xIwqk3DhwWXkE7R4nLGgGiyvVggsO4KaYRjIpplQXtXScizmveXOAA83Io2GVIdvbrsyZx7SANum2FDFxdpYXDoEMRiUvSpexAj1PsFY3yCoIr3k7dUEc/LZac06EkZVBgziyd6cfrMfCX6XHo6mDFkErMG6S3kGZbGJd+5mHXh5JAFX4I26GTaZpFut4zGO03ZlbR7m/WRCkIbyxPTt87YUEfk6OYbazhnVBleGG+Tsl4lnBS62yT/QyPFdjQmM+uGuxAwmpGkqI84r8erCyJT5YIr6gikhzEJhYnzw0LBddIAlS08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33yZVtHg0JDBpg03M4Lwqd6ewC1U1TK7umO7PRVyL+g=;
 b=hKgCcwj5CzzvCydfpbj+YTFMSAIOi/ZWAhph8XD7tXS9HFHcOglS+I5YCW2/4n0ydP4CAHfB5OfAaWb2CT8eq1EKNpE1EJxlBHDzi+Nd8FvMvsBk1s5C8Y2ctDRMf5uwBud7KNWwmFTjYAEAVUIoYxN3NqYTy9fOaVseIR8Bh587lqtUW65FybjOwWRA3t7X6KsYLGjZReu0NsTsbZ+byYXGgTSU2JgRW5yViMD3agvRLG7Oe/LD499v8OhZtYfYgxPOwirNZnWJNNbL1tqy/bLAGrjubyt6AxQHrx0R+NFwAmpyAl7maz6EO52YfNYoT99V+udRGCEx5zpyxDLLTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/10] mptcp: use pernet id_bitmap in userspace pm
Date: Thu,  2 Nov 2023 17:50:46 +0800
Message-Id: <33cbccb3212f686019e2d508e58a4ff37cd70a55.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 387338f0-6e91-488d-53e5-08dbdb894063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bvik/EZ0bLSAE5W2A5jrObOevg5f0hU/m497BLr2s/gGv2QrfNTHqsaqy2Fvwz0V3tUbIfyvW0LjIfM6QGWSNmmXpnEuEBE0xWeryqeRBaHGzsXdg/GFGo/7BnowNgWKuIo5HHEkauhFm14NWZFepQ5L48YYC7L0yhmjkcGASZrP82/+Dow/XB8pdrSN73zQccyELRLtkBHn95jByRlFQRLi3q3YoWAUlbhjKeopftKeshMLbYQbq9ZiUQ1ptpYHAHWztV2WEgSJntxOetQpZ9LnGR7cW/vmyqXQmwna0WE0iwP33+saQTGgC+daS786iybV2zOLSt1b5ZH8DPT1EOksXJug8HuR9WowaYg9JQ4ivTxloz65M9f8oSvwJyGTNhwjTwxImEAkxf+Wq0LXRvqJ3QQ6G2WFFlUdZmRZjQXUhQBSVCuYGHovuPaEJPPWnPL+B0QFjTXJQu/P6qtwLJdn6wJBInG9neEm9SXdFbtr9Yn1yju5/DVNn5D8IrQ6K8CQe4+gAMjz1YMKX9B1B1NoKSttioI3+VdVhlyHoLFse7XisDy+zNn0OSZjjYsJUJ1OGu8iM6Wa3uTXTdzBvarpkfJawZ2ddUZg+sHuIL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKrm3hF/HufUQeVV2Kcj+BsnebKskx3F5o9T9SB5sPq+w4vvt7o/JmkW0GZf?=
 =?us-ascii?Q?BxhVur5hnqsdpEpIRyu0He2GOU79MngQyBFJ+LCyVQvXwTGn8PoT0c4gPhrj?=
 =?us-ascii?Q?HFIn6DuoP3MGKcXnbVcWz6WzxD077waTmcYCY2v7AtZSIRJAK0+smDWfWjC7?=
 =?us-ascii?Q?jzD8+osleg3s/MxwRILtuq3a8dG+XYjU/sB7h5d7kcsVhMwaNxfQralByEfH?=
 =?us-ascii?Q?pziKJlo1NfLuTXSQpbNoCRERkhTtaM1UvOl0I364lQpZdYRKjnUfeMgayMSv?=
 =?us-ascii?Q?OX4c+pPyNnRp6SN3LpNCoIIKUnupjgBn8pWxxff3DR67Xi7aS4omUdnHWdsn?=
 =?us-ascii?Q?x8dQMoyMDVb822RXm3EeikREW7qac25BnGvXpCIWnRnzpNgrXlXohOWtDLDZ?=
 =?us-ascii?Q?6YYRwO8Zjjfp51aTpEMlBc8AnFgbK6h7dLJScZL6VtpCTHuvSMEryVJeowwd?=
 =?us-ascii?Q?g+RKKLogiXnlKO2PBQoDpAs1IQm4BOMfjlZm0+XgpM7u+Ci4opgcNAR9hbF7?=
 =?us-ascii?Q?G45r/tHE4HYoXRUGSRtwad+/NHWf71Y/6/gy4o1DwQy41PDjeuRMjTVi+AI6?=
 =?us-ascii?Q?EFKR7HlQICQjnlL04W5gSK4cZXY0N8INMlKFqAUyjBUq5vVOYXvmTnnF+QdS?=
 =?us-ascii?Q?mpdXEu6ieRZ8P2O1b0qkDILjxImuf9jV9UnabhPjFJ1w6WzCbnvT8XiP8L6W?=
 =?us-ascii?Q?QPB1HiZm7RY9S9hEExBwwIlDBu8bqHx4C/Z8038dg4ze2Fp5Hsad6uxmC/zC?=
 =?us-ascii?Q?aCsPjnXI6QR3COVMKevQYV53JkTftJGeIRBgSkhztLvO8irl17/PW8tHh4Tr?=
 =?us-ascii?Q?Tauzsz6id9snsgLIglFstHVLEIMxm1VduZ5qD+aYsodbqV94oMRjFHBMrchn?=
 =?us-ascii?Q?S+Qfn5ITNQfZ20tG82gcxC5//bQMciGWJdn82LQF4KSYhKZrWg2wZKJgDL4Z?=
 =?us-ascii?Q?844mXUA6tsnuUnG+tClTDW7io4RKb3NLHDShL3+yEYOQuMcf722AkOCvLJKr?=
 =?us-ascii?Q?SVujelwPj22LzaYrIm+XUPiDyRi4NSMxggMMbtv0NJLkN4qsjIWPGpoHT9yE?=
 =?us-ascii?Q?GnAgrrhqTLWcAx9fyTG1cx3u/++NuihrslSRo3fZg8axlgrlzXsjkoFuTxxi?=
 =?us-ascii?Q?BPpPGEPvOTmd0JZMpKGLkW870T4yp7QKo0Xbd1UWLLgqcFvXLPnE9qEqSubT?=
 =?us-ascii?Q?tzPYqnTW64mk5+qeUjSMe6bH3gnzh4e4bxtsLULgfVLQSpVE3v8Ri8tbgVdf?=
 =?us-ascii?Q?9vgkHn4m5smPJfvw5/Yp25ddaOVW8Gny3asqyo3Ga3DV2rIqbBHju5BAeCaR?=
 =?us-ascii?Q?w+9UtuHC5YOZCRIf5RMV/uJZXsOlVHraHwdofImi9dSW5uGbXGvQxRxyvw7m?=
 =?us-ascii?Q?IizGbE2TMPZinlLjT3nETYWiWHqczvv/uVOf+Thn3BVivbw3ghRGjm3/yhvs?=
 =?us-ascii?Q?XFj+ezEdsCVnQ0Ctxg13ndjcFAPhtDhS8hkT/ofGOMaXw6D5lolSlzDP/4G0?=
 =?us-ascii?Q?pK83N5CFMpX728/nHddcXFgUDX1yoRgj7K8gK8DdpoMtHQF4R78qPTNVQRwc?=
 =?us-ascii?Q?dm60z7fkVe1Sa4m/z/wkyIhtPTYw1vZzH+RSxLqT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387338f0-6e91-488d-53e5-08dbdb894063
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:14.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJt8m7d3PBcqChbH1QLNGkwZ1DbzFkeQCedWTQjSqYevTkjsxlKjVvea3T3UIl5RFIJwIwm/fyfhwLOA6LAjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This patch adds a new helper mptcp_pm_get_id_bitmap() to export the
pernet id_bitmap used by the in-kernel netlink PM. Use it in userspace
PM too instead of using a local bitmap when appending a new local
address into the userspace PM local address list.

Also add two helpers to lock and unlock the pernet locks.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 24 ++++++++++++++++++++++++
 net/mptcp/pm_userspace.c | 11 +++++++----
 net/mptcp/protocol.h     |  3 +++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1529ec358815..75be7182181b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -228,6 +228,30 @@ unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 
+unsigned long *mptcp_pm_get_id_bitmap(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return pernet->id_bitmap;
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_id_bitmap);
+
+void mptcp_pm_pernet_lock(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	spin_lock_bh(&pernet->lock);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_pernet_lock);
+
+void mptcp_pm_pernet_unlock(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	spin_unlock_bh(&pernet->lock);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_pernet_unlock);
+
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5687578e6ac..6856bde6c74c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,17 +54,19 @@ static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_soc
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
+	unsigned long *id_bitmap;
 	bool addr_match = false;
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_pernet_lock(msk);
+
+	id_bitmap = mptcp_pm_get_id_bitmap(msk);
+
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0)
@@ -76,7 +78,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -94,6 +95,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
@@ -102,6 +104,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	}
 
 append_err:
+	mptcp_pm_pernet_unlock(msk);
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..cf72a57e6c54 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1030,6 +1030,9 @@ unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
+unsigned long *mptcp_pm_get_id_bitmap(struct mptcp_sock *msk);
+void mptcp_pm_pernet_lock(struct mptcp_sock *msk);
+void mptcp_pm_pernet_unlock(struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
-- 
2.35.3

