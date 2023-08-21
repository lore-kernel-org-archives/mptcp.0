Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835C1112
	for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 03:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+zrGtyZvj6FGCSV/UVQMdIXhre1v3cggz47MhyQCScWYIYliT89oVXWsRhE9FGKadPdIqFsgrJeqHnAyZi346FdYu5a1odq3dzpXKSRUlXSn5TSnw+10zjfhB3q4+Ouoswk74MZsma0fxuZIzujabXGWCRATSSfo/tVDIl9pk7nzKHwm45g9ZJVL3Sj+mWnE7S8+P5BX5eeTh75rgv8fZp3aBMg/Jx46pTcgmaaUHfb3a3gqwqQlpzllrayj7Z5I7sWFoX1J+A8SKR550v5FajtbR9a7KPPOILXMmpxJ84C+ajgCMOIDbqhWE+gYgXvAp6UPgxmnQYfcGM1EquZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzlnyjmI49qf0ulvbLNaY0OjdNZA6YHUWHMy+pq93do=;
 b=H5fAe7IM2qL3dXEzOqJ1mOwjtq1fN8ZkthGebGnuT3XN2g/2XRND3uaD7yku4PNDV0zeBluPhYpk8jJAoOjEts/FL8BOqNCFIkgN32zdbbc8+4cT/UZNHoMuF2ND4EkZBC8ln6+diVVbWQWMe4fgmil9fnlshg2Ihvaw0D4UikAky5vNpNx4HkhocivQWvEUKvJe7gUvHdHZYiU1MIzzEit9sjA6bWElBEFoFmRiCaj/m+gI+ggTOBc0cuUKTa7J2L4+aCk3UBtK10jeL3adU5tNZiAIOdbgkjNnsIWV1ARObvXXTJyR0AqcSCdvODSAA3BEL/N+AZ0M3C+/vt7Tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzlnyjmI49qf0ulvbLNaY0OjdNZA6YHUWHMy+pq93do=;
 b=VMWtVUaOKYiLMwDQLPcpc82goJKOkLk0+3KyXQ46mNR7puQ1Tw/9kl/hRKDNXm9LPe2nA1D70EMxA13y0mMCiAVPqqCqM+ImhctSU2clsM8wasYiNnxjuYqNCnBn2ePk+gwjPHQHYi5dXED5mzqZM+6VzFdeL49MZyjU8oeCsUoRuzlQzgIn+k4tuSXSQwyHcAbTuiGRQi0NbI5fFS3oSYwclntvGBrIzyzKTJaegMIKWj4I2Nx6QEMLBnQq9kxpZr1dKq9AuoKftF42pxrUN4qx1oeVHdMcyCEAGa4u7SQJKdHAKT2T/3xDmZiccJ8WSWEb0YTx4TPuBbSUHjdqXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 03:33:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 03:33:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_stale scheduler, v3"
Date: Mon, 21 Aug 2023 11:34:04 +0800
Message-Id: <03cc6fd8df7127486257bf1dfb2191115b142533.1692588823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 38494a25-6aa7-4511-3ce9-08dba1f76e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	urG3+oMh9b97GdhmGwbrLse7AXYXDL+/mJMQmf+VVNGsx2VJwmZg6DtawVfUE//lLkqu8TkEej9AWHysc4sKf+BNqo8FiAJUrbS+X2VeO++kysKeMmslkrJj/NLRUXANDFBiJ8GA6UIQ+RVJt/Tlei5qrYNyZzx6aIqTBNAcqybgJsVKuGxSQiOKPshvhDaWOMsNAmpD8ijkl6HUjasM1WnjsbR5hksd+52zsU2XGtAk/p1gmxF4K4Cfunxm+/iO1F5qy9GRBNjQDFhevUU7i1aqeWnXTNyF2c93HU9f2pfIC95o0J/7dr4TgX2/9sdcX15HESlnnyOMNH+EvJj5tvYKGMo35YUunsKFR94rKWPj+1dz9O2XiJMGz2qi21P3iByT5wX711TLkcOAdeqZiIfkmTZmO+7mNQ9qwAAcIajGwqCc+ibq+uueGgX3moee2DPGRagMpt2P8yHvY9QYgI+w7iPY7k6ZlITja+QQDcMTZxjbNcQdDczALIOUpUpNTGyCvK1HtDQSlZHqwR4VojJUqLSvA9GMZ9qdUzGfNGgS/Wl0iM0YZV8DIAo1soebXR5WrACbOrNQiivTWnuwhKLKwUGnqeaH5ns/eaVqC3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39850400004)(346002)(366004)(186009)(1800799009)(451199024)(66476007)(6916009)(66556008)(66946007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(107886003)(41300700001)(36756003)(478600001)(6666004)(38100700002)(6506007)(6486002)(2906002)(83380400001)(86362001)(44832011)(5660300002)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkWeunp0IIJU2nN52s1/iA0Rkkxm3BUAOT/s3vHX62oNOTAx+SyyrMcpGaBw?=
 =?us-ascii?Q?SuGK+xk6pptZgwSoHCmDojBBdE2FBGimRIqZbYUep4axbvr+fPYCx2H+464E?=
 =?us-ascii?Q?B6CZvd83nHDFYqFL4b/co8J/aW2ZhgG/uMiZWhaPkTrKhWfECr+CxheR9Sg/?=
 =?us-ascii?Q?N6vu4M/1gxq/vShMgtXnVLAf+zd0uBdGunYSyrTkFx9akrpsz0IVo1HhF05Q?=
 =?us-ascii?Q?huidRzbHGd7fWKUKf1kB1GM1hTpiGLpB1i6wTcGuK28mYnR1D8iGU9DPMEX5?=
 =?us-ascii?Q?UjESmBsbF2Ldb7mediNaFEwpNAh2MThJgAQWRIgHlRNTbH9THCdGcVNhEix+?=
 =?us-ascii?Q?PEAmNOeJibaWKZBPZsnVwTFM203uTsRfoDejzm5DXUnpmauvKL58RPzykteC?=
 =?us-ascii?Q?1JkU9swpDSVtjcLKqZzYm9JBm6pQyiFKJUltolVjVraPqmcmFC/3PG7L59yV?=
 =?us-ascii?Q?i9x8vErcplqmcJDANj/qTEA/wkaySS3RPL2Fw6sesNH7mmW812rtW1Gb85T8?=
 =?us-ascii?Q?pkYpdMNL3e/Vai6yCgEzR/7GMUtJE6krlpp3EgWHaS8mQXJn+E55lfAPXH5K?=
 =?us-ascii?Q?Iqi+g/CrdSFHH0u+WVzLzJmfZZF73rkDcQjPIK1TZjuCP5Ifl7KUuyB0YqGX?=
 =?us-ascii?Q?XLeupsYyGnUmdGn8gqVB/US+hzUUOS83FNRIli3VvKsCwpJo1Phe0I6RzR3j?=
 =?us-ascii?Q?uvHtsd31zJlHTILjtQ4QMT6HiHCuh+62X/89A2DCEDIgpIo1uHCtzYbzL0Pl?=
 =?us-ascii?Q?jTPemqi02HidN1kYeK4XJTqW87t/ep9SmlfnmRZ9cPWYdWt8SrimSjEbo7zh?=
 =?us-ascii?Q?ZPBgmUQdFUyAOCp9V7zjCf58XUReRoV0cy2f3nYo0lr+gH2t8ZWaKUZQ0AV0?=
 =?us-ascii?Q?fay+TZbd9RbJKA4eHGO55FQq7bwIMxm3PyaRUHY0VFd5SgUTdnqkfSFDk0DJ?=
 =?us-ascii?Q?fZZzQfHqnIlXBbcHUT3lfODPjfsmuQCdmn/mnKVaj9pmyG6S8+AkqXAGePbo?=
 =?us-ascii?Q?WnDMEvOHNXkEhOmvemZkDnlrW/Sa7TTWoD0pMJlrQA4cnNubbhGAMCP6ykHu?=
 =?us-ascii?Q?C3kx7hiD3QGHsYv66P+etMGb5W6BYgaIJjlZqVwm8uPrqtlZjw8AYGQOwz6A?=
 =?us-ascii?Q?XNABJBpXxOH8H0J1WCGUltnRrExVU5B/DYXwxJhFhF1rxRASqG7fR9DtXZ0J?=
 =?us-ascii?Q?m6/ucqS6saye6mTqdV32v5nIjYMaJdODj9XdQZ9s1ijGglzyKhgCFxo/Ldzz?=
 =?us-ascii?Q?n+mH1CY4G2PHSztSXna8IlFOCTS5pejxSGIiuJ+bD/QNFwPFMX1oL4D3MhYo?=
 =?us-ascii?Q?cVN7mvQimecW1JeYvDGDmx/snZdnFv87mwwOiU34fgLp7943TSB0NRjZm1D+?=
 =?us-ascii?Q?xjjSrYWwR6UbjwHssp3zHzl/rqH9VLS1b1K7h4IxuXM5X/1MyzunFvq6mPMq?=
 =?us-ascii?Q?VQNwukLv/nqojPCyILF3YqH2vfu59jrh8Y1j42oRlSeXQL6owIXAm64U8ewm?=
 =?us-ascii?Q?z33u+5VUUrRxhIyfocaWJSM7zfD+WqGhfjVl+GFX+qaCigOkfwx9M8qbTjqq?=
 =?us-ascii?Q?pMtH/uaLkMKjQ9FIL5C8I+r6xd3M2UG2BqCksE0z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38494a25-6aa7-4511-3ce9-08dba1f76e27
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 03:33:48.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oM7cMit7INh0GLII7p2hU6GSLB6UNoL72ak7n3UF8ludhVsf7NzzLKe29rRSNsCYAQK+Vlmqra+Hxbbm8SEwSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Move set_stale from get_subflow() to init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
index 08c857f79221..b5ca9e273409 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -90,7 +90,11 @@ void BPF_PROG(mptcp_sched_stale_init, struct mptcp_sock *msk)
 	if (!storage)
 		return;
 
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++)
+		storage->ids[i] = 0;
 	storage->nr = 0;
+
+	mptcp_subflow_set_stale(storage, 2);
 }
 
 SEC("struct_ops/mptcp_sched_stale_release")
@@ -102,7 +106,6 @@ void BPF_PROG(mptcp_sched_stale_release, struct mptcp_sock *msk)
 int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
 	struct mptcp_stale_storage *storage;
 	int nr = -1;
 
@@ -115,14 +118,11 @@ int BPF_STRUCT_OPS(bpf_stale_get_subflow, struct mptcp_sock *msk,
 
 	/* Handle invalid subflow ids for subflows that have been closed */
 	for (int i = 0; i < storage->nr && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!mptcp_subflow_is_active(data, storage->ids[i]))
+		if (!mptcp_subflow_is_active(data, storage->ids[i]) &&
+		    data->subflows > 1)
 			mptcp_subflow_clear_stale(storage, storage->ids[i]);
 	}
 
-	subflow = mptcp_subflow_ctx_by_pos(data, 1);
-	if (subflow)
-		mptcp_subflow_set_stale(storage, subflow->subflow_id);
-
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		struct mptcp_subflow_context *subflow;
 
-- 
2.35.3

