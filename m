Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD81364
	for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 08:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNWdeXCgIjbDtr0CZlp2+rv+7DyBUHUf2652VQdMcNPO7pdO2i1+nLIe8zuoJWP1lbV8L4OpTsoJ31Kb9CTXKA3+uuqmj8xBcaACgHs7Sk03cmbjpgJv8UU5tgEQXNAGpDPtpr7pcdmNjv4DpMFmlQA8Hft3PHB3Xj+yGuabgVegutQAyk0yMbd08oNXfR8+y/i0/xEHuxlgVA5GN54fHNWXV/ck2z4yuBYIpxqVzD/ec262FcDrO3rL0B7i9Z928Zg5xYfjLU+s6gdKtyCfsxUnpCHWLTOhxC4TSVqE8oieAD7KHkiqlpJs3n8XOUSc0o/cdAXr6z7GFtnrJ0ORyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daehk4Bmw1xizM5vPn6ju8rrSkuSZ6qNxhDeZ5WPEEI=;
 b=J0HlnItXSkHuVGnZTIjDlXLCNtvit2+SFJybfZL40ZLNtsudJtFbBX+Tv/rONjkZsq0PPXOCwoxl3COP51LbrAczr1oBOW/KNi99BQom7tZkRqyOFRl9C+iz7TAYu+gE7Ka0mT8PXSgSBg3WveKcSPpf7knLGzPDpm36C3ywQ6r8NHKu8mHL0YVTEwpzS+cU5Y637ypiclvaMnl4H26zoYiMGaMQUr9c2rOOjaFe0Eb1vbbz1QR0kbbhAyuRCdo/gVro2UVeUbItixBxO9aS9g7b4mD9aKNBTzZh3cmZ2XE4Y7Kp9pOsOSuWv4HurxSTKVE/GdEUhSd7n0PLxIQvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daehk4Bmw1xizM5vPn6ju8rrSkuSZ6qNxhDeZ5WPEEI=;
 b=BeEFNOoujyVTmm+xRvzW4cN/5wNL2pLxgZVfkAGjcP3FPiPElgeWJ2YTzfQ1tM8l9hAUSd6iIubCr8rJrRYA/K/t9x/+S4CAbdj8R1vX1r9yg9vuPdVWL8AFUTmzbcPjbija6JWQIkMJ1k3iqPil/bDn9jhlldFEnd5XCYh7LuzutKe7FGwGb0WXIVeLmj5dTq0p8DhRWgIf+3/bkwoF/IeqIJvFFW5acknU5EkMOZaGj5WcWOru3LfQ6byncnl2CVAaSQyMHx5c7c9jPXCn0uIJz1yYwdfAVY27Xk9Ghsfqa9ta92qGtZXZKD6gcfkZwycLf8VomZPpl7YbSsbuFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by GV1PR04MB9215.eurprd04.prod.outlook.com (2603:10a6:150:2a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 08:32:51 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Sun, 23 Oct 2022
 08:32:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: get sk from msk directly
Date: Sun, 23 Oct 2022 16:32:46 +0800
Message-Id: <20221023083246.4042-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:2::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|GV1PR04MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af7816c-a9d7-4df9-d809-08dab4d12be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eNglgSeqC86Vhzx3q19fIYAeCcuz8PD5MoORkdhf7t6vOzlSVyuFRBzxjvXG6DanvRJ6meNS4GrgNoBmb4ONYOYys1Aq71SG+mTJuiupuYr7sAqevkjVhi9ZNgcE9+doRytkas6d8rW2N5/v9CHQzZ9jrvmDodfP0nw7reh5oWlmOfrWXh+erUyy1I/3RNvVEFlTBWHJes4W2Cz2QurrYiRaaBpVFpL9KWKh6vURUtgyCRPC1wG26i/ev0YHiMdfKjnVoZEA3lyOLqHNkVzH/qgpgc8IQTu26jc3S7hvGqgiJqxIwptvbP+IebM8ca9npf+z97OUhJFXYAhijBH1gXRQPMpzWuzjXj7hI5xyMGpJZMJeM/+aJRgTG2OHSJj7wKOWU5eyA95/E5TrWL3xTKGHdVyoiHRTFLyZmRHMwPEVM10xx/LRuALv5h1f7bp2ehZUZa9ZcgFUD3IdeiUZkKyU8OWmdqji8Ljxk4OW7DDK7PE52DeU4LOnbhFYnfuSpRLzCgNxGUtDPcFg4JZKx4vsQQi3y99aigsgHZm+23BLuo9SjuXplCBsEaS5Hrxu11am7cIO3f13iSp7q/TLodYRGSr6tXt4vmFfljd0KAR6Fux43x43vg373Hrfw5fMTR8XuIaQglodjUHPNVdr1h8Sby/H5HjLY64sPhjRH1UkAC+R12XPRm7KFKuLnp1dmfaggRLIJarEY6mffaYn++NPDjHYOogSzP1/MMXmykSyKuWNa7PBoFtSptaw0uF0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39850400004)(366004)(396003)(451199015)(26005)(41300700001)(8936002)(6512007)(6916009)(5660300002)(66946007)(66556008)(66476007)(36756003)(4326008)(6506007)(8676002)(6666004)(107886003)(316002)(38100700002)(2616005)(44832011)(2906002)(1076003)(186003)(86362001)(83380400001)(6486002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VV/bhO0CHzxuRhK6RIrAiAZP6IJVHcgxEeC7Phlale2KnLVD0q5+WMYe5V7I?=
 =?us-ascii?Q?GJBlaLG7NchEw1sue2snIr/edEz+2I8bLHpg9MX8MhTmcBoFzgNS1COK9LX/?=
 =?us-ascii?Q?xwhhTOdpudrlORDqnIk0WGA5VAwDT2zVEwyYC3duDDjPimwop7PBn0eHXZ5s?=
 =?us-ascii?Q?JTRzt4RdgTRC3T1TzZLidxn2tpQiqeg7B9gJZJxDu40kRBpicvOHx77ZQePP?=
 =?us-ascii?Q?ZwLzDgAd1NkWD1/EYaWRelZBE1P2cSJi8xWy+awLlpyme/meEDxKh+spvyVS?=
 =?us-ascii?Q?NJNs1o8c9we4+aCBIA3Oq1zzxuj3I+3qvdnyHsA3ma76LVXRBpLuZ+9BvVTe?=
 =?us-ascii?Q?eebttW4pyqz6MlVq9SgMLSKLGALwVW4VAC0PjnNOikx7tjGDC++A5r7P5A2o?=
 =?us-ascii?Q?kWJkCN7O30c6/8i2UYwjGU83JDVSkcry2QzDAFMFbEduDSvXk5IXwg49QM/r?=
 =?us-ascii?Q?pxxQeSzSbhQra+CdKoR4bEWacdmTXSP+WyNwQOAdCO/zhsP1M0HByrLkL2KA?=
 =?us-ascii?Q?3uAEaOlxwsFiTDOBxPRkAXPHWLHHR8SK+UEzoDMuON2kI8KI+qsiwna3G/z/?=
 =?us-ascii?Q?kO7jIK236vDA7F8eYG35fEUna7OXTyCzcOkwhKObYZwV4FbJH/6bWlhvE06b?=
 =?us-ascii?Q?y9G8pgIEL0d22tmwitekTNCzp6Q957sChnuuMExxkAN9jdbFVQOLV/D20c7Y?=
 =?us-ascii?Q?8zY6EqVCRTtipiDbEpKqRLYrmm0dQGJP+fpWrc1EZjY90EdYq8FQY+lODmck?=
 =?us-ascii?Q?2KVFuyWKvx1WeNQtuU187LU8h1L1QDlfnBAgFwDTplI13ZsNqzH+SKlwSmQp?=
 =?us-ascii?Q?/GmnlQqGpodp+g/eJYiJVsnufVHX5r2yIl2neVkz5kB9gNEjoG3REQZIouDS?=
 =?us-ascii?Q?8r97wPfe4OxL0f0EkIOMbkXu3jIDVECYngBgXDCVuCzHWYCpdXLOAtZTW26c?=
 =?us-ascii?Q?usav7Hfhm3CnLfSTzfu3WhucvEgSGmSrtdeoOM75Raqu4Y/h7E2HNruJuT0H?=
 =?us-ascii?Q?1axCjpkKFUuDzcgS2hLDdD7pqXK5fhfmkmbiTIkf0RWGBA9UoQLuVZFGVowv?=
 =?us-ascii?Q?wHCHfaacx+V5b9idGePHG9GRRYmsXmpIRFurSZOTnYIQKuGCQN+ScHJIF2yo?=
 =?us-ascii?Q?v8Pc955ACjtjk2RwabuFmivt95PPHbtjeUJme88GCbrzIAPS3B/gAuw/9VoR?=
 =?us-ascii?Q?0QM/S3Qht9eRhJCSXqtazgnyLf4c2BczHT9AGII0UNqewVSvjKV5xIr0Bh1D?=
 =?us-ascii?Q?E7jIB556ETFrWPVnXkBOMUpflpqL9k4PelkfJR0kDpqceGAWpuKxGsD8uaPp?=
 =?us-ascii?Q?ZqpH9MzwNU5jUfoHW3MiGtEWk9wJpuiKMF+WE7HYDLGr55vuTRlxnyqnZXjx?=
 =?us-ascii?Q?I8AhR/NG13qSE1sbWE4tmmmBjjhhCUEtDtsrR6ytFW9xrdujkDIDA5YoaB14?=
 =?us-ascii?Q?aHrCYsMMcu/GRxNijUfIUXhs1LSTpvQwBj67fmMIj+yN/cV62wQ0HmLtxBYq?=
 =?us-ascii?Q?KzayMAguVSrVwNIjB+dw1ok0XJ4giKFFnHAQXbz1PLNQ5zNBG+B0gjfFiiOm?=
 =?us-ascii?Q?OE36JqDxmz8doz82MJ5SfEQtdBr7Hp2sFQlqZQ0owEMrOSvYG6W0YqOF+Ou0?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af7816c-a9d7-4df9-d809-08dab4d12be1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 08:32:50.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miOn8wjZ7AOC/5d/AGcdCoqO4kKvTCy2y2Li5kho3WNipK1ZNdCseUQMjFMzmtKW3rJ/J68CXE/RAZp5x7EPFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9215

Use '(struct sock *)msk' to get 'sk' from 'msk' in a more direct way
instead of using '&msk->sk.icsk_inet.sk' in mptcp_nl_cmd_sf_create()
and mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9e82250cbb70..b56a29aedf27 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -291,7 +291,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
@@ -299,7 +299,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
  create_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -403,7 +403,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
-	sk = &msk->sk.icsk_inet.sk;
+	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
@@ -419,7 +419,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 destroy_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.35.3

