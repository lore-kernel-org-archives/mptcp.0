Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D528628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvgbazuusnPSZywuCdcV8yUcb57QeJN5H5pJv4BMgd8iexSfDmaRLvTgspwOZaxcWCMulBME5y7wlU2ltfhD4KhYiGA9E2feJyTfu0JNP7ebp+HL2JCzTmWpW3ReHn0hP5BFSUmeiAiPeXl3EXisvlB7r1K1kcKR4/XrgjV18PeuBvawOUF6VUP7PLXCiJiUyEyyDuq0JsuK+LPGbSMSCIuxPSyazR9DvQZJp0q2ICvpTgluuQrbTV5aN5G2PYIQBcQxy0aokivYGje17+zTiO9tRfTumYnRM85onNGjiD9oOPZpnIEkCDyMb3PQuYcC5jWRaPG/xZBRz9vJjTAmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS55Nd1IhZ4P8MG8+BQB/BMHawHySbYTisHKAKZAGOM=;
 b=TeYFKvO2ksqP+FJhUO93BnKEXSIBw8hsdVEIH0LqwR4Qd362Msy8sadlS3TUDoUej8OrJguheTg05Mn2xevetzAUTCPVU9xF4z3wVhhBOMc6vNgWohLdKRHsN+c3W4Nek33+nQPKrHnsf781/QCcdqF+cmGLcXXC/0HFTievU5ltoYNi+jJ0iuaHZn8Ya2grR3ulUVr0wttWdc2HLZqN1KmLA7srolHBZQGvD5+BHjHLMVrkb4zQe8vBQx5M7hv1WkqWvezh5D+6IBzg8UirN/vszyl99qXJ/C0+0R1y/KY6fpBhHDk+9wyWEzNx6wDZyue5dcf/L9WXQ4+iy5UOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS55Nd1IhZ4P8MG8+BQB/BMHawHySbYTisHKAKZAGOM=;
 b=D3MeFrVoi6jgrFQ2+vznrniC0IzY8aopaIcg0uBHASlxjMeQovwU+aB3cwO6zCZW+NoqYzAjcYLD7RKzleBsvYle8yDQX0nuIbOaILrqN1MldEGB3NLs5UwyYBlD5LKlh6W/8U+nJ8/njZeTpR/brDu5JRi7uO1kuG8Zw6SyLJ/zf1pqNC9H/xM+4uL1xlU65xUSdf3mlJ6ioocs1e7d0bqpK6ruCeOsxyocTmhbzq1dBZtA29DsprArrgE+LkClt6QaCwGo1h5T/FGHlyLdy4YX+0k7uaDUfDlLM5yWBpIc5LkwkNFEDloP6JN/6UxyrPIXu7489Lo9Np/bxSHu8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:49:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:49:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 15/17] bpf: Add subflow bit flags write accesses
Date: Thu,  8 Jun 2023 13:46:53 +0800
Message-Id: <1c112db800949f67ea4574c0226eb077c98a6283.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6a904b-dc79-41ac-f398-08db67e42171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ouWBXyfIF7v76UUCYySbmwa9oVwHLeCd/SK+y29MavCOBIDxuSlr+SZP+oBwB02+XyYwtl9BIKlosg1bDUWYhgl/XfnEdjYBq9fZZG4WYgb/Z19rc3Jo4Mht3hO2fa1mJCVdoaqNgMkTFp2ep2Ixv3uRJoHp+jyoGtI73NcO7Jb2QJ+F6J7p195cMXCneZ0SlWXKW8otdG4RBt/ZorQYHBGHxaTDWPvTmZBUPwN8L/XeS67zTtYWqop84f3EyRkOztSRyIiC1+a2cNjfcqF1oiDCsSopqeEzBdVLUyTZ4FbBbaQHlTKKToTX4EnCl23vEhrlln7VIKrwSJqGRFajTk5AsrAYCR+ak3dI9W8/cazHJ5jLdKv95B79bfvF/fTQdSq8fXx/dfrqo7KZjydjHM3abuIc0BBNOHTpWWc6tS26dVInnrdb33J2PZvhoxQ+1dYLYsNuST+uLaC2VlbCRWXORJozOm9QWbXffLUiFp/o2T4Hpvk1lbKHXhojQf57JxNOC2h6v0abMc9TPP+FNHOumngO0h9xYWomMvpVkqMBqj6qI9AAZ+tEMO7iW32+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(4744005)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3C9VrJ08DwAhyEN2ZH7mlYbg/5OceL1usVJFJaOOAD57jsbvOdV/Y0qOzFCG?=
 =?us-ascii?Q?sXzL9ou3eTvPtpyfXwsUGb84YqnQWbYW06GtZkaNeOqsvo6kHzEK3IAipm9e?=
 =?us-ascii?Q?TjsUkerAMd6e7HMpkq4F31qojotUzDD6fXc8XDY4t5Y6fi3DZiT/sY2mIcKg?=
 =?us-ascii?Q?hoOueBNHBkm4K4/BFRtp+kesH7STAi8hugkIrwxhzx3kpOySji/Sq5VL81hh?=
 =?us-ascii?Q?b0BAYTBNiFwHSYKPbQGzx38oKHNW7G3IsevQyiKIvgdS08Eq+uf5wG1e9hiF?=
 =?us-ascii?Q?QHAaJUhIpAZ2DpQ5+TuRbwg5l2CvL2rdJPj4NxiHDBX1yb+x07FTqxhupUWM?=
 =?us-ascii?Q?FQt0P2478xH2A0oEEhnSlTopsmam39Oxr9pDt19h6pPJOm4FYVvwwBUT7k4k?=
 =?us-ascii?Q?64bA2R3JEjpp/hER9mhlrUTdmXVGvuZ3yPcxrdjc0tugqVGzpqdv6A9RqbP3?=
 =?us-ascii?Q?fmLgvwtfyEnf1MaLcL/t6uELasCn2qr9ceOMmhYkVJvVZd+r8MlbAWiL1i4B?=
 =?us-ascii?Q?TXjN5BExtRLakr8bXYkDrJCIuNky6zt73C0fcsCHHNFSzCz/RWPl4tLXcXq7?=
 =?us-ascii?Q?Gz+Z380we4VnNaBOtN2PVDZp6tzzMqOUMdjqsSYXm13idXhHxa5wtWyPSgyJ?=
 =?us-ascii?Q?js7PIdnei7cPGeG1JcVotHfkGmiKtIJG53IDb71Q4H9cOO0bodr4tck++w50?=
 =?us-ascii?Q?C8DiJZoPNHA/5xWFSFpG4pvu4m+lS/G+AL/r1sLc829UjV/2M0hZ0T6QnlrC?=
 =?us-ascii?Q?BZdauj6wsgAAk4V0DNl4p3mmOtTUgKJQwkZ6a6B1YKwpHeDCxdSjxHITgikX?=
 =?us-ascii?Q?aFHxPMnbL7mJZQRsz1WqUUGyVbRw3Uh0HPx+LG2eIVJwVrS50BKsDP60Moyk?=
 =?us-ascii?Q?gj7O5Jq7KUSKNMoRdsI+GyZ84bO9LN9e917/oUHJpg6zePadx3UBUCf0tDjw?=
 =?us-ascii?Q?NLmd9axQPEq7StwhdNtOEJBWbBrtwa1yq9cnZG1yJYt/M2ShhleaHDYaXeb9?=
 =?us-ascii?Q?4Dsv/W/+DKYDw5g4M4Xyft/9NsfeY/LEXo3p64e3tR4MRgTaImlPPFTXvBD2?=
 =?us-ascii?Q?lrU6+n0N9eCyJMulSaFLZRy61ktQyHRgw++aU+krLOq4SmpG7NaD3mhF33WY?=
 =?us-ascii?Q?D3QgPlyHka3fZrLNqoI3DilCYE2Ow7cud4ST7y/T1qz3ktw2BHDOd6qCS4pu?=
 =?us-ascii?Q?MRm9wCW01A2R9VCWlXQRerQDJA6ZtvXV/4dndFlQgchbLCNJkQTiFB7Cbskp?=
 =?us-ascii?Q?cQRBnl+/4YYjAmAbUtn01OEbzIy4O9ubdiePmTN4p3d8L2cUkR9t8a4Xp/0O?=
 =?us-ascii?Q?DCEofNG5NWf8XSXIxmT7ERM865y3CgJ/Z6ocyTuKyuu3HaX01hbMq+YsoklX?=
 =?us-ascii?Q?KFoiY92h+VM4eemIyhveDXMCFN89BLqEzDcm1TzffCYdlknEPGpiy8MlYNIE?=
 =?us-ascii?Q?EjDd7ANc43wH2jqeH63P47lao8pdtCIzpdojnbWECIEsET2nZvYY9m6/sGcS?=
 =?us-ascii?Q?pgDEv4s49+llnOkI6t2YfrGJop5LuxEZ9JLlG1zcjKMt8//hbyGXpdxJyyir?=
 =?us-ascii?Q?PpBKYcm1k7t4HiO4wd+bGffzFJv6EIY10hyXaQ5Z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6a904b-dc79-41ac-f398-08db67e42171
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:49:31.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCmEHe+eojGBaVA8Vc+F5mlFGEcOvOyg/5D/NaZDXcx9Vgbzs12/6KckYEcZh3OKhismVPaCB6UGqe4aYGxBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

Add write accesses for all bit flags of struct mptcp_subflow_context
between map_csum_len and data_avail in .btf_struct_access. The stale
flag will be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 4912808edf5a..d46d53fe193b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,6 +51,9 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetofend(struct mptcp_subflow_context, map_csum_len):
+		end = offsetof(struct mptcp_subflow_context, data_avail);
+		break;
 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
-- 
2.35.3

