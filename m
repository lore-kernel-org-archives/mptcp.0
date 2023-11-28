Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBD35888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UplUO7gP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRFxGGLHL35GH438vWaSXDgzCKRFtI185/TNRElmmUNNk5tYAuhrH2jcIq6fMOoFFWqNZVM6zit4GgAqDJ90+fzbMASxanljZ2LZBxxNOTE4kVYTDtLoEsud10IcXgBa80F+UOuA6iBXXkclLBKyiTCCyFSvFSFqXPBvcqf1vTzHNV2Ybb3D1jewofmaYiCcHCvkUm6DLu5WgkxedgTiUSOwsiLC3btM0njdIbptZWV4UMzCjc2t1ro516JBEhLz8KRHH4TqB+Vob1lgz5jnwWSK74j0dEimvolxG+p0kFDDj8vjIje9gPXv8NXsVY+Yo6dL1fPQS2YvBqG9jXdlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJAk8dg6gU0u9mClrfebSdE1UMczyeSf8LWMrUrVkho=;
 b=U3AiVRn7SxxNJMan1ugZ0140YSsBxLwy8P4tRfhjwudS4XywCIMfdmp2rDdnB//iWEKdhRm8ROEHsRD3gk6+3oyp3TblO0RjZoC5Pp9goxPyM3EE5OxQJHDzF0P9owR6yrBhadaC6dDv9aHyl/T7on6x+SgozvOmNXXTArgI7L2PtRfuRv1HXW3erfG5gnBr8iMLZHN5F3VYdmHAfJrvzjKM2Dl3dXrdTVWSHy2+Jv1Lp1mN8FSaCrbuS/Hgi+vtt5v6s/1W3c0uF0bU8S+9AbkIDi0Nv4SVZ87jM7dExIOFSvTAtSG0u/bQr48xwk6qsa5BADybrPypZyQZFMLLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJAk8dg6gU0u9mClrfebSdE1UMczyeSf8LWMrUrVkho=;
 b=UplUO7gPf/dGr0ZE4W1djb/8KcyK8jrwX7PDTJM46qqd4yes3fkqqWfQ947/XONjrtJStSDa0kYBZc84ty2Ir2V888kNwvgOebVs9x33Ul2tB6FkJlKb8YA9t/k8XTBrkJuIFV/aJPuOVj4DnvQRBwr+i+4Pq4wjKoP26eRP6pnGdnAsOY8P6Uk3UjjzgQLjnPfzv7hVoH0nYFy3dF0kmGRIcfi0PFfLnuHs3evT0IDMbIAO3KtgAg5ySoOC94vlSA0B9eq1XGHFtKg+xyN0wD8/HeLRCHWpg/k5654Zr6n3o81x5LkmkyOEB5tJqgBCkMkViSaeba7jPk23U1DtsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:13:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:13:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] mptcp: add a current established counter
Date: Tue, 28 Nov 2023 22:14:04 +0800
Message-Id: <054116a36337d50a847cdefec4696bf758f103fc.1701180777.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180777.git.geliang.tang@suse.com>
References: <cover.1701180777.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d54b13-1e8c-4cf8-bb03-08dbf01c4407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6hp16USHmXountSJv5JdfVQ/Ywy/+S8Brfa0vB3NZiN8ahENYPx14E8nXXSEiLoQT8pRPKfBpNiRdev6qT15JLEiK0cNF97G8mGyds889PBL/2rjkXqT0xVlyDCKHNDpzCabSRt5GNcmEnwThPUgDSPZ7t4gIpRo4eSWGHhSxVwB7K9Gx9zxFZ8elWqj2B+UkVsxoQu51ONfe3YCo8lyTtssezaBxrX7tfv3vXhT2McaTpvnFUYBpM+tqQBWzEiFsDTvrCKtIb4vpzZrO/ZA+D/ebGwEsNA39Ys82zq0Fv/ZWkvh3OnCIy7UNmqZqUTYEviGUF0TgkqKEaBSLO350t1jp2t9O2PsZuWNPCkJ0DbuJY0ShpvS2UAlpeOBnYK0Nn2D9+AA5w7UzRyGA8cZHkOKTZzc4Ugn4A5ev3ZEB7pWwuzMk4rOw8AaCcvP6mggxrV7Sy6yUgbXRwRu4nmGFgemoKrD0DGFA/CU679lu4tyFUpYldhP+HQ1QcLCDWcrQ+PhU4kDg1+P2s/ZX026KbSH979dneBrdX83B5EIS9fQOSuCX7A8U4CXlLvDLz14
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(38100700002)(478600001)(41300700001)(4326008)(8936002)(36756003)(8676002)(86362001)(6916009)(66556008)(66476007)(66946007)(107886003)(26005)(316002)(2616005)(83380400001)(6506007)(6666004)(6512007)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dt6Ax5EzCz9HbBFI0cqDaaVjeJBxgY01LAV6chrs+OVbv+0bDq0cWw1Vf6iF?=
 =?us-ascii?Q?dttcYo5avQtUWDjbaRQD3lDpyVApA1p/NrPezPrig38FXe651+RgEBpUaYrV?=
 =?us-ascii?Q?O2NeYwVLB4kZzzHTUJrSAjP2yvIDJpK7bVn2JiYf3P2p9jLOyv3g2/ZwwY6K?=
 =?us-ascii?Q?m5rCpPTWuRRgLxuCA4tvIr6EuRY7D5myLjiWmbQrXTo92r80KuJTDWL2KJG3?=
 =?us-ascii?Q?RGJ32jVWyqcwy8uYunS9bF+s1iAiyOrrtO87fUQWkZWdzM7D4AYrfapg6xya?=
 =?us-ascii?Q?t7fSGQ7vOpfFMgV6EAnfYgXCp6QIJlH8K9o2I7GTLDwYvnk9jvlpGB15+nfu?=
 =?us-ascii?Q?l4r9wRpnOK2TZdw8ECdc8lbv/qIZxWOXDkB/A8qhFsxKxKqo7MWZcnKKaE35?=
 =?us-ascii?Q?a/rNYlzMF/YRPn4T2OidvXaOlTZfHEXeqm++sqsgrfOhnt2+kMDZoMxUj20A?=
 =?us-ascii?Q?N2Ul7q0w7upMPG4L4ZeUSQdaBprzZ+gWGp4UD6FDProf5k73IVOYx3TofQmc?=
 =?us-ascii?Q?cDbKaUnJcljtkZAR9aa7t3i/jnPn8DAMLrXOScV3nVdbUa50fEWJgTJhLQyr?=
 =?us-ascii?Q?Li8MK+ZY9Kv3F2CxDUGPExdhmmoHuCiQwZ96ADeRYAWB0aYNHsUZJYLaPkLc?=
 =?us-ascii?Q?+4MJKUt2oPg0Q/fZ/JhT0gdJjpzMyEdqHLk8W1fhrmrFrBQK51lvwdcf1nK7?=
 =?us-ascii?Q?+Rs/wgudjRf7fLIhPdz9HggyIUSptMySP+DwZitca8iNRH9kWA8G7Ufm0PHP?=
 =?us-ascii?Q?iQINd+ue1uZ7DW2e8xqg2nikfruiFDCqwBxcQrLFRkh3BVfmJ4u01kgbZlxR?=
 =?us-ascii?Q?P4Wusdslj7a+BdkGtv+9sBF27ZB6RVjQKTVtzk+A7S9quuQDlWytzCwebvUy?=
 =?us-ascii?Q?IkFvMWBv8rA5CALzolQwmc+MLo5HI6Ycc6GTHvWsnkeUemI8qoAzwKuwT6FQ?=
 =?us-ascii?Q?JXVlAiO8hRsCxgNfnrAJ9E/wT1xWTom1yFST/D5+xpCx74xCZPJ9Z4L+2ucU?=
 =?us-ascii?Q?yBXqS4zl5VTITS+jcBWbIl8LJWlXi1mB6NS6pTVl1zyOL9ugffW7koiOpQGQ?=
 =?us-ascii?Q?9+zpGdbTGGjn9OirWuJ9FZKM8CnDAZzsRAE4nN1M5vyqFlbaYnOSEr4o7ih8?=
 =?us-ascii?Q?3HnIMRcN/AR4Vk76wfXh07pxA9YBhbzIw48N2P6uNkALmGdNTAjeJt2ZWJj7?=
 =?us-ascii?Q?6/ceAsoEHp4ewyUUIyj+KwGp7Q5Wege2Jx2zLO2job09grCJiZeASB0nmKIA?=
 =?us-ascii?Q?BN5TOz/BOg2dX3yuesKhatVkZiKpQ1FBm7qFHcaeWbvWqHXkUpF7Dgu1moMR?=
 =?us-ascii?Q?FEbaSx4vSsNXeRoutpujTlN4YOypINyFv4cQB3kylyFa4uVtnbwkiGFD+X6j?=
 =?us-ascii?Q?yvQOsfRb4jKDJ1xVJHn6Woi/0qn4c8iNxO8pzt72Cj4l2Eg6M/VRKoI+fLNz?=
 =?us-ascii?Q?KYjDoCwDTKXDDJYWqCwK/F3NKf+jV/z+ARVe646HgWg8mr+H+iSALioWiEfZ?=
 =?us-ascii?Q?RcJnR2BV0tgo0Gxl77/S8PvQ01tLZyqMa2FYIIrGWyDSni7CbnRdra49nKIA?=
 =?us-ascii?Q?Pu2Ha/OzzI2WoEv0SI/I1FLB9GDQKcIZspTHvTD5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d54b13-1e8c-4cf8-bb03-08dbf01c4407
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:13:59.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKGr+wNaw/5fRIkFiYhU0eFOZ0ewH3D4BEY3yRX09+OUBrp7WguGXp6Eb5Sq/iJtJzf4MC+gd5LeWMcTgGn48A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952

This patch adds a new MIB counter named MPTCP_MIB_CURRESTAB to count
current established MPTCP connections.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c | 1 +
 net/mptcp/mib.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a0990c365a2e..c30405e76833 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -66,6 +66,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
+	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 9b7c366675ec..dd7fd1f246b5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -65,6 +65,7 @@ enum linux_mptcp_mib_field {
 					 * conflict with another subflow while updating msk rcv wnd
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
+	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	__MPTCP_MIB_MAX
 };
 
-- 
2.35.3

