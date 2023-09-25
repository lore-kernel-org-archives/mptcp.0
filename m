Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96B125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3lQjSOTgfexNoUMqA0MvNTZ0p5iTiIL5EiZcTJ3TLmKdTkzWLxPjyHPZovJM82WjZHTpdm9OPgzrf35SfC1HRI7ZHlUz8BmtoXWlFL7pm9P665bhi/y7/kXFmz+CkwCvnmKdTGfUPZqQdy+jEdYBVxc0diDnxLOUgk5O58RkOFXZdR+fseOaXUmUfeFb1Bwk45cBUpFZRIFIDTMGEHHyfnT+F8KuoqSfd/3XbiWpN0UVLKk2D1+pI9w0m2dzDStzwkr5cpQFUfVeZOSDiJfaZkOAYawAxVsHQP2mIJYamHEkcTl/Bo0Q6oquCBSTIni1XjpozLVWn00jbIqZP3onQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGhZiuYYIVVlw+Aybh0lCrW7ROExttZPli2QbbzK4hI=;
 b=eNru2QX9/NGza1yG7t9TMm5PQAzRjXCR4TVIKD/gLuDkj70g1qnq5TcWHWQbuFTbp6knBwuLXz720tukhRJ3cFvvmUgT30LmMLVQdVBzIJzEDD6QjEz0weQRLAm+Q38A4vG9dfukkmsZh2yUssnMsYg9CzAlpr3EGNrj2CUplAXB6KSPdpvlbUFI3yUfoD1pYJZW+reEHEoeWnSj9cf162iWxUZho+lHPe+e+3zAuA6/0vzn4evlgiLSLreqF974X4AAzC1nT5Mth5BhVmXokuORTtF3D0H20Oqn0e2+CNSRJLlXK2t+rJ4gejpFWCzBFlpvW2/280abqLXYP/0YuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGhZiuYYIVVlw+Aybh0lCrW7ROExttZPli2QbbzK4hI=;
 b=bwg41+ExCmmCIE6IeYGq6eFeUDRmJCrDZtZ8MHYgBsFyWwDqTUCFYJaQdQkDYrvH16RpOD1hq8+gRbA8K4CEz5gkThJJq+uxH+5QOfp/yGBQd67g+KVdWK+UDcQ/R6k5daYbqD8p4T4wQT0Yo9zOa872P366hEiibMNIvA9fTKy4WPs5GGBthQIf/84+fetCoqS1fanqCMve4JCq9wrunUgs+WXWLt0BuSz1mq8jEaWDb2YVn8S3XqurCdd5NuAqpamum34UpBkydi6KHKO9rsx/YgOgWo1Qv5UCGu9lyJtlcrRGQ8MdiWNwQxYLetvkkGMLpJtOTCa6HQ3WGWxKYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:44:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 26/29] selftests: mptcp: add mptcp_lib_get_counter
Date: Mon, 25 Sep 2023 16:42:05 +0800
Message-Id: <b9425bc5bbc9a0c66a0c5f026b176d5ebe0d4d53.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: c67d28cc-c815-430c-ebf1-08dbbda3ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yI1OD9PgCs/7npdh149GJrnusSCM/l1mer1+qFM3GFLNhce8twseyqbLl2+2mCBQQkk8gqscaLjhs2sp9LdKgoBAG4YM0NA/v74doznDRW835xqqLW1Vu7VA/cSWK50P4E22uAal0at2kkA1jsOVHkpb9TWEa4ZaFdiXaZWMsCQlMNMAcdS9FqUPnUi5bWUFB61UxfuJjOfo+c3uMGPNO3sgRXhNDtXY2t4u/D/fm3Iq0CUzc+1h1Va5RvdBP5OztJyfnfJ3ZcflBYT5UgoN2AIauiLZ94VsGc6afBXwn6pCtLJIrwpOU2bQWeLxCRvgHHciPiHeI9ILIR27xlNF3aS+F/B82QorXQCSRz9Odx5W+6OHQJ9WZ0eal+tBf5OjDhoocsiLLNxM41YF5+vTaelcvSWMfhU4IPpBs4VAklW9adPCWM/8nus5IG+tw/fqOCZt5rHMHstBSyd00CBSmU33cNrQtwyT0+mA8MxAxKgnKPw8EDSnSk/2Um0R1seQq5UUH509l3iv/ssAKfI/QQSyZyxg0hfD0ZQMdMiv++SV20JbAvet+umc0xiue7J6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(30864003)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJiHEkO/iXWasBacr5Ie17SjkDrOIRNOlP4JhigSp7i+PgSZvjGpEikCVYjC?=
 =?us-ascii?Q?CHCCpE+1ekwfINHIe8Zx8O5z5ZH56GQ0nHatWkMa7nsiCP+02+A/Qg78ixcv?=
 =?us-ascii?Q?7U9ygNZ8t9HU3yw/paBowouhi1Lv/W5zqqH9eJNFIrlAIPHVnYwCKG4IGPhP?=
 =?us-ascii?Q?/sYltk5sH6Q8X2t/PijD2gftKkwPxGgDT+yIwhJmc0aTmoXysLl/l2TuJ3BE?=
 =?us-ascii?Q?J9cjXshZKabiHiueVZ1HNHvufGLibSIWKdtf7v8qPDZg2vk5r3fTN9LXb2od?=
 =?us-ascii?Q?4ehdLJ496nd/lRLUidtHIYJ1XFZnC69FmGXmf4/o5NZ0pxB3Qfwxs5Xna0i5?=
 =?us-ascii?Q?1+L9lAWL+Txh3IN+4t7i9ExlKP7qbe3xBUGyhjuPUpsp59rQ9HF8UVAfvixV?=
 =?us-ascii?Q?uZbgnATgXKjTGExLPK/IIsf52jS0HNVjv07oq3EvJosch14kT+9T31CNmygM?=
 =?us-ascii?Q?3JahZvbW9TEkbWihjptpzswMVyduqSo3+xE+rVeyJP8kt6LK3kFQnkZMnhiB?=
 =?us-ascii?Q?tDNwjM2htqFdeKQYOH/BNaTZYig7jlwyTtMf2Cc+2ZRMdcjCX0ug8ZzcNxZR?=
 =?us-ascii?Q?XL4ojDRqWaPfoet/dxuQJIvMQTkcILMyzPE0zZ9y5kTSTM8TATxX8nD23ssE?=
 =?us-ascii?Q?hXZKMsMYU5Hjof+wjZG/OWXIARP0a9RUvzZDIKkdMtSYqQAutXDCqOOE5gd9?=
 =?us-ascii?Q?IcPJyq9EEtNu8ll4Gq+JSBIU2kdg0+aDH3fN89TGA8Xcuq+1GYWZZmMW6fAD?=
 =?us-ascii?Q?7lEwRSSPWhgmvLOHtKDS0tQc0Qa1cYuT1RMwp7JXzGEE6o3EKsfZ6NBDBMDo?=
 =?us-ascii?Q?kKpciK8yhlYkzOk0TIkN8nTEkdiu8mW0fhUouNfpfddyQ3H9vHPWvxFwuxsQ?=
 =?us-ascii?Q?pvOidrgjDCxonYNbuBnOcMUm3DbzbTF3C4zrc+5n4oM66Pur3yWN4ZqHDsLi?=
 =?us-ascii?Q?bYZo7YY2mkWRnS19MlTluhB9tRPzrMOAKtF8eiB6Pb3NZKOh6hK5mqPcY2FA?=
 =?us-ascii?Q?jh7nRImH0A+CH7ts+gkuxGkHC60cd4NdVmdKot7gC5rNfqxXwPOJLjtbgypC?=
 =?us-ascii?Q?y+4+7Q3JFf1kebIoVjT2tgiHwqIgtPpB8cXZBNNgFwaPmpsk1xO0R84F24gK?=
 =?us-ascii?Q?WgSB/COuOw+UoC34LNfN7iBQ1AM8OvtLCMPAZf6h+04Yh/NtFOj1Qv98JtIb?=
 =?us-ascii?Q?9FSaxcWHj/rwucLRhJNxbWYgGi9d9Ppj/8Rpsz2bMye+uwUgzgvLzdBzlVjB?=
 =?us-ascii?Q?7fuaR5kCmRb6kNI/V4Lc7awDABHbpqGsCj4ozNDyOKnwgl5txwreR16cTNfT?=
 =?us-ascii?Q?1pzGW8N8Ch1pdo4BejeZqxcqKWe5dQgTJLPl5LS5d4WYmWJE9U2ZZSYfCKdR?=
 =?us-ascii?Q?WyVxa0nT7QIwfpTkq0wZpqh3Sqr9btPp+tJWfaasVLH1yirZ+WRfavaOh+Bn?=
 =?us-ascii?Q?4qla/Kz9737D3PPzq4aPxZDZlP2rb/93/mZGZUswfKNw3qmEeg+5I2vkRG4x?=
 =?us-ascii?Q?iNzlLcTdk6r0v9bFD0NqbotCIm2mlHanLftFOrmK3jeoauh33rRM2Uri6GWr?=
 =?us-ascii?Q?oZb1c6fJ1Gj3b2U5LAm2ivbNDLOFxVlKX7hCyEPa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67d28cc-c815-430c-ebf1-08dbbda3ab08
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:45.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl6juCATFmCbsva11KXwr8lkpi1PxHPIcn4Waj6xhsk7MVS3RM5kVR/X6dX2KCSjT4DDB3GBWqq0K+YeQd33eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

The helper get_counter() in mptcp_join.sh and get_mib_counter() in
mptcp_connect.sh have the same functionality, export get_counter() into
mptcp_lib.sh and rename it as mptcp_lib_get_counter(). Use this new
helper instead of get_counter() and get_mib_counter().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 41 +++------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 16 ++++
 3 files changed, 65 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4cf62b2b0480..3b971d1617d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -335,21 +335,6 @@ do_ping()
 	return 0
 }
 
-# $1: ns, $2: MIB counter
-get_mib_counter()
-{
-	local listener_ns="${1}"
-	local mib="${2}"
-
-	# strip the header
-	ip netns exec "${listener_ns}" \
-		nstat -z -a "${mib}" | \
-			tail -n+2 | \
-			while read a count c rest; do
-				echo $count
-			done
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -435,12 +420,12 @@ do_transfer()
 			nstat -n
 	fi
 
-	local stat_synrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	local stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	local stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	local stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+	local stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -503,11 +488,11 @@ do_transfer()
 	check_transfer $cin $sout "file received by server"
 	rets=$?
 
-	local stat_synrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	local stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	local stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	local stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -536,8 +521,8 @@ do_transfer()
 	fi
 
 	if $checksum; then
-		local csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-		local csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8ef91a939c1b..26ea0919810f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -595,25 +595,9 @@ wait_local_port_listen()
 	done
 }
 
-# $1: ns ; $2: counter
-get_counter()
-{
-	local ns="${1}"
-	local counter="${2}"
-	local count
-
-	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
-	if [ -z "${count}" ]; then
-		mptcp_lib_fail_if_expected_feature "${counter} counter"
-		return 1
-	fi
-
-	echo "${count}"
-}
-
 rm_addr_count()
 {
-	get_counter "${1}" "MPTcpExtRmAddr"
+	mptcp_lib_get_counter "${1}" "MPTcpExtRmAddr"
 }
 
 # $1: ns, $2: old rm_addr counter in $ns
@@ -633,7 +617,7 @@ wait_rm_addr()
 
 rm_sf_count()
 {
-	get_counter "${1}" "MPTcpExtRmSubflow"
+	mptcp_lib_get_counter "${1}" "MPTcpExtRmSubflow"
 }
 
 # $1: ns, $2: old rm_sf counter in $ns
@@ -656,11 +640,11 @@ wait_mpj()
 	local ns="${1}"
 	local cnt old_cnt
 
-	old_cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
+	old_cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
 
 	local i
 	for i in $(seq 10); do
-		cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
+		cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
 	done
@@ -1256,7 +1240,7 @@ chk_csum_nr()
 	fi
 
 	print_check "sum"
-	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
@@ -1269,7 +1253,7 @@ chk_csum_nr()
 		print_ok
 	fi
 	print_check "csum"
-	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
@@ -1313,7 +1297,7 @@ chk_fail_nr()
 	fi
 
 	print_check "ftx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
@@ -1327,7 +1311,7 @@ chk_fail_nr()
 	fi
 
 	print_check "failrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
@@ -1360,7 +1344,7 @@ chk_fclose_nr()
 	fi
 
 	print_check "ctx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
@@ -1371,7 +1355,7 @@ chk_fclose_nr()
 	fi
 
 	print_check "fclzrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
@@ -1401,7 +1385,7 @@ chk_rst_nr()
 	fi
 
 	print_check "rtx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ $count -lt $rst_tx ]; then
@@ -1411,7 +1395,7 @@ chk_rst_nr()
 	fi
 
 	print_check "rstrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" -lt "$rst_rx" ]; then
@@ -1430,7 +1414,7 @@ chk_infi_nr()
 	local count
 
 	print_check "itx"
-	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$infi_tx" ]; then
@@ -1440,7 +1424,7 @@ chk_infi_nr()
 	fi
 
 	print_check "infirx"
-	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$infi_rx" ]; then
@@ -1469,7 +1453,7 @@ chk_join_nr()
 	fi
 
 	print_check "syn"
-	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$syn_nr" ]; then
@@ -1480,7 +1464,7 @@ chk_join_nr()
 
 	print_check "synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
-	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1497,7 +1481,7 @@ chk_join_nr()
 	fi
 
 	print_check "ack"
-	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$ack_nr" ]; then
@@ -1530,8 +1514,8 @@ chk_stale_nr()
 
 	print_check "stale"
 
-	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
-	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	stale_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowRecover")
 	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
 		print_skip
 	elif [ $stale_nr -lt $stale_min ] ||
@@ -1568,7 +1552,7 @@ chk_add_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add"
-	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1580,7 +1564,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1591,7 +1575,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1601,7 +1585,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1612,7 +1596,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1623,7 +1607,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1634,7 +1618,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1645,7 +1629,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1667,7 +1651,7 @@ chk_add_tx_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add TX"
-	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1679,7 +1663,7 @@ chk_add_tx_nr()
 	fi
 
 	print_check "echo TX"
-	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_tx_nr" ]; then
@@ -1717,7 +1701,7 @@ chk_rm_nr()
 	fi
 
 	print_check "rm"
-	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_nr" ]; then
@@ -1727,13 +1711,13 @@ chk_rm_nr()
 	fi
 
 	print_check "rmsf"
-	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ -n "$simult" ]; then
 		local cnt suffix
 
-		cnt=$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
+		cnt=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmSubflow")
 
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
@@ -1761,7 +1745,7 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	print_check "rm TX"
-	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_tx_nr" ]; then
@@ -1778,7 +1762,7 @@ chk_prio_nr()
 	local count
 
 	print_check "ptx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_tx" ]; then
@@ -1788,7 +1772,7 @@ chk_prio_nr()
 	fi
 
 	print_check "prx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_rx" ]; then
@@ -1917,7 +1901,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(get_counter ${ns} "TcpAttemptFails")
+		cnt=$(mptcp_lib_get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 91a17ae81cb8..0f5e34c76bb4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -328,3 +328,19 @@ mptcp_lib_verify_listener_events() {
 mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
+
+# $1: ns, $2: MIB counter
+mptcp_lib_get_counter() {
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" |
+		awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
+
+	echo "${count}"
+}
-- 
2.35.3

