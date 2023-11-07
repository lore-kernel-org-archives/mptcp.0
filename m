Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A62595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="q896oLBV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kONUMccUaatsagA3po+KphKVonlCb111446FbAfqsR8XMDrZ5FaxyBTjxLpD1/eBOnOGzLArPjXmreX2D1T9TjGGIYgMYI0j0sLHywocR8rIyHFbmaazm4sEQfAIKKy1KrcTKlRhPwuYEvJMwUDjcMav6/cWcy5DE1WjV9OyXYfbmqV90P1YY4xCCQP1otny7kWsNl+ArDcsfYi6lxe3ZhN93rqs2xjzwR1uoni4BaOX2Ui22XhuRAyXoYDmkV/Ln9AH9q381awxOBj9/EjX92V5cfzxYhFAut6qHKIggNJeigtXW3x8NI2+x3H9XL89J3OZpi8rHUdKWazKYVULJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XWVdS4WMVaWZ4WA1qkFSXtjr+/dygOEsK/fiy/+8Y0=;
 b=KRmoPRvbMFvrAuwpBy9P/5fKbCZOOwZv3UQJt30RYB9ZxRvss1ZHTfemiVMnk9ahuFzm0l3lGb5u+7wCoYHZQ24g3sK1enApE+xlcLHEsq928mND/Vd9Wmy7moRKIf20gVVaRDcQ4WhtEaOC3kGGkAgmYFfsPEyovI8DAISpu6TpdFKrzJSN4OShRXI0blgVhA7/pLWc+gro9SDt3ZjGcwL6cKqpNHd72gkPTfPGB1JXr8sA6oOI8Jo+3Fxw1SiXExqcqmNCFna/XNqHUT+E7cbPvd2SWu8blE4gUsM8d9s96M/9dyUyduLWlTKvE7wSTywyNIkKOeWMOc3hY9+KUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XWVdS4WMVaWZ4WA1qkFSXtjr+/dygOEsK/fiy/+8Y0=;
 b=q896oLBVaSj99nKQypbQd6ulInahjm5ADdFbA7pU6eZuX5wDIlAR7+vD21t6NpK6kvdoV9/M2uCW5JMb87R3z1mrPC+k0fdb8yXfZIaAZfHsYA75CZXO2ga/GPTv9Ej2gBe1tTPAAhSp4aqUhffG2t5qKRG3WCobnT98OltpebqknEq6lgR837eHzk+rjvDE7ES9WP+cQhao0deZdAB/cPBP71uyFvlAq/s/NM/zX9JPRtSr7MepZx7SXiFfeMbWDYQEkV2qs/qdwT6Hnzmk3GXVyvWUPiri3qj1dKPzXVLxfVeB3jxaVvoDpJyJTm7pncww7H0/5XLXd2eGDMRPfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Tue, 7 Nov
 2023 08:16:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 19/20] selftests: mptcp: export event macros in mptcp_lib
Date: Tue,  7 Nov 2023 16:14:25 +0800
Message-Id: <0ac7527203cd9809e661981f29bbb55704de8a07.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10023:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3f99a8-d4d1-48fa-900d-08dbdf69db23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LtPYQWz3VWPqW/PQrN6CAcFtlixB72xU+QQE3UD0+ZQepLDkfi8vztpHijDn+JQ/O1H9CEL1FiLmKMxOkef/sNHvJswGyap0T5Lt4fp6/FSssKSG7c9o3I7ZiNE5AaaGu7rN/gyisPKc+49lM0I0ma9WF47ke+PMq9hZMK9nYVr2vkeGkyELLEvhDV2UisI/aUAwbem9HRAUkaHf/6BSa6IAOQfUYvAsP7GI5FLdtZBSbDFbHBI8SB/CuRVbthkrEJc3JF6RKcSE4q0plKaOKzLpaBXOw3ER6vnPX8NafH0RI+z7llOd4mt/gytP8tBDKlEVRsPSR00kTb6xkoknmJmKO8tcbmkYZZQ7wrAcQnpFxv+VOHBS3nTcCGpUgbgyWgie6v1qYuaf8VTjbwGFouUdIHYCWXcOJkALPBtUfr9qc7DKVtIdt7CpLQAdWjpzDE9R6F3GxgJUUV5h145zXbPVyKEzMYQvtDIsFSxzwW/mIieNAxseCwrd+pLV1NqHYgskgJvTcYPaXBooEkLcG8GjVl7iaJwBUIQXcfhlhjAm+lrXh/XwGpY4i1OYAltf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(8936002)(2616005)(107886003)(26005)(6486002)(44832011)(36756003)(8676002)(86362001)(316002)(30864003)(66476007)(4326008)(2906002)(41300700001)(6916009)(5660300002)(66946007)(66556008)(6666004)(6506007)(478600001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4KZvboz7YMACGMn90dLnw0HWVe0iDwJrPDLOZYLR8gukRQVBPuUsJvjdckt?=
 =?us-ascii?Q?IKrgjiiNwBXIyUyAuRhb/M2j40onbTZ3c/XiqzqRZmaoOfh6KJP2+/FltSuZ?=
 =?us-ascii?Q?LBV+9sBDDlDNcM/lZwGZve1oQd7GpB/5cFCSBnI9SEVwIZ00qOFY5NryYMyX?=
 =?us-ascii?Q?WBy4GQuLEkGA3wKBw6yP7qXeYDmFB3DmC1xDlksYpUupTs06hqEo74g7DtOU?=
 =?us-ascii?Q?utUAez739Hze4YLKIOOvPnltShSe/YH5bR3P1T2BYX+S+4LFbncful5TPbk9?=
 =?us-ascii?Q?hiH5zGUAb78WBaJZbW7LbR60+k+hAEFTOjzfPHpAJRPvu1JErYuak4OYtRuM?=
 =?us-ascii?Q?PG3L5mxCAaUMwCm4bGPqZt1Agri+hBR0NSR1sTF0v0iAXXEg9VwDlACCwuqE?=
 =?us-ascii?Q?JTcGdxutBjLcXizAJllU6TEUxxR4uBQvLaic7xaSWz1Fg+LrNqI6YoY2Qrlk?=
 =?us-ascii?Q?HCt3cb3FnDWYB4i/MrTUO4N55lXTbetPT9XWEbS2Shv5agUIV5di30cXzV6r?=
 =?us-ascii?Q?JkoWWWJEAeS8jB/pS5jnLMVqgSUWDxTorlTUyFvnVWEfRKc1En52vMqNAehK?=
 =?us-ascii?Q?PzRK6gMa1PaUy+yT2mvFNzveygfa7YeWzvpB1XInwUO2kurW7k4OP0XY/d7z?=
 =?us-ascii?Q?IHaVV/N15ul+9VYlTrv9z2YID8Wsr1S7HBgkmg/UaXfIB7fz1aHJk1OSct22?=
 =?us-ascii?Q?a4LYCSl/Oj7S9maJf/Kvl0TO+p8iBv6PlKXvLtEL6fp2FRVEhQtUdFYQ2+c2?=
 =?us-ascii?Q?w+KA3I7DhUqg1x2e11BinMmLtBflooThFnI4TT2lVPcY9b+eot/rXtdU6+SV?=
 =?us-ascii?Q?TCfuSCYzXYuQ65Umz3Oi5c34ctZmmQsTtOo6dOQ1Mu3hoJ95XJVKJ7vdEE0e?=
 =?us-ascii?Q?rC0iV4LGkPMz+YAMfEoVg4SQz1q2oaUlXP5jGodcz3d9CyrwMI1VammHYOES?=
 =?us-ascii?Q?/Ye+qvAPERpHODXGDe31kdk5L1P7RxUFNk/g77g1HPG1koWKF+rpA6UObp9+?=
 =?us-ascii?Q?0Vh93uZRp0mls+8W5OjRmoW07K9AwXTnn0/sloBRGUVcysmMfNeURcrMUDb0?=
 =?us-ascii?Q?FJ7QxQu4s/2dHNRa87aCaTTYjiSL+omSpP0gvqN5q5p8GTd8Sdio7IaLTt3G?=
 =?us-ascii?Q?PEE2IqD/4bhKcWTdlZMEE3D81uR5KYL/6hxPTlpxEoV5gCZjErNuGrHPySls?=
 =?us-ascii?Q?iyq1varzxgjhDcKq5r16aB3ginoST0T6iNFg6WhxVwfheYmaHuC1FjcZxdFH?=
 =?us-ascii?Q?M2AocVuug15TJWRKOIEWe147XOQ7OLN+sfD5eJ9sIYcStmnoRsSD8HjjJVdl?=
 =?us-ascii?Q?g5lFWZ3W8b9AvlEErvz/VzqVkV7ZMxokBHk+gabarFiJIBkKvnIEpVCin+sV?=
 =?us-ascii?Q?0Vv1IQRTVe4FBz2fmAjmyc4fcxeECHHC0W/+FE1D77rsb7ZuxJSA441Cn9ai?=
 =?us-ascii?Q?FWr3gDfRdbpoAEL0IC/aNKTAWYbSs98zcFk3d3XMJHls+aNoF/KVOnOj4qFb?=
 =?us-ascii?Q?RYKSGWh0e8Ceez/iYj+Y4YqsX5o3h6s9Pj9ZfkD/kQX/Ipg3HzNAnkV/x2B5?=
 =?us-ascii?Q?4Q9l1lriHYWhoF+b/zc9EgAqMXhtsAOJBgPsHAKw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f99a8-d4d1-48fa-900d-08dbdf69db23
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:34.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVh6BOrsHX1EzNeQGZ5t6td1Rl3DwHEKPwZcgVWh5mMBJFACJpXx/nrUOJYT535j6utjrLCuKFgKwog40Q9FGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023

SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED AF_INET and AF_INET6
are defined in both mptcp_join.sh and userspace_pm.sh, export them into
mptcp_lib.sh. Add MPTCP_LIB_ prefix for the first three and add readonly
for the last two.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  7 +++
 .../selftests/net/mptcp/userspace_pm.sh       | 60 +++++++++----------
 3 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 634b51e40435..f922d32f4f20 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2777,13 +2777,6 @@ backup_tests()
 	fi
 }
 
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 verify_listener_events()
 {
 	local evt=$1
@@ -2797,9 +2790,9 @@ verify_listener_events()
 	local sport
 	local name
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
@@ -2866,8 +2859,10 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $server_evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $server_evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CREATED \
+				       $AF_INET 10.0.2.1 10100
+		verify_listener_events $server_evts $MPTCP_LIB_LISTENER_CLOSED \
+				       $AF_INET 10.0.2.1 10100
 		mptcp_lib_evts_kill
 	fi
 
@@ -3396,7 +3391,7 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3419,7 +3414,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 980ef3dbb6ab..ffd78187237b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,13 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+MPTCP_LIB_SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+MPTCP_LIB_LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+readonly AF_INET=2
+readonly AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 34344c481046..024043a00518 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -25,13 +25,7 @@ fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
 
 file=""
 client4_pid=0
@@ -525,7 +519,7 @@ verify_subflow_events()
 
 	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
-	if [ "$e_type" = "$SUB_ESTABLISHED" ]
+	if [ "$e_type" = "$MPTCP_LIB_SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
@@ -582,14 +576,15 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
 	   rport "$client4_port" token "$server4_token"
 	sleep 0.5
-	verify_subflow_events $server_evts $SUB_ESTABLISHED $server4_token $AF_INET "10.0.2.1" \
-			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events $server_evts $MPTCP_LIB_SUB_ESTABLISHED $server4_token \
+			      $AF_INET "10.0.2.1" "10.0.2.2" "$client4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
 	local sport
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -620,14 +615,14 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
-			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
-			      "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$server6_token" \
+			      "$AF_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" \
+			      "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
@@ -659,14 +654,14 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
-			      "10.0.2.1" "10.0.2.2" "$new4_port" "23"\
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" \
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -698,13 +693,13 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events $client_evts $SUB_ESTABLISHED $client4_token $AF_INET "10.0.2.2"\
-			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events $client_evts $MPTCP_LIB_SUB_ESTABLISHED $client4_token $AF_INET \
+			      "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -735,7 +730,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -743,7 +738,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -774,13 +769,14 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
-			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -819,14 +815,14 @@ test_subflows_v4_v6_mix()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -886,9 +882,9 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
@@ -923,7 +919,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -939,7 +936,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

