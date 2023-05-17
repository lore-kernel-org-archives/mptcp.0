Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135C18B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca/5R75o5BhtjJYjpzvn6pD8mSiphUCyuQ1EeWwsUAmONILlb8Y65VosWKp8Quk4R1SEUz2vyo+W+yAgrxsabSB4z+h270SPIgLxPd70zPbaPRRRoXU2Gt+5+1lZuGpY/ceugSt43h0ZWFokcvk4SNoFiP9h6sSTMrOMV+oczkE3gWtSCW3g22btm8aw+pEbqZqteAE4mMhXt+tC++jBkM6Bx7hEDT4laFRstbWxvtUxSiCYsFyW7Hj1Wf+5kA59SW/Yy7v/zaZlC3DRJKIHzADprmPI2nKw9vNnNhYZXOAGIFFRJIWfwpO9TYr9LzsCt+c3bznIKopGi24GwkKuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Av1Pqyo/TLJOQjVLZ7QjMjdaDqeviPTl1LAJ6+dgxQ=;
 b=MzYeSUlPC7V6KIRk6p+8XpIWa33lrFYRcG6i8t0+VXO5diBy6zorq6cvKMT3RUMAnlN+rRxjuQckL+6L0Qz9bCqFBmzThawsvCKdzyYSx6S+TJiomz3wjkpj9nk5x8j/honOLoFGU5szvgq8RGhllrTZvLn0T5HyWbY87wysH1J0p37G83vT4T5pH5+XJ1xoVvdABlG1SQggraLRhxwIxxxZFE/jQ3nRf+fpLtfYDYTzfH6c9isKF4FAddkIBNlSthARCjVZiKkWytKUDfmCXivzigo2yBrBI+QgN7n539PYo7L2nU9uKTg/0ukrcOs4IfE1v9YvlwHBdsPuH5DYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Av1Pqyo/TLJOQjVLZ7QjMjdaDqeviPTl1LAJ6+dgxQ=;
 b=Rd0reWbzRys30It1iwU3xx1ls+iwd7U0ZH7uvFkNgEjK+mQ3PZZgCOtmoQHkXjcQaNK241XaIQL4zrVOSQwgwIL8b8DxOe706j5SKVsGazGIRhTx5o1OltYFtRR2EzSau07e4n+kWu1UCYQhetC1zLivErBaigPE2B2FpVu+6yiskYpmS+AsYz4yyr9AUUpTpdW9Qr0PWvOeRHf51bN3DA3uvRaS7RxBVLqMxQxCNccoMbKSE+YXc/uHVzuaXLWXJS41rurlqRoi7Y69GS2mA97ySyBbXqIq5Ahlg5ETUcfnI0BCr44vOX/x7+jImr6NhCpJmHQFzxxVPI6U+aahCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:58:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:58:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 6/6] Squash to "selftests/bpf: Add bpf_red test"
Date: Wed, 17 May 2023 21:57:14 +0800
Message-Id: <1bcde6c0ed5c841a2eedf214d44742d683c85cb0.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f02053-cd76-4144-e06b-08db56debcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e33T05ZiPfXRis7Opu4ehBWvgnAhf07oCt/42DDv8+Uxl4GbM6efy8KVuUzYmoQW7kmCDDQGZyoXRM+iY5Lwvw/N9e7cKT+EccClJfR0XIMMHXzbF7h2s13BAZP89T62sRNEPfJs+TRdWkYwbgzKr5GZgKJY34iLnj2tntX0q/u6NSBqTIAU1r82kRF/giTi/CHX30VIyq2RrjoilLJ0yBo6YiBwTlQY02Z3DJm2HPdMk4EnGk23ScVhyVKf6ZFFuCMF8SXqiXXLeo2vgijRuuCcfdJfq48EwQFgyN3rWKCTFeQkHaBP4VlyiF+fj6Bx8J0JT62P3US7eZzMDXcKlufAd7d+4r8sD9oNpI0R56WUuuuwkvzUzGBAP0imurOiSWkw711c8FhyM6ov7NWXJ1rphTsqJaNsptvSpBmg7Y5T2vSJjPcXUzPhAnLWIlIKgWjfBJs0QQh4TfDkCx63aPDMwAW8GSjsyaMLW78jqsA8QUOio/fcQRhn756NroVl3oNEKYt7fcGeqNNupWw+VBtei0qmjjp7uSZKSkDpW9BPpqHlTv06u3L4oifOnmv3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UT2PRLoWFeKVFqy4qeZJZV+85OujKJAQGtPCbFsmSKRHeguE39IXy6rZtJQV?=
 =?us-ascii?Q?h/uxhCtBI7IQCXVsvs6fMGydv/S4KQNtFfqB1YIV3rNqdNNrlZp52pwa/ore?=
 =?us-ascii?Q?RWaXG0ipfQ5CeOxl2UJWEqe4kfLdCR9Gj8UyBAwE/L+y3G8/0ySiFJtkUTWT?=
 =?us-ascii?Q?GdR29+ldK0L/ZbrPqC+mW6pFevg70fVj6WE+AahEPFgBny4l0MgqU+C/Q2Ab?=
 =?us-ascii?Q?yF1HRa4L7dFNkWwOTrwCoX3fdcdXkgWWZpYEdxg/+Unyjc780wRPQtxrdQVf?=
 =?us-ascii?Q?1VibqmNKTGIz/NsuvN9GlFvpv6WcX7Ofe59tz1Oczd4kQKuQwNN+QIov4n5C?=
 =?us-ascii?Q?kgAT/6rEA1LXMcbSfsvo/EersUA88mWbZnNAlRWWqaPxCWcdZs0aYszt0eDE?=
 =?us-ascii?Q?9sIzkgcPJKCMBcI+tdU7BmVpLfTxcU0YhxIncPiSSYPTGoWy7oXkTbAClBcr?=
 =?us-ascii?Q?gDagLTKWKbjmvBTs1fHGlzgf7lPmrkuKdmdu73WWMd5ONtU8qYEG5sac6oF6?=
 =?us-ascii?Q?DZ7F0ZXoVe3EUvg8MstshF++7gjToSBsdEqWzp9+v07fqJh3xFb9E5BiY0oS?=
 =?us-ascii?Q?AmR/Pf/4vgyHI5g2fMoI9XkXewISwZj3tVOfmdTMBChLLIFrxZ7IKP5EScbM?=
 =?us-ascii?Q?akvY5vZ/0AcWmnLBnirZJWoWbJxeNjoM1RU+mX/SOnwS0fu3HlFYPuD138t3?=
 =?us-ascii?Q?h5fL0V7K62cf1DYzBzRdqcxh0PjyD41UpuoXoywMVxpz0Q0FAHDOAeoX8Fve?=
 =?us-ascii?Q?PMZ23hhNB1D/bkrkpiadO9t8y+952NwEyDfIdLxOkjzFgduOdAjZVIr++ylM?=
 =?us-ascii?Q?fJVtgqgnCl8RRYXBFv2VAlA2zqvPpL0scIb/Ttz3Y2qvzGeqmH4cuxzRj/dm?=
 =?us-ascii?Q?5xH1rgxSIiNS1oUg7F00AwDKHH3uI6kyPXv9sAhgIMQD4bbsKIFa2xHCkKcW?=
 =?us-ascii?Q?RRmTUFuVAcTxOyeLUk9/QlABhITuccHd7UNCbT18ZKBMmqbzZlnnCxk+FvJh?=
 =?us-ascii?Q?4a6qiP+gupzWycIJyUgJzSBGTTHddAjpvvH9fWa+3O+xEMBvMsAp+hzD6vvG?=
 =?us-ascii?Q?7QRSHDThx6hm5XhWc3UbIN1ppOH7Pft4zMLAYtQvLSZSi3nSep1IcXfBtjHf?=
 =?us-ascii?Q?BaeRqVlz6D626O2MgzZV9yG/QQSVb79swbDqxZ6bFoe0ZoPHYsobB3tkarZx?=
 =?us-ascii?Q?KHcbhbiJ+bX4yA773Ao0SjIOdC177duUKksHSmzF9e8LY7DWIHqwFC35zwZw?=
 =?us-ascii?Q?Fa/FQ94ctRtsOGxqjpg542WldVIJROXaQy+XFeWN1zIJpwPOQOQ4K5WBV20x?=
 =?us-ascii?Q?ieb8qy2ActQ6QnWpE41fjatIQgbmt6/ihIWVZ07X+pV4GMwc2jnBQqtZpaFU?=
 =?us-ascii?Q?6akvWjaUmJCp/UgMsRbaXr0UDe0vc3VHvyksx6j0D+FeE/mgXsk6ZNwVTKdS?=
 =?us-ascii?Q?a28RW6kj8Ecjxj2aY62Whx7OrQetOWS+nhRzHdvhT6WnuhZzjoe6+ij8ZFOh?=
 =?us-ascii?Q?xcMv+/yjR9wCFggqTVOJfoBx84pB63f/l2zpA5PjHQ+kV8IeDwV4yfbY3mKa?=
 =?us-ascii?Q?PPnhcjOm0J78ApesBA3zFIzxTN9FLewHPNJum7FI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f02053-cd76-4144-e06b-08db56debcf3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:58:05.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+QJVLO2eIe647mv7tg1BICKvWR84Hkdti7UKKOrSFDILvDkWcTTXKa0OQcBCpToG2uUeDF4kpUQh93f07kOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 912457da88eb..77aab18c63a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -421,6 +421,7 @@ static void test_rr(void)
 static void test_red(void)
 {
 	struct mptcp_bpf_red *red_skel;
+	struct nstoken *nstoken = NULL;
 	int server_fd, client_fd;
 	struct bpf_link *link;
 
@@ -434,7 +435,9 @@ static void test_red(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_red");
+	nstoken = sched_init("subflow", "bpf_red");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_red"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -444,7 +447,8 @@ static void test_red(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_red__destroy(red_skel);
 }
-- 
2.35.3

