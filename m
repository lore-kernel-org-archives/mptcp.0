Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A25692
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eO+i8XhZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbkwPonY8i/zUDgtmQe6WHL/IzdovYRWiuVaQn2tK2zDI9GHyP2wavlCWlbLCD5y1w7fnwE5JjhjuwTN/mJ2a13fMK5oOruNjYXdPeYdfkWWgChFHNppuBILtrL7NDOJLmjGeIbTnYPNYbcAQ08l/KhcDP+/Zl6WGaRgI03ORGBEMT5AhgS210keK9HxXSNG8Cf7KHyqoPFvH3FHtfGRkLuJ0ra+VmP7awY2BUMwrTKcpPQ0YrOvpvUnmQBY5nOcvwC9qRGE2slZrFEsyx1M52NLcdb/Ba/SjKef0chYwVQHUD5gPaGhApdc+DJdLGKPLDXsFeOoV4BEULfkyEnDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NKQTbcBrvfmBr6FCHfhC55/4LoO7yq1uI0Isga9VEo=;
 b=WEhTXr+XP2R1EcIzM4ixPR8WZHeGctBr8/+21dl9YLhidvpksCvkypJprjIa/Dh9fiyuJGp713yb43vyK+3RwX4W6SEhHv2ATkN7CkLysu6KEt4gBoKr+fBeqvN430VIcbUrpOBH5f3OGNr5ft8JSwp8QQRGvq2DvZIV493GMwcx3G9001U5vRNP0KFWBE1+s54511m9pFf3l3DKZapEhTWM5p9eJ8nTEBcNaHR5s0hEoVNwY1xPWq+dXFyXGrWRgO5C9ldVI5ZfS5U652weNhTtypEt2vEF2T3mVosTgvZhWZyCCOAc3b51ULSYeG84lg/E3OLH0F9jeBLgSwVmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NKQTbcBrvfmBr6FCHfhC55/4LoO7yq1uI0Isga9VEo=;
 b=eO+i8XhZEZhmggpSCwlGDPEvn6+qBtugjAhgbZTy2JBW7eTMnY3GZfzPYdZ4vHBv8Y3Ip0tAhzF1jaDnFqwjE+xkx2mk4x7Kx51BAHX0XoueDFTT5AGQW10/iwm5aadDZZzQ7lTzgFEayuv8XD8dUy2jfzMVTz+jbmrUaKHc7xHSwIrvegVsXcXfK4i/B4cbB9yPTHhUlFSgNY8LKuWn0ZZrrSvqacGiuo6MnjdJD0qhDTrwZPd9y4hmK3Sot9R6/Gup5/FEgJziVCDX0aznKjZLadXTklcRy/kfIXwD6RUHXbezf9Ols5s1i+yGNS2oQ67c9UleRZrI8CmoRDoHkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:43:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/7] selftests: mptcp: add mptcp_lib_kill_wait
Date: Fri, 13 Oct 2023 15:44:31 +0800
Message-Id: <dcb368bfc9eae9a1e67612aa7229f25c69fb7f0c.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b991c8-a9e6-483b-d141-08dbcbc015de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o0v34OMLb/Rstz3BwDmuPg6/2dhex5LNf3fGxRQKHbHgpjxmK11TNvhIi8CiPnVeJFJtayobwAtHoa9f75FygQdAoZHuLLw1rHI3xaqm4gcWuI1dF4if3nF+2/r4d3rNIZfC0KBQ/WW61brSoTGfceinOlJwntM/DKVAeuLaZMZo7SVwIwCkCAxm2mNfgwFQ7zC3D6MMwVGugtjBKX5+97BKzqNf6PLk6k5+Zoc3qfXqdb8pV4tUopugmXkN0W3+O7zxJv7DQuvcQFclUsUkXFX286DgEPaZlvN+792Yz5DolIIj9S2RHOP9YDKLPN7EYeWSF9SqPIBkKiVYLggrC5go4yv8RJQOXShfsAfHnAa7ImNTt378e/1VxoL4hZbnzFDcV0PW8+22EVgU4YgS8NfmSFhbjO8qe4FXdEpvOwfBWtLh1oUJmxiDpqSh+bIv7AqBnmwP/dvWl97waaRnftc/6DzEWaGOBOSeTzn1wfwImv02wL5Z+lWnvNW7gr+5bhIz45TGeE5scoqtFuv0nnBFAGgPc8ppgQilD+BwwZlEYt4CHRpoevIUT5N4dMLUuGXWqJueiqDQyiql1ghJdGBw3EmUmAfy1n5CxadmNP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(107886003)(66946007)(6916009)(41300700001)(2616005)(66476007)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3W7uXaMoUWAyqjqUl8RyMIUm8xpEAh50Pxlt3KlhrG0jZizRvNf8JLdZdRrT?=
 =?us-ascii?Q?ueu0+a5v2NaRRG3f+oaLQGCowvJpZfVJ7ZZWo4JQPM2uJYrGgEPmefXeqePW?=
 =?us-ascii?Q?IGqmAemSt/Br2yz57Mwz3tnxGCPfAEkZN21W1D3qcR/2BFyJoTrMMqGW/m1r?=
 =?us-ascii?Q?UjBUjcxT+0VDScjVQF3jLzqlK5km4pb6mzNpj+HHLNalKttgPTy0GGa3NYav?=
 =?us-ascii?Q?jQuIlYJTyI/HCsVHUECiGOVpNWOPxNT+an6w4rNogD2/Vycljf656XdjrVPx?=
 =?us-ascii?Q?dzFrz/n9itUFxjj4q0YoE+rRiAKJlbnPV41qrAlczTQzvAGknUSJsjr9qV6B?=
 =?us-ascii?Q?Ma4IMRUUcvGvB3R0ayiJjg5l60YpVSawQy0FDEa4cieQzGeS+RD7luv1SWFw?=
 =?us-ascii?Q?trTdhD9B2qRitr32e374sm/8SM0MyTRIIS/aWD6hJiqOKZZbi6MYF8h5trm2?=
 =?us-ascii?Q?ofA/nizqkzSjlSqUBf0JkWIaceTWI0NDRZflD3BXjKaNRgWZ5yyPFZ1PperT?=
 =?us-ascii?Q?FB2+cvTs+rYLQgeUWth30gXWY6uYjwmkR2XuMfOsksfgPlwIEEIgBgfgVnlC?=
 =?us-ascii?Q?AYZrMA/Ie3MXjix0+GuHhpe8G+frUs0fmgekHKpg3Rq3DBBK8TEhqO/ybMAV?=
 =?us-ascii?Q?CxSWiLnB1gYCS2XYCDUwTiGyH8jsXLBceRK9kgR8qB7LxUeeJ0rlhmStExZn?=
 =?us-ascii?Q?YW23nMOnTqfOcrLNnUjudEfOSk67fPnk0bDOdW1oC6nvxnpSiOp8qPNUc0I+?=
 =?us-ascii?Q?0pUJRlrsvw1muq5KC9Z3uRmkCm4xVkWFxUH3WT1jFxfBVjqyw1c3u5szVLy8?=
 =?us-ascii?Q?yh8BWPYDykT6wxTqB0SvS3DPahAwy7nDHO/hrBGyWyNOvKtehRq26mrnxgJq?=
 =?us-ascii?Q?pTzevQB86dfU6iMW4FzWuF8yld87erH1EpRRaL5KkSKqeGaHPDzUBukKGmb5?=
 =?us-ascii?Q?Pput4MmcDYGKjiHz/iOLQ8RGCzvKFyurutBROur0C6cvYLUJfIJlIGT9Fhc9?=
 =?us-ascii?Q?8mCXHlbFnKH9a17NVOfm6tfl4hgw7DCmGTC7itgVvch9dmu4CA9iq9qOeIGm?=
 =?us-ascii?Q?3xhnOh7JjTPowTeD8LsNDDV9AevDaXSINS5yiuD62gDasa2MfGfjvVbevLK7?=
 =?us-ascii?Q?LS85mILIWuYxGhG08D4q6ao3DusljydMoDzAMDb71tHOm/IYbhVtonSdbT5d?=
 =?us-ascii?Q?TnfRluxmUdXQA8afw7FbPldsONwBvQ/Cq8dI44nuTUf/vvY1DPzDrd92FpSc?=
 =?us-ascii?Q?3RAYYONx1TRDmq7w5cBThLe5jhX5LGGhK4W/JtzcN9maAuUVbZKboPKqrwRJ?=
 =?us-ascii?Q?GK5fdfHHW1wG/2qTYBvLw0mUDULaaMBRnatWA2Im9EmlPPpqDQg1MqRT1uHQ?=
 =?us-ascii?Q?jMme05Q2Gf8+WJ8qgHS4jwcBp15K5fywbzSD5IBo+T7UTK1703GHUKLigtZW?=
 =?us-ascii?Q?gWN8rEGdf8DnVfc6Ryemd16FETODkBBQlrkIWd+7l51OgL8tf3ry4MYuAv+3?=
 =?us-ascii?Q?JVIK47ZoesN9swhQPUs+mxZt7iIPJaNYaJ8BosMM9p4HjfIkNnG0y321SEws?=
 =?us-ascii?Q?xG1j2np00pVculdDeI9efIdVqKP0njvuucRWANog?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b991c8-a9e6-483b-d141-08dbcbc015de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:26.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd0gFgeD+aAhn9EDlP/c4pPOKoXB4L8PrgutUMVMbF/p8rcbXLNb8sEBld2Ps4gGd/vC/js3HVNV9mM7a2Y3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

Export kill_wait() helper in userspace_pm.sh into mptcp_lib.sh and
rename it as mptcp_lib_kill_wait(). It can be used to instead of
kill_wait() in mptcp_join.sh. Use the new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 ++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  9 ++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++------------
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d2015f16028..46dd7b1b6872 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -682,16 +682,10 @@ wait_mpj()
 	done
 }
 
-kill_wait()
-{
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 kill_events_pids()
 {
-	kill_wait $evts_ns1_pid
-	kill_wait $evts_ns2_pid
+	mptcp_lib_kill_wait $evts_ns1_pid
+	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
 kill_tests_wait()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index def35395a254..692a73252830 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -217,3 +217,12 @@ mptcp_lib_get_info_value() {
 mptcp_lib_evts_get_info() {
 	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
+
+# $1: PID
+mptcp_lib_kill_wait() {
+	[ "${1}" -eq 0 ] && return 0
+
+	kill -SIGUSR1 "${1}" > /dev/null 2>&1
+	kill "${1}" > /dev/null 2>&1
+	wait "${1}" 2>/dev/null
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2413059a42e5..f4e352494f05 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -108,15 +108,6 @@ test_fail()
 	mptcp_lib_result_fail "${test_name}"
 }
 
-kill_wait()
-{
-	[ $1 -eq 0 ] && return 0
-
-	kill -SIGUSR1 $1 > /dev/null 2>&1
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 # This function is used in the cleanup trap
 #shellcheck disable=SC2317
 cleanup()
@@ -128,7 +119,7 @@ cleanup()
 	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
 		   $server_evts_pid $client_evts_pid
 	do
-		kill_wait $pid
+		mptcp_lib_kill_wait $pid
 	done
 
 	local netns
@@ -210,7 +201,7 @@ make_connection()
 	fi
 	:>"$client_evts"
 	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
+		mptcp_lib_kill_wait $client_evts_pid
 	fi
 	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
 	client_evts_pid=$!
@@ -219,7 +210,7 @@ make_connection()
 	fi
 	:>"$server_evts"
 	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
+		mptcp_lib_kill_wait $server_evts_pid
 	fi
 	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
 	server_evts_pid=$!
@@ -624,7 +615,7 @@ test_subflows()
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	local sport
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
@@ -663,7 +654,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -702,7 +693,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -740,7 +731,7 @@ test_subflows()
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -779,7 +770,7 @@ test_subflows()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -816,7 +807,7 @@ test_subflows()
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -862,7 +853,7 @@ test_subflows_v4_v6_mix()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -974,7 +965,7 @@ test_listener()
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
-- 
2.35.3

