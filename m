Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFC5467C
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5gXGFbFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq/Y6lzhxKspGLu7rf/uLOvq2CT47hlkRztWQ94klXiswkk+w5oOlUcgrzvo6KD7P+kggtwUusakIeAtuqAmER4yWZ5YGi5eM49qYK/O0aZR7HWmxM++pkpvGDuVNZ/LLMdLkTKAcJ/PFSO/erYjan4WD4Yc+J0jJwoIVptBtNMZr3fYOJkFJBhRlj8CaNGpMg/Cu1S39opraseipmvUboDD/d3I00O3MXZEcxrTTX94TNNVDmgPeMwcV9hnDQcl4gREMPlx5QNJcJZwgnsCQR0hNP3jWuL+ZEEZ208yrX7QgRnWTmzFo7YmvBFurlp1B5hdGUCJO6xjmYjQdwP82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylyB2i6xIwqVSug7eHgYL6mnnTQJMkmRI7REsg7punY=;
 b=jTj5/Tv5BewYI4WB4QKKnVxy2WviHLt2WadlYQzdRfaAoPpFT7PE4KabkFMmNpODntr9OIhnIYpKW+xnYLMP6dvUqver687etTfpJsqY1vWwRCk4jh5LxyT2O9lJl7BgP5IsKfMG+mpUl6U44M6sFTnAnRhT48UuEYeJZCXE8CcobJ0k0VTlzzI/tJftzhmHKnvH1Df7esxhuwbIvA38goHUmnBMUFCXQ//PErDapnZZAuY/PvWWUNHXLf/c3HEfNeDqLft7MTAhQcpD8E7zxSkLkwv3fzva9zclEQzBnpecN3t85ecfqtn9FYT5fkWA3gPKZgQPIZNdN6qWu/sEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylyB2i6xIwqVSug7eHgYL6mnnTQJMkmRI7REsg7punY=;
 b=5gXGFbFa4Hsnw5HN8T5q2UETkQTqSZiE08mKsQhHaWazFpDYlyoLa1eu51C9TZKdurBd4sYL7nA7cB8iK9jine6nravD0g5WJrYXC8H/0TvUKqrLwCmR3j8gOsaxxG/tuxicSXicvGM+teEksWHfR5cw8I6IRGkwJ050D6sWk7JYwABeBqfEbbNnGf3i3jTucKKPdjPvHTxbCGte5nenlrqLN9mCpdeFZTb9Wt6dcS0qEOwgb+8GE6F9GnTKyAS0kY85xU16kD1UkwNpyAzYDCY5mvtweoYW/Nx2JPg0IRCSoSPBqZx9WL2WbxZWfSHIAlGM5Gdu5VGrjlBuyu7+KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 20/33] selftests: mptcp: diag: print out test counter
Date: Wed, 22 Nov 2023 19:31:08 +0800
Message-Id: <6fe6c32dd9c4d01ac2fb39d4ce077964d693c555.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ff43fb-8cf6-4658-2f08-08dbeb4edde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V06mbFknyCX/CB5M6L+wa/st6jknp0OUUQ3PVgA1leuSF86eoT6wQzMzIbVOvshXwkPSUqGXapknWIOxDKBLAdwo/FXn/Cvywev65haG2XsLnbz2fEHliSivJGp4JKi6gGmbTzHI7LxwRbsOwR4hpj8zFayFFAbUEVmGGhVrXu6ilt+aPa+d+F4GB6rY5f9aX4mnk3kJF+N0gmC7HfC5w1/hhGslRS7OY78jzvqCS3+lx1TRRCEVcwuB2Kq0TovaA/9ikDtqhDZhvpn+E6PyBbC24hr3Ai1qt7bkjQMBMvuuqJTYPc6jENY0PyGlFxR7lJNHJSu7+CEtNlgJz2xw0P9b/mdFA60EWW7FPHogI3+OPC0C+vo1yGhkZuKlGOfV16C0Pi8SEtwqikK3OgwlI9Ytt+EsX8gmWsIovXrrVJb7pp1IxK6HYnY6jR4u4tp5CY0Kt969zq1kG2mPteQj3l1+07lGwa0ntmSTzDpmEtn2oa8pimYDrF7aQfv8A2AITeadEz+Ivo4LqCU/YIMkTIkwZEf4T4FhQ1ZniVYZYyHj17I3w5FvsBiaOA95OQQdcOOZZ92i37hsWKkTjiGEeGf0DxLiqZ/QJLK77AS4UDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNAHFp8RyqYS1SyxUvlm/DkN2d9Ey4gsLwCxsg0NiUlBz+13nf2BV65/9uF2?=
 =?us-ascii?Q?yChou9acaZx64LH5o6UIkTvkIyTPSuKUnUOFDuTeqekHPoyg/ZFNCKMw5RGZ?=
 =?us-ascii?Q?H+Cb5rlYR38L1hHBTBFYC7+sIYj2Ph9ae9YydYE1ktvKSe6r5f/Vwwdd7o8m?=
 =?us-ascii?Q?NyIiZhoyDMLOtJLMDfHAndqZKHb0vkKW1pJhXpSKezVEV7+b9vgmdgR8AXcJ?=
 =?us-ascii?Q?BYmgmek+WvCH9/RZ4hpBhcNIUMhW/xD+SBFQc1yHDbWFBpYuf75cQqam7mS/?=
 =?us-ascii?Q?+P7tX4dpOgvYcxkOM3EDv/Qzj/0uRbJWuNjLgdHEKYJAd/r4w17lSOU/BvBq?=
 =?us-ascii?Q?d84EgqJHzOr6zsJFVh5Sg/nmtme2SabdL59zrtPjcERx0bWn4ak0BkyOKJwT?=
 =?us-ascii?Q?9XLx2zkvXah6gYJ80xzfJPSVa9nfI5jCwgmMboEgz0LRv1WFvRceGYD07/cw?=
 =?us-ascii?Q?zDsmOryH9ZyVYhK96FWAt9yh07wVOrePYJSv6rN4qU7JFQmoLu2btwwP3uV8?=
 =?us-ascii?Q?VZ6vzpmMRfsUOC2NMgASQPBHILGuuEZk9L4EToGqNHKfDlCGt0U2o4RTo5tG?=
 =?us-ascii?Q?ldJislqdWLG1D8WejE0Y5PC6ZogiCqy5n7tyg4Er7fqwbHspRmzGcU3KQdGN?=
 =?us-ascii?Q?ZBeS8xVRl51Bm9EPp/JBg1CJ942ESBKUHx5Avg4SypcDArQ2WY2BIhNJY+eT?=
 =?us-ascii?Q?sIDHb4XE0iM+qKRs2lI7oS7NZWDc4t4xF4q7jjswjaFB4kPMFHzxENv/Nrjk?=
 =?us-ascii?Q?eDjXqp4IVe8M3WLEexsr8x7NOx+ahwcVPKmeTvqCWFNXJojGz1gRyZvsOluv?=
 =?us-ascii?Q?BNdxbeIMut6S3+aOYWIl5cgmQJ7GaK3Abx+A2ur+5jfuOU+0Wgv6F2EM10XL?=
 =?us-ascii?Q?01AeLsFX0O8XwaAPLU8AQFpJD4NDpjuXR21aDY5ob4aij6NGHsFeKVRqb/fw?=
 =?us-ascii?Q?Y1ylTyVazsmVcuZgYlTZvfC3BIyJVa7fD7etOCsPcnD1fQEIYBPZGIBIVhBa?=
 =?us-ascii?Q?6DEN5i9pRW9JIUOe5AWYnBCEyzbubL47HCZgZr4Uxm12hlczRMLBPbvPu8vh?=
 =?us-ascii?Q?Sx8DR5m/b6MVLOU+PeZKXyD6e2YjhH/H6ij88iIPWOEJhGleKE77on3/ERb5?=
 =?us-ascii?Q?bQJ8ykssD/1M0f05IaVhF5C8TFBj6kpNekJzO5lwOzhlXXUkT73P6u10m/1j?=
 =?us-ascii?Q?FW9eO/uyr45ebLdEIpdBfVdLWOt6RpuJxq86blN5FhdEF794vlFRdD5T51wJ?=
 =?us-ascii?Q?qh0CGOiwh9mIpPk7qBuKQfZ29mVv+0QLlf6R2ruzciSHWfSUyruTyo6N4fpg?=
 =?us-ascii?Q?NeZeBJI6zkVHXqffS1aoARle5fo23MbADxVdP9QN1Mru30AcBeJDu0d6StQm?=
 =?us-ascii?Q?vFyJobUDqFNHmRo+goucLR4iAhsPcQeoCsQU2Y9ZELpu6TZEmClfUyH5V5jM?=
 =?us-ascii?Q?tKSOkgTPcEsprdBTl4UYOtE+pvKvqSGTDf9uQ3rESMrmEIj0yaAkbrqvsjGd?=
 =?us-ascii?Q?MHJXpS7/hGIJExQPUtPOWNVEB9zMFFLB9rJBWfPI7sxCBzxXg7g4PDqXlykG?=
 =?us-ascii?Q?42nZPJtHMf8jrSZcN+m3pAQ+lslqrPMAYKMFnLH3dcKG3IErfZMLLCFrGxuW?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ff43fb-8cf6-4658-2f08-08dbeb4edde9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:36.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0cW94APkhb3+G2qKaoLRuVSpLrP9sieN1MgmKFWhh6pbSNd8KcXinTXBeDuTHuGU3HT/5gNYKOKExcFlj1iJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

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

