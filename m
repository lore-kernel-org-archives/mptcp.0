Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B2846B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CiTE5moy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqSCTBualwugXnux3ePRvqxkW4PZHqqrgz8/uzHgjtuiGWSx6Uvbkok+BfgXORBsdEoFS2p33MVLWKcaWkDkGPjomDluORWG28LOOxstiFGH+XILt4QJi7i8i6pGMlc7kI3qrPWtzk+6lti2of+0dIonhM6wDlFk/cGEgH4Qh9d6XHA+n/W9nwy7ser2WizJ7eVW9ZjwSI0XVPVYkmYt74rh4B59knbYWgeROYALir6j7QVBZKanxX9UXSNLbR/6a5jJKoifIUNkKuP/Zxq37hAYQxGGOW0JBhPAqKFIvRJEDD/qL9XF0zHLO3+72ev/NKtPvoCCC4z8m+YxoHl/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDzlGEb35aRA6HilnkNMB4c/Y0l52mle1+lpO4f5R3M=;
 b=MfzE6+ty1KKsWwt9c39/vliSjxy3TCqXePol5nM9qAppnC3wNkUnfNGOYj7uf31CWvRLZsKRQkCbNmzhCucNJX2TxK2pvjaTjCoz5qCHbfeIATmrqhLuldO1vlryUBqYN93GxQ6VlpKUOgaL2TilDaz0FgEsZKby+pkgZcrwvqvPX9p53jobCaQZPVs77cD7iZ1Pn72XylQlYXQYSLkrLYla7fXHzApo2DH0hNLZmNDc6uMR9JGOAaXsNUf7ShK64WAKBQDz+NHtAm0nOmcrFspIprW+u4ASIJY49nLPAMLxf6wCXNo9roCFVjASrziagnE2dCv4hAG/A4sxi+xnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDzlGEb35aRA6HilnkNMB4c/Y0l52mle1+lpO4f5R3M=;
 b=CiTE5moygMH4zmZkT3n1u3Nb7ma7FA1Ddimo6U4pyePOvjUFK16FtZKs3n4fdpO7fN7SUUSXhuR8NaFMSnafi15ad7jbaTGBaGozyKzGH7/vHVk8PLItv6O57tdyYNk50An7dfXptbmHyePGe4UryjNX7gIUfNsT8UI0vESy2DY9bwyucfkXtURALvJVQhddxBIkjU8WTvV2HSKYbvad98tpgYlfTmsjaGKlCdD8mMMNvlkJZ/SrEvtbmXWHfy26SOG188roN6l408ywO8zTcb5gXQh5b0Re4FfuUICVjVpr4ONFJ49wy0m4q6/SCLPMvzHdPipvEIHeqOD2TnBJ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:35:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:35:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/12] add flush and dump for userspace pm
Date: Sat,  4 Nov 2023 16:35:35 +0800
Message-Id: <cover.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9e3d8a-f1cf-4b59-515f-08dbdd110fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sBkDXBeQeWkLYXkk8JBfOXkEN04je2suAH64UUOiTXZf6XgFhRVCYQipPgdP9fE8CSDJkfvhCRXsQOkjAkdm/B8LgDZryGK+JWHIk0UjgY01/YbbWQojcrQizz4A0TJW4GMM4XhD7NKDGR6Eatfzz0wlRFJtn2V7IcTnu5xZaD+tmLLdM9am6GI4Y0dd95kEp9sQvhdupUXOk5ZYLhY06NT043woWoZfE9n895RhcAEqDixQhwEIlnaBjvcwHnNgcBy/c+y2yaPf917Mf0e6+8LNSLuHZezDIk167uqL5ImeLinc7xJiLHHDY+1mUWpmJYLBHMhvmMo1W9YWmzHLMxQyOm/OwKF1srO0x3inlKAJnVyv10UalrQd7wC8ZNP7VN3sKSpUDMq+pQGOvcV5mT3XS/pTUmNj+TxNhGYDfIhHkSGYAxb2cEYGJDZINdSmLOb85pYTz5i5/XHluq7mQatJIu2gFzLPZpOO3UoVBdvEZl1fCWNeJ89QktJC/Nxh3xyxNOIargwpcXfLsmBXTLBSSXVCM7y2aOE8SFPaMjSAo6gcgqeaGnpP6koUB38vcBszi1kV22xN9sLkUk9dqihxpkWePO7DOzlzhTiLSOyS+2zzyRjAbHGuGxrG0FboNiTd9IznxBoTMoQGfoHrNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H0BfRAvbml4twn8RxI2Yo6cQs6UQxpwaaaw+hshn9GwaQmc/rr7bo+PYS8dc?=
 =?us-ascii?Q?tsr96WXKlxGkLk48j3leldnykuN4Oqp7X6P9Kvn/STrexgTQno4N3oZIn9x8?=
 =?us-ascii?Q?jrGWsM0kDLoO+Lf4Kt4mvuKTKJckJz0FIG4VzzUqsO+1beaaTG5+33fZpWpA?=
 =?us-ascii?Q?hhuqq2Ti7Gm2IEfRn81DVM6EbSlhUPvxEtHMEMqzqTyF3U1Nelz/vhrZ1Ll6?=
 =?us-ascii?Q?OrKdR3inV2COa0O7c9v5tJ4GdjnFlILBk7RYCA2PqHZS87ZkpB1HUnOESo++?=
 =?us-ascii?Q?othjLA1SV8eb8nUI0ztZ0skS23X9S+cNXMhIPEYaxoaB4WXkik7jSExIa/6u?=
 =?us-ascii?Q?SQBErtpGdzrShSqvzxNDun4tHTdXp1oqXY6XO526Zxurmc/z26vu7UOjXWor?=
 =?us-ascii?Q?Uywcr0SDjtI24kLqeK00bf3OwP4Bso/7TWFerkpqmQu0LFhKMBmDhB3zeSAr?=
 =?us-ascii?Q?LUT65yhezRHcj1pmakA9dS00yPLqz39VJY7k3IDVVzYP7KV+QLpJKCpihA/w?=
 =?us-ascii?Q?q3G1bvlHTMW3Yy9xDxlcRKlpUGR7om9cf0IbnrRJFZB/8vy+ZKX1eyZDlhE9?=
 =?us-ascii?Q?h5vA2gemKA5pU1g+GfNtQ47NpdjnpH8N5KMh5vuxslUE+4ndFeBpz9XLrNK2?=
 =?us-ascii?Q?rteyNvWva4PiATLGpcSvfMTOb+KwZHNmiB0ipYFKs35UdsUktPgMaH/KW+XY?=
 =?us-ascii?Q?L5Xu0gIJMKOTM/ue10Ma5c9C5gnXh1avHAqdNA3/U0aqz3terIqxojDoZ0rV?=
 =?us-ascii?Q?SbPZ/0FeveVGQgTr6qS6ssG/D+ZEO9u+Dj3PsB+OThMj0RE6AD+jqgy5F7c1?=
 =?us-ascii?Q?X77EOg8pFwfoYPPRcyi+hfxqqBW8PV0akpN02iul0dQmxuMc3gmwjibevQlj?=
 =?us-ascii?Q?Y1KQKjgzJkt4PL/+3VAtw50RvN9YXll7MJ0HBXqnHPyXW9ZAh4PLM0jjEumL?=
 =?us-ascii?Q?9iBPlnNjoQvp1ByBe/4VvTJqtq4AIlr6anv4yAvkyg7MN9s12IdxU9+tOtoW?=
 =?us-ascii?Q?9IUJyxn4KY+QVwcW7/U5eatHh9yI3gvJO7i71XkvRkqH4AczkBsRPILRf6nz?=
 =?us-ascii?Q?Q24KdGC2DM0iYsGHJT+vSCyyBDXFebG1Q9sb7o/+GH85NWRD4UBVeUSMlrDk?=
 =?us-ascii?Q?AZ23C+2rsn1JFwFoecVYSIdPsYcgZJFgMvAjhpxmyJ+4Fjw+q7JUFZFSqEQ+?=
 =?us-ascii?Q?y0Qmp7YpVLT3yBRP5FlTwmhE8JOxhgwZcxxvMKcpYjvZ0Dag43ZNG20CssqH?=
 =?us-ascii?Q?YU6ScB1nArjQNRXI8oGhYX/OjU0qePPZ/yDjnN3PQpnxhu4FaVkjZVjm6Q+M?=
 =?us-ascii?Q?ohdQ8suYEvLbSGmENX7S6/gmDeTjK5HgQ5lHS54sSg6CVjIcVnlVNOOSZCzN?=
 =?us-ascii?Q?IJ6r+qTpyXw8L7G0ZTvA5rx9T+YlODR2ve3R64Qhd2L6Uaj3fiW/NUUHnXUU?=
 =?us-ascii?Q?nZRoYhRPx8gfMg/qmQ0SOWiWuqJR9XpYCB1coEjEgxRF9r2pvcxDivdWWiun?=
 =?us-ascii?Q?92ICs362Jl2UJV06t0e61RcicLKgj9l1M0pKNwzAIzxik1MiJJY1ph7Oulyz?=
 =?us-ascii?Q?BMQPMjhFX8mCgzXl9Mtta2wGP7MT5WFylqRAC3UZLzSeaNpBUUhw6jHQdQsz?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9e3d8a-f1cf-4b59-515f-08dbdd110fbc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:35:55.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ0LtYY341cCVbNxr6VscmJWOW7x95LNdYDBZ2Jwy4ls2DCwIi00BCa4Z5J2pv8lbHMV6ykQHZlzUSKw4ipVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

v3:
 - fix warnings reported by CI.
 - get id_bitmap using pm_nl_get_pernet_from_msk.

v2:
 - add two patches: "mptcp: check userspace pm subflow flag"
                    "selftests: mptcp: add userspace pm subflow flag"

This series adds flush and dump commands support for userspace pm.

Geliang Tang (12):
  mptcp: export pm_nl_get_pernet_from_msk
  mptcp: use pernet id_bitmap in userspace pm
  mptcp: rename free_local_addr_list with prefix
  mptcp: flush userspace pm addrs list
  mptcp: lookup_addr_by_id helper in userspace pm
  mptcp: dump userspace pm addrs
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: flush and dump userspace addrs list
  mptcp: drop mptcp_pm_get_* helpers
  mptcp: add addresses_identically_equal helper
  mptcp: drop lookup_by_id parameter in lookup_addr

 net/mptcp/pm.c                                |  14 ++-
 net/mptcp/pm_netlink.c                        | 113 +++++++-----------
 net/mptcp/pm_userspace.c                      | 104 ++++++++++++----
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |  33 +++--
 net/mptcp/sockopt.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   5 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   8 ++
 8 files changed, 177 insertions(+), 111 deletions(-)

-- 
2.35.3

