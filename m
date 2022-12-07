Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B01FA4
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 11:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hamadf5h+DWyLdQ4wHjMlER2vxaM76SEcgCG9qR5fkxqTpw11xLYRKU8TqYn8AFmvrcLOdDDsMEIhJCpNI5eknHTcV1Q+KiRxh6ZLplLGiT/BU3820V9y7buGstLg8etKmyzbu07g45tMRiGtdNW7BGwYI1p/5dJ5v2BblECvwNH1GNaPdxUzyzttAqyLPu/WjfRWbmxhw09b6WWx63zsymrhqv0UPzg40WJRcBZ6D51AhK8XJknSo9nqngk1XebovnGsYvqo7FzRaWB4S6P8X+x8SVm73fpR0u3/BOBuyvMdCnDqlNp3bcKuJfssCt8NKBqkC0UeynYMpVbG4MJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/puPgkn729MiTeCOtpQKRG6++6kAsV05B0crRKCj2k=;
 b=I8BMLcw+xWSP+2xeMSUYDPXEso+e3yMdeGxgX92Zr1FFeVPH4/S3MTRDEQv59sYMzRZV8ZQyY+DAkvkyz84NHGoqyu4xfauayrvPY65lJWar+Ed4Ac/JwRjHI8xK7LuY/Tc8m7uELFysBRd13j32ZN/HLoeRBxg9dDb2TWrho2YfhzCw9i4vr8Fi/CBMDoe5bELR+RJt/yE2lcQc0lUXiAnrYqhJeokGqRfb1yMvZVLde+C8pY0uy5CMjA0z583aomuh3LRb6oc88/zRBWxDUN1nqwnf7niQGFZ5QTZ2bfZTFzfI6azJEubbxXl2HZBp/mFDDvPHAVnTuY3csy8EpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/puPgkn729MiTeCOtpQKRG6++6kAsV05B0crRKCj2k=;
 b=P1DbXDCEYegcizMiEi1jLt67Khne5CMHlAZsEacCSVYYfqBqjUgwnmk160Tl1aEJt1+CO8LDRwNckyqkrjRd31OdGCW2wixt178+uO1GMtrKnqittZtqPXPcpAjOjx+7kuJM2NAX0K07xaXNy9aK3nNJMLQF+x6VeENi28QBDZa+dEy3RpdMYNZDpz0OS4tbBNje491FaxYr+E1RFJ4s8CYhi4754S6B9yUZOya41iu+P7VGX+lBcrfenIZyBCNSsMsy53mPlLf9A3kRYy/sT9oDOUBC7vsLqYeHbMsQGeYbfb8VwG/VzMN2v6g1LAGIbdmSdwO2TZK7sAw52JlpkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9374.eurprd04.prod.outlook.com (2603:10a6:102:2b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 11:05:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:05:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/2] BPF redundant scheduler, part 3
Date: Wed,  7 Dec 2022 19:04:55 +0800
Message-Id: <cover.1670410690.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:403:a::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: c893b021-7433-4c60-9bcb-08dad842e808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rRIL/9a9R7h3kRGaBwbkPVI5InE+PESaxi20YNLaVh8x8aV6PzIW9sqTN41QxY+ChGSJXlREfwPljx5oQYWei1t8ACTmnHCJuU1gBlpKFNc2Vx8U7238ue3CaX0lhaXNOESUqO7uG9c74AKVPwVY8TrLk/Gb9hRye2kaL+3hJlwi0MLR2ZuqmCUqJ9N2MSVqoq7Vaca0tZZJ9sovhO8QCLmswGXdKnnk0fleslq8hdUSSr7tSoJs/NyAXx/W5MtzCo5nXCmbQxzrCFlHuBmfhhtIOkgu3FShUyVN41qNfbCDOGCWIaJ3aBhpuOkVtNd5yaSqdm4bJw+avzaIi+6TLl3gItmumG6RF2IU3kC3NdAPsk8IS/Y1N4wlhufsEhnULo6iCS63bAGrYJxl7U5+dnnce03/4iRh071pYXDPN5uRFVBK5FhVq8jW8E95JqL2UqbEVPUcMzx7JWQCvRupnc0m2qg5xJSDXCujtKslrNdCPFsRvdKtHJDJXJ2DA3/IV6vwDrjVYpHwC889ZTh8KNXp4ctZZ9Ci7iE2hGu4r0wJpITOEq+qTOYXwUdWsbhh9nATicrOjZUucuQwY6zoZaMkstvJcPHjgP02i/OyejJ97c9ZqxchDIePDqlzb5Td7KBkyvi+Hi16FpqkZ7W7lQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(83380400001)(86362001)(2906002)(5660300002)(4744005)(8936002)(41300700001)(4326008)(44832011)(8676002)(6506007)(26005)(186003)(6512007)(6666004)(107886003)(2616005)(6916009)(316002)(6486002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UrzQ841RJvR5ZQGNFUjrg6XRY+yFeXkTxzj3rT6zYNl63UFYxImXJWz6BuSG?=
 =?us-ascii?Q?CxqY70fayJzRc7lWPG+AgHWXkNXGC/iG6RW/oFUzZCbSX3WYPweC2GwwR3+Z?=
 =?us-ascii?Q?5UrbCBwchDFGa6ynLBD5bSm9fnH1dnNnF52K4Q92kOhUwInbl/OOwHyNilaA?=
 =?us-ascii?Q?GifXp7QnDE1Jn9Wn96fKjctdZoAwzLEy7mZRkaPGQ4i61TOa6dSS9ANHxM7s?=
 =?us-ascii?Q?mCqV0YH4bts8VZpiMmsTL5vtX7uny8r44TSvK5FY23mqJqdhfyUPsUhYr2H7?=
 =?us-ascii?Q?I1QzwqsWeYNbDhbixH+92i59ONjyExMC0d2N0V+sSmMHDQGY5+Oj+2sNhGiZ?=
 =?us-ascii?Q?7ySROhJFjzZnf6voAcqHmCpk5H3GuLLkFgPdDyCyGv1od8DEiqGwYqAvg4ej?=
 =?us-ascii?Q?7od96zeNAgUADLTrtyHx8D377or5FO8UTa57AD+0P+MngSHsGwhamFeMufPg?=
 =?us-ascii?Q?+ENVXFZYatSM0NkJr9goZJebSwtJeFCCCaaxh8yqxBj6mSnYXqVOjY2Ha1Lu?=
 =?us-ascii?Q?+zYWikzwn5YJ/WI1hRXuI5hYhmZr2xvb4mWXJ7kLbmbJypuD7ZT+CRyKYcq6?=
 =?us-ascii?Q?4kWr2DDTVo4xqRMDKnqmCOQe2ZtZz+qujmIQGNIiQlh9CySp8G6BumN0yFOF?=
 =?us-ascii?Q?6GAeZ78VNkuU+II34XKnuTYk24UvQMinDu09Efm9F75jlNqUd/9bTzZ2BdSz?=
 =?us-ascii?Q?Y7kaDf7GAtZNhYBPUDY0AJQ8eNtfRlx6HHtXjJ2JQvRsD/MVE25v11wvwCV7?=
 =?us-ascii?Q?Tfo0cJBAHxLMQVnQxUuQNgI3QImFuOh8mB3ejIcpKlQ/GSibvpkBhWg41IvJ?=
 =?us-ascii?Q?/tEatwrEeXmBiGEduorLydPINqDUdcOE+9zfB7JScf6GH6wHnUzl7lCAsY3t?=
 =?us-ascii?Q?YikdldByaPZ9SC5gZ68ecmBnZW1hBLFvYLAvtRvbd3l8xA0HNXZgin7tgFx9?=
 =?us-ascii?Q?hOlPabf6UbcnBVZyLmJ/WkQG1ITFNVX071q0kUc12n8cyZ4tk6e/dbNGBtag?=
 =?us-ascii?Q?tNY0ss6zLoemCGygvFvnPG2Fj5FHUyTUhfxlbI3UcyA9i3JdTubx9vi8ZAAv?=
 =?us-ascii?Q?h/5Xobs3VZaNVnuQe08ShpzgbykNTBs6kEZubLNOTqRyniV+HTSTJBNhZx54?=
 =?us-ascii?Q?kNXjLb2TwcNqpxgxiloLVUA1qJARcvy4KP1bAQorLnvYp9JJQ/Spfm9sGhyT?=
 =?us-ascii?Q?OE2udI3lBHlhVzQZyC57QzH2gBqJgfIPtGd1spYzvQalg+CgP0y46itBuVYq?=
 =?us-ascii?Q?+T351V3IsoXI/Ldt83CFhDEOgUHmJAM/bxC/jEkY9wTnkE2DK/HYBE4NmuC6?=
 =?us-ascii?Q?wU6yBMiYEYcobuEAdVKf2Tyg7kwd9iDDupvYWmFvplSbYB+LQxSI+yi3xOAW?=
 =?us-ascii?Q?otWGWs+WAjb2TQ2hNI21hKuKQ6UuKBhw5trx+qVppH58V7cCFoQsaYjXcl+p?=
 =?us-ascii?Q?aF7Z/2HDxhFlSlX4cGDtniVb8zHHrMDm+UJ7kKESJGe6lWcufsKj3wmm/UER?=
 =?us-ascii?Q?gBf5C0V26CjSAeq4xSBLzrprYH6mwp4PqVoMQiLHMgQlt4MvttdlWtehIlBP?=
 =?us-ascii?Q?VB1HVdsqjqt3FmYwXNPluoM2MYETpexgW/dxMA6GYWC5+tC/7ngGk9Q1ec+q?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c893b021-7433-4c60-9bcb-08dad842e808
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:05:10.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Coxh3HB5BxH+V9NU4bs7bCYMNGtfWaBv45Pu9XhsW2s86Oi31xmJG+IazK8tsDVrQeM26U4pMpAPKWYo9IltYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9374

v3:
- invoking __mptcp_retrans in __mptcp_subflow_push_pending fails
  with a soft lockup error, so use MPTCP_WORK_RTX instead.
- invoke __mptcp_retrans in __mptcp_push_pending iteratively for each
  dfrag.
- depends on "BPF redundant scheduler, part 2" v23.

v2:
- drop retrans_redundant flag.
- call __mptcp_retrans() directly.
- depends on "BPF redundant scheduler, part 2" v23.

v1:
- The DSS issue has been fixed in this version, and all tests
(mptcp_connect.sh, mptcp_join.sh, simult_flows.sh and BPF test_progs)
passed.
- No need to set already_sent to 0, drop this.
- Add retrans_redundant flag.
- depends on "BPF redundant scheduler, part 2" v22.

Geliang Tang (2):
  mptcp: update mptcp_push_release
  mptcp: retrans for redundant sends

 net/mptcp/protocol.c | 63 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

-- 
2.35.3

