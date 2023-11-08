Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6C171CF
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q6NG/3rg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iarYc2wKkbSs0PQILHzZvA5lEL+4wpbkdklYRiXtrIBmqbVSZrNWAav6pOh7v0wjJbT3ZbEzj2W4YLB3cJ7+gzMN90TRxNTo2qeXDQyTZxW7csRaloQVq6HLuKa8s7T6kvGE5bjybe0DFP9iAuRumUc5qpXBn6yZR0j16BBX2+sx/vs5JlFy7P4AEEjvIOLYp0LROLnlIU60xVmtonHNDUXpbh2zAwgWzAXvZe+tojOI+8K7sazhfCqVurmPD2WbBHgKOpCKNNgyuWc9wKoFGXHGKzyvZtPy5UIu3yblo9u6a5gu9BwqPp94/3U0zT4mg+nHuebqrWwryJnfFagyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzMJUJf6z+DqoO+0WgBNdb8FFNJAztpQNjv0sWYAHoM=;
 b=CkIZgM019/Zedg5PV8cncK4GB2GHTmLU8te530Wv6IAIYUaynGECDNHF6wRVSYNC8q6A3Rf/vmB3KF77uX62nq/UEgt9UNDxefMQX7CkmVwCorU+oVMUpG6B/4RKSCaxBk26T9Ck6XicMOBgKxGZF9dSTd/WL+p9TqQUE5D6RY5ag3BTU/VKCJT17y+N0p6Nzdd1Clqqt6BMdwVQ9JQFkF4GEiMTByd8QSlENMs7B3VzLsg2QgPTXci7QrEbSORm/+U73dsKkFI4fzWBpPzoskV1HwYDDviMjYIlEvf671RLLD+C5XVts2bOlBtreV7nDTf1uKhBItjJ3uADpN8/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzMJUJf6z+DqoO+0WgBNdb8FFNJAztpQNjv0sWYAHoM=;
 b=Q6NG/3rgXHUmTiKTvyBqDXLbRrqAZVpXAldVm8pGWcWNIqBEtQSTZli1OvTARAZtz9ss+8IPtA1oGMtCnDmJwTKmUXUNHlUvKVhvqlQeOmidOjzfJ/fAO0qbJY69SiZGnkRk5Myo+9Ua4QB2+prqLGl+6dbeG90OxXVWL0fbt6Uly/3KLJNFl/HG1bIkhiHqLBKyQpCXrzKiDjXHq5U07EGeFNs55cPJqXo7fWSQ2IUbpZthhWmb0VKpd0dULcDbYrUlbAqIevJsHnUgnWDj8P/Be7wJluCV0PtiQua5Uns2UQbd/zhm1rjz5daTINDsX8LP+OBqfYsy5M38wQLMJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next 06/13] selftests: mptcp: print colored outputs
Date: Wed,  8 Nov 2023 22:11:47 +0800
Message-Id: <02fd40689f31f73ee53705ba2e747242882f820b.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 486240b7-f219-4dca-4a80-08dbe064c1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SEiWBa5DhSRyg1pjWHRR62Ag4aD9+Ekskkom9giaI+7vU+PToFdsrcEvjDQqpMLqlVHvh8oVi7SWpNzncMG9o1XE9PwKvcUz/XjDgwUWsM4W6engX4v5Lx7c4l8waWSkYCEVoOsO0hAPb7cToGlDHKLQizCYN2wuFFfFQxUtYsATKiL/hakFjobLQvCY6+pYYy4DiCHYBsFPMJUNmf4L5dEX7voGZnzpiWMVMcfWdXrWDaCHXm//m0Et5l530ANmttEaOgGJ9TSPo0hDWkmIqd6lanW9apOw6WA4yqIUJPNUG0ABLKML7otLp+X1cU8IebDMVI48nU9NdulYU+HYHG1VQwA4LfLU0P0tPk1CkZVYJfdozx9nXeOOCc3bZU9VQzWHpsjxAOa/MakaKoY8cmPJXbLW7oJfdLMpL+h4ttYxOADFkoBcepK98bueXva8arZyT0qXDlSffGo2wePxNPwVFQdL66hLNAZd5JQ0x3pePSZoFYwoPMSZ0JjYR0dYURko+T8Tduw5XIS5KTxYDyG2A0ejQvZWYNEUrxA4MZm0Ibjnu4wPWZbOWo1HOsTS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(6666004)(54906003)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRG3C8jNHmOC7m/h0l3AeS+7x2xiuN3C3tw1Fozxs7XAWnUUk9AEJzff6YL8?=
 =?us-ascii?Q?TqEO1lFQploowibW34VOsNPCL58cJEMCmkPTkp98AOObuMTNHYr1nCAZhf7i?=
 =?us-ascii?Q?0JrdENaeYj1lJabW7D/G9qUfZV0W7giix5fjWkbDKGuxVeMQt9+5gLaksllB?=
 =?us-ascii?Q?DK+W/xBQJJHpzGRWKFRagIVjB3BNDLotI/AUnYALK/60Av7Q9r21X2MAmRfA?=
 =?us-ascii?Q?qGy/XWN2caWHxI7o9hse/ktgdDH0AK/Z8envbpRQvFwG5pxJeeinLMHwDTbT?=
 =?us-ascii?Q?XcNKMgmb2Fp2CH71mD14hNjgW3oIDfAstSaYFZazFKgVfK5r9S0VQIjU+cvL?=
 =?us-ascii?Q?SWMzNS2BbaZIIRg3obOf4H6dEwlHZjgxC2Dr18NwUfKHjW88qXOBZi/66QhZ?=
 =?us-ascii?Q?/ywFtshZi9VR9c1gs+Hyi1DrBstLeYT43YrQWT63OKLOzjpjyxOTWFK5Kb81?=
 =?us-ascii?Q?Gb4GucnGmw1w/UEtE7d+sVhGAYZwN93iNYCBqinZBShDRzBhysDv+6BrrfoO?=
 =?us-ascii?Q?bYpro6ldWhoCFRLu4aosFRnrMLTkwpwrumBjVVrM2Sz96cmVAcnTQeyzZyVO?=
 =?us-ascii?Q?a6YXueGkzKdzcY+7miBXaare221gJV0RJ+qd5r2oLknFiCtjwLoW/nH+wMSj?=
 =?us-ascii?Q?BeE8MdH3UwBkNA59YKichZnMTHrhgNgRsLN2NMIvBIc0L62saYYtU5uUMXo5?=
 =?us-ascii?Q?AE2z8jRCvSfBEVU7PcKMDjOWbUOKxPXFvUIn5NnpCVQK0Y9/OjfHVf3kDTx1?=
 =?us-ascii?Q?ySOjHRTct+2dExZkXnVJkqzA6V/jLft+4RZBUB4Cz+eBZTFkGnddnQBQRpnR?=
 =?us-ascii?Q?UjPgzFkjQgu5oAvb3H11JKNhYQMFbKga8M/rdoyeJxdWYpi8RyXWY0PLlqkL?=
 =?us-ascii?Q?hI/BS8Ih0bSECm87a5dVSGXL6dP1F0b8ooBorDaS+XP0DJUBYQsY6pl1kFze?=
 =?us-ascii?Q?SP4mAdvkhFXDzpvenTJ5stfnJFHun0nYsm5hNTBh6Kx/ziSYXs/NMayHe1pz?=
 =?us-ascii?Q?zYlEHSRb1CX4QZs4+TyK2Icl6fKbde91g6avboIp/7yu6l4ASz6kFB9S+7C9?=
 =?us-ascii?Q?ZUX+rLtveXhRTwTxnWyvkN6sGViAOeqP06N5GYCr1wOzhD5JRsysZDGj7qSq?=
 =?us-ascii?Q?g0JwAtpQPkQ1BGkfS3FifSYCTOjjnyN/6rpXRa9B84kU8G9d84VHKQ+cBRYv?=
 =?us-ascii?Q?1LdRP0rlN9AlWg1p7DwqhzK/85Q7i/Krq+Q/UQo/jRgIJ4HVNW9XQ1eC/IQh?=
 =?us-ascii?Q?YTvu4PgsWzZ6r2YxeU99gNt/IdTGRY3/dYNB/ELh9u50Pu5MIPKn89LDryPH?=
 =?us-ascii?Q?qrnMB+eZvJenpafL+ZON5RWk43Dea41WiE7put3WgYgmFExlFyXaVpZWANmV?=
 =?us-ascii?Q?Gxdp+rQOF26o0DPb8UgM8MM6D7f9uKkebVGAfFtuYINjCNbftkgS59ShD+hr?=
 =?us-ascii?Q?/QjAl1gVdvBUaOUhxay3iySCKRDxAv+pzwJuQv453+waLD0s+IfAhv2wi1U+?=
 =?us-ascii?Q?aIxxm3OaLIFEkSlZ3wHHGArACPWKy7CXRJW4fX9OMcNuqsA3siUeZMQZilaV?=
 =?us-ascii?Q?X08fdwnToeNc9zz9ybsb/nw6quJYxxsS7cHYcVMR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486240b7-f219-4dca-4a80-08dbe064c1d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:36.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4x5WNnquT1vQAn27iEmERAJItergM6M/6hYsjscg+OjNm/tutWhBoYFbuoD9upBT7Dp5vBdWX/yV2F1PvXIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Use mptcp_lib_print_info(), _ok(), _warn(), and _err() helpers and
mptcp_lib_echo_* helper in the scripts diag.sh, mptcp_connect.sh,
mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh and userspace_pm.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh       | 12 ++++++------
 .../selftests/net/mptcp/mptcp_connect.sh        | 17 +++++++++--------
 .../selftests/net/mptcp/mptcp_sockopt.sh        |  6 +++---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  6 +++---
 .../testing/selftests/net/mptcp/simult_flows.sh |  4 ++--
 .../testing/selftests/net/mptcp/userspace_pm.sh | 13 ++++---------
 6 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 043e199b0c62..0e8fbb55db8f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -64,15 +64,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ skip ] Feature probably not supported"
+			mptcp_lib_print_warn "[ skip ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ fail ] expected $expected found $nr"
+			mptcp_lib_print_err "[ fail ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$TEST_COUNT
 		fi
 	else
-		echo "[  ok  ]"
+		mptcp_lib_print_ok "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	TEST_COUNT=$((TEST_COUNT+1))
@@ -113,15 +113,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_print_err "[ fail ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
+		mptcp_lib_print_err "[ fail ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$TEST_COUNT
 	else
-		echo "[  ok  ]"
+		mptcp_lib_print_ok "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	TEST_COUNT=$((TEST_COUNT+1))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..b28d7d3ce4de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -280,7 +280,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	mptcp_lib_print_ok "\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -496,7 +497,7 @@ do_transfer()
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_echo_ok "[ OK ]"
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -703,7 +704,7 @@ EOF
 		return
 	fi
 
-	echo "INFO: test $msg"
+	mptcp_lib_print_info "INFO: test $msg"
 
 	TEST_COUNT=10000
 	local extra_args="-o TRANSPARENT"
@@ -730,7 +731,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_print_info "INFO: with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -745,7 +746,7 @@ run_tests_mptfo()
 		return
 	fi
 
-	echo "INFO: with MPTFO start"
+	mptcp_lib_print_info "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
 
@@ -757,7 +758,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_print_info "INFO: with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -781,7 +782,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_print_info "INFO: disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -830,7 +831,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+mptcp_lib_print_info "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 3008f15c04f9..44095b274c40 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -291,7 +291,7 @@ do_tcpinq_test()
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -338,12 +338,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_print_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_print_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ed1e8380838a..3b0512ff5d54 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -59,15 +59,15 @@ check()
 
 	printf "%-50s" "$msg"
 	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
 		cat $err
 		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
 		ret=1
 	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	else
-		echo -n "[FAIL] "
+		mptcp_lib_echo_err "[FAIL] "
 		echo "expected '$expected' got '$out'"
 		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 6fc0e08985d2..2ab0e649031a 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -189,12 +189,12 @@ do_transfer()
 	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		cat "$capout"
 		return 0
 	fi
 
-	echo " [ fail ]"
+	mptcp_lib_print_err " [ fail ]"
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 601421ed4e49..613fdb289881 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -57,7 +57,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -68,27 +68,22 @@ print_test()
 	_printf "%-63s" "${TEST_NAME}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

