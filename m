Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B622C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642065192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiPWLyd9C5Mjmx/EW6saxdJD0TuzZGSidMlTf6dOTzU=;
	b=DIOC0/yPH0ib2Imls/hZao/bzJgAkHc8y8V/zZYjOeDQvN/OWzIFqErV3Cp3eO5aHxdX2Y
	4ftdxRuRwV5A9yNy7zYZsO0I9W9COCmyW2QHQBIlvLquxymkqtUimcDbWN+CS2XaDc9mp+
	fHPYTym92a+AneLzb8dTTUysTIPEer8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-r0KehYsAOf-EdHskK4y0oQ-1; Thu, 13 Jan 2022 10:13:11 +0100
X-MC-Unique: r0KehYsAOf-EdHskK4y0oQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAi6fywk5j9rCXRfeBeHX4Rwkhj3nDM5imTn7yRU7Q8AJf7YOaVHjrbpP3VZUWVx+xGUi0FyJnkJe5xYiNwQ3CK8QY9xLn7m/BuNJMQB058RdmpqE8JZC1/X/2DwMgIdePEYN4pBTZyp2+QKn1jucewL84FEEd2wliZYna2mcRQIJ27o7TCaznrWqIdsKlDg5/EXNIcQXHL+4rxY/GMcDQg1V2fW9GPneUrjEPNWbTRp3jIXpVh9DavC0j7e8TwxVDTa3SbvWnxv627qjy0yixjci79LCN2NnE9kGnPa9OsUw6iFX7OOgT6AnuntfFyao4nTn905eOR13ahfE194Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y30rYRfSYA0Mz4jB05oS+6zXyA71XDWlHxXN2UR3Gog=;
 b=Sol2zqMwgW+orSiouEJ7mK9a6QqiaZ6R/ljH4dT6y2x/3t5TMq2UQ3DmH8DV3pkJqijBVUinulp/qoLkX+szmhl2HoztXWJMCnjsm+k+ErIobQEa8GciDz1GyximemZbbDMP3l5weyzuMhTs4blJ9SUyABvkkyypZDZMTzu4UiibiesrGuaukrU+9ioDTYBlKG5/sc0XAg381wwhte1OafI8zS9i/V8VoMa6rBGjlNubi157N+O5L4ATwEiwm03jm6NuNoqDMywqNZDHuAUtqMhp2XsgB/FoGdeRInTPnAeSP2oEFgvxWdWSwqXM2LUCCiVTPYrgpn3fgTEFgEOwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 09:13:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:13:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/3] mptcp: allow to use port and non-signal in set_flags
Date: Thu, 13 Jan 2022 17:12:37 +0800
Message-ID: <474781026c1148569489f563e858072f10ed515f.1642064550.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642064550.git.geliang.tang@suse.com>
References: <cover.1642064550.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12edf3c-d94f-46ed-f48e-08d9d674e9f5
X-MS-TrafficTypeDiagnostic: DB8PR04MB7178:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB717865D102EC707D105226BDF8539@DB8PR04MB7178.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v0fxrLC1GoG7q/1+2iFabn1Dfip7hzsUvg7H+nLm4FhH/RF1Ygkyo9SLlxAuaWzwTlzZpaEkK/7fQKRqFG0TMbE3e0RQ2tL0GCg6ojxMeSFfNQlJfC2mKmZMqvCkzXYCnyGwi5EDHJqw5DIJHx7U/tVJZnIUhn/HiUgypk4OOfq6Kut4dbyG/gozvFxl51uXM/5VpzzwxL42L9JbtpuWn1gDSMRk+xi4gv70WtpoAFlQ3DJyxDWc7z9kxaXqzTyDh4FTKWi95XsNLkj9kGy6xHJGVNAWRam8rFuJi3PCd/K6+J+skc7A29QMY3b5mYwFCY5KVK5xWIcnWjMQcay06qxBeZ7nes/uqbBuQad0s42zMoRl2vCgOEWSdtvQQgC8kOc7FFIW1sK1x2LjlOTduDpkUzuhXc/EazsxZgNz7D7aZzjlygTeZ9oOPxgV4rO0+cVR+QDIsZzWWrcjDEXFbpYruZR6r35my0YXUGRMsDnGtWgTQQnf6KLkWsLD8t2zvceeNfxHX4kQEJYEBxtE8S9vbNyljMQtjLGy9ngIW5yMuI1o1JCnachXdYSPt5zI3ZDyG3kxnF4Myv1pj24d84RTMTDG8Hx+fUxks5yt59+SiTQbNxfbSflorV6SN1nH5v6qwHwCVkAPlhoX4fWoYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(2906002)(44832011)(36756003)(66476007)(8676002)(66556008)(66946007)(83380400001)(508600001)(26005)(6506007)(316002)(38100700002)(6666004)(8936002)(6512007)(86362001)(6486002)(6916009)(186003)(2616005)(107886003)(55236004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eaLj+KbAMNj9b3OSPQMO39T05EK4fxVcHwk4md6HBCcf2K7yAeJaSxgRgJ5r?=
 =?us-ascii?Q?QETK9Pljf2vFGObbhYlsdakiNFrmow9zZWYESJCkjVP1H8tEBC5Wh2exH8lN?=
 =?us-ascii?Q?LuD4IOyWrvu2+F6CEg2LIvFoRQdoQE3VKNT4buadm37fPv2j3L1aC0ayKYrA?=
 =?us-ascii?Q?1u+iZShdrvQJWxua9T90lOl12DsWr6aNSxjGAQrQ/lcZIgdH5B27OTRrD0Op?=
 =?us-ascii?Q?dUs7Ujum2KOtq/ko79yK06Uf/YCyVLzHYUND5RnJzlRuRf9SAT0y6CSY/vqG?=
 =?us-ascii?Q?j5ku+DvPbrBz+R3Rw939Mbgz5RSEnuvtbgo+ynYqGWmdiXpvoiN/eF6QGO6e?=
 =?us-ascii?Q?2k/mCqGnShdQ8bv94N5tJqJVm0vv0AV9UD38EIQeO6A7zzKUTVty2z3IRylo?=
 =?us-ascii?Q?YWvDb9c+HzfWwX1iTuRTjXxHFDlDGhiNqjFpV+8Vbd+Z1/0gDCFOFbuFe9mb?=
 =?us-ascii?Q?IVY0oHbMpnP8wz7IfwGaziwNxIKkTlKtG2zbTPWKGvvARnk1Ogdh9K0WDqjt?=
 =?us-ascii?Q?W23UlecsdISt8J4GPfwTjlQXCwSxpGsYW3QxrSwKWlYzEbyS08bG88gF4Zm3?=
 =?us-ascii?Q?Mxb4E2cFKoioKeAnqShFv5ja4CQDyQSTseD9hsOh3aX4X2hw0Eube2djlocG?=
 =?us-ascii?Q?974sGJw921E02omD4Yx6I+CXF6fE/7CpFQf9umX2pk3k9R6xe5D9miLkWSJ6?=
 =?us-ascii?Q?z8Dz2pxSZYgV4YjbpS0Potnr4DZ4j4+ew7VFU/PMhvyTfNA3LtQ8pfossddz?=
 =?us-ascii?Q?j3duFt66LjGKiQuxTKQemnC4a9avaX2ubJ90q/uG4r0ZLMZ8ZPJe87N6CHIT?=
 =?us-ascii?Q?OvnrizZoOs4ceve/UPcnrL+78E8JyPG08IX9dbp8fjmdmq81EaH1QzG5Jpgv?=
 =?us-ascii?Q?5ym8m35WTEvH7RVUD05XdHzVZKDq5e5VY6FegeARkWQmGnWNvFa3rp4eBMb3?=
 =?us-ascii?Q?6qELLb6M4fBy+jgORMH0FRuPvWizy3ZGA9sAAKs9eoBe3GvmWRrcHVYihBeq?=
 =?us-ascii?Q?jYztYo+VR4hVBsKN+1V6mMxupi8vjY2xgDejiW3viNUh4CW0tgKCdmPbABV2?=
 =?us-ascii?Q?oR8Xo1kK9WsKywSH/byAVR375oX+ZIaHkk6N4dj8l9P4BA6qiNno45niVqZM?=
 =?us-ascii?Q?jWwlBAHyKAaRRIoSCCGXug4HFr2w7NCcMS/m5hnPvzi2Qr6RVOHc/LGuZy0L?=
 =?us-ascii?Q?rp+3mtElLHAXRhjjuBAjjez/CI7awfDv7NtW9EXyKlhjvnFgBKInL3Pe+hVy?=
 =?us-ascii?Q?7ecGHK7AUH1PWEDSt/HPFXitzhT0oiWF44CssjaU/T/DuZMU1hlOzTh35ZUt?=
 =?us-ascii?Q?L12x2gWJrXWPwISugzJDkQaDuMBdoFAMTHwEs15O4g7BWs0LbjRJg0YiDnM2?=
 =?us-ascii?Q?phEh8z0xQxPQ9cp3LBfwb0o/nxEao4zD74dI9O49pgLS8Xy3FFRFVBbmLZhr?=
 =?us-ascii?Q?WZZc3n5IVTo3BPTjkwp+LEIdtTXxR7au/RZVMQqSeDjiPJYDofgOXfKNQZ6+?=
 =?us-ascii?Q?E9Tmew4fpw3DciA+9iXayU0L85QqEdo38zpsujFaPbSPN9pNKDNFhlPYQobr?=
 =?us-ascii?Q?rtTC5OMrovanWvisGK5APeV8V6We/7xSh9X4sHiPh0hjXAb7P6RNPjIhM2Hw?=
 =?us-ascii?Q?c8fasS+qbT/l5SWoxUPi/1U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12edf3c-d94f-46ed-f48e-08d9d674e9f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:13:08.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4MT7FKjbpYJ3fXxLHIACBWDRbQGhkkBlJ1ghVYj4XSfQihJH2hYUErJCcIH0NjWLG3oYvLBTuOmhWd5za9EtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178

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

