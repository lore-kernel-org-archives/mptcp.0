Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120621BDC4
	for <mptcp@lists.linux.dev>; Sat, 14 Oct 2023 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yNEbe5+L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZtX5nB5L97yDVeAZsQK2epxPUZaKNtNxYX5U2aab2CE4ET5IFzCbFkT+dGHpBkKca0NPcVJWFlVN2vcXxx3a0JHVeCRiLx3WI/x/KzFxyXa7JNpdq9q0LuiITaI6WDmgqc6AzCEvMWN4JN79eeLi9SBl99qbkac6eCPjdPirv/xVc354VspgnjXAYHJwmE2fftjF+Kalpi75CUxijoZ6dg8f2q279L09Qg9kUA6zrZxHnOyqI02aCuub65Dl4NnOPpGiAWZqw0dOU3htX8VsVUZnukPevW+uSf/u7ru1qRcEvEVQoU1HkxyVZh4ykFPLJVXtj6Y84M/u50CxOJLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Ih4Dq/tgml3++TAoEYoFHxrssr7B8zfPv46l/A3ho=;
 b=fNMuURasMDzkV8b8qQhl/eyR00G6sS69AZftrYoScwZ00hPr1rxwzKuJHxcpp6xBBja7QbWEot7oIcm6400uaAWG7lHVM2EQgTRQDoaUvnTm7vxH0XM/6lQthNIg+T1jpmgIe3irGBtvKTV33efTy3nwbfG8vwPcbinogXNV7yvJMJa9kvazrF5TRnok/2nNYPFx9vyf4ENE0YXvTmCvMN3etYnFlSd/1gq0O5R+bF5NofZS8tXd03/bicxyeYYJyB0cwAuuEM8V/E1QypU0qs0OSa0LzwsoQlQEpmyBtMmQDzDxe3FR/lXIiqhfoAuNJT4a2nPFtTZbzJcXCaEpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Ih4Dq/tgml3++TAoEYoFHxrssr7B8zfPv46l/A3ho=;
 b=yNEbe5+LCsRo0GuwdNyY/WNl1moSOTi+60d77rNNnqbvARO5VnrwD8HNIIU6786Ry4V/zPtFs6Qx/le5bFEp3HuA23t+FQQ+zzVuQXHsEJfzngjhKUd0711iS0bApfoCBLIqLqB9oqvXk8s2Aos6BZ8f4Zhsywep42j0tJK3RhhkGw+mkgTef67gCK+D5CsnxOXQEuUiAJfhkKjTmrCDNU1YTr83WkSPidr2OnWpnDlarWUyrJBefFQvh5Z46vjP1boqcOMSg2LE8MddhhxxnnoRBZmDv0kDNMwofVYihndWxgTwJUtukOX6OXn+5+ORKbYGnmeUdkBCXbL6TMNygA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBAPR04MB7464.eurprd04.prod.outlook.com (2603:10a6:10:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sat, 14 Oct
 2023 16:42:16 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::1bda:6094:a26e:176e]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::1bda:6094:a26e:176e%6]) with mapi id 15.20.6863.046; Sat, 14 Oct 2023
 16:42:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: update userspace pm test helpers"
Date: Sun, 15 Oct 2023 00:43:29 +0800
Message-Id: <41268eba89466b176262dc6113528af49f051c41.1697301801.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBAPR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 030b28ff-8aab-43ba-269f-08dbccd48596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q5Bs4s+zYAeFkFE4z23l59qD3wBVLaqmSERUp4s8/djl+TxeGBaLKiZStNLyyW4YjHpTa20he2ug9hO6LqZod7KHTQNOb7RIRuokV17xJ0SLLf8IQro7IunClN+4aAVbId9deMqdorbe0iFSYriqbHQxKG9o4KusmmnAGHaNVVefcuMqw5RHwFoxX3Vt9dUKK/TwpgIxMmJmx/r1phXCc1Wq5nKB/2SgADVC/F4t84iURrKsc2XxjaMBYR/TfzWpbt2Y3QDMmZC27dqIkaLNOQcm3sOpn3m1tXk832XreTJm0ejOFV7PHg+MlzasmEzX3o4GK5RcL3ocHQnG5yDI7Ktv/Y6ybVKFH3fDjmHdSWpQ3flAkw20ijt4Dp7V/DjXU9fO4hqEHCM334z18VPyHo+JH4ivN1EN/RYDjlyeCT6WKQaKPFgJRZUIDyXeJJSWgNJdT+aoWQ/MmCLHM70XJ9Ecw1Abr61W+m3mgqjqnRElHcn7IlaUvKHYbZZNV5b+dOUqfr1v671/9MKfjo4erVmOH6L0ttel7fRwOqnJCztwQ23vgVNUSu+5LOchcGntsAZIwERCiuAkcQr4+vaocm1KlV2KY67UOY0NYHE0Bpg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(6486002)(66556008)(5660300002)(66946007)(44832011)(316002)(41300700001)(66476007)(8936002)(6506007)(4326008)(38100700002)(8676002)(2906002)(36756003)(6512007)(2616005)(478600001)(26005)(6916009)(107886003)(83380400001)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2khTtgR8al5a5aBVVIhczRu8eeuI+NMTcQW2hw4AChY21aywvL7OjG3h78xU?=
 =?us-ascii?Q?ZXr1re4K0Q1t+KoNFzk8aLJijWwPeA0GhmhGizCvEAPB5I+mr64rlxdCSooD?=
 =?us-ascii?Q?mL4+BqcKDVDT3pAEd2mLmW7GwbJfFqbVb/wl3bJByhsqLxHJNbirw/pVfzS+?=
 =?us-ascii?Q?I8/iDSbGdzJQt2DqelKd2kruE8uQHTBcFstrStmnJRAC0aNZRkP9XVqqt0vK?=
 =?us-ascii?Q?wNQ0Bnq7rRxpSsdzF8P6Dy2zB7qtyNf3Y1z6vykRhEXkAWsH+mivF4Bh08+K?=
 =?us-ascii?Q?HSUFZ51vEvvdDgs9LxAluS31GFAoWgaH/7/y6ZQ1O45f1z4PfMorVIdRDCtO?=
 =?us-ascii?Q?BQQPxCaallJXD6y5ZTjzQApu+U+in7BIOuKlnAkBjUJ/jewTU4aOaa6s10bB?=
 =?us-ascii?Q?AUM80qOAQIglbvN/mKCnXxF2r5753deylKXzS/zmbFUp2GsTlwM+W3RM7NmN?=
 =?us-ascii?Q?Cgz4+QQ7Hx+os/QoWanXEntkZs9JeeeJHPaRZbg+TRALueyRl6kLSHIkx4oJ?=
 =?us-ascii?Q?Zktn4wNaOFk0XWJmMWfqYKuVXIryY4FkaK5X80PvD6Dfd4zJX6bOQwMR0X9u?=
 =?us-ascii?Q?vI8yOmxVp4wQgLHJO05FRksTlQyjeBgERc5jn5H9WD/fvvDaIY3aOwCB/pZv?=
 =?us-ascii?Q?zrBKThtFUQGMEN2s23HXVNy6jnJeLFJF1zZ5nd192yidT2zd3MrO2sDpajqU?=
 =?us-ascii?Q?QU2oHXuZrWxMNV0LM9eu0k64Mb9oQRwlCNvSErxSDppT1VY8Yxc110eCppnI?=
 =?us-ascii?Q?NSnxHjxCvxSMHvCPCa/hjX8B6fe7jBpNuOREMRCwOtR7uMydDdxRqypHnb9g?=
 =?us-ascii?Q?38CB+wndS/T1xeywnJLT6jfIpW88WlmJ5K1AjdaeAq3QnWrmLCqA880/ub68?=
 =?us-ascii?Q?G+D2Oj2No83Z6wsVjOYHudDvtjgHxnwmjtuFi7yzygZaRp6G5RsoDz5ST36K?=
 =?us-ascii?Q?G/dn9wkKGpCZ7mCwO+8CvDyHjx/BQ+1q8G+DmD++GRLHl6k6EwywsCvjYz4w?=
 =?us-ascii?Q?EG5q6VWNcdy6D0lz8QobUEG4VcWQUOx1oe+XKKK1dimdUzWo+G8sxJwaYI+A?=
 =?us-ascii?Q?37dggTtHTmFb3jqmO4lsXAVixPLdZCRi6UtFhgIb3NfFTB3bfjhL/KBP85mv?=
 =?us-ascii?Q?ifeGN5fm1wkn53Hl2lPMF/4OefaCNHW6ScOvyzxerRqA4X2Cq/w22f18HDZA?=
 =?us-ascii?Q?qydLJAd8ErXEZMoa7xURLO44zDNNsiAzf6B6xp6zZgZhet4rkOrkjmLpR8G/?=
 =?us-ascii?Q?CbeJpNoppfw2fYhJY+lYiaN6Xki0X5wn/dyvTkg+PNxDyoxvB5vXabwXpL2y?=
 =?us-ascii?Q?2ZZHUFsM5WIgXpXyWC2va9T8AkqvR6/gLfPQgRIgydBqqOYzJP+dMle8Oakp?=
 =?us-ascii?Q?sLcf14AI5iNDkBy7ME1kQOxvfkilszzu/uGj47Uv7LryuSJ9k9atDCOJYlki?=
 =?us-ascii?Q?1gkcn5F6P1XaX2hri0sFyjI24Pbp//iQjpfOVP6raFNDckkAIjKmD9hwxYtR?=
 =?us-ascii?Q?8l3FFGhKsDNvgyOfTFztYSLpTavtAft7wXPcFkLtEe31Sy9jZTwDBag7PeMC?=
 =?us-ascii?Q?eqvufeNKNPyQjshz7/zIOCOF95SaU0SJTT+tDbiV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030b28ff-8aab-43ba-269f-08dbccd48596
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 16:42:15.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 027eryHowjs+PaqLG+DZ7QLEJkdiG2ESqiv2t5GQ+IyGS7ShW3xAKBbFICKTgsqO3FnRkO91o962RbB/BVKr5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7464

Fix userspace pm errors reported by CI:

[11:10:11.889] # 112 userspace pm add & remove address
[11:10:29.692] #       syn                                 [ ok ]
[11:10:30.294] #       synack                              [ ok ]
[11:10:30.686] #       ack                                 [ ok ]
[11:10:31.263] #       add                                 [ ok ]
[11:10:31.653] #       echo                                [ ok ]
[11:10:33.644] #       mptcp_info subflows=1:1             [ ok ]
[11:10:35.761] #       subflows_total 2:2                  [ ok ]
[11:10:36.762] #       mptcp_info add_addr_signal=1:1      [ ok ]
[11:10:44.932] #       rm                                  [ ok ]
[11:10:45.321] #       rmsf                                [ ok ]
[11:10:45.325] #       Info: invert
[11:10:46.405] #       mptcp_info subflows=0:0             [ ok ]
[11:10:48.048] #       subflows_total 1:1                  [fail] got subflows 0:0 expected 1:1
[11:10:48.052] # Server ns stats
[11:10:48.310] # TcpPassiveOpens                 2                  0.0
[11:10:48.315] # TcpInSegs                       118                0.0

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01480663c102..4803ba1ab42d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3316,7 +3316,7 @@ userspace_pm_rm_addr()
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
-	wait_rm_addr $1 1
+	wait_rm_addr $1
 }
 
 # $1: ns ; $2: addr ; $3: id
@@ -3352,7 +3352,7 @@ userspace_pm_rm_sf()
 
 	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_sf $1 1
+	wait_rm_sf $1
 }
 
 userspace_tests()
-- 
2.35.3

