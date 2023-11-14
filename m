Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DE612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="2wjuKVCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO+BTfDqqGVyI2yqR2z2hBI9ywE/hvjgvA14ppn82CqV3Ac6ne3MgZH6IHMSyx5Oyc9RMJNDzonSEH9t1h9+ChATT9NXhCYwneUDIXb2oz+Lx0Lr8SwMsfoTCs2ohwVTE7Jhx9wAUQnmhlkfDBz8PwbqVXPo14EBEZ4rrFxyYNQhP4Ol/ym+UOfTEYdhgFF/OfHuxlrGaOjdBj7HDz6xHZROBq1BP1uq1wSt8laYdDtnCn/DdLPHUENCBmJc4+YhfOeXLZbcTW72sFqlljnutnH2m23UCo/JsI9jZMxreoj1N+knDuHC7+dGngSztvrM/nx6yM2WaQ6M+/SDloXsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylyB2i6xIwqVSug7eHgYL6mnnTQJMkmRI7REsg7punY=;
 b=lpnuoR239+SYcJUJO9J1ue6ZzajW+rX5tMMZokQk+CTAnc6NDBVAn8jdFfr0wg4ZBh3uWQmqHNAGrRFvsFsqNmKczvXKpxdn4kSApq5WVUSEIhQW3T2UWOWYy2fHSpXYrBr7knVro6YbOokehyS3Z3rCFF3KbAsfoPAuBNCuFvqPO5HSbGcyVfOe+8L831Qzxxu27WAVKu04GBQvNsk2+2MMRVR3slykHG4TH1CN1uUVGvejxAYAUpvjjfl0wtWz1XaVh4jo3TyD9TI/+1rzGhn00NRtSkGjXKT3dJIo45DUYdfsu8VfNS0rblviqtl9Z3pPotFO8oU/2JCoef2aSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylyB2i6xIwqVSug7eHgYL6mnnTQJMkmRI7REsg7punY=;
 b=2wjuKVCEcU5GyLkZq/GqHFsbQDMEy3cbftfDVe9EfgEpPkPBr85Y0bhb1V+IepbO7vK+ABTskSksJALVXFuo7fDqZPi1ysoC4OUwlK5igRwVh5MQVa7CviezxiWEfmQFpNigjAOhUI7asDsovNANK884a/SvixrXvgE+MthOnc6mpNNkJl6j1zTZGvkDrYQfDVSXzzBazISOXALi0k2aR7jN1/avHsyu/EQ+6xpQnATypfUSAMH7zME628+7lzvxdporSS7+QtvUX8EEe9xjQxfy9NKW0zzv6mMHyI8um0ZhrhR7OvBZXriiRDq2G2wHRupBaAnVqDRJOI2Q86ugzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 20/32] selftests: mptcp: diag: print out test counter
Date: Tue, 14 Nov 2023 14:35:39 +0800
Message-Id: <4acda9bd89f8f3e2286f7d44bcd9a0cef8888a22.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4c2dec-f3dd-4675-dbc1-08dbe4dc95cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHJcUpcy3i0bW+UyDNbrdh70QOrY+kpDwHcbUsgs96mzLNYTjJGvmNnh5TOYq3CsO+yV9oASReM3fpPP4sOpR2/PIvYioeh8lmQtIV77zLGBYWzpKRUmX8B011r5z5bqR/Jzwt+/er6ueuLQMNg/19CN0zvTZuoIklQzA2qEsEuWZ7991uXCYRQmxzWOa1n7NcIhZkI7Rngr3YB/rVGRqQNy0dlUcQ0pD0/Zor1iwiiFBmAvyrcx/pRzQViMt51QkDnZhUD/qqney1DUgVKpRJTEHPkjhw5iUbCnprvJNSfqITHmTbQCk5pzZb4y739UiNQkFQ1+F92tJzM1tUZJ7FupXO2gArVK0p37ztoz4Hh1QnEAd4/COKWz2eMp+DSgcOaOliUIh64jzcKfg9NUqVNDhGDylocmHG9gyLBY9x14fTYTJt3qV+qdGwpy+QHEHCDtzTW+6dvSaKxdNYGTGy2NpoZgMDDj08gZ9FS16Pw8Uxl1aydnbJF22D5Y54HH3U10eqlK03Hg0T4qfq6lgh4rdzy/7fNkq7997ob25HfLoiL3xDew2p6VMIo/P5c0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ju3vBgxwfFWMr0ioB0BX/HY9R9tyjhoRQKAojg0xHSOpxoa8zM1/cNTzb2NK?=
 =?us-ascii?Q?LEJ/+kcDHe+5wq1Guz0klXU6+js4/IAAKecD/nYQZ34HKiX6X9E9+IHwp5xq?=
 =?us-ascii?Q?GRhs8iHwxLmwZ49ZroOr5Z0nTloxMnvbBZ80Th5vycVyNINzk1uqxemk3sa2?=
 =?us-ascii?Q?STz6aRp4b7sTEusXguvLkSaFdy7xctXO68eyTV6+c9PD6jJc7XO0xbSlSy6r?=
 =?us-ascii?Q?Xqe8aIYwAVudLExMYdnKAQy86Mrm5RsGnxeFbGb/R2IvgfCZxVUN+96PnSP/?=
 =?us-ascii?Q?JV3Loi5FydOkKVTzy+3zPIgrYRX0TYm5kKlHO5gCj0VA2W6oonhxwt1wvDsZ?=
 =?us-ascii?Q?MVuaJsNYzm093iFkFnvNQhXd/EyGPq1v8rV/4E/QRsdLUi3knGNNmeOpBG+k?=
 =?us-ascii?Q?RkZF8Qc8X6YT62/eSbDmapTu+tjveKTZcX/vwvtkSDorWa4/hh+VjgEbZ1ju?=
 =?us-ascii?Q?Kh5ODwWN6vqSDx+SVrZ7cSPDNmqXxz27TBwUTcaXCkx3UiGPick3uOYSE+PP?=
 =?us-ascii?Q?vqk8BLjlpH3Dr45hJN2HsUMoOj4OrPtigTaLZ0AomD1/OZzu+1c+4Tio9tV2?=
 =?us-ascii?Q?A+x0nq8IqGSlHE6czrMH9jNpUSXKvX8tY5yIuOyOsQcC5r0vi+5F51kYrnio?=
 =?us-ascii?Q?AuHxbuLE9XgQl41/AoXAOWGfbgCc3BnpAmmZvD3CEvm9nvtc9qXMAC3GKPlx?=
 =?us-ascii?Q?ILdpS5R1ZZQYuHck+ZDXz4AyvHOKdXLBl60t9WBQeG3+jsNKOMPQiLO2tleQ?=
 =?us-ascii?Q?3rOMDhpwD1D6aOFAjdaXexUloOxGB9TbDwTR3ZJbInvMBtgWdRj/mCizqEQV?=
 =?us-ascii?Q?1gi+xG8MrN/Qza+0OZaVfwkXvo2SGZQo/ZjfDapTCfh/kmF7clRQwGK0++df?=
 =?us-ascii?Q?zza95Fn61q3CUHXJ5BCdbpQy114ZfYbdAENcXkWknuyCXFIaMAAO7Y2+6clm?=
 =?us-ascii?Q?KZoJj3LzYoWGQodlXbwVVys/FZBrqXNWdWPeeT5kzOxXrnLCEtc6GfFAO6O4?=
 =?us-ascii?Q?LwhytliS77t6eHQ+gjdaWyZwK+plQliMIxwDZmQBsWC0uFFNSpR4vkkVa/QI?=
 =?us-ascii?Q?9cB2lWa4iP8tvF4yyASqRktuPKJks5hcB8KjbHhOyQ5FJMXTi6wQVUKLaf6M?=
 =?us-ascii?Q?blkNY+ornn2w4A+1Jg2YSRc6TFGjH6Lh8gOAX/0Q4VfHtYdQHA4wIlhZtrCw?=
 =?us-ascii?Q?ZuQJoTfiRjJoWrR758slqMRi8x2fp48t4zTlIwD/kNzJbpUjcQvO7MmNVG1j?=
 =?us-ascii?Q?8h1c5+uBXcKrcquMxuife7lQifHzEv9E6MO0c5Jdo0Zmre5FxKr6lrkUcdu2?=
 =?us-ascii?Q?bT1PiK43waNokgH6p1BTN+33pTh2yM7T/aSW8AWbkiSB5bfI/TEIsyT1tXsD?=
 =?us-ascii?Q?HH4iLtt7niSXJfdO7Lvkit/PhqgUTYB4xHc0kuym29afE3yL37eZtaqIab5d?=
 =?us-ascii?Q?a6qJ8V1W2Hn9Y9ZQXHs1JGGkMy2yVdR5AoZesJSRbjUsTK7GdKrob5z1oKws?=
 =?us-ascii?Q?Npi6USQbv4q/Zs+T3qOvD6k9MnkDL0hwiSwqkXovLFit4LVFuo5oTxos8Ctv?=
 =?us-ascii?Q?wx7LRvdEJjctrAmd1Qm9lIBj7wbMQboR5Ix9AAmC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c2dec-f3dd-4675-dbc1-08dbe4dc95cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:26.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8xiZUfCVWLVeXiDypc9/qQ4gISjsZ4yJRQ2w7mjKRNh7pquWoDr3A91GVgxg47wx3tzIA2+0/8Cs5IMHWTYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

This patch prints out TEST_COUNT for every tests in script diag.sh.

The output looks like:

 01 no msk on netns creation                          [  OK  ]
 02 listen match for dport 10000                      [  OK  ]
 03 listen match for sport 10000                      [  OK  ]
 04 listen match for saddr and sport                  [  OK  ]
 05 all listen sockets                                [  OK  ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 541a9d2d128c..4279bb59939d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=1
+TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
@@ -59,7 +59,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			mptcp_lib_print_warn "[ SKIP ] Feature probably not supported"
@@ -109,7 +109,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-- 
2.35.3

