Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9727DDAB
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PwNX2aJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8q3GZaicmpXF9izjlGqsQqaNv1lJLQLeHPmF9yQ835ERL49fG6qTNRAKBDHnNpxVrLzjCutpsWbwTBr9Ir8ZaW7MfTpCaHnDzcL0ylxOTiNDDTGlPnj4AQo6CTGT5jLxQgdRHMG/yYpYwmPrwRru8lfBfryTdNvfXLY8z0dfNURrP7PQUJUSnXIpAmLhCN4Vj97NVlhTP/YMlWyAvxi8zx3SdT4b6hjzFMqVAFvae7nX70S2xq/7y60MQdXkam35AaxaLxH3cVESaW3QIQFC+GxErAvFjxy4L5YdkhDuKhGdT24WUceWRrZwYSatjo3kfJBMyRMqWRsLId3BYLU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny/YNTV6iAE3ls6l5bZbWBN4WsGQ64owh+fZYjVRzZQ=;
 b=ighD+g+Os69O47UK+aU1HAuzv+R5zC9hJb6FX+FkUUzO27euP+8Fv/psb58Mo12TfQtmE9jJzpVCyWd03RKh/4fdzvcZ45AHnzIHAtGYISdH4IhMCkf7TTg+nD3vr1meybOeKsgr70bteViwpmnzXQYQYdU2f3O8bKrw0JSTfQssUUOyKdmR8iOXpld6fJWscFPP2e4mP6RGLdWLpbW00yXYIrMgOx9jL+WLcZPUZuQIQLjCn4Xk+hjoBX65TmvObsJ59iaYXdInjd9heW6tXMGqb7EAeQYW8l6+ppCiCwAmvyUOHkj7X1164oyDMuzLaBflF8ZBuCR5T3QNo6hJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny/YNTV6iAE3ls6l5bZbWBN4WsGQ64owh+fZYjVRzZQ=;
 b=PwNX2aJ7R70x2dAkag5SJIW4BST7VwsQBfQ2Lq4Hn4BK+kqYx/N+d4lVvPOksX9MNL0yT0oRcPlZENycNK5ftL0jaF9sPHay9uU0+LQf9B5NmlACK36lhOzU3WmWNZED8anR/TUbtlfKFpzc3qBTndvl+QCv7zCMpYu7fK0/y2G3ty1Ag0Ag/sOpJSecEhXnAhmZFKYYrzohpIJe1CDOuspQc6u/9tdaLwq+LOlgUhRpzImNz9JVqhaewl2IaS15/IhYRoOo/kJO7rdCmSceaP4O9ESpY11FgYGbmuRMRlgEMSpkNu48c9q9QZF5XpFThIP5heTBZQxduS9ra5Ai7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:14:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:14:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 01/20] mptcp: export pm_nl_get_pernet_from_msk
Date: Tue,  7 Nov 2023 16:14:07 +0800
Message-Id: <fd6038331ae344eb374079213e40e975da3ec986.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4053086b-5ac6-48b9-b492-08dbdf698fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qq61bagK7z6FLgJ9gNPtxGu79mWPFfShn/YODKxiY1WTcyIvJK1s94apuz1Fg4sfaLN/TI/QUzG5R1ZNcurKuTW1XslPtUBTZ2i9hHsvlOsUG525YqD5MkKoJMdMzp9NoUhORiTCEzXe5In4Vqg3OhIdiI1hpfBJVpAaM+g4C/uk6C9ruN68c0Zp9ppyqRQTRJrPZDZLpV5ojSN1JMaTkcToVBm/d703mw97MHmt/H/x5L3ap/DrI3B7FrcfeyH69GBBZ3x7tNeP60q+tq3bBYnF/cl0Wpi0q0G+QUQZjgKTXvxkp0pjGradkbeAZG3S0hZHnAez1lqJ/7z73/1FvXQqsMgwJsTJxuhiyW621RqDsQrRwRByu0vamYKHdO5WoCNMeHP6iAdBQRXrXdmdxorsF3PJVA5vNM/PeYIn1LHKZI/XS4IGKoRkTNlImaGdyt15P1+k1opsKHJaXqKirbaJLxVHSA9iMGYEhHyZqOQxDalzDv6wvHgX0V5ym3Mruvyo/+8mF1IWeMlk8bTYvm9e2ZEqSRrohsUxe+6M0t8XnaaM+xsC4eFI1l3zLUkg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LR7E4kb/upDruT0xPg3JhdlzVBoXS0/3V20P5elaIz2Pgq0cQ1hxmcSkWdO?=
 =?us-ascii?Q?6uhCXEgi9qhHZxKlovLHplDAIdgG2h52+JTEVIyu9bijL1SbWn+rrugK5EXZ?=
 =?us-ascii?Q?Jcuhz1WJIDacsXy6BA4hJWLbEosvNPoS1K+TaAzhYGhQNmRjILAvO00V4RsZ?=
 =?us-ascii?Q?3qy2WkETfmX+GOjbhib+noXf40lyObCqZdt8WVqq0Ul4LJdtzFxL8/1qvCQs?=
 =?us-ascii?Q?SZroeBNcjvYMvycHEbDTAD27vfZCdN+bfwQj4yu97qqVJ59tSDdadk+D2jTA?=
 =?us-ascii?Q?AEb/jCkkHpmX4do2gYeNaxnpz4at+ksKpzOax09VG3qr6y1uHsOceQMumx2a?=
 =?us-ascii?Q?JlfM1WIWrgHCjOu1YFsM/wFnRF8gddPXQdT7EbjA1pBItMqYPY3CFmKMcrLN?=
 =?us-ascii?Q?YkWtVebV8Gl6Pj0tBKVgc/N8NgY/haUuuEwnypKMTgoO1Vsgq9UZzOczUGcm?=
 =?us-ascii?Q?o9bdyUju/BZYsML3eKHMlNK87WQAUaek6/BhniCh6G3Hvo4KhMAF0hxYzYqb?=
 =?us-ascii?Q?NcCxY6bmc/fOi/2ysDKSArHE+s5wqAwbUu1G4iqz3I7+0m5r9cCvFeI55Al5?=
 =?us-ascii?Q?A1iDQz+h///OSrsbNSi6PtR2CouJOfHfWfsR6B17XJpl20qpbv6/jpm0WBNp?=
 =?us-ascii?Q?HvDwrnEDE0FtY+vo3gImcSZOS/RFT3fvWoqVGrtsXOZkZW84TbSwGbfGSBsR?=
 =?us-ascii?Q?YPVTpJoqbi9jFL9W3Go4y+GUXjcyHlSI4KcqYnQyrY0IynZOhCOuXBpk2eED?=
 =?us-ascii?Q?CrJA8QkNJXTgBcAfzUlgakG/3D/CieVv/1OtvxvVMsA5D8d2895+qUHS+vNx?=
 =?us-ascii?Q?MVVfmRzuu54jT2QECFlG6Yy0qqc4+VJdsLyjRFf4JyZwYeRuKW4RDa3YrUep?=
 =?us-ascii?Q?VcQMw85ENe/+Z7E0IJb36KreyjZlTLkYVLbdMCBxj/ZImyU+ukTOzeGpLWY6?=
 =?us-ascii?Q?O/FZwGBmZKXJFN3XoIg0wUrJEwKsWgeeQQUS8fdUUvSkuUp4qxiOwTh03hoS?=
 =?us-ascii?Q?tEVrmb/xr+ZdGpAMOw+Zbg1wMHfpHwV/V2Fc2+sK46nSqWozp7QQv3Yq6YHB?=
 =?us-ascii?Q?XBeeX12gKMA9890Y47f/fSpqtMNDXVQ+Z+vernj5MQ7fzAQILBl/ctxMd5mc?=
 =?us-ascii?Q?fdnv2vG7i7KitYP0HEh12yiJ5X6Ah7RCE8FfgYbvN8Zg2dvYuGIox607QVfW?=
 =?us-ascii?Q?xMSjBRjfErASZRjA47QrGa4GBQ9F7hZQ9QCwuj/jfN5/NdS42n4LPDn6I18H?=
 =?us-ascii?Q?HzFo08SwG8Eaz2iyBwdyXOYPji/SJevJwDm0SzB43jECUucsEOrVgr637xLl?=
 =?us-ascii?Q?V6mycWa2QulhdoTc+3JsPTnAcdiZWZ1CvAFN2/vA4bkQXrZm+NBiTwfHu27n?=
 =?us-ascii?Q?3OFXxp4gj5q7l8T1MzbQk3JUq7GUlCwnpcXoyMYWroXf5bnrhZ6YRqkfN+S/?=
 =?us-ascii?Q?l2uoMnw41dtH58Whd9pqtNBuThThGsMJMS+heepFxbiMi6LXAfhPFUsfQxPc?=
 =?us-ascii?Q?pvylq26Oo9iRTj+q6jqs5SIczRHKd6zeKBI55rmfsTKxWNxjRjlCtCOTehhM?=
 =?us-ascii?Q?Y9ZmvzOc0XyzkltsW7DQR79YqU4F0GSZ69jKicat?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4053086b-5ac6-48b9-b492-08dbdf698fea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:14:28.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf8epVwZwq2zlKj0kXsthD+NJm+OIUWTGnMSMERj3ufY+sFT7/8O3XryXO+/4KjDI3aV8qlQZ0huvzaPwO1mJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk().

Then pm_nl_pernet can be accessed everywhere, not only pm_netlink.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++---------------
 net/mptcp/protocol.h   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..1dcf104d7a01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,20 +31,6 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
-struct pm_nl_pernet {
-	/* protects pernet updates */
-	spinlock_t		lock;
-	struct list_head	local_addr_list;
-	unsigned int		addrs;
-	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
-	unsigned int		add_addr_accept_max;
-	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
-	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-};
-
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -53,11 +39,12 @@ static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 	return net_generic(net, pm_nl_pernet_id);
 }
 
-static struct pm_nl_pernet *
+struct pm_nl_pernet *
 pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 {
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
+EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..c38a2126071b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,6 +1026,23 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
+
+struct pm_nl_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
+	unsigned int		add_addr_signal_max;
+	unsigned int		add_addr_accept_max;
+	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
+	unsigned int		next_id;
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
+struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3

