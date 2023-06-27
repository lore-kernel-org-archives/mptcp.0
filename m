Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABF7FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDFidY53ITI/sQqxQ758XeGDiWtKqNw9SGodA99/kkuoA+l+hQHEonPz0D4sqbtcJ1WHr6AtHjQmOld/KScPtMQCJSwqYl8NfGC/jg9rOCccLYUracb/xVU0BC7nq3ZRKVWxxk4kHNCCPyWEr7GDrZdDxvAb0nhsyUfi+svAUudOeXsZITV2hTuDLK+pybgcNH/s9E70HXalm9+Xy8AaTRAUS1QPdOz7kbN35ywaR6MdVxiDOyV5eyuvTE0nYDI2TMyM81o8GgjwERC1yC0elVeW90RLnIzf8FUcqcUfKNMJ5vFNCyvNWpRaQo2mrQMliWgErsRPpHx4sHM/4NULJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUnWy3Uxwr30w+QK9cl6w8ugU4KeuI76tBk0ZcfpRtU=;
 b=I56lmp3W/x+D8/Y30G9mbZW3aFevshuUbGzM2E03LNhY3KoslcnTatY7tY5OrMgvG/RiUbG+PbCn6YW0ycMfDtSoVbXRosgRmcWWf8HyTWSUR83tWEZ/Ap4os4hbKQqons5lHT+67i4Y5sMNgmjRutnznJWW429d4jU1HVulyVkiIwmv9rG3PFu3Fcc2eVS57dQvYVx9VB5j3Rc+YF6JqKVz9S63oFGInAJYkPIUPIRkK0PR/SkyfB7WSum7kDc8YUC7U3iXi7/T+V8p9IlnCyf4iXUAlMEwLSzulgBenjxDlF9CQZCmve0lHbPFvvq/ekVMGLxdQvChyUHpmlHz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnWy3Uxwr30w+QK9cl6w8ugU4KeuI76tBk0ZcfpRtU=;
 b=3YUj+Tq6bWLYIWJ30tgMeWwCFBVZJEymN2dc/UjRQQ5n+/6aKM3YBWHRBapT+Y/dEihcwDznnKIQX93AGAx6FBuDGXgqJGd1//O8e5OXUCzB2H6lqFJGhPOieLZWLy0r8aqily7GN6H3gXevQw/JETB0hxH96+n1H8WmpKAa45R6duD71no+zrXZaRS5lIUhMVS6rZwFU9mogwZEzMTLO9tiyvEWzlE3FDSjw5OLe5PDOvqmr0mZceVySqfBw9GvzgclLSkL/y5N66nDiTjMJPPWW/QzpfVJBZuepdhb38t5hGnxtsdimuFAUWRGROdZBwTnA/ZdkJjYH44suxxf8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 04/11] mptcp: register default scheduler
Date: Tue, 27 Jun 2023 09:06:47 +0800
Message-Id: <e69a36b0c4e48f39f9ed2ff75f2f615f31aaacc0.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 8165f7ea-bfbe-4710-9bdb-08db76aadfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	my3jXwjeL0mT6HCTWRQXBUH44wQhvoag6ucoJvI4aHIxI8wIWmUOTJmpuqlbICdfoQW4lRicoo/NxrUNRaSp8N03OiweNc8WQnEt1Pe0Aon7hxfw2ZQP5UxPwBXJCe5UZhJznc9MFTcgLFLeaJH3MF9kZbyvXPw+gVsMIw29JpfE6pgKumkfroe5RqhxjNuI2KJOUm7xHxz5GNHZU5WOyfq8Zy50AS34s/BokDbqsXLX1WUItkHgTMixX4D0xrilVjRmZkmP2pypSkodHJLC2Nv5BPKeHT6eJ1TCMVQBYiGI20ufTjPNr4dCjk/EVjOC57xsgkIOFMIok78KnRd7VcBeQD9k/49CPb0TbFeM4PTHqXNuI8HzvNwsS/GaguN70cROmSpaBBkmuLpxyAw6/bKB7yf2Ctu/HzfWVWARQbFyX5JWAA+vs5eRjkHRSNr6bZ2itbUPIDC+7bM+V75ICN28Buy0/KBwF2eIfW8QRHS/aAEOpDa9t+eF2VZIuymFwWJ/kC0n5i7s75G4Cx3KlAhy1Lr9JrqiGaqY9QaaUZIcLRko8nDhF4eDsmJ6+BSt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bUyTG/hRcFKKlYnyRpv8t7J2p7c3HWy14ySH48/vGPPyMuZRSGu1KjOKkEsX?=
 =?us-ascii?Q?uIfwx1JQL9/JgwBNQYxf9O5FlHc8rh82ejBJDQWsXbmFjxSriT2xWsOlbzd/?=
 =?us-ascii?Q?G+54leMfHfRHLmQka0Dwkh2u02nRAe8YPtms/DCNI/D5KXR5WJVmRvEVM61z?=
 =?us-ascii?Q?TFVuJuPliS9agJVFc8wlypYdhCEKZ6ob7VKqH8w99FIAG1LjkKV4PKvbidR1?=
 =?us-ascii?Q?1qOf6zgds5oCknbI1pioCoqrnvlz86EDMycJpSMyaitD0Pc3rTrQ2la1N0a6?=
 =?us-ascii?Q?s4nMsMFr8+5bmqgyrmLgmWV9K+/k37hlahkfJ+4y+CtWd1FwDUrCJovTLKTD?=
 =?us-ascii?Q?arybicgWtzKHNA2V5WJXglkZGMN+Uh+NX1o36rzxpLAl8pOAES/dZf/2GEPA?=
 =?us-ascii?Q?rU5fJ2X2R8zERz3hh5JoQB53Svh50vcpWFTxH0vYk9CH9pscppfX7U4Kckab?=
 =?us-ascii?Q?4qZ2WwWgl/u5ZB5pGXF3azU9HvZWq5J3BF3pBMVJJRVudEyn70dst5x9lmsV?=
 =?us-ascii?Q?8/O7RNB/kszr7HuObz4NeLhAiwy368B9qTm2GSsnG/Oq2c6DBqadhX+YMuVR?=
 =?us-ascii?Q?kPfgiEVAKg+b2u43klJWhh+gnWyAIk/O/+n6l8v/YsO7BKEpXHVVvVnok3zf?=
 =?us-ascii?Q?qkM3UcrmxG0u/dBpbN/mP5kj4rvZTq5RzC/t0poPXKl0JRJwAHHW+SbOSSyr?=
 =?us-ascii?Q?FJF6Zq2eNOKrOKF8toXmBWuoVFnsWi+9k4FOcJ2zcyeDA4b6E4gZKekodz8f?=
 =?us-ascii?Q?fstYCShPTfJVoe3xEHMCF5dXYuUsi2pJesSbzhCvfQITt/OeCSUSoEeW5EOF?=
 =?us-ascii?Q?dzboNzSKUj6SDLUwIAXgLB/sUbNDiin8zSFDjjTHwj9ZbVSnvxOuJl+PQlAX?=
 =?us-ascii?Q?txz/4HpHZGMCnvamNWcC8OAxHQx2mvZSw59C8wxftUrKY0KC5ruXg2WHV9c0?=
 =?us-ascii?Q?3gxOQn8RXV4+qQ5K0BRX/yWCTN1POsMi4ZL65L4wn4meQZBgd1BV3mqIPLy5?=
 =?us-ascii?Q?lchp6Mc4lkCHemxNB9wNLIEM8V5VMgqUZmujJTTDfWlqoOxuJ9eIIEZI+NMc?=
 =?us-ascii?Q?eShdopqOL+5GoWUGOp3PJHDnUCgeX9qFZweLCRmFWB0QaqX6on9oBUkq5X7X?=
 =?us-ascii?Q?MbD0TE4IBnjx6Sir9hRS1V/OvKYrF/RnExDUUkzl4w+zsYuax9RMMboC+QXU?=
 =?us-ascii?Q?mFEve6VK6mjy/cXT9ApzNbdNKAROSH/PpRaqK4SSdI+B8zmk4t+CE5A2o1XA?=
 =?us-ascii?Q?QzYKP93iKsPVVC9Ow0e2g0MSfg/Pnt6uiJYFo4NcruiMkGW36K+G9wIO77IR?=
 =?us-ascii?Q?FCfKH45C5pTaliXU1d59wYQ5y5Ktyvpkg5Pk+vZUIfwNCoiJoGcwmkmRa+18?=
 =?us-ascii?Q?rPFJ3mtkKpapHcXFt3Zkr+iQlgTpM7AtbSm9bRXjleprLLjotRX3RgwVCxoT?=
 =?us-ascii?Q?cvQFuhE9dOLyBq8Ef8EO+InDY0fHZc0ulUavtlfQ0Bx9y9g2yExYj14WaY2b?=
 =?us-ascii?Q?/d/TqBn2w3J6X8RNu0yrq5jUIXhv1Q5ok6+dAdhzCpv99zCyctGTk6nJKWzW?=
 =?us-ascii?Q?4GijdHA+R3qVh6Mw2xOS5gw1+EXmZZJiIGqIFhtb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8165f7ea-bfbe-4710-9bdb-08db76aadfaf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:27.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NTu2XV5axaiVv8uoDR7uuo+ClrRKP4teuh+If1jp+bkOkfe1Ma+2YO8KYgv9/01o9XTs+fAGkoaOeQI8WQmSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3ae0b94d25c0..5f9f046b2124 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3970,6 +3970,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cb2f34c8ed09..bb4d50c8c398 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 82665263bb94..a80cf0481edf 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,32 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+}
+
+static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
+					   const struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow	= mptcp_sched_default_get_subflow,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,16 +76,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -70,7 +104,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

