Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4DA45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxjRZ19nq9GcsGaXv1qQUgqwYaSuV+m6yFtTX7XhI+j/K0P4ZSZses8TGBsXqIa9uJ76pqdUPcnHmyrqR+Ap/f7ZV/Rkkk0EZrf+OKkrU+4NTy//yfCbX6v1Gsy1rKm39Z2NrSha2G44/PO+gjAln3Y8sesGk7PyU0zhp/IHLESU1/k/eOWtgKjo5upM3+63XDJwZr42ORMfwO0jBHpqWkf+G86wBoh4t5ivNIVcaNV/nBYYMS+4TFlfcyVc7ZmS39OmDOE/pMMyxnwraizRM8P2jbpIjpCnByYpg4sMhXGdBHnIdzhz4sxWIVXVDqKL6Rh65d4MEQUHVjLz6Nf13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d549GrUxe6fCjUdrqguJ38H33Tgg94B35fmE0He43Xc=;
 b=lTDp0JPvM6CdLUmrTEw481lxdFW05tQYA2Z9iqOlpNMq5AaStQjdxv6rHgyUcIqRZ8m1kKsFTFZ8aYGwVxVlznZGbW5uZhb2eFbyDmw/ueINIFNmMzo+A5WGqBCtZcywk0nwD3rpxgtx4BkrFjNyEgt7kwpCAgrzidvOc7c4dm/wAwh0lkmxkbY12Mbc3kX9GEE6fltWCM7YtJZ7LI1jPf2nMwhkArVDjUlU8BxeiOibS82D4LM8deFYovzgj5D596RSaJnZNbla06EperygOAjhfRYUttGrwfhZwvHu/0Btx6upwSaxyIx5sUcDT2EzOhc1uitqm97zrZ30O5f7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d549GrUxe6fCjUdrqguJ38H33Tgg94B35fmE0He43Xc=;
 b=RUXLbKeJkdgAiNDi0A6Oh1QJsuks6fFQNs0W+DQ01qPA2grTzqxMqbAK2t0WYLpSFboIf7japmk3kz4WHkgrt1+/99ysZ3uS05XAMtYpKx77Lq3aACAmdJO8irwA+Zwt8sKdcFuAqlxjqW3lXw7O80Fo6sZ5k2SkOCAsJUcWnaYeBZ/vyjwdAPGWTelYwnyOsKekKhPQ/Nkx3hpSxvZLjjaezPIE6Afb2MtescdZU8V31hGnRiJBjEczzDMJ85hdh/HTIOMFCF848YkM+DdrfHXNeX9s+JC6c3GaMAzVcvwEV4t7Fklaay7uVXGTLVTxf4OE9E7K5jPWeeoZBjCTaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:05:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:05:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 11/13] selftests: mptcp: add mptcp_lib_make_file
Date: Wed, 13 Sep 2023 14:04:59 +0800
Message-Id: <d50ba53ba2c42ff107a1585110e7fcaf957d93a7.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 853cde0f-2301-4423-541a-08dbb41f75ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gnc2mwTA2fiYcyW0cs77kobGMeXINt9ItowrEi2/kotnAd70sEpVAE9/3hme2+xpQ13Pzsz5i3h1JHbq08bwDZY7b/K2UXHX2ROqmpIiuHpzC+MGbysnRHq4v3TDvB0VBC7VgMQtdBBau9SYg0B4hrET/62bcr2fOcLrqNzPjyH79d7BszVE9bP8D41+pDYHbUUEfsOaQU6URDnbRTtnAB+mc7m4oFvXSOtMz33FkpDRQTwVHUWPREmpDmyI4yO7U9b7XKcoJoqx3E7ljyPPb27zlJx3tMSP0mqSSLtvHxHMddbUvNcBeUi/tqtkqN/Op/sSOHTLHne46zwiCcM0XCuxyrbWi/x6UUnDBYowPs03fa9ZY3D2gvuRktFsOMBOkejh7/nuqpCIqSMs78b6I1RpB7XFy92eddDa7si1nS8GmTNWq3dFrcsPZZddjLIuc55S2T2rwb9dAYdoanluT71TeY4Mn4jj7iLJ+E1sMOEsFaY1iTJPRHacX1nj9nHkn/kIdZD66vampTzEhUeUNZNwcyX7dPZn2Wg8HvKcPludN4q1thevI9Ti618dsfla9Djnn4+FPvZ/pIVbEvj5Slx8G+dkqqHIw54VDF30mDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anjjWgwdLYg3F/qcfFIA611FcqfURNYDvu1cuCmobxkd7cT5dRvwwSJiHh3j?=
 =?us-ascii?Q?QiL2jzsS7thvR+7MVpahqbkP9+HCP5iX9b6LV+Qkd4J+gSVaqfA1KqnGhQpo?=
 =?us-ascii?Q?O6qYIz1Hhm9wNAkLR6hxhT9imiqmvYx6yUi9RT9Dowh0kkP5gOqdk0cMeqXx?=
 =?us-ascii?Q?0oChEXxjaTw7LgATJ/SR3ma1hMFR3+eqXa6wG0BZDpN2X4R4C0yzWnwYyz8F?=
 =?us-ascii?Q?30ONBU1aqI2q5j/9v5z/Mlsy7QJD3f0ICmmAlOlHHYzj9yZ8H9g+w1d1K1Da?=
 =?us-ascii?Q?dXog/vL0PUz55sTdCdNm1utM3h4v8iOgVjXoH7YHXzsbm53K/1/4HpbIzjvp?=
 =?us-ascii?Q?84SIOyR20kaCxgI/ujDxylSf5HE/wEsp8Yl2JnL/NIacUsgIOp0m7afbfF8J?=
 =?us-ascii?Q?GL0vbwecyanJegVGqfPPM3mBl/7hrpYHL7HZVkoNKdSbEahh2usZTsZW55Yo?=
 =?us-ascii?Q?lGtZFailIKwRNYN5R8NBXfkIASk3dmfC7WLrPLopMcF4hCHirI/UiZBcEwN5?=
 =?us-ascii?Q?/e6fBVtxtuaWFEH4q+ZmA05V9Y9kPrv4UD407mXuoT4+rjio110n9wUosgp6?=
 =?us-ascii?Q?icN/AWpTuoWKUs6TQiMvtxZ7LP7GRr1DbHwg8q2+nSRoDZxTzDYY7lefD4Xw?=
 =?us-ascii?Q?bWWr8v4mMPjBZPajoNCra9FTj2AMauib9qU1suBQkxIHpWtOd6HZtR7aEPLu?=
 =?us-ascii?Q?+w20leuyeQdRZU/vlw8y1U3nAzIzfedSXlerr3uO9cuuLC33v9MhaFT3pwiS?=
 =?us-ascii?Q?I48Z528pzM8btBHaN24M/ZyQDUVL97+/rmmgebwxHPHxtIBDn8YZ+34YTyHY?=
 =?us-ascii?Q?flH9pJzkAwXGDVk2sRpPjnMCsa3zv4t/I/OsXR/8+K5KA+nSFEvtMnZj3UzS?=
 =?us-ascii?Q?dS8PJ3tK2EbZjv3axDG3UGp4UdKb/fZ5ZSx8ovfqTLQYeHRd67SQ9aa/1oW2?=
 =?us-ascii?Q?fZffXsEj6fSCMUT5Cz2uRAwpzWm8ypAMPpwbxDxMQh3RA6GDfPOAVTM5S195?=
 =?us-ascii?Q?FZ6gkpyzJDikqfNcg/E8pjANlK/KxgYoZbp7Wtr2g0nsevnSkA62mhx3KWr7?=
 =?us-ascii?Q?JqVdQcw8TYTtRGIWWIyxsRdD74+lRiUj5ajejvhdYGErLwHNtrUeMjX8CANw?=
 =?us-ascii?Q?j/JRu8cumGQvyWOZTDf2WE9p0Ft7VDNIUyDKlGrsMO7pJn5MQseTbDtU90kg?=
 =?us-ascii?Q?4bcFX1dqy8LKsURQ82OpgFeFn8/jr+rLIkfdHyb5szkIC4g9eIK+heaXI+T8?=
 =?us-ascii?Q?8sSNKFb8bIX0yNXw5W2dHE1zZiYPwGLYswKdbPQk+LzN0qW4Synldgo+6BCl?=
 =?us-ascii?Q?TVQf191DJ9RpiBPl6Osw1THoQkbSQ6V4lUu1ot3THAml6lQgwXgMsG14HpVd?=
 =?us-ascii?Q?V1Wdvd/hy14QcPHgltODWqzx7oYvtTXlwLCWLsWlzxXTwucF1jTZm8CLV6EU?=
 =?us-ascii?Q?SxKtjNTmmbaQOuEGDqcq/SiAExgCLwXzaGhr574SrkJ5XgvZT63V1GN2AMRH?=
 =?us-ascii?Q?ol+H3PJ2kRHADS6INDZTHYtBFwiPAje1S0ci7ehtXPObSdFvvEEeEZvVnIBd?=
 =?us-ascii?Q?ULgjQPCJj2iwg8seEoDKYrCNqzOJfzvatpCWryjAO5EWsQtBXabel3/eddxJ?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853cde0f-2301-4423-541a-08dbb41f75ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:05:41.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsIX7oD0/MwjnCwEG2w33aBWudMa54tNjBTQIFCw6RJ6LF6/c4+F1Sxgg3MztWc6N6PN6AgfcVcy5XkPmJIZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

make_file() helper in mptcp_sockopt.sh and userspace_pm.sh are the same.
Export it into mptcp_lib.sh and rename it as mptcp_lib_kill_wait(). Use
it in both mptcp_connect.sh and mptcp_join.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh       |  3 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh  |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh |  9 +++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh       | 18 ++++--------------
 .../selftests/net/mptcp/userspace_pm.sh        | 12 +-----------
 5 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3b971d1617d8..dc4a1dd3566d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -592,9 +592,8 @@ make_file()
 	ksize=$((SIZE / 1024))
 	rem=$((SIZE - (ksize * 1024)))
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
+	mptcp_lib_make_file $name 1024 $ksize
 	dd if=/dev/urandom conv=notrunc of="$name" bs=1 count=$rem 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0b7c48b54bd4..0ef395c9eecb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1155,8 +1155,7 @@ make_file()
 	local who=$2
 	local size=$3
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+	mptcp_lib_make_file $name 1024 $size
 
 	print_info "Test file (size $size KB) for $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 0f5e34c76bb4..7b0d03c40f89 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -344,3 +344,12 @@ mptcp_lib_get_counter() {
 
 	echo "${count}"
 }
+
+mptcp_lib_make_file() {
+	local name=$1
+	local bs=$2
+	local size=$3
+
+	dd if=/dev/urandom of="$name" bs=$bs count=$size 2> /dev/null
+	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 306d6c4ed5bb..9f11dfffe956 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -246,18 +246,6 @@ do_transfer()
 	return 1
 }
 
-make_file()
-{
-	local name=$1
-	local who=$2
-	local size=$3
-
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
-
-	echo "Created $name (size $size KB) containing data sent by $who"
-}
-
 do_mptcp_sockopt_tests()
 {
 	local lret=0
@@ -358,8 +346,10 @@ sout=$(mktemp)
 cin=$(mktemp)
 cout=$(mktemp)
 init
-make_file "$cin" "client" 1
-make_file "$sin" "server" 1
+mptcp_lib_make_file "$cin" 1024 1
+echo "Created $cin (size 1 KB) containing data sent by client"
+mptcp_lib_make_file "$sin" 1024 1
+echo "Created $sin (size 1 KB) containing data sent by server"
 trap cleanup EXIT
 
 run_tests $ns1 $ns2 10.0.1.1
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 98189b3f73dc..d5197d745171 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -150,22 +150,12 @@ print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 
-make_file()
-{
-	# Store a chunk of data in a file to transmit over an MPTCP connection
-	local name=$1
-	local ksize=1
-
-	dd if=/dev/urandom of="$name" bs=2 count=$ksize 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
-}
-
 make_connection()
 {
 	if [ -z "$file" ]; then
 		file=$(mktemp)
 	fi
-	make_file "$file" "client"
+	mptcp_lib_make_file "$file" 2 1
 
 	local is_v6=$1
 	local app_port=$app4_port
-- 
2.35.3

