Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A675692
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dA2H8dXK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln4MhFo849xbImjN7iqw440KZODWPH8YM9w0qpUGfIPbdFVERTmq6B5SHO9T3kb3IQlD0QYVBU5xrxf3IGVmBQRzLxbqDpSlG6vtx/XgPcx9lGNvwj2Hxo2SP/eMO2yCouJ9AiofDDHz0Xo8INyJHU43ZP0oiW0ZEsvEwZpTvUsV7y2W79v6tfydLA0Wsgdulc2LPSbwHqeiCYEhlhOmvVJ+bNQfXTq5DpYhJcKBaiYw90xSEsFDEvZKpq85+o6mUntIhwqYJz8fM34oBf27BIc6kdN+v2/fLcTe+ZC9NEalfEK/8XjWP1CwUpsq9aOUjH59vP2dyR4KWlpN9Re6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEe73/Y++QFsFtjMWQ33xLMXFxoQqtVoVMh8F53NNJo=;
 b=f04XcAd1IPoqvbwfNBka6CBhkPBgDPxM8LFbTcMkhCWzOD0sne9QZbRduOeZtUBGbD0dV0D3A4ei2Bg4JXzbpV5EOF7r5vBbVjFIySnsagkPMh7q5p5DjlOjEjrse+LWlPFjfI2p09BJjsCMRm8iiwIKDldjDsDES/Nirfh83l5UAoUSj6O9CaL/JBHgS+0I1vcBYLhhoJCKm1OJAmwMX0Si177Q+vXoo7YAd/H4ANBvh+BoNikNEurAe4ZrYFWmeyFQrVGVKrRH6DvdE43nFit4eF0oqkXgSZsaSVpDPYr3/xG8IC10V/DXxVaUJHsy9J815VdqitCljTrUSSvLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEe73/Y++QFsFtjMWQ33xLMXFxoQqtVoVMh8F53NNJo=;
 b=dA2H8dXKqTEFsFNOSoUfDXM582LUiTMUvyZa/5JWM3N3RdmS78d9oV828ky1gwUYQn4+tqe0Xz1wZg+2MBvSFh6uuql/CMoca168xGjxgHnHgoYhvA1hHzwkEfKutnhCQZwjUyIMIYyZhSuOKweOMSeoCGsRgypB4QLqq7UxyaH/64UVeh/mssnhPayQCUkh1OEwcXsEQCTyxR7R2hFb9pHK60ZRqyGIjEylKU70UPBiXvcHDCfNprgqZWmJFLeyIKwBo2gOUGQYMlPmh/uX93FKuN9bRvhj6kYQnW12GNFlNMeAJyHfMaWYKA/GN89lnN/tLPuOpQBDFdi6F2ZqwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:43:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 3/7] selftests: mptcp: add mptcp_lib_get_counter
Date: Fri, 13 Oct 2023 15:44:33 +0800
Message-Id: <01e9a8bc6e22784a10492b22c478f0beec06d438.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ab0e4f-7daa-4d08-abb0-08dbcbc01dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7a76Bp6IXCGcOSZPMngJkOzTij8EENCXXdjGi8n7Zw1qgrH38q+nqPzpwNyKPdGW+FCxrdnccmSquMMlorz9gTze5zll0MyLjt2UaxoTrTwg/HA7tlILQedHxFkJoS4XMlx28XYl8ceMRrEBYfnDHrQYsiHzL8Y9CS6p/VUreQ6FMoeuj9M4d/z9qjUtHrrvumpYyJ8v9KFj6HF3MsU48yF1ERlLfKonmkvvkny0J/iFBB/dnPlR1t3NnTbJzSnt8WHUnbqTuvHN240ezl0q+vjFRdyLMarIog4bwqZXkUBaIzb4ZAzzG8PqPZrJRgZ/E80DuuWMH2onAwmgkjNhD9ox4daaTzpv4NlRK+0cfpCxyDGASxMzvOxt1/YjrdqwsQ0ZvC08cSSs/vWLOVdcuvGRn6pcWUEMg513iDjjkw7shLPj+T2u5HYU1vJDeWx4JKNWVoVRjTu2gPtDfb4n7psTtc6s3BqvgbTv6nQbkCZ+oQl1c9qspoLhRa8ng8JA7LismM9i0VligEPOIYxShh5s7YJ0XYfU5ZibEYiitrxNaSfMMpOtHyaeW5jh7BFH8YnOa9+IlLmswS9H2aH7p3B7kecTPL+exi4RlcqOQYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(66946007)(6916009)(41300700001)(2616005)(66476007)(54906003)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(30864003)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsdXEBt1vwEhhQaFM5qFLYbcDxkoDKk84Mi3ZalJoROrjuoVr1HAkGgSKFHx?=
 =?us-ascii?Q?51VT8VJw0AcFshoQ+j9PmOWg6+LegPreYjN18lYY8LvUsi3sXIp5kb1v/s4r?=
 =?us-ascii?Q?XE42FuV1aDrW9V8oofHYo9url9hiYEMQLL2W0l2k/TVBvwzCRDKeZ3UtVyrb?=
 =?us-ascii?Q?Ja82ClAZ0w2M12W+/aF13gNbJEI/EFIzjbxFyMHfL7M5fbz3ghf4RdMMCB8/?=
 =?us-ascii?Q?vUUGiCnZ7D7FVBFrUCYy17OKB2io6jaMxHRC9IupUNSFTPWMotjYe4+qrsqd?=
 =?us-ascii?Q?Ni5xrUVvpd5tqVeBeaRXtIqdWQoxSYDAXiH9W53TLF8893qoW7nZb+M+4Qw6?=
 =?us-ascii?Q?i/myANzHWcTM8K73PZf2atO8a0PUzHAZ7LH/7is7vfcYd52Muw5jPGkC6DDv?=
 =?us-ascii?Q?XjFrdU5sAJap+CeGt1FIVDesDF09TVWf55iqAzydHtLgy+X8/Rz/VeoEyP0L?=
 =?us-ascii?Q?2NnD1lMD0UE5uJTi78zCqLdwz+/oYw5/HkfgP7nC3yrh3tn+mmLJMOxsqFLR?=
 =?us-ascii?Q?DxPYwcg58q4vaya8FkkvfMb3FgYU6xLmONXYup7oL56dXBuTLJbDGMWMeG9n?=
 =?us-ascii?Q?K6GKAUSNMY99pIMG7FRJXNLVwFPstz2IIJR02Gtw9VFq/o62quVRAoIts+Sc?=
 =?us-ascii?Q?zWIgtC//YdKZkwDtmDxBePrPEJD5iBhTKoasq5Ku7xEhzGmmLlgSFp31bRfL?=
 =?us-ascii?Q?MWa7KMG9V98Sk3Fad1PZUeaB2qDDo9AgY0zq6FbXlI+oYMzvUsO9ap/cqvp1?=
 =?us-ascii?Q?X9ZkA2wOkLwRCJ02TXze1z3PqS0DIiH73Z+Pn8rWMBqaPqFT8NqzOSlUtADG?=
 =?us-ascii?Q?p2fP23sjnPyzKEO34ZxmwYAkslqyUqZnaoeEGKJrWpL0V1ka/GkbkLauLpcI?=
 =?us-ascii?Q?oAHwCcBGiWqRB7d6voN/JI8ZwmMIsoFOD4UkJQ5/T4ucl9hWu8QuXcj4tmvz?=
 =?us-ascii?Q?IF8ipMqjDnjFR2GSjQpBIdwvuIl04CLFYwhzPUOPlFsD5dhdiN1/zItN9xJ4?=
 =?us-ascii?Q?URMy/ddCM/J0FYaMUazkLQa4V9wG1x5p3NC0OSpll6+vGUpBOLo9/x9gssws?=
 =?us-ascii?Q?oGim+whwtjA4a4fbTLd/BCU0ipGSGeIHbHRanOK8uSS3pzs6Gq/ZZyfAhxjW?=
 =?us-ascii?Q?HlWBA2qERMO/Q3Fkv59RU+He02kVCgoV/LEyLdxVzed+R7tmRI880KyFSvla?=
 =?us-ascii?Q?wGg9G06rK95beSZ/I3lDscl7PSewFbDWGGhaMqXYV3T9K+BOQJ+eVXaSwVCx?=
 =?us-ascii?Q?wijynXgwBhfCYReJBPPPfHeRqlSunslOoqD2UETszA/Vjve6+EeL8eqmscBF?=
 =?us-ascii?Q?2mescEUIEOJC9L5QBT+LwHnoose7EEytcf5eSKjUgJfNFQof3RITXG5rT4UB?=
 =?us-ascii?Q?tcpJ42wi99ulNWvSm4RrAZEH0Lhx18E/Zs9nVzbAKjmyucGP2k0Jh2xyPJLZ?=
 =?us-ascii?Q?oiBmUlUY96ndN4bqezxNu2o7tDmjVYNRtSYvLGEo2lfbq9+IzwKtq+NiJUDt?=
 =?us-ascii?Q?50rudDycqF3O+Jp/6qF17Sk3ZE79A3VopJ+LBbs6K068ex0FUhNGKf8iht2G?=
 =?us-ascii?Q?c/JkrfKEqcROowRR0GO0K1sSNY+pU6yjvsJGysjwQPAISoeyEKnAYGCac5iv?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ab0e4f-7daa-4d08-abb0-08dbcbc01dde
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:40.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nASg5z3y3R2IZBYj/baHAqaMXy6re8lW/+yieZ/wEaHYvhWQatf/yRDS+xYwQOBbNhFW1ml6qkug5sHHKbE2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

The helper get_counter() in mptcp_join.sh and get_mib_counter() in
mptcp_connect.sh have the same functionality, export get_counter() into
mptcp_lib.sh and rename it as mptcp_lib_get_counter(). Use this new
helper instead of get_counter() and get_mib_counter().

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 41 +++------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 16 ++++
 3 files changed, 65 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 9ea4f0d6673a..4dfbbde6df77 100755
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
index bb2a56c2dc37..7bfced890e50 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -605,25 +605,9 @@ wait_local_port_listen()
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
@@ -643,7 +627,7 @@ wait_rm_addr()
 
 rm_sf_count()
 {
-	get_counter "${1}" "MPTcpExtRmSubflow"
+	mptcp_lib_get_counter "${1}" "MPTcpExtRmSubflow"
 }
 
 # $1: ns, $2: old rm_sf counter in $ns
@@ -666,11 +650,11 @@ wait_mpj()
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
@@ -1272,7 +1256,7 @@ chk_csum_nr()
 	fi
 
 	print_check "sum"
-	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
@@ -1285,7 +1269,7 @@ chk_csum_nr()
 		print_ok
 	fi
 	print_check "csum"
-	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
@@ -1329,7 +1313,7 @@ chk_fail_nr()
 	fi
 
 	print_check "ftx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
@@ -1343,7 +1327,7 @@ chk_fail_nr()
 	fi
 
 	print_check "failrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
@@ -1376,7 +1360,7 @@ chk_fclose_nr()
 	fi
 
 	print_check "ctx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
@@ -1387,7 +1371,7 @@ chk_fclose_nr()
 	fi
 
 	print_check "fclzrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
@@ -1417,7 +1401,7 @@ chk_rst_nr()
 	fi
 
 	print_check "rtx"
-	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
 	# accept more rst than expected except if we don't expect any
@@ -1429,7 +1413,7 @@ chk_rst_nr()
 	fi
 
 	print_check "rstrx"
-	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
 	# accept more rst than expected except if we don't expect any
@@ -1450,7 +1434,7 @@ chk_infi_nr()
 	local count
 
 	print_check "itx"
-	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$infi_tx" ]; then
@@ -1460,7 +1444,7 @@ chk_infi_nr()
 	fi
 
 	print_check "infirx"
-	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$infi_rx" ]; then
@@ -1489,7 +1473,7 @@ chk_join_nr()
 	fi
 
 	print_check "syn"
-	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$syn_nr" ]; then
@@ -1500,7 +1484,7 @@ chk_join_nr()
 
 	print_check "synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
-	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1517,7 +1501,7 @@ chk_join_nr()
 	fi
 
 	print_check "ack"
-	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$ack_nr" ]; then
@@ -1550,8 +1534,8 @@ chk_stale_nr()
 
 	print_check "stale"
 
-	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
-	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	stale_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(mptcp_lib_get_counter ${ns} "MPTcpExtSubflowRecover")
 	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
 		print_skip
 	elif [ $stale_nr -lt $stale_min ] ||
@@ -1588,7 +1572,7 @@ chk_add_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add"
-	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1600,7 +1584,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1611,7 +1595,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1621,7 +1605,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1632,7 +1616,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1643,7 +1627,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1654,7 +1638,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1665,7 +1649,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1687,7 +1671,7 @@ chk_add_tx_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add TX"
-	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1699,7 +1683,7 @@ chk_add_tx_nr()
 	fi
 
 	print_check "echo TX"
-	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_tx_nr" ]; then
@@ -1737,7 +1721,7 @@ chk_rm_nr()
 	fi
 
 	print_check "rm"
-	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_nr" ]; then
@@ -1747,13 +1731,13 @@ chk_rm_nr()
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
@@ -1782,7 +1766,7 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	print_check "rm TX"
-	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$rm_addr_tx_nr" ]; then
@@ -1799,7 +1783,7 @@ chk_prio_nr()
 	local count
 
 	print_check "ptx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_tx" ]; then
@@ -1809,7 +1793,7 @@ chk_prio_nr()
 	fi
 
 	print_check "prx"
-	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$mp_prio_nr_rx" ]; then
@@ -1940,7 +1924,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(get_counter ${ns} "TcpAttemptFails")
+		cnt=$(mptcp_lib_get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 8d0480d2a8f9..0e30c7bf24c2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -231,3 +231,19 @@ mptcp_lib_kill_wait() {
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

