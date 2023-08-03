Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314D846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jin7SRdtzCkoGyExNYNMNnqA7QCnXBRAb2na8aqkxm0r+prym+Hnrqgg0PA87r2oBXqmEkcEqClAXHFOXx2RhWey7chm4irnfc5vZqcHoLCj4pCpprAx2zlp8chzCWZXZvIl+yxe2ue6/3s+8IW9ch+5UZbMr/BVjrHpKHgPstXBcEgXNIpom0SMMQyRsvivmOZ9W0QB1PtH59wdy9qk1Mmk1FoqBgLt7jBRvLtQYazruUUmd+/TEH8oWuGXXrZul9bb6m3NZO2vBS29lLjW+blXn5hYF6rzuMahTNkLW2d9NcwloVFWNCEwd0nom6wWcKoLCPz+8hqzNVHsWcKpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msWpftxtBYhi4F/vyxfgeHNUPm/VmwmDKYkSATjtVn0=;
 b=Ji/dV43jALA1GpAhjzl4nXXs21OTs+EOT4FTj7dTJrCsx4veSlYY3GiJ09g2jsEWZGZWcyyKr1GX+GdLSzTPm37+FCxUHCJlRaj1PAJqlQAd4kfVvoO1ZdS9nDVQCxQpOBwwBj7+Icg44UHqSZPRvX6eB/xuZQsvABtRY0eY6h7qDrFEGjz6r32dA4CRLNC6//YbuwTmo9gAY1J0mZm+lbuVHm9ZWtQi0SWZAOb/iAVD9fWhPmPFvA1Rg2QAhdYhhJqkQiK654vMl2BQgGGyQ6cv7gRMJpqar9mgMDcJuUSNuOzfS0tPLCtHG+39gzMm44i+i1yqIAt+SET/CC6esQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msWpftxtBYhi4F/vyxfgeHNUPm/VmwmDKYkSATjtVn0=;
 b=UmLfPe3BdwjakFxTWlLV+nW7SI5yyceGXmAD9o7mhz3BrmbWQSnhN/1Bh0x9+G5y8pP/9iGG6881QFp56jLKMhOb8LTr/TqvURVt4WRBODo/bmD9/j9UpGQYLIIpF2apIEbZ/tf+clf8gR+NRbuSEuraGQ8F1pzF8PD5l0rfVaXxmZUtpxuYxgumdjBMjfbZUiy27CHxeiZOnokdlJ87NI4BlJc4hRZlRu573w2p+Nw3lBvZA82pAxxPQVmIo5I3XQHDiFkhyXpEVPRKPFHb8ejmotM8LFXEjGp9u+Cq7vQj0rYGVKZK8jCVriIH9EOAaZrgKVHhw5H88ilCUbqung==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:27:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:27:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/6] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Thu,  3 Aug 2023 12:27:19 +0800
Message-Id: <210649a61b0ff7a722c1393b7e7275fbc87484b0.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
References: <cover.1691036765.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: f36bd21b-c32f-4db1-4e31-08db93d9faf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IHPaZeuZptrJQfw5o4nwS0B1wwDYBAswhHEyAgsbXLP2PMH86/m41tiQ+At1CpiAr2zIb+0u+oMDF5y/+/8YWk5J3rx3pkO/bsCFYQ7k/JK2QkbpZ88yygpdboRkNVHReNWUKHgJ4+GYNDPeZfVvycjgOheCGHSyIv9uyopaZY6Nw/lxKXwNDLOVDe3vfNRbA7iibofzOaGTndlStpRLlm+bOhKOkGFXFD6gEvNJ3cuS+Sk4bLl1UK1bm7cYVgVl1MrNr749msK/FRorbeaWmTixmVeENRfhQDynoanBhxDvl9JpNOD8bo9HaVJAs4N2z5tJTCo/msa1+R4GIkta/s1dZcL89IB6fKEkuSvI4lM1Js7REPVDtk2SyMv4oY+wLYCQFeEU6JFF1b86Sr1aeI6VgdrxzNenQCEdIxCc1/qXTk9sJiWnT5D4yR7tZggSi+GiTnO4BUUpAVi6OO80KPC9/XAwl9j89DyYmqxspKsxZlJ+EB9Ja2intnnoBAKwZC65vvTld9h7Tbqaxl6roIsKX6wEM5lihOUKrl050xlPCKs4BjsSW3OQW/4TVZFabTM5t74oJ2GwyEPIT8nU6LYuSX9aJ4ukHPVss1EhzLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(4744005)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/meqOjkJTEWTH7AFP44s92xzWfjXfv9Yhr0O+qhOdNSR3SQqCfoORVkEVya/?=
 =?us-ascii?Q?L22siLp27LWFVWbBhI0OYBAaA7Hub3hHehOnI+5iOxPR+RAvzl7ZtVd6DHM1?=
 =?us-ascii?Q?Zzb3oIkrvAcs2nHMEyUwUKOxBsvP/RkErvVDuAYl5B8HS7ChUOftmZe0Xbh2?=
 =?us-ascii?Q?UgV+vRxfasXEayqzbG9RWiJ74lF3e3QpFja1qA4ub4TFKQ8o0BA/dVGpfA+d?=
 =?us-ascii?Q?7J8cQYRobLcPSzK7rtN0FBrDpGKUm1QwOZzfzf/YQE68XSlttsy82gCGC+f0?=
 =?us-ascii?Q?l7BoP5cZE4Fs93HiiCl7v2KLNiBevmFwAnopdaxz8ViC0bZklWXRJTk1MXDO?=
 =?us-ascii?Q?pTQrueCYca1YnlE4qtmPh3qcA8E1tQNBj62rs6XJ8JeuBndEnk0Q/BFyf1jx?=
 =?us-ascii?Q?sr0z2/4gI6WJ+rYQZGaAu2kodXco7NWPfO4GFD90a9YM17VLDWhtP2FNk1cy?=
 =?us-ascii?Q?VD/WOM/bbBardONF4GMqmxabSXAmulY0GL1+HgNTwJFnGrNPBnRfV8Lrvgp1?=
 =?us-ascii?Q?Nc9w23dGRfLJL42YPgxKkSNTIyy9Xd5OTGCXPqQsPPwZ0pL447zFIjbv/RW4?=
 =?us-ascii?Q?k9nwLHRhGcaiEl/DP3kjE5FgSvE7Fml2ay4u+l/dzsGdpIj4xXxpVxIS89Vs?=
 =?us-ascii?Q?eirZQyUooYNI6MVzyRJbgNMq3mh6sbxzTeM77Wk9aJ5M0rp6vMJmFwEIy4XL?=
 =?us-ascii?Q?KcBkgb5RF5foQipM1ty3O46zbEmS1qqA8WsxNQ2jQs0K1JqNIQuV8Fdq0TiL?=
 =?us-ascii?Q?4P3N7hSyonyV+RAM4hE9ZXanaEFeTeICKy4oXtxXGAXRYv4MwsOmJyJ2zz2b?=
 =?us-ascii?Q?pjehi/9XqBlOEuptdzC9SGk4407yHQmpzLsx1NrXQq+N00LTv3deMsrFUWYu?=
 =?us-ascii?Q?xFCb/1CZmCqyfSkjGGyEHxrfoMNpfuT8g1zRoJP5b0ytvfSfVUkyiI2if/Qg?=
 =?us-ascii?Q?a+MjvQ2dto3H7t0hPhpKbppeSc869tUwLKWt/6ykGNoOU1kbHosUImL5Xd7E?=
 =?us-ascii?Q?9X7YCp4uwLtV5Lb8XzRoELt7hu9X/3dq/ek88r211ludBTUoHpAFtlT9CdI8?=
 =?us-ascii?Q?XCLw0/u1zhq5xfzzCyq1huo2Rg3Vyx0FyTKpC/ccu1p9vzHEhemzR/LVxxYa?=
 =?us-ascii?Q?mbReuAyvs0zz6D9BT9dZojyJwC0EstDnLBHQNtM8/1+JCFeoyFcOA1vge12I?=
 =?us-ascii?Q?SC+mAK8DC6qmecTGlEJPAteX4T09D5HORYmQ3x397QqIakZYcRdaLgeIGJRb?=
 =?us-ascii?Q?r8xyNv8QnvfJQqGJy69WquZ2micnZHzrgA8F4d54RVFZNb35QboSCqE11Kd4?=
 =?us-ascii?Q?FNyTrpqsfuIThXvprMaBhkbbZi9iTPKvPxPFIZyxulkr6w7humEU7RyFVXhw?=
 =?us-ascii?Q?z3wqm24R8W1jtJt5935iG5soljIfr76gUJuGJCS4ZLhPNc7NXntF5d0QXHBi?=
 =?us-ascii?Q?WOa32Uq2UTkbfwg7aJAaNDmOETC6SVhjVrxxhHEsIwsdeAL6vNsLO0+KulsE?=
 =?us-ascii?Q?T9K7fDECaHqeDKG6Y1aZGhH7U5JeKVoad9m/2CiaOCocAZFnU5bCKbvrmdVp?=
 =?us-ascii?Q?u4m3zTIQh7chmupayD/7OqgO+Ot//jfOGrEctIfU+vNeffL0NDo8Aiuoslzr?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36bd21b-c32f-4db1-4e31-08db93d9faf4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:27:43.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCnyvvdsHSHUHrQ1cqzm0FOVcicpe8k3XdQ3NG7YpxfLpY4aR7WRvjWjQqo8ovM5fnMifksLRLSX7dmKgSXz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Just drop a black line.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ad6b5e889d9d..09770aa31f4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -198,7 +198,6 @@ static void test_base(void)
 
 fail:
 	cleanup_netns(nstoken);
-
 	close(cgroup_fd);
 }
 
-- 
2.35.3

