Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931623C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLnF+d+QscmRMBrFfLOLUf5wPEkP2+3bfiLiOtBMUBkv//Mur8m9gKwj1M8A8gREWJWtSxa3Hs+k2KgPJ/qkGm5IY/qkfPHylCelq0n/jUuIqm/zRbXR4o9hayREv79wG3r07jsZLLmu9Umg9VbUxdXetIR7qpJMU+Ha1PCV2UO3yPhu3JDcq0RC3NVstBY31nPvJ4btNz4WHtIV/TY6AN2wp1XxLLyLBRbF56LdRUy0kdZKiRIn7aOjILWDq5t0z6YJpweMw6awntcuL8BumNus62NKj21B107DRwvS+u7kY6vsNaDsL3dL7rsb9SA3iso81B6XjNgVRRsB2gH5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+IcFPtLQyVs3A9VGbFsMGAlJ7fESJVWSKXHre48vps=;
 b=kgRAZiN3felfPC9935XmeeOQOLTaV9qUntiOyeu87KLdjiK16HPlrWDJsHmcw2bNVAvln3RvtqR7KVdZXSoN8j1Or9nr4rXjg+a7SkUgy9cWrNd1//7CjFYKFzhPh3mXMZT4iz/hHIFkmxk+rEKwZrI9x8xJIpgHDdtWIoz61cBPDACP+cNJCd+EzCYtdOZGjs7lKorIW15s0JYEzczjh/3dwVsghKRuYFsfNFZZ9ccvFsHSb1k9ojGD5f+po26gyp5O1oZnIPT5qMwegCPpRRSbapyLTZOF8cA3E68xe+v3BM71p7wBU1ykX4dqde8h64SLs8AnvgSnEwOpoZNJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+IcFPtLQyVs3A9VGbFsMGAlJ7fESJVWSKXHre48vps=;
 b=l7cDTYFYzeVIEIWcyAxEfxFNk8A7oOj3jye1rOsosI/L9h4/y+FwptTRvK6EZGjcgC1z/ODvqJZOLNlg6qNQGEdX88yA/kX4LRUEHGEAdE4vGjW1E8Pnv+pS1a3sTiKtyC8+3Jv/ma5h1DwTk/xAeuHxpnD/yqG3OzlH7+o+Sy7wuhfoCIZ5hLckViVE7FxVyERtVfsLcMn2BfE31vbrZx+vcGIDLdtzRRn6IBqn1T25Qq+5bIVz/DrvbqRXtTNWbm9lfOhEr0ZaQ8cTC2HsOyG7ghlFGxvy9v++cTMiKseH1Wfz5I3dbXA5MTM92TcC590opyr21mQG8OrtgJ1HGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:44 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 05/10] selftests: mptcp: drop test_linkfail parameter
Date: Fri, 16 Jun 2023 15:30:57 +0800
Message-Id: <cc41987684ea8ccd1c5f16a0c2750218673f61eb.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 970a0ea6-6df0-43cd-9042-08db6e3bbc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BOV10HoWRtFUYeD7E58y6g0gsjMJEidU+pIhQPGj92OakUzhWein1WNUp+viStGgQM7YD/epCEZTD7l4p3D+hn+YqmyfbB3u8qnZdW/fo50v0fYboNfc8ZW1c20nXNrh948CyKGI3fDPOxXoUtRj22JQBf4EOqod3C3oobfoyikp3ZZasFXnfXM2UW6q5XRptGMbs0RblnUMMBEjjNDJoIRAaPYDW5FbW4P3zhM4ZEKkVJwtqcpOVN8xqehhExM6ilFO7ab3Z1wBuDI4Sj6/EXN7Nsicel8hirnQoldh0PvEGtxcMIqkjgUnvaTmgD1teiEfe6rbv46yITuLPYJ1G85/rKEo3Zn5vF08zFLCSAx3FxuDZRj3vPQPXyN7QhbU+cncypQrKogYXzVZZzTtCmibpYpT/UCkBZM+nRqIlWRcOSYTKyd7BG4/z1z7Hf8oq8TBfYpPzVK1uP8fqFwFb+O60MkbEpd8EoCs33UHO95I0f0g1K3Zj2OUyvvICy+svmIbfZDBF/8WH8rv9p3QJwyS3ns5c83rbJ6Y01yl7tZ9+2qUJVOxOD1Dzn3keTBf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(6666004)(4326008)(8936002)(5660300002)(8676002)(6486002)(41300700001)(6512007)(30864003)(6506007)(26005)(44832011)(107886003)(86362001)(66476007)(66946007)(6916009)(66556008)(316002)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D74aut07Iy6qc76z/uEz+rFxQaKsLqtKgbqjmIv+QE5ojrQv2MgZPT+ndtmm?=
 =?us-ascii?Q?wravRgrreEUvW3Let0mVOhqsTCr3yoQFyUHIMfbFCrmqaeS1Tce6knZxlYMe?=
 =?us-ascii?Q?BvPlOumvdq0OpfXNtyRDBypqdU9UXzOeG5+4RN5twOqx4xpPJXDjUuGga0Ly?=
 =?us-ascii?Q?HXwU2N7Kvi0vvAmw0YN0P2Gqo4dahRrEOEuvQU4VnUZu+2WEbAokYvL3vUPs?=
 =?us-ascii?Q?AeMyLJA7eevp8BYVAB1wnxhUYjaSE8d1fT0FsKmVpAMFj0B3qugGAb0X8BDo?=
 =?us-ascii?Q?GF80APhnqOw+MfWCkipHvemIovRG4117+XVhkXxZv6Mw76TqziJLUnQBvOf3?=
 =?us-ascii?Q?rix1ia7eWjixw2TRD9dSjEzmxSvz/yqluVFZSvVNf2O0FiNa6lR7fs8xgMdv?=
 =?us-ascii?Q?5aANbhnK6z3zR51iE85aqwwu/9nf0cGHTJVUzQaZkpKn2ytkE2GkZuYH25V7?=
 =?us-ascii?Q?c7cHt5aUZ1hsOvE6EsXjXK/oBF50bZtN4e3OMf6pXuV0xHEQI7gQX8xWFlC0?=
 =?us-ascii?Q?b3HTWYKlx96H+RUhzL3Ysjz9MMrO/2VcitqfmLOIbdKv66uJy7Hvpfkdf7LL?=
 =?us-ascii?Q?3ZSv27eopPgLQuoFui+GsqocNkrwPmqAXEZWnqMS4r19fqe/PJ+TfEm8fLPi?=
 =?us-ascii?Q?BPNKxVM/xVkxO/yK0li+IZvHhBX/2EMWBy3YZZQV5+VfIqqHBF7I+y4VOnDo?=
 =?us-ascii?Q?yr1CgGO6pzcsf3ZH0YYQntPsSP2SCpL9YGlatp5z+u5iogeXSP4JkqW6KSN3?=
 =?us-ascii?Q?itavYx9ekjujP0ru7AsEvVJqhLgLFMpaWlnAqoqP9EJaG3ARevzhrD6aWs6J?=
 =?us-ascii?Q?Qs8m2mHwYCD63xhO64vZVh8ilHHos9Bccf4p6xBukmzvBWm7kr2nyA4QBIo6?=
 =?us-ascii?Q?m7ZGUe12tboZJJq/YxhCknF56KmD6u+2u1nyybgP+DY65VPpZIfMJOKJ+xYG?=
 =?us-ascii?Q?eZx/AWp69YTXMguPA/h7TJw0m48Ma+ZxiZw4yL6cVsFlQeGoJYJmw32ixVP4?=
 =?us-ascii?Q?TxEIw6H/X9yE9JchE1bwzdbVsp4pwS71YzxLLn3dBR47gfWiUlHCliwFxS/a?=
 =?us-ascii?Q?RqvjzQTT31QZ8kZLhdO1qVPEgENFlDSRDpK1Wek69oKYBpgztmOIfsisQyRf?=
 =?us-ascii?Q?VKZLN3zdXzoshTdurdIyAke/2qmfNNU+vSKvStJtzTDshbt0zbjgkl02hDg0?=
 =?us-ascii?Q?FF8FLDCBDHKLySkceloBjN3C/Ub/YuiFCqxJ/5pmfA0lBRKS2ROtKROEdPuz?=
 =?us-ascii?Q?yabeMtOBtVUSqkOh50vssSdAWms9KUrsYGItIbonjRDZ5DQ+pUxEfmJ9giSj?=
 =?us-ascii?Q?q2rAhK5bPSw78XPNYNy+hcSSM5pIdozwN85oULj2Xtkd1keLp/xnrG0vyOv1?=
 =?us-ascii?Q?FdJnQiUfUiXL1EidqaecHRz5PpmwjHNSIHPOhsejvq6QdBbTKAeET3Q7BR61?=
 =?us-ascii?Q?oH7rV1WNeXBPCeRGoPz6lhhrWhkjeIB33FJHeuWSseR85BI5Wm6mYxnYNlNa?=
 =?us-ascii?Q?KsVqS1d7yodCYAajMLGS/UzI5u90f9e/HijYoU/yajpMWdCV38oGHzdFgj2D?=
 =?us-ascii?Q?Vb+xncdABurQAFQ5Q5D6TRfWYZ3b6HiEeOC/O55U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970a0ea6-6df0-43cd-9042-08db6e3bbc5d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:44.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpQQ259dVkR/sIfvhqzCSoMmGDYByabMaK9uRfOV4QAhAJh7PP1MZY4NhXq9mgfoIqss0aqV2Do/AlUx8tlw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

run_tests() accepts too many optional parameters. Before this modification,
it was required to set all of then when only the last one had to be
changed. That's not clear to see all these 0 and it makes the maintenance
harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

This patch switches to key/value "test_linkfail=*" instead of positional
parameter test_linkfail of do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 192 +++++++++---------
 1 file changed, 99 insertions(+), 93 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5146c5268c44..90cfd134bf7e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -50,6 +50,7 @@ TEST_NAME=""
 nr_blank=40
 
 export FAILING_LINKS=""
+export test_linkfail=0
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -825,11 +826,10 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
+	local addr_nr_ns1="$6"
+	local addr_nr_ns2="$7"
+	local speed="$8"
+	local sflags="${9}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -874,21 +874,21 @@ do_transfer()
 	local extra_srv_args=""
 	local trunc_size=""
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
-		if [ ${test_link_fail} -le 1 ]; then
-			echo "fastclose tests need test_link_fail argument"
+		if [ ${test_linkfail} -le 1 ]; then
+			echo "fastclose tests need test_linkfail argument"
 			fail_test
 			return 1
 		fi
 
 		# disconnect
-		trunc_size=${test_link_fail}
+		trunc_size=${test_linkfail}
 		local side=${addr_nr_ns2:10}
 
 		if [ ${side} = "client" ]; then
-			extra_cl_args="-f ${test_link_fail}"
+			extra_cl_args="-f ${test_linkfail}"
 			extra_srv_args="-f -1"
 		elif [ ${side} = "server" ]; then
-			extra_srv_args="-f ${test_link_fail}"
+			extra_srv_args="-f ${test_linkfail}"
 			extra_cl_args="-f -1"
 		else
 			echo "wrong/unknown fastclose spec ${side}"
@@ -902,7 +902,7 @@ do_transfer()
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_link_fail" -gt 1 ];then
+	if [ "$test_linkfail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -918,12 +918,12 @@ do_transfer()
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
-	if [ "$test_link_fail" -eq 0 ];then
+	if [ "$test_linkfail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_cl_args $connect_addr < "$cin" > "$cout" &
-	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
+	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
@@ -1107,13 +1107,13 @@ do_transfer()
 		return 1
 	fi
 
-	if [ "$test_link_fail" -gt 1 ];then
+	if [ "$test_linkfail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client" $trunc_size
 	else
 		check_transfer $sin $cout "file received by client" $trunc_size
 	fi
 	retc=$?
-	if [ "$test_link_fail" -eq 0 ];then
+	if [ "$test_linkfail" -eq 0 ];then
 		check_transfer $cin $sout "file received by server" $trunc_size
 	else
 		check_transfer $cinsent $sout "file received by server" $trunc_size
@@ -1146,11 +1146,10 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
+	local addr_nr_ns1="${4:-0}"
+	local addr_nr_ns2="${5:-0}"
+	local speed="${6:-fast}"
+	local sflags="${7:-""}"
 
 	local size
 
@@ -1195,7 +1194,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 }
 
 dump_stats()
@@ -1990,7 +1989,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2001,7 +2000,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2012,7 +2011,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2024,7 +2023,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2123,7 +2122,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2155,7 +2154,8 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1
+		test_linkfail=1 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 5 1
@@ -2170,7 +2170,8 @@ link_failure_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 2
+		test_linkfail=2 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 1
@@ -2184,8 +2185,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1" \
-			run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1" test_linkfail=1 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_link_usage $ns2 ns2eth3 $cinsent 0
@@ -2199,8 +2200,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2" \
-			run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1 2" test_linkfail=1 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 2 4 2
@@ -2215,8 +2216,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2" \
-			run_tests $ns1 $ns2 10.0.1.1 2
+		FAILING_LINKS="1 2" test_linkfail=2 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 2
@@ -2231,7 +2232,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2242,7 +2243,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2253,7 +2254,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2264,7 +2265,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2277,7 +2278,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2289,7 +2290,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -2 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2299,7 +2300,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2311,7 +2312,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2324,7 +2325,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 -1 -2 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2337,7 +2338,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2350,7 +2351,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2363,7 +2364,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2376,7 +2377,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2394,7 +2395,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2407,7 +2408,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2418,7 +2419,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -9 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2428,7 +2429,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -9 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2441,7 +2442,7 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2449,7 +2450,7 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2458,7 +2459,7 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2466,7 +2467,7 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 2 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2474,7 +2475,7 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 2 0 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2487,14 +2488,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2504,7 +2505,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2514,7 +2515,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2526,7 +2527,7 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2627,7 +2628,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2637,7 +2638,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2648,7 +2649,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2660,7 +2661,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 fullmesh_1 slow
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2673,7 +2674,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2684,7 +2685,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2696,7 +2697,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2705,7 +2706,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2714,7 +2715,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2722,7 +2723,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2731,7 +2732,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2820,7 +2821,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2836,7 +2837,7 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2849,7 +2850,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 -8 -2 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3051,7 +3052,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3063,7 +3064,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3075,7 +3076,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3088,7 +3089,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3099,7 +3100,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3110,7 +3111,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3121,7 +3122,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3133,7 +3134,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3143,14 +3144,16 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		test_linkfail=1024 \
+			run_tests $ns1 $ns2 10.0.1.1 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		test_linkfail=1024 \
+			run_tests $ns1 $ns2 10.0.1.1 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3168,7 +3171,8 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
-		run_tests $ns1 $ns2 10.0.1.1 128
+		test_linkfail=128 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
 		chk_fail_nr 1 -1 invert
 	fi
@@ -3179,7 +3183,8 @@ fail_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
+		test_linkfail=1024 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
 	fi
 }
@@ -3304,7 +3309,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3317,7 +3322,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3327,7 +3332,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3347,7 +3352,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3370,7 +3375,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3393,7 +3398,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		test_linkfail=4 \
+			run_tests $ns1 $ns2 10.0.1.1 0 0 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

