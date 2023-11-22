Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF551035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ixowEIgE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKL8wm3f1dByAz9O238Cr8vOL8mYs+8jVPISLj52RLhTCYDQ5kXT97J7+XvszLPsBUNPeExbYPGuJAjSpVFjHaSCJHk99aMIYG/7+F+vZ/mvcjpW7bptale3Y+HCpXvNxXi4uVktU8MScMe55ltpAx7WDW6vbRf6yvaMjeF5ev/CTS3emU1QJ9FoC/WVH2SONCia8aoO1SRp3KNmd543r/j2c2qxYw8aQ5dm6Ykl3D2bgujfBv4LZtEBdNXgtn+r9tcvmPccc0zR4oyxe2BjBGSoQwcF/83xXx4wqUdsmJ8Z0R8SLB4+96r1ndzTGUXWuVCl7gJ5Nlz7gYqZY1ET0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxxkpHXGWLByg8enzxrX4/nMrdWsQIMahwMBfO3HraA=;
 b=HIDUA2k23qpXQa5WEWEUSy9/p4arfN4xgJElks9oc8rweGiKA7wPcBEdG2fLHVf9EYtnve5FVNsggkV0WTr0hnosC2Sv7n3K0mqPs1oKQyjNBUPLPzlUIOcqSteYAh9ONt64C7St3looX5mHRVv24o31fi5ueO2kNUJvvHkQQqBN4SwOxutrCRjXOb3m6v8m5ot1MO3Q0sye3ZujszY7ckUbP4xIE92dLv1ajMTpXWY1Xs09ezRcg/Tpj1b1GGhHCkSVL+r81ODywOde/BE7BIJott9r7cJr/4xTlgS3QtQX1PJ9fYt+VZDnhQKck7DBW58eNPb5wPd+VPVFghNDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxxkpHXGWLByg8enzxrX4/nMrdWsQIMahwMBfO3HraA=;
 b=ixowEIgEZTwuKzQBxWXteU7URdl/mMPImiNGWmEvMIN4+cX7oz/sQm4/A9d32yop1G0yqP8ambwHx4E29U6AzReIYBrxDWgsR2U3NHaKXwR85lQ80iR6B4dwDfON9vlcRwIc5Yyw4FgSHPrzCOvHrTdJP6+ojYuuU1Vx7ROsBfo1xlTQifwHZl+z4nEfEhwlQoJp4i/QxwXNDpYdywdOysO29djAtB6D+ilajNjfv2xCcT3E9LlAohQN/65TEfYwM03cFjbTswulJBEhvvXd4hhshV4wL8/IbsUACTFRLmCFwtrmAQS/wSkPqSLa09hXWtqPlu8LVZh+koINtjECMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 08/33] selftests: mptcp: export event macros in mptcp_lib
Date: Wed, 22 Nov 2023 19:30:56 +0800
Message-Id: <8b762eea32de0009ff5a642220658596e6c71979.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 79be013d-0213-491b-0ea2-08dbeb4ea804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iJPGi4UaXfIq7wOVHDFZdEoxXjYpsKkDWG2XdLl18vEhS9rxXssZlpbJ0dmX5rGhbVdoArBYNUhOndmw2y0hxcz7G9rEEtAxqEbHziiosLJA67ClScfxW7mKrbNS4P9llxkQkaWuk/JybtPRSgtBA4uix53WxwIoxGV0hBtUsAz517R+SQICHgCqSEYXds7Amr5U/pen6ard1WzFP1b4OZsH39P1vvyj24ktNqozLMWQMPKWUv0tkNc875gO3pcYKIHprLKMoXMt1tZWYLKNZ6PYkYiLjNfpRVI4ClTcnUxY8Vz7hSYL4N/uciqtbTMekruHRApphe7kulck739oJzO43Ll+fWTuWdSrkGwn5eNN4WAXzpb3vARgd0GwtAeA4j/cQUTIVH26yIYjmWie+AYzfwc4eH5JMpEYdalPUGXb15pEQ6RyN7SwzMr8Iu4z0h9DpiKG2fGdgTH1rwnLAUECaliJfFTSOqExC8hufkIY2sfIbKNxwbaeNi56oZKS4v5gpne0jQxlUxGmSnKax9dMvH+XtDMpxIrz1l4CL9cJqhDDfNc4mG5GV/vlEqXEKR57OYJ4ojnLkOsQZdqFJF3GtTUsfoueWrhGAZts5kQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(30864003)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a14Dp91//NCkxcLfvbGalrPIjMwdbicqyuvgvd8rKl6suVXti62rZpMt8pPf?=
 =?us-ascii?Q?igvkTRVP4qKnM7yorI4/N+JG0Bt2vvoUPjWZ3sZuB4xtN29M7JWY5zYJwnUr?=
 =?us-ascii?Q?/5G3k4XqdYnSUliYQR6D9FCfdK+MFDaODDhUOcDG10sXsiMC85v3LjiiJRd5?=
 =?us-ascii?Q?4/4DagiMVax2/bGkmjTuvspz1ljAXsHqcNuDbHdHjFyLnatRC0y6vhPr/bwH?=
 =?us-ascii?Q?wkTKPQB6SJVXm9ORKhAK5JZLgQGRLE/WuDsIUB6Je4Y8AndEd2h+aXxQbUGh?=
 =?us-ascii?Q?PltGCsRvkWZqo3Q9gBkacmmzO5dMK7+sSa4aD4H7vCQ1F6zoY34pTy+e2U2Y?=
 =?us-ascii?Q?Zv0lT/1ZjeqFVVh13OEdaCLwt3nAWA2FPPE/tfIglpTjkMFlpW95zC8nu9lD?=
 =?us-ascii?Q?aGNKRAVao5EA11fUd3lsJXhHrr7ur6s8Sq0Ox1ZaaM5NgTgBg65GcvWLEtef?=
 =?us-ascii?Q?cV5Zh8Q8NNrmDt1kpfJS97HxkzIMYKI6r3Z+BIVdRP8hB8H0o3qBX8e/KZ0e?=
 =?us-ascii?Q?+VEPwCWqFPjKswMgThXS0h8AxApRYL75NrUdxL41AnkFpPdJ214zGRBGc+I1?=
 =?us-ascii?Q?X5VYCeO8/THRjdYyU+tcpm5tm9RjsTkLP0Kb6OIg564BmQqM7nI17MQyXIM6?=
 =?us-ascii?Q?dTDIEuCjmu/dXZ0SQ2/Z1EG94YepXmOTQtvmnP3MVezJTabIXQAsB5jEcRrm?=
 =?us-ascii?Q?/+H13coaCkDJfmpYuIF6GnL6a114Y4WYNzv3tSXhcbpuNfj0ez7tmNpCWgc2?=
 =?us-ascii?Q?LnGzwh0DxwG1+zd2Np58n3k60hwbTmIaLFovLVOVUTkMq3VJPGsO9oCoQhi5?=
 =?us-ascii?Q?psF1lsA2v6F4d+gUwnw6e+Y0QT2O6ZjnVJhitiWAgPTMgaz4phsBQAIAbkrw?=
 =?us-ascii?Q?+YljpHPeMv2XbdpXaUSetWqxmDX/HwQzgfNOb4h6EU3aKgHFbjQO3PZpqGMz?=
 =?us-ascii?Q?xw6t8q+egK/cuLxkizhph1eh73RQjvyZh6N1n/drgRFeIkUjez7Shtc1yWUt?=
 =?us-ascii?Q?zcYQDFnpu2pnDwvz8c1qlgk00GxE3UjPUHWCyAeBZBiimYpmCGitjwkQKYbH?=
 =?us-ascii?Q?KvrWaxz0QdI86sZkVrfbdN+R7uI22l9AqTZZHOw+MZLZL6oYbSI1hX+fCyrR?=
 =?us-ascii?Q?m6Uww8qFjUTYDNs/O2579+lTE40NCEunNNIqVOMb60FJNCbUxJKk+WYWzxSd?=
 =?us-ascii?Q?PXKqHdOdGaGN+6bPviLsZuCAexXdIBr0jT1P/G65HsAJruiMuREW//QfF4qX?=
 =?us-ascii?Q?+vYuLBSMUGqOva+Xs/GA8gR7m9QeFR4phA/mBTBTHWkVBjatTagXpQ5jTO6b?=
 =?us-ascii?Q?XCzSNwcq1CfFfKY714Sbq94jjHxffWgj5l923KnSjh3r4J0/lCQS23bQ8qxX?=
 =?us-ascii?Q?MA/msm3pD1mf9ztf+LcAricETbcIbkyVk85HGa6bdgrZ7iLL1X/okynS6uVq?=
 =?us-ascii?Q?0cuUYWUwxmP0YdibWOChZvXmZ495UjggIyYekP5Y7PZojuOqhFNJXH+U9CXn?=
 =?us-ascii?Q?eWCzzk1bnTFCQ60pN0wVgoqxIb86JMydkUAQ2Rwyl+f3v9uVH7vqnu8iO8XE?=
 =?us-ascii?Q?dmzTbGkRmTs/UhR38If/xVl1Av94V8t12jmI8N70?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79be013d-0213-491b-0ea2-08dbeb4ea804
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:06.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxFP/AlcDimW2bmw5sxhJRpjY44TYA6xpPyAkWeoRq5w4AzTWh7aLewFM3k9adKCk7ZLQlpV5u24p53nbjR9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

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
index a6b32104003b..79bc894a5aba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2778,13 +2778,6 @@ backup_tests()
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
@@ -2798,9 +2791,9 @@ verify_listener_events()
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
@@ -2867,8 +2860,10 @@ add_addr_ports_tests()
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
 		local rm_addr="userspace_pm_rm_addr $ns1 10"
-		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $MPTCP_LIB_SUB_ESTABLISHED"
 		if [ $((RANDOM%2)) -eq 0 ]; then
 			$($rm_addr); $($rm_sf)
 		else
@@ -3423,7 +3418,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 9b7e66364c49..f711cc0d0271 100644
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
index 85712f097597..9b1d8b56d8d6 100755
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

