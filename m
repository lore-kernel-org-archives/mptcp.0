Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70320F9
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645419060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jw95hgUonbYBW5tQ2JILrrakFlCBUVJbmvFA0itFSus=;
	b=Gp3eoOtBV9QQc7M1LmE+ACxzWjsPQrrFvUlI8zRmc2jA8+l1Cf3RzPMUS0Vw2INSj7pNMh
	hla0jIOMjBHggyjKN5WNFjHwxJEkGq0dAH+hENfMUt/jOG8CNLfW9MrLxdymVfG8KPHEk3
	gGZ/SNYI13Dsjt9yiDKOI/rYuOXSkyA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-eQ5QYmxJOoOQd6h54mvN6Q-2; Mon, 21 Feb 2022 05:50:59 +0100
X-MC-Unique: eQ5QYmxJOoOQd6h54mvN6Q-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1WwWQxKAc91il8RqT6YRks4iz12oXjvcx7tYzq+zgAz8Xyl698fvBLWv4YvYRPYcCaXqpxCK/xHa0gi8CkwRonHAPvCgwA7pqGcvpGS7QKPhE70JSnKnL1HxCMXY1At3yn6q3FeLIWm1EHdbDymOFCdvDA9mkkCYl0Aq/A3i1ZzeqjticWs5yU9Cl++xFfFO8wH0IUb9ofzVqDRvchG1kZV2jOMviZTYjNYsyS1WR95dsfDvg+P6spBzEdpGGGTGgnzxnYrHuj3A5FLgsVoul6R5EgmONm2UcM0wSacUcG3gUG3s9i1BTwNvpOSrcaOmY1ZcCopgRLRLT1mf55F7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Wm1biQbRc9buRmFZhMWnLLn67VUa1abFWygnCOydM=;
 b=cHxde4blsFxl37w82UDZxSKfJao1MoqioXAXUrwGZO64Mz9RlTP4mhBur+ggqv3MXleli0qer8B+uYNc8Xsgl4pssBc+xwTd+4Le+jVzPl6V1FiunDuGJRjaXF72mzKfKEHxrv57ZinvwLaVBv0nXOmg5Qp1s4mT4FPouM33ZFV1I2q16ZqgusIcRq8jhKFF20xTcSok6zWBr0oZg97CVx/mcf7h5WU/SDBAz7JhY4htZ6FdR3JzjsutHUvwthVWhjp5MYW1K0CLJWayvzqCpVRzDjKStrhibBYMHC+OlcXI1tyDWI9gfVJRrPUtQlLiuyjUpRpCFIQiGRItzSgczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5982.eurprd04.prod.outlook.com (2603:10a6:803:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 04:50:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Mon, 21 Feb 2022
 04:50:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: add fullmesh flag check for adding address
Date: Mon, 21 Feb 2022 12:51:25 +0800
Message-ID: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff99738c-b9c4-4d6b-9c45-08d9f4f5bf4a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5982:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB5982A1009687306910F66F66F83A9@VI1PR04MB5982.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJDlAaE2uUAzeUJJZJsHh/L6QrOWc7bK5ESeQNVwOjGDdfXLJPdTA2bL0t3RqXlo7UVNqlhHoJQw/Ua0txj3SpPoy7/3hnl+om2goswS1mAB8/0QSAI+SwfrAzMgH9MMzXTU5dJAIucIf9P5BARiUXmsPRE2X9O4nnuyyu4MVXnuPdDTjqBTvo03hA7Xf/2FtwLSdBqVYjnapLdAicMYH8X/cdFQcdUpV9/Bi+eNkZkp81ZVKXPMJGAAp+/RyYstRkqZ77M+L3AEwd/AbWm+9cZ65IjzvdHrT9nOT4yYrtZMvsRESOjuLEeKaNuAGjLDkFkt+gGSccH3XvVA5/JaG2onldMglwritEmcaeloNYE/Rna0gNnI5EKWi6Tzk5EjEdYE78JXYuipsJgf7lJToBLKEXd6RSIM8FDyuRKHwpM80y97VfYzzdhyrZ24sVSDmfZ63WHI4EIRIIqJCaH2DivSL73icU1p8bjCl8bU5YYN7/a8k1wTHoEf8oRHmukQpU7SiU8PL3pj840hVfdFlxjq7uHaqLrLvvlRsu/YA+N2/UauPRCyYbsmczb+CkvHYr+NxTFLySi2jkzeJm8rpLUKHkpwuBmABbATonukAr+4aClSKhWWWDKJsZnYIprNnJ6tVyP7m8pyAv9wjnEpnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(2906002)(6666004)(6486002)(6506007)(6512007)(55236004)(8676002)(4326008)(38100700002)(8936002)(508600001)(44832011)(4744005)(86362001)(316002)(107886003)(5660300002)(2616005)(36756003)(186003)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lv3CAOdIAdUUP0NJYV3iJmQ/zSK5mOP+coCvv7/S9P8ws+2cd3NQNouyKVMc?=
 =?us-ascii?Q?Nh6+/iCYyODIs8J52+5Qh8iTu8O3MRH5gwRQzZGO+RvdbFrv5VdB6RFy8cKS?=
 =?us-ascii?Q?FWH9aGE9O5+rvbdMdRPEkZV5Ez0C2xO1Q9bzf9KCogyFpYs0C4ojCoYWIRwe?=
 =?us-ascii?Q?G/fIs8oAMaeL93BbJaNzyFjJQZzYiivWQ8bf6g1Q3Jl8zHjeR065UMhJezyg?=
 =?us-ascii?Q?Ws4MjxKUykoZQKr1tMNuGdhI5ppdFGfeIbi0cwWu7WJfuEspL7U2s2+Ep5OR?=
 =?us-ascii?Q?Gqzi4+tqaSaGWa1kJHny3qIOppsN/f7ijP0ekRzJ+jgqFdvrg0EO6mqY3FAD?=
 =?us-ascii?Q?CRiHD8PGgzIlOcO5e3AiJTRIWyUewIJZb7NIGyCv0h6TLGwdW900Jegcbez5?=
 =?us-ascii?Q?TraId7wX0Dnuiyks24rvsCMevBRjRBGULhKIwKMU//vADIop26UAIEBdRUmJ?=
 =?us-ascii?Q?G5a3k3O8mvp61ryuUsGIjLVaDpdBZLU9k9iEd7xSTFe8salWYvhsWNX+ZNTW?=
 =?us-ascii?Q?9ltnz8FNaEFb0d0EhtafpY3mlBDzLqZEke79Pi1H2QrO/g/sUZdHqHAQcdoD?=
 =?us-ascii?Q?4pa4vFGbeZY3wij5dn6Hw5172nFGSt/6RvJJmmTOh6tMr53yaiL9ICTDlpcS?=
 =?us-ascii?Q?t72c+w6mgDmnWYTsOH2qD7b6DFOXZ7WSHkvlgmdY3JH0BjUM3iTaOds4hpDf?=
 =?us-ascii?Q?r7JpURkS3HBsCfebBCU/MTZvIrQz/rej2lMWiGO08GJMwHe1I7+JnJsNLwiC?=
 =?us-ascii?Q?T6YHXLB4uw5AZOQCkMTqrUDAFID3m7zQ3yCvflXLZskSABRzb2dnguxJR+dY?=
 =?us-ascii?Q?KqPHAVUS6dN3rEj8Sbv/0UPszpfxzluIJ8aIRChDzHIXk93OxxDXA3dtrkH/?=
 =?us-ascii?Q?xw6RlbS+SlBovD3zvmEs7cJmdT+0SqNMJiKx/qcvJ/hmJa4UcKrK/5XcILzF?=
 =?us-ascii?Q?xCxDNqlszI0fSzgWgYwlLFFRtizlQIe42oRlySM8j+562DY3JNk2GDcIDRr5?=
 =?us-ascii?Q?Ktw5IZZp6JzA2fCmL6liMZA9XbEx49F8aPu7yFUkTf3P0Y6TkJyV0pJTfpAQ?=
 =?us-ascii?Q?KzmR/2Niii0WSE+O+0vcqZU9eFWPB+mNnJdDEkdUhtYW3ZQQ6FArDtOULO71?=
 =?us-ascii?Q?/qBtexfNiHcdNyF5YLlZjJx4HxgnY586W3bLA4MFIJqvuBH4XjbEmd49PGgO?=
 =?us-ascii?Q?k4MmgahDbyt7IZYM564QsGlyNB2wPe8Sk4YweQSr58dWwkQMhvv9alvWK/og?=
 =?us-ascii?Q?kcuJCm3jWVn52talAumZBXZI8VTnhXr8eQRYpxmLQsQ+DJ6JgNcN3YdFnjj0?=
 =?us-ascii?Q?il/uDk0t6hzdwiG9rk4xSUMmYX+pJipJ48FR/TjWaUZWzGDfPRm4CyAPWmXK?=
 =?us-ascii?Q?3+cds1JULQQI7czis4xl+uo83YyHDbCdjjWTBqD0V6gfU2EaWKGm5d72CQFM?=
 =?us-ascii?Q?VeJI7BJHs1vMLVJYGLdnPeeFJSvUkA0tqZMNQEu52LTxhgOwIAP5rMStw3Hp?=
 =?us-ascii?Q?JNvxY7fLw2mgSarZXBiTO4K9ZGb8wsoTC9F7svVoq4VfkAGXhRZeUu+loahP?=
 =?us-ascii?Q?1ihtIInbhbo2tM5/Ga2M3GeqvXhgkWXi8n3is3njuPBeVGj4GI8nuukGAq8Z?=
 =?us-ascii?Q?1KK6FOpRlE0mLHHGd7a9vlE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff99738c-b9c4-4d6b-9c45-08d9f4f5bf4a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 04:50:56.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYme6iFgDJqhHBdnWkCvmScj1evt0JSYAV/BDVKi4YlWZEhpCGFyaydQDlsSS9IzqQQ6efcKPZqOKnwdCJwdaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5982

The fullmesh flag mustn't be used with the signal flag when adding an
address. This patch added the necessary flags check for this case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a0e7d5b7e22f..e3b0384ff79a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1253,6 +1253,12 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb=
, struct genl_info *info)
 		return -EINVAL;
 	}
=20
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
+	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
+		return -EINVAL;
+	}
+
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
 		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
 		return -EINVAL;
--=20
2.34.1

