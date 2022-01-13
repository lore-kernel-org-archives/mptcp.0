Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768842C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiPWLyd9C5Mjmx/EW6saxdJD0TuzZGSidMlTf6dOTzU=;
	b=jTWYekv1/htCUmQmu1zH+Zg3G47ugZ2z85UYQf7a9wFIJ0gBwD3zmz2tx1PbRlsusr88IP
	EgdAp4dIEooQc0M8mfL9yH2EKLAz5zpeVmD+VhpZmu7PlDkV60k4z50ZvmfNGzDzJXwec1
	yHQ1ROskmyYrTqs64aKRdcRBMZ64jxs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-nYbKPoTINeitPmtfxh7E_w-1; Thu, 13 Jan 2022 16:09:07 +0100
X-MC-Unique: nYbKPoTINeitPmtfxh7E_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/XqbUKQAyJDjMY4UYH6qwjwV6zEkpppkaIqf/FmvIp9o2i1ibeDQjc8iygkopbXAhvkGk744bbNca9z2j2HTnMN/7KD5a0ssZfujOTB6Dw0PWBPK7tQIGgbMO7nmSBVh3UMnUHxmADQhKj1sYHHgbUQxDeLnFmvwXCwnMaqb8yND/9MlZXjhgRdmQL1Wny/p6Ttx/ndpHXA9gJ5x6NY8FzpgqJwxg3CUqzrK4e9URUtLB2s9Yi2q3ic0AvO1qvhnDnEwMtNqEoyRKOC5BdGObW5XpI2ITZRhHQfvCc+hhoFMAQTnFv4HlB95ZJyy9phqZVjSTkKMj7/+otDF87hBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y30rYRfSYA0Mz4jB05oS+6zXyA71XDWlHxXN2UR3Gog=;
 b=UXmjleGavqSET9u7i6hms23hHOaqn0HP5qAgiKDlVQpm3AaL8XmJIVkC77sf4TTRHRXWwNJLqVUHKZphLqbPcVvjuji31ADA68R/39TscGzWuT3FeK2PsFEec7mJ+T9MtYs8DMusTHWYibrfuTlQK8qF7v0vXXhClbWO1WFBVC2+rKVUkVaZkPjHWSLTkdgUzszr9zhmzbRCpNg1a4vvFcg7CwUDBV6quXJ5pYmEYBol96aFMsH5sJYovy8Qmc+zmGUx3888+zdTxw/t8RhXk8fwSTsPiu50+enojiTzFnVkm8nDD/lUPmH2/7WuW9qjQvrVVP4ctTy3BS5KTwxSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2489.eurprd04.prod.outlook.com (2603:10a6:3:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 15:09:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/3] mptcp: allow to use port and non-signal in set_flags
Date: Thu, 13 Jan 2022 23:08:31 +0800
Message-ID: <288383507f5fb793dde04ec834bd92e25898f8c5.1642085750.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642085750.git.geliang.tang@suse.com>
References: <cover.1642085750.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31be467d-244d-4cb9-3b05-08d9d6a6a407
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2489:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2489273FF2A28D2C32F89990F8539@HE1PR0401MB2489.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BooeuPwklzlOCglnDpTMLfU05hIfuEldwQul7oyZKGIkhi5w2/eKV/aVrVfsZlitHpmrVHgKNSYKon6ZgHERM5OFf7je2Fu5BKE6HU3sHJz2YJyfIVLB/LqXtcEZwmo8HqLuYjTYb7yFeW3Wbg85lgmfbMPi9bNlVAdUy9E0i8sETtBzZ10OFhRf3rZURkBfgM3uZAPDDCk1O7qFY12Dk9ZZbBwo68N7LthpI4jS+vxlDqEDiBtflvao0RkipSSm3MefIwOfNZT1Tsq1YU8Wi3XOHbvDxFb9QrXJ0QDPikWySj7cgMObcc/PuiURwGjzPVxU7Aps2+UPeqFfpWNNjJ93eQl0mIviFNEt2qX4QiGJcT8flLri4ZjqvQV7Wr0NFu+qM8I3+Ynyj5irTwCGo8vUKukWNJgGYKcQestT0EGMNCdoB0RjB8ip/LZW+9spRNlCVkm0UnsBkEa/rub36fjIH/VvCpSe0nU57YDFqO2mITdcU0gaHautsBv+d1SgY2tsZ2f5shtPwWF9+z53cweGPe4lHysIo0naVzmaL1hIfZbIv/COnxmeOcjMgDhsd3kq/OhEk1U4J0h/CCznPxndkkWdLh1Rv8MsvueNEaDCmZ9GE9+j31FC/x1DUm6MknL5SuxsRF97zyhpEm7E/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8936002)(2906002)(6666004)(2616005)(86362001)(44832011)(186003)(4326008)(36756003)(66946007)(316002)(83380400001)(6916009)(66556008)(508600001)(5660300002)(8676002)(107886003)(6512007)(38100700002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKs7yBdZSN1302ZthqowXw6seGQDo/VAplYisn5E3Au1x4okn/rotsCsKy6R?=
 =?us-ascii?Q?BYknQPG794sZMIwoRA1Qjg+hiPVyKSbfRHoAotzIGr2TvbdVHHxEzlmO65jl?=
 =?us-ascii?Q?/+nRoZ2vF3BOirPZt5GXvu+8JToxKzjvvntYve/FUc2bshYar1mMDCs+D6hJ?=
 =?us-ascii?Q?1mNgbynowS6385Ab9XT9yDeN9XnCx6ItWvQCQnfeAwpPHod1zGnBihjD7tn6?=
 =?us-ascii?Q?ZnDdeSF+Niz2RHVgksRRHbmvMRdVu1zu1Dgkug7M0ThoQIyBOVmGrWYtxRyw?=
 =?us-ascii?Q?FMWY6NMti2YAxRiCtb4vsoU8GGWODRpGCibKzUl/artik5AKjRmvXcuyS1nt?=
 =?us-ascii?Q?IMZQDHD/b8/5fMHSaPgfLPylH/OSRe59BOBhNNX1iQ7aJ/hqDHRN2cCAJaIr?=
 =?us-ascii?Q?GhCdQxEJE4CKyxncSxVQfIiieHwYxssxx0q4TmgQsVtpiYVLBvZPGtEpmb5W?=
 =?us-ascii?Q?sn2B5SWhcLzr8WL2JaDzc76Qp7axdsSSw7yjFcvr/9MnN6NshbC9F2F1IPpO?=
 =?us-ascii?Q?ZJyxv6ghmaNuINbFtpnMCfyMYDyIpCflgrwsuNso8zW/vo5XiuGmRsy2VPTS?=
 =?us-ascii?Q?W8RZ63FLG336UjdIBxlTQCpYR0mmHvr1Ng3mwKexS+7iMayuEWVlPBbhQN70?=
 =?us-ascii?Q?J4AZEwduKU7b7G1E9V3bS7ipsWO1ibGELEBhXwPWnK8Oh/6cB5rZXuF6E37a?=
 =?us-ascii?Q?/0Qu5xAD+uWIcPNjIY4H696/TM5e7jlZj4cSpnKvNBwy7XuFmfAbo86hqkNs?=
 =?us-ascii?Q?AGW2NIWVleB1xymKR7dsR6xxudyjQh7wbtqfszD7MyHKdp2FbjaC0MNnrub7?=
 =?us-ascii?Q?sQsAFDqOcGqmrorN5AFBYnXIJE6sMdsEooBCdBLjczLBiQ7CHlYVcfBL1gQK?=
 =?us-ascii?Q?XS9jMxF3ckeiUYg1H05Lll6NJ5TxTJwDKGq04rVksaugTG4Kfu5OhDGSD5E8?=
 =?us-ascii?Q?XNUbtF0htU1m7qj3EL4qauA1QNlVUeuRiVUleySs4MoWlNCi5NN1fI7y5+Vg?=
 =?us-ascii?Q?2DGwwqQIJs+/7yE1OhDGF9kKUz4HVq01m2Xnqd1Fc/fEJ0OpX3Ue2zQaqhmA?=
 =?us-ascii?Q?oQvqQTur96OxSVvHl6+tR7Gy13Hl0QJ+U3vPS2bAUK4/YQcnoeZZVrrzvJWk?=
 =?us-ascii?Q?yKLcwiHzUsi84bK94aBmV2o8b/8rvIeEv/kBNsXSY43Chnd0RndKtkcL0RtI?=
 =?us-ascii?Q?w4IjEUXg4VMN5XmQ332JIinGTB3oy4lq+A21Uo6Ls4lK/eFcAH1vOf9592w/?=
 =?us-ascii?Q?H0TyoEdQLVwLzwiAulzuXfGqdSpPUO8RTqBMO73PJdVj0d6mNCIVzJmSRPMZ?=
 =?us-ascii?Q?CLzQDv4eOui/NbxW43zbuSDnpQoz47/9GGDys/3jZkVs/lDceNjk8KFpL/0z?=
 =?us-ascii?Q?hFkLXUOzPvsqudD7tGyHAp/CCfjgjldWXO3MuO7MwlDbjbo4Vth/w2slpfxZ?=
 =?us-ascii?Q?yVSFetDXeG4w5tFpehwNPFjf/FRf/xlXFMWujxW5r7L0zcBwEVanb1UDJ0NI?=
 =?us-ascii?Q?E8p5+OtLTiX16PlWaW4zkETcSwIHIlu8D5SOyoJbBmnKsRXdhWjqS//QHTGP?=
 =?us-ascii?Q?voCcozSvT9Mx4Cuoj3/WICM8R7keMyKT7ClLHww0/8VQqg3rFlSe5MC/DSeD?=
 =?us-ascii?Q?dHIKjLAZlzNSqDB6LUDjFPaDwzc+POy5LelKfFHxaMRURI0FF/DFwYIVF7jF?=
 =?us-ascii?Q?u/RGlMlpNi1uVrSG+zshd4qZo3g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31be467d-244d-4cb9-3b05-08d9d6a6a407
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:05.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+R9n539lWY1QxtcJ8LDtAxVGHQChS804N7qV0sCm+UwDDGz514sxebMmzOfhZEAX15hmC6eGxlLvKDAbH+ozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2489

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
index 8c5a4be21e3d..d28e9f5d2780 100644
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

