Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9A16412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3Woyv2le"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpDeVbG8XOvT8k9leYHtE68BU4Ex9RXx9F70CY1EJGtB74nBhHqwP35fJxixUanzImRlEt2hQ9r2J8SKosyq49a66efQSUcZf0JPAysCzv8Qk25lBhfV++XeMTbpLBFl4sTPd+2Ep9TnSZTpPHTCf6q6IX2featkR32ey1Pqzradg+h3gwMF7NsTkTq/C3bc7+Cx02SZagdLv34G9pD7+AaNjI7m7UcfoF92kp+U/XaD25QVdpb5emeZelRtXlUphK2EOlxf2dPBL8eJjhkFxGpl0Ev0d6Gw++GhUyRpj5b+qH0zy8HZS1xC4keuZ5G8eo73qQNLfsw+ZbGIYxYFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/DzQHWnLi1Pc8Ohf67nCSZUKw9WMTLckVkpqgDw720=;
 b=bwo5J4h4+HzDRyBg3e/IWeXsez6dXaSaPauwD9upSfsdsf3hic4ASRlKjRSTh0wFL2X0TzKkJ5a2yMXIf5H2v29qBmDK3qjRKSkLYXeqrYjIrOfA9cbz31B1ApFTJ4rApZkKKK9JvsVwW7Z0yISVA4vo+cfJQquzm2wTYWXT2kVgKgv0JI548uopU9OMLNhMoewGCmnBMb+VTVfRIU8V7yP8xb/Yhy2eieJK1KsNmF1+7I6T8TIB5XZnUEIN5Vjda620H0MQ/k4jGQWGm7VbY02Yi1l7WjG0YzTcc+5Yp/E2+PUzQvsoKwLnRnRF7lQ2kb6kze6aA6+Qw/9qTxnxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/DzQHWnLi1Pc8Ohf67nCSZUKw9WMTLckVkpqgDw720=;
 b=3Woyv2le2GWzdSBB2gHliTyDgOfdn23dZI9S5o6MYswebUXrAXK6IGxmSmqHkWAnwlTCTJtppjj0gv87/iOKfHcYQJyPU74oClyD8EXWLIONW5dy2QZsycEJL3uGupGgPgKn1EDgKyn/pomokqqFVvA3ph5JygV2gH5G/Mc/JGYsWqaTgBzz5iQyy9viNrFeP0kTZ0nl4kW9k1y0i9uRmIoxAqtweq4VgtWcr5mPQs0eczpRXKuG9QrH2sYVYao0K3VFcZ+Ni0oGyBXOTlh5nT5iUvJrXPXHnw/huCQCemaZFMJ7pApb+DNwuKDFVyWQDxqA05xrARAc8+iYV13+3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 08/33] selftests: mptcp: export event macros in mptcp_lib
Date: Tue, 14 Nov 2023 18:21:38 +0800
Message-Id: <b6e012244e9c1ee39a6c80c2539617915b869263.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0111.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 171fd931-d072-4c0e-9ed2-08dbe4fba498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xxT+4roLn5daRcs5TNGFcAEKwqWmZdh7qg+i41eUWOM2qPFULawlk48MnzFXk+xJC+uWYuyqBcoIJIjKpglptHq7XxkbFVk3sbkpY1L3xZmBQGzMYnuXv855U7pE1zjIh/m5xIPQe3W4b2mrrbJ/OMDsbAObbFd1lM1raSAPqpFOxTAtK0AarymE/zWXdIIgI18uVW1SfvuEpsQa8WQQBxV2GOzmNHUjZ+6qFPnsloAa+bOBZR7tGqhw/yIlH+xJ4JHHNag7BODhyF1FnFUupbxsShhAb4BrGfSFTX4YFi30/6AOOJO7Io3oInO1GVAdQI3krQBASS9N7y8s/vYkrhJezOVRWhj8oTWcZuEE1ITiWTj3Gh5XcawKEFhfevbVdQwDyW0fvMWTImy6tLEzcqu1w6ym7rf++V+MouBoofmZeAhMpAqG7jOcN72lC5/0lxSbbbb3uAC5ZOwiJ0xoZuBON0XX0PVXgWL0g+iSKfX0rWlVav4PIkwUL1/r+XZjjtfC9uoE09Y4WSPe78o8ghH/pU87aAsN1tHGqlnRrRBXIPIARInP0qibczydyYKX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(30864003)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZRWvAbbLqz/2oe07uuXsCbqJLcCNEROX+ptPGP7MpGAGrJqqyfw26e2y+C4d?=
 =?us-ascii?Q?ke7ac0Fr0zoAjC2fvc8lc6ony5tBTRU83OczoGQaAYSz3QmL0xWD7EdWpAvd?=
 =?us-ascii?Q?DtsVmQ7f8z7gNuRMG/jzWMUmDVhe+JQSGTnd9T75B54ThEbijVMx6j/5ytWX?=
 =?us-ascii?Q?UkX+Nu/X+R1AsIrBDmN4cDZOEc8MpxGAe/vOZhjscdA0cgjRh46LEAXpEUBc?=
 =?us-ascii?Q?arIWu+HIynseWS/LJ79+WeroeYR4jAKgMqn3sghxO+2CLIe6v1qdoC+hd0pD?=
 =?us-ascii?Q?PHzxVaAIa5qljPTiijRjlokLBMqc8Xi0E8S7YwSILmxQNEgHqEttQHylVCLv?=
 =?us-ascii?Q?zdF9+LOhAGJ67kuuL+pyW2UeK5kiyVLDoit32vh9EPO1q4SD9ed1wGAYTYsh?=
 =?us-ascii?Q?MNrzl9TbuP2vV3kx2Er5KaIFxJkFJxqBBIAgXeucP9Q6J4QxXjbRf9gW6a5h?=
 =?us-ascii?Q?q54REj9+bsr+j4PAmIR9v5GLvQLtx0uWb7GZI7tdUr+d6T4LR3E1CMr7FwuU?=
 =?us-ascii?Q?SBDGR3gAfxPbEcSf6wFyHxoQOGvR27KwD7L8WJdarOq7/pggXYL9p1OViEKO?=
 =?us-ascii?Q?8vSUI1yGyGb1Wz1OaKaTAH0jFvlcbbPVnv8iRQt4LzfUJDq4cT6lAjNnjaeu?=
 =?us-ascii?Q?/PHRzNSdHwDvhhhrPwRQ6RPm+YS3yIb7ApDlnB7XAyvEBHvfM1K2FAT5Jc5s?=
 =?us-ascii?Q?n6PaG99EISf5jun+vRqdAh4nuE2yyGIR804KPCJ8GGiJoyPfvDHHdHKK4tY0?=
 =?us-ascii?Q?k2M8a4o7vgs7vNrM9FcxatQrG65X0iY9WRefSdjgJ0WDVKtZYKgHLq7VWbps?=
 =?us-ascii?Q?QvZ6Q0JUbxqh5wzszcYhMh9njsG+M4uzCekweo+uXccQZHt0KI+CSaH78nd5?=
 =?us-ascii?Q?Tzi/Ewrk0Ioq8VxumyiTe43aiji8Rr48yGkr6+nRIww7TzEgXOVS5Q55WE2j?=
 =?us-ascii?Q?QAdJ/TVC1K9A232kQRgk0/MmU6M5dVLJdG+nEtvAMqkQYph+xLXA144RAbKO?=
 =?us-ascii?Q?W1IK2E82NJKuNb6ds4LGkgox2RPsCn3KnaiJVQESVlCYW0bmKoEq4jj8EHzS?=
 =?us-ascii?Q?PNJZySmp9R9HWTDw2C8g90UNZDHg/10E8MIFk2AP+zq6/mz5AY7mTPNsf9MW?=
 =?us-ascii?Q?PisCvzfFMJ1mIyblyqLJpIB1MgT0JNrVruvn2OG55UwWtYVy51kF8gGS8gKT?=
 =?us-ascii?Q?qBnEn6/81BamHcP7VhNI1Et6THa5Ov5RyA4yF2L60RpXIZelLjHNIC69VsbJ?=
 =?us-ascii?Q?r1qTi3KhHGQWAuqo4EIix3wQmb+MCT/M7AYnQFKFUiOL6gvHsghpA2WO4UO9?=
 =?us-ascii?Q?hauVMrYYy28E3I1AdRT7qFc8kwt++9qrEFTHahFzZJhnM2R0VazbFZ0fm6TY?=
 =?us-ascii?Q?qMn1UIIh1KIPYzSKY7dXdISRsO1T3MAOONZXzcDlcDNcxbEYflSL0q0xHpGk?=
 =?us-ascii?Q?wfexXaVJmvRnTiRHULTcLgSL/se+uxrOtGIiQN8A1qgppyhncASbtXT1GRD7?=
 =?us-ascii?Q?MXysjejsVCAyfJH5aF8mn824GwIr426mMVJrYwcu10B6vezxCEJuUSOT2ony?=
 =?us-ascii?Q?ocxIhnA0MSTUqThQ73iirFv+ThBaUXX9YKbrH9xqiFrf/1fzjFU1+sMFpVEc?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171fd931-d072-4c0e-9ed2-08dbe4fba498
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:45.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQzCTPZvjijEgZLVmGXj7ICpfOAH+cUdTudrB9/i6XfvhM83li9pHfvh4ae9IaEjUERYRKA8YULBOds2u9Anog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED, AF_INET and AF_INET6
are defined in both mptcp_join.sh and userspace_pm.sh, export all event
macros into mptcp_lib.sh. Add MPTCP_LIB_ prefix for the first three and
add readonly for the last two.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  21 ++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  10 ++
 .../selftests/net/mptcp/userspace_pm.sh       | 121 +++++++++---------
 3 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1ba49a668eb1..1c3df7831855 100755
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
 
@@ -3397,7 +3392,7 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local rm_addr="userspace_pm_rm_addr $ns1 10"
-		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $MPTCP_LIB_SUB_ESTABLISHED"
 		if [ $((RANDOM%2)) -eq 0 ]; then
 			$($rm_addr); $($rm_sf)
 		else
@@ -3426,7 +3421,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3d23783dc307..accd3a62832e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,6 +10,16 @@ readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 ret=0
 
+MPTCP_LIB_ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
+MPTCP_LIB_REMOVED=7          # MPTCP_EVENT_REMOVED
+MPTCP_LIB_SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+MPTCP_LIB_SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+MPTCP_LIB_LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+readonly AF_INET=2
+readonly AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index a85eb83a61f8..2e9fba4e07ac 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -23,16 +23,6 @@ if ! ip -Version &> /dev/null; then
 	exit ${KSFT_SKIP}
 fi
 
-ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
-REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 file=""
 client4_pid=0
 server4_pid=0
@@ -306,8 +296,8 @@ test_announce()
 	   ns2eth1
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
-	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
-			      "$client4_port"
+	verify_announce_event $server_evts $MPTCP_LIB_ANNOUNCED $server4_token \
+			      "10.0.2.2" $client_addr_id "$client4_port"
 
 	# ADD_ADDR6 from the client to server machine reusing the subflow port
 	:>"$server_evts"
@@ -315,8 +305,8 @@ test_announce()
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
 	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
-	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
-			      "$client_addr_id" "$client6_port" "v6"
+	verify_announce_event "$server_evts" "$MPTCP_LIB_ANNOUNCED" "$server6_token" \
+			      "dead:beef:2::2" "$client_addr_id" "$client6_port" "v6"
 
 	# ADD_ADDR from the client to server machine using a new port
 	:>"$server_evts"
@@ -325,7 +315,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 port $new4_port
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
-	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
+	verify_announce_event "$server_evts" "$MPTCP_LIB_ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
 
 	# Capture events on the network namespace running the client
@@ -336,7 +326,7 @@ test_announce()
 	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
 
 	# ADD_ADDR6 from the server to client machine reusing the subflow port
@@ -345,8 +335,8 @@ test_announce()
 	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
-			      "$server_addr_id" "$app6_port" "v6"
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client6_token" \
+			      "dead:beef:2::1" "$server_addr_id" "$app6_port" "v6"
 
 	# ADD_ADDR from the server to client machine using a new port
 	:>"$client_evts"
@@ -355,7 +345,7 @@ test_announce()
 	   $server_addr_id dev ns1eth2 port $new4_port
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
 }
 
@@ -416,7 +406,7 @@ test_remove()
 	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$MPTCP_LIB_REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR from the client to server machine
 	:>"$server_evts"
@@ -425,7 +415,7 @@ test_remove()
 	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$MPTCP_LIB_REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR6 from the client to server machine
 	:>"$server_evts"
@@ -433,7 +423,7 @@ test_remove()
 	   $client_addr_id
 	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$MPTCP_LIB_REMOVED" "$server6_token" "$client_addr_id"
 
 	# Capture events on the network namespace running the client
 	:>"$client_evts"
@@ -443,7 +433,7 @@ test_remove()
 	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$MPTCP_LIB_REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR from the server to client machine
 	:>"$client_evts"
@@ -452,7 +442,7 @@ test_remove()
 	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$MPTCP_LIB_REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR6 from the server to client machine
 	:>"$client_evts"
@@ -460,7 +450,7 @@ test_remove()
 	   $server_addr_id
 	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$MPTCP_LIB_REMOVED" "$client6_token" "$server_addr_id"
 }
 
 verify_subflow_events()
@@ -489,7 +479,7 @@ verify_subflow_events()
 
 	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
-	if [ "$e_type" = "$SUB_ESTABLISHED" ]
+	if [ "$e_type" = "$MPTCP_LIB_SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
@@ -546,22 +536,24 @@ test_subflows()
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
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   "$client4_port" token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
-			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_CLOSED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$client4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
@@ -584,21 +576,21 @@ test_subflows()
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
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
@@ -623,22 +615,23 @@ test_subflows()
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
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
-			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_CLOSED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
@@ -662,21 +655,22 @@ test_subflows()
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
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
-			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_CLOSED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
@@ -699,7 +693,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -707,15 +701,16 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
-			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events $client_evts $MPTCP_LIB_SUB_CLOSED $client6_token \
+			      $AF_INET6 "dead:beef:2::2" "dead:beef:2::1" "$app6_port" \
+			      "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
@@ -738,21 +733,23 @@ test_subflows()
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
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
-			      "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_CLOSED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
@@ -775,7 +772,7 @@ test_subflows_v4_v6_mix()
 	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
 
 	# CREATE_SUBFLOW from client to server machine
@@ -783,21 +780,21 @@ test_subflows_v4_v6_mix()
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
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client6_token" \
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_CLOSED" "$client6_token" \
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
 
@@ -889,7 +886,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -905,7 +903,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

