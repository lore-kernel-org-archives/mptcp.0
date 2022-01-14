Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD42C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7UgUhY7NAo4dsenNOuxQoreUuGy4nPUHuHWIamzIAM=;
	b=CZbA6iYROycB7fPnAN9v63Irm7qYJ3BIloesi9VZhH2atzaDrE8RyL49F75VwSG/I2i5TX
	IRDt39tfxKOshiO3Idc/ZKpGWd0w4jpMXa9YfokG+kvdM1yuwipOZtFu4Vi3+8PsZT7gZ3
	cR2h6q3WttW6TRRHiqyvqWJi5rZYLSI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-HKG-p0G7NYGajTb5vz_Hhg-1; Fri, 14 Jan 2022 11:27:15 +0100
X-MC-Unique: HKG-p0G7NYGajTb5vz_Hhg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFzty+5UzMO+D1gUa7kJq53xC5tTFPQ/RyMXCgtHQwDvhRsE2E22fJOwMvRIRj6O96HLuWRkOA9DEkODhFSkihNo2WIMmBPTyRlsSl/KbNCXTcz1gUW6IuWGlVas/eYnG9qnj5KRi0VNYkMoIf9oN6DIkJ3t+JjBAwfGJ+pDTBFckfWquSd8oCELIf+GPRakWdgU/oWNWHR/znAQwpCrIO3OkiP8fGv7vrPzk8WgePYSRXI42Tb1S+3OdIdk17cqqNL93JxdMmf1xm4sTeN4zXPR1xJa5Wfjw24YfrhhxTRZZVsivVfFyYZxF269/VxU/x6Hf8SOHJm8Wm4XIdQbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ihbpFixW8TYVz2mHulyY2C4ZhnkGUFynoT5wIS6SpY=;
 b=djd90ycRPdYkF53XFgcCthfcTEAJKHQ5PNYe4f3nVaXrX5/Szbo3vBbCFAE2dm5CfGy2ukAp/UszZZikQncR6K3pMg2dU8WrH0jUnqIGXiSCIDemZSfSELiaxO6mLpvCTJ9pVsqIlf/3xecoJCk11ZCZRZ2XswkhMM7r4xH9Nkak8d46MRFXJ1gGNYMs6JOSpBwIa6U9Psj9uWnKaUbWE7irt1Ck1WaokyDKxDjyagYxvigJS4oKISsOi8TeUHzukLjx6W2sZhIY1arptg33CYBnCX547XdFa/+BLxo6kDhJSMOpWmcTqiyN8K1a7kPQaPLDTLOeQ9k6hn4I9bXsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:27:13 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/11] mptcp: allow to use port and non-signal in set_flags
Date: Fri, 14 Jan 2022 18:26:23 +0800
Message-ID: <ebdee81b8b01e0523041ab8c05dc0877534ce252.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:202::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09a8228c-9fbd-4ce0-aca3-08d9d7486e2c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4317852CD8FECE1F9B4810DCF8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A5srMHpTWFmA+NW06BEvNgUR3iRnmWumgWZy2c0lH58ccl9u+/Gq161dI01Zfn7/rkmLfGGNeure7aOLTCYv75GjdJjml5nNJT+pWj21OnaAEmFeB3GFhYn9YYMllg380bZvj97jo6q/KfUWaXOQky4n0fwWKHuhn2Mi2mv2UIp3Sz7EeyB1M7PCr0KbHRSCWtN3IZic6ZUVuXzBhx8PtiKAgrPc+d9qFIL8qtXmALNr5aZLx+dskWaAJuq0hIgBrQf3z2BNDg/vYDzEYtCijFjCB2P40uBFLQFslHy44Z5NniI89GI1grkQqSWGpwrLtQMCwtyFC8FPUIzermYI5pqJjEY4X+HFDGouZoqu3tzDzvvkn5qPnnQH+18MvTGfE4xPkkoArdhNuJVTiESLu/LPebMUMxEfTH7MtkK9H9nDKnB1fToN1ktUpXYyvIP0L3b89RN4Y1hsNg3VLL7aK8R/0rF7Oc2w4+WpvU+8iHqy5pqupkQX5KKVE5koxCLG7JhK7IIWx+4j5ZyqLWE/rJBvPbK08onMDrkyq//J604VO0C+bHlBgQhDf9MGwM44G0o/qA5f34qu/qmA+l5Va+QW2bjxY1SXRIL56t7tUQNF3yn55FpRrgHZ/x8h5d1vTeDe87tg+wMOE4oIUDHBDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzfLP0mQIRhVsGCYGY6qxpcRkC8w8bD7WrIPiT5H4DqiK0NZXNzMp1V9MYSp?=
 =?us-ascii?Q?DQNgaucyBfsG1hs00c5ToDt9LOnGYSCI0a0fyHpR859VfZ2dP+CCQGWsZKm6?=
 =?us-ascii?Q?ySGvbQ9OOOxuLHdCWYVZpYR+K3jwWbaePW2SsiEFBpA5xwuBZH+HVYlpqtnv?=
 =?us-ascii?Q?p7uJSZC44sG/4I1JgHPGBNIfuEXmtNTh/ujsA902rZUISK0GfhNVwHGBb7s7?=
 =?us-ascii?Q?pFdS4gxsFQ5vQLxeMKkgADb6RrCyF7dpn5LggC5nNPuup1XzTbXmxm4W7wk1?=
 =?us-ascii?Q?qmmnVuW8/aIoN/xmlaznO+qm/ItgU/XQUIz/w8sq7ZN7F6qNmrtRrKz7/zUK?=
 =?us-ascii?Q?vxie/4DayaJU7J356fzS+Owb/aA5SG2P7nQX7AoAMOnqZGJCWXss7qhckeo1?=
 =?us-ascii?Q?1s4jWMgsz1WrY2VnP7kJ++t69FGqTu+x2fjR7aN8eon0xBVLr5aU2rUXiO/2?=
 =?us-ascii?Q?81ZN2VR/kJgpmoSvU5UShRCI+Oy7N3uzvts9/kFi7W2Q/9mSEJQjlD3NJMoU?=
 =?us-ascii?Q?JlAz/LkTPgljmITfKOBzLcu+cK9JfyHFN8CQfEq2OokpIX9k1koNOhBuvJpq?=
 =?us-ascii?Q?KmDx6EZMHJYHs96rEQoqq89E1kEt/mOfMwfkKAL80gvfWNdecnEc1fgh2dQF?=
 =?us-ascii?Q?p7zXaIHt4+603Zp6Plg8oF6VMDarCEM454PN2jo9Uom0PmU2IjR51hxX1gtb?=
 =?us-ascii?Q?kUlTBxkNHHXyKy1/OrYmEY2xoHPJAz7bnISXwbUhl/+03i2roTQ1q1weKn3F?=
 =?us-ascii?Q?PmhjmLAmRj4TiUZLGQwQydu06kf7LwNGlG/hcvyrTvm4nsecaGkyhbTiokov?=
 =?us-ascii?Q?Zg9UKOBpOJ8Ro1mvK0ZeGjtEYB3tZn7URavuXERBNAKjdofpshKm3UYFVy0H?=
 =?us-ascii?Q?3D/UITFhz/9hJqhrbHp8wBDSmPUR5yaI6gBbNugOOSF2WSKlUDTomV1oSwzs?=
 =?us-ascii?Q?tXoF/3HQ89mCeZK7zM3bbmHmrRer6ez1rWiFyUS4QqeqQrbwUcjBUZ4CcaVF?=
 =?us-ascii?Q?/RK3moSOUCLeQFC+a8ShnikplAe8t3LdFrT1uLfBk9lvwLotDv9lk3DvoT3g?=
 =?us-ascii?Q?aKPR7Fi6O1tZhsDVlyHNLG1aJLE4goAr9PjVja+AvHzg5Juy8hQMfO9dfn7j?=
 =?us-ascii?Q?C5uMg2FBFtaIo+w1IXSY0CkFf1J6t5DdfqFxP5XzYrOYU1n506AoAzjRee1N?=
 =?us-ascii?Q?4rT/kKyBTELa1aa9fJh07cY9BQI2DJt+45ICF2BsGn9mYBE5PVO6nDPc5Thm?=
 =?us-ascii?Q?tfvB5VDOYBRyPxXgd3Q11udla9Exj16oBo0rq2t2uylDUDr88mp02SM6IbQs?=
 =?us-ascii?Q?Kc9PvqF1hDRc2F3H2zRV0ESxHybf9bnKCLKPVhUao5++O5APhhzSjLfMozEK?=
 =?us-ascii?Q?b7pObO0r+/IkqeXihj0c2BSqYkj6jKzydtPTzZGCt+VZpty9AztqVBDQ7A3t?=
 =?us-ascii?Q?XaY9YAVMcTnfMRWTn0NDllP5OJ2AL/mWxgh4c1f2qWlECXgwwM3ltrE/2tqJ?=
 =?us-ascii?Q?Js5CrQaqppQn2fvfA3llV/lia3mA0kvT4DbqAUkLwPPvJVKanjFGkOHSvuF2?=
 =?us-ascii?Q?nnH1G6Hj5vG8TVQMibxRFi4UqPfPPWHGxN2OivDRvxpcNpI6KxT0dt/YQ+kx?=
 =?us-ascii?Q?KxajaOdaAeoiuLWTVIqYQ1Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a8228c-9fbd-4ce0-aca3-08d9d7486e2c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:13.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0AaqZdwJwBjl04uUuqZHarVaEElgkoQiFzACQfZ4sOesSR/u2Jhrajn5/MH685V5splJjMDttOPcPSSmAiPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

It's illegal to use both port and non-signal flags for adding address.
But it's legal to use both of them for setting flags, which always uses
non-signal flags, backup or fullmesh.

This patch moves this non-signal flag with port check from
mptcp_pm_parse_addr() to mptcp_nl_cmd_add_addr(). Do the check only when
adding addresses, not setting flags or deleting addresses.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b86bdb6cd0ee..e69e2104a7f3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1162,14 +1162,8 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, =
struct genl_info *info,
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
 		entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
=20
-	if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-			NL_SET_ERR_MSG_ATTR(info->extack, attr,
-					    "flags must have signal when using port");
-			return -EINVAL;
-		}
+	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port =3D htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
-	}
=20
 	return 0;
 }
@@ -1216,6 +1210,11 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb=
, struct genl_info *info)
 	if (ret < 0)
 		return ret;
=20
+	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+		return -EINVAL;
+	}
+
 	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
--=20
2.31.1

