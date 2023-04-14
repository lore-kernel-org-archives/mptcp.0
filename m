Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB8A45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlxgHooKYirq3dmsHIePXlof77gbuMpVr7IsrsGiS6asX/Lopu3oNqpsP0bqvE8Mo6olDUwB8H0XlM6rJtcaoX0Ped/qVT1xt0Xv/DnQBu4Yijj/7QpJjX3cyxSFjPRdNrnaBRnOv0CP6P3FQxQFx9a3PEGW1mzd88djMhStyqeL+E9WIKqvwHIntOiVh8MwWoKmGnyr0TWtRmrZZQ1+uS/gRFQFsE1ctp/qvaYXiEEGsxxliI0SxlcuDcU1Az7N07tykphzKQS6ZdIksD+r1uIW7VrOevdicsEoIV2+XTS6NaxvGmDXPAEbb/CcHIZwMarILizW3cXlOb2CV27myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ja6Uaz48Q/m74auLGtZhgYuR/QkR1M+XZeEt8OirdA=;
 b=noDw956wb3I4m6vAv1VUzE8tlO4tFBQYgRx6F7Q0+mVC9roOw+3YpUthgnd2BsBT0oBWyX3ubBOQY7HMC7VtnkLSI2rctVz7xrzlsVchr4CwDGrUPyTQcayLfwFBbfYLEu8fc2pT+W818uowq06JQY5D7lEBKg4sWDiFOJ4Vr8kQ3hOlTIei8V9FsyCsii+fRCyvhMKOVAxjsUb8H2zkSqzMeyAMJIGdrKCuRQzyiQ8G7zOczAC5sNWVBoeJkaYaDDf54MOWnGkn4RI4hiJhYv7vereKqBo6A2qzGWd1TDhSK9y3VmlpGXbmvShZpzBlHyhoRWpOOj7Q6vkb58uuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ja6Uaz48Q/m74auLGtZhgYuR/QkR1M+XZeEt8OirdA=;
 b=AathLd7TVhuxgodOsAl7RXm5PKJPl0AvGUhiy3mxl9bztBfqzYy7ttm62bRF6YYZ0GntF1MwooaE6jUcUQ5cjh+RJwTYUWI2/eQP97wMBNGrvRIfFxiPgnO7s2VBc4GXJWq2TaU4RZoeqMA3UFBCmO7POXUPoOFawIQTZwOZa/Yi6z/jF3cw0vdk1FfQbg/2LMufNCHPMpeh5Hz+UP2Rc9v2u8J2Kol3oBiCzCvJ7JYrzwDfoJKrtrPC7yUsYtgOTp4Jq2uK2wpoRVQZeI0KW4jtgxQpw9Q1jiYDfvz3yeZAhxvIo0pGks1r8LGmrIWsh9SbWoSvHYX7C9atDoDxDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 09:11:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:11:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 4/7] mptcp: add addr into userspace pm list
Date: Fri, 14 Apr 2023 17:11:07 +0800
Message-Id: <064aa29832dfa25337877f33766da1ede5ed6843.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbcb214-3841-4125-c1b1-08db3cc847fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fywOcb56L5EteVWHyUFkQAgcG3oeyF2o+sMsqlJB7rtPX/wde2C5FLmWuFRizakKtH5lZ5R0VOmoxoQiL2sgQYkll9FCiU8vpHtImC+71zIZeL62l9mbgX4EKao2xf5FJk9Ciz+T7losghdP5mHmuho/1MwH3HVwWJLZMaMw6ejK0Eh/6l9vdjbVcIxt83dPP5OcvnL2i6nsyEiAlvWWiSHFEd9WhR3MKzD6gYmwjCZkzyfjPMHyWDwVXaHUl4fEAdAlKfOX1wljKMYrWUHMRhrMMwDyWgjlpMakyB4jzOVlBD5aBFqQsxm5RSjGwvi6FENk9Ry9dOEyyZnbmgGCzMS/RyKxcPTPTR7aIct+kVlHpJNRPT/zoBI43fX8EC3f58PpBIoQ5kZA2FdK/C2dgRNc9CGNrACyVf4HxaPzCSGZ5Kcq8gSkmT0NcGbLzsno+Lws4VIhyGl6DY+IHdrItMafx1U8IjJDbHK3Ps3MOnAgpQ8URiqexOlFTJtqMn7eFmwuaQy4+TXaeVeCkXuVWpZPFU1RiMc/UfN7z+S2Cd/zubEW2bfsiu6LCkBPYeoF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(478600001)(6512007)(83380400001)(36756003)(2616005)(86362001)(38100700002)(2906002)(316002)(5660300002)(44832011)(26005)(186003)(6506007)(66476007)(6916009)(66946007)(6666004)(4326008)(6486002)(66556008)(8936002)(41300700001)(8676002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sr3uAJFWOR1EdUSpcvpBKYWSHdiT/piAKb6wygFFB++oSSazBoeocaZz3bYD?=
 =?us-ascii?Q?Lk7Isc/7bQaeYAeeYdCCVVW7XnVl93L/qQyQaiyamyZp8ANOds7/KXOZFHzA?=
 =?us-ascii?Q?0n3wsfgZmzmpoPoUAOATzhZ/2APJZUmtlhkKRFI5kZ3HV8Z1wBtPJy8BvzUw?=
 =?us-ascii?Q?T7pZWRx5dRRpzO4WxMFwpXu5/zCi9Rqv4w0U0SucbfxzZJd2Ta4uc4jyLlhE?=
 =?us-ascii?Q?NuPgJ8FHfeXzyShoQK4bv2Wpiah5LarePFJMgP0vnebdLuEVJxDIXhlKqXTN?=
 =?us-ascii?Q?3w+IiiG3XQXvy/t8coCXZuHhnbo7RyDnFv4jnxTREUL2y4JQqAH58T1rmxbt?=
 =?us-ascii?Q?gFKAVcLDHMPibPlYqfqiFwyJ/Tm67P1t6S9oD4uWdi02f7P+OFt3Pnfmgpr5?=
 =?us-ascii?Q?j6J65B849PWoxbnbBVBhWsKkbo5QeKF08P2CWfPj9m2LuofiDCHmIREDhots?=
 =?us-ascii?Q?OF6+LWbHxDfoLfsK/wzIMjfRWPvdBC9vB/1g9rXR9vRRXAQIeWcBCR5n+B1w?=
 =?us-ascii?Q?jW8HcnKSfbEvyBzkIgGc9tz/EpgyBSMIhYpPGP6aCn2+yOFPDKjkYuV4A1i7?=
 =?us-ascii?Q?Dh2NM+6mIGN9zIcSAiUc1rUT/dgsj7NA/oouQ1qZlWkYoH7eAG+glV8TPr8J?=
 =?us-ascii?Q?RA6Y0ajj30pKHCqElq9COn8ayMbFrt+Y+skpU1TAZn9KA2cmeO1USuuAYQ3z?=
 =?us-ascii?Q?k7IUHpQohAGVUNUIDlgyBMaELvTAlSmAqWb+7X7kX+Es6OiCM0QPQa0XgeNC?=
 =?us-ascii?Q?4kjK67+Hgp018j1GrSgJnzBQoz7BZ/DZUzUpklSDB4GF7zIcQgjbY9z5bLRj?=
 =?us-ascii?Q?KcRTvgttR6MMuCsEbKpnntYKrVwjokBL+yRhjDY5gVIjDU2EqZeWgC8VhWDx?=
 =?us-ascii?Q?2DdRNbKqH7Qsc8BS1vqtyWJAYMA2mOAbpdbS3yxsZm687WD6V589WFdGCet4?=
 =?us-ascii?Q?pY2RIfR9cq3TR+ljYAOFFBL25Awa9s/1SsZhxwIYQliEKlar7OCP+jvL87ii?=
 =?us-ascii?Q?ZXDgxaW/ORrcFWnMTif/PGH8+EYw54jeQP/AqOLYuX+ZbiaPoDQN74TXqJfd?=
 =?us-ascii?Q?14ACxqaSfRuUD6QAMO3QSXsoJtLeBFGFCxOr8ZjEkqhf35Wx0nCB8cwlFq7Q?=
 =?us-ascii?Q?LpIgaFKBpjSAad4JlooCmV3fyRhofVDdUqJny/LbsITmS00aaXTdcIsu8+Xj?=
 =?us-ascii?Q?TRUeBtUAuyHEEMl9vdhYuUURE++DhKqvI34OrYVKbr9UiXEfPaPmJm8uG85F?=
 =?us-ascii?Q?Q05LbznxWlDMqHwgG9qyUkakErSyuNGUczAQfchqKD0eT/GG5J6OYgof+2lH?=
 =?us-ascii?Q?L3DgF9Cwk81RGtSZGKcUcCzTVkceCpOYNTq7KN4nMJlVF3Zi4cr6o1VlJzOn?=
 =?us-ascii?Q?rGbikgTeOC+8t5VBlFUwGNri6uq63v4MgHtuFXqW9jASd3Lj93CI8vKSZcJD?=
 =?us-ascii?Q?YQZPQTpYc7o5V4bavztYq5w0QjsYqnV8cw5gaIdhN+K0Xn86GMNHyxpz3+qg?=
 =?us-ascii?Q?e8RxPWsH8Rp/RILoIdKTG2K1cBu8J113SO2//GJkik/j4AkE1QzKaHBJ+mNh?=
 =?us-ascii?Q?6RK9GXORQp48SMWlyPqxxh+x+joN4p2tXSuoVQ6a?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbcb214-3841-4125-c1b1-08db3cc847fb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:11:50.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qmj5ALf5cv1YuD0bzmUNobGTHqG3b0JWYiFvzC6uHio9Wlu7zlpCyFqHxb4/tgYfqC1WSHZjDPjjLzWL1C/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

Add the address into userspace_pm_local_addr_list when the subflow is
created.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 312fdce174fa..99a3968f38ac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -301,6 +301,17 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_alloc_anno_list(msk, &addr_l);
+	msk->pm.local_addr_used++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -419,6 +430,18 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry *entry, *tmp;
+
+		spin_lock_bh(&msk->pm.lock);
+		list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+			if (mptcp_addresses_equal(&entry->addr, &addr_l, false)) {
+				list_del_rcu(&entry->list);
+				kfree(entry);
+				msk->pm.local_addr_used--;
+				break;
+			}
+		}
+		spin_unlock_bh(&msk->pm.lock);
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.35.3

