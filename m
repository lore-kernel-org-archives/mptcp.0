Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78C2890D
	for <mptcp@lists.linux.dev>; Thu, 24 Aug 2023 14:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENZZIecfkh9LlchKS+aYERF4jnBT6LDZq6Ltl1pe89AEDlySp67hLcEHxMS+Nya5bJMxsGzHidltZuyBfjKQOT+3+mA5Ij0KSRobB5Zq/AD3R2Y8inuKvMAVtvejDIhyW0hvkdGOGyZ/c5cNPAcMik/64xfMOUdgWXSzcfRIvk7Bhs66OihGbLl1mG/H1cgki2kL9URnP2CwslJGSgm6NTMBLusJCzK/IbT02fjVjEVBkmylmaAj4lBlzpV4EkEC9Y2i7uGb5VADOZlcQT80VhGTC9+04ox6p9OUffcgeVj9v6n8f4HM0FLvPERil8K1AJvm5aGm3L4j3NrWGb4Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmDOi8CKTsr9N1zGTc7SvXuH/rk4WtiKmkC5OSZNiak=;
 b=J/4W15X9SlU8aOSJwHCo06CzQq19xTFt9hHBpquE7lxJw9VZkE+fbYt1/tWH6pBwmMnPQX5K1ecUlI/JxW7kz/0+0cnZXQwBm1aHWu/vgeLYQdwX/tMuLUlmlWe5EMybLmFaiJcencCM7xMvtKFMZK4n/MBEoA6DS5yx2vy9rDRaNytLNq484SKD/gex0Kj4qKbncUeSt/kcSaSlntAdiC5y2AN7wFV3UjWpNimxtsui1fFUS9L9vnnzn4Sq7/5hOvGv+MDf7QAJQYqKZf4u9CpBJYgIj0VMRTyH5tPz7/geBA5PLBdyTT7Dq19QSzf7ymP2gozelvB7vaQKT27Qog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmDOi8CKTsr9N1zGTc7SvXuH/rk4WtiKmkC5OSZNiak=;
 b=ceiifKJrNXzzIrWAbyjJELpLSMOGg8P5nSoZLI1IVqiXIWS0C2BJhwATsSo2PiBJhE3xDeLSeBkFNq8Qbtq9X8P9dE7FIyd08N36u4D5JSj+v32mBNmt4WaSivMt/XE5Ku6HetjBUBgrmWirayYmB3qC2XEJPoGAE1ISYMCpBFv/n4BquA0b+d30wyAktaawjdJiL9WtKgBbWlOi2KaYIKG/aFdlVwcFhKlnz1NQmqTb8+PHdLkUFHmZ0b8HtFqFFQWis9BNwt8H4zsxxJfuVr1bd4YJyAbMd7I2n9tX+QI7a+CRCG0PGqhq0b3XVWWKINKgayFEznEdkkEz51dIuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 14:00:28 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 14:00:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: update userspace pm add helpers"
Date: Thu, 24 Aug 2023 22:00:55 +0800
Message-Id: <2f0ccc5d17dd8165b67a0c984ade974a9b1033e4.1692885642.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAXPR04MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bacdefb-d98e-4dea-87ad-08dba4aa7920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uctORyzi94BBlvRVQtxazRhtPm6Bn/UIRvnp1Xoq0QF9aUdlFQRHk1n2Iq1RUOSq5mEp+d7I1Y6YoafUdD/pEnFdkCAmyGNw8P/qijpn+borflP/vnqOfCno69fWWzPrZvn2Usm9QNwoakdCTRbr2Yyi4nDG+e+vIw638GDWXGHJcXDr1lVs4vHhzAc2hGBFGtftrMthaqCkSC+pdVtc9KDV1UOxGu+qb2aHCoRSLcvbud7wFovC2YZ3MrNlTvpBqX+cEkgVmeQCsaal0QV1BGvoRYWabgrjBvyNsmRQMFSveMV0Y9Q9KTvAbveHJo3bQHVNy4sjhhFsSyiRNfviSNROaM8xRDGgqOEBwDEJkPzJAvRD0XN+w2O+Fi2NACrxzrrQEuk8D18jQiARTSaLwKSkyXOLCKAqLF1B8PDV1Cslhvn1M0ASD5BlOSFEJ0XWHvwL5lxu1tfn/EyawTqzi++6ezvvd3HTa/JZaHm5bQmHIzc/S5kyXB97mTEjdxAvyNpSpN46Q9RrhqIwmAiVS1ODlo6p8eQ+Fw2L5igiDybw2hLqO0fTxf2/KWsE+O9dTHQfdCchaBFGY3h2x/GABKzFCm/ddArMk2goSxx+Yno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(26005)(83380400001)(6512007)(2616005)(107886003)(41300700001)(4744005)(66556008)(66476007)(2906002)(6916009)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(478600001)(6506007)(6666004)(6486002)(66946007)(86362001)(38100700002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzIhUG64+9EThG86JD1XkC3Eblb5bEgSRw/q6gbiaOInvj1+oMT/cNE3jSP+?=
 =?us-ascii?Q?uOj4Dv++sq1eCKFRHnefVoel/ma9m7QHnybEtNxDTgl30z45AYe+O0QSe4pV?=
 =?us-ascii?Q?/GpHYuk8D87I9Zi48UzMueCYEXx6L++hRkf8f/ou8y9BAVpgoO22VMzski5p?=
 =?us-ascii?Q?r8EYlww+5g8mXTls5gkQKDpdIgBzhiOIy4knmc/U3vXVISeNSNCVwQPQIKyW?=
 =?us-ascii?Q?OdQpe1pj5ozS9b6p5ff5PhSYXGugKBZgxjckH1SHoTiZs4lELFcYfLVkV1Ax?=
 =?us-ascii?Q?IUuW2CZiNnKdcekCXNncKdu493aAMtQoPy8fIEpyFhncCyRjp9rNvxGlaJ1g?=
 =?us-ascii?Q?MFjDAOMYZwT/qeX5IxZuzJzR5Q0ZsJJ8VBlU2vR7dDeyZApSsmmZG3rE8h4+?=
 =?us-ascii?Q?3adh3s2O4bNLM/TMjTFEFOIyyce1uNhsy2ULbYzfN6DIimCZreGhXBLvb6vt?=
 =?us-ascii?Q?EI7cmpu0+3Xl9uFa3aBFl3jM/hmDNS5obCewTd/IvyTY8ktJ7gXTgjPQyQmg?=
 =?us-ascii?Q?JuMAVJD8co2SuiVlTDZzZEgQB2n4+ryA3ctq+Z0cz0aeX4nyEZNKwsIV7bfY?=
 =?us-ascii?Q?DJ446y6q0Y2+k+DI+Z3MShFNazNuKH7kVzU2HipZwDGLmtTK/SaENEl8Iukw?=
 =?us-ascii?Q?jkjPWmlH3i4zoTui5QTTn/gBkh0FoyGoaIJVFWFnXcGJrEVfmi5MOVtTtoZ3?=
 =?us-ascii?Q?/ZG1BrAVWVlwW9/jxQclD2dt/cJ3Pf/r9yxx3b9dT3UPWgs+QQZ9+UGIShwP?=
 =?us-ascii?Q?90vYa8/k6YYdBtag5CNlrzA6L1p1+fuwCGdKfsmheehA8ijsdTpo16ztg0/l?=
 =?us-ascii?Q?i4WLd9EhoIaIfKWSHt3O6+INz0v3CRHtnc6tKESemE4E9Br8pw10uc6i+IVp?=
 =?us-ascii?Q?RPQgn2VKG0Dqb/Rdd/hYLdhrDyZ/Du//n35oebQF/xWo1MgCdHW5Dz0fHm4k?=
 =?us-ascii?Q?dGAIstq5LfcmBcGuKc716bsT7zGTAK0sECKLcTTiTHgQKnVjFKAobBPJZCNf?=
 =?us-ascii?Q?bVp88N+euxIXrVObFPtdP1RQtogFipeDs2fhGD0tQgztf9eID6AuBd/vkvq/?=
 =?us-ascii?Q?AStse0+w/cPHLg7QNmdt4SCiRQvpKrJsKQut6QAzURZc1JuNzCusGFM6XTob?=
 =?us-ascii?Q?J7uM/nz4ePfISe5MkOS5x/cMgr85LLN77jx03nrRTKQ1UZIXGEAoRlvTH2ds?=
 =?us-ascii?Q?2qtQbqI6q0TDjr4NJvqP8ODPGKijDK8Qu5BvAF91/dUcUcK38WuwijTH/LG0?=
 =?us-ascii?Q?n+kVkkFWX/gSJ1wudBpaNmy6bAggg3gwecCTuOWV8ZV2r18Gl7d5d1yYFI5u?=
 =?us-ascii?Q?AJjHf3ARNbPGMN8ultJYa9hyInbkYRnsOfyUWWf+2swFHmpqS35o5COqHIhg?=
 =?us-ascii?Q?Xo2x+Ih9EzYgE38v2HXujc6d1uASjaZWUEJ8lTLjq574LYtu6nOCLHhvyZ/7?=
 =?us-ascii?Q?tJeQOD2rrhLBj5dBgPWEQZGD0FR1rWKqPDHhZ757aUXUCFXnxgnP7KPNw69a?=
 =?us-ascii?Q?RSnW/HoPdFcD1o7iWUhnxyTBHdWn5RhoXeYR0bWGupgwY0FOk1e7vvCfGbO0?=
 =?us-ascii?Q?i8bzNcblqnW6o7Vx4tCHsxt/W3CfTd6ROi3/SvwV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bacdefb-d98e-4dea-87ad-08dba4aa7920
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 14:00:28.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEZ5Id4FWwITKEoVpcPPiFC2E4lmIcnMi42EWC3C0n2+SiAHQRHHEt6CHIpOeLklVAqcJ4Ss9IOB8LgpN1PjeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707

Use only one sed in evts_get_info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a0912b1d6405..949c5cc0efcb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3255,11 +3255,10 @@ fail_tests()
 	fi
 }
 
-# $1: info name ; $2: ns ; $3: event type
+# $1: info name ; $2: evts_ns ; $3: event type
 evts_get_info()
 {
-	sed -n '/^type:'${3:-1}',/p' "${2}" |
-	sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
+	sed -n 's/\(^type:'${3:-1}',\).*\('${1}':\)\([0-9a-f:.]*\).*$/\3/p' "${2}"
 }
 
 # $1: ns ; $2: addr ; $3: id
-- 
2.35.3

