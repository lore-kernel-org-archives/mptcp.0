Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74272199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uyNAqmKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8OfGmMOj4Oqlo3RVimcIBqp+3mkwdPiN44S210rt0N0RDvtQOJss93xI9TBRh49h+h0DaoAQNfAHLjlMFgrt3SX0x+KCjGoZsqJGtThWIgUkMLKaRnaiBmOqAThjdJXwcGrVL8UsmysGecRu1SHZEL/7QhuZLWybrLDNTeUvxxN71J2Qa8Afg0nh5U5U1DBAUubADugBX0LYFxysqsk6eZPv9xUTXpq+F95TQMt3OTOsD7HxTkwYAW3Es/DLoCIHIjnl0Nt4/g3rPLQ9ebZDKtegaeuxVHbMsCaFufYTb6GurZ3ee8gp8jtDZ6+1e7eBNnQkiLAeoGOnhsWZejsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofl6hXM45EmEEPA5+8Ccz5vyTfadoJxLzu7wVowwvrs=;
 b=H4okABNblJ4ykdy2vMsVnZ3yBDBscrn4Ngj3PcfwVVKlkPeRR6HYwIfBF3dRXCuAzN/w6pIB8RV1puQzMzGt7dd/sDShVMGlKQbRini2z0zncB+wypa4Kh/I4vD++xipBLGh6MHm5qMxqqt5sZ7bqgMtCk7kkfMgyJRwg8yMyjkbqo2SjC2DgqciExaAPJ0zolW9kQTVXo9h3pUVkpJCQ30d9F3rm+NQG8E0dlQV4XfKeaRcwmXr6cWmEhzMqd/Zh1saXcFpoTeAk4oGCtaiDx6/41IVCLUzbjr5OGzqa4KdP0ArI5A3h7n5+0dzrM4u4fzRv4lTHVVC/PBft7J2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofl6hXM45EmEEPA5+8Ccz5vyTfadoJxLzu7wVowwvrs=;
 b=uyNAqmKgU9gDwmMs4opcdD72HjGOstWLeU0Pu/5B2Ob3AebbA1of1AdgzKNsBgutyjlJcaWzxnI8TbDppDVxJy1UhXNNloeU9i+/oJuwoeXxJgZO82t+x4XVhidmXzrYurjvZtsco6R8G5xWhEx8pVZsUT+JJ9BvMTjoBwBkQdKL+Wx0H7DHaXuC4cC+Wo9OFBbSM08MerGK23L4Vr1fzxqECYEar36pA7irHvtpdmgLaWkJPHEljRAlCuPiBg3cCxZH3+NCUlo88EuXsepxK3Zn+wuwAg3Dkuj7PeCL1trEFYf5UB++AWVaS313znaq2YB2vghCvWApS7H3srTrAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/13] selftests: mptcp: export event macros in mptcp_lib
Date: Wed,  8 Nov 2023 22:11:43 +0800
Message-Id: <59ade3efe88c15600c1cdc4a62dbda7bae58aee6.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca2f87a-690d-4107-fdc0-08dbe064b38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RWW/S3+g3hpEvSJ/UgfmVrXQbgAxLq144mfZYTnXl3/dqD5D7tE8arHau0RvZvzCNbeUPn4shy8N1HWR+Qmobept8ePyDmp6zu9m9O/ji22aoB6BVn/E3UT5FL4vn6SSWSyREKyq2CiHMk1Z3djD2efElbI39cq/bgduljMPlw/uZgwBpoXpvmSEaRN4RchIhVunGF8h5tg7NzTYCOJhxOps83yrlLduBWs8j63S21RuxlgLEyKOqT4AYiR4Ku5ucAruoy11n1OdyP/s2xzqhvzDKtuINm/6wCgqHepyNpjuhhhgwUiuLh7Hl6IHeFEKNfv9mhwOldnCmWI7Nv54Jne2ydiVz/kGiQNkq5D0ShNOzd1/rP4V3Ty/FzB67bZ+5A9vkZBrXTWUiiQPTFZj+LG68gPa6L2TnAYgTgapdY1wDUZXxoPElhFaOaT08fZ2Dbc/AdBF78r4yCj275FD6/hUYrfn4pdG+rpv024hY7MZupM8Tu2UcNAdkTesibn4YF5BL5uRc7fDNwWVxS2E2E6/7Aj6xqqYIC+K/8sudFyUPRuzuLJanSOMeeVm0A42
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(30864003)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6IK/r9ucFbxorTx7iZeeXiSIs8vTZ+2LWPrddLUChseYGq2t/XY8YVxVj4j?=
 =?us-ascii?Q?xMiqnb5WKAdY94QwS8m2Y7YTjj3axm/86wOa6rUHTgASZgL6G0Kf34lGUdTt?=
 =?us-ascii?Q?uxo7UOBPtbXQpfA3TxNoF0W820F0bVrFeIhY8qS/PRbmXHrF3w1cRIijosbx?=
 =?us-ascii?Q?JdtHckTLiZbcE6f3XMGSiakhYVSzvj1KeB9fWHfkPZa87y900tIG9OBz8dmd?=
 =?us-ascii?Q?9Moqvkk/Xeo6t+kjqRU9/Q6gEzOhcPrNsyWHWBI/mfJKOTa1GQ5xP9kvygrQ?=
 =?us-ascii?Q?eVwyUARVans8CBC4CQTXbazgsgN9HmvZnmPHJLlBF1o2rVB8VPz6BVKp9doG?=
 =?us-ascii?Q?DY0BMTO2Bf6JBfRS7ydvNKvAWNh5MzI0JraXmOFm/L69RtReT/npYJ+t7U6d?=
 =?us-ascii?Q?4RyXAe6nwdaf/VRHsfpvN4oqAQzUPjVwsLLRdRPaH9Y4T1T2GT1sTG1irXgH?=
 =?us-ascii?Q?CYXLRuPr8ufqZWkep3jAw0RA4sZBBI1+XPSItsc3I5pJOf0URyKPFb7BYQJf?=
 =?us-ascii?Q?gF629MyLIlGRUnHl/35sR/b6BdaEhRpNnBO9ctQWstUg8jGnjBmIky0guJFA?=
 =?us-ascii?Q?+CA0xV4lvtv0tlhzyVYpLueJrJ5FyBIY2NjhksCjBGerAsUfgC1TFIE2THlo?=
 =?us-ascii?Q?wa3WU+izj108S1xt30+kEC8JbRbG3Ac0/Mo6FbOyXAyL0of3rwbAMrYTzadO?=
 =?us-ascii?Q?v9noxu1cZ3tioUsiuDBTXai9m3mg+6O5fS8ZAYeNjpLPpRR4gymaNDDawt7L?=
 =?us-ascii?Q?ub1HCx+ow+aIg4pf8GHIg4ysfKiJbFqPjKEpSojdB+A2ERhUeSkTAjzktL3/?=
 =?us-ascii?Q?YIKLqun1VM9NMEV2UPqu18kSWVCs3ZO4GlVVqHkeB9gA6mS/lM/vjYIVPMCm?=
 =?us-ascii?Q?SQn3+vq8wdl2RoZvS/VMUkkkYneV7OlHg/5kx+DMXsuQzX3Gv8FjHxroIwuJ?=
 =?us-ascii?Q?i0hUsf3irLHQyAMLFmoE6VdeF5Qm6OFR8tg9sJowJul1vLhRUgaT9aYfHwen?=
 =?us-ascii?Q?pb+2qVWStFQtLtOkS3+P7poh5S7CSBSpFGdo14Bdz85pI+h8IDIKPNolE4YL?=
 =?us-ascii?Q?I5eBkrKn7tgCF6trVb+OQZuQqBGV3FxK9Ww0kX6b/xldeZXCZpWc8sJy5C/3?=
 =?us-ascii?Q?8I5MtGqnLf7cbl5Ibfd/9Iog9BG7+Q+/0RkcamwjjHTT+neN+OFvUypqSjdx?=
 =?us-ascii?Q?1YWLo2Wo3Hd8QLrIdor3gKhC/mfW2lKhdV7JCKi0SSm4cYMi/CCSPkE+1DRo?=
 =?us-ascii?Q?uV4Kxp2bgS+6mmuzG/s/4tL5XG/GTdFfVfvMF9KccjDLJzOveBCesPzz6+wC?=
 =?us-ascii?Q?AgQ02v0sjL6ANnuEwf7+qpioHISjFvcltD9ZUPbZH/VrP+iVINBCLIks1KYP?=
 =?us-ascii?Q?jEy2S2qZ5wYrgxQCh29wr3Fjo3zkXxvTnQbOsAl7rsTlek6ikT5jcF25CVvv?=
 =?us-ascii?Q?bLJrl1+S4FF2mBOZ7BxWDp9yFPsguVGcnu8ObvsTXvohoXMv8kP0KJ+kXY5v?=
 =?us-ascii?Q?JbNQudJVbZdlVozfmLZi1KFRuT5zUyMP1pBi3J2iYLKVv0tqrEbfYlxHiIt3?=
 =?us-ascii?Q?olqfcGfPqmivC2aWQXr0JokJXs6C320okzDZVJuw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca2f87a-690d-4107-fdc0-08dbe064b38f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:11.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xgQ3YFYsZwkBOneZK+ecwU0wEhQaQhqS5oDTDMbf2ZF3rSrCEhoHmXdgUPcf67VdNmk5PHFrPX7Baa2MnU7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED, AF_INET and AF_INET6
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
index ac7cee3f4dac..5c8873bc75e1 100755
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
 
@@ -3395,7 +3390,7 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3417,7 +3412,7 @@ userspace_tests()
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
index f1dbd97c0c96..5921589f0db9 100755
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
@@ -888,9 +884,9 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
@@ -925,7 +921,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -941,7 +938,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

