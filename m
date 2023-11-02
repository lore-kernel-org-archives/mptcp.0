Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E0125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KrdSa5u0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvz+BQJ08l6Biq6ko8k4l5RBbVGDgpj+ET1Mgm8JZyE1SLT0ePstoTB25IFKhT7Oyn8cmzakppVqDCWr6DYa4EX4nznds1iD5jLUK7l8ts/oMrKd16ebAAF7tW/6raLG7YQZ7BXIZD1MV9MJc6C1t3LDCAnwxsoYcpS0a8MaEIe5Ugllw+FZ7XCuTYnKmg5iC1NzVRPGKewHxueoy8j+zWLD+ZxACEmdQhcbwR+5wMAuS/mRchhybN1SViO5z0sxby6q1NXBjqEtnJW34larFjSglH2DQjplDqC/3Ka5JP3XfdNDZgPtergaVqjlBaYk5HdAJccWawJ3pLT2jdgcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aaa+K2dS+O/lLWseYuuVBRKs7u2d6iBhepSWFWx80GE=;
 b=FLhtlLG3qiy3End6CAg76q1unFIllWQZw5/vx4o0mz2SfSJb2+HVYcvCe/NVyX4390oMelNVdQ+l5u1mwB7C7fthnAw8NBG3k5zowAFe417IUGZaZHtLzz+VtIx9QNQl37KzFty4+WYsWiFT8sW0gca9RpPIWIymepZWwqCJVo0MmN7QQw4RMa3ZI3pkjoyP2kQZXyW5NrSillgmfmz5p89ism7O5lqxsJ7+iNjg1+I68jUnt6SRB4hlnKYOaGsPG3XyLRy8G9cqry6sa7wVqHX2ABbpPZG86oDP/qG0VjD3/Ryod2josjQo7n39O2K/hgZncibqnWI6g2upF4a4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aaa+K2dS+O/lLWseYuuVBRKs7u2d6iBhepSWFWx80GE=;
 b=KrdSa5u0YMUryOlEnrxmP+ZnSr3Ml1iwqi6ldcQp5FDFnxOAlB1DS7lkGp4EY3qERIhe/msYDKqV+tDlwDSm8Jb807I3ncEYtHgvTKGU+Ak65QBBM/kGlHq6DuZ8hmAUwww/wD1SKTEbikEak3XSdCNqzVT2Tjukk0Xvgdhyr2KmUwrM8ntmkfuE0zoJHUarXT0Pk9Mc1/zN4lh1S87isPzqVyh2HIRRsDmJiyKpOBuNSbo0M8jrU7vYxJgeS4sFGtvog/TkXq/eq5NrIxP7437qUU/e5XTWqRCCNKNTLNVBJqZ9VEQqAhxJGYN/BQtjTuMYuaAtotMQIn7bCPmQBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:05:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:05:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/6] add refcount for address entry
Date: Thu,  2 Nov 2023 18:05:51 +0800
Message-Id: <cover.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6002112f-592b-4412-f83d-08dbdb8b4b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUAOJ4U0Ikc6owH7N7utTY9W+abUmVKWpH9uhYEXR+ILzGiRu98YK1Tfr6r5ezEd6H0x3LK+obysZOB+mn/9ojL9A7edLolQeGaUOewtx8p2dHw+JMK0kZUdw1XpAIj7MAoGVsQzhtts2ViJzr5xAAR2wAviCjHB1A2SNfqzVmiA+rfH2fEivLj77vKlz0xy4w1kl8BH+NX8tiax7zaxKmsiPDVU6HMgbAOIROmnjZfLzd6GFu1AZcx1OqVI6GIiAU5kObo8cL3Iam1ffoiDrgC97SnPKEroL829BFmL0Bj6QcktdAYazN5d6EH2yYPhZ7HvSa/PXlCGdOCfpgESQPC6Ivnb+gm5u1RLwCFebR8RXP321NWxHzRcwu8/PDKFoaPux6Im4I4DvAKrSZ4pkX6+RUD8LTFfo/BoXZKSt8Ks+zYLJtx0HMbUEmYBtRf2K0baiwdwJ4VM+LxfObGHqogCsvEYR03LK+Wef4fkhn35UBQILiSNdF3+IzTTrcfTKtZAKhx11d59nkLHhPqtqoa+FM1wo6OAfdq6/i+FiXFCFPXshKT90noPAEqbbb+BbpX7miQOlYHAkQhzh5qrmYaaTi3eAb48zos0uZ7+qDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(4744005)(6486002)(2906002)(478600001)(86362001)(6506007)(36756003)(107886003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZJNAwKEfUugreyqPYqTvuXUHLkiYBU2Q6PnHOeyZiAh+qk5/Gt5AmJWZDHh?=
 =?us-ascii?Q?t4/SoupXi3iXBphDvC191nz+T7WY35Ff0gOvs1qaZrVNFCuuls0hrsTNToib?=
 =?us-ascii?Q?tGTOVtr1/oNBcLOaDtdsPBiYalHMp7JY+pNcG6rXvBQk3BEuiNwe4EKVN94Y?=
 =?us-ascii?Q?4vI4bjgbxtOUV6PNecxQOh0huvykVTlBvJw4EUyBYDU9svUaLKkpyPsYx/v7?=
 =?us-ascii?Q?gjKT+vn7lNskkHha8ungFdxPCQ/azUktAlJnGlSxNogPbHEJgXzyqe0g+Zfl?=
 =?us-ascii?Q?wT8TpMFy67VS5a4aHmZ8onpb3AqW8+MzpBJwZPN+LQg8U6q/5HSXD86GzyyI?=
 =?us-ascii?Q?msH/nxEqSglGcfWcKp6obBhrxSuU5z9IdLj8e1R3S9wWuIylEVCJD4568+Ry?=
 =?us-ascii?Q?xYRVg0PONm96CnAILO47M2v/7S9Tg9Qiauxw5gASxKys6+Iixw1TEU3CGdmY?=
 =?us-ascii?Q?mgED2qIvXJ+THeqr2Pl33caOhprDcWCQChDnG5Djoga2y+BEnGnzolarbbCW?=
 =?us-ascii?Q?nbX6TgY6EPCiIYqvBuT5ZyU0RMQoFquajef7TX0Yd2tUzyCL8aGaXU7V3NRs?=
 =?us-ascii?Q?DYhDpBFauXKpNE02XhGYos25SzxQWOQd8fK7hldTc1lJtIxD0gX7GgaOHCmI?=
 =?us-ascii?Q?NuLPe3w5QV6tWI7twQ7ITsZEsgqFc4IlR204S0YPpWQSG6Mmz0z37G7fYvPk?=
 =?us-ascii?Q?EOhaLV2VY9VxlFXUOrLyRHvr5MLrxiUPN2hzNo6B4ZSI5l2zFuH7R0d5M4Bi?=
 =?us-ascii?Q?3OUd5fg2+YUzujQgXIkj+KaOGys9M5op8PIzB0kOEetazKihvDLgXyGqk68s?=
 =?us-ascii?Q?+NFnSItnK7OXpGsllA4bex7XeRXtSF+nH2eoVI5sc3wqoJgYVy8NvJAoBCrI?=
 =?us-ascii?Q?wsTHapkS+XryQd1rRU70I9rR3Aydqx/hrRB8VLRN5ALgZeOYlXtYI6dqffBu?=
 =?us-ascii?Q?v/Gyf2unJnRydyvtnKW/najrzjmTwcfyw7HPmSecs33LOiYUL2ifpSLJaWm+?=
 =?us-ascii?Q?oUy+BKRsz+b6r+5iVdLYodopVeuXiN7vm+H9Qzgkvej5nE1VgnpFKYV42aVD?=
 =?us-ascii?Q?aRTj/mKTCbxAdA4Z8x/HGeKRaPz3JETtpFPhRb8tFZMx/+C11lq+kaLUbsvK?=
 =?us-ascii?Q?DTW7QrnYe/wXP9iyDQQsm5khM4JKhsHVDVPXbwwunQhyt9X/j1UOrppdT/1K?=
 =?us-ascii?Q?fOiJwuLRIDJFaCP/CupRfcIxz44DL/tMJJyni9reX3YKLCN4PlvvtFDpRIhz?=
 =?us-ascii?Q?YdP1coewHx69UdCLOYMgFn2YyulbLs/Hf0+l1IGm1cKWvLYbA8+S7hrNqVi6?=
 =?us-ascii?Q?JfzQFXkqrDIBj0rKogL0vA0v/UuzfgSC2lQKzkMtIw+aj+pOnppoC67f/dZu?=
 =?us-ascii?Q?jQ9+wkxvMD58/6qKDyqjw4d7ndd43aOs/P/cV9qYlnHvqqmhlDvcsW9Vlsr0?=
 =?us-ascii?Q?FV7ljApy8hKbOFDo0E638QLHFidO5/lWtMLs0/6QLy2qyVP6wlp7k7fAll92?=
 =?us-ascii?Q?+xmC91E1Yv3T/SAfpMdJQr8X+EJAJ7uEWgxGfIQ5c8qEesJJSw5tse8IUZnQ?=
 =?us-ascii?Q?7DEy+fr9SmPuPuS6Mf5PvN/5bHKl0qd7n9ataiZPXBZS+8gz8xcyJtVqOh3E?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6002112f-592b-4412-f83d-08dbdb8b4b58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:05:51.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h69nrr+oXPRTU8KioCADuTo+sAP1qE62ewCF12ZMdcqDrOMjERnRCpbZbg2ud8iMlKZvCqksY9JRJbryGXbb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

v2:
 - rebased with "add flush and dump for userspace pm" series.

Add refcount for address entry.

Geliang Tang (6):
  selftests: mptcp: add mptcp_lib_evts_*
  selftests: mptcp: userspace: print colored results
  mptcp: dup an entry when removing it
  mptcp: add userspace pm addr entry refcount
  selftests: mptcp: rm userspace addr with randowly order
  mptcp: add netlink pm addr entry refcount

 net/mptcp/pm_netlink.c                        | 19 +++--
 net/mptcp/pm_userspace.c                      | 39 +++++++---
 net/mptcp/protocol.h                          |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 ++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 42 +++--------
 6 files changed, 150 insertions(+), 87 deletions(-)

-- 
2.35.3

