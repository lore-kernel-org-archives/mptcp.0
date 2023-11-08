Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7E171CF
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="pQ2GX0c5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ863/Oi70uPyQgVRnhs/q3wxsF4Q//SByA7v9ZRMf2NNbNYa9EXxwm18z6MOg4rxLPx4o5bakCJlazwUgOeD37iBa1hf9QRvFNBOCr4kMC+/UKXECJ9HrntMnJomEpWywaQdo46XfbYdCxHbxYlYnMjVSbDhZy/oq8wZoP9zINCEoN/FPUD/kmuL7RJSizv4xbHTOVOTbqi3HeyOuoPDf3iAgOIo2kayj2NoenQyuHoYH/fTXXXlEmqKzI7nujpUCw60Ip0qpN5Z0ccKoSrJSKEemeNxeLUjrO8i+w44ph/IKgtietyQToBMpJk3InIDruF87axyk7Xo3mu03u2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D66Yaxt4JsKLJ0oIoo2vbW1KmkzohR8wATAcYq02qgo=;
 b=mPf/fDKaRdviL5EQCkQxyyWasRF2s5yjcJmzUSnvWR8o6RIrD9zCIef1wZ82UqMalOs7a4HBbZhijETa6X4vbfbIUrbi8udgJzKuqPLKfAMuFttz/vFLZ/6k7ad1fgkZQ3eNc1IIZhIWbVGKTAl1cXTPmTDNNxrVlqi9uwO0qxDbKs620LZ1QRlx2DCtWfOgJDJS10a+ivcUQfjCxyBQZ+X0FWC1sRFwYafoV8/Muzej/7vLkGuTnZo7febnvaxqVcNAXgUUaFH99aC8XCUUY5EnmnnzwlGxpHmliwIapFNtdMtyqpgb4ThmGiBXi0pSFfsk/QP1VP3syvtz4oicYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D66Yaxt4JsKLJ0oIoo2vbW1KmkzohR8wATAcYq02qgo=;
 b=pQ2GX0c5FbsTMArQuPkP4UT7om8dXmuKlEihgKLo7ONPnEZZ/YE+nZpHQokZ0CnSUshPVjL1SO0ASmoII6ftdxBr63GlWBUP3c0e4XraqW0uBkajwTIDkfreHQ60IKeaUYPa65n0YB26L3mejijDMB17hg/SVIlZU4QnbPnlMl8ZA2/PfUuBP2irWtE8dZPHtU6IPCD0W0NjcONy2w0J62GB1olJnMtxPNwgsGmUL4hknwVFA+3l1vxsdKa8bfo2gumkYxW4xwE2S0/as7aWI+w7+YZOwB7ktgRlmiZkWJ1ONLUUktHw96bZ+1oSFDusgecaMmOEi+hTFJvOtbs7lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 07/13] selftests: mptcp: print TEST_COUNT in outputs
Date: Wed,  8 Nov 2023 22:11:48 +0800
Message-Id: <b7016b65713f64fed3a9a0be223ba50409bbfc4d.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0936906c-3120-489b-f30e-08dbe064c5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvsZK0I2gYaba2wOW+/E2YNqAwIIPUIgl0VsZ+1jLJqYeIvRBBtzHzXCNDizVCLWlOdDxybXCQzD79iX7hNGKL3rO/LxAmp9XIr0EkBUgvuIsBISlMJJrfGKOMfqxf/6m2cVxH+0mg9wmGJgFVwicvwXcCQnd9ATKn+WM+aUKDJnoK6HfV+C1ExiDb9ErlGEXuOe+k1u9WzN/dYUE/5SznHO/Hc89S3wZvVJAmRVegV5RW7bArzXjOpWbyUU2ofby1CJ9g+LqyYNprX9TcdzZLY0rHNorL7S7YLUT9I/IX0+V9HFeKhMXo8lZtNo9bAI+z5t49k79HwooHmQ5eMpQMx586/ZxlGGTvkd5qLgllwQArTUzk7h8pMBVr2oqhGX4G6XX1P7r7t1KnF32+PFrsKpLEXGXOiOsQFvmnoRza6gCwrNaE8VXA6pt+eifqSmSsJyR0HCiQHW3THq9UziGro0Rx4zNQtB1HRFsfA0JEdi/yoY1hG9/QHGNBS5dd/1jjDezy6/jEUNDjfMX/rA45Jz2CY9QcdQoOP4jrIwh9jvhbj9BJQOiicHRK37EOj1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iJ83Z5nGtVGb2nQHGBL2twduOU/vEnYkDCO3rI+LQfjd7PMp5XD0Ld9Snm3k?=
 =?us-ascii?Q?2WDjc4cziKfm+2yKQ7j9Jo0pvBP3HhmTMd7V1tqrKkxt+OoJOVpDa1UsATUB?=
 =?us-ascii?Q?fZuKVNYlAsGkBslYhCdRgQ2tgaA3UvZo8Ne5rNcQDLASyw6MIkXXxcIYVWJY?=
 =?us-ascii?Q?gP+aXbQBzFKPsUkE5BoV2akFXLus6x4Uwz2aUvotGkdzH4NkN8nIHhrMRW2r?=
 =?us-ascii?Q?mzT5SYDJbLjxo/4woBilHwrvWxSfuE5qRsdIt/LIhqQ3LPMkeMYtEkIDMQL+?=
 =?us-ascii?Q?lR48XwmqVYYXgaKiFVp+pDUCUZYfpH1SIcxm5aS1Wr+yU1UxAehkA8jo/iq2?=
 =?us-ascii?Q?KQfNb7KszpNpNhGMD2L/t5vqJevQjbEk/0tHWeOmimABOtzUIZOPoUI4Iv8C?=
 =?us-ascii?Q?V5rkrMQQs5EcXMkQv8thux2GuQE8/S1EWeKFJxOnlolRFRdAee5hSbSM/cQ9?=
 =?us-ascii?Q?aLpErdguR0uFNZB0SFse3kBEf6YXTfEhT7UtKvwv2pjickZjcYg0HrhvUGrK?=
 =?us-ascii?Q?wNzPPkVP4uRd1EzgHm7FgEN4Mxc0QwG4IELdfk0o9HKaED6JYIRl02Qd35at?=
 =?us-ascii?Q?Q0PDSEAKx8DAEWgfUmFKJ0sPYc3mRiQr688DVzv5BzLam2JjPQh3IEA+o4fD?=
 =?us-ascii?Q?ZMsgzyTbw2oiYd/HmxNUfaGX6LNv8bGw/XFlnCkMu/lE7TdWNYYC32PfGeMQ?=
 =?us-ascii?Q?nW5ueiA7ehoDUwNygt7EJBZIi3eKnFA5/hBQSrcEn0dRQK2A/0lK8l8agphU?=
 =?us-ascii?Q?sWzBCVw1I+HsHlAwcWTvyF6duvcV40BYiYpF9F8CnYjOdr07DIyuxJLf3Myb?=
 =?us-ascii?Q?/IRDlgOa0A1V9N/X6dN5MIupsysi3Sz8lKOu5s3c4wKawpIrqhoH98j0aPNV?=
 =?us-ascii?Q?ZGfeNASPio1ppAJnmwwkudvwEUWbOBJr5+4MOKAMdlt/Ra1Mr5Pq4iNe49Yc?=
 =?us-ascii?Q?7Fw4he254LMBLNxXhkV99TeFXxdQIm024wgF0rZgOSG2abIhrX7G4JjxrQSI?=
 =?us-ascii?Q?Y3vIm62qQ33eNmB7z8V2MJnsFRbxu7qK0q4r/p9QsJD85QHW7ByaroyjlyhS?=
 =?us-ascii?Q?YZXPdY0z2o8ESV9tOUGH5jxQb0dakRS5icFXhx9NLK83CQ2jBYipG+XRIDC6?=
 =?us-ascii?Q?TBKuY4W8SznUUST1Rch9ScZSR9S1NOWtEB1zFHiCpXWwhCCbFqclruB5Evp9?=
 =?us-ascii?Q?TfayLvTXgJ8qsOo+Vkn5pU5iOndF10J5JjwD/kQxVcD0NWabP2tDYa+Focvl?=
 =?us-ascii?Q?vNDz3lnAL8LbkQVsY0Cxopi1xuxNyLc54tHRnQbf5TGBHD5SzrCi579/M2Ry?=
 =?us-ascii?Q?PHZ1BhhWxIwKbBlxh1az6j4wDPdd11fZqsS8P/NHgEoVfpNsVYZdai3YWbAN?=
 =?us-ascii?Q?4NUql1PVDur/IUOgRhCncJunpXkQ0urHO1wt1R+LT1sGaVHm9w5riIAYa+7H?=
 =?us-ascii?Q?fvxod7S6pdSSzr9t/fLIF4gLZBVJLW4LkbVHuCS1LVuAhxZC6YTUby3duE5v?=
 =?us-ascii?Q?LC7w35epXzBr7Ke+8U5ZxtCEKdEfSugYg14M3X5tZ1NDPn/NduqDp8fOvI2e?=
 =?us-ascii?Q?9eovi5UBHTnmlQiBmwN6oGETbFcAD+EWQvySCEIb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0936906c-3120-489b-f30e-08dbe064c5b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:42.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLVSYgofhEb1p57D0ZlZdZjfhxu2JPYHyY/DoQ+2IkGkSrNHBShXpCbCXapCspO4KT9+uNqjJhuHSlJtSSK18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

This patch prints out TEST_COUNT for every tests in the scripts diag.sh,
mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh and
userspace_pm.sh.

The output looks like:

 01 no msk on netns creation                          [  ok  ]
 02 listen match for dport 10000                      [  ok  ]
 03 listen match for sport 10000                      [  ok  ]
 04 listen match for saddr and sport                  [  ok  ]
 05 all listen sockets                                [  ok  ]

 INFO: Init
 01 Created network namespaces ns1, ns2                       [ ok ]
 INFO: Make connections
 02 Established IPv4 MPTCP Connection ns2 => ns1              [ ok ]
 03 Established IPv6 MPTCP Connection ns2 => ns1              [ ok ]
 INFO: Announce tests
 04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ ok ]
 05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ ok ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  6 +++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 21 ++++++++++++-------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 +++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh |  3 ++-
 .../selftests/net/mptcp/simult_flows.sh       |  6 +++---
 .../selftests/net/mptcp/userspace_pm.sh       |  4 +++-
 6 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0e8fbb55db8f..697afb205374 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -7,7 +7,7 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ksft_skip=4
-TEST_COUNT=1
+TEST_COUNT=0
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -61,7 +61,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			mptcp_lib_print_warn "[ skip ] Feature probably not supported"
@@ -111,7 +111,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b28d7d3ce4de..74a94efe85f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -280,7 +280,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	TEST_COUNT=$((TEST_COUNT+1))
+	echo -n -e "0${TEST_COUNT} New MPTCP socket can be blocked via sysctl\t\t"
 	mptcp_lib_print_ok "\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
@@ -349,7 +350,8 @@ do_transfer()
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
-	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	result_msg="$(printf "%02u %.3s %-5s > %.3s (%-20s) %-5s" \
+		${TEST_COUNT} ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
 	printf "%s\t" "${result_msg}"
 
 	if $capture; then
@@ -654,7 +656,8 @@ run_test_transparent()
 	# following function has been exported (T). Not great but better than
 	# checking for a specific kernel version.
 	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
-		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} INFO: ${msg} not supported by the kernel: SKIP"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
 	fi
@@ -671,7 +674,8 @@ table inet mangle {
 }
 EOF
 	if [ $? -ne 0 ]; then
-		echo "SKIP: $msg, could not load nft ruleset"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -688,7 +692,8 @@ EOF
 	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
-		echo "SKIP: $msg, ip $r6flag rule failed"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -698,7 +703,8 @@ EOF
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
-		echo "SKIP: $msg, ip route add local $local_addr failed"
+		TEST_COUNT=$((TEST_COUNT+1))
+		echo "${TEST_COUNT} SKIP: $msg, ip route add local $local_addr failed"
 		mptcp_lib_fail_if_expected_feature "ip route"
 		mptcp_lib_result_skip "${TEST_GROUP}"
 		return
@@ -855,7 +861,8 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
+TEST_COUNT=$((TEST_COUNT+1))
+echo -n "0${TEST_COUNT} INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
 reorder_delay=$(($tc_delay / 4))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 44095b274c40..b965c12470b5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -184,6 +184,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -197,7 +199,10 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	mptcp_lib_print_ok "[ ok ]"
 
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -213,6 +218,7 @@ do_transfer()
 	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		mptcp_lib_print_ok "[ ok ]"
 		return 0
 	fi
 
@@ -243,23 +249,29 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ ok ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_print_ok "[ ok ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -282,6 +294,8 @@ run_tests()
 
 do_tcpinq_test()
 {
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
@@ -290,6 +304,7 @@ do_tcpinq_test()
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
+	mptcp_lib_print_ok "[ ok ]"
 
 	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 3b0512ff5d54..853dbd2eef41 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -56,8 +56,9 @@ check()
 	local msg="$3"
 	local out=`$cmd 2>$err`
 	local cmd_ret=$?
+	TEST_COUNT=$((TEST_COUNT+1))
 
-	printf "%-50s" "$msg"
+	printf "%2u %-47s" "$TEST_COUNT" "$msg"
 	if [ $cmd_ret -ne 0 ]; then
 		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
 		cat $err
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2ab0e649031a..938844477fe4 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -12,7 +12,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=1
+TEST_COUNT=0
 ret=0
 bail=0
 slack=50
@@ -241,7 +241,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -250,7 +250,7 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-60s" "$msg - reverse direction"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg - reverse direction"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 613fdb289881..7f4aaca032dd 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,6 +50,7 @@ ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
 TEST_NAME=""
+TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -64,8 +65,9 @@ print_title()
 print_test()
 {
 	TEST_NAME="${1}"
+	TEST_COUNT=$((TEST_COUNT+1))
 
-	_printf "%-63s" "${TEST_NAME}"
+	_printf "%02u %-63s" "${TEST_COUNT}" "${TEST_NAME}"
 }
 
 test_pass()
-- 
2.35.3

