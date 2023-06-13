Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2170361
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chruadx1uRmwXzb3LBe63m4btsoStbX5+4hSW1UqvYss5EYTFswx+CagbL60FmSOHtM2qzi57k5AXsX7GbQjAg2fSee83hYlRSJU67qs218JtjI8oAi7Fevt/aCBqXPIPXK7D4RnTfV8X2GQw+hEi9wId9IfUqb5EaoYTnhcoTXLvl4VxPAxO+FQb7TDMt+qc9CVxHLZpIJ7qu8mCGLefhsFHoF8TZNszqTnKEHbxzrk4PU9ofCoDLdmmtMKBdj8RC/qU6pglEtYz/2ALVH04e3JEQl9JPKS8rNmUC8u15yYTtGPwBf+dOMW7/2EMTmvBpfXGqQIOW99pwcwFC+IgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm5fqmsWsiZaUfU01wbqQfyei4qFYcVVH/OvWxBR9oM=;
 b=SQNNWJbIKdR6eT4YShW4wXoYaxfsSOiXuS4e7+y+LRw7QMnD7kPLczm7k/X7whi/+SNLlaTJVSJz4eEwn/S2w+TkmrDAX8Dyi3oVFKkaDuui0FL6G6q2LxUCes6pWjXV56tABheSogv+nPfP5uP3QKx4n0GK5yLPmnh2P0mlXoMZdE088+ZhEtOuLdhP20eSeK5bXbp8aN4f/DnYyek5HGAExP6XLyso28oYIvFKDqbvgrJcVxGPDoyOE1I6w+ZebKtA7TKsH9MRUVUnHBcp9REsj0SaFF+ejXgX7yQNfM11zscI2eQ1ZEsdb6cBj0+nUd2hdOrVVjWjua0LfB7O0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm5fqmsWsiZaUfU01wbqQfyei4qFYcVVH/OvWxBR9oM=;
 b=O04t2lnyJjXmhYiTTk6khhewUpyev3pPF23EbvpL4KLlI4XUt4Im0JTrKU29hdDdbXxfUxoabwB7EUCIqRUxZ2EvkzAt/DT1oUu0xIZfLSItOVqahzZRrUKGHwQB4VuqGzwRqYUgOlnCtU64vOURvWhXWek2d3G68GjKM40LP+swIhFcHdSiwgwZDpcUCISQ6bQSKH8Z+WettAfeTvYhiWYKTKelAyct2XmGzan3quWQWlno/OrzwEaxRz1XVPQlfg0QRjBADVSAZeINzorBDs8LhUpeiQQxgD2jBt81F4ctAVmxgigv9ZtOUasyHDHm04HDQee0x44XYPfLa1kvMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:32:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:32:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 4/8] selftests: mptcp: set FAILING_LINKS in run_tests
Date: Tue, 13 Jun 2023 13:31:11 +0800
Message-Id: <566cf464eb94c1f37f6c5b082d6296fd7d3c39b9.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 993b7420-0109-4a47-ab1d-08db6bcf8d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CmWzGZpTf7znsXNoTrF57zoT+GyGlAmsXsz3pQPlDsk2qANr72efS3uhinVB2NWpiak93bFzku4jWPn+j5VlZ0aEK7guSwJy/qKauce5auWfjR75U12jjXtup6lN80zjVv6KMxIaAGv/eEEKy5A+wns2nLdB8DlQTgQckihBTzDIINiSbQO8e/XXdCp5mwwW5+EPUiSNeuX1n+SPDx7W6714hfI0Ifl/KN5NbP8+tlfzfPvjyT77Ao/Rnt9DStYNemW5G0DDaFfucpp3ZxKCq4MMHH72zpE23WUC+ZmKEri/9qbS0+9EBc/JiNXQTi+ioT+HEJGFrEJS8ezStKc0umUtZuenfAkWsaw9sKEmWnnXtKcPeDx+oLmbW9K+kNxjf+cK8+0jMlp3qdo3PABcIw1dUmp+K0B8kPMSsqei+ry6vksnMj8zieTf+gB7ndOC6+D9YaKIA4PnWGEMO8Mc05dGrhgNJGfoAz8UaAFu4T+RaM1SM5MF8hlDxs9I6LRAvl1qosrD4AIBUSeLALFgdS74r8t0E+E91ZMOzuIYJok8sxgghS+u/JXoeIxKVd+z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(2906002)(44832011)(86362001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tyLXVljaNPBq/dMdfbxYbhQoBgZXBG+FfAQQ8i8hvPy95r6UA53UHCjR/V3b?=
 =?us-ascii?Q?akrpYb1oXAOK9o3BP3Y+1UD7FgvCCKi+zBnsC8RMGCT5fiYzWL8CIO2pLOC0?=
 =?us-ascii?Q?KHQKtV3AbjyVXwgU4Cv4YBpOCNk4Pwt6q0mCWGqCYK1JEf3Xmp0GH8HDVgJe?=
 =?us-ascii?Q?vYEVYbKL52vvQsd+uCbkvL/jazOrvNtEIcVJQa5su+lOG0lgnAoiHlbqLVjr?=
 =?us-ascii?Q?ootsjqI1Cip6/Y4Ok++apSwpmJN2aUvOMeusPUKu0C7pZyyvitFrOIvT03ul?=
 =?us-ascii?Q?6QZZtBQrA8VEvFdKqk4YAq9249zv8loyu511ELUeTcUS7hi1jQukibtOmomX?=
 =?us-ascii?Q?GIyJnBimWrdHiXGnb1U4r36ofAzTLJ1KdD60uNZCnZ+OsAp3sZxhr3N89D0J?=
 =?us-ascii?Q?MRt9LaOdgTb4+ep/iZp+lputz5aVP1fiwNTq1I4G3XcAUk+qvHDzLCPEBvyd?=
 =?us-ascii?Q?JhbMLol5QHl5gDATiio5BrLBS/nGzuTSeboFjRlD4cC4BDmTEvXMjkAbZnOK?=
 =?us-ascii?Q?xukFxFzsPplsldAMlWb/ZUUjjlXRIP0try/BZlsPkWGZxxMMszhZTf2dBM0L?=
 =?us-ascii?Q?1GFbbVug8+ovSoFfFXnwa5a6qJNGmR06XhGjC/KH8wHZCsUNcD06jsBBrA23?=
 =?us-ascii?Q?NU8GaETpL67JQiDXUIya8USKCnIL94kwK7xGkv19GHwFskLY1mp50SKSLWjz?=
 =?us-ascii?Q?pnBs3HUGCM6KIbdMZUO62DGxxbt78HIm2w9f6LEh0VtYXahcGlmL35trgsnD?=
 =?us-ascii?Q?3Xy1oh02tCyGiGd+ZEo0HqPWWd+VNlKomYAbvF13riBhbtNfwf3lZ5X3oSP9?=
 =?us-ascii?Q?HAxk4/K7T2hzSHdaq1OHT2rXwYNyNoU8U4Yjw+/JtmUmGbxFeGSEop8dRQYP?=
 =?us-ascii?Q?vFiweVEIewnyEug0T0Hm1ckNL3S8qjuuxQQMhA+x0ZCpHjKHgGfa84ENQqCX?=
 =?us-ascii?Q?gE59F0t2JIkxbFnwSEABcarJ5+dcqXosq7J/0Vqp2un2PhPDQOffP5bAydIp?=
 =?us-ascii?Q?iQcqVjaf9PLv7IDkBFyRKALR+xJJzFHinXk29SbvCoGnLjsopD10keq0Peir?=
 =?us-ascii?Q?QwdD3+FhgDRkZaNSSBYn9Jvr1rPHPczXKhNUmCrpdKK6xGjFwsUsz5GXkkno?=
 =?us-ascii?Q?Kq9TpjlNteb+01Y1oaznITcTiRyqTJu2WuRwkFLFYz8HAxeWypJ2Vg59UPt+?=
 =?us-ascii?Q?ivMc3nbjerXUYf32MWaIiwdma1u8mi+3No7SMz8nUz1eM//qVGoEsHC6hPo/?=
 =?us-ascii?Q?nV8yKZeoen0/iMVJE68sYpUjC+Wc3tdnIYYdVP8XGCrnfkFRmvqC7CKzzpPB?=
 =?us-ascii?Q?31U20MCU/wr9MFFBj546NN4mkOoJ/+XB7LzMknrv69z5BwkS+ylovHdD30ho?=
 =?us-ascii?Q?td7w64/sGqWGpzomMod+ozFju3oezHY7XDFJ1QxTzLk9tFHAcznyYfK+Sahz?=
 =?us-ascii?Q?L7adW6GZkUI6tWf8+F8AWtlCxnZ4ag15g9nP42aEA5w1cL3I+Yn7BxX4/SXm?=
 =?us-ascii?Q?miIAiwWKvErUJojBAr+6Ms7ojAY7lSSbZS7H0yR03UldmlPCvgIBR4KzcVn7?=
 =?us-ascii?Q?CBpluBl2rBFXifsXw4Q2L2bB/cuokhC+xqx1FquP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993b7420-0109-4a47-ab1d-08db6bcf8d12
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:32:17.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McRk0sZAmve4IOok0c4/64j11LdkWEPnTlT7CP32SFGZXHXnGVay2pVF2xktVHw6xyG5latpMJAVKN7drMk+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

Set FAILING_LINKS as an env var with a limited scope only when calling
run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3811a6c3dc5d..5146c5268c44 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2183,9 +2183,9 @@ link_failure_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
-		FAILING_LINKS="1"
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1" \
+			run_tests $ns1 $ns2 10.0.1.1 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_link_usage $ns2 ns2eth3 $cinsent 0
@@ -2199,8 +2199,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1 2" \
+			run_tests $ns1 $ns2 10.0.1.1 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 2 4 2
@@ -2215,8 +2215,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 2
+		FAILING_LINKS="1 2" \
+			run_tests $ns1 $ns2 10.0.1.1 2
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 2
-- 
2.35.3

