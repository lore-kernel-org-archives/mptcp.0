Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482FD2CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K5S3F89l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9KDdTMLINMGjXv1FICNbDCVgMxDfIUBQnesT7ZknumTVDzdGTd+W2qbFoowbq8QkW1Y0wdNv2b8M+n1m64fbblVl+i7xN/Ij3eGpaWxb9UCI4dikBgiRRz11iISD7yY+aUWvPbhrqyWZD18OACmO01TO7sO0UlB6RzV3NqlOrM0Q/fPEwZ5o2PD++2R5uxRigncu9Zaf28dyA3hxI58/24CFkLNx0K66KtH5BTUMSYNDx3HUJ/3RN2PJr54j2vVGO+6Pmevc6EsWSsGGpR5bIIx/dBq7Cb9SFNxrBtKu1ZC+msMb9Tt+qMwKdWvJzJqmZu7GX93nZXKoU7ZTiGaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+27DnH6uO6vqX84r/9aSY6qVhay0Gh8UVPXxzxQDxA=;
 b=hBM/2mdjJ+ZiuLPGAxOG2wC1lPdpNrbYv5Cu5q6W3U3yiGwElzfJIY533z/7Z3KcNp/q/v5QIuh+4vd12RqcnvIcxv0FjmPPdQswDDPfybCKGddCBPOzPQXFxgf3TNAIENcjcqHJ5Wdtte608gnsZ8qrPwvp4etAMBXjEHGCn5amB8JJiAqqq2dtPSdD2FmsrKsa39f8PHfTe+6m+YG9W/md++V1gedsS9oF4YMTkPe437DseCp0jSgwr0at/LHC6CmAMQFlxEIIXR83RxtLgByS+pBJzxFj5e6Xrbia6SE+rDySg1Y1GcAlBP0TD1eQlP1qSi/Z2VTxE0bpGrAgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+27DnH6uO6vqX84r/9aSY6qVhay0Gh8UVPXxzxQDxA=;
 b=K5S3F89ltSfb/B1YGWEfnImdFQHj2J8Vee9FjeTNGEe/cAAj6mqpp0rLyuRhWFq+wvxM5vNGxvbiJXXGrb1HLOQNE+oCvWn4BQc7vmRWkn0SoUUcKVA+p8QEKsixrSQFrVJ+Zxz+0I+hTRQCPGtrZce6SqPpU5G/rHOKrXpotinjFQ07bincfpLSAb9dS+LQE65z837EllVe1hxwLCpRNEOU1aUfj2WJbOkPRkpsfuz4B2kCA2t3xWvF0LY0niZVaxkLQafP2SMTOUc70oGg64DuUOmjNcd5RIj8SYpgSdpCOohJ8jOeGEg34MNMu7HM23tQVJPQPiUL/0z94BGCdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 19/22] mptcp: add userspace pm addr entry refcount
Date: Wed,  8 Nov 2023 14:49:49 +0800
Message-Id: <2c497c2cb2f53151d0d824c0cb8cd342a36f85e2.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0e8823-999f-422e-0f42-08dbe0272c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NAkUhxJL5Gm3neXsJzEZ4bYfVJa1lDhVUWkUjYmgy3h+63hbgiTiWPCqDXL8dQmBWXbuvSavT4DHa+XMi4EhnRrBy+nhjVdZ8ej6XnX+um0RLPvfN5ZIVhHR81h921ddbdF29A/fyTQypJ0Wb4Iku3vg4on9Ailb/DRmp7Fr8h5RGbah9yXDEBYjmBMMRgzaaK4EYnRHIxpT4kDR+crvQFaZIxjvE08faC6w1AhpYtPPT+RNDG3zA4f5OAoqRomEKdr/8hODgaZLQF/fFBCdClayUfhOxDgo33Uy8eYpP3yUOqyEKr7bKToYHnPuT9ISWHEYEBmSrDILLNuxA5wHPqIsvzJEqC1fCKOQ2XXwjoVX/lJGJaBPFN5MLORMqV2qHSxDWyYSYZocF9ApV5vbb4McI3W+QnSuK0RdtAqIw98RnL12TsC+zGC1jaaqh77H9nuTrQuJxW9beszf9wl0d9bMDuFAj0/SMvsec+bnZ9I5d2LqRS1ZVBo+7Nxde1VW5xIS409C3nO1Mm/8cc+LNcVMVmcCHZh5eT/leVfv15EsXCdCN7G6Eqigcv1XrNdKYRhiHqE4Cvi+k47nKew5R5vtxcjvS7VktdsJA0d9Pco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(966005)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GCMgSnDVbO/jKar6tkKLgSiUNxmosTGxAoc08qss/MZYfPTj2TuBZ0jIqzos?=
 =?us-ascii?Q?cqfZbB1maEAKp0Ge/hFiu0hklQLboXWl6AdcrzwujGFzHfHJwa8eC6Bxv3I9?=
 =?us-ascii?Q?xVLz2v00ApbAOXb5AY/bq5FuNze5ShLxHIvm2RHx4bVKkSPbLXGice2t7tgh?=
 =?us-ascii?Q?1pyWSz9Rtl0tuI/6/VyCspcVWWT53vX/l0trUxExYGdt/ULkI/ZZ+/0k0RIP?=
 =?us-ascii?Q?U9Od7SkWFPDaU8Sb0qyS5wLAZhonWuz+ZAhmE+vB8X3MTuI3uoJnI1qDq497?=
 =?us-ascii?Q?LUHW/GaUBheCVS8XV8COZ8Dl+yR16WwU531HbOzOaj8z/mFi8LfESkY32Dma?=
 =?us-ascii?Q?Wz/h9kwwnV434PL8DKJRGHPWQoSCPJL28gqC0UM8n2szD7ZNxmNz/NH8iuip?=
 =?us-ascii?Q?ogMAHeD9rx2BsjdMoA979rvErO1aHAwxwnsPaPV0iM6e3vKw3u1rWxhiYKAE?=
 =?us-ascii?Q?RJ/n7sGmfZTiWzUVrJEt41RJO2MPlF3ih5DMB5C/8ZOXcLCdQu/SJIfQPmNI?=
 =?us-ascii?Q?hHDJountpEsPM9HZ0pyx9H6yHf4KESjEVZ1VpMHHNqvukUCLrR6Q+dsS71Xb?=
 =?us-ascii?Q?hlhGVJL3oabxpVx1gFoZCP6rF5GN6goqyjw0WHjbXXzQ3489o1/BIny8pb9w?=
 =?us-ascii?Q?PgPJWcFw6DIKkAqZsfsnNq5maIzm3xx1Y/x+PJFng3+C6dRtnV+TZDD/wVty?=
 =?us-ascii?Q?YiEW3qNL8qdJZ3Brf0i+BSR3sI4fkWcfKVcj/GS3f7kC1g7QRhl88pZd/r4U?=
 =?us-ascii?Q?AvpVrd9ZDMk6K2uxHqzUNNdUhFjAeui4HowYwkkKpzYZptIDYRwIY4vqusE2?=
 =?us-ascii?Q?aT30O09FqPrxRfooCBQzeZHm3i1ElLOAGekN9CZT3vpWNHmIYeKXAl4oKRAW?=
 =?us-ascii?Q?o5UMR9hkD5pJgECYZ1uxjXt5gSH9wGhLwniT/B+GrsTInJm8vJLLSZsho4ay?=
 =?us-ascii?Q?PRslMv+r2jV4Xs2S9LRmCyBGRKEFqGUwR7k3KSW8EIlZ5mwwCdqzIr4+1aBb?=
 =?us-ascii?Q?Ai4jszpkHnKETRZEixE/j0+ETgrdvxqMl20JLTB42Pp+w/cvG6t5Ov/NkVv/?=
 =?us-ascii?Q?hOWiFBidmtpS7p9h+pDpWSB2vvRr33G3U8Dk7dcP4/uGzj4EbY+ByZxmEMmj?=
 =?us-ascii?Q?Wwj6TQNd4ZGAVUp3oJGuqY8GHcVMYh3D8d17BxeN1xDs8mg9tvDxkwSgHZoc?=
 =?us-ascii?Q?sYFT5VrMHb+ifNPOqMp+Js2kgoTizUUwslOJjUhSXpsN9JhuhnXP4VKhy5IF?=
 =?us-ascii?Q?TUOgr219aajTzG5wH5rC6ZoIaxdDTEpdVo0Sp1FBlV7QQ+SNUCLDcKK6ev4e?=
 =?us-ascii?Q?IhjSo18zaViVPTSzQjCptYneq2jgrrAv1W42w1a9RipEoKEvftukEqSnwM5o?=
 =?us-ascii?Q?5loANbz3Y28uuIvsAkFMitYPy+QI7U4urre58gaFBHXQCPxoHR7wjlLf5ubm?=
 =?us-ascii?Q?AcZtLfIhylRjONzFOodbItBoZdm5QKXFdBKJgRyT9RBgZAWxcEOr6ZFd1UaP?=
 =?us-ascii?Q?JQzSHMLr8FJKH3A/8p470XWZ2svC6OvT3PZh12u+VeSVgJr6QHNAvIDzz7cd?=
 =?us-ascii?Q?Goes4wLwXQ/5qRVUMYlm+NNNve/UA/kAqW5/zZ7pG7lMkOlisDvODkvXUTIr?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0e8823-999f-422e-0f42-08dbe0272c2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:45.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFqw84pR4rHNnR8NWWcebijTkji4DB2BaVKEatjl94PBBJOLc9haej3dfCM9DzOcTOxHjo+zbx7h3ywxyP6I3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e2f11e821214..f93eaf1b2338 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -83,6 +83,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -108,12 +109,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
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
 
@@ -207,6 +207,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace uninitalized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -312,8 +317,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -398,10 +405,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
+			pr_debug("userspace uninitalized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0eb7b84a262..3093766dd224 100644
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

