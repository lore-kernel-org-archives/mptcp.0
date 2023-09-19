Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55E31A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm9pUCa5tLGWO7QYfT9QWQdNbEscbTWeQ2EitH76svSfoWqHgumjqme0pmYCNZPkn41iz+zLkBPFDH9ZMYYRb7aQ2GlBRZV76qrTZ5xXSn0y1cP34joPsdsR5eG6RUYwjMw2G/I2nfz44pv5ExOTSz0+ShAb9JBFEQCH1bq8m+V6cbfuIcMns9ZEDQc7brave+Zna2b9Gva6AjgVTFpiHNBYY15Of1CKEv4ZO+CKDsuQNpvTPFifx/VimBcxLntV+CZ4OQlqwdfcWz8LePIyQkYfSm8hjdK1MAecuhaWst9RpXHXWHQSnnTKRi+Pj+zP6s+6MD7Yf+B5K/cZUg1nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wYLGyGAoYo7LK1fEPe6VfElrhuOCAPZq92AjlOF54M=;
 b=GEUnYQdYgWw/dp0S39v3CXZnLQJhry2+M6C5kl5bEIhkD2n6m1G+19iJDFsthtfe8cZuOkjN3l+S3K8JN+4XAevuYY9xLf2x67Ydlw7CG41h5Pepjd5fhjD9buBdjS3SPR3bKWNl4vjKMeQ2068F5VKgizysju3ViW8CcR3maxNOait28eytr+9lpsCLJ7/fJndA1oiodWFne9TaNPMLeg3LR2neLlmCpaqxGclk3WDDJnuViyKPYXHultSVSehlxUeygB5bMyIpsj4KK8ZUfE2xfStVbCQUOOEU3PpHdeSkCkGKn3Wp0jG9EnsxPM8qo8iZREa8pCBEn0qhZckfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wYLGyGAoYo7LK1fEPe6VfElrhuOCAPZq92AjlOF54M=;
 b=4EGzj4HLEWH9THZK6chqqogmL/DAhPyQ531mSCJMHvQGKXtrkFoLG7H8emrzI7Qe3nF8K12Nzm7ZT8zuj2juAcT6U1cf+seRdAySwaxZOWos4OPSE4L5cBem2AC/ACeTBYcUW96F0Pf+8kVw3H+kYEgRR/NPkztnizDHwBvofu+FpaNmtl5LFg1dEg9P0WERdiCNabZGdbnDLv40FmT0iVwwtANxmXY6Mr/VLn1BHzfVkK0AsdQ3ybYBTlMGWfUdKn/PsmEU6t0nfndi0mtWiJGnAIhVDU6W+U5xcWJrYWOHuarqovcuQbNx02XW3ULV9udSJBUwviIF3+0D/aOIvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:05:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:05:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 22/30] selftests: mptcp: add mptcp_lib_kill_wait
Date: Tue, 19 Sep 2023 12:02:23 +0800
Message-Id: <29407317f5a4783723e49d06131471a94d23e720.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be3daa4-c689-439d-a5fd-08dbb8c59ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BpjwkOqNUUciYFAFZZsO7fOfUH8HliuYNC+3Jypikjx2kQxb+L38LHH1r0x2b4j7kb1hP90UMs0aRk9v+xSqvptWATtzNzllmmgsCDWD8VqKPMycAInUbI6WlILXTWbc5RhavrR0a6WmCxRov20TcQs9Eo4j2tgUkzWzyx/SwyROmMksH9jIprprWnr1yPLxdW9p2kgfBs33OM0y1ldCaJqL80EXeOSRswXHct7wgOwK3h1u/QVAcUKnA+J7WrhjHM3Fb7eDdyDLb/IwS3npDWnmFbdEpCIzN3eJRf98Qd1Dz0P7Vc3Pa7MSKBm5fKYgvwqLGay4DTtvil26X0qks8UMhkUVE0/rO6nfnImmxKI59eJ5QOBeqG3k5m7mcJ9LVELA7trc4UvqziOFSVPv5X654fe3E/vGW4irtwKzr98GZ/DRVQwayJdYPRj2M9Ide0Eet89r01YOWYSoibm2syQZNWWxnJ/aPrXvy1CTOOjI+vkm0r21Xy90pG17j+gni5a+Jy6r8ir5Fcy11AsL/tPNCbsvW4CiN62AQ5MI8X6ZmSRUhMA0TyBN16mTm0O9uKZuYRs6d+HGWtH9QASLYfDW3lqYs9+qsZhNAdONsRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZ4GdhnkXgDFCpzZjkNLc+2+RHn0BIrNH4MttJCtRyU3Cr53hMmAMCFZNf4L?=
 =?us-ascii?Q?Xe73hskpzS7n55hnACMD9GUgO9A5fsmoj6M06TskNTz1ObONhDsl/iYfjdIO?=
 =?us-ascii?Q?JgJnuybF2tMNQnN3tjikXEiVJ9qbsGiRF8KLVFNmBTporFuvzNMctc2+QYdS?=
 =?us-ascii?Q?9lNtMrsKF28NOzfcaeYpdhKh8jGLH8dydxvrlAXsLTqjc2Jt9MPxFjXFD25e?=
 =?us-ascii?Q?gXFd44JuzOkBr5bwyNDbjaca81PeeQXuIIvcC2+aspBV7MikPnab8HTBB35e?=
 =?us-ascii?Q?5cGE1CNXMmhOltnONPnW1vpvAF8A7rgivqGh75yHqVaLiZ/FAojIer+zUcNs?=
 =?us-ascii?Q?GShijyeU3EzDAiF5knSm0VW2+u8XFBaiDTICJ/GygPfWGZBEqLQyGbKifNCk?=
 =?us-ascii?Q?v8+DH1J0OwCNpOuVsa7tGHRgF9kaDKiHk8k0x8Mdtx7RAVG+AExQAnr0Vea2?=
 =?us-ascii?Q?RCIAz/v7nK/tQCY5d4xTURZKDzC9QS0KKR9mxem3rE2O02gGPOGqtdKXZvFg?=
 =?us-ascii?Q?oU+V5ZvGVbSuHpRTKM69h7mYOlV+XPh/sgZB5UpABrMm1ElzPVYuC7QyyLf6?=
 =?us-ascii?Q?0CV/RFNY0SAhUPBdT+AemlScR3S3wdOaxWKSqm/lp5UKhy34sTTaCTems2g2?=
 =?us-ascii?Q?y06kzUtoVOH/BMali63AeGKT84euLJz2V8ogqgH0fhgzhDW7m6W2HoUeWhqI?=
 =?us-ascii?Q?S/VEGtiunbMoWKi1PvGAuger9IwA2n1RbN/eS2CWLAyoIqJs6x33cdDTktvM?=
 =?us-ascii?Q?w/TLYbTWVSoNN3MURxadTff8KSynGuTUHFBGQUbrI7i6ws7rK0W92OR2yPbU?=
 =?us-ascii?Q?byROhNvcQ2ro2shwYSOVxE3At+yL0C2iEyJi3unhgiNRT3Ck+pxTIeA9Nu51?=
 =?us-ascii?Q?HXfmt9f06q+t5h4wmafCqPNQhUuj+bOUcAVDG3mzYbIcK0xIVnFyqS0+z+hl?=
 =?us-ascii?Q?nYVIc5gUOeABcDosxgeu/1aRhHlHA0prB8CREdfdjRB4Wh4nIwbxSPNBbOEm?=
 =?us-ascii?Q?1ef3SH8fX6ifeOWZa9hsz4y2TAh1Qp2zr1wKNjdJsk/z+HIJBCCnd7eadonR?=
 =?us-ascii?Q?eLEpzVBBgaRDyU9NwJplsO7H4CAkc/JRfRxDdYhKO8eLBEKvfshWfyc68wux?=
 =?us-ascii?Q?+p+nwChXV4xjXwboaveHKzEXAVLRCUlExzNOsL+Z5p29wN9NTBCSkFX/SzjU?=
 =?us-ascii?Q?L+bOPcYsJuf2bF1JPvWHjw3tyFcJSm+NXgAh1CvGXpJadTRj4tTxuxKRBcx3?=
 =?us-ascii?Q?73WHs1IBQPagSmHV0JE3rudvTnD4jDT8AQzSpm7YExZAX6PIeXHVQLojSiW3?=
 =?us-ascii?Q?iXt+yLfoQgqcJ+uraDNNHclv9K5PXsnVFVsh0gSMUsvlAOBeV+RpBrNnDsG6?=
 =?us-ascii?Q?6LhSA95pw32vHiVxtogDskALgh6dJrvseZKdTCp/rPFM6kyVJHQNX02dGPmB?=
 =?us-ascii?Q?YlRL2MHNk6H4LkCCr4Qddky/KrK79Yth26Wnkq6PYFqwojYV9cIqo192KiT/?=
 =?us-ascii?Q?Er1PfjjSdt8EqVrM73GLbMjEYjX/HYJBUY2dBMkQxm4ogZtu4GcQIP843+Md?=
 =?us-ascii?Q?uYIR7L5tmeMNZwblPl6DYiV9tJ6Ua4S4dopYgJ/T?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be3daa4-c689-439d-a5fd-08dbb8c59ec7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:05:11.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjMiEi42bN/4Fp74U2szAgHQntdhzthFWi2VDxccYb0YwhaGPr7v+mpcJHCsovK/R4gVMfTQmkZ2G0qrzCIjkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

Export kill_wait() helper in userspace_pm.sh into mptcp_lib.sh and
rename it as mptcp_lib_kill_wait(). It can be used to instead of
kill_wait() in mptcp_join.sh. Use the new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 ++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  8 +++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++------------
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d883c6c2426b..f335a782c793 100755
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
index bb95dd967eb3..8051ac5507dc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -219,3 +219,11 @@ mptcp_lib_get_info_value() {
 mptcp_lib_evts_get_info() {
 	cat "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
+
+mptcp_lib_kill_wait() {
+	[ $1 -eq 0 ] && return 0
+
+	kill -SIGUSR1 $1 > /dev/null 2>&1
+	kill $1 > /dev/null 2>&1
+	wait $1 2>/dev/null
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 283c62deb628..7cddf793950a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -107,15 +107,6 @@ test_fail()
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
@@ -127,7 +118,7 @@ cleanup()
 	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
 		   $server_evts_pid $client_evts_pid
 	do
-		kill_wait $pid
+		mptcp_lib_kill_wait $pid
 	done
 
 	local netns
@@ -209,7 +200,7 @@ make_connection()
 	fi
 	:>"$client_evts"
 	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
+		mptcp_lib_kill_wait $client_evts_pid
 	fi
 	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
 	client_evts_pid=$!
@@ -218,7 +209,7 @@ make_connection()
 	fi
 	:>"$server_evts"
 	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
+		mptcp_lib_kill_wait $server_evts_pid
 	fi
 	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
 	server_evts_pid=$!
@@ -623,7 +614,7 @@ test_subflows()
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	local sport
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
@@ -662,7 +653,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -701,7 +692,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -739,7 +730,7 @@ test_subflows()
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -778,7 +769,7 @@ test_subflows()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -815,7 +806,7 @@ test_subflows()
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -861,7 +852,7 @@ test_subflows_v4_v6_mix()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -973,7 +964,7 @@ test_listener()
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
-- 
2.35.3

