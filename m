Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2F20F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK3vs1T2IbQgxJXHmXIsMjoMGp1eQLCcRk6VM1yOwjiR6UzbfKsjkmyBcVIBpe8rgwjEXYQ6GjV03I2O9fp3nuK/M+o1h4sIsBPAFPzlGj3CK7YCx4rDxVQDElCCkXOyu/PjKlCT69K+7eKTnsq82MRnrYPtowuBvFy7rBqHAYa12AcJAcqfDChYfuXfTR8t5biZgpZ8lOPDEw3GFxYvBtOXDsxVHBjBJnh8ygTTBIV+62odgX+cAi+Esa/YbslDMNW95WcCaJg0pBG3O6f7mT4QhAuOjhBU14SM7wummqqBN9fndYFvR13SxLgYmh+5HnbN5gJ88vxLqR8VD+VSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+MVa84P5jiSZ7LZHh/mJVeaE1tfpoHpdixfFBPPHtc=;
 b=gHXxdv2B+kL66axvZXvfAyB9YikH4vcUxBJlEhzUBdi7U1f7VGHlZwyPR4GTiBpX7iTVoO8OW16mHwidBLPZWC901GGF9ofWURenA/llcA412NMbgVf9xqAEfHA4LGysyXgg+chC0KYVQ9tRB2QuqZkEWeSy+6K8nLn1QfOydAIQf9YBXSxMQpL/wf3ItnVMVwvSgc3QSqvp0d6qN+044vQ4s+X7FfCQYnT9U1KSE74wdWbGeatlYBcZkmhRePI2y57sccIhQOu/nxKSOfVno6ZjYwFdZS0tMwif5od9fmiX78dQwCgCel9Po7Rq1Sr/TcQAapkO3zQdrcvJZ43IIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+MVa84P5jiSZ7LZHh/mJVeaE1tfpoHpdixfFBPPHtc=;
 b=gwYEqHWJl97MeEa5+r8+Oo0+j5aigRj/AAlxiFEJ4vsFsCkKm6MXTUuOvJ/syu2Bu1iQOlErpNbmDIO0+GC7dcUTw1lOU08VNfy7g6RPc6DYTNUpkgb3Xatl/CL69BY9xMTZLTiKiTOST0DvZMh7a+odAfPgkdPDoj4aT7vLkcPm0ZwdNJuaEIy5WZAx6zaPgWJIwH2+MGPtFK6hFcTX4rnx6+JY85rlRSncr25r/3ft+sMXTPNJawbrGUytQsYMmfPDOJrFAITG84iTF4yyT8XQewq5eurh90HR0vk+nw9b8QywZNBxeGfP8vmPaOleOlSCerzw/cB10P0tfCyIrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8529.eurprd04.prod.outlook.com (2603:10a6:20b:420::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 07:20:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:20:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 4/7] selftests: mptcp: drop test_linkfail parameter
Date: Mon, 12 Jun 2023 15:19:43 +0800
Message-Id: <f48449370d0fe5de299db3c8ce1f543b7cf85bcf.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 80acfde0-884c-47e9-9cf0-08db6b158a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E3D1hV4KCYuWE5k5BEXI0jmLdbowQYJJjCZ90HAyObYlUzQFFUitcjdH4lAzqlvftNzWyX/arQZ7dR5bvFYsODAXSh49S71bbuo/YZHGhCRiAdTj1L7QaP7o5nefKlt0hjh1la1lffXqwBKaihbbqkTUnaK9gMDcK4VCp9u6ydJpuH3MGQo6J7t8Uaymqz1qgOtNWLCUxp1/FYK5RBVX/VvTs+P1QcTIYyCZFECo3HGdsbayQI7USoL+x5p5coetybSe4Ub+CmEAX+JIh4BSHHtAqpvBUDzkgWHqUBe9OzitchYZVT3WclnV2T2LVjvwjtuW0VYh3TvmEUCMGpeTEvNSoVef55sE4FluE16jylL5Pi5QDUahnh0v6LABVMmooOCnwa8wmObg/oZ5TyBeG7zghBSzexLpxlazRpq3U3W7CCUVt29DzDvSt3vjz3Ooghm70nbDv1T9fAqW9PJF9QcORxWniXThA/XUcHjeTX13NYkArR9x3Kpr7wD67Aswn7QtJItUNTKiqlFCZHTmG/LXnjh+V4l3E3jsdb9bul3/AdvKxwsYS+CuNXecfWS1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(66556008)(316002)(478600001)(41300700001)(66476007)(8676002)(8936002)(66946007)(38100700002)(2616005)(4326008)(186003)(6512007)(6666004)(6486002)(6506007)(26005)(83380400001)(107886003)(30864003)(86362001)(5660300002)(44832011)(2906002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBGlnvqOUkm0ziVeau8DsFAFITusO1D1ced6Y1snMxCs3uAziHAP5QTXCJnb?=
 =?us-ascii?Q?W3raZGEmuhCfIW06m1fS/KdAe+XHPy0qQOyy2ZKbM+gzoJDJeZRnGtDJhss4?=
 =?us-ascii?Q?aeCWQBrQoUZaPshRIolvsBbT5Jd/dGMcmJgs9ZNM7I+3hg2W/02e1JOGWsIi?=
 =?us-ascii?Q?E89w9FPhI/bCeQwR00sojz667yZvusv2H9kyo18AZmEE3XPyUtTbapkqu5+y?=
 =?us-ascii?Q?T/oPNyzW/9Y9Gwkt+5vFc1W0mi+ql3bTI0ljlYNXqKIsp8pEIqejF2Fz/X7m?=
 =?us-ascii?Q?gIjvJbf4Gk9++WXPggbk0IAzKFNcSuk9hlpMGF7emo3Cl/naEaomBquOrhHZ?=
 =?us-ascii?Q?IoWqFz3PbJS/e4Qb92CRcptJ25nerKg7pzxPa6D/fxr0/mf2KRFezMmPw2Nb?=
 =?us-ascii?Q?2FUbiXcRtgTebusWpMp35BLxmVF5w25CednULfLzNWvnT+XYdX8h5JcDr6Qt?=
 =?us-ascii?Q?IXWjxQj0RnCAc+4rPlNpBGyOZFiZcf3adgERQgn/K+EigxfyIegyJomZ1LrV?=
 =?us-ascii?Q?a7xN0VwOMEKkWn4n42vJdWZY9obyPbp4C/4rCyQV8ZEAEFB6QMxLhA6W4bJY?=
 =?us-ascii?Q?HSeEfSBnCPsPP9qyVVCIaYKWb4qupQcEe5LjBC8Bg4e/2QaeDqhyaE3kkLej?=
 =?us-ascii?Q?eI2Ovx3aeHnJ5YQm3r2lV7O3KmbyswU1XkPU0FX+vz5mOE3pNTk6f7y4QrQs?=
 =?us-ascii?Q?47jZXgDdUncC1gI2isadVfWV68ueDZ3wSK1fRA9Iy4GOezDX6616qZ01gSGT?=
 =?us-ascii?Q?62RSG14+a9j7XgNzmgctE4oGCX/lYz0N9waM6ga4lT7G4ePxhTzXBRoDsQXB?=
 =?us-ascii?Q?UbK4JXylthxAoSVJRX4FrRKfKs7uoMe5vdDswUPsDJaBSl+kGDKrJS9myP7v?=
 =?us-ascii?Q?QY8k3gmm2apjiZLEOaFlD1OQIFGiV9I/1z9sW857M5x1OeIVhorrqV3nkqAL?=
 =?us-ascii?Q?OBbJlbQ7GFazIO+9cTr/8ay/gU6ZgEO+nb5z6TYZeCdhhGU6DYZ45pdAwMWt?=
 =?us-ascii?Q?YQqZz9KzWQZxx4TeFt882PTea/H1QmncQrq1NuigufZHxhpuiDfRZS+Re9tv?=
 =?us-ascii?Q?fGq0klC5T5ebIgi2/t/DYWPZkStv+ltS6i/yM29vRl9B5OTkd66n78ENeYQA?=
 =?us-ascii?Q?c+bKQE6F+u84OklcfQOXgtOwVCMQgyjkTRhRhhCrDQR6+886eaQnrB7nx+M8?=
 =?us-ascii?Q?jNbQPV8LmPnKzz4lVNzvDuoQ6i55WmbnPGNpACRarT4xg+oyFUQYkiL6527O?=
 =?us-ascii?Q?ae3Jnw5IfegsVVUQr66Zvexb5YtQBXZb3luerHa1tL4D2vTQM6LoSl+9AKwa?=
 =?us-ascii?Q?+EwydoogKgaFdNY+VwjybmCrd8cucdBrAWzJ0Gwj4E7Rr9JB/jRa795VVLKe?=
 =?us-ascii?Q?viKf7MSyhtfCoW4sIACXgONpD0s3mnsE2bc1vsFlPWFqb86ShCqnWNqsrLzf?=
 =?us-ascii?Q?fFu2vSX/ZP+eDu21VjeaGnOuSWB+1Q7SrR8gJRH1Chg0YjfrHYTO9D7vX9qc?=
 =?us-ascii?Q?/XB/GJ2FmhXJ9fPPjXj506lXCCMbocyJ1gw2qpF+h6Zg4XsPl1qrg5R/Y1ox?=
 =?us-ascii?Q?hhpyYrziHmToZaF3/cfZjv1hDaLKrgrKcpDKOGx9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80acfde0-884c-47e9-9cf0-08db6b158a1e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:20:46.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkHdp1SNuzQUrreK26gGvMs1gjUQ63A+JjNlKLNAIkGoT5WQwVw+JyUAoeUCXzb1re6LZHKnqXntowjzGiI3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8529

This patch switchs to key/value "test_linkfail=*" instead of positional
parameter test_linkfail of do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 179 +++++++++---------
 1 file changed, 89 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1697b0b89d9c..bd23fba70361 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -50,6 +50,7 @@ TEST_NAME=""
 nr_blank=40
 
 export FAILING_LINKS=""
+export test_linkfail=0
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -825,11 +826,10 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
+	local addr_nr_ns1="$6"
+	local addr_nr_ns2="$7"
+	local speed="$8"
+	local sflags="${9}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -874,21 +874,21 @@ do_transfer()
 	local extra_srv_args=""
 	local trunc_size=""
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
-		if [ ${test_link_fail} -le 1 ]; then
-			echo "fastclose tests need test_link_fail argument"
+		if [ ${test_linkfail} -le 1 ]; then
+			echo "fastclose tests need test_linkfail argument"
 			fail_test
 			return 1
 		fi
 
 		# disconnect
-		trunc_size=${test_link_fail}
+		trunc_size=${test_linkfail}
 		local side=${addr_nr_ns2:10}
 
 		if [ ${side} = "client" ]; then
-			extra_cl_args="-f ${test_link_fail}"
+			extra_cl_args="-f ${test_linkfail}"
 			extra_srv_args="-f -1"
 		elif [ ${side} = "server" ]; then
-			extra_srv_args="-f ${test_link_fail}"
+			extra_srv_args="-f ${test_linkfail}"
 			extra_cl_args="-f -1"
 		else
 			echo "wrong/unknown fastclose spec ${side}"
@@ -902,7 +902,7 @@ do_transfer()
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_link_fail" -gt 1 ];then
+	if [ "$test_linkfail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -918,12 +918,12 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
-	if [ "$test_link_fail" -eq 0 ];then
+	if [ "$test_linkfail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_cl_args $connect_addr < "$cin" > "$cout" &
-	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
+	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
@@ -1107,13 +1107,13 @@ do_transfer()
 		return 1
 	fi
 
-	if [ "$test_link_fail" -gt 1 ];then
+	if [ "$test_linkfail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client" $trunc_size
 	else
 		check_transfer $sin $cout "file received by client" $trunc_size
 	fi
 	retc=$?
-	if [ "$test_link_fail" -eq 0 ];then
+	if [ "$test_linkfail" -eq 0 ];then
 		check_transfer $cin $sout "file received by server" $trunc_size
 	else
 		check_transfer $cinsent $sout "file received by server" $trunc_size
@@ -1146,11 +1146,10 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
+	local addr_nr_ns1="${4:-0}"
+	local addr_nr_ns2="${5:-0}"
+	local speed="${6:-fast}"
+	local sflags="${7:-""}"
 
 	local size
 
@@ -1195,7 +1194,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 }
 
 dump_stats()
@@ -1983,7 +1982,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1994,7 +1993,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2005,7 +2004,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2017,7 +2016,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2116,7 +2115,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2148,7 +2147,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1
+		test_linkfail=1 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 5 1
@@ -2163,7 +2162,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 2
+		test_linkfail=2 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 1
@@ -2178,7 +2177,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 2
 		FAILING_LINKS="1"
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 1
+		test_linkfail=1 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_link_usage $ns2 ns2eth3 $cinsent 0
@@ -2193,7 +2192,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 1
+		test_linkfail=1 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 2 4 2
@@ -2209,7 +2208,7 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 2
+		test_linkfail=2 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 2
@@ -2224,7 +2223,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2235,7 +2234,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2246,7 +2245,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2257,7 +2256,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2270,7 +2269,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2282,7 +2281,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -2 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2292,7 +2291,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2304,7 +2303,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2317,7 +2316,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 -1 -2 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2330,7 +2329,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2343,7 +2342,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2356,7 +2355,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2369,7 +2368,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2387,7 +2386,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2400,7 +2399,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2411,7 +2410,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -9 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2421,7 +2420,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -9 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2434,7 +2433,7 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2442,7 +2441,7 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2451,7 +2450,7 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2459,7 +2458,7 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2467,7 +2466,7 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 2 0 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2480,14 +2479,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2497,7 +2496,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2507,7 +2506,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2519,7 +2518,7 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2620,7 +2619,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2630,7 +2629,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2641,7 +2640,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2653,7 +2652,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 fullmesh_1 slow
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2666,7 +2665,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2677,7 +2676,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2689,7 +2688,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2698,7 +2697,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2707,7 +2706,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2715,7 +2714,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2724,7 +2723,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2813,7 +2812,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2829,7 +2828,7 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2842,7 +2841,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -2 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3044,7 +3043,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3056,7 +3055,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3068,7 +3067,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3081,7 +3080,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3092,7 +3091,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3103,7 +3102,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3114,7 +3113,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3126,7 +3125,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3136,14 +3135,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		test_linkfail=1024 run_tests $ns1 $ns2 10.0.1.1 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		test_linkfail=1024 run_tests $ns1 $ns2 10.0.1.1 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3161,7 +3160,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
-		run_tests $ns1 $ns2 10.0.1.1 128
+		test_linkfail=128 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
 		chk_fail_nr 1 -1 invert
 	fi
@@ -3172,7 +3171,7 @@ fail_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
+		test_linkfail=1024 run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
 	fi
 }
@@ -3291,7 +3290,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3304,7 +3303,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3314,7 +3313,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3336,7 +3335,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3361,7 +3360,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3384,7 +3383,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		test_linkfail=4 run_tests $ns1 $ns2 10.0.1.1 0 0 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

