Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA552CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3RRegy7nMT/nxNxsWZUWKpas7o5csWkyR2w0tQW7C0=;
	b=B1pIKjjuwhuJq5nsiKuNI9NwPw6oYVIuLCwdrocdPJ3VZoFl3oXgLidAjQnPd5qENeIu8R
	Qi8hnaJDuAdwkaDPfpQgwGnzC86H9LfwZUlqgOTDm6Yl7Z2mepmhaqwkbGfQ9ddeIWIHsY
	CbqGuXS5LGtT4vQUaJja5Uatt8hQdak=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-qe19zaXGMayqBm5uGywQ3Q-1; Mon, 10 Jan 2022 04:30:28 +0100
X-MC-Unique: qe19zaXGMayqBm5uGywQ3Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eua7b2eOeJOUx4qVI8e0BfhMqW/5XaFQl6+TaD+aSXG2vY87uslguXRDKqV77isb1r1abDrjO0d10WQwaEeVVkZN3uUypAvR3Kt458ezH3cPRxjKbSKjGDLyw6mQoD8/v4B9uaqEuCGRLs7nd7BZ892cM7p/h1Omjt8d26uTcNfJkrm1dI8GCDE7S2B9/uqGL8antU3OXhoX4FZIYxsey4WcWbNy+EZBZ2ffPDi86ea1fmci5nh24O0ilSY4i27J2n5uwajLovHroKzBDP8kuUldn78NIO8thJ/wLmPAKpEipo7CHddgMksp4tlDH4Oeju0720qeSk4iQLonk+QvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf//gfUGWFOBY3xUbfvtIov3BbZEJF1GsUoCrrsHSbs=;
 b=hxyaSkpYgSEcXLF1EGs9KvPxZUza22cyRBxLOIoaUkVsQbDVQEBD68Cqn7edeJwoYPPwCByFA2ZEi9884i0G9n8Ga0C07AgXmuX4dIMYT1AHxQ0nYn2+VRaLTyWxrntSUaH5WbTLAyOKrL6COYU4BfEfpqbyEAZdPj3N8EqhEGyB5rsNsj9kpJfTC1kPfFIU4/39kCToRQkz54Pmr24H6BwdN0tQymC7ebSdq1yursr3P9x0PBfOMd+VxWWCqtB/a+NNkFUXzKwumuU3Q4EHEUu49+zPKQ35esbMW+ebnbD6Niycf/7gNkm8xWze3eamxpEu5pjinebfUaL21HwNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/7] mptcp: add clear_flags in pm_netlink
Date: Mon, 10 Jan 2022 11:30:00 +0800
Message-ID: <0132f80c0aa9f62deb00c816dab5d51d4032afb1.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1bcef7-7cc2-4cc7-6184-08d9d3e98ba1
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2569AB36A9B60F77E5D6D7F1F8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKZWm3BaaERDDUfPVHUVqakbHa13D8l20QXwAedIEh5FdUvIXFvhWSRFJrF5DgliDIGqf46j/Wcmf2XDtA6+f2Um4HfY69fojMUGz7ccKVIUig6W8YHO1Yi6kx5j82OPpRXQU+Cuc17efDYHB9hVTrRM4tLhtzt0tRlRvrUM7CvtLtBeEsN3LpeyQsmvDgPuozTSW+BncHrMlkO0UtSiZ2zwvjdiFJieVMgrgQr1/8wQ5C0lml8imavSpf9AoKcx2yRw1FpcvYcg6TYRfGuqCq224S7YwFhXl8pu39JktR47RbI/nylG/xkzZ5UFnh2f/F+oXjZxYyBJyTvOcoIrmN5OHZ2MiCoP4kF1PTnlpxrR5bdnf39xvxZN/Az8PKzuBAJVmc0HupDQaev5fIjdAPV/hehZGZEgmo/xtQe6OSuse6M6LoTZTCRWkgR9lwj1aFaKOhhomdUM18xfs3wy6PwT1OO6bMgjy/bN8dbpasl0JNkI1sxgGOAIYLFnLceO6wLrkHff7T+pNVH4UmWLF5C/kWkVJ1vEoDN3zhZHbN2adyXAJYMX5JrD+AM5Ab+yc2Pc+uc1APkquX6Qw92D3SdJBD5uDprG/a9BD09LM7exzo0OSt5BlqvDQkBvFEj3EPzEDYX4+Ly9EjonvSMFHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(83380400001)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ryLXJjJ6B6hgju/6jnvSvfz17e9zIpp03BEQNDvQOCeKE/p4C7ESbeBE3kN?=
 =?us-ascii?Q?0i7lvG5u+ToqmFyAErq3x8Sz2T6lpLlpGq15jsCzxz3tVeXpw1VeLNt9LE8p?=
 =?us-ascii?Q?b6Es614hnJGrZVf/GsR6pfSyM6esVDlwKP+GjaacW/NwZASbGgAsR+T6/KQJ?=
 =?us-ascii?Q?TUQ9KViG9T/Kb0fMGN5JTseu3CnsWS08AKqlMhW5OpYMwXT48eCDTYz84UVh?=
 =?us-ascii?Q?OssQ2UYYKB/w1I0WiOvImQ2wDz6htjb6I5I+oj6TOhePxlVd+6qWAaHQrU1U?=
 =?us-ascii?Q?P77jdhIjE7tv+f/TIhxTQL6pNQ7fROhiSJ1y454F2cXVUyJgG9/6yIRl0AB9?=
 =?us-ascii?Q?XS64iqbOo865boFdT2JDPuK0JJi/PxTEFtN+jMsr+6Pe1dj1ngZpklN0ibfu?=
 =?us-ascii?Q?q8rQsPaSbTA5ubWhgIPwHd1X6VCilP6pEGMyFBIrIqk1w9pvlLGnhXD5fvAp?=
 =?us-ascii?Q?2iPJqpp3HX4VNe6lkwENkIpkgtupBigzJGpW4t+I3qr7AtmBB2ZFMboB3nBS?=
 =?us-ascii?Q?lDa6nbZbqUD2xWHJrKMCylfd6RrOPATFQfpiAnPY3R+923Stt2jOws9670OY?=
 =?us-ascii?Q?imwtSxFTu3K2SLKW+Lii9Yb+0WwiIg/24tWaECBe9zkSJDjYf3nx3JxuvrBB?=
 =?us-ascii?Q?71HT8yBhNJ1TYhL8yYQ+acumB/rPziH25Jr5H/C3Rh5a8Q37fVYkWLvFl+Zx?=
 =?us-ascii?Q?eN3jUAQAQFuV/40vqgHIGRrKCEGL18CofbqeSVe3vWV1VZ7ugg3RwIVqDMgq?=
 =?us-ascii?Q?fXemC0Mr7N3dERSWyf2hGyImf/pW44BoeZl29RtqkjiFMcDqttIO+/uvCWBO?=
 =?us-ascii?Q?l2r75HRhE0Tnz+6clxkKxqRQEpcv6Pzg8s45yNBLy0HGF3U17AXO2OgG4S4q?=
 =?us-ascii?Q?E9rGuIaG4P3/erIhNFG8E/8p57Hwy0Mgaavn/IrIkBE1uHgc65EhGfL4oCaQ?=
 =?us-ascii?Q?NVCbVorNAMTVNT85kySqvYRDUW/YeaxSGx8gG4MzAyAQy1tsBvCcbEufebIl?=
 =?us-ascii?Q?4KSCE6BMOrJn9054GQmXm+cBnoLsUoFEBAwQ2kaSBxK4/SU3fGkTpgBdAVrw?=
 =?us-ascii?Q?XZlVS0X7AC+MFSTSNDK3KsJpDZtV5TdRD2E7E1G9nFsHrFpmRkkUsvMc49GQ?=
 =?us-ascii?Q?TDLdZu0NVho0hPTolHKf0bwHD5LQ3bMb6rMSQG/ew0RbEEBMm4Euk4UNkhA0?=
 =?us-ascii?Q?9b2J5wROnhmNvnKBBjs6QKvIdWFKAKYKe14dwe0Um1kdbWaeN5jpKpxXZ0NN?=
 =?us-ascii?Q?vY2CN9rMu/qSQOZADO4YTpkP0UMyJxN0/4X3kdTDedVY3//jotdudq+t9ZhU?=
 =?us-ascii?Q?oDWiGJ6KuokmGXVGI7cebsEM3TJgtrbY4r5ICz8ZRR9YNmlUtn6CVtZ3FfwI?=
 =?us-ascii?Q?slf3E4ilGi9mVGfKGrLsGYCQX0sD3iUgEQPNSvL6DloCShdc2DkYuB+es8nG?=
 =?us-ascii?Q?ekem6uQZ4IfLhO4FNAbMm5/+UgLoIqTqq56iAg+3KRgOZ2+XX/ZrCDnsuzjM?=
 =?us-ascii?Q?CAvdShDyzs22iTHgI3A3HSejxlFt3qsAI04pTeDI/2gnIzC3qerlHgS5E8Pq?=
 =?us-ascii?Q?ECDySKw5E0A0dFtEdvMhwzWIhZKvW2/Qr+XWwxLnJ4tLUwR3aICaB3rFi3/f?=
 =?us-ascii?Q?3W9FDYVH6uER7wGquEjpWDc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1bcef7-7cc2-4cc7-6184-08d9d3e98ba1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:27.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeYw6MldQaG9+egep+WQKofZglllZ4Ebtu57uIigDjipd7UP528CdpKqQOtBitxjpuwJopIBRU0rE0WvSlG4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

Splite set_flags() into two parts, set_flags() and clear_flags(), make it
easy to add new flags to set or clear.

This patch added a new PM command MPTCP_PM_CMD_CLEAR_FLAGS, and a new
function mptcp_nl_cmd_clear_flags().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 36 ++++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f106a3941cdf..1ca9b13c2ed0 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -92,6 +92,7 @@ enum {
 	MPTCP_PM_CMD_SET_LIMITS,
 	MPTCP_PM_CMD_GET_LIMITS,
 	MPTCP_PM_CMD_SET_FLAGS,
+	MPTCP_PM_CMD_CLEAR_FLAGS,
=20
 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 47ad00d01cf2..da1bef34e8e6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1736,21 +1736,21 @@ static int mptcp_nl_addr_backup(struct net *net,
 	return ret;
 }
=20
-static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *i=
nfo)
+static int __mptcp_nl_cmd_set_flags(struct sk_buff *skb,
+				    struct genl_info *info,
+				    int clear_flags)
 {
 	struct mptcp_pm_addr_entry addr =3D { .addr =3D { .family =3D AF_UNSPEC }=
, }, *entry;
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct net *net =3D sock_net(skb->sk);
-	u8 bkup =3D 0, lookup_by_id =3D 0;
+	u8 lookup_by_id =3D 0;
 	int ret;
=20
 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
=20
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup =3D 1;
 	if (addr.addr.family =3D=3D AF_UNSPEC) {
 		lookup_by_id =3D 1;
 		if (!addr.addr.id)
@@ -1760,18 +1760,29 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
 		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) |=
|
 		    (lookup_by_id && entry->addr.id =3D=3D addr.addr.id)) {
-			mptcp_nl_addr_backup(net, &entry->addr, bkup);
-
-			if (bkup)
-				entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+			if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP) {
+				mptcp_nl_addr_backup(net, &entry->addr, !clear_flags);
+				if (clear_flags)
+					entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+				else
+					entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+			}
 		}
 	}
=20
 	return 0;
 }
=20
+static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *i=
nfo)
+{
+	return __mptcp_nl_cmd_set_flags(skb, info, 0);
+}
+
+static int mptcp_nl_cmd_clear_flags(struct sk_buff *skb, struct genl_info =
*info)
+{
+	return __mptcp_nl_cmd_set_flags(skb, info, 1);
+}
+
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gf=
p_t gfp)
 {
 	genlmsg_multicast_netns(&mptcp_genl_family, net,
@@ -2074,6 +2085,11 @@ static const struct genl_small_ops mptcp_pm_ops[] =
=3D {
 		.doit   =3D mptcp_nl_cmd_set_flags,
 		.flags  =3D GENL_ADMIN_PERM,
 	},
+	{
+		.cmd    =3D MPTCP_PM_CMD_CLEAR_FLAGS,
+		.doit   =3D mptcp_nl_cmd_clear_flags,
+		.flags  =3D GENL_ADMIN_PERM,
+	},
 };
=20
 static struct genl_family mptcp_genl_family __ro_after_init =3D {
--=20
2.31.1

