Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C38612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QNEX40jz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLoH+EUbyW4v03UIz0RQfO2u3xWXKLiIIfRCbQ3MMg5zffcGlJBI1pvpQWb07BKptuWPBQEMNgu5XinVcxjYBiAowTPbBeXHFPgM83DMIgJCM9tukkTLFw+sOCIZSTm6zgjuRbpmGej1uiAuQwANP18/DivdHWFGhikH2qE02OTm1YTdkT8xVNmfENlLwBaplxpn6ln6a0gM/SbfRSVGwDtqZEoMnG8FMJc76eA5+8xHUsrWZclBnYxQ23ARw0VeiXrJL/0NdtR6t4KrPXgQrXOwGuSaE9zlsAD7ouj41aXlMlM4lJG4ym32uB9RQPAD8TGD2Rjy4YhHLkQLdpHf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu5lgSYX/9rnYtfTdqvNcH2jvAMIfKFtNgzqLRjMwtM=;
 b=hAI8HLVswFnuA4rAG+/Ad2SqhRdTe4iS6eNtVfaVxL5Dtygt9LGxZAHoqfeG6ufzSf6jotsUwsxVdXFiIw/LGhJ8ZwFNDLT/aKHSbhJzh7vj6t/hqC+1+IbpQTgZMYe0Y+5d3+5pfsjacBvJ3zsTYm4cjXVmEYIyGoD6O1MKLFn00o4QfYUf0vQIk6pbAX5VYHUCcmyqaNkktjZD5jCjorH/9Gali1gkcyce5gApMeTd3O+AoWpe4WYEJ0mbkXdK6IV/FqG0vFcUgz86BgVmEm/xHlBPwnVEbNj/e8z+jfV6qokftcGJ63dwv7YEYnKWQ4cIrHeXDntg2gHjGsKneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu5lgSYX/9rnYtfTdqvNcH2jvAMIfKFtNgzqLRjMwtM=;
 b=QNEX40jzQZanWRe+vml+3mJOzAklsEgAvuLdoLrWxHIOkkHRGf2FhT1SwAn95+cgBuShjvae3QCWiycDsMAy0xuEhME1YtIU7wFl2V6FtPDVgUYdefaA/r/BnJsdZr5XSKYD6z4AfFB0HpcpOnDCqr/XaY34/RF/zp3MhNl+vjngo4+i2/ngdTP+yVXQKtBCZJHxCozVfZ0RyFVHKgInio7SRIcyv4zE7bBbaAf0QKeB+zWIjpfsebuO+S4stP5VEvlzBp9LmaSiIw9RwJW7cRadK06/+AIfx0Yx/4hAl4LFTHfzSUF7/Mb8fkbD5s2oyZzTolBPFR1gS5g2FKOVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/32] selftests: mptcp: export event macros in mptcp_lib
Date: Tue, 14 Nov 2023 14:35:27 +0800
Message-Id: <411c77bfa412392128e3b1579cb9770426a83fbd.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:404:29::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbc13c0-1888-4cdf-7e3a-08dbe4dc61d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8kCS+YUytOKOgNvvHkWgkOcEcAL8bKN+gHIlY+h3rPjFIosXiyQdS4DVvIAb6u2/8dhYM+33j07g9wEsV+uGfq1PwnviyawJY3ibCkA+E6qbNoLBYaMdrvHDgiDBvmiQpVALCQXuckx+ygg3R0ZH6hzbBeRf7t1PiJyRGs2VWKGZzS34bVLCB/7U4tZtUqnIoR7XXwyl52WlmHm99/ybnyNtFT1X0JNmkEtdIIqmPsSnVnXQRcLSOjL50hxRHTaNNa7lQWKvrYfK/QmDycfUt/bEW2gtn/namTIznV05Ds+F3Ur/3rKTzOWUotHDhkZWnLWEEdlX0Ki/bEgP/x3I9DwMM4y4Vs2LyZNHDElWCmMzn9PoupUhqdesYaMIPZ/j1WKXmXw5vfj9FCaNUXzAEix063jrChc/wf8wGzm7yLGw/D7zmlYDjAM1yGoIryPdGD/kILhgg/Ilkda6fZtM/VUwu+Mzy3WIpolm9C104ZKYyAkxKOYK6zgTcLAvTsk4O1l3riciMTXTDc9cJEl92jgvzIzx4xmH971kfN4De8xzIfnG+6CmV+IBd3cLJSHC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(30864003)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Enc60dc4BNWj7SEQpGx4pDCVizGLolLy0khg8lavxEFFDXTpUuIW/McK360?=
 =?us-ascii?Q?YVWrECX2KxaF/kJRowSU0rjIg4vaxvvaREU9EXYZjfvruRU7dbLl6+qm9lYN?=
 =?us-ascii?Q?p3wDIsjQJNFHfnGHmCMuD8miSIzxEkfj5cRfYjP/NBw7iYF+Q0s82K/DEuwl?=
 =?us-ascii?Q?r6PNj6NCZT11dFmjCfovlkLCBLMt59FiEIDql66juWWoYiGEVMMy7+xACxM4?=
 =?us-ascii?Q?GsV7lw9Oz8//YlglYzvP+BG9vC8Gc8e4y85znitnQ9nxEWGHEiuN26sBfVGP?=
 =?us-ascii?Q?TlUau1DQfUN8xnrlIniYlzrAwggt9lTxIa96BOGaKe613NNVNImdXLzVcrDH?=
 =?us-ascii?Q?f9IfvG2nzfwoozh0XL+KkIRf/cbeR5oR3K2DXnuNAbe8GhoR5BySonh6kUiO?=
 =?us-ascii?Q?Lq+I+By6T2mlypOP1PNDCfdChkopoaDmn0SSECzXddIfXvae19Z+cXfH5HEo?=
 =?us-ascii?Q?6TePwT5GJfVFlos90aX6iezF2CtUdE+/yyHLmEYr5706QLjx47dFIUaFGIGh?=
 =?us-ascii?Q?Hxk5BPiYXQLTaT7I5o+6NRCIqzkNhOy7DAoX53vHnXfptDbgnXodM1ykMTFa?=
 =?us-ascii?Q?vdjcwE+Q+5FEaCwik5zoYl+1rGWGBa0/v63NSx1txb88V69q7ssxZswh7KA1?=
 =?us-ascii?Q?QuHmvVU8qBQStZSpf9kZCi7tJQjIB039LoHCa1WkZtxoGcKssjBKdBQvjf1p?=
 =?us-ascii?Q?TJgFA/FFyywL0JOisXmxu8xfp6G+lIlP8kt8UDX3ypxypNegpWv58RlnxBPs?=
 =?us-ascii?Q?9hcwXp48t+flvlJTBCw9O+Ld4cpPRaWuiAhHqebPkqqcJadc2krgZnv1vBam?=
 =?us-ascii?Q?/mAp8wSx+qCFmnWOM1AbI1enANztF+dh0OI5LEbU9PFOmrj1XU3KZfZG9KIh?=
 =?us-ascii?Q?fqnrfuPZgby4wGAOJ3DNKrOjAwwTzOC/6le4rOBYMyIzzz0aZAbwtHhHysMs?=
 =?us-ascii?Q?6V+6LICPbxvtpEMM2rhI+oMelbzpEJdUcEZxJBBpwi3TRQedc+mRcwUwmhSq?=
 =?us-ascii?Q?Put5FZg7jGg1AgXZjzGJ8KNeb0Ve2Kg2wvzfnCcRrbmBsXN1ed7/aYw0raLL?=
 =?us-ascii?Q?v2sWSiZMP6HAmICzQ5b498pZayrRYBuy4Gmv2RrxLm0Jo4T+602Lws0sWLfI?=
 =?us-ascii?Q?twML1XnYiD6rii9ZuvRrtIpE3hLgNNOjFJFg9sG0SiNMENnSlxFRp1HERE2U?=
 =?us-ascii?Q?I0iKX5QfySASDQ7MpNTzyhq70LrlkusApNtlUQSOX+9qTA9dofZmJ0zh01v7?=
 =?us-ascii?Q?eHNKyTopytW4AdiUGrjGMX1dmY7OhzirfnkzSuP5RjIcZK5s2XB38drs4V93?=
 =?us-ascii?Q?aIsQtNjsSO8rCtot/5TyScRA6yLB4/EsDx7xdXqFyHIPozG6GEU6rAI1Dxw/?=
 =?us-ascii?Q?6Nm42FdD9HxaYNek8FmZuT7GEVr6L6Jo1pVwFC9HHgbatqpBcJDfwOKI7BTV?=
 =?us-ascii?Q?wRcVuTePpsAgzzsWtyfeGCPV1knHbXsW1I22Cv1mKO5NB1RdVbWzCvMR4SFT?=
 =?us-ascii?Q?7qugJfZFtKgBECI2dKDXXiFxSUKfNkXMPDUEGAUilFng9CSLF4it3Kl0GU3x?=
 =?us-ascii?Q?hx78q9Hmo28AoNf6gj3wPjwt3i4x4TNOoS6dkNDl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbc13c0-1888-4cdf-7e3a-08dbe4dc61d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:59.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuXMyUSJQIOre/pZF9RVpdeDmYbKhUJLjxdjeOZwAVGrf/8rc2whmVjz2GMdQ3Awf/bRshMkldQ5gIdvTajGiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED, AF_INET and AF_INET6
are defined in both mptcp_join.sh and userspace_pm.sh, export them into
mptcp_lib.sh. Add MPTCP_LIB_ prefix for the first three and add readonly
for the last two.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  7 +++
 .../selftests/net/mptcp/userspace_pm.sh       | 56 +++++++++----------
 3 files changed, 42 insertions(+), 42 deletions(-)

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
index 3d23783dc307..036130569652 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,6 +10,13 @@ readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 ret=0
 
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
index a85eb83a61f8..6e5370275e49 100755
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
@@ -489,7 +483,7 @@ verify_subflow_events()
 
 	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
-	if [ "$e_type" = "$SUB_ESTABLISHED" ]
+	if [ "$e_type" = "$MPTCP_LIB_SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
@@ -546,14 +540,15 @@ test_subflows()
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
@@ -584,14 +579,14 @@ test_subflows()
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
@@ -623,14 +618,14 @@ test_subflows()
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
@@ -662,13 +657,13 @@ test_subflows()
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
@@ -699,7 +694,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -707,7 +702,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -738,13 +733,14 @@ test_subflows()
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
@@ -783,14 +779,14 @@ test_subflows_v4_v6_mix()
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
@@ -889,7 +885,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -905,7 +902,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

