Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61A2CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="1DSZC97x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndTPPANwpSTBJtfU/U5Sx2tBY2X5gYoZohz0ZQrMk9/+yjDh75qY9z5LOphVO0BPEfw0Noj8Zgtrym7KWgezUQOecdhbo87CvRiiip2RSB+5v+dze5WUZRxHRD1q7hLPWs7gvCXR27IqtK7WHpq75UI7ZNiiANTa/I5LEnwHOph8PkPAu/8ml/aFBD7cF17mN8JauriIfIG5OLppRx5+/cqpF+Sg4jegOhDXn+MPbn6yH93fDjx80w8jvRaNiggoh9gSZ2A5JCkKZdsPeNtyidvZfz/qqVOe95Hl8WZFDZp+R1Op1ZAhsFwiHAbgVBxyu9a44oo4NXf4OSsEQ0SfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t1IgnhDtM0NEu1wEiYBsUZksjlzjV/3WnciozZ7yMw=;
 b=cTVe0te7Ygqeh8l3Vy2RGUc1nIcUKoddPHhe9BgtLDweHrkWXC09GRyL7oOugDfMpCoNSGoGaaPiNbV3jZIEblYkIUdZ4An1JaHKSwhIVoIX1x11mZhZ3a/qU5BTN5kleUnsN74Jjpywd2JNwwie6Q+Wot2yDYR2Hj1UKDYjEiUFmfRE9Dq1m5V7FhHDCiFv+i0vs8DGd5lL/lPwc9gQs22waywiFbPT3FYXbvauQxlR4Pe/HQGMxtRqlDANGTueYBtpfduwqW/bxwJSaAsxIBwWnb4qmk28vLm+AhTvdyya0WH1l5dFqu+DLUdhi2WIHZlOjZH2/9RgDt5Ix0UvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t1IgnhDtM0NEu1wEiYBsUZksjlzjV/3WnciozZ7yMw=;
 b=1DSZC97xTRH3YeckxMmoP3P11TLx64IDARSj9YL302edsT7eBlrte4RGLhzbq+Rf/awrJHbkSxRlT6IjCz9wT+CWx+RHOgAYsFJLnAGIoPmfIrgLjQTK5M3/+wJrB+OQcgrTahguKo7YnzHFJawt7ViifP3VwAE5VqHlL5mdrQSK3xcMDuMON5qRbXAP5EXSBzTIFxHr8+2Y32V43oza9DAgP5Sl5B79PKzfbCkFh9Dd0qmYOmzBXMRakIHZpQnCtR4ncukNt+tt/PFQ46YizPEbCif3zMuM3gSRFh4XPrHsSsI6HWQxnbYc8RJxOj2u+53eXwZZutck44uyiJpvOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 21/22] selftests: mptcp: export event macros in mptcp_lib
Date: Wed,  8 Nov 2023 14:49:51 +0800
Message-Id: <4f885a8d5c0176fc4013f23cec1e25c7cecac3e6.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e3ec5d-5c38-4184-e8c9-08dbe0273260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	29dSy6agcYfdDgodOaKeVM5zpqnk48xu9HwHjJHuO+QgDZ/3V9ocBBPa05wwg3q58wN9QexXgB1X1KXnr35M5L43TkluFbYPSH+lLuDp4a5j2Zqk5DERL+i4qTav20nNIUpoa4buLWA5huoPfAkCJQ3Qzef6BT4tVv59WDs+LkGldliAR7DI7UpnmFvUwSVPu2SjO5bg7ua4tIBH/9U7ztJjmAfTagr9MMvyhU89mkL7aTkeHsqCapbtwm3YA/PlKOkdaX2/etU8paEWzVwvXg817GRd+//Qg/m6UeohcYkP47QkO3La7kqQyq7KABeceO6HoUf7BtSS3cvLKfspiwy2Ob7mddVDiAZqPs5/As9n3m2ddMuTSRXXc2+HxCbUxQYRFnsYPGzBoVf4johLthgxrrMvsTUupV7Yoi79yIbu6jgxeF3WNCGf7A+zEk499RgywVSaxRovTXFGwLxt+ov7yHOAiZO2RMEowqmC7F76scYmtcfljJ8/sCfRKWiFqd0hSOowlJay8J40GhPDiaCsrcc1VGYYE/KC7QW2IeZnMHoAzMea7M5tp+4aLHrCKUuDCGbDMV3IcqlX7SBAl/EfWZD4HkgOd06lUi3Tfcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(30864003)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6666004)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5pPPpZj/4O15o331pWDgBEDBxEaK5YfpUMwZwmntCwyZUkNb8tXKUJ46VcX?=
 =?us-ascii?Q?Vy1BNgYkJ3Hl9cZ2LkX/HD2lqvRBatBkdxXyXFXeT302nwBv82Si/pptelsf?=
 =?us-ascii?Q?GZ2qxeSfqrbvEuemW2pA7GiFkTw9nY2AKE8JYN6U7SAnMHw/ii+4lMUkSp6V?=
 =?us-ascii?Q?VwA3yxZbL8DZ8eaDbpj5F6jFO5WfmG5i/qFKDprD4b7yY9Rdbmyj3aKQh6GG?=
 =?us-ascii?Q?lkYJ2Vdn+muBxG8JdC8MpQ8idEvj7mXRmlZaiAYnxqcZDT1AsJu9Fiy2lw2d?=
 =?us-ascii?Q?OPFXUbaQKHtFxbrcSZctMKNfsmgMsYwhXKIw2hFtPyGSqeUHIAT+L4qcGIP6?=
 =?us-ascii?Q?4iJonEkl7YL5HA129wGOUQF4XPHdyiH6ScYWxkQbSO9Mk0stakUqsUt2I38k?=
 =?us-ascii?Q?b+djMQVbJdi66D4TkBotUTuVdAVwvBp7J3dseu+tV4aL+K1X8LNUd6aDefCo?=
 =?us-ascii?Q?I185vZl62oqSXOsmmnuaNNCdgt1T2pUZQ53RdnE/xYHfpY5BNMQ/qjKu9U+t?=
 =?us-ascii?Q?OaG8aprHtQiWW0v/VFy/8FCY7eHEj6Fjah2SFZnoRbqloc+RSpcB7LibX/kT?=
 =?us-ascii?Q?fVaThQAcKa+G1SejQ8rH3LKaBJWwZOASyhij7SkahKxMO5vEMI0jPd5vNKE5?=
 =?us-ascii?Q?mtvtDYgLIY0P71YyE9+68fIrgwc1fk/GheCGrJOrLNnwK168PeXQtB0PT6mI?=
 =?us-ascii?Q?wWbv5M3RYnPOULjmNO6nzHfm0p15n+wuyiYsj+Yp/QEk33cbWeB5K+o5gvrd?=
 =?us-ascii?Q?hzTB+OFrBBhznfR2VAZ2zr+NxfnkMgy+bBawF57AiruEzx3YAXXCgqQ4ZtRM?=
 =?us-ascii?Q?D7ERFL82NglR72Zd2ub/NGDXoCOcAzrNGmPibefxaeM87pGycvOwrprrjqhT?=
 =?us-ascii?Q?Z7ocJDHrB1Q620icY68pxdGCjQn26hTb1QQmXsWzKJTaw479I2jf5Q2rCRgj?=
 =?us-ascii?Q?NnylXcZlYb4sCE3xcduDiMT/0vgpJZq1kS/7WVWS/QKvXWJkKxBohoSi9kK9?=
 =?us-ascii?Q?iBxLD/BrPtHeZg3+lfnEgsdilSsFqT5JGOwt0Obpkd0DTXx1X8te+FpbQlJK?=
 =?us-ascii?Q?hL0xrwk6cIqau7KNHoxE6R1Qen5Nnojc+DC3HcVlus+wStDY9f1qEjmaouBF?=
 =?us-ascii?Q?EzKzJrQQFk7aqmUMBfG40DNjdLlGkXXfuTlbhWy7AVWcr/4JKxe4SNXhkVVg?=
 =?us-ascii?Q?GkrlrAqKREsZZKvwEu8pXFfatlpcmuYOCsNrGK41ZOzKqGWIl9MKMitaVxlx?=
 =?us-ascii?Q?3NuwTZyJO7epgctpG27w6+mXMHX72qgH2A9hVNBgH++xPLESSt2re6h07Fiw?=
 =?us-ascii?Q?jlkrTGpHV/OJDBZdsxAMIlVuRopx1ldKI4tzxjogPu1ooI+oxGtwz8w9dJ7Z?=
 =?us-ascii?Q?cZWw46ZHQyu23VnktG/vx/mDUvklV9iiPu+aBsqj+Z+xJl4qyR8JCzW6HzBg?=
 =?us-ascii?Q?m+S8agryurAvIJVWysLcpyAhxJ90F/ojjAfzVX/pe0eROtXC46GuJ2+aLQLc?=
 =?us-ascii?Q?p6jm+CSY49o3ObuE0t9cboWTBX24tkktaz527NWb0NajH3VnEU+/ZlneOAs0?=
 =?us-ascii?Q?0jEhJf6euiZFZE0dbpH1DGzUeJNzPcYrNVOHu24knVEEextnAexYpQlHhSd5?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e3ec5d-5c38-4184-e8c9-08dbe0273260
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:56.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8767TCpBIwozwWbYpba1zDdFexm/U4Dl/km+WM090XHDO0vyQU9MQRWNz5ei0fOPe/9gLUSvFpTpzcIoLk5xPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

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

