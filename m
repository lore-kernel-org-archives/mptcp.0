Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7C2C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641913588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQ150jbgl+Zcg8nPbjSC4I8hrD3bN28ik9AaUB4kV1c=;
	b=VvU0e/hGd3WRvB785kQXqbnxrItmKzWj3L4K6oGuvdp2VL1GitR7JXNtQ7ZKRts3geaRjX
	lVP2x4364OrTrOnjNNLml4kazjRp4EoPH9IulBMd2aBhDB/gbblPNZ3f6PgLY5eT8fsGUC
	Zg7q2eQ64vzafGG0aeygagweub3AcWo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-wqJ7JX8oOBuQdBNHPJjC4Q-1; Tue, 11 Jan 2022 16:06:27 +0100
X-MC-Unique: wqJ7JX8oOBuQdBNHPJjC4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTzBDCpa4WafhtyBv/Le5JTbK17YoWDEUP2ldykERnjCufJH8oMlI/Tu6umYcIyCHnwTw+49+5qNySw03avc6a95LgklSzb/iNtEZ9ZtuKNDCFRQWZUbvp8pEVQCTyJl7H4akQFaDlqhgaS7BdYjVyzQK1jilhDDIqNOgK4BOJpZCufisJ5akmnxrkcg29XK/1QjwXNNJZmFF+7ccAKxyn/o0WLI//Ke4Aty+9+KPbYkAKX+SHWU5xGVKRj0wwlnYGo8ZaWNdLRKVbJUNbiYC6K37ePEv8IWi9WEaXcWeoz9bB96yRt0MpECM0P+Bocf6b66/PdoMzYx42mu5Mk7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0TG5l8hUGwcBBFxR9xkrGpbK2dNO3Q/Ay3//bdapoo=;
 b=DsYDCZcAj0deYTvJcwTA6d7lbpDYoSB/3cI/5e8SBFQemP6Vl1cN6R0R3Lr3SAa/gWLQ9Yz+lnX22eizU0PigxlaZcr9dSPCnxTgymTCm1aRp9J7MqrIssDQQVaRGkmkLxTsDXvbtK3XreDf99TbS5MwNcZEudqaSQoIEtzv2HaUn6j7ZdziRBbQbFR6fiKaRKnCA9ItS384RqGLOHlizECmqstRWCNPUCu/JVJz6dC4QgnUtMcUhl1vHOctdZY3St4B2Z9DepI5rWbpaAHCFwEIEDXXQnpfTDwuyJvBXRBCMXFLec3bDnxWYcyPWKjHbmIbr6Tuec30VtpxXjEsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2458.eurprd04.prod.outlook.com (2603:10a6:3:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:06:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 15:06:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/3] mptcp: set fullmesh flag in pm_netlink
Date: Tue, 11 Jan 2022 23:06:10 +0800
Message-ID: <6b320b4a008759cc851dee72ceba693c8ff7bf52.1641913113.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641913113.git.geliang.tang@suse.com>
References: <cover.1641913113.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5bab8dc-275d-4d3a-3703-08d9d513f07d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2458:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2458E918EA6E3ADEFA2ED0A7F8519@HE1PR0401MB2458.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jdOg/loho5x1SkLkVh5Oj7c8+DK3jRB/Dw0K3lha0H+vb0/bbMAA4b1oJoi80II1b6iDjYko+FJrFo2a4LT1k/ndZRDrgT31pWF9y95+9SVqc56roKsABXqNGhllvW0XOHYz5WfGCqd+KmCUQSN0FJIgvgEIfBonCvE+phARPLne23PZCy3AfXSLXyXosn26toKbT1zMZDS79wm9Nv7HcK7Mx59OgOVgKOb/fcn6/Gr1wZ1Y485fhJWDymkAXEUuWFfcRq4cZ3rYGnpIvtNK3IUliJND54dOOTXeihsiyhsZjMDRtX+jhpYqozozyHPPBcakmz06qh7Cpjot6QwkMgalAha/TvN2F8kJtJH/DrmDF5joCN6g99luN4E2KQCC8l/BQrBAjsE4HLxgvpSd6V8K7Wvdh7RA2/EFSJ8M7SFSa7/7fb+knE+tnyPI2+iRKtMt54JXKKZm9+8jsWge85YZE9+u3icUkmBW88bfKNt1uyHPEZlA0td0zoPpJZziIgSFTxHN9zfUySF3pcz43PQpKfCalabprOWjPM1HSjQVQzXVqcK7XRqeHNfZY3l12gQ1C1JJQu3cJ78780oaWCTwJF0M3KSikQ0NUftS6262bTdLDjJzoB2AUFpJ5kZImBF0066IXloe0YqW09M4tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6512007)(66556008)(6486002)(2906002)(6916009)(66476007)(38100700002)(4326008)(508600001)(8936002)(5660300002)(107886003)(6666004)(8676002)(44832011)(186003)(36756003)(83380400001)(6506007)(2616005)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZ1ZyqtQaGjwa0c6glUpzi1hiRauZ9YlaAnNUioznbgSYmV9LNG+X49YuOlX?=
 =?us-ascii?Q?w33ZQyE7zJ7pmPthgw6gjooDjypPe912ypG2b/HEaWBmPqLAI3dEDhgI2CFD?=
 =?us-ascii?Q?06f58QmfJ+MP48w9oCE71UQLH9BWtCl13xrQz1vJL6SrwAvXKJjy37KDDRM2?=
 =?us-ascii?Q?QRV0wMB1S9bUnVugul8nWz4HMPfb5s5xseeMilYq31eewEhd2agFuCT5WwzW?=
 =?us-ascii?Q?LRhWNstpI8Va/nVFo/jrcQGqann4feO36sgAnLxQZylmfoMy7+cSADTzoSMc?=
 =?us-ascii?Q?sR8DatfU3AU67P8zEWvqxNuySXY3Nc3NSS8blTNnTAJs+1WjHCJImVIObutW?=
 =?us-ascii?Q?okdi+V6/K9bZbT8HhKr3u+PzTO7gIrHotJpL2FsKI88juYBwO6yFq9prXO4w?=
 =?us-ascii?Q?dkI4X5mD/uIJKFRLP9ee/kIJiqIdI2zP230KFV4QW+tvy2RHwcCijQUXdkLH?=
 =?us-ascii?Q?J9QjOEs7ralLL6GWR9FjPx/RAi20EPFpaRHMcykNrme7gcrioB6EY9YSE6RF?=
 =?us-ascii?Q?ICxcYfoG4sczveVMP60xAVVOUTtKLp7FO/wJ1ry1fN3pv17rLLMebv4XvI+u?=
 =?us-ascii?Q?7an73uC20DDJPCouZku6cczKC9Kk0nEOvYrLnJVOLUjYfJXo943S2fR0fode?=
 =?us-ascii?Q?tJij+5MOB37Bi8ES/6hCrl7lYlGUdJUHSac1xV8iwZVlqSS49rXls9mjzr00?=
 =?us-ascii?Q?n9ANs72Fi4ENVyP3mUyUiVSoz1o9uU62paHtfL3ylNiNA04KOlkcr9bzCyX5?=
 =?us-ascii?Q?wYqBaMvh31BtSHzyz9sRPXIc60iRk8/gWRcq/QyGqENeiEHGNyHPwmRBKMbM?=
 =?us-ascii?Q?Jc3UHWKRC1HSwVR7W706C+JWsdJYDSJeaQIot9hpps7eJ4Bkpc+5K7T6lBW5?=
 =?us-ascii?Q?O1LKb/Fvk/VTLpL26KrE9XkJV1X0jwdJtpLheGwVULkVJYJzDFL3Z8h7TQd7?=
 =?us-ascii?Q?0FGEo6qV7pOWuRHLT7TukEwbOPIM6VngqcWo0rSF+E0NokKRj9Pg5swh23H/?=
 =?us-ascii?Q?ixXT/NbSH+RvGbkSSveym/HkQ9C069qKkWaG1W1oBT6lwHqlJbs2ddwWULKP?=
 =?us-ascii?Q?CM1gC/tc/SE33R7GukXkZatFuOr+Kb2eO2Wz3nlmvr94Y1/XO598jzaDNTjD?=
 =?us-ascii?Q?/GpBF0qzer1JGnlEUiFPum1JogRhjMWCi/ab/1oFc7wODc5dIijI3bg+L8B/?=
 =?us-ascii?Q?/874P0ShxnCASVZ3UPpBbTNVMZVDKz7wlnVoRfKQ/CDG59TnUrOJo6qvEeBc?=
 =?us-ascii?Q?cxL2D1Z2ysKcDYFET+CjW5gZA/zFTlSRe+Ua8MBhheS61cVyLr5aCvJbTODL?=
 =?us-ascii?Q?MMe+mRvzCF1nCg2NclhiOR0L4zacP8Tg0hO8g7AxzduBIbDOS9aAHtizMUYu?=
 =?us-ascii?Q?IMsmwR2TbH4OSX+9wbVR1vs0NMFz++zUJaschomZm/XlpHhF6RxsIZAGZAMd?=
 =?us-ascii?Q?4BvlOd9OGyl2HPX7klPe6EVvX+3b9k6XQ21bilTadECiqHfJVhKYNHCC3RhQ?=
 =?us-ascii?Q?N6CocYxe3M1lDdrYL5xIsQO0ZT6j2bm1oPoly4RWgh9rQ3+ZMDxS4gZ92hUT?=
 =?us-ascii?Q?Z0Hd+zDYeNrRHXfEXEosMOfCksEsioVlDiAeVGK9TL134GRg1shV2Ea4hHM5?=
 =?us-ascii?Q?Z/bIrDMFBUHT7q2j0egfxvhRWrfA77UqUyIGKzfUiASmzia88PXVFQFM31LO?=
 =?us-ascii?Q?D6hXFEUMAf3o4rC6JLGYGNwszt0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bab8dc-275d-4d3a-3703-08d9d513f07d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:26.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWbUHnOGpwBpJ9asyIcp2Qhc0YnVdaSGsGKjK9KH8iOfuH5L8lYQv2nTy1mV1s/+K2L96gKJ2dYcAZK/r7dCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2458

This patch added the fullmesh flag setting support in pm_netlink.

If the fullmesh flag of the address is changed, remove all the related
subflows, update the fullmesh flag and create subflows again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4c06cd6381ef..ef1d58373ef2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,7 +1722,18 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct =
genl_info *info)
 	return -EMSGSIZE;
 }
=20
-static int mptcp_nl_addr_backup(struct net *net,
+static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
+
+	list.ids[list.nr++] =3D addr->id;
+
+	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
+static int mptcp_nl_addr_flags(struct net *net,
 				struct mptcp_addr_info *addr,
 				u8 bkup)
 {
@@ -1739,6 +1750,7 @@ static int mptcp_nl_addr_backup(struct net *net,
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
 		ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		mptcp_pm_nl_fullmesh(msk, addr);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
=20
@@ -1757,6 +1769,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct net *net =3D sock_net(skb->sk);
 	u8 bkup =3D 0, lookup_by_id =3D 0;
+	u8 fullmesh =3D 0;
 	int ret;
=20
 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
@@ -1765,6 +1778,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
=20
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup =3D 1;
+	else if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+		fullmesh =3D 1;
 	if (addr.addr.family =3D=3D AF_UNSPEC) {
 		lookup_by_id =3D 1;
 		if (!addr.addr.id)
@@ -1778,14 +1793,25 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 		return -EINVAL;
 	}
=20
+	if (fullmesh && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+
 	if (bkup)
 		entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
 	else
 		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+
+	if (fullmesh)
+		entry->flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+	else
+		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+
 	addr =3D *entry;
 	spin_unlock_bh(&pernet->lock);
=20
-	mptcp_nl_addr_backup(net, &addr.addr, bkup);
+	mptcp_nl_addr_flags(net, &addr.addr, bkup);
 	return 0;
 }
=20
--=20
2.31.1

