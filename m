Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755E18E30
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IrJpfnZI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asnBRoNNQndpe2Wc5hMEGLbJtOLHk3z7z3/52TdOCmrrF1XKJ2L+BQvmhdwaRIYAA071nuJgDTuZhC1NdZMicKp8CFGDDfNA7SewxoViehGecRdb/9ISoEOP1qfeyQ4aicWad0VcEv90kmau5mc+Ks50lhn+fFhiZhPk3cQe3xIkFZL20L+mXVpvBpM8xEJnO6l9fn1xOeeOix8p3FljUUOd7RJRsBSPG8kO/1xo7tXUos0c45DyJkHqb0aFqCQATyZ8Prs/GuMp3q0hPquAI8hNoOwgb0idJlvEUXhe4LQT5JzsN6FZEpO03NqoUobvvcea5vA6BtjqbI5II6isnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pstlKgHJVkC1IFYS0OtawCtL3Nx6gmiEQybXiFmd+Co=;
 b=amNq7ejiKAljddidHBJNMyK5FCFQSMQncqROSI5jckyY9xPPfRpHXZGAD92CY5GhaqV09ITPZrMyH27sJlaHWVUHHtx91h9vho5Ieuv14CUwVwMfs6hN4AiMk6c0XgO9e6uRTVbrZZiXrNGcWd+MQ0ynTyB/672rJtNNh6s7Vn50lzW/1yEPsyk9YCH0NErtftDM+hGJfUMUfwgyqlTlAoNEE0ZsMbOIBd406s2XNfnK3ru9nZpNK7VE+WipUajKrCXyWRSo/ItKGoQcxLzh90ANupQVIaLAYfTti7FvDKtIkKTU+4XlDNaQoOSpiSpbUWGheIUW2s1a9Vb/mlJVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pstlKgHJVkC1IFYS0OtawCtL3Nx6gmiEQybXiFmd+Co=;
 b=IrJpfnZIuGclST7NFWRQvWM72P6S11a2NAFTohW/iO0wH3dWdH0QcnemYR1F4pk75wfVPPPelzBRehw/ltSYXbQGNtcF67hZ83p+lVAaj6NpRmBliPk9f9lmcqVDcBQpbGydRTzG4Vmy6bB1nLRzvDT3naVALJHKFQdeUA8OgXV1hfMU+zah1hhNLyeMK0po/2pyXMAmZlkBcHUcMxlnoGl164caLe12TDITXSXOpLyD+4HMH9Rj3BD67Y93G+GdY2oCAWUj17uvr4IX2GkYV4bbl7h+ps08/azclnJdyoH4D/51moi+cd+s823L8u8dzPYn7tUC9j7n5PqAs7rCUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 19/33] selftests: mptcp: rename test_cnt to TEST_COUNT
Date: Tue, 14 Nov 2023 18:21:49 +0800
Message-Id: <a57b18cebb8738ce81ce3b782775a4ca5fa3b29f.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa39772-afa5-4601-4f80-08dbe4fbcbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycWwTyurY6s2CpVhCwTBaTdNxy3QvetDJ9bNa8vpteScim3iKd1cqggsZmLtazb7IkZx4GAQjzCrOXWynafkVUxJDGK9aYXmRVdE0Fyf31yZkUj9E3qBUtAnKq9INNrN2Hz3S9e2WTbp5eScGPYxonmhFKVOfs6y28+MQPD7B96bW5lUCmCGOzK9oIJLz52pVTFV+E+N3GKYy35gFMxHXY++NgEwephYdKnv6HyYCBG5BDTpVanxDyfr5flB25yV1Uh2AfWmSdOikFNawiwl2eA6lQX69jTTjl8GuFjI9+/EzYiElihAOMsXi725w99TU3Fa5W9edpNISGAuLb+aqFfA0B0mFQl2ZCS9B2oYJcRYSYRjFfx5lWSHrRDFAWzyAlBeyNorbupf0yItZlBBmaS0oSR4DRF+4iEumwIzLPxKgauAG46qn9FAxtAN7Nr9Wmr6/UzcaEGpaaZvMId8qVr2Z9npZmW0XG1jzusAo4Deov0x4rK274kRthub06mXek03aUIwoKKMs7WP/AHqBrn2Wf8QMsKUDD4Zx6dCX/llH3tp18sjpWpRxLpdEZrC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNZLhCmy6rquP91cahiW8V8gqJ82nNjPsOfegfup/IQjquoEbpFg6KhZMCza?=
 =?us-ascii?Q?qhXOWfuo3f2eKk291DA6I+vKOdH9SK3hSCzwcf9eXCpNZLQEPRk/FMO9b/yS?=
 =?us-ascii?Q?IiAZZWrphQFUv3kl63QbSjKvAt/cCOJBpJPSuIM8I8x9yvAI1F8c7unI53wT?=
 =?us-ascii?Q?mg8bK/krdJAO2deX1UWP5J5A8RApjOQWkJI+XDZqltQGGYbSamikCMIZH16X?=
 =?us-ascii?Q?rzvmMXY0ciSBaKtyTbHNBSaZW+1jzrwluQNkbL8gzp2NbU7lOsrYG3Ioim8N?=
 =?us-ascii?Q?+gjw8dlZpWx+uuIrvpDB8hSvFM7wPgOGeu5M9ZzMFHZjXn1NdB4iGHiRB7bg?=
 =?us-ascii?Q?X99LXzrEEVgLqbcc/Tcl1siGbzhQsHVsyladj3tv99uN89esOuD2oT9gtIcu?=
 =?us-ascii?Q?g9VPpirnszC/SlY0oi8zert2bzOntVtpEh2mbzu4yBvRogUnt9J69U0nLtKF?=
 =?us-ascii?Q?QDLNtRc4JI0stIPzeTftSlqrXV6UNNQXm7vZC+X8ew98epyc4GLCdJvDnjWh?=
 =?us-ascii?Q?lkcvzUny3UbuuzaMHA7e2T98KahhwPRUU1lGA4fhqckXSP0bJF9GsoJoYpOM?=
 =?us-ascii?Q?oDi4X5OWu0wd4CWFmlY7EmL7p8KC+B1b33jKmYfdwAAW01Uw90nkhS/EHazp?=
 =?us-ascii?Q?xbFiQ0Clsm9Cmf849Wp/+uYB5gdxLJwkqHsxxa75vCDIfrk1kgKNeUl8POop?=
 =?us-ascii?Q?b24/JkgV6fvADAIYS1oh8pzXeH5ohE7nrGWD69HUb5cwsfD5G0io3FJzA7qR?=
 =?us-ascii?Q?K/YLm9lG7ETQV13QYY1OtbkZZT3Ih2hR0EcWS+lq5DxpLyha9j+1y+nlbT6S?=
 =?us-ascii?Q?gkJXfCHcDSONz0MwtVHmcxko1SdufEH3Pu0ii/RCYfdw0N7hEcSXrODhvO5s?=
 =?us-ascii?Q?CnGc7bTjKX8H4rqTNLddCLM8t3bzq26o3Q063iN7qDSvY50s12akSC9L11BS?=
 =?us-ascii?Q?ROjNnxQQ0/dFhV1hp5j7mrEn2hUGOhFC7ceQPYsoJngSULSS2uqGajewTshf?=
 =?us-ascii?Q?yf2k0SxjNhouoADSpwtTqtb8MZN4PK1cfvkm2jvfGiHTg675fEQdxevWuVVn?=
 =?us-ascii?Q?nzGt8Ve37wL+CsN5nG3mfS2SB9qkDTR5BF+8jUV76AQbvIGGAN0yUmdOkh01?=
 =?us-ascii?Q?MIY1D5PCrMqKhJQMlAzJPSPdln93KnlUqhbP7a1gQ2NKuonI7hLSHck9Qanc?=
 =?us-ascii?Q?GcimJUcCwfnwJOpy7dGbL98oQnits+Yu4fF6Ms698MfiOtmd/x20E3X/Dwgd?=
 =?us-ascii?Q?5YSbfOI/lGZNnrH+NXXDMPQVGRxCfR4TMnxrKGU7XIU0oepRYlBGzMaLamFm?=
 =?us-ascii?Q?hVxTTGt9CnoLrPMRhaTlW8VBEsEzg0WRjy4OhVoTM8G/nORpj/tvhC4H3LnH?=
 =?us-ascii?Q?fAEWmiKhazywboGVRJxk9Mwy2pcNAi8U/TOpODjX+GEcpgPId5y/FPx/hQWO?=
 =?us-ascii?Q?RTg/h1BXtKYc/sGmXrvHTSMac6C/h39nzhVxL9zDijqKRtwc2/IlRkoI16GD?=
 =?us-ascii?Q?gxQaUwozLAhDVAWbwQAbAn59uaNhtZTmUkmY7q+pJLHFCxp+U5qGFvTkLe0X?=
 =?us-ascii?Q?RmOuKipPo4GfodRUw9iYEVSVSnJj4RSQ55bAE9UCiZ5oH4qMmyEUr7N6oFlI?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa39772-afa5-4601-4f80-08dbe4fbcbd0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:51.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTl0ESJscSaPM4d7VIYWr8+t60VaL2oedd3coj588XtXKxP5M03Uzdb8zrhdMDyg8IxIXL7uidGC6blYRM6bFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

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

