Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E0196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SGwYAlfA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBZ3NxCmiWvHkJavaltBLCFwN0qnQqf0fdXhml3Wgt44xRyXSLVGDXLKouZh6fQawfNlUuGsc4oA3tJd4pqNGPMnfJWx6JYhIPghsDjQAlYfuC5VsKWeLvr7TKd9u0VmlEFpTyrvwFfr3mWxe0GhKGwx+uj2wYUegdRe4gP9BGbtRmBcFB+HOH281J7Viv4tlXjdsBBOQJZJOsHh7UUKy9SQCB9hjBg7iOUdEy5r7UvzAFuEqO48t7ab/r+ZNP7sSvqHwGtd54T7j5kNis8kAKDE3emv/wOzBeIZpMA9hqzACZR8SUYgxmt9VIozV+N1CfX7jflk1BXLG5LOKvfmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh30nNWWmJY2uRRqI6isqygJk8aR6KxTc5CbnOPCIec=;
 b=Qos4Pr/x7WWzYnPtPOarZXsYd6OmMudbv8SHAQvqCMv3S/fyVqd2ajem/pFq+UnuEixHTQO80GkYZJsRP/dqRvFO8+Esazo/MgvdPKGG75v3h/8MbtTzis/cEM7Mm3fCE+fiidfiSV19QxXGfCCt4kzYtAXkP+yltt+At/LnhBodRTTaYRKxe78/DSvfG5j72TUXAoUH26E8Aj6pu1MFY/XdSyw7LIs4ydRWrKPYwLJ7iwkFZZVYiuF/SV174SKkhHf/MMqaVDi4LZJaMbkUIflPfPIZiOKHfSlN3vWnNMtLjLpk788cNHQXQ6jEjv4EmdniiH05FWFANy00snog5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh30nNWWmJY2uRRqI6isqygJk8aR6KxTc5CbnOPCIec=;
 b=SGwYAlfA7npWdqtU7FB+jetHwjwvHBQPg+s5G8m8MlvhaXbsDd3j1FqAFHsLNyeEzT1ftXIGW8R8gk8FmebVk4GLa7FFrvptJ4mslJbEUvMhhZ32LYYcoFkt58GI9pdlKZdjxrhEhOpzCGhXdPg6dRmWAOrZLdhB/ESHdPpr1AZghwiEHw6i3VA9cWtiPGfDOtX/dg0RdvOicE/BlRnSk1rXn2iNYptkK0lo5h54bbPJifUM00nQa45qbHJxOQeVYA2maUPP/5KinSNKq8qNsuXYhzH+LvDcA0prBLbJ8p4uGE/XsDe/TqUJWqga9z+XunRto2aTIpO8QRxj/+r6mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 03/10] selftests: mptcp: export event macros in mptcp_lib
Date: Sat,  4 Nov 2023 08:26:27 +0800
Message-Id: <457503028cdc6b67d2ecaf4b2111a12a270fcf81.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: fb75f014-1445-4cd9-f91a-08dbdcccf3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gk/fS39BHonTWFMjccovDWd1+eClbxWLRVOQRL+dj/Y9LD+sVadavl3UMfkWS1vSM7P1wQb1vlCUqXE3v1f4ih40VRsyJqnhdQTeKCq9rud7l16P5cKong13teszXk6BXi+E1CuDhav1Hq7atwXAGfYJ42rFuh6gtFu3F9wvEzZm7RCABr6zdR/6c/dIQAUzn3jqWiN3rgb5uHXm0yxdgNpSVD5xSAPAPZZsoir7r4VLIlw9uGgflKPwgekUDcSe1Y4bpFAqMGz23HJGfODAWGTp2Me15jw688Kfn4MpMbZ3M5IfCfL1AsDCr3QpFxAOqXXDO2Cejrh570uac54w7/T9JNNRcaLdoYY9uzU3cFgdR0HKjU5wcoiDvmB/5wWBPgqD4WbzZ89+rRkYONkr52VA6FmpwfjgTQ3yVD7SBHkNWgO9x6x16PDPJ/cPdub/JrTHyfKgTYiV1DLIadjuDByrTjuymPObn/HHVA0gGzGhY/mB3s4hEY3bP5+3qCmTHNXHq9mul690pdwvDDyRIafEJB66zYyCWc8vYHDBu/NRRABbeuuZHJl4MFSsrJf9YHI53znPcK1JDX/lO4V91OiOuKUORHxysq6uYhXAXoU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(30864003)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhlbrBHo+1EeUadrEsZ6VnKCf4B9faMhOe8RQ82U8I/2aQthLkMudh5jkxFg?=
 =?us-ascii?Q?4kHCCjVN6kaoGvwhZ3QGSDqd7IjCxpumqqKSQnww91twi/CzNfHvfWSSjPIH?=
 =?us-ascii?Q?XeaFHkolOtRZagmmSMzfL0/nH4Q+ZwGZSUBZVPphcUa8ySr+Hs5yQg4wSjpp?=
 =?us-ascii?Q?irc4THF+I6G8FC38RdMV367o5MX+9yaBRQyEYA1cSa3ct6iNe6dTGjhDTwqI?=
 =?us-ascii?Q?oB57ilRz+7huZPF/dwwKwl7xx3MC0pNu+N9cCfTJV9RtddRkYUDpfqDwfoAf?=
 =?us-ascii?Q?zyLNXw63FYJpmoHBNgJh2qDvKH4s7XmRowPJj0IR31JcFwOL9lQts3tky8fu?=
 =?us-ascii?Q?qjKvwYPjO4N3xYmGIWsXxl17FZv4uyTEAiyycahnG27qxv+FS84RasVmQRxj?=
 =?us-ascii?Q?slLZ2DtOa5Qc96LXhSxybJD8hrCwh79EjWXb7RtbC8JH1yXRfvfgoEwLpIvf?=
 =?us-ascii?Q?okCEPlaxmZUjqjbxUXbwfnYxkiPkcqnFxEb9/ygYAmilOuTUYrmDrLsXGl6A?=
 =?us-ascii?Q?EgM9MtVdCmIvu+vrhSl3d1/ZtisK7KcvcCJZQnu3j+uKUhjXfpYBTX4adcVW?=
 =?us-ascii?Q?JoAVEPoskw8hpB8jLzpLKfBhtJGvhOWDAEia3J3Hmqeep04+Rk/oojP5bBNH?=
 =?us-ascii?Q?3lEZ+hvBJI6ARJjbZm+g00+uASDA25j7MizXRQga9L5XQVHAe82CFjmQcTIi?=
 =?us-ascii?Q?OIoOs/k9wiKGMr76dxhZJGAA6k+IislrjR1ALHtfNUWTCNMfPrC2El02QEyU?=
 =?us-ascii?Q?J8DOURGrGhYjoWm+7YCYsoPMFyiXt6nHf/LU5JzLUH7K4P1Tj3kkLcByqHRN?=
 =?us-ascii?Q?oG2wD4Rghfg6cC5muQdFsSrk87FIrY9+k4DFfHPd8TkPYzhlpzPSh/a+7+lJ?=
 =?us-ascii?Q?367rWEpO/tLOAZPG90S2v3/XS9FwF+c8M33l82kpmbIZdr0qnt1CGbSQIpeL?=
 =?us-ascii?Q?QqvQsTXRpIA9V09KMRrQsNjPKIV9reOv0dINTfqpI1tcDv56E9//D3EtVtho?=
 =?us-ascii?Q?hmrUaJLadvADGMrGGW0ibILI1qq36hO2qELkCHKRx+0Cw7ZtcrAMWju0k5R2?=
 =?us-ascii?Q?UIssG3IEmeep/8eotJVIqWpVUwWEjVk1VXLDv5tjp5Laf1KhD+wugUdns82J?=
 =?us-ascii?Q?5cjZLY1mUS66G7yLnEMF4BTjroHf3Nq6bbmKDHFqPPqJbzELh2mpa4rOu/pY?=
 =?us-ascii?Q?EE/NJcIWcWwXgOXrU18N0K9Tf4+e4vLw4KnMKAgLnVK7Qly1CD7uxBuIAKzw?=
 =?us-ascii?Q?0WwUD/0oHwjiLQ6FMZyPE8bhs7UWvRd0Tg3ANirEfpamga1StsIrPT7TO826?=
 =?us-ascii?Q?S0kZGiAunGD+m4sHMvkKZ72phT3qYEuAaa+rNfheUop68WJZaTPm30rv9m6C?=
 =?us-ascii?Q?v6g3HzPAzMXOIT02nr6A3bV+q7MNvq1e8zms8mAKVVgBw1H7ewBl7M/q3zNI?=
 =?us-ascii?Q?+XmG5K9DZ4zDWYaGE4U2z+XJ1w8HtUWiwLcpp61kVGfBN306nOrPUU9RTG87?=
 =?us-ascii?Q?vihSXaIvOvYHrLoVZWyPHw62xt37wp9entnqrwN4zqZTAIzYBUNoe+wQLqTN?=
 =?us-ascii?Q?Yapiz32nmVvpAFHdhP3ZYluL9Rj0be7yzVLxOufXJT7XCuRJiwBN00jnacpV?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb75f014-1445-4cd9-f91a-08dbdcccf3ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:22.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XXk7kMMNfZUS+meALmeP1eQBi/vcFrR6AEmn4mI5/yTpttcUdeiN6MdVAPr0/pCNKxeQwMDbU7X3TtR4aN8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

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
index 27ddbd8cf03f..fb05d207fa44 100755
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
@@ -520,7 +514,7 @@ verify_subflow_events()
 
 	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
-	if [ "$e_type" = "$SUB_ESTABLISHED" ]
+	if [ "$e_type" = "$MPTCP_LIB_SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
@@ -577,14 +571,15 @@ test_subflows()
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
@@ -615,14 +610,14 @@ test_subflows()
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
@@ -654,14 +649,14 @@ test_subflows()
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
@@ -693,13 +688,13 @@ test_subflows()
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
@@ -730,7 +725,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -738,7 +733,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -769,13 +764,14 @@ test_subflows()
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
@@ -814,14 +810,14 @@ test_subflows_v4_v6_mix()
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
@@ -881,9 +877,9 @@ verify_listener_events()
 	local saddr
 	local sport
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
@@ -918,7 +914,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -934,7 +931,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.35.3

