Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB44846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhSloq1PZmb1rThW7CPZf/S0R0caE4ShC32QXr9+rYW5BftC2VEFvQhnabcHwyPOXxS8rEw76KsGbVYydT+wLEdDoKQR6zAgWQgY9YU8Yve61xJdxtJYPfF3AIP8oYmprFHSh/OxBwUtzFhh/IHerz0f27/wE34Ct5zlHCjvBt6MpbjrCahxTKnuojwQeNxg6zFPGjy1yo0wdaMAzk8FhvUNHn2AzeYtQtV2SPeQplkxec6X9dlfHE86aogtj1w85vgje1xrBQ2ZgqdKvPQ3n14rCp+vph3LN+6z8rIziuTNowduSrpS1kq98MPwfsiCoJ5W+Yi2T2OGSM45Kbo7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NDwGJLDlQwvuaAJuEih0V9Gp92q86kwfKSeTOKO5ww=;
 b=KgfWnukVqbMP35RUAGRsWIvLreTGeKfj1Jzw1Y1I1qIrYPHUibY22mcZNrqHQnZyTzv+HlFDwWT+XyjN8Tiw3jkj+q40t7wsv2asp4e+ttRZRqVrYYagHkSpve/e0zud2GIa44lkVE8ugVvHXNPb2So7x54vbB726J36Bk9iIlMoFU74BR+9+SDy4axMfJ6hSzrbMDcXQY4DeToJVE0ZaDo0cm4R3dAHfFWHQACy3KV/c8wS+HPT6Vidd0SMPP0qjFBudxbzw0/ZPQOe1f8440SjP69w+IUTf6COpy29bh3R8l/t33t3CbzYB0VzMUxe1E8b/bBLgcPu0HR4PvtMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NDwGJLDlQwvuaAJuEih0V9Gp92q86kwfKSeTOKO5ww=;
 b=SRX8oY9aBB4mi9S5kATHZ3niqnHmuqGvHchA8t3v8QmkQcZu6so9mz6wX+OO/GahgSyV5L7nudfrrUiXjMrter7uYSptSU4ZO4N68mVqUlPPtfpiFC7xTb1/d6/lZhG+6+oLv7Kw6puZPjwNSX1mq+nV7YLsbZ6GpiA8ROPnpZ4SNRpcQFU6t9Dy8AkXQILNEH6ZD/DhwwE/7uwBiNUuqdCk/PcbTtcG7u6I5zi/90+RVh01h7x4IZBxogy3U7O9gpYG2PqCPTJBkI2i863fEXkVqcvliamG0a1s7p8otYysxXwJxwsXnlx+1bED+fP0jO3pGVO6yocg/8/eKqqSaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:27:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:27:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/6] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Thu,  3 Aug 2023 12:27:20 +0800
Message-Id: <3b60685a6a9d9305efd461825eabbc3727a98b99.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
References: <cover.1691036765.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e10ff3f-e3cc-4f4b-d102-08db93d9fed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1raxrWnk3tsE7sE93qoqykT3zGnWaD6874xp7FX2rfdYDJHBC2KKRV/fYnnq6n+jhYA+7Suhv/nNBL8xH3jf8frEPzDPfanpacCpYXEo18chZW7JhdU1FMe5a3TxZya55m7vwlvKmjj1saeZAlik35P0DWNVeyrg1ufYP+Ojn5dypwfAg7NvnJG6VbJ97RKZjbfKUvlY0JS5rqqshBuB3AsvEJfRqI2d9UNW23XvzulX+uDznA17U4EFKu5MA3jv8Aatyn9RYPMAP3RqXpXGKNOiXqI5o05Uao70wIPy9dcQ0wcUazLUcl7WLaMkIvPeinxpz2M8iytRy7AH1+d2X5gI/2TFGma4uknimHmBEGWc/hHC5Xly1hYawnwpYw8haWBQN8MGOXmTSVSgsjSkT/Wu5qtkTqL3y7Sy2paE8MPeLsUApPNQAYiu8z1S6kqkGtqR+2C5gh3U1aIkWjv4mYVzN2l37gCEtR4oJBRett9TwoUXDPMAkgp1bY/vX9Pd0v01Vu/3heRxq8SNIhZsoB9jhw9M3GSZ6mlhHJ16E0ofO/1TQnyux/T8G9UTZWUVOuIZUTK9Mu8inphlc8LFHom4hDhNJFamqQze6ph6sNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(4744005)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z+eutHHLnJNan2qDJ9lLTnCTtNFGBPUajworxrU86MmMnTpqPaybMr4tr9ac?=
 =?us-ascii?Q?WP5eqg8ny0AXUy8t1OGNejIWyH0IV7t1+T3v1CabZcbrTFU9qPxjiQXulhl2?=
 =?us-ascii?Q?mj+CKIuoyf47pqI+2n7Ch01p4IlYRc1dTMEUw5NqxQ0D4iLXNJGk50LKmJmh?=
 =?us-ascii?Q?Cofi2LIvBC+/1lurQbWUH341izKsqM1EyVpMYQ4pkUO69GghXaClZnlbO4RJ?=
 =?us-ascii?Q?ixyv8AGlraqIGQX3N2szMxbYseNRFPL2FC4CpQ3R7OTB9n6fqWziQKqoEvfr?=
 =?us-ascii?Q?7PPL49UIAmOG5qu2rRtbFwo8Z9uh5qOVFIwrMfjE8NGJJmvCfEVtYedouvgv?=
 =?us-ascii?Q?fpXlE1mXzoHEcOePUD7JtZM5xoE0JWls0198oNW1X5c2sr2/xhGesjvtDOn9?=
 =?us-ascii?Q?64DuXmLqqLNLBuLdDTKcgtMjkIiMyygsbMYqhpdGNtVPCm4GyyWuNfa/6tzM?=
 =?us-ascii?Q?1j8bT6y1aVRd9b2JnLuuvBRWG75uvyu9g+a3C71Qo1tqz/pDXNrJkMaFb5KG?=
 =?us-ascii?Q?T2EkZxiQjhHXOC6V8og0c+K7c13lcah5umU3Cgt0Wo6h0ajkSjh5V9uhdLDu?=
 =?us-ascii?Q?zIlwp7W/kFX7dLLUw8BhivFazYxVq3gZSQKeSLqr7LxpQQC37omtS07hnM6J?=
 =?us-ascii?Q?rnGIHO9qJw1RFKx2zL4iv3VohewNyxB93bPTvd351dMCAvQJQ8+RPMvmgOni?=
 =?us-ascii?Q?FcerSikN1n4cSD6Uw8kyinKTKksRdiy7x44TsVcgm2G1Q3wXn7kvz2Nln9tY?=
 =?us-ascii?Q?sfS9LUJM0qsv2J18tqnS+EwD3URGa7BjFCPHeC9T6k8GDPSjj45fQ/3gxv6+?=
 =?us-ascii?Q?v9rKgx756wQLtp0K7X5ZSxOK/pdMuyf9cXiSq7MvrwGqgtyeegkaHaCOdONx?=
 =?us-ascii?Q?2eixsFy95k6T7KMaP1mLLy9r4b7V6mhsgTebeq3ChCFm+Cclff9lbBjZoLz7?=
 =?us-ascii?Q?3V/8ZEaHh1/Qcsgcw35km1+8TQlsfp7XOSts2DFaJnvPtlGS43kZ2yNURTnu?=
 =?us-ascii?Q?Ot7LGh1jcPcdSSLiiS9TQwTXfFqWWEfeGgU0OVINCMuUUwkBVrv/sYlW59HJ?=
 =?us-ascii?Q?6GCLDrjjqwmmbWiba52h5jsI6h3F1TUdusuciFttpKx8MXP2atVCZQckL+fB?=
 =?us-ascii?Q?AMtEgfMB6DtkIvHHbQOvAnundtpwHSjgedW5Si754rQ66K8Q521nYDcky1ir?=
 =?us-ascii?Q?6c5o0fCl7o6cXq2OMtQN5/qkqkxoHTc5szmSpriyN5N//INJ8Z3yfr+lbJbi?=
 =?us-ascii?Q?Njw2inCDTgULYN4VzfMkVCrZB3pmOVZ1/kxKYeeHCkWwkC3u3MWLVF43si5Y?=
 =?us-ascii?Q?Zxz1E6HGPF0MeBTV79GHzB2ZydJr91TGiwDIzJDIISto6mg37c/FWPR6a348?=
 =?us-ascii?Q?orqPa0cZR5MVj76jJ8mmwmmW0enOm+IRL3b2mjOj3ad3DZP+KnLnR2MOjZ1x?=
 =?us-ascii?Q?rOv1ioBjrMtwuBcGQRYX5RNvmgSoY0E5DzB7AVS4uYwCrkgeOXAehSWrrigo?=
 =?us-ascii?Q?ThntGbSP81SBspDDn40cfqHi4kum+i0uTynmeWqPQrCwVH6QOFXVaNLjNLRi?=
 =?us-ascii?Q?kTQnPQM4y/5AZepqOmJRBaemEZbQXBVpDtuOxyCFFXXTLqseLUNL+Zbnz58g?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e10ff3f-e3cc-4f4b-d102-08db93d9fed8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:27:49.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzM9oMJpE0TTCkkAnSUt4T3RxmpfVq5YS03RoyhxccaO/pLqxFSjgwdpjx12guOd1H9d67V8FSw7qD+y/WUsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Use __always_inline instead of inline.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 5763bd27f56d..ff4dd13fd8c6 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -274,7 +274,7 @@ extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
 extern struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-static inline struct sock *
+static __always_inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
 	return subflow->tcp_sock;
-- 
2.35.3

