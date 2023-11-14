Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB186133
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DYJzJ+WB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STFPKlk1CW1DRbg4dxYVbBjUEJlGuyFoCEoxpMK51pvHwZpnvESi72pSi6S4T8JvzwNUG+y7eS4Ik+pX7HN47QtCPKuqQjE+NL3c4qNO4Nc46QinNgV/WUWgxqjbM5zr8RxJQPIX6eZ7DjxPQ4OedJ1IHpC4Vj0cjOOP+FCT9AFCOJbPhiLdsljwZYlTXMc+v1a++47SFehxUbkkj+hXRKTOmH/W5cxIFOqU0iVIIjh9/fAOPHJUGmAAI2Rw9PAAQlSMUEcJYIw9WiAFJemkU4k7teu3mcJPMSRiLxTgLQkATzEtCewJaWl5yUjshVJT1QiJ7bhahEzKNZ30GFakCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPgKtBgb8R+Eodzpz0NAQe7lMk5DTfdsZaxJOTktBeI=;
 b=m519DYip+19UbWasnAnu2JEAzB2nZ9Hf9atmXVDK/f0f1c3C/UBwLEVtcMW2ge/wEDqrOsq8HQfF+YPvoZK2gYlPxyXK9dxLRGxuQETz4xCaa9LQIo6iLxEDksvKU4T4keGBV6/RjniLKSRTbs9MN6Sb1acvoEwDC0RwiM5LEI8iBuMlEwcmfs8TUS4VvIRHJGLEwRHSd16gSr2h+oHkwDiEu9cWbOnt66vAai3Hbi90VwurVVIJoMOg4fh7Pt9/5JSzuMkjH7jfwf7eoIpczDGOuIGYQtcYcKfroZlVYge8bw9wjETY6OrTTUrxNkCYJhBFZEJHAUDU3bGCQoRg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPgKtBgb8R+Eodzpz0NAQe7lMk5DTfdsZaxJOTktBeI=;
 b=DYJzJ+WBVaw8eK6LZ0/ZmK8G8PIq18cns9E+YLcAGQwosfjmVJ5NgMt1/iJdyJeI6XzyirLVjFIxKO73uaPSz5wdDdGUgC7VzDmnflc8yioX5ct5ZNN5EtXIDk4LN+01gVle6ViDbtZMloohEQp3PF4/2zBcWnBVK9O0IcnyLkUS7JB3mgAE/0UhFQ0k0i9jfm7NnKGKfwWRWBh03BjmDEOIudOdyRUGOE1462jGCdzrgAKaWL0wLiEokvf3Y7UzdQIQVfoS5VZwwY7IQeOPOrMgJig+Hp+7hwMZ+p0SQzoiIafBVGw6Aj+rmUoXWtC/nc5MbhS8+NyRXkLE66k72w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 18/32] selftests: mptcp: connect: print out test counter
Date: Tue, 14 Nov 2023 14:35:37 +0800
Message-Id: <2fadb121dedf5b8ce4e0b8f850affbbf5040ad4f.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d44ebef-b0f6-4c9c-3a52-08dbe4dc8e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rQf/+KlxD4Xe6gNmGbUHWmPpI39TK66iiG49GtzGI3D9gjKCnHp2lBK3blEMcqSzKyRA1aKQeX4UUW1SdV9cuMtS37BQ3FJlSQpmNO0Sxlp4aEkzKjagq/Yeac+LKpmXXFWTDd4/WhToaUweTcs5Gn+oXEw2kDdO17N/3h0K7jLfYbb2L3RS7nX7UMBock3Er6wgKTbviDK9KMni5frYPt8u3WdJ+441kpW7urJEx2g4WgkZu18LJwqJpTubiB8tjxkNH5nWMYVBAqraX0subU+lGO8J3f6FDWkefjRLQFl+2QoG1C6MruzyJPxXuEZlT6C9gxFQt0PKB44mUoHZ+xootLH45QlwoZeHqGykizUUkx9YVRkSCsXtNLpVEtdDZ8EPfie6yvza1+CwUs6myWOXavS0RtN9mXs3DHPowbLuXoHjXAbG+tAhKjcYYYiUPvEbFBGI0a36xuuxX38lA5m0GkIJHwz0A9yzNJMTeBQHEM8NxQfWZPYzHsZqAfTCeWrQq1YEnknjdO6xaB0td+UVuZuK6794NkPCfZH5iXNZPbPuMooCzyBHfeJrgaUP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwnoOprys0MQvslbGbOc00nIgy/aLNBO+WMseKln2FGDEuauDSyx/1W068QG?=
 =?us-ascii?Q?A9InpraHx4wMEyj2oPynFtAShN9HSz8VJknSIa1UvbnZq5ctQcphf1n6PBYw?=
 =?us-ascii?Q?+RUxEISKBhSKGTF0jlolYY6kK85XHPZi2SkMhNep0KIrJPqJGkgx79Bl6Hz/?=
 =?us-ascii?Q?Kg2Y5opFdbs4rrX+apN2H+qDkOMMcfCIBngGP/8PfP4MXgFOH1RzVCfcDpqy?=
 =?us-ascii?Q?NyTYVOuhS61sTmV7P46Ryziv2KfwGNiLK2oyfNhdbRBbThtziwYEmlHLZUWb?=
 =?us-ascii?Q?7a6gETx3o3RYyF4txcM4BqocnNrg/rUOeN/VgYagW61pxFeEPLW/mPayEUFA?=
 =?us-ascii?Q?tJ28ksGP3cEHIkR42G1S1uOLtBak3nRKu6UFK68cCxyIAbnZMKXp5T1D047+?=
 =?us-ascii?Q?v/JReBiKdqIaLQWTVbbwDp/CVKCmcGJoAtuSrM81h/+KGVshGbkNN5IN0AS0?=
 =?us-ascii?Q?LnKMJq5AtXECtLRLGVYz+3gdyda05pKT8yvLXLLc0G2sSrJDI9Hr+Vit9ROx?=
 =?us-ascii?Q?gVOIja+1Pr4DMZ3Wm9Jh5yu1+lef5R1fYNFK0TYIcJv/U1tFOJY4C+RkhupZ?=
 =?us-ascii?Q?4+srMbldy42OMS5mmePZdnrFoVDVV3hMY5hOTRFstXykGU2nohLRIpqQUVK5?=
 =?us-ascii?Q?NKSxCPghXdoYMRjmZsNCN6++FCT2pIjJo4LXch+IfD0xAcpaGXm/F94yPFNL?=
 =?us-ascii?Q?r+74VQ4XHrs4nG81wlFmqvNP+MhncoZ+3FLR3AXjCTZku5IFGROasTysb4/g?=
 =?us-ascii?Q?a3zj+58Tpzfx7l98P2nfYb8YpMu1tGHCqaOYayDCOuY6VMqmQsQ985LhCfV3?=
 =?us-ascii?Q?7WSDHo5sQBSZ6kGsW9v4wvtY0OQOIZgUQWDVTX3fggqSoDMw0Kh8UE17Inz7?=
 =?us-ascii?Q?eaFbZjWR4OTYSmLN2Ji0luexNZJHaPf8GUg389x/AYRVn32WV8snmCtJCc6e?=
 =?us-ascii?Q?JNT3LHeEtYrS89rbp8+AFWBB0OBFb6KDbyQo5aSEl02ToEC3AhuyRCSP0n7z?=
 =?us-ascii?Q?j9fhW4wGhxIUJfIDgGIN/3QPuGcz2O8vNNWHAqXYqHcUROQpN41qQvvR7kxk?=
 =?us-ascii?Q?WXB9kzIQ1NbARspnBcPZJSJgTCNwpNm+MwkaH4jftk0ok57PSSG1QsA1RVEd?=
 =?us-ascii?Q?hkW8lRiTSIJucmbm6CHY6VHKZS/mlORRFW0/9IPH7yJoFldyMQnx4KrfmkCO?=
 =?us-ascii?Q?pwXJHTvfNX8ARWcBZdaaewgJjU8GhFhSNW7Gn3j4/llDN9TY6WHo7T+uwkbV?=
 =?us-ascii?Q?XmHslvOohCsUAesdsOjfIWTMkQNjtp4UkmFf+dFJK8xi6ouUyP0iT0YHHVo3?=
 =?us-ascii?Q?UtcX/4v1/6D81aw3Lly30jDPOoWZjtn//V2Rk+VySlARyJ9fTJvOwi4wwURL?=
 =?us-ascii?Q?OxFm6GIAGjGdr1vd5+5lYS7HAXIxamf+l+bgbgRAAQk7y+vkdE306Q/H3AFR?=
 =?us-ascii?Q?2Diph/o9n3c961KK5rTS+c2o1P2CpBLnxT9CnJyJMa/pmeaOyYo00EU9O9Jw?=
 =?us-ascii?Q?yIzfmZd8NOrBzp7UrWcX87pBgQo4vUVLRpcqjguNWXhPYyDiOzACVJ19dBN1?=
 =?us-ascii?Q?AbWlZNstku9F7wgaR7g3taBveqyZtxrSMQba1Goh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d44ebef-b0f6-4c9c-3a52-08dbe4dc8e4c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:13.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFHTynSE9pMeh2zNkQMUVw/UgbEUwGVLbJeQpIVeNUEWgdxAvE5+XO1+SeQqwbog9LN3wa11gQo81YqwJWJ7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

This patch prints out TEST_COUNT for every tests in script
mptcp_connect.sh. The output looks like:

 01 New MPTCP socket can be blocked via sysctl                        [ OK ]
 INFO: validating network environment with pings
 02 INFO: Using loss of 0.90% delay 30 ms on ns3eth4
 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration   116ms) [ OK ]
 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration    33ms) [ OK ]
 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration    25ms) [ OK ]
 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration   128ms) [ OK ]
 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration    31ms) [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0a6d40c3aa85..7442bb2a8562 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -267,7 +267,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	TEST_COUNT=$((TEST_COUNT+1))
+	echo -n -e "0${TEST_COUNT} New MPTCP socket can be blocked via sysctl\t\t"
 	mptcp_lib_print_ok "\t           [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
@@ -337,7 +338,8 @@ do_transfer()
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
-	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	result_msg="$(printf "%02u %.3s %-5s -> %.3s (%-20s) %-5s" \
+		${TEST_COUNT} ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
 	printf "%s\t" "${result_msg}"
 
 	if $capture; then
@@ -641,7 +643,8 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -658,7 +661,8 @@ table inet mangle {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: $msg, could not load nft ruleset"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -675,7 +679,8 @@ EOF
 	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -685,7 +690,8 @@ EOF
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
-		echo "SKIP: $msg, ip route add local $local_addr failed"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -842,7 +848,8 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
+TEST_COUNT=$((TEST_COUNT+1))
+echo -n "0${TEST_COUNT} INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
 reorder_delay=$(($tc_delay / 4))
-- 
2.35.3

