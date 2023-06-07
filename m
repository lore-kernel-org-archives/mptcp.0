Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736D7488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQsb6rUpex9K0JsjRT1dsc5FgMlq/x1V4LvBGcP7fFyqoCuGYgYMI3hwcHwbQ3obXWyfLfp81GIksArItuBwyF+sfMPYVtVIQRVxVThCiWufkF2qRvFZqpwXDXT9he+NuZQVwjBqymLnv07qSFFCV++l8Bc+l7Hr5EPC3uBOLJ+ORkyxVsJy/flvyLy8bgE/MeYA4kYa8pkgi55U8Q/r5GmtqQ9OzOsdtQn3qeybKviouDSx5LHzs3xi0wwv4FP3vAQLXKUqhRcdk4NnMEUb8yWCgF7Rswi3NdPjSrGZESfwLoNaplLtSBhe/C8ZsuYWXYEcTW2u9onF9qMvJbhmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61g4vKyr1XwQqzoAwEjsFfz8ajxsV8MrvwUk3ssW9As=;
 b=V8TMqQRAX13Rkh/TYWDDEHgY/zt2hrnbDnNFwVQmxArqlTrgSRjzdWRC2GAE07Vbba7bAuzEKc8TczrSrZH+3jT1xnm2G3oqg0A8+Iv+4tpSVYDOKYrF0Way8YkgDTtyiCLbPavalHDoHQtPvU5MNsMMDWE45gckFgIl8FXZZPLjfyKkdHMCZLShN+Xfj/uCQ9YBlTe8YgIkliwOegcXt/fJKQHfGJmLpoE9tmWAo91Cn60Nd8hj6PjS7FlA/QiMpjydlCdoUckL/HMyRp67C0Gt9SKMV0JWk/Js07iCIr4BSsWoZhcC5mkmI8H5CgDAu1kcRmeYclGygPFe4GxIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61g4vKyr1XwQqzoAwEjsFfz8ajxsV8MrvwUk3ssW9As=;
 b=I8ooKp0ab3j0RI2kVyhcme8ZzgW2PsL3xQCO6bOWF4pyEfBsoBKn86mocLmaEYiNbwOPlaMiuAcdP8ZoD11GabiFan2flREtfB0fXFFhTPv9OBxlUEF0jlzGcrnrY+M5aESt2RTBQk2L8D8jcaIY9E0MuCkXbWoVCa5xFEFmX0gcCKf8fRuVqP5hxDmHA2S2rj0dQBv5Phh9ZQ1EtqEEGvhDJZzy020nDko01bGx0jwX7a/1GKIY7EPm3H8SxSpRdnnyD1XX1zC9S0LAB4dW9bsGXVDLWSBN48+vYDrZMnlUq6WOIotyVVe75sQSztOJ0JejOiivmUbLPz08LJEUDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:46:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:46:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 7/7] selftests: mptcp: set endpoint out of transfer
Date: Wed,  7 Jun 2023 19:44:26 +0800
Message-Id: <2673d5e34566da219d6c5d31ac385ea778e32040.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 969c5f9c-342c-4d8c-8ea9-08db674ccb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k9TbfPnidxGDdQDQoGgThqQXa6M/UAZELXClua0byqkpbtblSboEr97q4NN9PKRjJ3TH5aTTQGzVW5dSBD43A5rZFUzMS00Ze0/c+axDLrV4qKDpTtoRYRDmCmqC0ot90ndnNeLTxjuPiIouZag20pvv+iFtpMZP4x8o1yfAVY5qerhXraBRNKEQ6aVzfQeTS2Q6va/h5Byo1Kof/R5WOJSLSkii3bGugiCmDfuzlgTBfr9m3M/mtVQvmR+ru6it3R5hu0VVoPYwCRx5VmN5Vvnm2MDIXtKVaRPNumsuNvzoEk9BzrCtZ2zQDPpSD+VfzH6aexRxEETMZd2/fwSwG52Q5JNjIozxW4K66pMg16wCzPP0vGCWzVgIAyL8ohJGPtdR7L/90Xd69zxA+k/tzAG6Ba9/3GaJcePKxKTvsT8wpt0VDakUvVIKZJhX7M7hV4mH373y1DPPopCHyNEmO5LMjuHp26LFB4tT/N34k575JIdGinjOTIFJIkZI9C0DTHRUuQayAQaht8cETsBee/keLhmmJUUjac2Al+gRqNjOvJv5REGXVZntRsawVmsD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(30864003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NTWouJOeevKKsf/qp/Iu08TJz4UtxMGMxcaOVJrp6aJ4gOmZHaCIzJfMFRMg?=
 =?us-ascii?Q?EbeWedIW7dfxjmkM4/pYmdbgqL1Wg5Fth8UrCUL6zJb1FBE6boylO13Cyx4i?=
 =?us-ascii?Q?0Mpbs2kUtV55Mih+o8coNDmUy2YrZwwzQfHlVoLKFjZtDnA3kU8VRI0TH38e?=
 =?us-ascii?Q?fiwQlVTi+3p/BHpDX9S1DfkvAzszeGmHFhqqy68bnuiXWsvOQ6K6QKZxO3NX?=
 =?us-ascii?Q?u0Q5jFRkN7Vd6C/J6tRqHqV5MhLVdivbfHmQIbANReAEoAetKrqSB+AKEBK6?=
 =?us-ascii?Q?XxCMq6novGJ35GqmMaZA2lIk7s/Co+X+kVXHZ6wsmoRgVWZ5ilLqslttTHXJ?=
 =?us-ascii?Q?Yx/238NekPGxgW/8+fjvN1rorn8m+RGCaui5GXN3Luq9nLLRc9gf7o65RUdQ?=
 =?us-ascii?Q?hsE8dy/jBmwD2pOxvsjemjozEW+JUBbZmkbLvXXm5zRhPvxNMKM5yUpWQPnX?=
 =?us-ascii?Q?Z+95CHZrYEjPSLDXJOA5ERiuOJRIO5ymioIBtgaj/x+YJO5gaC1raeDOGT6c?=
 =?us-ascii?Q?PdnTRNVWCwTluE1+iambwpWWysSoIkwyc9q26llO+H3Bo0JcZMZVKNSl0QZ6?=
 =?us-ascii?Q?N5kHWFuekCQjRwkqIjUVucfbqFIzpoVsr1yxw37RkJLE10274QMJb9qZitmR?=
 =?us-ascii?Q?mcuKUkUxPYcQBdzfJBYoIuzZnEvaLJSCRvAj05600usO6pHh0y0WdDEoqr70?=
 =?us-ascii?Q?L+ZUt/6NIUBNktCQx6G0ewG8+hcsh+pA0wvfVBSYKroRzIodST07mgAQocxo?=
 =?us-ascii?Q?34YmplnnmQD5omJQK124f4RQLLdtqWuv71FfTRwRvg8k/SnKhYJ0pplLhU+k?=
 =?us-ascii?Q?1N4Nx/v6WTjywce8FuiYISbC9w61MTqdIv1pb7tdlqAFmmC05nUsI3lK2q1N?=
 =?us-ascii?Q?NXHr/kL8Rc/a5CF9EReM33vMI2qkLNycpOa9ewKNUrZSIKDOOYotSseEczzw?=
 =?us-ascii?Q?IWpcQt5oj1E6ErKw/t1q3icKun3xgtEaJ8cenCLlzzWRbD8Upn192QjERpOZ?=
 =?us-ascii?Q?pdW4VbZjuQnjROVNYr2Ylq6vNpuVJve2h1Rab/sdjNtVV4mRGeh88zSRYoDc?=
 =?us-ascii?Q?y2wGTEb6if6RHUchkfWji1gODG/3YiLJZur8o2GPJQrjebXpLMNjcyEIACCJ?=
 =?us-ascii?Q?5WiWUULcgd+JDiomXz2n8hdgRhLx0tTwY9b23fM2jaInvVTCYj1jaZ8xCrJc?=
 =?us-ascii?Q?myRG1oagcfbyQ1AMa3p2l9wTXhzQlNLjCTeeZc1ItYi55v7n/CnPC8tnIUPT?=
 =?us-ascii?Q?cN+IGyk0LYiIkuXfAkNbQVac7ROcxJEXIfqBBMqwEXn1OOdV7FhexkQ7Ug9/?=
 =?us-ascii?Q?XaaGvX5rEZ+KN4CT/4yW5PXZygkXP/RAd2OYmpcleWa1cJU+8/FHGcMOA3f6?=
 =?us-ascii?Q?cu3CVHrmFzcmLTiNJ+VEGWbH8MR6bJfSPNsYYGoohsdS3IK7nlbEIj/XNj5N?=
 =?us-ascii?Q?N5GuiXuJBcstCqvSElx7dx2MlE0S8GW4Fgp//sj6oliJzZiXd5/6dljUVbu+?=
 =?us-ascii?Q?S0KEHBURbHAcxfPUDxfhLRvwD+alSeC1ckcOcw4RMzsOdYmwGZXL5as3xEnq?=
 =?us-ascii?Q?lhE6iqOBe9HPMFPMFKPUgiv2F/G6inOBai+MB7nD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969c5f9c-342c-4d8c-8ea9-08db674ccb13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:46:12.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoU3agCzCdPnPb34l9DCBTFIrRfsZSnoleG/FXg/g/HDU778LdxKDZldGucQuKoiTpPY8UMETlLaIxiGks2B/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

This patch moves endpoint settings out of do_transfer() into a new
function pm_nl_set_endpoint(), then addr_nr_ns1 and addr_nr_ns2
arguments can be removed for do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 164 ++++++++++--------
 1 file changed, 89 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cd6869a3783d..595f9f0230ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -804,8 +804,8 @@ pm_nl_set_endpoint()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local addr_nr_ns1="$4"
-	local addr_nr_ns2="$5"
-	local sflags="${6}"
+	local addr_nr_ns2="${5:-0}"
+	local sflags="${6:-""}"
 
 	local flags="subflow"
 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
@@ -961,10 +961,8 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
+	local speed="$7"
+	local sflags="${8}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -1069,8 +1067,6 @@ do_transfer()
 	fi
 	local cpid=$!
 
-	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr $addr_nr_ns1 $addr_nr_ns2 $sflags
-
 	wait $cpid
 	local retc=$?
 	wait $spid
@@ -1140,10 +1136,8 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
+	local speed="${5:-fast}"
+	local sflags="${6:-""}"
 
 	local size
 
@@ -1188,7 +1182,27 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${test_linkfail} ${speed} ${sflags}
+}
+
+run_tests_bg()
+{
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local connect_addr="$3"
+	local test_linkfail="${4:-0}"
+	local addr_nr_ns1="${5:-0}"
+	local addr_nr_ns2="${6:-0}"
+	local speed="${7:-fast}"
+	local sflags="${8:-""}"
+	local wait_join="${9:-0}"
+
+	run_tests $listener_ns $connector_ns $connect_addr $test_linkfail $speed &
+	local tests_pid=$!
+	[ $wait_join -eq 1 ] && wait_mpj $connector_ns
+	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr $addr_nr_ns1 \
+		$addr_nr_ns2 $sflags
+	wait $tests_pid
 }
 
 dump_stats()
@@ -1982,7 +1996,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1993,7 +2007,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2004,7 +2018,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2016,7 +2030,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2115,7 +2129,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2223,7 +2237,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2234,7 +2248,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2245,7 +2259,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2256,7 +2270,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2269,7 +2283,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2281,7 +2295,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -2 speed_10 "" 1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2291,7 +2305,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2303,7 +2317,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2316,7 +2330,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2329,7 +2343,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -3 0 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2342,7 +2356,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -3 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2355,7 +2369,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2368,7 +2382,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2386,7 +2400,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2399,7 +2413,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2410,7 +2424,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -9 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2420,7 +2434,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -9 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2433,7 +2447,7 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2441,7 +2455,7 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2450,7 +2464,7 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2458,7 +2472,7 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2466,7 +2480,7 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2479,14 +2493,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2496,7 +2510,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2506,7 +2520,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 -1 0 speed_10 "" 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2518,7 +2532,7 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 -1 -1 speed_10 "" 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2619,7 +2633,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2629,7 +2643,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2640,7 +2654,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2652,7 +2666,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 speed_10 "" 1
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2665,7 +2679,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 nobackup 1
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2676,7 +2690,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 backup 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2688,7 +2702,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 backup 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2697,7 +2711,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2706,7 +2720,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2714,7 +2728,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2723,7 +2737,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2812,7 +2826,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2828,7 +2842,7 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -1 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2841,7 +2855,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -2 speed_10 "" 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3043,7 +3057,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 1 0 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3055,7 +3069,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3067,7 +3081,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3080,7 +3094,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3091,7 +3105,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3102,7 +3116,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3113,7 +3127,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3125,7 +3139,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 nobackup,nofullmesh 1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3135,14 +3149,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3290,7 +3304,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3303,7 +3317,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3313,7 +3327,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3335,7 +3349,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3360,7 +3374,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3383,7 +3397,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

