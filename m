Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F62C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSihoU0EtgnB00/pit+ZLSdq3dILNuWYNUJKhFe7Ck0=;
	b=K/Rglb5vvenP/yjZgTOo3xcIvRHk2Y0nx5SaW6dZIAxSacrYi/+zYxiTp/qe/0Xp1V7zMg
	LNdY6nXAdmFauHrOb8KL+on03vTIItIKLu04Xg/vDKsKrxmXuHyPyKficcjsSSKBVilLUg
	oCovdH87WAd8nVb2xWCdsZQzLaczDa8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-C-HhFNQ6PHKkG8kJtDLq7w-1; Fri, 14 Jan 2022 11:26:54 +0100
X-MC-Unique: C-HhFNQ6PHKkG8kJtDLq7w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFZA3/pQK0HIjBt/YjNjEt5FZB5t0A/IJcE2oWxZCwmmzPnDYbQujjfXi2olSGM9KWhcWT2GFDXcgz5NXt8KqE300mNpo/y09xAU9RQZLdfLEpTSPBe1QKnouNaNJ63GJBf3m/gtq7bjXp01caJzSN6JL1ZVE8RqtJsZXZhj/NDgPOZarj8ExMdbqEGmC3eNMeRKZ/Is6D0gEUQlPm5ERhyJprEXy9dYETLrdL7dYBA5zsnS3K5ur5bk2y6oDT+wi0jKp80xdkqlI6bb/nikpgyAuPdLmZeWu3a9tYV/L3Fskbzl1eNKSM9h1myFA3ODpeuEKo1PGrejffIPsPXfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFK+g6Z6N8c1GbnquCJla3DjX5xQ5KMFNlbH2gFXSDg=;
 b=Hs5rlyNC/AGqseO+CecuX1LvGteNZUflQwuIcutY+CojCKjJ37PwjKPwHeSFVK7XCDYJiDGzhB5aCPKkSPUg9c9IHpTTzVGySDQvdLxLok10wpxlkA79gbjFfhfAcSv/E4EIFdzCEWrwYb7Ez10BZkupdItClVt/gOnTJJICxy546Wjqj0eG4NqemcGRSeHWLkM0zAfGZFTSgSnYacF+n3aQdpfHuMagTBP0SSz9GE0i2K9ip7VxQ407CvOoW/SJUXEU4J/4TRZSSnG1gOu6jiDLHZ0J2BbVmNlM7G4foFvFf6f6Ku2GagPdUI1Yfmxumjnrv99dlzjEr22SamTpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:26:53 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:26:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/11] mptcp: set fullmesh flag in pm_netlink
Date: Fri, 14 Jan 2022 18:26:20 +0800
Message-ID: <73d69473106598109da2db398f9eb57ca1a3947a.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c5aab2-6c30-480e-49de-08d9d748620a
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4317B67499D6BABEB468996EF8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oTkkiTKP1mDUjlJugHjCwhAh1UMG1t+kB7wVbKqntvm16VqJO8ckRpj//W/sh75antOfGd3tditJEIwh6OYuxhIOhPS2FJLeaUKrm7hkB2tHrfOReV5TOSQ0afSzMQKXZ8b2+/syURwBBlLbL286uq6fZ+TNNsmv7VDW7344mY9A+WUs9t4HZbxtWwdkS5gZ9c0HkevmPU+MORbOffTLkimcwG4Y7dJVdWGDcmPzBHIDUCWKcWh1bG9l/6UiP1GsRLplgd8FW9g154P22kpglluU3H+6NSyle/TdUP1XuZLEi13rAwuPWI2V5maoF5BH6dJRw3XR3uXREDCutIqJxzpsFrFjbDmXfbzSPlg3ZdWruuYvb9NGqivrRpx/QYaDKQ8dbfVEtT+Bad+FS4IHtrV8v55nPiaEOgxwrsdvTO0lUU7H3Dsyce7tQKsopjMaJx8bqKqtUStD++spzCJSiXXY/ahqGF3NAJoJk7mPEzD23awUOGI7zAzaWKML2OiJa6Hsd89tazjlNzHJZmnOK1wO/VNHdIMcdBaHs8aqdgeUhIL4YWAf8GzdUKiEOkgVZlOOmaNbnjY9kg5y1tSjRfkvmEdzdwbtgavXaW3BZPc0fQaSp+rDpI14/f+OTlGNKKJUb1ehc8+eufY89rWCVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ihgqpe2Ae/aNhC/IHDiUUSSnVj/rTx3AQKenREW97L+I//HqvlKjrp+JfLin?=
 =?us-ascii?Q?tLsCbknVJQiGKRHxkipMrFttNeaWD6F65A9bF1ugnO2JiZEYcpwykgkfVj54?=
 =?us-ascii?Q?szVuF0cueURLl9JX8zo62Ix5LRmLrEqylVY1yIQSCSNZ6TPumw2I32RWsOtj?=
 =?us-ascii?Q?inpHQJJ8amZxwKlfRbzsKcdgvoaoI7LQSUXA3sqA5WAD1uEZJ2Kq6Z3ZTnE6?=
 =?us-ascii?Q?yS9pVdAhLqFig5HUGtZr+9gvGNTN1DTT1aB0Bd31GrGypQcvSdyETdoQvNeK?=
 =?us-ascii?Q?ydgXGp1JIGH/DsZja8LZOhmb9xZQjzvXAmXqFinBwkH5ZQNfLAUcG98gBxRl?=
 =?us-ascii?Q?RZ/Vej5gntfHNrWPoauxcsQI517W0zd7nZacBFsE6ryhKkmVbJULDkCymMsP?=
 =?us-ascii?Q?T8txhr0IXmqe1jqnTgs7dmnPQk3TgrqRzit+HMUU64lmPino55nlTbNFFM2T?=
 =?us-ascii?Q?xn2PewfCU/nV3RIN9oan2C3euQN0XE/Lc+Zgrzim+7m8aQPQH8zQoeSQra/Y?=
 =?us-ascii?Q?QGO2NdZTGQvaKHCQIEGNTuhurktJgdXQCFax0Ja7iffGctq/cVbS2u3nx907?=
 =?us-ascii?Q?o4CmMgLqk5NqNxxWrV9osfzxM+7EfzaEf++yRTMIX90QZXoe4RFeM2RqDk5E?=
 =?us-ascii?Q?6QG2uYatUwmD22dVlKnba7oPCuP7KNbFNJho1lRGpERptbZN1yHagg/bqIn/?=
 =?us-ascii?Q?b2wfnTQwTw8BhyMMVUnw7KTkseozuBlXHa693YM6TVBdWNsDus5kad6dW4iy?=
 =?us-ascii?Q?I89egfS6MFoqPubGyl5NH9zgkFS7wNtcdIS0fH8Xm4vxRyIyqC+zg0GkycPg?=
 =?us-ascii?Q?7P6TeWMuGAbJ6pP9JjvqQoZJH8bJagceM0fp1okESLLDHzEnbbrCSWPEQXMO?=
 =?us-ascii?Q?XVJl5mabP37lRnHHeeNJ4gefXFrlX/Od4b4iMGUmlkeGnfLGt2U2jKeWZ9T0?=
 =?us-ascii?Q?9nLIDFVUpNy7z5ZcgaBcUW5kU3fjuRnufUZ6KREUqqFrSjb4szL8Z0LxeDJN?=
 =?us-ascii?Q?zOXztYwSe7kp+Ib2UKZIJ6HFXprRVX0FX3ijKHIkmxFKUqsUG+rtqryIAtmZ?=
 =?us-ascii?Q?bNMsG3IWWBrBt+b6UfOPcRDMOCseeETX3dq31L9IrmU6ZzGl0AVVBkP+byGa?=
 =?us-ascii?Q?KbXR7sC9jkefvOh/ax7zv28Tl/sQLPPHvNfClAhWC3WWFLHBxFthkbVLywRe?=
 =?us-ascii?Q?Kc2vukRFAfkaxLBcMDv0sWF7tclTdSG36jj+kF6Q792oKfJHqsl1O6sAe8ui?=
 =?us-ascii?Q?J65uSxX7CBwgE5cVQfQl6iysHrCUCon+bpV7tYFJYsvWLOwE2gfUZi/K1uuq?=
 =?us-ascii?Q?EM3J0bMmOQuqe3afOawtRVeFImd1mmGn5fgwrZh071oa1lHuQ2K/5qJoThYj?=
 =?us-ascii?Q?H+Z+thCRlCf1yeHuG0/YKs6fAHfQUzlcPOhN8O+tyf4E+rS42IgFor9uf7jz?=
 =?us-ascii?Q?0qQ1eYRjJeQ0ak9a/xq/OJzh60FuPa5MpY4SGmVAQy5Z9/smEX/P6li53ZaZ?=
 =?us-ascii?Q?C0jWYk5m1Lgng56/xwJdYgV72ilFr6pBPIBoNVFcK5dvqkn/VVSadxZMsNmW?=
 =?us-ascii?Q?16dgl61PE4/uGGJainQ3vipEOMMtzZyqR1P9jVpoo1XE7odWeKItQfSyrI6w?=
 =?us-ascii?Q?X6Ai+uvHp50+eam/enb9UFQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c5aab2-6c30-480e-49de-08d9d748620a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:26:53.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXp+AWwV9jeamdYv8cdf6SPzeT7yJ6XBpe0ZS5E1yRYX4BFZfq9GQb2a2lgSMxCrRPODcQvYRifn+XZtDXUaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

This patch added the fullmesh flag setting support in pm_netlink.

If the fullmesh flag of the address is changed, remove all the related
subflows, update the fullmesh flag and create subflows again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4c06cd6381ef..b86bdb6cd0ee 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,9 +1722,20 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct =
genl_info *info)
 	return -EMSGSIZE;
 }
=20
-static int mptcp_nl_addr_backup(struct net *net,
-				struct mptcp_addr_info *addr,
-				u8 bkup)
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
+static int mptcp_nl_set_flags(struct net *net,
+			      struct mptcp_addr_info *addr,
+			      u8 bkup, u8 fmesh)
 {
 	long s_slot =3D 0, s_num =3D 0;
 	struct mptcp_sock *msk;
@@ -1738,7 +1749,10 @@ static int mptcp_nl_addr_backup(struct net *net,
=20
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
-		ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		if (bkup || !fmesh)
+			ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		if (fmesh || !bkup)
+			mptcp_pm_nl_fullmesh(msk, addr);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
=20
@@ -1757,6 +1771,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct net *net =3D sock_net(skb->sk);
 	u8 bkup =3D 0, lookup_by_id =3D 0;
+	u8 fmesh =3D 0;
 	int ret;
=20
 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
@@ -1765,6 +1780,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
=20
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup =3D 1;
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+		fmesh =3D 1;
 	if (addr.addr.family =3D=3D AF_UNSPEC) {
 		lookup_by_id =3D 1;
 		if (!addr.addr.id)
@@ -1778,14 +1795,25 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 		return -EINVAL;
 	}
=20
+	if ((fmesh || !bkup) && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+
 	if (bkup)
 		entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
 	else
 		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+
+	if (fmesh)
+		entry->flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+	else
+		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+
 	addr =3D *entry;
 	spin_unlock_bh(&pernet->lock);
=20
-	mptcp_nl_addr_backup(net, &addr.addr, bkup);
+	mptcp_nl_set_flags(net, &addr.addr, bkup, fmesh);
 	return 0;
 }
=20
--=20
2.31.1

