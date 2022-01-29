Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB352FAF
	for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643437588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kmSv41xx3DBV/LmeA/XJC7fV4KvVQ6PEwgOS9K9uYMU=;
	b=AsIlWsT5mUp7MFjIOTF161e6DNqFNdrx5y1hvocp7NTMTwdD0f0W3hqrwcfBAI8TATnph/
	yHVDG57j3nif8+EG4mUPFpcYF7x/FsTns/yvDFprMt3mJ40EfZg2i/8HGLB/2WDB/YMJeJ
	sGc9MFFhaUB0JL0+KLRaK9rKkhtgQe8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-GgzEDaY4PG-dfurl_Lg_fQ-1; Sat, 29 Jan 2022 07:26:27 +0100
X-MC-Unique: GgzEDaY4PG-dfurl_Lg_fQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSOP7N/R5btNgACY6jHiMHuUxZbsvbPoeLJisMKN/grb3+hXGpf22Umsgkva/WgQ95WqWcA/zGGSM2QrJMLKCF+cARj6Xh7lfPZreHEijjwV9RXAOqxIQOpXydJlgoczbj/KTjoziOqxUm6uacGr/e/wtSAhTkJ0BIy7/AoKh47mJPj4QC8gSaRzgtvpzA0C7VNwtStxAd2+tWnR8vgCxxYCN0XktxwyDj4BXZjK55cUfjZHA9i+1aSoi7VKewhRKkjyOrnm3btMQ7sxsdLRnxdqXE1A38DvHvCtmUaDDfA4RCH/2Kf7Fe83TP1SZKGc35PE3S1kbzhEnZldXrhzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfrzbnkLnwVy9HAnGdoMdKvrcDPBv2x9wuw+Uvp9l2E=;
 b=BBa3D38NB3/gam+JcC93q0IoZ/rQVesWCQhLGxxlAwW5jHfQjD4Z2OiuDVkxLLiVejYL/R8y6nKcNTaoC0X1P/ketoA/yRaGnS4uQ5Q36+edqy/UxswRjI7PbO37EdEEvnmKhlG2ZcRa0QazgOzUm12tbUiS0Kde+ScDyd54r7DomI01LRJA8NtbrL3wSob/JhxUP9kdoHcd8cg94ZqPANsEJCTJ3/f6txBT//xzy+jcgxdXxRq5sNlOZDDZJ7Bs9AJiNQT0S/nKcB77tT16f8+Hvf63ENFajYNNPLLxPc/anPi46VVuymDXiBq7IlQ/V7dN0kSns+MRM6zpy1ttcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Sat, 29 Jan
 2022 06:26:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 06:26:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: use nla_parse_nested
Date: Sat, 29 Jan 2022 14:26:36 +0800
Message-ID: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0dcbfbe-bd2b-480c-5aa7-08d9e2f045e1
X-MS-TrafficTypeDiagnostic: VI1PR04MB6926:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6926C4139C8F604F6CB80509F8239@VI1PR04MB6926.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	prhY+u85bffo0XnHskxw+1ZwBwj2oirI706GOcjFlTWexfKZKJx9cIpaaDQmyeAw4nMJelBE5PkbDTLCzjQNFBpRJSDO/7JBu96UwlH8ts5CykoXeBOBnczPKXfIB/5rd1jSEGufMHBhsRHfEJvwygXJi59ANA69UJz2KxPizhIeuqRrihewQ+mgG2Y1d+l7FOvbrpZHRRY4D7OKTDz/AMwCQsYsg4ruOcpgAA3ERQSL+NjRB2xyF3b5Q14OsR+/OpCdHx1M43SiQIlkZTpYVf96aKixFGHDxiJYxtdM0kCgTU7zAu55VCbfQg8gDLN8+VANu+w381qFiBcJNDQmi8NNvtpvdi/8OOkaNgieEaRx/KHBHApQmuhyi0/OAbbkU0cE//I5VeKaULC6nkLR7GCPLvd4bQvfRY7XNHYZ51iu1hSIFSGRaHQfP58hAcnIq1F1LC5ze0n3okhtA2Sbjb7jllCKTM0mUDa+zw4+kv1k3lYPMSXnnIJgvAaUY0QDeZXox6fTLOTZruQEVz7c2fW0iYcIdWCY74a/eDOT1JUrxpE1F2Eywea12F3X7xhnGu16casuIvrt4niBh80E5YHL1AiHzdZa3rlO8XAVSLRn1iLjUqy9MQnMQVPrJPwODpos+RfJyAxkVxJHu8DfSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6486002)(36756003)(316002)(508600001)(2616005)(6916009)(26005)(66556008)(66476007)(66946007)(38100700002)(4326008)(8936002)(8676002)(6666004)(6512007)(6506007)(4744005)(44832011)(5660300002)(55236004)(107886003)(186003)(86362001)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qj9Wp+YQBwaQB3C6G1pYWe0Xr9r7Gj6zrmtzPeJfYSYvepjO7R11ViFg2moT?=
 =?us-ascii?Q?YUdKjq0BS7MStW7ypABLG4UtJYAVlVeHvIWtlaRKc0HNP7f6CvbW6N9BR41A?=
 =?us-ascii?Q?lpqrzp2xsG3U/uHJvvTGBXUD37Ei0IsACOwRj1TQ6uljpEPTErCFJo5MGj9P?=
 =?us-ascii?Q?tB1XEq4h0v2rbgXSA236YoT+xxduXEaDc/43gDDU1bVQ781KesQL58ObjBQf?=
 =?us-ascii?Q?JlJvgJiOkHBhtgn6NHYLggXiZulfv6BxPpN+rAaPkvZ7G3nJmsCWz7CNndaw?=
 =?us-ascii?Q?cA6avRGuZNcrt/kvLic3lAGMsojE6df5bFHE0a9dkPA/iFMRJzhB8wv2yA8U?=
 =?us-ascii?Q?7+e3vKms5KGEFvlrf3omhrf/DuyYdw6qDE/D2LZNLOGrHTGdSjtyflbwJ+Iz?=
 =?us-ascii?Q?YPA2UhhsicfjMNRPq+9n5C0p6x15uXv/75qwr0+dUGEvHSpUDQR/m05Xw/qp?=
 =?us-ascii?Q?FDkwoJYF1zXxi3hb5DCXZxEh3w59KjcHdj6x2YiVHb8gMe81WsRmNmWBcz2h?=
 =?us-ascii?Q?Z3vAcUP3PS4hpsITgDs4mfGvXxeMrPLnYJO4P97gqDU0NY83bws1BCtXwVzN?=
 =?us-ascii?Q?dImu4nwlS035DxMmCyGmUAl6Szl/xo8VEdk+IH5RXzNuc99YQpEKBuFhmA5M?=
 =?us-ascii?Q?nWEJTawtOmGsx8J/tWKCtxOmVz8t2xAQ2vNQ9iR9ezdNfHpdCGIdMswhpvqO?=
 =?us-ascii?Q?sNN9kJMbVRJMldu6F4q+hjV28FpepRnJ6fS4cSMFC441RBD/9oyF8zCI+3+g?=
 =?us-ascii?Q?GadKUvdnRiVdxpT/b2baJxt6Quq9M1iiBmV9RIxJcYpc4qm576Cx5QZgKkLc?=
 =?us-ascii?Q?DEmnDXJ2nm4ZUbX/lgFT3Ac9Wfo6+WHAijIzpLU8PNSlkNL/V+AMIZIUw+AM?=
 =?us-ascii?Q?mO+3IpAyirQeg7QuL72n7Q9kWh/ActrUSsePyhsKqqdy+LXCChoE7Qrp9Zxq?=
 =?us-ascii?Q?A6KhUzuZ89f15EIol6NqTsNTVspBWC2PBfFh5AYQEpT4SSvjtPao3xLOWKvp?=
 =?us-ascii?Q?aZ0M8ZDJETvF3HjqvyUQeDWATbv4/CUtoSPnU3/a/lpzoxUtGnEWDz2+2Tp5?=
 =?us-ascii?Q?zdLYbGjEAGJx73mnlqjXOygkaidr6gC46Bm8M6dDAPKmJ41+w2E/npOx7nYN?=
 =?us-ascii?Q?gi7N1zi/kzVyd/ME+LyXM7gEd46ds8DKsmd8KSZE3UkF8v6nDGHACitBxUaA?=
 =?us-ascii?Q?CjXO+tH10lKyn+Y6/CeTmnknwH/W3lyHcXJVZJAofgqABy2lcXVxR/FuFbni?=
 =?us-ascii?Q?e/cLeCxNddj2T4dnmgefds6AW42uLvdije8mD5JPHi54iDw5G8uDeOaSlgdi?=
 =?us-ascii?Q?ABi0hrFTQOZZLMzNoSp5SqlyW/dTUf92RoqlLuWycwHR3O0smK+rg8GDnovx?=
 =?us-ascii?Q?MgvMHqpmMSWVZTxvLYTVCRxG5xqO9GJ5hfqBOQrEn/RSF59AIiQlDsoXekA4?=
 =?us-ascii?Q?esxOH7O4pgLEO9IHrTMHDqQ6mE3jGSUiHyr7arXSNZA2Td7vuucGsDbkt1Bs?=
 =?us-ascii?Q?TMPTtx88PiV3wg+jNlbQ4fM80kzB4JBlZ2nyBFEaG6OvInqbE+QBmqsm8SpE?=
 =?us-ascii?Q?fRbKi+FKlpEDWdP4C3JVZaMtQtXC67TtGYJviP6zyKjEeNJFieWkAjroz5/6?=
 =?us-ascii?Q?UtJhzatsXZlzr0/Go4ZiWWY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dcbfbe-bd2b-480c-5aa7-08d9e2f045e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 06:26:24.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHs6BtVihghq+Y9cUC8vLN08qwX9wKOTQoLQAjHTHFXDhQt/vgozeuRPrlB8saiFmuzHxRH5zKE4n0hs90ZnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926

NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'. So we can
use the strict mode parsing function nla_parse_nested() instead of the
deprecated one nla_parse_nested_deprecated().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93800f32fcb6..dbf1041876f5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1114,8 +1114,8 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
truct genl_info *info,
 	}
=20
 	/* no validation needed - was already done via nested policy */
-	err =3D nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					  mptcp_pm_addr_policy, info->extack);
+	err =3D nla_parse_nested(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+			       mptcp_pm_addr_policy, info->extack);
 	if (err)
 		return err;
=20
--=20
2.31.1

