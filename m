Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29B51035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QMz8AGm1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlrdPUqGnj11CNQp6tC/942P/aYs3Q7fnSsV8uGbQB9c6AXOOzkrH5f2OYjw99E+1C+5XFLO0YNOvwb87icaK8LazOqTNPHS7zdcpWPFhA9cQLOv3ZTZRx0NsPkwMX+9FP6Eqk/vnCAGH0sLGDTgqEaHkAgA1IjlI0vg+CKIlOmR2ScVtClNhHEBo/EmEVrE6lHFP1PVJmnEsufDZslVzptF5CnpihVcS1IpuuQDwLrWbblPMwmg/HZiynilcr/8co7aAo/bpki2dVm8qwaXsy3kPZ+gSF8K6Ya2uWdGrrkxYga+lze1dR7EHcyZiVz+OQ6ZdMyLSkav0ltFpZvOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pstlKgHJVkC1IFYS0OtawCtL3Nx6gmiEQybXiFmd+Co=;
 b=WWoSlIsXAKwvguWS/nZOc052Io7JDeV+xV/quWlQaqElgECMZ5PeWZiQ650qt+myQucWR4TSKfvHuBjkmn6cPhI7dBTy5kKBeIbhk+5lwej1DSHDKBK9RRwcXARJD/iA25eSLiJV8KW+dFeCfkk1sRT/b9xlnHBdcPh9pOv3U0pQfqkzHsl3JNHCv/dPSXGznhgNtxOKLryZiAhxqtjeZ4LSgGNFcNaTVFyFFneJkHLD96Mo3PbKICwhIamEcG+Av1nnM+WRvP7UEF+0UJcBOuL1GKm2LostpTHysZ50dXazxWRWOyqHMU6ObafiKbFA0Cg9o5+rewPPpdz5IMzkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pstlKgHJVkC1IFYS0OtawCtL3Nx6gmiEQybXiFmd+Co=;
 b=QMz8AGm1uV9HT+u716Cweh0shSu3ciUttG7S/oHmuMFQYK8G2iKN9NvmTYhyH4qwhdRtVKfPTi03qyBUk+Gx4fwc+yV6FP8RO+6a/ii2ayWfdfFGxmccfw9sLQLv+/c7L+DJbQTdZOmVg1J6QvRtH+E6jLMYB215oO6Dc5GxkYPexx1YRdHPSh+rWck1w4u8beFZSyyZLaIUn5b7OEJfB5Dh9GFgeYMj0lLYB+a5ZKIk59l/vHCA3gyFAPWeA/ZrzlovSEDtuxeOZgvwnCe52XXMl4jb5psGlFq/dpasmQVF6NqYzsx5q2+ZV1l9aHHj1pvTCkNSZSgoF2zg9qjjyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 19/33] selftests: mptcp: rename test_cnt to TEST_COUNT
Date: Wed, 22 Nov 2023 19:31:07 +0800
Message-Id: <8146c8161134d4fea96bebdcfbc6cf96e22b32da.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: bc000a12-dc20-47cc-f731-08dbeb4eda82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y6/OaU31qSR1fZ6W2tmrAHWL9vf3qg/G2zOvAeajIVqP4+PulqSVDIN3QSv+aWpScie3FFf3uMQjcb262S4Muw5fn5YHy5/AGJLNnciRm9IsGKVkSLrG6ontWwixIetZJ1vIKcBlwUAaKYMWNqGUCB8VzsNOVk3Fjf0zda2+5O8uY3Xp5AH1VYdeMwU8G36k7Eqy/mNgkyJS5aOURUARlML7cvNaqgnZ2d8yWmQdGHyS+U1yRgBZVbflEmLu77bCDhw8wqMUHuoE6gmHy6uIJX7FqIaUtGtgobKyPAfciJ2wgdr1oZE50Ygef5N18WIFI+IeZHuaKwww9vEXWIOcH7/bIy6yVPnV6KlneiX109BJAfDkNunEyNigVHRIyyq1F0H/81A5ijmfcK0VvNY63ANham09YfHgU7MCG9qKMx0Js7+ssWpCbyQq5GWmovkNfZ+ubEI3ZFO6hnhodJNFjlT2Up2VqrUWxExSbdnb3U76grqlJxkUHkjwoGcVB5qhIHwx3DElyFaSDDuk7duKcNxryiLwkyHpeO5hl+RTFy8iCjfAEOADGjlxd4FL9/54lBvoJxiMuxweyWmH9H4Oq7WZfQYfMzzj9nng96eNFMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xfc9aI7E+A+osajVzq39gFFdVYhdGGQPs5w4U3t9XH6wHMEboKUnyUzygqh4?=
 =?us-ascii?Q?9GL1FCwBG8OtHpl+GC1Wjpqzxra7ImA2Mawu9jqJ7mrOd1VTo/0cwKgnRd3F?=
 =?us-ascii?Q?BNHtU9x0AuhVF/aJTd8wXlTKq49xUW1NcV2l5LQapKi+IAfOHps+t5ooblFc?=
 =?us-ascii?Q?jUWqJPRzwoKgFeWwVMgquMiGt+OMH3MxE10Y6zzJ0jWQl+pTYuineneGhagG?=
 =?us-ascii?Q?O6Co2pxSB+V5kBKVm0i43vUVY6hgxq8s5oUgTMKpZPU//bL5UPaoonZh3xwY?=
 =?us-ascii?Q?2Xg6GVqkFz8pADwkFmBC088Tq+WLmZXLMf8BFEs86/9z3+QLFOJHhcDtkW+t?=
 =?us-ascii?Q?JvCRU0GNF3n/imuM5f09g3oVmnHU9WIZcCQ0fYx41Yh59MmnQ4CTRuUXUnuG?=
 =?us-ascii?Q?sCgTPy+ljjSn90xWfCEAGNV5f0FP7hhyTJ8Ii2/HMusMncvzUO5pw4/Q/iT8?=
 =?us-ascii?Q?SVWKwbqbLEwt76oXcTNxwqMyYz0ePvz8N+bwS00I2DOUaRB05Wkvr39Dfjtq?=
 =?us-ascii?Q?NzOsvUT6Rpi1B3B18oSyKtTtkznRaiuezbrKy3RKVCj3fy6NQnxThIPR4B6A?=
 =?us-ascii?Q?uKWAUOBlY7KrBZW7h9yRTdL/7BWKHJzVZUnHT441M+FzalTMryhAyijVYQx6?=
 =?us-ascii?Q?hTOt0gC6ck+eH/UrUdn+rxL24pEbhtG9eLw3XLYjpfObU5BfaaCbaSDv5ITb?=
 =?us-ascii?Q?l9rYWFUirtJNKph/76xdLO91uFJcIBzdpLoUxy32BxuWuzCJtrk9bn9Od1p1?=
 =?us-ascii?Q?W0TosozDsPRu36PMAi93Hf9tg5WeMHepRTFKhGG8H+zVShzFJ1UqkEHB8ebq?=
 =?us-ascii?Q?7/urWfqxIKQ/WMjU8DR3RTiRqejSm9ZeJk+J++oEWeLJEZxHcHSkxmvrspvm?=
 =?us-ascii?Q?jd0Ci5dCq7Ev0Z3ced13vfXJeP+QU9UBTF35MQcQ/VleZm8T7GVo41uvG7m0?=
 =?us-ascii?Q?I2CKCvCREzR/V/66INRPqIyVbR6IfiqdQXj5Tvuy9BRT0L9ZNaIabvzLyxcC?=
 =?us-ascii?Q?8BgtGtxc9BlX1jm2iGT2wQ62euN9qZLFtMFf7eSwMhUkGH6cucQRWxhRYxX6?=
 =?us-ascii?Q?aS8gdCzw4F0EogBXk4rfZhHltrnhJ22bqRspoh1BBVxmzZ6lRDUqLXMPVW8G?=
 =?us-ascii?Q?/SzeI3NhoWTWUiVvsAzTU5BmhsEhXey3Ug4joBulB/2i/h8ofoeU9B2z0ZTB?=
 =?us-ascii?Q?OgNHP0Zr7OhUVf5q6RyCdrW0O+QULu8hax8X+WDCJq2TqhoIGMjksulG/0J1?=
 =?us-ascii?Q?qTSvFrSpp/4rSZnrJDAhOLBwIZ6gaBB6vI0TX6Iv15fmPEpq7kY44Yr90m6d?=
 =?us-ascii?Q?CbH4HiEKaHVasWw5f/NNaQxYJ4GJJSW+0yCQgEA1HJF9/0GAIVICpV2k8jPL?=
 =?us-ascii?Q?A5CXijrBa3pch1QBLNTW5QMf9AP2gsZkWtboQc1h0uueVwHo3LenwZ6/UV1Q?=
 =?us-ascii?Q?wtmBnOGrSjQYijBuziOgIyF0veG0w8CQv29OTCTMTUqrQTG/SyqCEKaFfvGD?=
 =?us-ascii?Q?FJ1pKhJIsrUQH/WtxFylJVflAQlDududSxOdY+y1Aglg+zSpvpHHUeFUXK/M?=
 =?us-ascii?Q?5wX7bZI61xvTM5HQonZoRT7or26nKSipKBN7sF/gXzb6xe/IulYLvYiaWdne?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc000a12-dc20-47cc-f731-08dbeb4eda82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:31.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g0y0rEo8vCaD23lME6T5E7whWhO7Pg1SiERnBN04Lif45eiaoMPhxlMa8P8e1ytHIYtgrqdSH6nu7MY9Wn+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Most scripts use variable TEST_COUNT, but test_cnt are used in diag.sh
and simult_flows.sh. To maintain consistency with other scripts, this
patch renames them as TEST_COUNT:

    test_cnt  -> TEST_COUNT  in diag.sh, simult_flows.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh         | 12 ++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7cf1f602bf48..541a9d2d128c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-test_cnt=1
+TEST_COUNT=1
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
@@ -67,13 +67,13 @@ __chk_nr()
 		else
 			mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=$TEST_COUNT
 		fi
 	else
 		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 __chk_msk_nr()
@@ -113,16 +113,16 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
 		mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	else
 		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 86f021bccae0..6a4568d8f596 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+TEST_COUNT=1
 bail=0
 slack=50
 
@@ -115,8 +115,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+$TEST_COUNT))
+	TEST_COUNT=$((TEST_COUNT+1))
 
 	:> "$cout"
 	:> "$sout"
-- 
2.35.3

