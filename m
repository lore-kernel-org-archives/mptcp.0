Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71311CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vvZlv9fl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jadeqcXBhpk/zlO5QIg7iU6cdD8/YwkYK1gZuK0dKZuvZGeZ7B2RqO4ZH9ftb9ZswWZOweONWd6RLd+ZxBawN4v4YVKc4iEitQytCSSMpN/dx5QWHH6zgGl5TxSwHLmai1Rw0OhZjF4efqU7tGikQTksdXgS0GZQfEeRN8x3ixTo6CqJhG8uTO/8Jx3USTbPybGbdXUzBpxTqZd3gUzC3D6t6DIK17+lbxV1rU3RFtOQxRHDSWYEav1ow6SpkKWmEbCbMRZxumr/Bp1XNb81jDarj4Hy/YZjOW40X5fe6xijtwV0ho6ULQLOnr2s1qbpiL4uPhIiKDc1F8r2vMzRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W4siDtsD4ZQBVeJyE3H9+b9FxO7aUsgZwDf4zyMnCg=;
 b=lawH4GegAcbbzKr5Da7L/PzWDexfMp7kXcLK5ejIHIUHDcKuR+03VUByK4XeyLG7e+8AP/7cTTbA+rLze6YLJSkHMUuIcgmudYdh8VI9UHU4sGpH3ra9Eba6OfGBy/I4yikdSS1wTw+ZbpLnkcLmwGlhRnaoqhZRiKB4IroXWcg634sPLoMqIx4o4kENxjP1WMRGCB/9mnX9cuoXPqRl7R5mQuwwS6ppRYN6Pt/XDXKUE1jzr+EZL/6n+dkP21D0FSCVYtSiR/fTjtgm2IYwqCezlaVrrjgRlU7BO9OQkgYPpHV1CBm+gIqOvwEApADLCFYKjnVYrs7MoBFJL7iRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W4siDtsD4ZQBVeJyE3H9+b9FxO7aUsgZwDf4zyMnCg=;
 b=vvZlv9flSZuYRst5hH7biKFrOvXvkr25dNBKmBG06pBbQAYbpDwvV2ApZk/96YcJAe987BiYiLX2gwAnUnkvDB2RMpZ7eZkGKTQZom1jryupPCmus2O9z7NDvwvZdZWdTmtWmSPQwbGbTTRBxmYiziWYFBTwLGFMzcb0GvgbiOIHllOHM/vt/Q2n8iM5aOWZGtD4UqpR+aq66KrGfj5DJMrQcoFN/R9wgoKukOSCLJqBvUCNpInZ7H5AzaBQcR4sfTPl97Dnqrs974Zg09QqL2yT383JxQ7qbFEfHpJhO6iJlJQOLjyNnsPS1AowhgNbQrA8Is2yfFTqVtE/5RYrKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:51:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:51:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/10] mptcp: drop addr_match and id_match
Date: Thu,  2 Nov 2023 17:50:47 +0800
Message-Id: <075b9d335c4b72d0a96d53ae5e7c8c1dbc5db04a.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0179.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da111fd-38f3-43eb-4f56-08dbdb894574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P4DIhO2JXkOKNstLH8PNy5DBktf+SA9HjhdA0stp3zm5SHxVKFiK/sboZ6F6DREnw2w9WTw1D2/10BWdUQqrZBezPdOkzAJHvvILQkQP7cUPNfXiJCYrN/z0180yMdv8+xcP2cq+1HejtKQvJn0NxDgPV9zNXvur0lU/AT9KTFs2NOkemflm0JJeeiwZNEkf7S44k/YvGS8RXs5Qd9GcuGUfNS3swUCIYYUjPDqlqT9F3l3L+aDSAYDKQ9+nemlOw5/GBf1qsZHSAeLtxJX68SR9Wy7VX08D2Ec8mwUK9vMHIKkzZzVVMFDDcazwJcomFrd4fzvWxg4+7pgpcgkEaWEj0WC9gXeE96nE3pItQ163pX5LA6V8v6F8B3CIMkJjtyB2hvkKBcdI/i2zrGyv8taX5120OSX8ePqgu/068DKZim7FgFsb3ZwEEY6vSCXXfOeXiiRPUUrTgMVEFz2W8BnVZOCO0pvQJ8ZH4A9BpGFpljZzk4t+WheDpl/vEP/MgJPlmyDeNnJ8SyKnboIrV05exwyszjjZWnj52S+sWBSh4ByerQH0SlreFhYKzRDrV6udI3Ek+SudPrRSFz/f2Ey4l1GrPy40RcefbliCu7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8T499r5//To5wq/hpOuZWo1AeD07kTUTmm+OkYS/M84JLxAHnnex+4yh+D8?=
 =?us-ascii?Q?STXZACBX/8X4GXCzvhGAADhD/MovkEeEIatVQeo3BxCU9KMhLRfD85Fq6jb4?=
 =?us-ascii?Q?Pboi3kl21A9lBacOkteERmWgtUEDlF5P1Dkp2LcMEF1bkxQaMud0z5CVROVe?=
 =?us-ascii?Q?MFDe5PB8bZBdwxf6NPeEInzkZ/N0lRfUn+9A/kGPlSoIUxG55PXxf8A66pnA?=
 =?us-ascii?Q?b4Q0p8u65mYdMH/70O0m2QeMpPZiFFzDBmHKy8uyZVLdBVTMkcbpqUc3XK6s?=
 =?us-ascii?Q?Wv3PalzoHN348dn+ga5kcf9Rwg6fj5I2tEjhIS0sVfO6+8gXE2VgbWBeZiIl?=
 =?us-ascii?Q?ZneOTtzU/eCEkwPy5Uz0wWcgJY78QEXTk+z7zwgVNus73jV0jLOjMS5gVZFP?=
 =?us-ascii?Q?ZRmu8UxCWu1RfGWBLrD3kp0HFoDdBJBrMGjiTKdF7xXtw/G9HTUwn9AKBDfr?=
 =?us-ascii?Q?4qYx6nCfY6oJvPovuzCUoRIv0H3mHWZ1C0RvZMiaGOM4cmZin+lmUjNh0VVl?=
 =?us-ascii?Q?QqM1RcARTuhkTjiFXplEEAaKdB5BQMj1pJ7D0JJAyBO7EsXiA2G621e8tWoW?=
 =?us-ascii?Q?xG3NiNoIPk+wc5EO674PKAEEIUyzd/SYBCd4llNPd7r5mRPCCKXRwvgvadry?=
 =?us-ascii?Q?5wE4uarfQl86Y49RVAC9TtdeAf+f6qXg+Niv0UV0Y4dBUfGS0Eceu6JIM7JH?=
 =?us-ascii?Q?ILO4vt0VEGM/IhtQFupSurM+KRVPK6FLP4h6GkxUMb7Os6lOzUI/nwPndIIw?=
 =?us-ascii?Q?zB+nZQUmE5xkywOE8fT041NkDi6pSd1jHZccy77FAe6q+cOn9qm+A3ihiT49?=
 =?us-ascii?Q?GI4WkNSF6aVHgqquJlCYLh+jRu5qRJ5DMPVNs2fJhpk9JuKdbAgk3/7F+6HY?=
 =?us-ascii?Q?nnayo11XaAnZGnRlMec2oCpU6xDvSorOC0fc0lET8WH+jgJ7qLyKYOuD9wBO?=
 =?us-ascii?Q?Fei29C+sD+Io2o73Nir9v2+Fl8cGxYEH8GnmKD3pZzKwPUKSh38EkDwEUn7a?=
 =?us-ascii?Q?AXNhE54Qpnc9aH+FhoZOFbMO+54RuGSejrkPUMIO3p/xwpvL1ldQHgZ8syF+?=
 =?us-ascii?Q?f3CWSV3TUDtLQLJFjRIZFoUhZwNOlizwWAYBTYydgPmcK5ah/HjkVRIM5uUk?=
 =?us-ascii?Q?wEB6MhCSttMM3nWnaqZvhPPh4Wcg6eZr6jC4S9Rjae+0cPw/ssPP/AF2W5Qs?=
 =?us-ascii?Q?qGJkkuImjb13ScpDdccyBJWgWRRX0aCf3Glpwa4prwDSirO4mtu7ezWynXc0?=
 =?us-ascii?Q?WOIs3MpUi/4ZxmllVFMmLWpGth3SRypRs/MzT+P2dxm1SX2HY53OBPEh7JNm?=
 =?us-ascii?Q?1xe1CxDg0e/CZu2TebmjZc1TcCmqAwns5PJWAMA633tUIIBK42mz7m4CxX/z?=
 =?us-ascii?Q?+fyJID5oPRzoZs6ePIgcsOaFj37XvtDHIoHzRzOgMWkJ01juEU8rYctm2axc?=
 =?us-ascii?Q?EYDio65XS91KLNThIJDYPTozE+SJRa29Io42301F2KVVAWR/7Z7MVdU09leR?=
 =?us-ascii?Q?ZQ9rdO3PKdt6G4KqYbU3rG7RdwxvX8x8EG4xTL8f00HxYAWRI0FAcClWUGs/?=
 =?us-ascii?Q?cBmVmEGCB5qtghE/a9nSeDCxgc/PL8Nd5kJM5X2u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da111fd-38f3-43eb-4f56-08dbdb894574
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:51:22.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVhTMGbHbtlKhFhf0d+coLhxR6Urkt6XKCgfmR8Onsa7U5RoORkExePkTlrsHrelzux2qN1pa0E8TLx+JRreNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6856bde6c74c..b7fa9481e3b3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -58,8 +58,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	unsigned long *id_bitmap;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -67,20 +65,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	id_bitmap = mptcp_pm_get_id_bitmap(msk);
 
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	e = mptcp_userspace_pm_get_entry(msk, &entry->addr, true);
+	if (e && entry->addr.id == 0)
+		entry->addr.id = e->addr.id;
+	if (e && e->addr.id == entry->addr.id)
+		match = e;
 
-	if (!match && !addr_match && !id_match) {
+	if (!match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-- 
2.35.3

