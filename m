Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77E1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="2POLSMeO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfunS72tY3JvAvTPjHk3VE94sMS2IFfBstxpqdHLGK8X+f0JvteOH86ZND7sNgssC7Nuq7emPddvEjMVGMLXskArnm+73FxFDQg+grIzWn7VXkNbVoF59NpwspDENjCiasBq777EGbfyY+HYEDta5aVy6yn/SOS+9JhjpREoDlUsXhEn6NtgGFcwkQPgK86csZbAF1GzYgRrKks0J6uqduneWeTBPs3U8W8mtbM/VH8271szDmfheHNLorM0AXLsN5pK3DmuZNWNUWU/gl5dm/5Z23veya2+zFRp6/nH4b1/ol3TAXdvfOn3b5+6WLAdYXYTPepOxgfPG/dWfODj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DIOuH0mrJMlYDMvMxEkqzAxKSdUOMwL4hn4Il4Hx/c=;
 b=bk9z5tQRx1SJAeA0o+fAqiTTAg0PcbyCrQeD8u9x4eIiBUWa8s11nWozUDW74vZqwOZEAIgeEuneO6X1hihf0eGUEueerob3K3OuglAgQDG4C/gtEmEEPxkb9MJONMT3RmRSmoxaixdU/PTl0NWkL7XJbFsDZmcEr6QuI7we+m6OYrMxGkdhYq94ODhO8x5mjDhDJ9MHt2pDY+iASqYE7jdqxW6tJUnReb7updx/1LEk3HwioiHPy/h3HW7UOUEMZArB5lj/atmAE8CN2eNuF+AXbfW9lQaYj60n5TSEWSccicx6ZoRwVG8MXSVSmMG8f8hYuFJCp3rLm2YfSBo3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DIOuH0mrJMlYDMvMxEkqzAxKSdUOMwL4hn4Il4Hx/c=;
 b=2POLSMeOfarnYE1X/gFtqUbpn0UZG98Tkxz8pvmEmPgJODIyNBB657eWthJTjuIUBdQpeGqp/vouWos2KFqa1FXFgjE8kD+XxHm7PVp8911oTFvotZt0kZA99eExSnO8mJBMFdwM15BVK7mIfr9vHrbuMAk4UjgIlicbTD9iZfmOz2GHyh2qJSJm68BqnRf2tesvUFjT8FXm3mZn7FnxAXbmExbVF/aVCYGii+E2MXZMpyiWr2J8lVK0ljRHLEJPQugP+GJ1wEnc/aZ8C7nKIVFQVUtlYwVUF54QyC31N+K6X99FbFATxQGI/HsHSnto9UMuPlSXU2AgbX2C9eW8+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 06:04:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:04:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 20/21] selftests: mptcp: export event macros in mptcp_lib
Date: Tue,  7 Nov 2023 14:02:04 +0800
Message-Id: <f68e65533a791f54db5ee8bb101fe8f5ad90e8ff.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0304.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dc49b9-6839-4b14-7b88-08dbdf576384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qs93Dz8AG44RDQy6sy9fPezwnsAz0rJWslk9iBtioNpDsgYy8HoikEAx6iTNK74J1mA4pvRDLUHv3EIMh7IlpZmPEQXwrgVwufVCfOX/3TB3y5jq1r65/InOs8EPxp4Je7jlkYUn6gO92OCiooEp/83OiCsQky4qcpAlJK8BborjXqZAl6SG5D/i20WkbD2Rfv4WM/6pP9p0F/baA5MPnEwwkpW0Q6pYQZea/UeSxqjZZc9Zs0hQTRnVOs9peOJ2qZAzpp9GYXf4OJOZQsoystscVyC0qRhl0FwEBdsXWr+wmcnuYD9A7axeTNoqioXfj3N7elUKLItH/yZVSoCAiFpqVWiYgq09LGXDKqHVmHV9XNMtBjvCnfM/BpBL7CHxTIFTh2aifUY9wCZoMuZ69hyTjN5BUrbggAdwUrmcaZXLio6IUHpsJETLTkM5uCnM9IyQHwAUW1ASsYaeltQokRPIyRDQFRc4rWnr17tuRJxPh4NetFNmib1UuEfaVFZTXu0M99BMw4sjDk4KKzfiF+nMr3EkiM1Nbfnl96UppxP50uRePSOl2FH8qiMg+Gak
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(44832011)(41300700001)(86362001)(2906002)(5660300002)(30864003)(8676002)(4326008)(8936002)(36756003)(6916009)(6512007)(26005)(107886003)(2616005)(83380400001)(6666004)(38100700002)(66476007)(316002)(66556008)(478600001)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhYxX4jdjIM6D2eZ+i0oR0U7I20loCZvy13F046pgA1cZs6SsG3bSwo0iJPb?=
 =?us-ascii?Q?UnUVohOQDCXHtRhyF+rO4dK9WKBANs/m3+ZjtkMjn+Lpn0haSDrVAOWV+mZK?=
 =?us-ascii?Q?CwSSW2aFAc/QM+e395SMecuqJUHIysfEkTDUMJxAkhxBaxlKrOPnGYliMDu/?=
 =?us-ascii?Q?WGtH10yi1JlSO2IymF0MKGlRj1lD1O7kIS1bswidlxi9M0rerhNeemwR6+g6?=
 =?us-ascii?Q?r+ICuCancY0ymGBKUC/wmiviHZR94hRo/6u0/xeFKKffpmGvJr+QulikLJzt?=
 =?us-ascii?Q?Q67k4222m7EEbrmTv7vxQ7O2/C51m7+TpT0Uz5WSk0J84yfnX/dHzHUVZfsI?=
 =?us-ascii?Q?Ft8Dkpvt+RhaG+IHKSQ9zPGEfF04pfL3ilbpaHakDjwDrYoHbhWIKL6uDxmf?=
 =?us-ascii?Q?WMI31Yuo1tH2N+mjLXW3CKbR3cYvqMJFbbg9MH2vMySNRDr0tKgrIlAeUSP7?=
 =?us-ascii?Q?uS4919lI38RYKl3NsILYTXKjuWKklt/fbymoiBTR4VnFvjU5v5m9VXrsAq7t?=
 =?us-ascii?Q?ubsU35D5MX7o+ayeREGlsyY5wvZtCudUvp0B0q3vSzdEvjiFIjY7DsODBq2X?=
 =?us-ascii?Q?8Zp/P1iqKPc+dlVppfdo71OIBvsph7Rx1YBqGFTFejaQ0aMtIW+rm+XE4xeR?=
 =?us-ascii?Q?jILowHkAzpvbi/sclhx39IeDNHzpfABomvlj1aQRoBBmW/iL5Iz+3EtJ5iwY?=
 =?us-ascii?Q?y5abF6hC/bR5GoPUAvjRO8coFR5o4pOwvh5kJ8ju8ukNaOCE/cAXDJ8RFMiH?=
 =?us-ascii?Q?Z8e/B9kT4Df5BNf7uEcgVtNK9nccGOLZtfDHoy2cxcjZYD9OBMjWLbbSF//n?=
 =?us-ascii?Q?FknF6kKGrs/gaacHkuOY9Ucv5cWe09T+nzjbnPFJuhVGPz4MtByLBf/COHOu?=
 =?us-ascii?Q?HMOmsZVle/FQj3ajPzk4L05KDGAUZcBArXtuWoG79SUVBgHt25Ty2DYF+Kcp?=
 =?us-ascii?Q?ffRWNcJmL39zTfwgrHnk7Cv0DVBevM1muoXcj/fzZa44XuoOAM3mWHCmute+?=
 =?us-ascii?Q?VA69WVvmNALNfRj+rCT9iUv9TSH9VpFFu3a0Df8gcEm3m+OeLb8ShXxlKZA4?=
 =?us-ascii?Q?AkPDesXndsWmOLOX82XCCuDdw5dre+w1LBrZ+pzNk3z0xBm+lPFLp7goukHa?=
 =?us-ascii?Q?951U4gGrCaKiU8VNBtkNRk6gia9VVbIPK7KA6PjDXVtnsfb4jreolECm8BoE?=
 =?us-ascii?Q?TX9IFa9tmq/ap7KP7YedmjJkz6bzdsyXyUoWGbUTqXzLeDVL+IPZL2Su+lhG?=
 =?us-ascii?Q?zmosqjsPSNsGQRbFqo0wTEdcM3qPC5XE+UAWV4GO5YHJ8H8dXRDJJyUR7SId?=
 =?us-ascii?Q?S6TZGtIUaNV88Pzc206KDoFAJSSebNy13Cg8J8mtCxzhEK7wOSAgS+yhoSTH?=
 =?us-ascii?Q?0H0I+P3ljszYReC7iAWUhmuhHF/f8NvzCJQ+yE39iXgHMxcrAaRVDiWbNwJd?=
 =?us-ascii?Q?QRyxQit6avjMVi+rADS28dHYzfWo8H6E3dBfj686UFgzrL96bbMN4vzmW0/0?=
 =?us-ascii?Q?/vwrAWH7Y++PDAtxz8MQz10qrsjEkZvW9ykk3SJrBH2Lo0e8+YBewv65YfXU?=
 =?us-ascii?Q?XdXwsfc7W73kupBUndvVt68Igc+jzz2jDRTrbcV8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc49b9-6839-4b14-7b88-08dbdf576384
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:04:22.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtPOcWU4m0yTGFIlgmUko8svfr6sJ2hyMccFLqkqbQ7K8NigglEnIE/OquyUT2amlh3rGDHgvSs/+1+XXybONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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
index d45d39356d41..098b685d1471 100644
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

