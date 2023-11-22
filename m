Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CC4AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="y1dGBc9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk6QuZ7gFtjuOrq+vqlW89e56rdMFOCV17KZoX3uV+dFMKztuCReNB5f6+qURMrCVl2zuwWC+crolujOsc4ArNjoyCJ7Fktq82TaGHxJ67/uhoYdYYw0RXcG97yE+dGyOWHtiGn0zNGMDrbhUJNgZ7jX/jK5AxLLD0P+PJuMjgl/pPmyDGt4Sl7A/5tULIhuThWhleRv49nXJtl7J+8TkNBh+1Sem5lzEat7oLUvho+PMCBfK8DSkA8iRYRRwXP+gAw1FhEFOI8mHnyAkUDIlOWGI9+0AedXGaibg+lv9PLoXv7zMSZ1524WTumu8LFkqNSsBE3NE2AM3b/yxxzWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QOhoyYAf+Rf2hVCPSnJxSnOiUca7Z+9mBIlHq6lQMQ=;
 b=P/O/WcK0knJJ1Lb+GIIXg7y8E+St2lnLD/srNTV/eZyekD168f5m2kYKJGJe3k25BABOY35JPyUUbHsFBYmf/VOr+4ZQxDRsO2b/jg+HB5+HmEqfqZXaxhHRmscVawquttDKCPHxiFntFroiOLznZeVyoZ/gonIRxgKB0oc4c422ayQAIExTzHU3ulQWIhmLV0i6bJREMoVQ/VFEHc7x6/sL3Ahr3vm40EJPYtnPJAnKiOAGrp5wf5XtA4SBNJfdMCQ46AF7djW1V1sl1U4dVohK44xZu4f0ifQTx8vqNyFIeksspvDI2fWi1usxYQJyL+WWYoW+CMm7mw3eOxOdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QOhoyYAf+Rf2hVCPSnJxSnOiUca7Z+9mBIlHq6lQMQ=;
 b=y1dGBc9tAXBG0zp8qo4kyjhFXEQHGoy85XmC6Uox+uIzhs4VHfTQVFqg+ffv9A2H+fN+3OLy9/rtz7BsigmNjCTsUgFL3FKb8PJdnXX38N8MS26ZqumE/IJvyCNBGQ7w/X5ugPV6sl0zwtMTKaiMUEHdvDHai0MBy2IRqhPSubE82l5sHzlYaCfm7tcIkVouBIzDV8cjfC5c+6mBUezMfhTxvvJ6YIFVQqefhDL99cF/2B5vLPKZ0OCUSN4rUHnIaPJ7zp1CPjLrx7VXBMOIAr/jC40Kn5A+sDJIGxQgHl0KsAsqO0ZeEUGEdVKc0IdlpKrW72vLxmsZrsgR9vIgDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 18/33] selftests: mptcp: connect: print out test counter
Date: Wed, 22 Nov 2023 19:31:06 +0800
Message-Id: <a8c827e3bb57b7666cbb42d769eb92b4a47bb1a2.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 98612187-8bf6-4966-d541-08dbeb4ed6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NKkl5yK64s/FMqNb3+GH9AtrQt2/DYihGR8r0b+OhT6JVYXDGODdbgHPooi4Ji8M50jrUdqJrUVtpKUjg+2OsQpbt9KvlK7H5dAOL5P08RbwIM/6/8oqe2GVweLyjHw3Qre/r4zDMlQWv8iNT+Q1QPVkgEl5odTAT2bxZMLeYddzDS7ygc5k5bV8KSTSxqGBvdAhMO9O4vFHWsOwabnzf8FDNOOC6hsJJsFOe90C7ZsJklRlXZpbIcL9PEtG23a22Wyn8Cs4FzimHxMpf0Zf7n4oUnbSURbRqe0KmNFxHXhaYs1RHD5yeny/xFbFTFLv5uI2RDqKODEVEdNgg3N2lPLJPWO+4l4NApLp+AvDAk2uo7GGyk/EKvLhibAT6FfM6q4/hZJkaFa0N6USgfODugMJN/ks2xWx04a+Aq2PVPZQElT2cfkvMABnk/LjWy9rkPaBE7TIac0Zu1Y2w+n+sOkAb+W+3XleWVXK1LfIZHZK8b0H9KIYjEAJiFnHpMbEuxmQoHMKrrNyDwE+ZGRwsfILI9BF9i5ncjswGJ0H4WvuhP93xVr0P13j9G5mAtCorJFyBF9xvkt2vK4mGAfC7rxAFtcMzedrJn1zUwzF+z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTzf5yTRR3nXW6SVj6t/yujqD/kYJPCCZp6X93VMA9SzgxH6NLEJKRGQoysN?=
 =?us-ascii?Q?h0RfxdoQ7dvXxdDHcD81Kq4G2yuymxGDBdZIUemGvwv85Xg4eDc+KSMUVKYb?=
 =?us-ascii?Q?We+BJVzPRFXeriBOnow4SPBzA8Yb/RD6mJChJ9+zrj1zSktHVwZzpibvw+M9?=
 =?us-ascii?Q?19LPSOBW/3SzOPbQ0Bo8xO6N2rAroeJY+g0XmD/21hzk08ww2rTlxQNhv1dJ?=
 =?us-ascii?Q?aO8gRalAOdg+eJcKQahbwdt52rTYpDnyuwmJuTsoG0OI5+2UB38xEmL9tZco?=
 =?us-ascii?Q?n+zGCS5RL/KbKf4o6S5aPo7pxL6/0wyf8Xobioer1n8BAZHdlJXlQ5PbzuLa?=
 =?us-ascii?Q?zX5GXG7IRka3RyxCzqJmzybjgYGqkNCLGdyK8fhe7hGH5x+hdUmMvU8wN9rN?=
 =?us-ascii?Q?eK7SqZRZAP5Cf251no02blnK1xHQDxFMg6X8OvQajATGko1y6E8kca2XDrr0?=
 =?us-ascii?Q?gVsm9iYM31W0KpVzt0TUKRxMlX9GJ11Clm1/zlu80gBWSC276AmMiGfAVo82?=
 =?us-ascii?Q?IG2tQWCK+qX9Z8Z2diPr7SqLx3TvCCsCOPcBZfkf7CxJhC2cANE+GDDWAK+l?=
 =?us-ascii?Q?GgeFqIYmyYrQWYgyenAsjXe1JNCp+Fmi5pxtdaL+YZAkb+dqHLj0GJNSRlMB?=
 =?us-ascii?Q?WW4c2Vbtzpp5DpgZACKL9/eoim+YPOTYlFWPfwbegUSvqOtWIq/DgIJBMNnj?=
 =?us-ascii?Q?yX5h/mpu07XC0QhCR68TPyeEWXxOTLbbpI/esQOTLlo/7+3ynVlc3CGPEXvZ?=
 =?us-ascii?Q?RIMIavT8THYhD3julhFIGoT3wDfNbf8iy7i87WkdD3AEwJAFMD45Bw3P3yxN?=
 =?us-ascii?Q?z8+iP8s5q4h0dbPSOtfVi1wx3DH6JxHFx6QJJBtcIE5Yw99OxbniAs1vJIrA?=
 =?us-ascii?Q?ZDEdMKet/CCH0ocUXYhNJ/KEfxLlcStnv7XXEtakO9Zal6ilX2dGK87H+q1s?=
 =?us-ascii?Q?4XqN8q6fyLQLXIxSrhXBy93Q5xN2DOaIMAvBHr+hsM+RwcfTR73Yk7r6tUW8?=
 =?us-ascii?Q?KNpCvXiDAL8SadN3gUIvue1OQ23kyN/TZGnBunAR/k6qEK6Bsj5zHZRLPG7k?=
 =?us-ascii?Q?jZ++QR3Fdz56qiW7u9fbCYbkafGlH6OdvYwtRm/2uktnH1iKLfMjPhjiv1ER?=
 =?us-ascii?Q?++32Dcrge13qavKkp74z14vToAqrGdyvvpM2AIFyTt6fNu+sCPLMsMtFm6xB?=
 =?us-ascii?Q?VVg92Qj+gcjoICgSONF+gl5zgJOzqNQPopciK+FJPEyrXVZCEglKDuiNd+op?=
 =?us-ascii?Q?yCuUOhVI227++MP8lkXeKR6yb2ex7ANnJM+dwnM+No3bB94pLgN/ixIj5uoj?=
 =?us-ascii?Q?CoCH0Wve+Fx26Ff2YDvpebLDNzonbyP0ICV086LgIHCPypborMGb8qWKFfgM?=
 =?us-ascii?Q?aecNacJyTdPP6WzLdSlEeftN58sYfYfxkcm/YF37RBiAKnV/6uPPDKT+b3Mh?=
 =?us-ascii?Q?1R79NkepJkro3v1kVri/e0PefCqcE3MDnX36FJOEdcFAQqPSKJMusuhxSWWn?=
 =?us-ascii?Q?wN2jf8+apjcHX0W+Gh4D25q1mbrdHk+b5dYNH1zdF5CAZbrfEGsSwV5vAQ3I?=
 =?us-ascii?Q?5RnQ6xyH+6GcH8gWhWmacXt61DLyM9XYS+XH0Fbn1aUVafUySS+sw9Id69uF?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98612187-8bf6-4966-d541-08dbeb4ed6f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:25.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3D8cdaEoMaxaUCQ/HMGd1tvuFbItOMMl9BDNWkOPZ6CqZUJ1gvA6dmIiBEIsUE2Y/IqjKrnS01rYFh9j/B3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

This patch prints out TEST_COUNT for every tests in script
mptcp_connect.sh. The output looks like:

 01 New MPTCP socket can be blocked via sysctl                        [ OK ]
 INFO: validating network environment with pings
 02 ping tests							      [ OK ]
 INFO: Using loss of 0.16% delay 25 ms reorder 97% 63% with delay 6ms on ns3eth4
 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration   116ms) [ OK ]
 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration    33ms) [ OK ]
 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration    25ms) [ OK ]
 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration   128ms) [ OK ]
 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration    31ms) [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 560eadc1de85..f4f7112a06bd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -267,7 +267,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	TEST_COUNT=$((TEST_COUNT+1))
+	echo -n -e "0${TEST_COUNT} New MPTCP socket can be blocked via sysctl\t\t"
 	mptcp_lib_print_ok "\t\t   [ OK ]"
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
@@ -840,6 +846,9 @@ done
 mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
+TEST_COUNT=$((TEST_COUNT+1))
+echo -n -e "0${TEST_COUNT} ping tests\t\t"
+mptcp_lib_print_ok "\t\t\t\t\t\t   [ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
-- 
2.35.3

