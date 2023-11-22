Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2034AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="zAxUN4xg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deOiLixn/uqgcS/inLLE2A84yxYXCxn2+QJzXpfygNJQOBaYQqlKM1MrZ5roaonfF00YJOClmXJMDGX1a0FtCqZFsWj4//jPtbM+74C3/GZ9AZ1asNUhPfemMwRWA8QXF2SvP4bQd3i+y66CgGA8S2/8NzY/onC//+dey8f7kM3pIY+w4N4KSCRhFv52bQzO9nwTbhCwMMZn2zM6eB2arCC+yeDF3E4urkhbmUKsIFvp5gTQ6+Zl3IFBh+uqL91q72ATn2symkq3fpmowEFGoyACBVotsHSSZzD6v60G2Ssegkvn9YACxflAvaVnmhBFu6wIoIcmwa7cdCPcIsxauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk5E7V1oRZ+qCVhmUP7eSPJSAk3aWcVa5p6NQ4nG2Rc=;
 b=kKLGfAXsXpRYw3odmkqUi4wb//2/TVaksCWtwuQyrXUGbwPmgl6uBM3z4cJPjSefUBnBT/s6J0+8Oy1GSNZs01xEvNt6QJfVICCZrb8HjnPXBcw9UE/9xXoYzI2ZN4YfJVODdixA/16VQUYOOUZfPMQcFvvY1JiQ5cgDOpdUYe9byaxfVmKUwubJyCg/Bx+sMJ3t7bh56jzFv1/Ky2gBDgOQXPv1f30ui9LAAwrRLOBvg65JmR2I9SHQIfvJi7ihrII2nWtC5va//kfUJCvpAlG9+fXs/IanG3vLHHKfaB95mG13r7YpEsNfjQ8DN4wm9enfimM2j35ZVfobyZRwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk5E7V1oRZ+qCVhmUP7eSPJSAk3aWcVa5p6NQ4nG2Rc=;
 b=zAxUN4xg85D47RkbMh3ynO7i3J81nazZq/dlruAdIrh1iRr1sl8UYy+VieQlvsjO0AH9DO2wlEnfil1lehbxfFC3fWWmAvy/GRMnW4PbSlKgTMManuv6jMF6+GvmftKXUl/cQGyKW4mh1zDgSdpdntGeyH//Ty+5gsVieZuvLoMHkKxV4oQFkHmzDZOm0j5lI5R/OOBqhTr8AHoARuP3Oh/px1kMfkr/hbe2Khmnyj6t6zWc/1uR/b5mCfP40pRSPY682fT+EaoKE5udgosDXaaq50KCBtG+9EPNhLRcvfytR7mLEltE9dtME1o55VPeufJRC86LHfl/x3ceMBbIHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:32:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:32:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 13/33] selftests: mptcp: connect: print colored output
Date: Wed, 22 Nov 2023 19:31:01 +0800
Message-Id: <58797410ad20582ce1887b515ba1d9dad777c4ed.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba39ec4-6613-4ffd-4adf-08dbeb4ec10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZBMhhk6vTQwOU7+RJcy748px6AlPA0hQa0lvvpCoTCAucNh+lk9HTAz8DYvSvq3lQEibgDcq/9PTA1qk6Bb5KhQpjoUpgfVdSxzyOADq2Mi2sw6tN+A12sfxWRbgg46Dp5WrLlEg5TU5v16hIcrJ4JTeOAYpNX6Y/GfQK9pPoIxOTiba6MvGusczdDe28Iaw8HVZ/HlDLgOZcFjFpq+hAWneTDYiFHorjE1vuM4AXa4PVYBCVlBSLSfSBmBYvq+bIg2QZw/0sIOnc/8IU2VzNxhAHwtHPzdud/eMu8muBRv46lQC+it3pZfQ0IAs4cW4OUpvuGjt4xv/D5xzv8EtKavpAAuCWzGriKcxY/3OK888p1aimg7UrA2YUasZ+fJU/Qx9jM9yvekR6cHrgGk8dKm/b6DlyymvffJqSNeo+kLbc4JcgpFUUx6wSBSw2EOkYZbyG/KdM09VmmznTNkHZBy3lUSMYBZxO4n/B42Wf2RbZqg6R/oqJjb5ugI8ApssgiCz7zbsgnuaLcexyY1XE0HCwFQTLkdaVp+EA2V8CHL1nceqpWmn5yfKqxG/d9aL3JNykxxAQrp6InSD5/gi+2w4cBc+mNfpkumtNvehXR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9xH5hF9xzWKy1YKDnZCLWlqDqTUZA7Xdh6km38wQkzat4wv/qvWQtcWuU2s?=
 =?us-ascii?Q?RTq2uD1jDvze/KEpj5z5LgesbSM7LDZ+ktA0LT/rxYAIZjfD0zqvSYyMwON0?=
 =?us-ascii?Q?fGyPrNJeUjfS00yiiZ9F36S5RO8KqQHyRhDE/pX5dbBwtd7SpOGoVW0daZF8?=
 =?us-ascii?Q?cTyMP/I+xip2rmwN2gXLrp8Fd+aPITC8NoMmRDqfGxaFvNCirxzDv+6mYnij?=
 =?us-ascii?Q?2oeJY+uoPr8uZJLA/WUSDcq4GbGBCsge5LurYKDHq6aS80RfljZM+Pl1gnSD?=
 =?us-ascii?Q?nJvZCgTm1J0P8BcOgh74vixpYNzWF+ug0GSwnUfL9KLmVB3ZTK4AXGN+mn02?=
 =?us-ascii?Q?gbwsUjJTTC4LctTrr8sPgkdyiksDUrz//B59n4tetgbT3HDnbE0u0Ybdxpcz?=
 =?us-ascii?Q?vHNzhPWQ6y7PE4gaWO2CkGhdwSaHtHMnEzflmmf7DVbDPO4cMrlC28mkSvwy?=
 =?us-ascii?Q?O1jS1nIHHeVsSAcB29ByBcD9cEiuY6GPlkKAPzs/tPo/ilUXUAJEqm+fJAuJ?=
 =?us-ascii?Q?SkafZk1AbQFeh8DjujSB0jfZ442EyzGrEWaElHHiz6In6r4XxfYK5HcORrmt?=
 =?us-ascii?Q?yV2sSUyHS86i4Zb6LfIH6povmylh/Zdt8PYKZ9Xa/aSq3I4aB9oqJW3CoxQR?=
 =?us-ascii?Q?oloTOx0nccqGnspMK+0rKh8K89Su3btxvPwyd893z7NuAnzfWddg/2G3OF3b?=
 =?us-ascii?Q?phICNYsXHg9dudW6FDUFt2WFQrIFyTz0gxNqrktEgk4c9pgRko7Sbo28o0Vk?=
 =?us-ascii?Q?v1zwHu8Lk4Fls+42VBAwXR0kgJqw4fJkMQP9bIbvnEZJdBk62VSiissGsE+n?=
 =?us-ascii?Q?+tYWF/X4UfW+4WwCUVKuLJ7T6UMMOiCIRYwf7+Lb1KRfXyiMLJ2da7OcF+0V?=
 =?us-ascii?Q?NC5ofhwk1bnVrlQju0DJNosgMmJqCJvLxxmfMtbyO7cfex41LzhvKXL5yN4P?=
 =?us-ascii?Q?uLOtd58Nv8RHx/yLkIjI71Vl+vuS8qwL2ma4S1eGF0e9ZgDyr+a4UhP4UegS?=
 =?us-ascii?Q?jpcYSZ67XOl3hmmDGsLUTJ1JgvlB7GQAHMcnIH6oJL66PRwofOc7d5cXrGUM?=
 =?us-ascii?Q?RhA4LkI9ivFs/PpBxLS4BAfVwhzOhsUUoZSLKogl6XRR6GEDB90WQ0qhEBD9?=
 =?us-ascii?Q?w4aRcai2yF7F/+TIC3Esn55qiN9Wr7GqwWlLbAW3ixIPrKg7lAhQrjgzAdq1?=
 =?us-ascii?Q?dM+YUNklGSSGHAvihm9+vtXU5kg/UHIewhc8qnnSJ16II3OoLYgjDcOZjfHm?=
 =?us-ascii?Q?EBK6VjmpxItS93HqiOuNUeCznx3MsG+GV/CDcU7IToE7K+lAyIT/qWgDPvxQ?=
 =?us-ascii?Q?jYB5mOWnkQt7+Nc6NxkzrCHNTxuGkd6h1My4wlMRCMcuAVPDB5qcfwHewpS4?=
 =?us-ascii?Q?r4jI0W+ytU6FZDdvDnP51HuuNgK64WdjEMwZ6+tICseOwAALUX0PYgSa9lJF?=
 =?us-ascii?Q?ZqndQQ2VlRHNLpjnnkwnm58aGYTFK6W6o3u7D5iBuuYbzAWTAZSEWkJhu2ib?=
 =?us-ascii?Q?hRCwNprrysgkxtv8oXOTWt5dkzHd91QS8d3iCxDttvreFBSV80axmAfWsmY5?=
 =?us-ascii?Q?kAoTsABbGev475C0BCsArlD+Qu5wqv9TTwyoBhS0m0UqeuJ9Xv4WxinDZqEr?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba39ec4-6613-4ffd-4adf-08dbeb4ec10a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:32:48.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsNj5MWbGrkrUYrPn8SKtrOI0Szo9h4Ma3c7OSzSCAwxCP0vO9yXhElnGdVZN9uvoLkAh3O6QHtMe+USrSoA+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Use mptcp_lib_print_info() and _ok() helpers in script mptcp_connect.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e0263e691a8..d085a32f662a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -266,7 +266,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
+	mptcp_lib_print_ok "\t\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -482,7 +483,7 @@ do_transfer()
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
 	else
 		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
@@ -513,7 +514,6 @@ do_transfer()
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -689,7 +689,7 @@ EOF
 		return
 	fi
 
-	echo "INFO: test $msg"
+	mptcp_lib_print_info "INFO: test $msg"
 
 	TEST_COUNT=10000
 	local extra_args="-o TRANSPARENT"
@@ -716,7 +716,7 @@ run_tests_peekmode()
 	local peekmode="$1"
 
 	TEST_GROUP="peek mode: ${peekmode}"
-	echo "INFO: with peek mode: ${peekmode}"
+	mptcp_lib_print_info "INFO: with peek mode: ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
@@ -731,7 +731,7 @@ run_tests_mptfo()
 		return
 	fi
 
-	echo "INFO: with MPTFO start"
+	mptcp_lib_print_info "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
 
@@ -743,7 +743,7 @@ run_tests_mptfo()
 
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=0
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=0
-	echo "INFO: with MPTFO end"
+	mptcp_lib_print_info "INFO: with MPTFO end"
 }
 
 run_tests_disconnect()
@@ -767,7 +767,7 @@ run_tests_disconnect()
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
 
-	echo "INFO: disconnect"
+	mptcp_lib_print_info "INFO: disconnect"
 	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
@@ -816,7 +816,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+mptcp_lib_print_info "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
-- 
2.35.3

