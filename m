Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1A17C9
	for <mptcp@lists.linux.dev>; Fri, 26 May 2023 02:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp/UjJDF/UJ4fYDMt3/r0+zyb/T3bZfizDDHfbf4r34SpG4pNnSTlak6mIozv0+Y0yUXfavTxAAxoB1BQ9GTWqX/JOZW3tBgbpNFaDvfUT2nYBuFaSH59QVUo6rQeVB9nnoUa6f7lkgIm5Vx2phMifyEmT9IVw8mnKaw0+gfbAXuhgd9SK5Z6Fb+unaqOgPBUw78gVzX8e3+VF/6xBgUUv85woyUmbaBlp0ZB7P+Z6cd7jDCYHrQX39iRn5+qgr113i8maz0Zj1XrGko/b7s6N0IzaQ1CfaViqqTN8mgCOD8/0ncXNtZFiBS2qkyOhGaf3M6KX9Dxl3sXQ0mYpNnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbY0JdD2D7/bLrjtltVb5lsca9SVkm3FZqZNwBdOS9k=;
 b=Va8+PE+DiP/D6rVXJ8RsQjiiaQ2oaIZw8oeDCXgnGpgUxBC/jpPZhG9sWKfiXiJRdkMuuWTy4Y7W4rCqpBHd8zlKj6fHwMQkELZl87Y2tcTAJQ1E5qyv2qqpIYcExZYs9VmC6ShAp441y50PkshcNHHfzdVwNWFXR2cojv6iUllKwFmi88VjOAPJ/HD8kilZxKm1Joe02wa3AGA6nUPNTuShjPvDoyjDy6E8M4zzo+iBCqrDWJSy7LB/zdG1/hBMN7xjKE15YRJD4IhXOUNogfCXY7x2j1DY8HAC8O6nN+SYSD/WruDjAIrIYoImJJyx1f2K2JCsojnH4/xA5LjuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbY0JdD2D7/bLrjtltVb5lsca9SVkm3FZqZNwBdOS9k=;
 b=w0Dr3no0g9PEdIOY1nTu/jwT4RrJOO96H7ll4frIb8scJ598UXdhLuTI9zrtijLaa9M3+lLKH6scQxoZp8ItweZfyakwyMglCezzneu6OhOaWvoP/x+MD+7tBuY6NDH8GDFGiytIgaPuIdxt0n83R1x1dhE3ujaCJBTcdDbB6eZcyLMNMol1DWnMYwkczTQMU49eXf6poGMe9h8NWY3Shdw2gk5skJ+qx5u5ttVZi6Ym5vK3MTBHiBw7PfiirUWMxPZTRomx7f8wQl0JdJEa43k45CGr2P6wYlsp7SNKD5847gwlqsxwpq+vA2+WNdtbZCEjP/iEr2lFp7gm5d8dyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7466.eurprd04.prod.outlook.com (2603:10a6:102:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 02:16:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:16:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] mptcp: unify pm get_local_id interfaces
Date: Fri, 26 May 2023 10:16:09 +0800
Message-Id: <73305af80b6c8b3964acae708bb188d41bdcbfb2.1685067241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685067241.git.geliang.tang@suse.com>
References: <cover.1685067241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0253.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c346bdc-71e3-49b5-d6c4-08db5d8f4132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/qwaEqn6uDACFgnwKui5CL8j5n36TEWpCAOVtDO94bNvD6NJK1B5Fp4jgUvN1vX6Nywb4BZQ03ahPvM8EVkgia7a8PPGS1KTLMUSbv32dSKVPE8dAEOn/7DS/v2WLiIRjdrnKB6VVWePTIik675N7VRBvG5DG2tzbB/hkACYAqDfksuFgNu9czluu8oC0+WTt7BZG9Xapiud7/789DUsS6n020JwDdW+6z5vJdJzkJQvaTaux8t6S2EQW5AY4p63tA4NpxzoqH6IR+FUs0xmuWZ/VhcPnpnGrkxNPrT3EoTfGAsLgOW9tNe8Dd448q0GW1DTnFEa9enArLnDdLNUZNi/MV2i+IWmDLTHpaxq4MxkA+624TtPNuz4tbREklCClevY3kfS+SW8KKVfFDzMi/jcXWglsKJ2zLSrNY7cv/M0CLni200P4u/TWJM4ZBkWQgwcIZK2PF1YHrqQZPlBvogEskK7D09dL8yTJUs8z4KokT+lfhulhTDbfIrJZ2m7ij4636UWWDDFWr5+dKuu9IcrFNqDOb8inv8Wxd5ddLhRiH4KusrYrGQRnXfjN5r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(2616005)(4326008)(6916009)(5660300002)(8936002)(36756003)(86362001)(38100700002)(2906002)(83380400001)(8676002)(44832011)(316002)(41300700001)(6666004)(478600001)(6506007)(6486002)(186003)(66946007)(66476007)(66556008)(107886003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ouP8yW+J9M8smoEM0eyZUlFYHGZGnT9nFXQAu1k8aHxOyerIBsJhAB6lS1sZ?=
 =?us-ascii?Q?Jf/mXDM2gFdToW8v0oY6Wz6PdkXkhwPnDqyaC51SbmcMGb4rN7LXbLTj1trq?=
 =?us-ascii?Q?rm9OE9Pb2RmJNYP46fEHiue0NQskdPMsE9EFHNTWC43xYYH7NvCjjSV90bFn?=
 =?us-ascii?Q?9rVV2zcTblqWJkbQXSYw9isl/kPKvCv03OeUzMBAyiwIDzf4d5xLPsfk+guh?=
 =?us-ascii?Q?1/PEjLingXG+KMdtU4/FRyR6cwWXe9URLd1hk2fmuiwuss7LxDK9PRaw6hqc?=
 =?us-ascii?Q?6ABZQk/cnkoeBcsgKuzbQiBNz9hQr7OF70nOaQDX+gKcVqV8X8Wjt/Tm/6q5?=
 =?us-ascii?Q?9a2U5GGtElWqI06I160qQYlUsU2VGBhlGcYySjcQkZ6XG9/D/xGbYa3FhhCh?=
 =?us-ascii?Q?NPJ4+ca61cB1dAH+Zx9Lht+RGknsWy4zUodJ5d0boOOnSU0DLeLqRqf2kbrD?=
 =?us-ascii?Q?PQ4z7DaVm8xwRjjw1hFn7QrzaAqXXWH1EZGbANyFTEWs3jk8caJKieT2hslE?=
 =?us-ascii?Q?ATXJqx8G1Nnsy+7J/nI9DiW59QE7gEQw5V5GfJOSPD8TkRGYOTW98s3/tp7j?=
 =?us-ascii?Q?JKCkMF9yUi0B/EcHScLv5BQmShnoivb4ODJhnJfoMwCortfkqUpejwKfWL+V?=
 =?us-ascii?Q?/VajOJtLwTpB1pg96tr+99FlstQ2u9gIcSOkEYItWRTHBWT0OPLM7B4EY4A1?=
 =?us-ascii?Q?RzXdzLZoSs9n2PgzQ65rMMdNOQ4MMMwRvmEUpaGrGIF7iO8nU+HK2lm22UOk?=
 =?us-ascii?Q?lAGAViAE+5DtggO6vHRmCsMqzpuzZYXZ6hKHaO4JzmmD+hUQgyFfZq12NzZS?=
 =?us-ascii?Q?kg1NwovzVEGjXDpKJHbLr8PAn8eY/le34ODHjR8QasLGu2RCONQZ4pmoOEP9?=
 =?us-ascii?Q?4Jo6bi8oiGtTTqpDFq6joMUCocZM/XMaFo4hKNPwrlPQNRB66pGcHgfDpK5c?=
 =?us-ascii?Q?Q0TW+3cKWSthmVb+6C7TreTmJsukKtsNBv5bo6BAzROXX7+EZmyeeZpt9cnu?=
 =?us-ascii?Q?D1uDgsvmB6Vlb6WVnObuUmnizt9mFoJyt3RRlTgbDm3cWOUwEgy/X9RREV+A?=
 =?us-ascii?Q?AVkoW0T+1C4rgub9Q8/3OZqN8ejb3TxgWVRLZXDRMAGQI6qNDUhQ5orn3P9p?=
 =?us-ascii?Q?aXXxeYUxjIPJgWWTFZHM1qe2enXDdiM4hyZen+l36JJbWnS/vRkjXvoEimGb?=
 =?us-ascii?Q?A0VkXCrBZ4z5eXj4otIYuPXDP5/KkOTDTVSlIJPUgIC1obXtu215V48IwCk4?=
 =?us-ascii?Q?Y9CW/HGHhmJsl6MeyzhftbLO30znxPtOwzKrYaNCZinQgVb0NpBHjzaJ0+76?=
 =?us-ascii?Q?YPkgbXjEhnckTZGDvbElo9XqLdRJQMMDhrxNesf0ygS0IrvylKJuSKjTSNpm?=
 =?us-ascii?Q?fnW+g8wnEp0EuF5/DZ+ba7vaKE/VsfmHXszb9GuhMWrsFBaK1hg9GwR+GtM5?=
 =?us-ascii?Q?Npw0yiGGFf3tvAG7OxLmyStY9rBBeua2MAbcD/c1ORt7yIqUcTBGLJ1ws3Ic?=
 =?us-ascii?Q?JFlfblk2AsipeT0GDcCWceJd08T1c/mtWp8qob6c7KZpQWs5gik+/dklbtSd?=
 =?us-ascii?Q?HdJjAaEFunKPeZf9mnbvEqgfd0g/FGBq/BP3X1ag?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c346bdc-71e3-49b5-d6c4-08db5d8f4132
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 02:16:46.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdNCfgoi4liSN4eOVjNVGL3XxTlCIO7kCbnfL9Mf8LCr5e3cEDkMjzLnkpMmcru6ImjTGWeOsZgBkPtqp4Raug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7466

This patch unifies the three PM get_local_id() interfaces:

mptcp_pm_nl_get_local_id() in mptcp/pm_netlink.c for the in-kernel PM and
mptcp_userspace_pm_get_local_id() in mptcp/pm_userspace.c for the
userspace PM.

They'll be switched in the common PM infterface mptcp_pm_get_local_id()
in mptcp/pm.c based on whether mptcp_pm_is_userspace() or not.

Also put together the declarations of these three functions in protocol.h.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         | 18 +++++++++++++++++-
 net/mptcp/pm_netlink.c | 22 +++-------------------
 net/mptcp/protocol.h   |  2 +-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e7f944d09fcd..f8c23d6a0d3f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -408,7 +408,23 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
-	return mptcp_pm_nl_get_local_id(msk, skc);
+	struct mptcp_addr_info skc_local;
+	struct mptcp_addr_info msk_local;
+
+	if (WARN_ON_ONCE(!msk))
+		return -1;
+
+	/* The 0 ID mapping is defined by the first subflow, copied into the msk
+	 * addr
+	 */
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+		return 0;
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
+	return mptcp_pm_nl_get_local_id(msk, &skc_local);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2f58ab49512a..1bb8e7e9c54f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1052,33 +1052,17 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return 0;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info skc_local;
-	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
 
-	if (WARN_ON_ONCE(!msk))
-		return -1;
-
-	/* The 0 ID mapping is defined by the first subflow, copied into the msk
-	 * addr
-	 */
-	mptcp_local_address((struct sock_common *)msk, &msk_local);
-	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
-		return 0;
-
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
-
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1092,7 +1076,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (!entry)
 		return -ENOMEM;
 
-	entry->addr = skc_local;
+	entry->addr = *skc;
 	entry->addr.id = 0;
 	entry->addr.port = 0;
 	entry->ifindex = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d8c9035c44fb..1eb555094a7f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -933,13 +933,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3

