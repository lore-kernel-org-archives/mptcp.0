Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCC2CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TS2a+TzorqIf+/zLR6+SH0PRQlsDMC+W4vjYwQAjZb0=;
	b=VUWqzrMUt+JvJP4HB70epnbTLYDLODFRDniCkCp5klDs/xIFCWNS/V8IUXz2aQUSKaH0F1
	n2EHgGHNba6CjblWeE33GQmW7asPdvIScpWSe+eZZQAZKyjOi0MbkldCqw78UL6X01eIO5
	ht8i9IqMrJ/3v7IS6el3o1pDBbHPSlw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-qgGx6qKhO5ignNEuk3SAYA-1; Sun, 16 Jan 2022 09:18:24 +0100
X-MC-Unique: qgGx6qKhO5ignNEuk3SAYA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLrVKb9P4Gh9jbOaP6zRwR1/vihkPLEkg4Og6mGrA9oON8ubt5w45dmPp3DrLhjGvNY3H5ZNfDMKPEIlQf+3nqfysrqWsoRJmKbIvrPMgj3Ig6U7mgzUjOgo4PA89U9rsfPKDmjp8xe0Ow2qaiREHB3VPDYeWFxfz3Eb2LoIXh4PHCmbQz9TomdOOskogVw44dpInl33if0GISBSe1RIHNRX3LpYYzIvLsJrySLjAlQKg7SnVaQiYyumtLNNLDAmqlm2uWXgONqE6ciZeyGaG6ybXbwg+9G2Bv+Po28nMAtQUWgEHZqtAFOTKmDWwPs4PEtSwO51qxYmloDjEk5v/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEx7jyTu68AMD+lRygK7W72LBHx0eCCvize345xLkkE=;
 b=irml9rYpIN+hSud6Ib6xU0AZMdW5bmbW7Xl3c1KCaiM128L3n9KcYiwQfKj9DSF3LuGyPh4CnSm0uZOVyAXwEX3O2vWcXSyVR18LrWJDhqJFrqpB7fUmfBTNfgwqCp+TR8myS2JY3i8P0JsisK9wcNonPhWZRdPlLJxDmMf7XmBwahfixK4gS5v5PSfbjRZtaThG3vTZORUAIxd0U82zfGxJMrlPbqE5Z6Qv3tNRwYLYSroOkixNKvYd/1vZLNVMZaNzV0wCXFDgpne4Lm2miF+8Z1C4yqV8L8/t86//ZQMrgzHrx4SetxOILhPckRhoYsjyRhAf1nRRznvW4wqdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:18:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/10] mptcp: allow to use port and non-signal in set_flags
Date: Sun, 16 Jan 2022 16:17:34 +0800
Message-ID: <3be4e9906eafe7efb2326e47f75ef26cc1031427.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8afaaf-3800-40af-ef98-08d9d8c8c394
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB747202CEE23B9F53058DB10BF8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vMu5/l9E2V5Hi0LuS63TpBB4uQUi1+Y13KQAZJLa2FA7VFuMZgsBSUNC/+QEKyNhc6OPOueuCarwcCt+ALC6ewmMBqkXb0CU70DCyiWiNJiroIssPIMGFAApA4FMPA0v6SOnMfZwqBdlfYJh6x+R3aLkgvg4tVpM+m1DSR65OvFMzXDrOlexfJK/dmai+B/1ZsnB0gLywgLhuxjf+OmEGRhBWlrBb6AS+kB1yaclYr6wjGbl10TNzTGHMjaVjNOXiKZWcjBZekSMTShs/V5qwkX21v15jBIU25rb7kg/3HAbF2c36raUvOY68jY6AsgqQJtn8HpiQ/DAhzkZq7auonuAMeVcJ9qqiPQaVHiyen6ZKqPhp4IUBLFo4dt0ZZ/vgMAxH2GKaMrRQXcHJjRqNwqlyPmriQ3EJtldfsJ3M/ZgNgKOFW2g5IobEJDWp9tRJ0QI6kux8CShGslqWwacebHbEUmiQCI22pgfZTDfO/MLVaBNCB7P0ajpvgG9ILKD+3g9/8AfxYI2JLnqdq7WD275Zh83AbDeXuaK5PG4RDXB6TIeqiq34RiOZmzs9usDV39NiT8FOfr3pBCBspVZd75P8WDCbTri62e6ZGsJa1YKKS2Yhzk1Re1Ae5ImHjSRVsY+g9tRF9Ni8NyUuw9CJbK6ZTUIoJVXBM+LgyEpZkBCudqSxbnOnc211dgB25U1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(6666004)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmVdC372eiLo7QrrTzWaj6XWMF211WenyOcxy0ejzwK/IdDst1TgQqEkUJHq?=
 =?us-ascii?Q?FF9EwsuhBrZUDuLRWlaUJwplIbijERBKCYecN7KE5450HNasgfqJKogd9gES?=
 =?us-ascii?Q?WdQ4PM8tw2zqoBKu9N2Khl8/vvxu+PznoxgDMn7DbugKFqSDku2YpTgipahJ?=
 =?us-ascii?Q?bKjJRTdhbgqOAr8CtiGV+23x/CoPleE8sI8bqMdhNYa8etliDe7ZPD6jc7hH?=
 =?us-ascii?Q?tHKuBUkNWExAlcj3a/4KlewkFGP39lMLYnX8I+Ug26sIIIBJcKRxZy9uZuDQ?=
 =?us-ascii?Q?x/Vhw9ej4Fu5MvO1GByxbUJJv16xo3psNY0os8inoSV8NwTxjLQA2xzn9qlK?=
 =?us-ascii?Q?sC1eqOAvUMv/6whP/2hCoJj/GecxbaZsm/JtN3vK/3S1stKVvwiGsgUhNWiO?=
 =?us-ascii?Q?wB/CM21pwsP+v+1r5/yThvdPqVpDhj9O7gHPbGxSdhlp9FxoFf+hKCeB2Y1n?=
 =?us-ascii?Q?AQDKDeQOQbQE1R3gSPPZjPRLYL2+ttUDGjbiS4f5P+kDfyV7Ura0mpHjUatb?=
 =?us-ascii?Q?+NBPem22qnKF9LqiZhc2OCP9YOwjCGN4izPhZJQCVnOd3ozmU8VM5zIVFbkf?=
 =?us-ascii?Q?t7ZuuaqSFTjjafoovbfdWqQlYm1zGcpInDgSnkXnROJ7b1ph4AYYlM5zP631?=
 =?us-ascii?Q?Q48IehBatfh7F5hI5l9cDnC02qWlen1R5ZLYQstibW/Yb9lm3Ee6urv6/kOZ?=
 =?us-ascii?Q?WK84CznGQR6+RhDJiQCWkjax9aLWJZo6v/V6NNZmuISbr/o03yAfW5cTj+3c?=
 =?us-ascii?Q?oHXHWmKeTZjrcPpWuU/oT7NHqvsUw2JMlAQxMdVQi+bYGoEEQSjQnudGpiWp?=
 =?us-ascii?Q?BHLbC1lwgw+vgOmkbIcEIgYM6ILXDdnq/asF9rf1WO1gG4NKQBA7rBfzU4kH?=
 =?us-ascii?Q?PnWCiNQv3ojyzGMEvCxxvxP+tGSgjsu/zBSL/FXTtqs8OSpvJ6H0BKMboH1k?=
 =?us-ascii?Q?ReJkGmAD/z6naGwaZFMi+TDD0MgC/WVSXehoQr0kMdYB0XFwWZM+c3XjQLwk?=
 =?us-ascii?Q?nvCkOf8jGTKty6VFdeog+5WknMKxhmku/sKtaYo1Bnjkcdwhy6gi7VAceE+p?=
 =?us-ascii?Q?mkbhK+8VLFx4WLFGx1m40YQTg0YVt1M6gtYENowh2fTaSswW2/wJeoo0ilHn?=
 =?us-ascii?Q?wIQuiHIuhTX9ndkfA/WV4Gq8lsu3htS05rTMrDfisyp9SzuMg2QY+2y4Nf1M?=
 =?us-ascii?Q?dBW6WwQuaU4aRn7+GE/QqpRMt4Z5ELZBYdziA+uz1zGTN4Eut16m1cHAs01X?=
 =?us-ascii?Q?Hxi5ELvnXLFQAGjfw/WZwxyRNeL9MmJik4us673yLU6iInIm3G4xEGBi1Nzs?=
 =?us-ascii?Q?ifeOTeTVqKg9eW8nZ6HsTySiXSH/zw8vCTBWb4bTn9gPaPRoT3fJYFfK/irQ?=
 =?us-ascii?Q?xTl9nK/zM0sGF2BsbpRLKCO7lLqb3dO5P0xa+OISNhzYoKxqYimxSniZgRam?=
 =?us-ascii?Q?ZUodknnbt7Ye2HisuB8jGxlN+dEBYFEjzSmTAJt//eJgUbqw1c1Sz9HdBM0f?=
 =?us-ascii?Q?NGfp2zPP6wEnQFVGgaA082PBWiRcxBA9LryW/9/kvLAQ7IZMJxsizI5g3JS3?=
 =?us-ascii?Q?nCDJ4jm2tnDZdsArUp4fuPd0q6lpT9GnT00Kvze9+nsdQnM+JsgPUzG+s47q?=
 =?us-ascii?Q?+P98r3ttNSozo9mju4jN2Tc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8afaaf-3800-40af-ef98-08d9d8c8c394
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:23.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3uCFqDuU+SaF5GlODhtayELxdXQ4xA/tjVpiJ93z3vBZ1PM8ZJm4WOe7Ml6jFe9YgEDyA4+TGNFN2kV/LYfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

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
index 51df0b478ef0..5eac5bde5b49 100644
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

